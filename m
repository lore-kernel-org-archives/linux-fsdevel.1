Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125543BDDF
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582848; cv=none; b=I4LJZc12DJqv4nyqA02aOpA/9Brx6PaYOxlqcwWcfy8wMZMDy8gg8D9HjsDlatDcmKBmWLJDdi+m6A+H1eU10HmgrzFZFEOzHydQHV8t0D63pW7lL6T5KfrAGp5roEYSdVtKQMtIbSVqM1iBAzqsdACS71BUt//fR7DNcQBrSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582848; c=relaxed/simple;
	bh=ViLLHeiqDr9S1/zgmlJqAYe2z/6nKsf8TuVaGMbVWp8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A7/M4uHUvxGswhewbdVMtw+2uJlAJcY9B8GbDcZGZspNWbaZje/C6cvgNNEssUEEuArm8VMOzZZT96CPUjXuzg6BdjJCwYlAIfhmrUHfWxvbT9G2p1IOcheW4vEW6MR08S04gOSAjcIiDA9EIG3KAIJR8uKSUn3XRpsNc0T8wzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXRqW4k4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXRqW4k4"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-836cda225c1so49973987b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787582846; x=1788187646; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ep6UPzJTnZmCqVomVSsdJlCYmmRG8TZidgjUjwtvIo=;
        b=IXRqW4k4gjNZ80ocq9Ju35DAUIWrZXQcfcHFpB2FjAtLj9Aw33LlOE1SzdGhtppfre
         y039m+I9tBJa5u2pTQgciHMRW/2zjd5Sn4joMZ0xWm0KL1IaDk53g72L9g35lTUYel93
         dTq+32OrNc8d9DEsuszMkcjWy1bcprqvG7bjFgKeK8Lzog27omYCDaXjpcqwOdhamCDo
         F7r/uGFpIn27kt2PfJ/mCYRsTzIf7oCOw3DKjybmIzWcQ/TfP7Iw/0sQOhULvV2nYSsn
         dWodlHmIMZ5IIFUBxCX8VQm1OSCOrqn6CSxhEU/kF6QL2uhypqmjYK7OL1T5BjPtRsA1
         HM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582846; x=1788187646;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ep6UPzJTnZmCqVomVSsdJlCYmmRG8TZidgjUjwtvIo=;
        b=X7oTlEvXogQn0NI4C4wbXArs0cYXKu4C4Wn+Cc+XfO0R9iJARbdqHWFE8PfKjy79Zp
         LIJ06aSq735gxsqISe5PRNdglTWCv1lzQ/OZ9weXV5GeDYkwnLei4Q9qlclWqTYn0K1J
         OSjSUUqwB23t5eiQ0aVg1w+ULOOVKbg18zsf10nsGJhWnOexD9CbqzDb9gEZubH3qmvJ
         +IJW/q4xMtXP1ju2RwLMFgtm5K/9XiElhc45RC+KFgRfEwrv9/YbOqOSplQ8GHRttlv3
         vUzH63O6/E5y6m7f9vLaDzQkZEGvt3OzJiv/BgQULx3hw6DoA3ykaNRH6WcwoSUO23Iz
         kEMw==
X-Forwarded-Encrypted: i=1; AHgh+Roko9XcPSX9gV8fAEC6WnQ9TlUzp+wCWhA7uQ8Ga+SAtqjgaWkntKb+GNqSOJAdVAK6tAaR1L69Qc9dOiHu@vger.kernel.org
X-Gm-Message-State: AFuF++lVL14H1IiJyAOVaqU9da37eVta8yHmqQ3Xjfo5Bhd7V0Tq+zv9
	g+c5mdOmL883pjmHQZ0HEHD0XYtSlLPE3VnrXPwpz77VZ+XCgYim5c7AUbrKQJfjlg==
X-Gm-Gg: AR+sD128lgqSzcoej9HqVS7/dQWvpjDjKhCeDKTy2IsV/HGnIxac1ciHZaCV523YgIi
	rdV7HqEfYPPG846Jm9QW4Qqp6v6V6qpr7cjIanz2MI7KrwJg9EXyXyT7yAZaQkeAxHNCiD3Dxq1
	pm44pe7uNWe1g9nNZOZ6e/xM3OJJK3IhL+F0VMz0Vnocfi4T+WedBpu4ynrcj8e0q/xSrByTUF/
	b9fY/3APfppfo3WcmTUPj+ae+l6WpC2X710kHI/LnwaIhiFvXIu0I4uqbHxTsKM0JlLVq7pJd5I
	hbNOPuX2rnts92YvN0OdWLIDKjuGjceB3iMWI6Etxb4z4GFlSXzC0O+cXHAaQyux5zWHzAtUWY7
	u/OAOziAHTaGG/s489aSKgmhnrnqQoJCOVz9nUkNgj3jAHTouaoCkAxvHcKe0zIj4kj7mVkWE7e
	/22v/qFqcDMP7odRjzqQDDmPGK13nFlf2h+ssRcKpMplcJHZIkFbiifWLalL6/7bFQ9bgIQS4EC
	2gpHf93wHZClMZbE/8/Dy9QykaEE6wtRTU3Dr6zTichJb/z
