Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600873;
	b=EiZV9fnAdB4+1eAroyMxm53Wm2YzUCo/qWHbYJC63Np8oNGrEo42oqE09l5cuze2bIQg
	 qnRVT0d+YdBUTAfZTghArvOv25JtKiC2nQnGEmlI3mxPgcuxy04wMAEpAFvzzcgRbX0FQ
	 rBIbM1qxmR8jjIFQ9p57vUmYVpOlpAU+Fht9ItXpbzeEZ9f/7dMTNoju0YjDJRvi6KUye
	 QQKDioYwrmLJMYSTUCC3KIUbp/Rmb5b7AJ+69yXYp5cR8Gdnlyu3H3nj/cObG5GhvzrwP
	 TgkKEUZEFPvjsvkrPdHIfcl1TkluwzrXpmhrJXHiAfEn8xjKhnSlNkQiMCGvkr0BZ/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gIVwXBqoIbWsBwcLK9XzDcXEsdYI5cY24iYHrBHq0Cc=;
	b=o+6A29VLblAETF6N1tz90AAVr7fbTqfY1jioysJCeSHyvrAEKRWdblUg+erGvPj0X9mD
	 +K8dbF/7bqtlxii+FihdaNM0AfEoQkjQfmDmJeib93kOzQEpW+F9EuAgUzo1H6ZT7JFix
	 YU7J/kxlBRqSg/joRypBgA6ebDjyjfZlVTTJPN7lD0JgbNj9cTIUsgcW6nuir/Qw/SV6/
	 vSCv9oDo6dKnStZ5c7NXyU71h9KnaNzL+0kRf2mUwI43p47+46soBNXYkJJowuei1d+86
	 qKI6B9puMynf7HONmmCLAP+xCvQGlQhgkIz4IY0BdXnY28xBPKkoGqs1nVwBgJcnCzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zBmvbaG3;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3213606A323
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 10:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3213606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zBmvbaG3
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so51434115e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 02:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795600871; x=1796205671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gIVwXBqoIbWsBwcLK9XzDcXEsdYI5cY24iYHrBHq0Cc=;
        b=zBmvbaG3szHtUabaAe49M42Bq5WBsRLYqqevp++ZOyEhct1oM8O1qEe38Y+tekT+ei
         WsAuzw3p/vSPvl5n78uZYvnouBt4boT3mWSdinyHtp60gTm4p6WClwwdZpOwD1eXKMZQ
         a/gZThLf8xn0UQ3nq50mJwsBVaFNKm1lYWn+6X5LSshuk/yKklakqPYmCrL7kdqD9VGR
         E7AKnqjoQdYeO4OH8FfZVHVAXzl929rRImQdg73+C3nQQ1Fyv5Bm8pBPm6ZGZTTvnfI1
         zwHsKaYtrwvxdZO9cXsQFsxVanG0xjsMI1yaRaZiitIpnbuthE9Zd9TEnofJ2Yq1+KXi
         xl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600871; x=1796205671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gIVwXBqoIbWsBwcLK9XzDcXEsdYI5cY24iYHrBHq0Cc=;
        b=C5w4lv9MyjRQ1r3y56DIpT8F/ereGG5qcIwtB52GOgXASaAFIo7V9nmWHAAG7K+7s+
         M1fi/6VkGa52fLKtGaTDznFkVAprebAKOZIzWB1LXDGvnBtv/8N5RI5Iu74MHZt3ASDu
         Xnes43vjhjhZgEPohzAd0gncZqK41eLau7/l+uAUyp7D3rhOxJLYEsCn0R+t8MptDcPa
         QCUTUDeLqRjP0WV6LxEaFrJ2A2fU0jfwpFGmzxw0IEmFh+Mv0HP4n6KetJdNqumlvLHI
         JGAkpWAVJKbDAiSafnKfzn6fi0sxc0EI0qlqwg+bMsw2IdlHMD3w4bNs7PgU7f/uUJB7
         njBQ==
