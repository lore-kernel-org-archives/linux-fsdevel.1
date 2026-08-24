Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEA4307AB
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579729; cv=none; b=BnHveYNjfaYTQ76OkmVvZ88kZBAA0aJ2h+dov61YCs7wm3VpQ/eHgWxG5tOmCLttw5CkBHMccjANwv3uSeRv+ogMeGMw09MoxprwP8A1zAlr0Rmz2JAiYev/y4KUTKC+di6gJ2n34XqTMSZQ2zTPZC65KP2qgX7xXDaHKiv4fHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579729; c=relaxed/simple;
	bh=1pawnKHS5KFrhVDfUohuGCOCrDfc8Tr2JRyh3/rR6Ds=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HS+dbcs7zmpGHymPooaMbS5H4stBPx0NXhOhRwSJs0h/WmtuboDmNTok+T54u75/rvnEg1+D3QZU4ttnuys1+HyOTeN7Ysn+l2zeYL1NmOWZiwEbUSx/t+BLtZKM6m2gmqcrBpNR0Ckfuiakrd29HmJI8vWojU4ouXbPtZYVxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlMN4MUf; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlMN4MUf"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-836cde02992so42077907b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787579726; x=1788184526; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kV9CvWZgKJ3OzoIjmFQaCybgDiXpPYv7ZoBPddJ/7AM=;
        b=PlMN4MUfQ5D2mw3zw54NNsyU6D1AE/pj/NAap5TEvjl/8Il4WZgDO/o6tmzc3Cf0Ex
         GM3rmEJX8vEjCe7tJhBk6yw+1bcSO7NZwe4YEaknjFYwvkVlC1LGFGTtQ26xJYkc9VY6
         wmrPI7f7ng1vy3ryztuamFEyFdcVJM/ltTzEgqVvhxJLJCV5OEMXeaZRpxo7lL5O3Xc4
         iV1qRGn0ublc4Ls1wZ+iU5aryP/gtsSMkitbvn/qiUV9eGFCOPDCTTRD2ZQhFsvwPRGn
         Ei8NTeZb2pya9AODihemEt1u3ieDeQ6zuDO3TD6haLdtE5xxVVa0mOWNliJGgdy4xnr6
         mjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579726; x=1788184526;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kV9CvWZgKJ3OzoIjmFQaCybgDiXpPYv7ZoBPddJ/7AM=;
        b=Vsv43izvNByNPdLiG3YBhug+s2PnJ40BY4rtdZrYHI6jhIfTLFUOnoYmPsVdbhCLPz
         euiYXzcaMcnu9QH2mhmbK/WqKdy1AkSY7+kPX3TwMGeh6JnE1YM5dRzjhW+jXO/bQGTT
         qiyoYMf3HcpgKx9rQUQrcKBkwLHUPKKrCF/0G2BxCnO84SLYLRRvT3EJz1QUm4Dge4Qx
         HJ5hzMMuCM7VC66J7GOCx5EMx3alPnZEZP23h9Svuhuo/03zHz0LsBBNe6jg5ExGfsz+
         5KaqGD1d3BykE9pLJfISTL02NC2g5rjDidA1773Khym2oDHVIsK9G7XAmJCeEo2xKlFg
         sQ6g==
X-Forwarded-Encrypted: i=1; AHgh+RqVx/sqAiGZgU9tAYRRlUb3GzZqu2FcMcy4jBZa1PJlo05FLUYI8/ttdZeCGrGTHB/2DGpKcMUslUKzuHdk@vger.kernel.org
X-Gm-Message-State: AFuF++ndLXx6abGApVugO7Ny0FzAwua/I4FTJqZMDJDQ6fWpjoZ/qnzN
	j9vAG7xFt0Wrt9FPlenal3m/t+7d00pNo1hHo58gDKreimsO4FNzz39qNbLoFi48Rg==
X-Gm-Gg: AR+sD12Sx4nqRltbG8++nPRzZ0DONKS0jwHe4OmnyOUvgAjireb61Gl8wOGN2U8Gonb
	XkICgXsh1x8O62NOtnOw05aoW98T6TnmpCMVuHEwiLPyLnt5DbPQY+kTnMh8MzNc5izUb94/9tW
	Vl7kZI/CbXz5TQ5JwLh/wrC7l23gvk3mAtwdnveXE5ykqhWpS4l/mc4Lrnh/3XsEcgrb2wucfwQ
	wJixYJg2OzzmeT8bVd+lapJkXeNJZneO3iO9oNsZ46I5yXJljClWmTYssT0la2B+2RcUVAhKvEk
	iiSbCxQnqtYLHF9EaZI9dWCFL6L5NckZ6njIiIDfJ1KztuhLxzVhRnHldoP/eO7s6Rz/ruTTMMc
	S6UHjLRkMRb2X2thoZT9QAObrSjv7Zoc92YkxcnMo7RIY27Fwf7bFrXaQ7ElMAW+kEzBGx6Oc1I
	4DHc78sKcB39Dpb/iQkwKOS85AE+QGft+qqZz645oJMuKhkovE5yMrYbJKIn6NZcHzwX2NvvOZO
	ab5w5XqyvL/Qc8nL2rg6JqWW8169wAJ1wZj2sVJbo6V/950hRdiNNNhEJsV
X-Received: by 2002:a05:690c:e3e5:b0:844:7e98:fe01 with SMTP id 00721157ae682-849f18a8409mr92007567b3.5.1787579725434;
        Mon, 24 Aug 2026 06:55:25 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-853ff053a0esm3017297b3.0.2026.08.24.06.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:55:23 -0700 (PDT)
