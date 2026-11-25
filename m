Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600881;
	b=J1oKD84xX+lvaJLoQ+pti28oFwCY7tb1clPNuaY2FuWlo3W6TI13wkFvXo85HCV2i1CV
	 x0fNSvKNkSw1UJPzbBzlqTHZzKgXEMbNoEsIY3wIdjSi+SfMSg2WloG6QfuVGBIKC8sa5
	 bcLu2lskxjwH80wEhaAVfOwpx6j09/Y1V6xbDs30LAOVOpMSXJzv6Z6Ou9DO9iHQj1jTG
	 aykEyYSe3sgkO0bXgUHOHKTXBtze06g2S2mIwCNWfFPvDI1QAEmehZLFA+rX9qSUhvpzK
	 ZFj3ukFYgh9Nwin6mCgYolRHY7Pfa1eGsWgWXwf/HjyXL1yOG98+uhHeLypXm0n5JXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=N9xyug7w8UPX5id/mH4z9jTfhNm5yOqqDRPZIS2Gdo4=;
	b=WXZ4wlbhruhg0jSnwNlVbbF8XhnnTwgr17ieMnegBka2owBQK57JmTLXtxaREUAZrX2c
	 zVUrClWdsDUqzZeKs13kkGrLwJf1wrxsGclOULb70yUbB28d4mzx6oJPV0NthRqQ/LEx8
	 iokjei4Jgn+59J6rFTs+BMBVat8b+mrFqt6ahJuylSZBNIFgbbjQGhKVfJajqpvqHX5Vo
	 6vMkFHiQh9mdCLsoNE9yGBm4C/EziDYrKZ4FL3nJcJoDPFxMJ6ilXM+9SJFkOq6p/+QGR
	 xb0a7tpQOh/8+252x3GrleFK9kqMgjFOJZp0+r9FoIg0Tvv8dz6eO705LpBKQEUp4Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQeLCtTz;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49508606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 10:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49508606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQeLCtTz
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so47760405e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 02:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795600880; x=1796205680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N9xyug7w8UPX5id/mH4z9jTfhNm5yOqqDRPZIS2Gdo4=;
        b=SQeLCtTz6SalKrynn6EgdpDNlZHZHfM5UmRiLMAZIF/Z4AP0hDEeM+8C8n4Rp9G572
         51KiqErXkHwKjAFZHb7OG7o4RtV0TKuYxhuwncXH3mt0Fz34NdKfU7kls0UjF3fpENZA
         6pFtK4zeBaDiE0I4I4/qEuAV0olgOvhrZVIjQHq83g7yOzTP0DDqIDgrg9xHW/JhnJMt
         pBBNJUoAoWyj7VwQYvq3KZ+wNQeGgCjmZXkJux4PN1a6mX7Lv0XSZFB3p84tWbUb4Qsn
         d130wwpowEi27e0FOhPZlIL2nP+FMZgna8ZtNJRJ0UDrEc5Pyu9XmQqkR9J2DjoWzyA7
         WCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600880; x=1796205680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N9xyug7w8UPX5id/mH4z9jTfhNm5yOqqDRPZIS2Gdo4=;
        b=zL4T70MkzXaryl171O6VYqxBvTl/EnpHa2DPr6SYXCpsZMp5BCgHJxWhrwqPgPe0Rm
         gbwIBW00eSSIONVy9+910bJYKVOkhTdkooTeGIAbwWP/1QlpoHpiDqF1F6RR17JrPhRi
         9IH9bD0Jgq6+VZuD3LldDonT3ACHXH6jUHUOvcDdjvajX+RXgmFOTWZdy7taafFKn/h1
         l/gN/x6Hmp5VbhWFSXbRKJP+/T5/NXjtaYAQ1/f/PiD+jDDPSM005uijJOJNY9HFY+ve
         vcGenwW5gaTDyP4HjeSAiIK+6f5NI/VrcrQi+EU30bwvzybmGzzSyjGw1n0LPkXE9/dQ
         3HTw==
