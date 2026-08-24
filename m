Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973FC415F3B
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581257; cv=none; b=aAKvUC9y2oS+g2KJ41eI4TKzR6kr193q6dVuxg4PjKG5Lg5xzm1Nxpk53k1BzehMtZOD5wuP9YVDjo/gaL1rKEYKJEOE1/SXVFuiSwHb0GxlEpTMaxx4OBC6XWnTydcE+k+M9srUS0e/Lrtxqj+yz1sdFD50O1yV4mac8fg9v+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581257; c=relaxed/simple;
	bh=8h+Tl/oSzEl273fsifSd2ROQHSdSF1jGQXnUSkA/qlo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cuVh0wT6sPzvm8uKn7aQ/8Yi8siSd7boXIYz7p2pKZKNDccAI4lUAHPM1Brdc9AjDUwT3JvV6txyMMhMsL7hvIvi9qBTHUhq2cY5p2Kfzw5nu2xORQqpMu+GGgeI+iwTurMDmEY/sXKPi0eEuTTwTKN5w2r2bZ/O+qLUa4hFVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQKTzxBX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQKTzxBX"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836c590b61eso53158787b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787581254; x=1788186054; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRoTlYAeNn0iQ+Akcq71dtDJ5mRi19RmdUI1yCGlg3o=;
        b=MQKTzxBXRLyXVALWAMfieUw5HptWmyT/+uz5VhS6deH8nU8b1zOs+lAID3sfB/Skr6
         n7Ehyqp/XUEB8x17/4+qABrwy+TaxUsKEryBhMSWXfK9wC/7lUifEcxzyPVh2Hf1S4PW
         BXaasjoFX3mulB7nmbyzAF7O4JdQc0KEggUEsW6CD0QGHg2+jAOOja+a1FhEVuDhAK29
         5kM0EZNz99xCkBi0SC12k81e6vr6UrHjBMXlmCe+FqglI3I5zzIcJUKavJqb/DJpIEtn
         Fvh973ENETGWBjdfEVadgmYcJVw85XXs9QxysAdhG6d/BRg2vwmAwJmWgUUNq6lHm13c
         Ovcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581254; x=1788186054;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRoTlYAeNn0iQ+Akcq71dtDJ5mRi19RmdUI1yCGlg3o=;
        b=ou0+NLxPwgiKAgVwjdD8iTFTji7hVptDjotrPSZRtAq4k+ae8ElFOntnyMb0nW9qde
         Pv+xYR2F5R5jhVigxXeOoUuHPWrTObKE91TYTwKH/9gL6aQSd0npWFYi0fk+lCJI/Hdp
         4DwL8hfVz0OEARnFfM2PtDt3dilgDg6Xs97tokB2zwiayzic5CucHDAy11/2qEVfy/02
         W6ha8IBpx6o+pTvTIf0dqZQO8yUAEDRJcCGcq5lXYXXaotwNaiYcQem71tEI+fkFOIqm
         C2Lz4seeh1MiTSiyq/r7sjgtHTikWDpPqY+JDYqAfmh1vI7ttwlQjgrlQ+TO1xqpM3Hh
         Zptw==
X-Forwarded-Encrypted: i=1; AHgh+RpfHnDM2p4/SnEzA41EBAAMD53hPE3eAeBLsRFCDry9+L7OLo65WkQCcs9EE28DPrY6ezt+oeUYvMdUnPpK@vger.kernel.org
X-Gm-Message-State: AFuF++layoGx7VsoliUN1zusDTdD63w+W9OgCJZPnW5DtZ2INezvgeUB
	L4stdMeNXG3zdOQYkJ4XIWboAreHR3PY+oKe7vZaItfWxbZtOIwnP+KzuZYL/SRZ8w==
X-Gm-Gg: AR+sD13kAgLqKo+22LTvBvNO6THCrxdOPE/jIWLB747EcVdHLzxegby9prGrDNd/3GP
	Kkmno1t0c9CGH4D5hW7Cq2cU43McR9FEgCuNFiAWyqbiDYpMfWujpwAPgkOzM4a/CEje7706kVa
	anYhNtq5p7nyF26BLak60cnqIyaDr21xufPvW/ZHQAs6UUmebnp2Pk3qmjeEjHOSpyXQLTUAHTm
	Sj9YAeSh0oWsYeH03VfcvTMX1Mo/9jlGmFcej77Sm3NQPLr1eKBOUyPNT9SKkqu8YQU6s4A9noe
	eWIklAria34KMUKk5yv3186eN+UIS+5u2XYN+CtqH7UTjUX1OF0521I+ty4KwnGDlc+bCgRXE9p
	b7Zi6yd3Npz8m+UN9TM2jOmXoECxXfyU7ISSC1EMDemzFNaZNHeA0v5TNV+f5tvbgEPlNrefC2S
	d5VbTJ4vy3i7k7LTStGHK4zMJK9Vk1m2QT2h1fLoARFOdwPOp/rfq0CaU6MeeJsN5d5WEC62Q1C
	kaW/qRnzV+mRX0zEPzdnXcavQMLm5yt3g7q6XxXqFvp6VB8
