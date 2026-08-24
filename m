Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9C438034
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580854; cv=none; b=Kyae0ejQ0Qh30vqOOBgB4dyFDVIQBNcSZBwKmLuv5P7u/BmRVSRE3+gzf1WtH5SH3chISF1FRDZCjY+4gCKVsoh/zdmKCMGJ6zk4BTB3bg2K6CoTmKRWjTXb/jSr+maDiF4LdGPj4vQK6JYzAgvcm6YFKzVLduaU/nrxss7TcbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580854; c=relaxed/simple;
	bh=E+/Y8A6JoYUD95BeI1jel2LRvtmdEOwPn6AtXIpcyyU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tKz0vGNyBnPpFcISKh5h1KiUE9iNClSWfevYW+Th0gGgkaPkpggz281rJAEwO6fn7D0X+35CRcTGdrp64chZ2DmAIXIi14Nh+B26APRUVau/OMKFAREEZJTB/XKqPfpWQq7uKiXe04B160VNUFC77RZMnPvJkmR/tWI8dCtvGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jF6WGMsE; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jF6WGMsE"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-836c718715fso33184397b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787580851; x=1788185651; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aw7ugmpQOmjY2/CNCHaKDY6XRRUcvMaJ3u0iOskkTBo=;
        b=jF6WGMsE1yarx5eL7ZoBBJZqhOmbWjKW0yB9y4xpuJrG+VawwYsuCdByYBiDkV1wYj
         cSbsU1XJK60aytCEVs24D+ph919SyEjVZp6YMkm6hyK6U2nk6aozsG1FOMTT9iyYFcC/
         7lrTJYZCZHT4JVeUMEWTvdb7c8TXmUnCQkU/04354Il1xDzQNrxoHqxy5h1VYisROLaJ
         l8/ckLm6UfeDfVrmEZAHEyCjbpPwk9KdfmS27LDaux6ayGS9vLQE4eghXwx3eZGiRgFY
         /4aLL1YMerGmsp/B6O8hH/OS0QrrVrLHfbJGLBBfugp1pBqQzKl3tonA0h28LpFFgHvM
         2FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580851; x=1788185651;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aw7ugmpQOmjY2/CNCHaKDY6XRRUcvMaJ3u0iOskkTBo=;
        b=anFEXSnKCXSB7+3w9e8zGY/uNLTBPkXiWpDxo8UarVpSzy4JOrlr3MrpO7nmknLinR
         8oGqFPzEFGPam1gepuadGnlsGVHkOcvday3RmKHP4PSYu2KyfJdvVQuFWQnXK4NbGpmr
         bCbG3ge4tEA6MlzRFxwy0QGCrfrqgtubYZjlCftZ2WwZd5kc1Th6fi7Gx5+XaD/8bIHM
         /EWXO/8dEtEZIV7a8MYzDwT3+kHapK93pjeshxJlDmIh8xqGypJuIYcts93yXmnVmyaq
         ntKJmptogHFAqW8vGE/XQFzU36EZWdSe+zpkTacqcaRrw1qibawTp9QdSYANgB9ixDfU
         LLdQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAhEsIdc9yePpcrW/XZMhQA6zL4b2WvFf1l5DJAqhwOXO3BN86hm10szCLsrrzyduEklSO7jf1QmbnO8p9@vger.kernel.org
X-Gm-Message-State: AFuF++lnX/jZ2N2uBOgQ3AMmK/N5Qqyax3PPKYgBm0vLbyGYiy3qgNsb
	X3mti6He0nes+MBXnjZ6DjOcd3s5yMP/dCCCtfNup6j9nREtTvbBVlG8QdWH67zozA==
