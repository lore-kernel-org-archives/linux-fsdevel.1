Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542437;
	b=lFNBm73/Hmw/SdS+gtzrGZL+ouC8578RgAypilHADwZYo2PoagJk5bGavk0itIR7oDOX
	 PVfALfsWQlOFESOaMOHT/nICZyfAjZaYX3H7vJpWmix7QSICZb7rqhJUSo9Lwhq6YdBK5
	 QRDYV3dVQvrMkju7/HeEgiv41rhHqL2CKYmrfSUZjSdivgGKjNRtqGmlZFiZ5069m94cA
	 Jlz6goutHHzW5veKeSzYrOFJkN2++hF9GVcaKAYMMkDTc7vk/1S51P42cW3XNFWtHN0fy
	 lx8WW7fiB5qwsO4QrbCnb23WnGeKp3fi9Lw1JF8xoQqU6/XuhovkI7EVD9RSP+/MLUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=zddTylz8qiVh2ypmdVkH2gu5RcJeF+l5NRl7cFaw7gE=;
	b=q97MNRHf+UkNKeMfKIE9h8f0PNBCTxcXRXdLi9JxONQMa++nbS26bMnLrmqniJ0hBVKd
	 wVWz8MkLmOPePWVvu5sD5Ms63j1eDW/1HksCMaWALrFdVGxlYjscetsmqjxJCdHdRQDy0
	 lkQgua/s08nq1yL8VNYSE0QQIfm6YLpFNWH1AeM7eRGqFOD/WGWIkpQw6lgMM/hoGcRbx
	 Cb7i/heyIlMfEiHHgUkD9FrMgjRqYFrDhqCdvJS7rCVFGPvhvpTDaO57M/xB/lo8e+6Hk
	 QqlsZHZvBmi0ipd6WSrmBXjIXkv88NO67xngxf/fHxkjxEMdweDtzCa4MkB0xqFYz9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b="T/6zmOAO";
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915A606A321
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 17:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E915A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=T/6zmOAO
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4322d310e7so248126266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542435; x=1796147235; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zddTylz8qiVh2ypmdVkH2gu5RcJeF+l5NRl7cFaw7gE=;
        b=T/6zmOAOvv8o5+cFqRmmnANzYffDknvddmUCpgxfujYPwI2b+Cx661cUqZmEcHOPeG
         CuitOfskAil8IX8sOr1jlP4XbALvfTkKk1UJXseTvVSylqZ/oX44yXyQXxmfBtQDf/vv
         ClrXWOCFOHRMrkm0H8KLlbbALfO2UMUoPBjWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542435; x=1796147235;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zddTylz8qiVh2ypmdVkH2gu5RcJeF+l5NRl7cFaw7gE=;
        b=iscWEp4drj9QgDPLc2kVDpeifmgMKLAcDfqrklfke4SACCm6qB9eMLDL6PfaNMzXuo
         +zc+/fmq5DZTDsEhNNFD9DBYyL6laoMIvSYBBhs15xApqS//waF5gEcBWaNhT8u2QfSH
         WI8L+bVVvs3iyEboJCm3jortXlCAcQl68P9oYv/8OmUw7Zux/0NLUXYORBOHjNbvqRsN
         +FZgU3vnAqWMclSk85q6NhiUUH9J7PztVEZ9v//Ko1pZk765A6m3MNMi3eAZ06XtZyde
         OnZBJwtW/n9ng/RTD0IabXRRQtSCF2srDZOsS4hv39iQQn5Yf0M6A2ZlsA/3Vnvxe+27
         TGOg==
X-Forwarded-Encrypted: i=1; AL+hErH0EP7NhLiSAShOLHbPWH+QsZNhFcpeyiIsNio9WEFX7K7e8oXX0OdbREZccKqlyrTuxZvkQ3EulpVzmuC4@vger.kernel.org
X-Gm-Message-State: APuU4Z887Yqn3AlCEMgO6MPbbO8P1FlN/6hED/CtXBEnsJhaR/I3IaRu
	4VC1ohHKlXPxpHLozKP31FK8gMQjaubdI1Ld9MwoEq2kkeLhDLluPBY9fC3lM0dCL6o3+aPboiM
	w4xk1silVXg==
