Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542247;
	b=HTmNOVubxhHRO9hrnG/skRPJcU4TKC8/Ok+kI/41HW3zli1B4iRD1BwnFJqlicZ6T3I7
	 GPYBs7pah9wzE9EHhT+wChTdRIF8OWQ7JECpFpirEvXBmqdCxtPsvEV4qbacj8lXdUEGC
	 MnhaXB/QqAfuY9zHz2aiwbG5atEYWzNK0zAdHbVRcNkzgCJTQ/dHFcwUfgInQd9AdatdE
	 Fm7UwiJs/nD9uSDxuIBAg1aGfVOEAp/33gAzg99zVHIfJJQco/Wl9kkqeq0s72erMu8jg
	 7mC8mNYnFKLe1TIeNw7nZzVMAfVYt7NkJG45nozwyAktvl9kjgkiVxn8i5e0dQcAeAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=fii55Qp0r/wSrNaQI8sgZ2kAvYmw+Mf1Zswb+CP9NWA=;
	b=ubQUvlOXdfRiL9CxN/P83WqFsTpOAzaOYmhTwW2aVsc34j8YTKNUp+wdJ6mjEkCCuCaK
	 k+U5HyXvZ4fZBuDnc3d7ue3ryUVrC9iFlRDoszKI3wgb9zaIQeffFlFV0o4p8ova8byrz
	 5mK6UA5mBTfmTR8TCI8LB00zKkT1X8eeWR0XDmNTT15msQylvHeFEkvAEvTVHXRyF7r8s
	 9hSCp6YycKeyM+idLeQnJc+Td/Klm7uzqiKEt5tRgENce5Wte7tNOrYREkB0fsKU7NQF8
	 9jRhQS7fKsBDwp3vcw9qjrSnL4vfFnhbQG/eDkyQMMsIwIo0yeAjJt4OEFVQ10QpphQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=QoGdHIe4;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAF606A329
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 17:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08BAF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=QoGdHIe4
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so7410615a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542245; x=1796147045; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fii55Qp0r/wSrNaQI8sgZ2kAvYmw+Mf1Zswb+CP9NWA=;
        b=QoGdHIe4UatBmZtKdLpfzjwjX805G81mQQR+f1JhiElE72366HnWHbBL3FOt4k2L7F
         V3WujGxe231Z2NoHjkZu04BdfLH6nqNst6QF/4956LE1FVxMa0uHIbgXBB9z3EWHr1zS
         yqjbpY9uvFHxJNXKHtspPNUSz7tghaorFS7Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542245; x=1796147045;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fii55Qp0r/wSrNaQI8sgZ2kAvYmw+Mf1Zswb+CP9NWA=;
        b=q8LNbzWKc2UicdRh0krf7n5DtHn+j5FhfyHIotiNH+k8gVJLYqEGYGqsV7ukYhKvLB
         u8cK5LkWsuqlb9rArELJm78/vMXtpgKvdIbJqM8/15y8CMGUD1Fydfry9ZqcYVx8d6uQ
         89v76m7uZr7W8G/9cp1zd+qkt+p7gWUcIbY8x0RuokaKzx4AUPHqaL0MNXS4CcKN+Ups
         sein3vlAaGqR7LS51d/qpMPc7SkOGT5qbHhiQCmwOmsB1qtGCxVKXPKkBr6NalvwWxyv
         TKV9tyX/P9XXgJ1bskfjy0YMdjKgpeFUETN0kFDUNWBGIzAKyxuyoZl9ENiiAx/vORC8
         Y9yQ==
X-Forwarded-Encrypted: i=1; AL+hErEQLmEs2gNLVVlgTuG7sso1Zy69WHB2ziYF1JCYEWK1RKNb19GMNzwteCNbWFXDmf/7/fwQGKygVN008Qgr@vger.kernel.org
X-Gm-Message-State: APuU4Z/QU0jLDiEHy+0P5IgyMsuGP4RZbp62CfLX+8Z8Fa0ofC9aVQbN
	uIyKhrLBynv0OeVWz6iX084eWj+/O4L/9YXn+yBfyqBDZJWhcACS3ZXIuhP09sDMzthFAWBaG+o
	4iQ3n1rUchg==
X-Gm-Gg: AZFdTZfQtQRPobT84si99v/MV47evLM1s4F+8yRDSnmO3TDC2zK5E9Cql+V3ipFe+0X
	wSwmnTXBM+TgitxufCsunqEjCm8trieseK6DHr8ao+IVS39j54jTcvaGTcvWUONqetafTg78MH7
	vNfgu67ecNrc9D5za/D+PX3nmjGBaJw4nmjSaR54ZKBW1YbE3BGXDjd2u+i2w8+5Xj57t/Lud0z
	sDEM2DM2H6a6iTZgo/PtQ4BKosbFqO083dD4Q1NXAMst4FfmpC7M3EjUPSkghLeU/qPCkMHYt3K
	SllZQgbkV0WdBqGLTgR+DyOtKig0z82DBwzh20kd7dL2YRMDBSBlT4yUmcQIWr6w8s7kFgPOWLy
	od70T82c+zk1ODtSpMxDD1GDoIYtqFQGH7ul2PszO53CecZc2Py3/wLWe7rp5FlaM1VHgozgAuj
	cnc4SErWtwO2FXZLTiNiML4mAMda6Tvo2h8klMSppPABat+pW4oca6S3/eD6YHyW0odl5f5YP9l
	o7IIuJj8L62A+C0rxz7oMhJ43ri++YlfASTEyDafUMLnfXRwsiKARxz3SNTb7FOuxk+s9DYh5HX
	B+zM08i8x0ucAJTeG+1jFJ5CmcETMMhQgsLZX8ehI7x9+gGHByRSnntL+6sUoIPHFregzt9v5lw
	4L6Q=