X-Gm-Gg: AR+sD10GkfVX43fnvVFp2ZWwQ+UiKLy/OTvQuTH5AtiorTv/s78mGDCZ7FXc7kwPSIt
	heDWvnjh2wLiYHTrQGhxviH9oq2Mc8G1Ux2t8THC+aqAPTPuGsvhfJs2zS0VXPeBtgu3tq5bphC
	ME+Oytpi8V6Q71F57enubUqArkOQlDUj1Fd4IPCm57T/t+U8tPj18sCrIWKfNdraQRVOCuVEF3q
	OJGoPG2wmPnRytf4qEytfZV7XOGg76b1r8ExmGDl4AJxcpKk1tg3AY+4J0Fr3A0KkaQI9IUXSx4
	SbQCWXbLfK5Ssz8DdSp+4qOLDsqmlw+sqS4QmITe2vQudzjDLJuNGGadhQmY38SfECU0XZ3zxS1
	7EVwfiXP7eFuk6NT/2+PyTSD+sG3l+xE+e+1TktXjVSuHrLfq8ThpvQ2KKKwUiggyNRh6izH0Ci
	BEdqeojXXRzg9EMm1w+ze2u/5HXaVoyY/DANd3ZOgk6tYd41caBvJ1r1y8Iftk0UJXZFZfBJjHT
	LuFwepNfjWMqC6YQ3M6RnJ6hiqoHuH8G1a2pbbre2nzKanR
X-Received: by 2002:a05:690c:e001:20b0:81d:bc5:4624 with SMTP id 00721157ae682-849f5df6e6amr76092477b3.25.1787580850776;
        Mon, 24 Aug 2026 07:14:10 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cac4ef4edsm34110127b3.45.2026.08.24.07.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:14:10 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:14:06 -0700 (PDT)
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
Subject: [PATCH 09/25] mm/fbatch: restore mlock+munlock batching, without
 extra ref
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <32d663fb-f192-e0e5-114e-8a92240fb0ac@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Update mlock_folio(), munlock_folio() and their fbatch callouts and
helpers, to do folio_try_get()s at batch processing time, instead of
holding a folio reference all the while in mlock_fbatch: as in folio.c.

But more interesting is the use of mod_mlock_count(), using try_cmpxchg()
to update folio->mlock_count safely when possible (now when on lru_add
fbatch as well as when unevictable). While __mlock_folio() is as hard to
think about as before, __munlock_folio() simpler because munlock_folio()
can adjust mlock_count itself without clear_lru() or lruvec lock, and so
do the folio_test_clear_mlocked() immediately for itself (without which
unevictable_pgs_cleared was likely to appear high, when it should be 0
or low to indicate good mlock health).

__munlock_folio() is safe for use even when the unreferenced folio has
been freed and reused. It appears that __mlock_folio() could affect a
folio which has been freed and reused, but only if it is reused as an
mlocked folio, in which case its mlock_count is spuriously incremented
(but usually a spurious munlock decrement will follow).  How grave is
this? If unevictable_pgs_cleared remains low, not so bad.

I've gone back and forth on whether to move mlock_fbatch and these
functions into mm/folio.c: for now they stay here in mm/mlock.c.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mlock.c | 147 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 61 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 53d754e82ba2..1050010bbe0b 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -58,6 +58,20 @@ EXPORT_SYMBOL(can_do_mlock);
  * indicate the unevictable state.
  */
 