X-Gm-Gg: AZFdTZcHTwlVkubulwvIavsaZLFZkRkVU0clTsWwBguRQXU90Yq6mE0qOXfd1UiqesD
	paI5wAYL242nZ83w0pQBhMRvYo2A79gGvZ8Hvqimsk9rtFmF7gcdlkcTuoPjWPIeyR32PSvcJ3s
	33n5/v0RWCU20rIm9HiUxvOeixNYewiXAoDxe87MXxH5kpCTopPy3TBuicOhRtaYxBp99JczYP+
	2mWrMVKftotiyL1+UywUNFD7Lc6SejzXuC+t6Tr3L8fn/qnnr8IN3fW+LlzCdxIiAQarc2/4tsM
	6MpK0WpgpsXS+HZzQ5pXbs2aN4N1TxYzueI7vYen3JfzTALlIHSEtDxQrSLF5t/j+v51slNvv4W
	PNz8cFqXbiT9nKOzJ+M/xr4BBR15LrUWV8iMfneU3Le8cTssJXGpXII6B5x7Gq5vxhphD3npJRO
	Ww2v0y4bpJ3/Y+qlGq2g/30UgGMSLzqk9zrSntoQfQ7+cdQTfIZQGxuvDO42VriXDwlP0+U/unS
	OxwXeHaJxwcEIXAq9wtBGrb4L5S8jc8A4INRb7Wpb6uoR6GDgm/PfTum5XPD0tF71s/F6diqF08
	PmNMsS19ufz0fnh3JQGT8eDMnArdS4c6ee0PswaLpIKXhmaqkKZoDOhNRq0pS0AD6ballKUuCvG
	pDMs=
X-Received: by 2002:a17:907:3e89:b0:c51:3bfa:8d3b with SMTP id a640c23a62f3a-c513bfa8f32mr1296573366b.37.1795542435289;
        Tue, 24 Nov 2026 09:47:15 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afeb9bfsm530342366b.74.2026.11.24.09.47.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:47:14 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c50e26763a4so886523266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 09:47:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErESfhYTA8xL2nqJsjP382EuI8JXedX9WD5bEGpK+3tqmfHaPs/a4VPL8aADwwUvH3s4UMYxjCXsg4kJPKFG@vger.kernel.org
X-Received: by 2002:a17:907:6091:b0:c3e:f39b:2286 with SMTP id
 a640c23a62f3a-c513a25e36bmr1373884966b.0.1795542434448; Tue, 24 Nov 2026
 09:47:14 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 11:47:13 -0600
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
Date: Tue, 24 Nov 2026 11:47:13 -0600
X-Gmail-Original-Message-ID: <CAHk-=wi4z0tv+1KLCec4xmctgzK8TzDOBDfPUo7cm7ixbGzdfA@mail.gmail.com>
X-Gm-Features: Aa3M54qUYvjHET6ZCUFf6jPslA74Mny1q3-g-c-Fn4dOshcSMOv9NPJMWy8y-3k
Message-ID: <CAHk-=wi4z0tv+1KLCec4xmctgzK8TzDOBDfPUo7cm7ixbGzdfA@mail.gmail.com>
Subject: [PATCH 6/7] sched/wait: remove __add_wait_queue_entry_tail()
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 16:56:58 -0800
Subject: [PATCH 6/7] sched/wait: remove __add_wait_queue_entry_tail()

