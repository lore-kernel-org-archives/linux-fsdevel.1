Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990FE488205
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948092; cv=none; b=WHxp6FmeSmF94xxEa4dVV0tTNiekGXYtM5HlTf9RJGiqsmMtakQe45PtvVRDOhZUpTbC84sfw4O2tJtJOVj3BR087WAqjIVPzEfnjT0APQibHd8A3DW9bHJcVKzSeH1Gtq+idSdu1+OzBD98WbqFXosVogzAMX0yfGcimfqt3vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948092; c=relaxed/simple;
	bh=XRPintYB66K90WWvosFbfNFMrCSstXNSaa8RFhDin48=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MBhz0Ha/2Etwo06+6Psw8rd6fjoh4t9X6ICKQ+v1/vR1z9+KiIaLySmkS5dd/X7BGRQD8rR1So8aC/0KO5CfpeqPrpXPE5d9AAWMFv2TFIcVVLbqU9dhBBLeNzzJ7Q8BTANU2OE5NPIP5V6BJIqLujj7PQfsAl1nqwv25hbqaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knKN5ddo; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knKN5ddo"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8565d77c277so73317117b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788948089; x=1789552889; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uNBljcBd5pVR40/qSQbRzR+DUQkxJ6419XWxuVBt6mg=;
        b=knKN5ddo70WoGAqNT1cXYO4RFeqwvEyrgjfzjOTWh0ZI7z0eldN3H9OZHWMzP8Acyc
         tkz5Nq+NpL9Cl5yMr8vTo0h9DtLwMvjbjnDgVE8UFTKEmvfFzDvpIlPVvcrimFFtQsEo
         9LMLjq2kA6FBn+PaMr1Wioy/GDYPYiJ+jn72tqftRAgcEk9VbaqC4hfgdzSPCARhEotX
         w4SSP7FiMBXRm2/0SbJmABzHUA1B8TZXd/3bFMQTALw7vLkROtUu6a2BAfQX7j4rcz1J
         dtvgs9uG01uy8plVKUXdLdoz0XvRykaSAj+NBOUpnmtxaC9UCWL3SAKZbwYtnXRJGMsw
         df8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948089; x=1789552889;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNBljcBd5pVR40/qSQbRzR+DUQkxJ6419XWxuVBt6mg=;
        b=OMtjApFX/HN51a52pLGFhgzWUNG/POTOItaNi9T4ItMF26ow37mxRIg2e/a0Qm0wK4
         Vbbd3QaW7FnobYcUVmyxKiBF+uZKWTKYxTOYhljnBt4F6YUrFtWc4mBDkVnVojjCli7i
         ihH6VTYpoW4CcTjesXuRlk83mNyWU27msyJ2kMBYLhJhYXrXvcEIqLYWDXzUbbWPQ2qQ
         dm80x7O52/zBwC6baYlBiPrM71z8LGM/BzMSCRUO+Ion7QTACtwHMGokBPfjBGf3qMQH
         FNAUI1Qag6k3wORmL/pEeIx0x5rXuu3PQYBaQNzN6jrL2bc4RNcc/HNLbv2qjv3HPOib
         G+bA==
X-Forwarded-Encrypted: i=1; AKwUvBy6onqsfBG76paw7meJEG6YXt0jodU4PThEI0EAig0J1FZMWiPkROl8rlqmG4ui0rq8weHhkznJT6l9bdnn@vger.kernel.org
X-Gm-Message-State: AFuF++kHm1Xk9WMP0ioPScBi6Qhz74AepUZpRs8cVnlmcBEqfayrt1/P
	Eowo05p6hTogfbriMeZzdHH1jV6TPx7ljoAiitZUc3BK09/cwT3k0rL6BuRmaRxbsQ==
X-Gm-Gg: AYBFou2p/fisyUI+mFrlsiWuJ9otAtNs2X4lLltoMHNqSkjndnekNCOg7YOayKH0wlz
	ySzJVmX2YvBXInGHk7ZRAjvZep8fLOZfHGS7smUztUFNXIWASaUcXIPQFDTaCn8zoBLnHJuaD2h
	vIdVzuvLVzZY10QqV43kTsmi89dD5fkHvtjI0FucijluRac3FYqgmOSm6FJCnVIBNJ88WMs4md/
	NLtMxh9klSIYExoWpVyB19m75iJ8mCXj7xL4fh0QpPMiROWMpVxTbtpxN+qYkBsvPMpOhyRxRsy
	wTf7llSbhiwdO98zKW3h8l4ZGbgvYs9WjSMcS/PFirVpR1APGF9qP376remJwo8aqTfTOp8YZJf
	Rch9DLl1yHV47AkfEHLWp9Nm9DXkSk8qV/4uL9jGzATsP4nfSqrd6FtmALuMlM66C8UtGSOR7t5
	+JeKpqVXMqG/ZxCviofBxvxTunQvtOOKtCgBemQXOYckz6k72pkC8QS1DN7z4gAsgYTkuEG810Z
	XFcnPlAdOCoy2IjHFd7dSTgjDK7Y4/KnRgcZ9Yf2ceGr+qjbR36JbzSfgQ=
X-Received: by 2002:a05:690c:88:b0:864:6f4d:ef7f with SMTP id 00721157ae682-87121acbbc5mr139590577b3.7.1788948088169;
        Wed, 09 Sep 2026 03:01:28 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714a0b654dsm107264887b3.25.2026.09.09.03.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:01:26 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:01:22 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
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
Subject: [PATCH v2 10/26] mm/fbatch: remove several uses of
 mlock_drain_local()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <9633684f-e5c4-d92b-8295-5cccaa18fc36@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
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
index d53e5443b802..3628b5bd1359 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3570,8 +3570,6 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	folio_remove_rmap_pmd(folio, pmd_page(orig_pmd), vma);
 	zap_deposited_table(mm, pmdp);
 	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
-	if (vma->vm_flags & VM_LOCKED)
-		mlock_drain_local();
 	folio_put(folio);
 
 	return true;
diff --git a/mm/migrate.c b/mm/migrate.c
index 15b45832bcfa..1939d6ed19c9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -447,8 +447,6 @@ static bool remove_migration_pte(struct folio *folio,
 				folio_add_file_rmap_pte(folio, new, vma);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		}
-		if (READ_ONCE(vma->vm_flags) & VM_LOCKED)
-			mlock_drain_local();
 
 		trace_remove_migration_pte(pvmw.address, pte_val(pte),
 					   compound_order(new));
diff --git a/mm/rmap.c b/mm/rmap.c
index d1819fd69938..1ee42d60d77d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2396,8 +2396,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 finish_unmap:
 		folio_remove_rmap_ptes(folio, page, nr_pages, vma);
-		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
 		folio_put_refs(folio, nr_pages);
 
 		/*
@@ -2771,8 +2769,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			hugetlb_remove_rmap(folio);
 		else
 			folio_remove_rmap_pte(folio, subpage, vma);
-		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
 		folio_put(folio);
 	}
 
-- 
2.51.0

