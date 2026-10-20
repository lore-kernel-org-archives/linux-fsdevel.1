Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498343;
	b=IDCItipS06q6W02ZljC/Ttps3sDCWi6fjrmX2QKSOgDc31yna0oLSxaFwwtzgL4ofATY
	 L3X0WJEYT/lqUV4m+7UTPAp0MPXONvjBjbm52oOAed0IiUOtcvbi2sQBuK4uxaod2+Hcj
	 WR/KXIkhh45akgvJZIXfdTtp9Zx3scZ6aaiTF75qY2DWKakcvQHCKz/cCJTODnvPn+LFc
	 Sn+S483HH3OENMxncJQfXpQNIAnEQyy6EYYcVDdClE5t7WuuwnJavnjxhTS0xoPjtiJeG
	 soaASC1ADNA/LpmiXWmSg8nqwLnWNc/G2iHYQmyappwZueobtqTh4caKHQvLosquBEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=6XUtngxDYkw/Y7D3ufCXmiJQV0M0BWIAb8OzCueSqgM=;
	b=0NlpvKI6zkuYwZZTHjwnPuz1IPRsKzwi97YpGWz39sdrbYXhppECjnIec6wbYYq6TtSQ
	 /0tHIDquBk8pKiMk8bV0RLzbjnH2DGWAR+acOvN08CjpXQNcnhlUht/+1QmJkWZV5yN+c
	 M/E1Cor7c9ONOdey2Uj2dmuzxJLNaWnG/H5HBg3LSJWjC3K/9r+fzZQs+egV67O0yaqPH
	 IBFIdLxImbUybMUSz8/nQV7mH/RpX8W2HSxPlN0n+kL5XSSxcBbYUYUISpD//yj3+PTI7
	 qWI9+XDjN172Y8ybvj11jSecQ6vbFhkneniP0tFQ1QaGRa8Kx04dzGdOMwnYTrz9Mng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mjaxFbC2;
	arc=none smtp.remote-ip=209.85.222.199
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76154606A31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 12:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76154606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mjaxFbC2
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e92aad34aso640957285a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792498342; x=1793103142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6XUtngxDYkw/Y7D3ufCXmiJQV0M0BWIAb8OzCueSqgM=;
        b=mjaxFbC2aFXaJQU3N2ZkgNo6hbsXk4tvgk/9++2CdzHgbFIWJdNnUzpPbKu//HVMEb
         85aRBJa1wJ4mNX2qondJxFxk3sI3lglpoQaJQv46lO6gGSuPZOaPWn+bXbpC/H/89F+n
         4pt7tB5QG6W36RYUN+KF+nii7eUeGaGahyFkQRz6Yy6JQLH4FO6PE3gCh9YH8HX3z7PZ
         pFE1crgepOTFWMgXgmE5TV1oXvw4WGcZZBovxpHhPbVhPhS4UNZzEX2rF/VZsOFcVqhd
         ydvsjMkIC4xp/Z0xtZpOyYWS9cfsLEeQBZg+ZmXpqfUBytsoQqF6kSdluw7AQMwYkCCO
         RGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792498342; x=1793103142;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6XUtngxDYkw/Y7D3ufCXmiJQV0M0BWIAb8OzCueSqgM=;
        b=RS6Az5ncGI4/A+2Ffvn3p71E6HHAICYhV1xGMaaWHFiaMmY1XT8NkaiQ0V7fWZ5REP
         GRR/PmJnU5wJPwCd5ysCwCP9SQkvdigu5OaWcCfSTWaTDM99N52yDTOx5aTyIxVYgZds
         QVgpg+GqhDiYZ0eIqKLuuFEZJ8m4CciMDYkZz70xWMo32WaDf8/KqHQww1uOPeY0xO/n
         WqhVCUZhJMVqqikBa3M0YGowqAEbpzZ3GrZZ2k9885s6FmMk7dttp83YrECuTxi//kfP
         JkXWJI2/h35vOtxafxa83QJuo8cWBa8KeMXrKZXqFFF0wCn0JTAPCnlqNiIoSDGQxpuv
         /oxg==
X-Gm-Message-State: AFq9FYKdp7GB/CpLp0RbH/QcBX0XdLkixP8i9jXdwM1NPfuxfbDwmbHT
	ufviBiqWucNDPdAVeqzuPc+FnCppKvC0Wx3uP3BS5fjX2M/hSFw/AsGvgcU5OBMgaZkxGH/FpqH
	nBYCMjw==
X-Received: from qvbkh14.prod.google.com ([2002:a05:6214:514e:b0:91b:e0f0:871a])
 (user=sadrul job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:2913:b0:93c:c7c6:90b5
 with SMTP id af79cd13be357-93f29b9af28mr1655598185a.9.1792498341848; Tue, 20
 Oct 2026 05:12:21 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:11:58 +0000
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
Message-ID: <20261020121159.2154649-1-sadrul@google.com>
Subject: [RESEND 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
From: Sadrul Chowdhury <sadrul@google.com>
To: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Sadrul Chowdhury <sadrul@google.com>
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
Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
---
 fs/eventpoll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 6cbef8b4c2e0..35992f6457bf 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -39,6 +39,7 @@
 #include <linux/rculist.h>
 #include <linux/capability.h>
 #include <net/busy_poll.h>
+#include <linux/freezer.h>
 
 #include <trace/hooks/fs.h>
 
@@ -1987,7 +1988,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * the same lock on wakeup ep_poll_callback() side, so it
 		 * is safe to avoid an explicit barrier.
 		 */
-		__set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 
 		/*
 		 * Do the final check under the lock. ep_start/done_scan()
-- 
2.56.0.212.g129ede20d9-goog

