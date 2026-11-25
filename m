Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600866;
	b=mKz9FD3idzB1SbHU0nsGFerVnAOKXoH12wxZmbK/cqbbf5vrBQQt+LdghLJ6LSg9BKrb
	 uEyGKWofRx3MbKgaepFv15zmaRtG4rDNHhDeQfDBSfadB0NLg5ecGUcStI3yGGMZvERp/
	 JWGCDQT59FHmxyTYE3LXzk7HxCT8XkMFh9rSPZUraXs9eDzBfG4079K0Ug86y4y2ql/q+
	 uh8JotBkqXfVN1PN84EBIPkLNY4DsXYDAziDu7Qa+8o/NiogoG1kuxRE0CXy1Y+cNt41s
	 3Oc0GK6vLktnfWd0Kqk6SPdKjVjoFyotZxVWOKgizJpYz6SwxqcX0xgU9YGJYBmhBmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gcuNzP7ETPGzPiCQU7jBlHgAed31Q6Dufg+3EtNCvfU=;
	b=WOPvZgW7xKBqSJ2qyPSzIZCFASmQ5CkD1LHXKR2ltzWG4Ml4z/i8HKTfD/E4pbOx07wg
	 2uJxPv7BTQ953qSpKQ+2fKGa1Gbo21XymrnYA5LWmjonc1FaF2o9dw9uS9s5dcfF7dWPu
	 pHAs/a0/TRHLtyywt1KiWn6YSk+AW8L6TEGrFBl5IW5vgL+sZmOTOQUaCDl+3z3ZJ67n9
	 sf/9uFo6NFWIBNbtMFfuh46z29WPyFbEezHqBT+cgiARPbxkSw7TQadu+V8Rsa4HhHYRu
	 FIj8AWEEVVOy/OeQ7xReTvmHEDz9T7D1C+gqB8UTfEeuBuIClLyJQ2ZXKkmet2iDApQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6rGNVYM;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860C606A32C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 10:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9860C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6rGNVYM
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso29932845e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 02:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795600864; x=1796205664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gcuNzP7ETPGzPiCQU7jBlHgAed31Q6Dufg+3EtNCvfU=;
        b=X6rGNVYMGVfQSI/esGbZr6ESPstyqBwi/l9j2JgNi5AXNO2Zp2879NTbvCq4a0PTVw
         Axbjj8e73PK+WB2h8HxuRExWEsYZLBpJOn0Jzb9IAgzK/++VKsn9ffyYYehNorjfebhc
         XBTrbQBurpOoSzk44m7yaP57ALkVZjxggisUHlLhs4CXl0ifGDV4laeSpYSt0u4cBPFn
         bLgFWu2uz3RqdGlbPydAZ1HGtkXCzs8RYg26WnE5seNpnUyXtfOzfRwMBqe2nuu+rN/d
         PXlxcRarUJI74qKsL43+PCaQYVqQk8fiPur4CLBABkyWSsGnFjPr5PX0w7cfbuRoD6oc
         lrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600864; x=1796205664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcuNzP7ETPGzPiCQU7jBlHgAed31Q6Dufg+3EtNCvfU=;
        b=TyRT7EmsyXNe0O6Dvks6VlgP2HfGj9lo/37zEO6hyL+m98XM8eeklZghEEjOojJ7IA
         buYVJs11sSUh0b1Lq8OmNybYMAaUPifobsC5eu+s2xWjn0f0P1GjheQMUu6o9iOPqLTM
         x9DDJQQw+LX4+QH2D80iJPe+snw5RBU/mL5HzZSASfqrsvsH8bee/aFDnOy731UNaYh6
         cyDjd1E0Qj+mje1g1ct3Hre+j8KLTfY9sdbbBkN9gYymPV2ThoUzqMi/1ne9c7SDHgR0
         AjZ+r87CVb5xqinigUj8Wz9CQw5wG7zpn3pqptCcNU/JHkaOdFpC9Q9EX/1d3blPpj3/
         6XNw==