+static long mod_mlock_count(struct folio *folio, long incdec)
+{
+	long mlock_count = READ_ONCE(folio->mlock_count);
+
+	while (mlock_count & MLOCK_COUNT_0) {
+		if (mlock_count + incdec < MLOCK_COUNT_0)
+			return MLOCK_COUNT_0;
+		if (try_cmpxchg(&folio->mlock_count, &mlock_count,
+				mlock_count + incdec))
+			return mlock_count + incdec;
+	}
+	return 0;
+}
+
 static struct lruvec *__mlock_folio(struct folio *folio, struct lruvec *lruvec)
 {
 	/* There is nothing more we can do while it's off LRU */
@@ -65,6 +79,7 @@ static struct lruvec *__mlock_folio(struct folio *folio, struct lruvec *lruvec)
 		return lruvec;
 
 	lruvec = folio_lruvec_relock_irq(folio, lruvec);
+	lruvec_del_folio(lruvec, folio);
 
 	if (unlikely(folio_evictable(folio))) {
 		/*
@@ -73,92 +88,82 @@ static struct lruvec *__mlock_folio(struct folio *folio, struct lruvec *lruvec)
 		 * folio be unevictable?  I'm not sure, but move it now if so.
 		 */
 		if (folio_test_unevictable(folio)) {
-			lruvec_del_folio(lruvec, folio);
 			folio_clear_unevictable(folio);
-			lruvec_add_folio(lruvec, folio);
-
 			__count_vm_events(UNEVICTABLE_PGRESCUED,
 					  folio_nr_pages(folio));
 		}
 		goto out;
 	}
 
+	/*
+	 * Something to keep in mind when studying the arithmetic here:
+	 * we only come to __mlock_folio() when mlock_folio() could not
+	 * mod_mlock_count() itself; but by the time this is processed,
+	 * the folio may have already been munlocked, or another mlock
+	 * already marked it as unevictable and so mod_mlock_countable.
+	 * And don't forget that a folio may be unevictable for reasons
+	 * other than mlocked (hence the folio_evictable() check above).
+	 */
+
 	if (folio_test_unevictable(folio)) {
 		if (folio_test_mlocked(folio))
-			folio->mlock_count += MLOCK_COUNT_1;
+			mod_mlock_count(folio, MLOCK_COUNT_1);
 		goto out;
 	}
 
-	lruvec_del_folio(lruvec, folio);
 	folio_clear_active(folio);
 	folio_set_unevictable(folio);
-	folio->mlock_count = MLOCK_COUNT_0;
-	if (folio_test_mlocked(folio))
-		folio->mlock_count += MLOCK_COUNT_1;
-	lruvec_add_folio(lruvec, folio);
 	__count_vm_events(UNEVICTABLE_PGCULLED, folio_nr_pages(folio));
+
+	if (!folio_test_mlocked(folio))
+		folio->mlock_count = MLOCK_COUNT_0;
+	else if (!mod_mlock_count(folio, MLOCK_COUNT_1))
+		folio->mlock_count = MLOCK_COUNT_0 + MLOCK_COUNT_1;
 out:
+	lruvec_add_folio(lruvec, folio);
 	folio_set_lru(folio);
 	return lruvec;
 }
 
 static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec)
 {
-	int nr_pages = folio_nr_pages(folio);
-	bool isolated = false;
+	long nr_pages = folio_nr_pages(folio);
 
-	if (!folio_test_clear_lru(folio))
-		goto munlock;
-
-	isolated = true;
-	lruvec = folio_lruvec_relock_irq(folio, lruvec);
-
-	if (folio_test_unevictable(folio)) {
-		/* Then mlock_count is maintained, but might undercount */
-		if (folio->mlock_count > MLOCK_COUNT_0)
-			folio->mlock_count -= MLOCK_COUNT_1;
-		if (folio->mlock_count > MLOCK_COUNT_0)
-			goto out;
-	}
-	/* else assume that was the last mlock: reclaim will fix it if not */
-
-munlock:
-	if (folio_test_clear_mlocked(folio)) {
-		__zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
-		if (isolated || !folio_test_unevictable(folio))
-			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
-		else
+	/* There is nothing more we can do while it's off LRU */
+	if (!folio_test_clear_lru(folio)) {
+		if (folio_test_unevictable(folio) && folio_evictable(folio))
 			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
+		/* But whoever puts it back on LRU should rescue it */
+		return lruvec;
 	}
 
-	/* folio_evictable() has to be checked *after* clearing Mlocked */
-	if (isolated && folio_test_unevictable(folio) && folio_evictable(folio)) {
-		lruvec_del_folio(lruvec, folio);
+	lruvec = folio_lruvec_relock_irq(folio, lruvec);
+	lruvec_del_folio(lruvec, folio);
+
+	if (folio_test_unevictable(folio) && folio_evictable(folio)) {
 		folio_clear_unevictable(folio);
-		lruvec_add_folio(lruvec, folio);
 		__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	}
-out:
-	if (isolated)
-		folio_set_lru(folio);
+
+	lruvec_add_folio(lruvec, folio);
+	folio_set_lru(folio);
 	return lruvec;
 }
 
 /*
- * Flags held in the low bits of a struct folio pointer on the mlock_fbatch.
+ * Flag held in the low bits of a struct folio pointer on the mlock_fbatch.
  */
-#define LRU_FOLIO 0x1
-static inline struct folio *mlock_lru(struct folio *folio)
+#define MLOCK_FLAG 0x1
+static inline struct folio *mlock_flagged(struct folio *folio)
 {
-	return (struct folio *)((unsigned long)folio + LRU_FOLIO);
+	return (struct folio *)((unsigned long)folio + MLOCK_FLAG);
 }
 
 /*
  * mlock_folio_batch() is derived from folio_batch_move_lru(): perhaps that can
  * make use of such folio pointer flags in future, but for now just keep it for
- * mlock.  We could use three separate folio batches instead, but one feels
- * better (munlocking a full folio batch does not need to drain mlocking folio
- * batches first).
+ * mlock.  We could use separate folio batches instead, but one feels better
+ * (munlocking a full folio batch does not need to drain mlocking batch first).
  */
 static void mlock_folio_batch(struct folio_batch *fbatch)
 {
@@ -169,10 +174,15 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		folio = fbatch->folios[i];
-		mlock = (unsigned long)folio & LRU_FOLIO;
+		mlock = (unsigned long)folio & MLOCK_FLAG;
 		folio = (struct folio *)((unsigned long)folio - mlock);
 		fbatch->folios[i] = folio;
 
+		if (!folio_try_get(folio)) {
+			fbatch->folios[i] = NULL;
+			continue;
+		}
+
 		if (mlock)
 			lruvec = __mlock_folio(folio, lruvec);
 		else
@@ -218,19 +228,25 @@ void mlock_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
 
-	local_lock(&mlock_fbatch.lock);
-	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
-
 	if (!folio_test_set_mlocked(folio)) {
-		int nr_pages = folio_nr_pages(folio);
+		long nr_pages = folio_nr_pages(folio);
 
 		zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
-		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
+		count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 	}
 
-	folio_get(folio);
-	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
-	    true || /* XXX Temporarily disable mlock batching */
+	/*
+	 * No more to do if mlock_count is maintained: either the folio
+	 * is on an lru_add fbatch, and will be moved to unevictable in
+	 * due course, or it's already counted as unevictable: no need
+	 * for an mlock_fbatch entry below.
+	 */
+	if (mod_mlock_count(folio, MLOCK_COUNT_1))
+		return;
+
+	local_lock(&mlock_fbatch.lock);
+	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
+	if (!folio_batch_add(fbatch, mlock_flagged(folio)) ||
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
@@ -244,15 +260,24 @@ void munlock_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
 
+	/*
+	 * No more to do if mlock_count is maintained and still raised.
+	 * But if mlock_count is unmaintained, we might need to queue an
+	 * munlock fbatch entry, just to cancel an undequeued mlock entry?
+	 */
+	if (mod_mlock_count(folio, -MLOCK_COUNT_1) > MLOCK_COUNT_0)
+		return;
+
+	if (folio_test_clear_mlocked(folio)) {
+		long nr_pages = folio_nr_pages(folio);
+
+		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
+		count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
+	}
+
 	local_lock(&mlock_fbatch.lock);
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
-	/*
-	 * folio_test_clear_mlocked(folio) must be left to __munlock_folio(),
-	 * which will check whether the folio is multiply mlocked.
-	 */
-	folio_get(folio);
 	if (!folio_batch_add(fbatch, folio) ||
-	    true || /* XXX Temporarily disable munlock batching */
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
-- 
2.51.0

