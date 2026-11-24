Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542395;
	b=Xu1BuL+cFN55005HzB5A/Zc+cKshWs357EyLaWxP0rLDGYbgus3bQnqUbsdQhEdOA+do
	 nD+Oz7tuap1MRH6KzCz44WRlH93iJ3MUOOzxCVPlzo9EuqSBpYsJB8nOnodKj3rNYk8hS
	 9coYFc0k111CU5nEuulUyxy8IFLOyHayjJ/aN0CIwQM10GlLdBTN1pljdWpPsAT5jmKVd
	 QrcuspVBuLiDrsnJrE4OEZlZ14l3JySebhSMz6Ic+lHOkHqy54SDvGhDAbwt3sbzXem+l
	 FLZd9LnhqOXV1q+8chk19NVnnya3zCRuyQoZu0EqhB0VC8M/ScNExDnfuOdontALI6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=SQpKUtDlj4AZ1qDo3gcLs5ROWZFh7sOWq4cTgDCqyUA=;
	b=WAx206wkhm9i+65KzB8c1uwN2anaIWW4q24CmZy5AE+bNZhW2P4KuuBj2kORimBtbB+1
	 a+yW/k0qgfLaPvt16UTkMF3nN/XycgSiuT0Kww/N+OgAHdmLvUFvTmh5802jeE14tFfvK
	 G0Y9yGgQr2fJX7o0rbPAfp4PvK/d4s/IXaopUtlMcTIQDDUoLbjcqbjU34VdUrpRYOQHd
	 sD0Dkae+2t/uTtUJohXDaZkGAOmRTXsDnXMIg6KgqD2jA52VA4VGZWF7547YyO8grokAZ
	 35SadixL6B29q3P2w2GjRRKmRqXXiu0mwPyJrPAfCbFmRjF4u0aohetJx+LYg/UO86Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=WFJiSZjf;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F2606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 17:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D6F2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=WFJiSZjf
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d21051042so779733166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542393; x=1796147193; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SQpKUtDlj4AZ1qDo3gcLs5ROWZFh7sOWq4cTgDCqyUA=;
        b=WFJiSZjfwO5LB76QTiptGjaXVSI1/GyjQYLw+CdrlX85xnp8GX+dy8GIguEmWDRUbh
         nnLrRyEqFGakAn7HL+BvgJtGnE/tKuLaKi53gmC2KwmfsxWmLg+/LLgs+v4royRoIXqB
         U8b4lCdjYm0yk0u+bcGBS+e7ZXaaflBQr6NpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542393; x=1796147193;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQpKUtDlj4AZ1qDo3gcLs5ROWZFh7sOWq4cTgDCqyUA=;
        b=QjCOv6EvP60cABgQGTY12GD4YXOF0VdO4NSiBLy/jYpITiPo9E1gOlhjrPAiAEnJxF
         lNNIMFEHMnfb3sWiUE7yGfFrEJ9Q6NsPGsveHgXDEoKenBXRxGhgafPwA0ZkamaGFrzk
         IDymuXKfooixdJDAm68MXjMNf+xAQcQUXxZuPeqpc0Fih1O5/zyAc/wUVZXV9amAlGRY
         hzEQybRKpxib9UbED1kqxtWi8f/bWgnT/RyOncbdwbv8rbaCbdOj7S9K5CDLViSpv1iO
         6gEz4KkdCUgqs25+sfi+I3/ffuT6mHgiKCWbw1RwfU9x3NFRXkkuPhd2D4uet4KRErmX
         Q23w==
X-Forwarded-Encrypted: i=1; AL+hErFgQWzc5CV4m3Z8DRcEKUrwM0m7+yQPQm0i8lGfHchOj75nm3nHn2thjiU8WuVgHT392IE5NhwDOCv5f1tg@vger.kernel.org
X-Gm-Message-State: APuU4Z+goDhBdAwwr/C/2rkI9FR4vlMCJ7V7eK5K4WCQ9EGLitr1eejF
	uBqQpuUiVsELlfg1MQJmyKXe1jNmu+/YGxy/qxn1hCFi/gmLqf2IwFvORIvNY+YKTiRuw1hdlUY
	hTnSFr97cWQ==