X-Forwarded-Encrypted: i=1; AL+hErFr49ffInATeFqyQz6d80zpJg9/CCvZR3ct3oY4qLxIKAk7jXIId1WQTugEwx7xYzhd00WtYg2vr20XN0Qb@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ah4HWeEhVptsWVAhofkaKTknFzgM8XSVatyjBNqd+Ce+j0roY
	0yuciCO4gOzqmUWJ957gW/YMD2udZP3zy/AtTvorrk1i23+RJcMM7nby
X-Gm-Gg: AZFdTZdWZrAxuPQ5qdR2DLKVbSQGewE9hYMyR15oJ8tVQpgdDwzr4mgnRiRxpe2mIFy
	cQkYMC0EB/yUPamavbjiSujMx2oyKJTbTHnX5q1oXCl6eVJ0Gd6/RPCOU6JdRF7ZHzht4yJEqN9
	lAH89fbeeDBl2sAPBPmQjjWPdXlVtVVvhpEXMv4d3iSJLQ4RHuGXX26vTw6jeCTAC+PRjXbGiCP
	Wr81vEm2Dp118Q7ykmJmHnA0RZf75VHbWhMPjYzpKUZiQMC6mqfB18hFYBhdx04xsM/7DcAKDOq
	nfujcvoStrwVMtIXUc9lGhXv6wHhCf6SlesyLl3VwQOifXR+17VxVVkMbuWiQnoJBnoqLheWTL1
	CmFW7VjrJVqk+f9VxHKGNypLmHpopIFFIJLAXkPAqfSTsgbKE4PxHyoB1S+wSh28kHm/BsrJhI4
	B8WJDhRSbjotRqrafi5HJrNRjhxPFCt9uDepSXc004ZmeFwK2B0xNpLTX298GehDd6aTJcPNJHa
	Fg/pqK3yUbx3y2at67ey++DDTrGIlJ92Myqtk6Q3lBck3Xh8x7C5jCbtxySvld6BJFEWuUbjTBh
	BJQofpaOtJOi7qQ=
X-Received: by 2002:a05:600c:3484:b0:4a2:133:45e1 with SMTP id 5b1f17b1804b1-4bb88812f16mr355106115e9.24.1795600863477;
        Wed, 25 Nov 2026 02:01:03 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm423898125e9.9.2026.11.25.02.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:01:02 -0800 (PST)
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
Subject: [PATCH 0/4] mm: don't allocate page tables with the folio locked
Date: Wed, 25 Nov 2026 10:59:43 +0100
Message-ID: <20261125100058.15200-1-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.1
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

David asked for the remaining places that allocate with __GFP_FS while
holding a folio lock [1]. The fault path and khugepaged still allocate
page tables that way, and collapse_file() calls filemap_release_folio()
and swaps in shmem folios with folio locks held.

Patch 1 allocates the page tables khugepaged needs before locking the
folio.
Patch 2 makes finish_fault() retry the fault instead of allocating when
the page table went away after __do_fault() checked the PMD.
Patch 3 drops the allocation from do_set_pmd(), no caller needs it anymore.
Patch 4 runs the part of collapse_file() that holds folio locks in a NOFS
scope, like __folio_split().

I don't have a real deadlock for patch 4, it just does what [2] does for
splitting, so I left it without a stable tag.

Based on mm/core.git for-next, patch 3 needs the do_set_pmd() changes
there.

Tested on x86_64 and on ppc64le with the hash MMU in QEMU.

[1] https://lore.kernel.org/66e5f9e3-17d4-4635-8919-c67ed562f9f0@kernel.org
[2] https://lore.kernel.org/20261124-migrate_reclaim_deadlock-v2-1-03cc147e1e36@kernel.org

Jose A. Perez de Azpillaga (4):
  mm/khugepaged: allocate page tables before locking the folio
  mm/memory: don't allocate in finish_fault() with the folio locked
  mm/memory: never allocate a page table in do_set_pmd()
  mm/khugepaged: use NOFS while collapse_file() holds folio locks

 include/linux/mm.h |  3 +-
 mm/filemap.c       |  2 +-
 mm/khugepaged.c    | 91 ++++++++++++++++++++++++++++++++++------------
 mm/memory.c        | 39 ++++++++------------
 4 files changed, 85 insertions(+), 50 deletions(-)


base-commit: 98f6b507621822477db7ec7cef8519de0dd243c4
-- 
2.56.1

