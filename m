Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585567;
	b=B2k+V4UaPeqQWhHrWPTZ+ZNYz6cKFIrvIQ+Wvp7c7RRVqKPuJTvk6GRu5zYRePfeyg58
	 CMrKesY1l0AcrXLxlJRdLYPIh5qiHyhBHZpqrrz+PWSp3Cu/eSpDlPq2tGODq/6Qz8D8D
	 zQibJkdDPzXQ1wHnU/uSL+m3VLSb5cXVuNy51LBi9hDQSW2LeElXjNAAEjt/giwv+t7yv
	 93GUt3B+Fu8K1MQLxMTRn0FNZQ0fCwZ7l9YHTQPR8gdJhFLjdjigAoC77lpabnq5TUpZa
	 TcWW7bCIFte5WyZTF6TMKOdxR87qFvdOjnSX8A6GKHeiP4G7TbEoVrErn54K8NZ5Tbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=NR/6ReBtZzWPhL7shMo8n0oVFcpdIbC1mfBQJ9hh1jE=;
	b=j+9NUvWb+Zk9WqoPNJQxRhQ2zawVWFj5XrVkM6w3taybUoG1RP7JuEVXDrnjWFGZJYlH
	 eA/+CzXgsGZ2PzLuLbak8yOuevYDz2DeWvuhtYuDWV+LlAGZ1wj8hsyGCX7go1vPYabDY
	 /Z+MsCUH9X9Y7tIqPoIHLORRXyQG/kFELBam5Nfnilgb92XobvGnBELihTkD3ROA9MhWD
	 vezy6pG+FDflsaGm5MUa7cDNjqPmLlceoIyBtg4lJ3c2YEo/jucfd3b7bwv/6zY1wQvu/
	 T5FjM8IGHFVk7oswPsMGjJudDxZYvcfqxDKngfcMGG+Es0T7hLnhMB5ewLoroq+rU2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RDQptoAr;
	arc=none smtp.remote-ip=209.85.160.198
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F88606A31D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 12:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9F88606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RDQptoAr
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5364605e74bso17080061cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792585566; x=1793190366; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NR/6ReBtZzWPhL7shMo8n0oVFcpdIbC1mfBQJ9hh1jE=;
        b=RDQptoAr7ZarafLjdYmo2ZhJs4b25kqadd7r9xdWurdX2lBuxGBC9Un5Wy9mY8DA8s
         S/EMrM1T7nR0PBt/Y0xm8VF9eNGiLRMoVXPt/kGWXFhWAcj7TRw4+Kiu3hHTHKThZw9u
         6yD7HXvvIffk42RgAKcF0R3gIqmN2WrFdmIpZEkWOmcD6+TWDw8mNnyCclW0HuRUq8F+
         HcVbwviKLbVDr5SOr7KfK5TXb7yEjdkwEyhNoQbWuJfo/H4d8WJ+tEbouL/sQx9/Mvdg
         XtTdKWWip+Q0SF0MzPVNw6NXwEN15KIyzfU+5ajNZfiVxrSjsAVximiJRVsT0HvCgQ2/
         4x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585566; x=1793190366;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NR/6ReBtZzWPhL7shMo8n0oVFcpdIbC1mfBQJ9hh1jE=;
        b=FhLsOEDE/zqyTSgWfZByahJVp32HyKx1NdUhVhfjPVmNBEVedOI9NyshE59SWL3tco
         JfPytvOh2UddGB/b36G1aaOtYQbuDrg/gCUvpHnWpn1aR1X5Pys+A3jKOhBYj7h/fQif
         mK86/FXcLoxAw0KEqJcMaJcf+lUSNPPclO8NkK137x1V9A2Birvx93KzwTIjekzhHUxv
         rjfQlfvPdMYZzkS3qKPUWiI0AHgFh8p5s113wbRE6kzgEmVqUIBVrMFJuV9JW6peE8+G
         4VkVgpA6ORNYN6lpChJZsqFcXbbS0+of2pOXPiGDWkAMbjtvtdj4mwLgQt8MyZs1YBU9
         iwGQ==
X-Gm-Message-State: AFq9FYJffP2jhexA4kTRwZYkzigDKhYHAJ8gtAlwmEe7kSBTQwHVAaWt
	UrWINOWMB66cQQWZzWoMQ75uUnl035FeF+3KCEljo0BuG0HNStqOp7ZyTNBglhbDJpEKjX2gGei
	e+iB3Qw==
X-Received: from qvbfi13.prod.google.com ([2002:a05:6214:1a4d:b0:91b:88d2:29c0])
 (user=sadrul job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:488:b0:535:855e:6e25
 with SMTP id d75a77b69052e-5369b8c7082mr28413131cf.47.1792585565409; Wed, 21
 Oct 2026 05:26:05 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:25:42 +0000
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021122543.3547778-1-sadrul@google.com>
Subject: [PATCH v2 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
From: Sadrul Chowdhury <sadrul@google.com>
To: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Sadrul Chowdhury <sadrul@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

During system suspend (freeze_processes) and resume (thaw_processes),
threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
try_to_freeze_tasks() executes, it must wake up every sleeping thread
with a synthetic signal so the thread can schedule, run try_to_freeze(),
enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes them
all up simultaneously, only for each thread to re-enter ep_poll(),
observe no ready I/O events, and call schedule() to go back to sleep.

On systems with numerous event-driven daemons (where hundreds of
threads idle in event loops), this causes a large wakeup stampede and
thousands of redundant context switches per suspend/resume cycle.

An earlier attempt to make epoll_wait() freezable in commit 1c441e921201
("epoll: use freezable blocking call") was reverted in commit
c511851de162 ("Revert "epoll: use freezable blocking call"") due to
reports of userspace corruption (Bugzilla #61781). Under the legacy
freezer design, freezable tasks could wake up prematurely while
hardware and peripheral drivers were still suspended.

With the 2022 core freezer rewrite (commit f5d39b020809 ("freezer,sched:
Rewrite core freezer logic")), the legacy fake-signal mechanism was
replaced with the TASK_FROZEN state. Tasks sleeping in TASK_FREEZABLE
are safely frozen in-place without waking them up, and the scheduler
guarantees they cannot be woken until thaw_processes() explicitly clears
the frozen state.

Mark sleeping tasks in ep_poll() as TASK_FREEZABLE. Benchmarks on an
ARM64 test device demonstrate that combining this with freezable
select/poll reduces thaw latency by 63% (from 20.64 ms down to 7.55 ms
mean at fixed CPU frequency) and reduces context switches during
freeze/thaw by 87%.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
---
v1 -> v2:
- Rebased against current mainline (torvalds/linux.git master).
- Collected Reviewed-by from Jan Kara and Acked-by from Rafael J. Wysocki.

 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f48b829a710f..76906ced2b86 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2327,7 +2327,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * the same lock on wakeup ep_poll_callback() side, so it
 		 * is safe to avoid an explicit barrier.
 		 */
-		__set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 
 		/*
 		 * Do the final check under the lock. ep_start/done_scan()
-- 
2.56.0.212.g129ede20d9-goog