X-Received: by 2002:a05:690c:e217:10b0:81e:a471:e8b2 with SMTP id 00721157ae682-84c95f4df1amr53178007b3.2.1787581253476;
        Mon, 24 Aug 2026 07:20:53 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cac3f525fsm33909927b3.44.2026.08.24.07.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:20:49 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:20:44 -0700 (PDT)
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
Subject: [PATCH 12/25] mm/fbatch: remove percpu_pvec_drained and
 folios_put()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <3599e5ac-b74f-87ad-ab65-78d24c148fd1@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Remove the percpu_pvec_drained field from folio_batch, and its only use
in __folio_batch_release(): remove that now pointless lru_add_drain().

Which leaves __folio_batch_release() as an exported name for folios_put()
which is itself just a wrapper for folios_put_refs(): mm/mlock.c and
mm/folio.c don't need such a wrapper, just say folios_put_refs(,NULL).

Or should folios_put() be the export? But __folio_batch_release() is what
drivers/gpu and net/sunrpc are using: don't change them in this series.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/folio_batch.h |  2 --
 include/linux/mm.h          | 18 ------------------
 mm/folio.c                  | 17 +++--------------
 mm/mlock.c                  |  2 +-
 4 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/include/linux/folio_batch.h b/include/linux/folio_batch.h
index e1cc8ae023f1..a3337f70e109 100644
--- a/include/linux/folio_batch.h
+++ b/include/linux/folio_batch.h
@@ -27,7 +27,6 @@ struct folio;
 struct folio_batch {
 	unsigned char nr;
 	unsigned char i;
-	bool percpu_pvec_drained;
 	struct folio *folios[FOLIO_BATCH_SIZE];
 };
 
@@ -41,7 +40,6 @@ static inline void folio_batch_init(struct folio_batch *fbatch)
 {
 	fbatch->nr = 0;
 	fbatch->i = 0;
-	fbatch->percpu_pvec_drained = false;
 }
 
 static inline void folio_batch_reinit(struct folio_batch *fbatch)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 87feaa5a2b78..a426f7351787 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2201,24 +2201,6 @@ typedef union {
 
 void release_pages(release_pages_arg, int nr);
 
-/**
- * folios_put - Decrement the reference count on an array of folios.
- * @folios: The folios.
- *
- * Like folio_put(), but for a batch of folios.  This is more efficient
- * than writing the loop yourself as it will optimise the locks which need
- * to be taken if the folios are freed.  The folios batch is returned
- * empty and ready to be reused for another batch; there is no need to
- * reinitialise it.
- *
- * Context: May be called in process or interrupt context, but not in NMI
- * context.  May be called while holding a spinlock.
- */
-static inline void folios_put(struct folio_batch *folios)
-{
-	folios_put_refs(folios, NULL);
-}
-
 static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
diff --git a/mm/folio.c b/mm/folio.c
index fa4cf9d7d51b..782b8245d213 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -159,7 +159,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 
 	if (lruvec)
 		lruvec_unlock_irqrestore(lruvec, flags);
-	folios_put(fbatch);
+	folios_put_refs(fbatch, NULL);
 }
 
 static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
@@ -1062,22 +1062,11 @@ void release_pages(release_pages_arg arg, int nr)
 EXPORT_SYMBOL(release_pages);
 
 /*
- * The folios which we're about to release may be in the deferred lru-addition
- * queues.  That would prevent them from really being freed right now.  That's
- * OK from a correctness point of view but is inefficient - those folios may be
- * cache-warm and we want to give them back to the page allocator ASAP.
- *
- * So __folio_batch_release() will drain those queues here.
- * folio_batch_move_lru() calls folios_put() directly to avoid
- * mutual recursion.
+ * This used to optimize with a drain before putting: no longer helpful.
  */
 void __folio_batch_release(struct folio_batch *fbatch)
 {
-	if (!fbatch->percpu_pvec_drained) {
-		lru_add_drain();
-		fbatch->percpu_pvec_drained = true;
-	}
-	folios_put(fbatch);
+	folios_put_refs(fbatch, NULL);
 }
 EXPORT_SYMBOL(__folio_batch_release);
 
diff --git a/mm/mlock.c b/mm/mlock.c
index 1050010bbe0b..97134eff6b56 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -191,7 +191,7 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 
 	if (lruvec)
 		lruvec_unlock_irq(lruvec);
-	folios_put(fbatch);
+	folios_put_refs(fbatch, NULL);
 }
 
 void mlock_drain_local(void)
-- 
2.51.0