X-Received: by 2002:a05:6402:e06:b0:6b5:5fc8:9cac with SMTP id 4fb4d7f45d1cf-6ba37e8af86mr9969303a12.40.1795542245413;
        Tue, 24 Nov 2026 09:44:05 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35ca6sm7262886a12.4.2026.11.24.09.44.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:44:05 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c51373ae637so728646366b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:44:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGp770gFH44Xj9c/xQM1U5A+rpGClbJtgNHi2XOAaP3HRdWNpCDw/YrdDcLmoq/JBFEtxIQTnhYl6sIn/Qu@vger.kernel.org
X-Received: by 2002:a17:906:9542:b0:c46:a607:6922 with SMTP id
 a640c23a62f3a-c513a99e9e0mr1021358666b.25.1795542244185; Tue, 24 Nov 2026
 09:44:04 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 09:44:03 -0800
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 09:44:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com>
X-Gm-Features: Aa3M54odmpZClWB-dkdI0tw2OKY7MtCfPchrg_x_N52YZyjOYf8rYgnJ38U7qkc
Message-ID: <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com>
Subject: [PATCH 2/7] sched/wait: add WQ_FLAG_POLL_EXCLUSIVE for user space waiters
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 16:47:33 -0800
Subject: [PATCH 2/7] sched/wait: add WQ_FLAG_POLL_EXCLUSIVE for user space
 waiters

An exclusive waiter whose wake function returns a positive return value
to indicate that it has successfully been woken up stops the wakeup
walk, on the understanding that it will handle the event.

However, user space consumers - like eventpoll or io_uring - want to be
woken up, and want to avoid the thundering herd issue.  So they used an
exclusive wait - but without any actual guarantee that they will then
meaningfully handle the event.

So the wakeup could be lost, and real waiters would be left pending.

Add a separate flag for these kind of "exclusive poll" cases, which is
effectively what these user space waiters are.  Only the first such
entry that accepts a wakeup is woken, as now, but they don't count
against nr_exclusive and it doesn't stop the walk.

Wake-all (nr_exclusive == 0, including POLLFREE) still calls every entry.

Reported-by: Mani Tofigh <mt4022@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/wait.h |  1 +
 kernel/sched/wait.c  | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index b3e94c71cd3e..09518f8ff10c 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -21,6 +21,7 @@ int default_wake_function(struct wait_queue_entry
*wq_entry, unsigned mode, int
 #define WQ_FLAG_CUSTOM		0x04
 #define WQ_FLAG_DONE		0x08
 #define WQ_FLAG_PRIORITY	0x10
+#define WQ_FLAG_POLL_EXCLUSIVE	0x20

 /*
  * A single wait-queue entry structure:
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index f8d6d8b9d03e..9f126cc5c338 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -85,6 +85,11 @@ EXPORT_SYMBOL(remove_wait_queue);
  * may be at the head of the list, and can consume the event without any other
  * tasks being woken if it's also an exclusive task.
  *
+ * An exclusive waiter that returns >0 promises to handle the event. Pollers
+ * (EPOLLEXCLUSIVE) can't promise that, since userspace may never consume it.
+ * They use WQ_FLAG_POLL_EXCLUSIVE instead: only one of them is woken, but they
+ * never count against nr_exclusive or stop the walk.
+ *
  * There are circumstances in which we can try to wake a task which has already
  * started to run but is not in state TASK_RUNNING. try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
@@ -93,6 +98,7 @@ static int __wake_up_common(struct wait_queue_head
*wq_head, unsigned int mode,
 			int nr_exclusive, int wake_flags, void *key)
 {
 	wait_queue_entry_t *curr, *next;
+	bool poll_woken = false;

 	lockdep_assert_held(&wq_head->lock);

@@ -105,10 +111,16 @@ static int __wake_up_common(struct
wait_queue_head *wq_head, unsigned int mode,
 		unsigned flags = curr->flags;
 		int ret;

+		if ((flags & WQ_FLAG_POLL_EXCLUSIVE) && poll_woken)
+			continue;
 		ret = curr->func(curr, mode, wake_flags, key);
 		if (ret < 0)
 			break;
-		if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
+		if (!ret)
+			continue;
+		if (flags & WQ_FLAG_POLL_EXCLUSIVE)
+			poll_woken = nr_exclusive > 0;
+		else if ((flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
 			break;
 	}

-- 
2.56.0.313.g975a75ca90