X-Forwarded-Encrypted: i=1; AL+hErFtg+yr1Jbw6SiWXiRBtHEmT36M+skbNpwTEDm7XySRaYSTKMBUFPdD/aYTIAnjYoaAk3AQzUjjoRqO4eQK@vger.kernel.org
X-Gm-Message-State: APuU4Z8yftFLViyPXKFr+xXyyDnwol0uw1Xyueitk380CmUF6SJ17/9W
	yCKy4jSn8K0sUFlqezM/wO2ruoJorAKrM9IsJjpDQ3u5o+z7TqIdDhP8
X-Gm-Gg: AZFdTZf0PjwNxCkIiBYURgUuuodUgukICU95L6niGIeYrehXznPB6NEtO2kyUiJzKZn
	vdasxYTylWbCF0PLryL/86hw1UkafRWuF5GtEwX/V/lbAe3z+2G8vS/P+18Fqv+4ieuATl6FRhQ
	7njxpgbMhK+gYtG1cNDO+Z0KmpoannujAZiEACkTtIiWksTwzq9SLOULeOQU7Jvv2BtHBDFmZDa
	OJRGve8F8ySrWmdsqxURzJLj0UvHc2ENyvQMsPxApxpv/e2kgR393dsj62ENvGrtOBYtFDu9eP9
	T+ucXhqnkxqqjB0er2Zf16ZaauEZQvq/q7nm0Ovza28fz47zVdQn+KnLtX2brMX+9atHa3Kx4nG
	7ja2xEkYazSQxGx2SIFq2mgBMDmgY8onQHwghIIvzvrmqv3p1jdyz9hfCzMHn8H69ewfCdFWdRY
	aOebMX3wgusMMllhOs2FoFx1wHi62zy8qyAVqJcp2Bb9DAMGgOT7uUbPcDVKpjbJp9veyAP0N7s
	OvsnGqvn/Wr+w431bfacQO6Z1oSu77x0lz9g9Fv5c6FsG3jPrz/LsHgmfowEejnv8zvSStn+Et/
	NDKK03Cz3jeL6Q==
X-Received: by 2002:a05:600c:34d0:b0:4bb:6a5a:7839 with SMTP id 5b1f17b1804b1-4bb889428eamr344330925e9.34.1795600870499;
        Wed, 25 Nov 2026 02:01:10 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm423898125e9.9.2026.11.25.02.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:01:10 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Rik van Riel <riel@surriel.com>,
	Song Liu <songliubraving@fb.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] mm/memory: don't allocate in finish_fault() with the folio locked
Date: Wed, 25 Nov 2026 10:59:45 +0100
Message-ID: <20261125100058.15200-3-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125100058.15200-1-azpijr@gmail.com>
References: <20261125100058.15200-1-azpijr@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__do_fault() preallocates a page table only when the PMD is empty, so
that finish_fault() does not have to allocate one with the folio locked.

Since retract_page_tables() no longer takes the mmap and VMA locks, the
page table can be removed while the fault waits in ->fault().
finish_fault() then finds an empty PMD without a preallocated table, and
calls pte_alloc() with the folio locked. On ppc64 with the hash MMU,
do_set_pmd() allocates the page table to deposit in the same case.

Allocating with __GFP_FS while holding a folio lock can deadlock in
reclaim, for example the memcg reclaim deadlock on cgroup v1 described
in commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock with
writeback").

Return VM_FAULT_NOPAGE instead, as we already do when
pte_offset_map_lock() fails. The retried fault preallocates the page
table before locking the folio.

Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
Cc: stable@vger.kernel.org
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 mm/memory.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 11cc4039b853..b7e53d7cf6e5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5986,16 +5986,21 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	}
 
 	if (pmd_none(*vmf->pmd)) {
+		/*
+		 * The page table was removed after __do_fault() found it, so
+		 * nothing was preallocated. Allocating with the folio locked
+		 * can deadlock in reclaim, so retry the fault instead.
+		 */
+		if (!vmf->prealloc_pte)
+			return VM_FAULT_NOPAGE;
+
 		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
 			ret = do_set_pmd(vmf, folio, page, /* may_alloc= */ true);
 			if (ret != VM_FAULT_FALLBACK)
 				return ret;
 		}
 
-		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
-			return VM_FAULT_OOM;
+		pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
 	}
 
 	nr_pages = folio_nr_pages(folio);
-- 
2.56.1

