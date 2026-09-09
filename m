Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05B46F497
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948866; cv=none; b=ExHb3INm5m2dU/egBOKr3piUOPA8UVkzUrVrfOSnNgovRLKwtLbnSeuJwgNSu1wx7ZC6m3egQmCSMhAtm9AaCVB420PCZwwLotxz85Qh+abFMuDRgPSE9Q572bcS3kBkfWwnQmejomLRyArwBTUrLvmyP1hlww1u3z+79pv+JcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948866; c=relaxed/simple;
	bh=iYBl1TBcq8XbAN5lWXQ5xeG2cPfd6X78ZvXFz11jkXE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rQUmWBcji4NTLBDRgBCAGmS+O58s7vL200wQKipZ1MP7c5LFLZroCO52ml6rXkYJFsiuGqFRW1duu48babinXO8C2m12mZ0Z8qk+A3JvbxNi58lpy25j9LuzDKp2PHIVwjhxCHfY9OJouw7F1tgjE9bgRGyCVoAluso4XSUj8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRYPqwdZ; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRYPqwdZ"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67109e0aa0eso324989d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788948858; x=1789553658; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cx1TfB9GnW58nOxDn37ATPgkJR6erGAjBm2BqNqkY28=;
        b=PRYPqwdZUo/IB9RDXendGZtCja/iYJ1a6PM7GvuYIFcVs73+Aq2REekIyiRl7fjjAk
         LRp04gPqNFcbyURy/5NcHJapf/ediVuCV9FJ1gJom6LcsEPMy9CDFhkqZ8YDn8ZOT1Ha
         x4O5p+TtNQEe1tpXqurl4XGFaXkVfFZhpr/nW/5B/zHmkgqGY/bx0ycLpnRgdmH7gU0q
         KPRfakb0o+JxLzBDZeilT8v9QkXEYKrAImhMZJKQUmLO1sKS50VNsZuJAQNQ3jAtlJZF
         /hj5X3ycMERjXWMG5IKdk6DNw5Vm752upXAONuac2+tmtxbZxrS+V6RMe0RLe8rdCk66
         7aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948858; x=1789553658;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cx1TfB9GnW58nOxDn37ATPgkJR6erGAjBm2BqNqkY28=;
        b=LQYc8Je6vh76TO4mnHLm9CDRhV6nHaXEpD5WqFxjZxM2s9VLAZywg528YP2Y3bNlar
         tAvKV4LJFS86yq7lO2h+GiuM9PVKsBsPUzHGQs1D4tNQxPdmPPox4K/+4Bk2Tzr8N6fP
         5Iv1fQJNFmlvheLpDhyFelBaVeaCK16Jd1IpdNSBQrtxUeZBk4cGNw+GdTlYxxVEIqGD
         v97/8QnR5d9tkI6ElKGivndR2cD1j1oG8au/MLHxpRNsjz6yRE8SBxUIh3BXd34D3WTs
         jtvmwNpaB5/JX8+MngNaCRpGApTxN3ABl1WPnFunegYfYcuSmQ+P4E8jRhN4hmUpilpJ
         jODg==
X-Forwarded-Encrypted: i=1; AKwUvByIuMkqGeHlGLBP+vr85DVW4Dv33ympaJTUZjCUh5JC1ZxbqKpQ+JMAgriOor3wMj2rWpQxQmBkQiDXbEEc@vger.kernel.org
X-Gm-Message-State: AFuF++m5fu8y9nA2PRjNeXwdjLfFTRnvTH0j88FYJrTmYgCAgjES7rfa
	raWGPjzIIUzbhZ/3cHZLU443gbDiIYOn1jr0gOaD1SUR7N6ZPR4FChzr8a11RP6bJw==
X-Gm-Gg: AYBFou35kG/pGFtksdEFjS3lyBmrCOBt7XjWpebrFC9wbP/xez40gZaArYoplbFkZig
	XbMgtgPWqVref1VRUa8Dh6GMzGJq/pmxlP4S6Nurp2Mqp0uWqE/9OyVD1TwCypC9+AthJiDFZvJ
	zW5LCF0JLdGIvwX9aiAYnef0o9ivAD4ByrZw/pq/JjU1JK4CBO6uF+XKSwqN6sYZEDRXiI+ueyC
	UW7fBpucgUHWE9Qk5owKcbOB/7PI6t5UZoInZu/gEpJcGVUKhzoHtQGkBIWatvBg/PKtXgqsENX
	4DEbh8aYoi741L98n4SrO0Om9M51ynGxp2wIkqfY55AEUdVVFgHN8lEEIZbB+dLEveuoRaan5rz
	/ABv/8oV0Nqmkxgq+HUw6Prd6kDZ8SZyZOgWU/MoY9+vtZwfptevKBWJKOdJ9SUDCCRDkyO9ahY
	Ov8QxAxsU1hLWCC4n4574CRdXSwj+uevuKgFTjoUsYWLh0uEIE03s2Jfak7ezhjPbAplnKI0TcZ
	JIWP2oK4mhZS+yZiLFs7sZnren7/5h7SvvhmVmRmhKrw51JL2HDKqkHnF4=
X-Received: by 2002:a05:690e:4513:10b0:670:f6e8:1f8c with SMTP id 956f58d0204a3-670f6e87f07mr2998845d50.84.1788948857514;
        Wed, 09 Sep 2026 03:14:17 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8894sm12066216d50.1.2026.09.09.03.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:14:16 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:14:11 -0700 (PDT)
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
Subject: [PATCH v2 16/26] mm/fbatch: remove lru_cache_disable() from NUMA
 folio migration
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <bc903047-0dad-902d-5774-ecf73c6dd343@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Remove lru_cache_disable() from mbind(MOVE), migrate_pages and move_pages
syscall handling. They do not now benefit from lru_add_drain_all() first;
they gain little benefit from invalidating buffer head LRUs first, since
5.0 commit 80409c65e2c6 ("mm: migrate: make buffer_migrate_page_norefs()
actually succeed"); and it's a shame that (even without CAP_SYS_NICE)
they can prevent concurrent tasks from enjoying the use of those caches.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mempolicy.c | 7 -------
 mm/migrate.c   | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 79053ece02cd..f4d9b5580632 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1343,8 +1343,6 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	long err = 0;
 	nodemask_t tmp;
 
-	lru_cache_disable();
-
 	/*
 	 * Find a 'source' bit set in 'tmp' whose corresponding 'dest'
 	 * bit in 'to' is not also set in 'tmp'.  Clear the found 'source'
@@ -1425,7 +1423,6 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 			break;
 	}
 
-	lru_cache_enable();
 	if (err < 0)
 		return err;
 	return (nr_failed < INT_MAX) ? nr_failed : INT_MAX;
@@ -1530,8 +1527,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (!new)
 		flags |= MPOL_MF_DISCONTIG_OK;
 
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-		lru_cache_disable();
 	{
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
@@ -1626,8 +1621,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 		putback_movable_pages(&pagelist);
 mpol_out:
 	mpol_put(new);
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-		lru_cache_enable();
 	return err;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 364015cbef33..1d2085529cd0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2359,8 +2359,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	int start, i;
 	int err = 0, err1;
 
-	lru_cache_disable();
-
 	for (i = start = 0; i < nr_pages; i++) {
 		const void __user *p;
 		int node;
@@ -2439,7 +2437,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	if (err >= 0)
 		err = err1;
 out:
-	lru_cache_enable();
 	return err;
 }
 
-- 
2.51.0

