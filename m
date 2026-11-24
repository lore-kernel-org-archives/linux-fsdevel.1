Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542474;
	b=c1DMx3coSAwnDp4v83JcnD6bcZQaxdqce78g7llXiG1hF0Ex9+s2kipCOA99QVIja3jN
	 gjJNKMAxmG9y25G4SA3navkkUnbaPlNF3HOLZDuAAJpyIpVTwZQNyzZKsJ++uR2zCBIgb
	 8aTLKiVO0l6e9dD3PT3cYL19bvUuPInL/Latzzs5kMc4Eqpk0NbAsuxA2dVk0xJu63S06
	 UCCbWY9Hpawal2evs+l2WmxyGJgNKidC7f0y/9F6JOiUJ67qckNcomEGzjd+OywnyxDoT
	 1n/V6dAUT2FkWKwnsgbNmUH9MKEDul5/irwmaYJsvXjmfTSMT5bZO+B6KLpsJ6IYzyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=H7ztE50hZokGuEnZu7uhKJFIAPGf1iIgqAITsfIe0uA=;
	b=O7NLxJ3YEzszB6Dj/aHxdjU48hHJDYPF2c0QrCAFhQSSMfa0YN8GwCe0wOcA5v6+fmY3
	 7HNiF55jgAGylJ1ERFasqN8oqrNeCk4Ekg9JphuMwPj695jxs0wJuN2wo+uw5Hz5CbinR
	 e/zHMXQ4iKt69z6ZqmlLbLeAx0iey2I9IIp0Kg6kvXQ+33Lm7eA4xLyPKD1sajUcru5BZ
	 NPI1+6CCVVZeF056hLjZvfjRnX7WJQp2LOUetWxIsAJ3wF81qYT0brGvZ0TqrMhnqiM/R
	 eAOApLEJ2eGOhf17rkSm5SxlWFTTf3q9mYEKt+d5R3r920p9yaA7p3FjN2vST0ACQ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=BItKy6yl;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4479606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 17:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4479606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=BItKy6yl
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4395d31228so822081166b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542472; x=1796147272; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7ztE50hZokGuEnZu7uhKJFIAPGf1iIgqAITsfIe0uA=;
        b=BItKy6ylqxo/WGtHCOnn+vsM/6jVBxwZRbHtjPi8BCdVu0Adc1SaGbQoZSTwCEu07l
         U4ujjG6s/0/fuseoaS3Ko4ZeHlRy9A3sfQrYyj1YQx+8IcFQHy+if5ETXoHgM1qv4B/2
         A0qtYbZ8J8VR+nxAHDhwPiiwEuhToGrWe2t7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542472; x=1796147272;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7ztE50hZokGuEnZu7uhKJFIAPGf1iIgqAITsfIe0uA=;
        b=nW/OpiJZo0KBCPbkLUTGe1oPFW7MwI5ZgGDlNxWFLYPYGsnnAkA0WyUg1grdl2B8tT
         GYI8d/uGfMgs99nE4kjzXsL0LLRKu8aaixD8UO32vTUAbK836xIGX8O37+ACfBiaKZmT
         OMoLSBYlwNyDasWZroaK1fsBHVqCOp51E3BIazXngNB34n8arpvzOZ+Na23Mq7gfpWCW
         tk32cQ0uQQ8NDjBWKylpmyjHy3iaPQnPs3M9c2WfAsxdMjOneNTiFbkxJ41s27aPRpoH
         Ya2jOl09YOvIZFLXwiZiYNWSVzwOeMjhXVhWdJZcjQ1li05++1dTm17nLHGhXMTP/uLe
         jVig==
X-Forwarded-Encrypted: i=1; AL+hErEx9KLqYzA90jFbFdkNQSNolKyxo6aPLcSgPG3cnXjUx6rumgBwhzdhaA6qal51wAdk3vQE0PxTThlq+lLW@vger.kernel.org
X-Gm-Message-State: APuU4Z9WXZKCgRWfOLneA3iKAxCZmFS8bpofeprrjlNEDzU4ym0FDRe3
	br0PZzDzIaRo0LZWx+qBPGLMO/if+UnopLiYNAMtI8aH96rbvyn2RDv/BrHOkX9Nk3smF+GdeXy
	SWyyHSYVF4Q==
X-Gm-Gg: AZFdTZc8dfIXH2M1Wvv8ekdyQm1TJAW2G5c1BRMHEYTtzLIRtV4ieEJ7wVBtGmz0S96
	QN5mfFMP7czq5Tt7H0VwTWZTdx1sZEw13mrV8ZgA7adTO2EyG6V7M936k96ZlzLXsS2+LNXVvI3
	PD9CFx3pRqPYuJsQL0zETDeTaroswlsv/YR2b0FYZyKX8FpVXzrfhSETrUDgjFEMGjciCP08jSQ
	mu2BTZs8P7DDzX99m3JQBLldrcA1XQ8cTXr/yOy3F0aOt2QkEydn7tKrU6viv0ejpCxBP5vF85r
	rAJ0gdtu4OABA1ZegxQZNb3HPzf7AcfAkikwzrPOb4B/ntUSbU3NBSw8Lo0zntlLyfEFm6QBuAg
	HAwG6wLqzO+R1aVojMrkLa7LZgEuyOR6RiD4SsjzLH1udB0cF5dZJaNftLEIv+UzdmHIckZv9Mn
	MJouZS/YCSO30MOm+zHcffj6Og7BwBp5hx/kOUiHSdvx4/GeyONTto1uz+FABrv12gJGw3NSaQp
	EnmFhw4BFBkrCUxI+4erTSode4fHK0PmvfB3YBW5HzTnrMeyBCYlnkhtZD+UiNGXizRitPzOPpG
	9e7t5o8MsaLQphfLasYy/08Y7mTbISvnR+ova0bWhtefzedhpTRtiDY1T5RgWNLfTfGu7E4ldWK
	a1aR/DifWLSbgeZTWPWguLAdz
