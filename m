Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE981E5B9F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580999; cv=none; b=mYCPYAUj+wQXRcPY017dibsHQ4XkStApRhBhGvJzxvLps8dfCBtpF/nT/F8N2xddSbxUkohe4R5rKJhy6GoVbvofZtcFFGCpUfNx4AicpXKG/Ry/FqghMNGQQYx68vYROKf0xrQ63iE9F0wKGi0mw/AralXeWg01PLHuKcg+gJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580999; c=relaxed/simple;
	bh=QniatQlrXg10kLiLZvm0JWLrvxMekaoyIeWxGsqqyx4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VZKS21yTYHgCQ8f8iJ1mrIj0UJlsTurSujS4oTpLUOlHDET/vPS9eKl26uePnzSVJ2phTnZGSIINN0HgTm4SsgCtOvhsADB2ZovI7HTCcgW1xHzUOojA3tzVOJ+wx49TLdL260Q4eXH+qQC4Bnt/YJVa6ai23QgH75HD56GSuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZdUIPxT; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZdUIPxT"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dbcb505578so40674657b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787580997; x=1788185797; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vRQTGUT/r/6sjQRYrNEkhtszeIpWm9eC3zYKRwiMzSE=;
        b=HZdUIPxTkwxFQa4RpZvCl6gyLZYQw97I5pgVbLbpwnIz9HUpD78bFxBcdtU2Ou7v/a
         inh9csPo7IuQeVlDn9VnkQe1hsxTf19J0cz3fYhQinK4rkS6aXHMi4GZo9co5DeM7lDU
         19HSW/qV/duNgmO3lz5+xtDnTR1t8WLBcAEklnG3q/ujAsJnhHuWRbIkgNF8njMbQ+kv
         /3N8u1a1otYGBD8t7LnYA2sYGWhDUJKE9poajleKk0YUgT8isZH5R8wZUR8KzxWglbGO
         dvDtg1S/Z75k/M/PZY922QTXl1FomDedf/vp57R8ltaKEz+Hadzi5SEuZmyP9MZePq//
         AEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580997; x=1788185797;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRQTGUT/r/6sjQRYrNEkhtszeIpWm9eC3zYKRwiMzSE=;
        b=YY9AY/TVMqct35NN541oXNLwsTJFU10ZNI3ckcNYpYe+LvE0w0rAM3A3zGSeRnV1Uo
         ODw/uKBUUdN8sqd7f/bxAPnQWLawxjxAeohqP47RjceZu41u/hnDCT9a+jZLQYcESuGy
         2sQenFQQO/eypvhCDhLdNdhZ+4fS8vyKRpA8CER+quV+QjHwWLh+nXDb4lPCAoL9BaVT
         KYNsL1Up4DLO43h8ResysQ4BvGfpk7JzWxxhwr9cXLM8+YMxcHEZAJLDOA2YyavaPmBX
         8tXuPZ80n4+F+cKY79UGdQ5uv9s7cO5fkAGnPAAcmYCWPcQchuA9Mv/THQQ9okqxrGvC
         us0A==
X-Forwarded-Encrypted: i=1; AHgh+RorGjPS9qsgkp4ps4hUv3LwAidR9ZvS6GMb4B0FIMyF4Ao1lhOYmhsKdEwOASdU7BrggY4s2UFefzrhnQa7@vger.kernel.org
X-Gm-Message-State: AFuF++nlJNwpCAfqHI9hIH4weezmdB0Qu/DK9rxFIP5MDAuBZ3uSX+SZ
	UEBRQXGS+lSSDjV2cR8Cf/G/aa8MSsBBUpNnphXjcL1flw7HpoiOqpPr5QJh2o2BxA==
X-Gm-Gg: AR+sD10vKja0yVenS1Eeg2MFzPMfoXnQbuFQtLukNQNQ1ncAN4A7bAGUMrO0K8JdVgO
	YF/RF/R1X576JGX9/qRJMMiyhIpTU7ltIVQSqm+E3fGrk5WkRpatKTudyyiu+LgTypdLKxoUJAl
	jjW1J+kUSNzHcWtpi8qaset83NNSQpkSY89WaaZz+wWZ+S4oE10/umK8Lx8dyX8CZLHy2iq9Qfd
	dYWEH53mYYRTKJyj/vR97w2Cq2Zqb45euT4ZmDoo4B7NGI0NY+/sSFAUhcKk+/v9fZ3srmjGtZ8
	2pUY7Ai29kIasVpr2e4Na7K0hZPUVugOCHDPnybL/hMu053SEg1PHoX4Vx63Pn+sYk7Moa8NmIh
	y7v9OHNSs5dhppz2/O1UP41HiysfUwixIfXM2rTgx/9gryGbddnCFPbHilJ3x5D8UD5WkghJLFW
	xRtN5yJtpS0MPYPZniSighTtZ68+0Ykl1n/nOv0B8O4ucBPFqoROGHaBBgNSPm7dyEu7RX/gRoV
	2Jg8WVcJAFhAaUW6D239Wiu+PIA8dI/xISATNyebUpAc2GN
X-Received: by 2002:a05:690c:568a:20b0:844:9f61:92d9 with SMTP id 00721157ae682-849f67acaa8mr75561237b3.17.1787580996861;
        Mon, 24 Aug 2026 07:16:36 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-851e1419e0bsm11879757b3.26.2026.08.24.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:16:35 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:16:30 -0700 (PDT)
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
Subject: [PATCH 10/25] mm/fbatch: remove several uses of
 mlock_drain_local()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <b0a8293a-3a4d-49ea-f902-e6a2a20e5da6@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Remove several uses of mlock_drain_local(): they were workarounds for
when that sequence of operations tended to leave folios in mlock_fbatch
with debilitating raised refcount (and no good if the task changed CPU).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/huge_memory.c | 2 --
 mm/migrate.c     | 2 --
 mm/rmap.c        | 4 ----
 3 files changed, 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c7bd99592195..df6bf69a066b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3568,8 +3568,6 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	folio_remove_rmap_pmd(folio, pmd_page(orig_pmd), vma);
 	zap_deposited_table(mm, pmdp);
 	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
-	if (vma->vm_flags & VM_LOCKED)
-		mlock_drain_local();
 	folio_put(folio);
 
 	return true;
diff --git a/mm/migrate.c b/mm/migrate.c
index 8aaafcea7bc1..6b71b2415d00 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -448,8 +448,6 @@ static bool remove_migration_pte(struct folio *folio,
 				folio_add_file_rmap_pte(folio, new, vma);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		}
-		if (READ_ONCE(vma->vm_flags) & VM_LOCKED)
-			mlock_drain_local();
 
 		trace_remove_migration_pte(pvmw.address, pte_val(pte),
 					   compound_order(new));
diff --git a/mm/rmap.c b/mm/rmap.c
index 1f72d279ba68..e76823ec4d5e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2390,8 +2390,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 finish_unmap:
 		folio_remove_rmap_ptes(folio, page, nr_pages, vma);
-		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
 		folio_put_refs(folio, nr_pages);
 
 		/*
@@ -2765,8 +2763,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			hugetlb_remove_rmap(folio);
 		else
 			folio_remove_rmap_pte(folio, subpage, vma);
-		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
 		folio_put(folio);
 	}
 
-- 
2.51.0