X-Gm-Gg: AZFdTZe+JMQGQLUwu2ffwByS6Unpfc2gbadEVAZrBGFYpAbH2Xbawl4vUDzP9RjfgSb
	+tdhDXE+SE1UDZYvtKsZy7os2t6KGv8sP7VhszR6kY1RTl0K/pQD4EBzHg0QOJLC6ux90NRjW0u
	lMvKV402kuI4wD9YNKldyxZWHBA0J2QLGskDMSxPU00RZFggOzscZpk5bvyc6GONobRsYa5hniZ
	AbIvm48ycg5HAlcNQ0m5xf3EEjf5eVn9Lhztfm7JuYTzIuTO4KXQEJ7aYXDVOxnwiWU686Id83V
	Yrh2cQi5HnU4DwfzfSg/f0UcAYMpTxPywBP4oF81UMI2lEUXG024KlscK0FPib/xxjcz+GB9+dC
	nBGrYL4fQU6Lugd9j94D0MvNqqywMwm8wTnC/ELG3mHDrzEdeQrWSU6FQdBtt3a9DIOt4BQXQ6m
	KoO4qrD/hm8gimBytFKp9yehSxHa982tKVJP9iuQUFbH2v0CDDrii+Xd8s1xzGHYS1G3z/xhA3v
	RhRju6xIYG4VAfi4UdDn2GV7W7Othn8lmjywsZhijIA8fZ2MpPMGbQaQw4w1GSkfisy4eCyM23D
	fY9sH2gTg4vUO71nOzBJj5jpA5gKpfMJVcxdyIsUU8yRlXg4oM/2V7qbYYYxlRSCJlY7P3CjRvW
	7vW4=
X-Received: by 2002:a17:907:20e4:b0:c46:87f9:f5f7 with SMTP id a640c23a62f3a-c513a5ecfafmr914856966b.17.1795542392639;
        Tue, 24 Nov 2026 09:46:32 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae9dc7asm549764766b.41.2026.11.24.09.46.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:46:31 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c51a02ad3acso74032466b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:46:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErED00m9zqNs+p6J6YUIkEQ0Kyba3vIrCbKzMg0uI0/4tOHjyg6WyuTJu/+SM+/ZgF53U+c2L8bzXnlZApPv@vger.kernel.org
X-Received: by 2002:a17:907:3ccb:b0:c3f:84aa:af0d with SMTP id
 a640c23a62f3a-c513a811d6amr1255078566b.18.1795542391340; Tue, 24 Nov 2026
 09:46:31 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 12:46:30 -0500
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
Date: Tue, 24 Nov 2026 12:46:30 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgNZfCN5qW-0pOK_TFBscqTu6an7fK5pEkxewg-Aif1Fg@mail.gmail.com>
X-Gm-Features: Aa3M54p8plLWbVY6iSjVP3DnYsEIL6S32qEa4KRav48BblCo7RxKY_YSzzQDIJA
Message-ID: <CAHk-=wgNZfCN5qW-0pOK_TFBscqTu6an7fK5pEkxewg-Aif1Fg@mail.gmail.com>
Subject: [PATCH 5/7] sched/wait: always queue new waiters at the tail
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 16:48:44 -0800
Subject: [PATCH 5/7] sched/wait: always queue new waiters at the tail

Non-exclusive waiters have been added at the head and exclusive ones at
the tail, so that an exclusive wakeup stopping early still woke every
non-exclusive waiter.

That only matters for waiters that mix both kinds on one queue like
read() and poll() on a pipe - and even then it doesn't actually buy
anything but complexity and fragility of the code.

An exclusive reader consumes the event, the poller had nothing to see,
so there's no real point in keeping the two ordered.

The pointless ordering results in a special rule for everybody adding
themselves to the wait queue, and that rule has not been consistently
followed anyway (see for example do_wait_intr() and do_wait_intr_irq())

So just queue everyone in FIFO order.  LIFO might be better for
throughput, but every time we've ever tried that optimization in real
life, it has caused fairness issues, so let's just do the obvious thing
and add new waiters at the end of the list.

Priority entries (used by the hypervisor code - questionable special
case) are still placed at the head by add_wait_queue_priority*().

And because epoll is a pile of stinking manure that I am afraid to touch
this leaves __add_wait_queue_exclusive() alone and it adds its entry at
the head for epoll's ep->wq so its own wakeup order doesn't change.