X-Received: by 2002:a17:906:a408:b0:c49:901c:d9f with SMTP id a640c23a62f3a-c513aaff7dfmr1041202066b.49.1795542472230;
        Tue, 24 Nov 2026 09:47:52 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad01ae8sm571032966b.9.2026.11.24.09.47.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:47:51 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so796376966b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:47:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH2uhMTV+vBeH6a+95MMBefwpTof0//U9kOold2mY2oLuKXVjVQL8ERHYvtIvuFI1i8gD939KakmGnQsHmR@vger.kernel.org
X-Received: by 2002:a17:907:940a:b0:c50:94be:22ab with SMTP id
 a640c23a62f3a-c513a805245mr1446646966b.18.1795542470849; Tue, 24 Nov 2026
 09:47:50 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 09:47:48 -0800
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
Date: Tue, 24 Nov 2026 09:47:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvd5odMS8560FgZUnVLKmSwfBZRbX074S1a3xr02RBGQ@mail.gmail.com>
X-Gm-Features: Aa3M54qOt4-7HBDAcgu5xUlq8oQzhcFZHk2EabxzMar5L5v32hBVGAZZneRFhHM
Message-ID: <CAHk-=wgvd5odMS8560FgZUnVLKmSwfBZRbX074S1a3xr02RBGQ@mail.gmail.com>
Subject: [PATCH 7/7] sched/wait: remove the __add_wait_queue_*exclusive() helpers
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 17:04:33 -0800
Subject: [PATCH 7/7] sched/wait: remove the __add_wait_queue_*exclusive()
 helpers

Each has one or two special-case users.  Open-code them there: set
WQ_FLAG_EXCLUSIVE and queue the entry directly, with a note on why the
caller doesn't use add_wait_queue_exclusive().

I think all cases (eventpoll, orangefs and ubifs) are unnecessary and
could just use the regular ordering, but I'll leave that to those
maintainers to sort out.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>	# eventpoll
Cc: Christian Brauner <brauner@kernel.org>	# eventpoll
Cc: Jan Kara <jack@suse.cz>			# eventpoll
Cc: Mike Marshall <hubcap@omnibond.com>		# orangefs
Cc: Richard Weinberger <richard@nod.at>		# ubifs
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/eventpoll.c                |  7 +++++--
 fs/orangefs/orangefs-bufmap.c |  7 +++++--
 fs/ubifs/journal.c            |  4 +++-
 include/linux/wait.h          | 17 -----------------
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 58c0cb845dc7..14095cd5f7cf 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2351,8 +2351,11 @@ static int ep_poll(struct eventpoll *ep, struct
epoll_event __user *events,
 		 * important.
 		 */
 		eavail = ep_events_available(ep);
-		if (!eavail)
-			__add_wait_queue_exclusive(&ep->wq, &wait);
+		if (!eavail) {
+			/* Head, for LIFO wakeups; ep->lock serializes ep->wq */
+			wait.flags |= WQ_FLAG_EXCLUSIVE;
+			list_add(&wait.entry, &ep->wq.head);
+		}

 		spin_unlock_irq(&ep->lock);

diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index 34195f2cd845..bc0abc050934 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -85,8 +85,11 @@ static int wait_for_free(struct slot_map *m)

 	do {
 		long n = left, t;
-		if (likely(list_empty(&wait.entry)))
-			__add_wait_queue_entry_tail_exclusive(&m->q, &wait);
+		if (likely(list_empty(&wait.entry))) {
+			/* m->q.lock is held */
+			wait.flags |= WQ_FLAG_EXCLUSIVE;
+			__add_wait_queue(&m->q, &wait);
+		}
 		set_current_state(TASK_INTERRUPTIBLE);

 		if (m->c > 0)
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 40a95a2fad50..a8a6c9b01b9b 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -303,7 +303,9 @@ static void __queue_and_wait(struct ubifs_info *c)
 {
 	DEFINE_WAIT(wait);

-	__add_wait_queue_entry_tail_exclusive(&c->reserve_space_wq, &wait);
+	/* c->reserve_space_wq.lock is held */
+	wait.flags |= WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue(&c->reserve_space_wq, &wait);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	spin_unlock(&c->reserve_space_wq.lock);

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 4f87ad870f51..bc2ad10a00b2 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -174,23 +174,6 @@ static inline void __add_wait_queue(struct
wait_queue_head *wq_head, struct wait
 	list_add_tail(&wq_entry->entry, &wq_head->head);
 }

-/*
- * Adds at the head, for epoll's LIFO wakeup of its epoll_wait()ers.
- */
-static inline void
-__add_wait_queue_exclusive(struct wait_queue_head *wq_head, struct
wait_queue_entry *wq_entry)
-{
-	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
-	list_add(&wq_entry->entry, &wq_head->head);
-}
-
-static inline void
-__add_wait_queue_entry_tail_exclusive(struct wait_queue_head
*wq_head, struct wait_queue_entry *wq_entry)
-{
-	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue(wq_head, wq_entry);
-}
-
 static inline void
 __remove_wait_queue(struct wait_queue_head *wq_head, struct
wait_queue_entry *wq_entry)
 {
-- 
2.56.0.313.g975a75ca90