X-Forwarded-Encrypted: i=1; AL+hErHtTpL1qG0/Za+bnt8AdSqtUoV9tWArQYCHBa86KJOX4d41vwP/ziZqaz9e5A2C+A3rTxMd1DEK9TRLR7WE@vger.kernel.org
X-Gm-Message-State: APuU4Z8NAM7JcZ9/gbMxV8LTYLCfy39orNw+Z6JeZXLdvtRRYcXtGRKX
	UlhX9NG76x5+fd5FfHBcCkDP8GZodwHljxetL/Yp9JjB9Y5+EW68myAW
X-Gm-Gg: AZFdTZcKh49ZZI8RGVm9oxDDoFwDsAXvgXKtY6Rq5ciqvcBO+3rVSmfSOtDdfPtX7Td
	PiEGVIYgWAEgGE5CTi6drh/j5kyK8OkHMnSclyW5pI7Suet9gsQ8ZMBmUVTQRmO+Fiu5tCDgVmf
	4A/wy1MNqMq6+3xCGobQYLG0/lNZ4IlAk25zrqumh6Bmums5pTxTCpqw33zIaVVL8AV6855RU91
	uIykYQ+ZoKcHwJ0n5+HiQWiDQomf3yHVUDY5u5KkInCYq4ipkDXLs86EiJNLxPHT6YW/rXxguqh
	26mGTZc/ouaE0c2wmMQj+du70+cQkY0cNXvFh5RvZE66kQtoqauLOmesi9F8d3pHwUsjKoDfsQq
	xV7bKu06aSloeBTPmp9wWfTre7BDSewHXrxmmcWQzxo+W9rQdsQT8EmcdPYxR65y+vVX12L0A4M
	ptoKzXKPnxdJZtiEaOkZND8jjUJrMfGTsa2YPgMqck/0sMbf1+7L5B++DM0vkvz/74OI15XY9Ux
	WW9A2dHdttd1zwIPSQfwnhHwzTKb3lDUzgmBFYOLOe+npYQ2X7fylMXF5rqq92N7VMshzIZ2XpA
	2/2gojdZc3jCLQ==
X-Received: by 2002:a05:600c:848d:b0:4a4:3a2d:15da with SMTP id 5b1f17b1804b1-4bb88812026mr328104725e9.15.1795600879563;
        Wed, 25 Nov 2026 02:01:19 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm423898125e9.9.2026.11.25.02.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:01:17 -0800 (PST)
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
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: [PATCH 4/4] mm/khugepaged: use NOFS while collapse_file() holds folio locks
Date: Wed, 25 Nov 2026 10:59:47 +0100
Message-ID: <20261125100058.15200-5-azpijr@gmail.com>
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

collapse_file() keeps the folios it collapses locked until it is done.
With those locks held, it calls filemap_release_folio() with GFP_KERNEL,
and for shmem it swaps folios in with the mapping gfp, which includes
__GFP_FS.

As when splitting folios, allocating with __GFP_FS while holding folio
locks can deadlock in direct reclaim or compaction, and __GFP_FS also
lets filemap_release_folio() wait on the filesystem.

Run the part that holds folio locks in a NOFS scope, as __folio_split()
does. The huge folio is still allocated before that.

Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 mm/khugepaged.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6d2431a20bc9..c3c733d3a32b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2302,6 +2302,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	enum scan_result result = SCAN_SUCCEED;
+	unsigned int nofs_flags;
 	int nr_none = 0;
 	bool do_readahead = false;
 	bool readahead_done = false;
@@ -2320,6 +2321,13 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		goto out;
 	new_pfn = folio_pfn(new_folio);
 
+	/*
+	 * We allocate while holding folio locks below, when swapping in shmem
+	 * folios and in filemap_release_folio(). Allocating with __GFP_FS
+	 * there can deadlock in reclaim or compaction.
+	 */
+	nofs_flags = memalloc_nofs_save();
+
 	mapping_set_update(&xas, mapping);
 
 retry:
@@ -2698,7 +2706,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		folio_put_refs(folio, 2 + folio_nr_pages(folio));
 	}
 
-	goto out;
+	goto out_nofs;
 
 rollback:
 	/* Something went wrong: roll back page cache changes */
@@ -2744,6 +2752,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	}
 out_put:
 	folio_put(new_folio);
+out_nofs:
+	memalloc_nofs_restore(nofs_flags);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
 	trace_mm_khugepaged_collapse_file(mm, new_pfn, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
-- 
2.56.1