Date: Mon, 24 Aug 2026 06:55:18 -0700 (PDT)
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
    Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
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
Subject: [PATCH 02/25] mm/fbatch: allow folios_put_refs() to skip xa_is_value()
 entries
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <44c7773e-5806-d24a-83c9-f39b3a134138@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Let folios_put_refs() (hence folio_batch_release()) skip xa_is_value()
entries, and therefore remove unneeded folio_batch_remove_exceptionals().

It made some sense when introduced in 3.1 for shmem swap entries only,
but workingset shadows popularized exceptional entries in 3.15, and it's
silly for so many sites to be squashing exceptionals out of the fbatch,
merely to suit an inadequacy in folios_put_refs().

But remove exceptionals on leaving truncate_folio_batch_exceptionals(),
one of whose callers then passes the fbatch on to others less tolerant.

No longer essential to this series, since 7.2 commit 9669b87065a6
("mm/lruvec: preemptively free dead folios during lru_add drain")
allowed folios_put_refs() to skip NULLs; but still an improvement.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/folio_batch.h |  5 +----
 mm/folio.c                  | 25 ++++---------------------
 mm/shmem.c                  |  2 --
 mm/truncate.c               | 16 ++++++++++------
 4 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/include/linux/folio_batch.h b/include/linux/folio_batch.h
index b45946adc50b..e1cc8ae023f1 100644
--- a/include/linux/folio_batch.h
+++ b/include/linux/folio_batch.h
@@ -22,8 +22,7 @@ struct folio;
  * The folio_batch is used to amortise the cost of retrieving and
  * operating on a set of folios.  The order of folios in the batch may be
  * significant (eg delete_from_page_cache_batch()).  Some users of the
- * folio_batch store "exceptional" entries in it which can be removed
- * by calling folio_batch_remove_exceptionals().
+ * folio_batch store "exceptional" (xa_is_value) entries in it too.
  */
 struct folio_batch {
 	unsigned char nr;
@@ -100,6 +99,4 @@ static inline void folio_batch_release(struct folio_batch *fbatch)
 	if (folio_batch_count(fbatch))
 		__folio_batch_release(fbatch);
 }
-
-void folio_batch_remove_exceptionals(struct folio_batch *fbatch);
 #endif /* _LINUX_FOLIO_BATCH_H */
diff --git a/mm/folio.c b/mm/folio.c
index 62b96c9ce19e..b2bce6b77498 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -983,6 +983,10 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 		if (!folio)
 			continue;
 
+		/* Skip any "exceptional" (workingset or shmem swap) entry. */
+		if (xa_is_value(folio))
+			continue;
+
 		if (is_huge_zero_folio(folio))
 			continue;
 
@@ -1088,27 +1092,6 @@ void __folio_batch_release(struct folio_batch *fbatch)
 }
 EXPORT_SYMBOL(__folio_batch_release);
 
-/**
- * folio_batch_remove_exceptionals() - Prune non-folios from a batch.
- * @fbatch: The batch to prune
- *
- * find_get_entries() fills a batch with both folios and shadow/swap/DAX
- * entries.  This function prunes all the non-folio entries from @fbatch
- * without leaving holes, so that it can be passed on to folio-only batch
- * operations.
- */
-void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
-{
-	unsigned int i, j;
-
-	for (i = 0, j = 0; i < folio_batch_count(fbatch); i++) {
-		struct folio *folio = fbatch->folios[i];
-		if (!xa_is_value(folio))
-			fbatch->folios[j++] = folio;
-	}
-	fbatch->nr = j;
-}
-
 #ifdef CONFIG_MEMCG
 static void lruvec_reparent_lru(struct lruvec *child_lruvec,
 				struct lruvec *parent_lruvec,
diff --git a/mm/shmem.c b/mm/shmem.c
index 89a1495e55f7..3911721e1e55 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1156,7 +1156,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
 		}
-		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
@@ -1276,7 +1275,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 			}
 			folio_unlock(folio);
 		}
-		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 	}
 
diff --git a/mm/truncate.c b/mm/truncate.c
index b58ba940be47..4151f7a167e3 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -53,7 +53,7 @@ static void clear_shadow_entries(struct address_space *mapping,
 /*
  * Unconditionally remove exceptional entries. Usually called from truncate
  * path. Note that the folio_batch may be altered by this function by removing
- * exceptional entries similar to what folio_batch_remove_exceptionals() does.
+ * exceptional entries.
  * Please note that indices[] has entries in ascending order as guaranteed by
  * either find_get_entries() or find_lock_entries().
  */
@@ -95,7 +95,7 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 				dax_delete_mapping_entry(mapping, indices[i]);
 			}
 		}
-		goto out;
+		goto squash;
 	}
 
 	xas_set(&xas, indices[j]);
@@ -113,8 +113,14 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 	if (mapping_shrinkable(mapping))
 		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
-out:
-	folio_batch_remove_exceptionals(fbatch);
+
+squash:
+	for (i = j + 1; i < nr; i++) {
+		folio = fbatch->folios[i];
+		if (!xa_is_value(folio))
+			fbatch->folios[j++] = folio;
+	}
+	fbatch->nr = j;
 }
 
 /**
@@ -575,7 +581,6 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 		if (xa_has_values)
 			clear_shadow_entries(mapping, indices[0], indices[nr-1]);
 
-		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
@@ -732,7 +737,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 		if (xa_has_values)
 			clear_shadow_entries(mapping, indices[0], indices[nr-1]);
 
-		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
-- 
2.51.0

