Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385B388384
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450978; cv=none; b=BTPzzC4VG3BoMVbLI1AL3uOaIfLwac2UawOa/t0BAeW5e66mFRLi+KcTRGaU9Oq6WMIntoe1FP6JGUhypiuvBWcDyjNqPVJV4AEgHJaJOm8wzvWRiMCFceXeXidij5k1b/ZeKsujRoKmj8CqBcpuwv1Gz94RT9AnR1im284+urY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450978; c=relaxed/simple;
	bh=cn5OgquvyHmmTfuS6yY9g9u0Q8DGsi/v7UJNAWes30I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nr08m+Xh70si/j5ummWZnOmZWriOfrELDLGXGAPIan0G1zTPJRI1NBJXhsUWbvSrGfAYnb0wzxEw32efRj3hKg50Ioj/GI+krxm9VAdlkwsCg4VjdZFXsS2ZYXUnAQR5IaPNfzvmVSEl4LNKzkEoWqSAM3VzfQTg6rvdjiKXuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jy/gp4sU; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jy/gp4sU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783450974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OCFn6p6im/88hiIgxaX0LFOOfYGXGRLooMDP19gcOLc=;
	b=jy/gp4sUXlnBKzG+MiakkBMHtLIvtv5dc5dng1ImvxdwKLPNfKuXgYd8t0ssZF1cOPYALG
	GcCH2K0HrTa2CbFcKt7LuaL1fVGWrKYIdgzQfiKFKVIz7qIca2d2SVaVhVvkYq9RL3j6x+
	T8I6GfavlLvQMoK+kSgPAR6BPMNF/hI=
From: Usama Arif <usama.arif@linux.dev>
To: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	d@ilvokhin.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kernel-team@meta.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] eventpoll: compute timer slack lazily in ep_poll()
Date: Tue,  7 Jul 2026 12:02:38 -0700
Message-ID: <20260707190238.3478608-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ep_poll() computes the timer slack via select_estimate_accuracy() up front,
before checking whether events are already available.
select_estimate_accuracy() reads the clock (ktime_get_ts64()), and the
resulting slack is only consumed by the schedule_hrtimeout_range() call on
the blocking path.

A busy poller such as an L7 proxy event loop calls epoll_wait() at a very
high rate and often finds events already pending, returning via
ep_try_send_events() without ever blocking.  In that case the up-front
slack estimation - including its clock read - is pure overhead.  read_tsc()
attributable to select_estimate_accuracy() sometimes shows up in perf profiles
of such a workload via the epoll_wait() path.

Move the slack estimation to the point where the thread is actually about
to sleep.  The timeout passed to ep_poll() is already an absolute deadline
(ep_timeout_to_timespec()), so deferring the estimate does not change the
wakeup time; taken closer to the sleep it is, if anything, marginally more
accurate.  On the common non-blocking path the clock read is skipped
entirely.

Measured on a host running a Meta production workload with the following
bpftrace script:

  #!/usr/bin/bpftrace
  fentry:__x64_sys_epoll_wait,
  fentry:__x64_sys_epoll_pwait   { @in[tid] = 1; }
  fexit:__x64_sys_epoll_wait,
  fexit:__x64_sys_epoll_pwait    { delete(@in, tid); }
  fentry:select_estimate_accuracy /@in[tid]/ { @sea++; }
  fentry:schedule_hrtimeout_range /@in[tid]/ { @shr++; }
  interval:s:30 {
      printf("sea=%lld shr=%lld wasted=%lld (%d%%)\n",
             @sea, @shr, @sea - @shr, (@sea - @shr) * 100 / @sea);
      exit();
  }

Over a 30s window:

sea=3,587,704 shr=3,003,920 wasted=583,784 (16%)

So ~16% of ep_poll invocations of select_estimate_accuracy have no
consumer.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/eventpoll.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0e65c7431dfc..128d7fd3d0ea 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2248,7 +2248,6 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	lockdep_assert_irqs_enabled();
 
 	if (timeout && (timeout->tv_sec | timeout->tv_nsec)) {
-		slack = select_estimate_accuracy(timeout);
 		to = &expires;
 		*to = timespec64_to_ktime(*timeout);
 	} else if (timeout) {
@@ -2327,10 +2326,13 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 		spin_unlock_irq(&ep->lock);
 
-		if (!eavail)
+		if (!eavail) {
+			if (to)
+				slack = select_estimate_accuracy(timeout);
 			timed_out = !ep_schedule_timeout(to) ||
 				!schedule_hrtimeout_range(to, slack,
 							  HRTIMER_MODE_ABS);
+		}
 		__set_current_state(TASK_RUNNING);
 
 		/*
-- 
2.53.0-Meta