Now that it isn't a "real" exclusive wake event, its ordering thankfully
doesn't actually matter for anybody else.  It should be fixed, but it's
now basically just an internal epoll thing (and that will be made more
obvious in following patches).

Cc: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/wait.h | 14 +++-----------
 kernel/sched/wait.c  | 29 ++++++++++++++++-------------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 09518f8ff10c..bf0a3713ed0f 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -171,25 +171,17 @@ extern void remove_wait_queue(struct
wait_queue_head *wq_head, struct wait_queue

 static inline void __add_wait_queue(struct wait_queue_head *wq_head,
struct wait_queue_entry *wq_entry)
 {
-	struct list_head *head = &wq_head->head;
-	struct wait_queue_entry *wq;
-
-	list_for_each_entry(wq, &wq_head->head, entry) {
-		if (!(wq->flags & WQ_FLAG_PRIORITY))
-			break;
-		head = &wq->entry;
-	}
-	list_add(&wq_entry->entry, head);
+	list_add_tail(&wq_entry->entry, &wq_head->head);
 }

 /*
- * Used for wake-one threads:
+ * Adds at the head, for epoll's LIFO wakeup of its epoll_wait()ers.
  */
 static inline void
 __add_wait_queue_exclusive(struct wait_queue_head *wq_head, struct
wait_queue_entry *wq_entry)
 {
 	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue(wq_head, wq_entry);
+	list_add(&wq_entry->entry, &wq_head->head);
 }

 static inline void __add_wait_queue_entry_tail(struct wait_queue_head
*wq_head, struct wait_queue_entry *wq_entry)
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 9f126cc5c338..a14e14202279 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -40,11 +40,18 @@ EXPORT_SYMBOL(add_wait_queue_exclusive);

 void add_wait_queue_priority(struct wait_queue_head *wq_head, struct
wait_queue_entry *wq_entry)
 {
+	struct list_head *head = &wq_head->head;
+	struct wait_queue_entry *wq;
 	unsigned long flags;

 	wq_entry->flags |= WQ_FLAG_PRIORITY;
 	spin_lock_irqsave(&wq_head->lock, flags);
-	__add_wait_queue(wq_head, wq_entry);
+	list_for_each_entry(wq, &wq_head->head, entry) {
+		if (!(wq->flags & WQ_FLAG_PRIORITY))
+			break;
+		head = &wq->entry;
+	}
+	list_add(&wq_entry->entry, head);
 	spin_unlock_irqrestore(&wq_head->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_wait_queue_priority);
@@ -78,12 +85,12 @@ EXPORT_SYMBOL(remove_wait_queue);

 /*
  * The core wakeup function. Non-exclusive wakeups (nr_exclusive == 0) just
- * wake everything up. If it's an exclusive wakeup (nr_exclusive == small +ve
- * number) then we wake that number of exclusive tasks, and potentially all
- * the non-exclusive tasks. Normally, exclusive tasks will be at the end of
- * the list and any non-exclusive tasks will be woken first. A priority task
- * may be at the head of the list, and can consume the event without any other
- * tasks being woken if it's also an exclusive task.
+ * wake everything up. Otherwise the walk stops once nr_exclusive exclusive
+ * tasks have been woken. Waiters are queued in FIFO order, so non-exclusive
+ * waiters queued behind that point are not woken: the exclusive waiters will
+ * consume the event. A priority task may be at the head of the list, and can
+ * consume the event without any other tasks being woken if it's also an
+ * exclusive task.
  *
  * An exclusive waiter that returns >0 promises to handle the event. Pollers
  * (EPOLLEXCLUSIVE) can't promise that, since userspace may never consume it.
@@ -308,12 +315,8 @@ long prepare_to_wait_event(struct wait_queue_head
*wq_head, struct wait_queue_en
 		list_del_init(&wq_entry->entry);
 		ret = -ERESTARTSYS;
 	} else {
-		if (list_empty(&wq_entry->entry)) {
-			if (wq_entry->flags & WQ_FLAG_EXCLUSIVE)
-				__add_wait_queue_entry_tail(wq_head, wq_entry);
-			else
-				__add_wait_queue(wq_head, wq_entry);
-		}
+		if (list_empty(&wq_entry->entry))
+			__add_wait_queue(wq_head, wq_entry);
 		set_current_state(state);
 	}
 	spin_unlock_irqrestore(&wq_head->lock, flags);
-- 
2.56.0.313.g975a75ca90