X-Received: by 2002:a05:690c:e013:10b0:7fd:a7b6:8d87 with SMTP id 00721157ae682-849f5a102b1mr80844207b3.25.1787582845685;
        Mon, 24 Aug 2026 07:47:25 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84caabb9e88sm34369867b3.29.2026.08.24.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:47:24 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:47:20 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 23/25] fs,mm/fbatch: use invalidate_bh_lrus() not
 invalidate_bh_lrus_cpu()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <bcf84f86-66ff-39ef-10ce-eaa133404b50@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Whilst there can be a case for including an invalidate_bh_lrus_cpu() in
lru_add_drain_all()'s workqueued visits to remote CPUs, wouldn't it now
be a preferable cleanup to remove that alternative, and stick with the
smp_call_function_many_cond()-based invalidate_bh_lrus() throughout?

And fix the UP lru_add_drain_all() to include an invalidate_bh_lrus(),
which went missing when 5.15 commit 243418e3925d ("mm: fs: invalidate
bh_lrus for only cold path") took that out of lru_add_drain().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/buffer.c                 | 16 +---------------
 include/linux/buffer_head.h |  4 ----
 mm/folio.c                  | 25 ++++++-------------------
 3 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ed966fa73b1b..7d114e5b9c62 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1427,7 +1427,7 @@ static void invalidate_bh_lru(void *arg)
 	put_cpu_var(bh_lrus);
 }
 
-bool has_bh_in_lru(int cpu, void *dummy)
+static bool has_bh_in_lru(int cpu, void *dummy)
 {
 	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
 	int i;
@@ -1446,20 +1446,6 @@ void invalidate_bh_lrus(void)
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
-/*
- * It's called from workqueue context so we need a bh_lru_lock to close
- * the race with preemption/irq.
- */
-void invalidate_bh_lrus_cpu(void)
-{
-	struct bh_lru *b;
-
-	bh_lru_lock();
-	b = this_cpu_ptr(&bh_lrus);
-	__invalidate_bh_lrus(b);
-	bh_lru_unlock();
-}
-
 void folio_set_bh(struct buffer_head *bh, struct folio *folio,
 		  unsigned long offset)
 {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index fd2c7115c054..f19f9e80be8f 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -518,8 +518,6 @@ bool mmb_has_buffers(struct mapping_metadata_bhs *mmb);
 void mmb_invalidate(struct mapping_metadata_bhs *mmb);
 int mmb_sync(struct mapping_metadata_bhs *mmb);
 void invalidate_bh_lrus(void);
-void invalidate_bh_lrus_cpu(void);
-bool has_bh_in_lru(int cpu, void *dummy);
 extern int buffer_heads_over_limit;
 
 #else /* CONFIG_BUFFER_HEAD */
@@ -528,8 +526,6 @@ static inline void buffer_init(void) {}
 static inline bool try_to_free_buffers(struct folio *folio) { return true; }
 static inline int mmb_sync(struct mapping_metadata_bhs *mmb) { return 0; }
 static inline void invalidate_bh_lrus(void) {}
-static inline void invalidate_bh_lrus_cpu(void) {}
-static inline bool has_bh_in_lru(int cpu, void *dummy) { return false; }
 #define buffer_heads_over_limit 0
 
 #endif /* CONFIG_BUFFER_HEAD */
diff --git a/mm/folio.c b/mm/folio.c
index 782b8245d213..3212c7a58623 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -748,21 +748,6 @@ void lru_add_drain(void)
 	mlock_drain_local();
 }
 
-/*
- * It's called from per-cpu workqueue context in SMP case so
- * lru_add_drain_cpu and invalidate_bh_lrus_cpu should run on
- * the same cpu. It shouldn't be a problem in !SMP case since
- * the core is only one and the locks will disable preemption.
- */
-static void lru_add_and_bh_lrus_drain(void)
-{
-	local_lock(&cpu_fbatches.lock);
-	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&cpu_fbatches.lock);
-	invalidate_bh_lrus_cpu();
-	mlock_drain_local();
-}
-
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
 	local_lock(&cpu_fbatches.lock);
@@ -778,7 +763,7 @@ static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
 
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
-	lru_add_and_bh_lrus_drain();
+	lru_add_drain();
 }
 
 static bool cpu_needs_drain(unsigned int cpu)
@@ -791,8 +776,7 @@ static bool cpu_needs_drain(unsigned int cpu)
 			 folio_batch_count(&fbatches->lru_move_tail) ||
 			 folio_batch_count(&fbatches->lru_deactivate_file) ||
 			 folio_batch_count(&fbatches->lru_deactivate) ||
-			 need_mlock_drain(cpu)) ||
-		has_bh_in_lru(cpu, NULL);
+			 need_mlock_drain(cpu));
 }
 
 /*
@@ -891,6 +875,8 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 		}
 	}
 
+	invalidate_bh_lrus();
+
 	for_each_cpu(cpu, &has_work)
 		flush_work(&per_cpu(lru_add_drain_work, cpu));
 
@@ -906,6 +892,7 @@ void lru_add_drain_all(void)
 void lru_add_drain_all(void)
 {
 	lru_add_drain();
+	invalidate_bh_lrus();
 }
 #endif /* CONFIG_SMP */
 
@@ -939,7 +926,7 @@ void lru_cache_disable(void)
 #ifdef CONFIG_SMP
 	__lru_add_drain_all(true);
 #else
-	lru_add_and_bh_lrus_drain();
+	lru_add_drain_all();
 #endif
 }
 
-- 
2.51.0