__add_wait_queue() and __add_wait_queue_entry_tail() are now the same.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 block/blk-iocost.c                   | 2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c | 2 +-
 fs/orangefs/orangefs-bufmap.c        | 2 +-
 include/linux/wait.h                 | 7 +------
 kernel/locking/percpu-rwsem.c        | 2 +-
 kernel/sched/wait.c                  | 8 ++++----
 mm/filemap.c                         | 6 +++---
 7 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 0ffe34bd95b7..f435bb894d71 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2764,7 +2764,7 @@ iocg_handle_over_budget(struct rq_qos *rqos,
struct ioc_gq *iocg,
 	wait->abs_cost = abs_cost;
 	wait->committed = false; /* will be set true by waker */

-	__add_wait_queue_entry_tail(&iocg->waitq, &wait->wait);
+	__add_wait_queue(&iocg->waitq, &wait->wait);
 	iocg_kick_waitq(iocg, ioc_locked, now);
 	return action_wait;
 }
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c
b/drivers/gpu/drm/i915/i915_sw_fence.c
index f24f616e23ee..e107ba9d4c24 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -382,7 +382,7 @@ static int __i915_sw_fence_await_sw_fence(struct
i915_sw_fence *fence,

 	spin_lock_irqsave(&signaler->wait.lock, flags);
 	if (likely(!i915_sw_fence_done(signaler))) {
-		__add_wait_queue_entry_tail(&signaler->wait, wq);
+		__add_wait_queue(&signaler->wait, wq);
 		pending = 1;
 	} else {
 		i915_sw_fence_wake(wq, 0, signaler->error, NULL);
diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
index a557e1cf7436..34195f2cd845 100644
--- a/fs/orangefs/orangefs-bufmap.c
+++ b/fs/orangefs/orangefs-bufmap.c
@@ -48,7 +48,7 @@ static void run_down(struct slot_map *m)
 	if (m->c != -1) {
 		for (;;) {
 			if (likely(list_empty(&wait.entry)))
-				__add_wait_queue_entry_tail(&m->q, &wait);
+				__add_wait_queue(&m->q, &wait);
 			set_current_state(TASK_UNINTERRUPTIBLE);

 			if (m->c == -1)
diff --git a/include/linux/wait.h b/include/linux/wait.h
index bf0a3713ed0f..4f87ad870f51 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -184,16 +184,11 @@ __add_wait_queue_exclusive(struct
wait_queue_head *wq_head, struct wait_queue_en
 	list_add(&wq_entry->entry, &wq_head->head);
 }

-static inline void __add_wait_queue_entry_tail(struct wait_queue_head
*wq_head, struct wait_queue_entry *wq_entry)
-{
-	list_add_tail(&wq_entry->entry, &wq_head->head);
-}
-
 static inline void
 __add_wait_queue_entry_tail_exclusive(struct wait_queue_head
*wq_head, struct wait_queue_entry *wq_entry)
 {
 	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
-	__add_wait_queue_entry_tail(wq_head, wq_entry);
+	__add_wait_queue(wq_head, wq_entry);
 }

 static inline void
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 6c78961fe753..0e1b6e3210a2 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -152,7 +152,7 @@ static void percpu_rwsem_wait(struct
percpu_rw_semaphore *sem, bool reader,
 	wait = !__percpu_rwsem_trylock(sem, reader);
 	if (wait) {
 		wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
-		__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
+		__add_wait_queue(&sem->waiters, &wq_entry);
 	}
 	spin_unlock_irq(&sem->waiters.lock);

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index a14e14202279..c77f104ae2fb 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -33,7 +33,7 @@ void add_wait_queue_exclusive(struct wait_queue_head
*wq_head, struct wait_queue

 	wq_entry->flags |= WQ_FLAG_EXCLUSIVE;
 	spin_lock_irqsave(&wq_head->lock, flags);
-	__add_wait_queue_entry_tail(wq_head, wq_entry);
+	__add_wait_queue(wq_head, wq_entry);
 	spin_unlock_irqrestore(&wq_head->lock, flags);
 }
 EXPORT_SYMBOL(add_wait_queue_exclusive);
@@ -276,7 +276,7 @@ prepare_to_wait_exclusive(struct wait_queue_head
*wq_head, struct wait_queue_ent
 	spin_lock_irqsave(&wq_head->lock, flags);
 	if (list_empty(&wq_entry->entry)) {
 		was_empty = list_empty(&wq_head->head);
-		__add_wait_queue_entry_tail(wq_head, wq_entry);
+		__add_wait_queue(wq_head, wq_entry);
 	}
 	set_current_state(state);
 	spin_unlock_irqrestore(&wq_head->lock, flags);
@@ -335,7 +335,7 @@ EXPORT_SYMBOL(prepare_to_wait_event);
 int do_wait_intr(wait_queue_head_t *wq, wait_queue_entry_t *wait)
 {
 	if (likely(list_empty(&wait->entry)))
-		__add_wait_queue_entry_tail(wq, wait);
+		__add_wait_queue(wq, wait);

 	set_current_state(TASK_INTERRUPTIBLE);
 	if (signal_pending(current))
@@ -352,7 +352,7 @@ EXPORT_SYMBOL(do_wait_intr);
 int do_wait_intr_irq(wait_queue_head_t *wq, wait_queue_entry_t *wait)
 {
 	if (likely(list_empty(&wait->entry)))
-		__add_wait_queue_entry_tail(wq, wait);
+		__add_wait_queue(wq, wait);

 	set_current_state(TASK_INTERRUPTIBLE);
 	if (signal_pending(current))
diff --git a/mm/filemap.c b/mm/filemap.c
index a1b2ca5b933c..126f5b9849f4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1293,7 +1293,7 @@ static inline int folio_wait_bit_common(struct
folio *folio, int bit_nr,
 	spin_lock_irq(&q->lock);
 	folio_set_waiters(folio);
 	if (!folio_trylock_flag(folio, bit_nr, wait))
-		__add_wait_queue_entry_tail(q, wait);
+		__add_wait_queue(q, wait);
 	spin_unlock_irq(&q->lock);

 	/*
@@ -1439,7 +1439,7 @@ void softleaf_entry_wait_on_locked(softleaf_t
entry, spinlock_t *ptl)
 	spin_lock_irq(&q->lock);
 	folio_set_waiters(folio);
 	if (!folio_trylock_flag(folio, PG_locked, wait))
-		__add_wait_queue_entry_tail(q, wait);
+		__add_wait_queue(q, wait);
 	spin_unlock_irq(&q->lock);

 	/*
@@ -1757,7 +1757,7 @@ static int __folio_lock_async(struct folio
*folio, struct wait_page_queue *wait)
 	wait->bit_nr = PG_locked;

 	spin_lock_irq(&q->lock);
-	__add_wait_queue_entry_tail(q, &wait->wait);
+	__add_wait_queue(q, &wait->wait);
 	folio_set_waiters(folio);
 	ret = !folio_trylock(folio);
 	/*
-- 
2.56.0.313.g975a75ca90
