Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318083C3F5C
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197850; cv=none; b=sANWDtnXOCwsxz3luc0YL3CfcKEDkRK8EKmVmVqRfPrGu+qwmW6+hiqZkvSV9AC7lPYdNLT/J0pFjdurV1M0nlZTvUppVDvxaVIQvJkvfjpHq//pEmoiGW8ZUH1gym7SxBkhN98qXfO0CjLv8CTDwHPA/AfSgrIqcXXbooT6WT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197850; c=relaxed/simple;
	bh=LUJlYppbUBKfJ7aCkQqSHCPJwDtO96BDWmS7dxvVrkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5rBblwrBrGLEpik/35IL6FJuHIOp/veHkdoDyJOI387RiRVqPuJU4A9QaV9MkONQf8g01Uc2pHLTUAbAGGNTvsPgQzigXROrpC1ZQS2tiT3m4qb/2ZfeBeOMdi9613eax5d8SMwfYv7vTvukYDVrO3Pic6i/Og+s4Ej7ITXDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ING62pT4; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ING62pT4"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cc46c7so138082485a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790197843; x=1790802643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkKoYk37zs7WcKh+6sHfyUj3HAIw43ESyu1nLCkyq7Q=;
        b=ING62pT405vyCsMmsYdswLF/hwhXIVs/ODkuMGocZhfYIaWO9jbYUHM2pT74Rwq2ao
         bqEIv27ugRB6ROqIV3sP3cPe0/kesPgMOE2XCSwDWZKx0nckm9rD3T7v1st9+/cLqYgX
         blx/vN0uy8zlG+3nqES53o60f9T4Bh4AociL04dkmt/svWO6kCe3vorKS6Yn2CnQxeF1
         Q6vQA7wmMdPGtfigxYRxA8jlFmakvQHaq1yKS2VJ6h4O1nNYBJchClDcdf/LTc2W40wP
         mM6TTiKaSSnUKjJknrSBkev99PLs/SVeetiY+77bkiqnYREFRMfHuUa3oogjWYTiz5Uj
         pwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197843; x=1790802643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkKoYk37zs7WcKh+6sHfyUj3HAIw43ESyu1nLCkyq7Q=;
        b=sdzQDjeTMRh8RstYVnhh6xGw3Y6Txw06GIfXB9zS1ku88k3cM9am8taASCzUXvL0UI
         PJq6RxHOfkX74Fn1d57ItXovbvM5vUUiu/r1UEVKUeoXqezkDxwjACGKySesPrjAg56U
         eyngwB43uIYtUPlRFGRVySLye/4+8kgaH5Dghv6M4cQs8JAudlvsox5tOBzoD0foZ/4f
         /uqB4Tvu7n8SIL9XcYa8VshDjXyIYz0J+9pa7Ui/RBt7Kr5ycMM+2N2kyT4ydmygbkOK
         2Qh55K4BZSnUroQRX7/tDo5WQpYhrNjKLMuORStpcs1/0B133BXOVK2Y/7CUh0BrI6+B
         MTKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtCcX7sk+mmSj/bzU7yywqg3AlG69SeqY0/QVwDNpa/w6V3wt/HCXg9F1W82B0AY1t8fHb/FtGcj15lxXM@vger.kernel.org
X-Gm-Message-State: AFuF++lmVsVKEP/Gh1khwVlprfoZc74Hz+D3VBZ0/3rxZY+dv0Ckd0U1
	IBh0ReSJDXT8cczn9kt3tmkEpBZouiOvh6Y8Xo51g7BpWh4AhVyDGoXB8LAO9ttPtm52TabX/CE
	2Es6ND6w=
X-Gm-Gg: AYBFou1fLOI6m2xWoEJ4CyP+jNzDRbDJy6LLKEyXXXjoNlefB1c7dXGE1JziwSgcVQf
	GsO9bOZx3iukKvFy2ugkbN20NcItAyGM5XlqmcqSjZOokPxFsysSp9QRdascVzwiDQhZJvz5BuD
	Rinsiagq9inRQS2OpnbaSJwtoKED75NTVkvBarlD+SjrbIIckpDRA8pbTkg237ehqm+DGqZuFmG
	7v9ROCpBfwJdrqvpSVKxgEH0wCV7vDD9QBM7gx/5Fb38VU877nUmOhZnP65OuYcbgaTxR+B882Y
	C2xE7MkglBkeGnmlLG77QNv8UlD2PYeBcca85jA7dHhPubexBMQhG7x0usFrJbXCaNknUZRKSIm
	FduFOZ+p9IIKcp1iNDXJ7WghVtyrXUTHzfToIc/fhSsoK30TnUojVkragLbU7y5BAYVWhFsTlJ1
	GCwAZxB4HQ9O4D2AT7oeiZiVBgGgWBrR4LZS5Z1NR02QbB9xLui4z8TU3NCPJ0vQJUtEUM4nk7W
	626UbVvDljYEs1x1Qa8ArHm9n+VRr66p4cf9dTbaB3R7Teahl4BWe9lZODe
X-Received: by 2002:a05:620a:271a:b0:93b:d8b3:f9ca with SMTP id af79cd13be357-93c347d1b8emr57822685a.21.1790197843026;
        Wed, 23 Sep 2026 14:10:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485926esm305893085a.19.2026.09.23.14.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:10:42 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org
Subject: [RFC PATCH 0/6] mm: pass alloc_flags through folio, filemap, and bulk allocators
Date: Wed, 23 Sep 2026 17:10:34 -0400
Message-ID: <20260923211041.3127588-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The folio, filemap, and bulk allocation interfaces currently hard-code
ALLOC_DEFAULT before reaching the page allocator. Multiple MM series
need to select allocator behavior through these paths, so pulling these
changes out ahead helps both series avoid conflicts.

This six-patch series first separates allocator behavior flags from
the bulk allocator fast-path flags and shares their validation and
preparation. It then passes alloc_flags through the MM-internal folio,
NUMA policy, filemap, and bulk helpers.

The existing exported folio, node, filemap, and bulk interfaces remain
ALLOC_DEFAULT wrappers.

Non-task ALLOC_NOLOCK folio allocations bypass task mempolicy and
cpuset-spread selection because those paths are not safe in all
interrupt contexts.

Existing callers retain their current behavior.

The allocator changes were built for x86-64 with DEBUG_VM,
DEBUG_VM_PGFLAGS, DEBUG_PAGEALLOC, PAGE_OWNER, PAGE_TABLE_CHECK,
PROVE_LOCKING, DEBUG_ATOMIC_SLEEP, and memory allocation profiling enabled.

Testing under virtme-ng/QEMU used a four-CPU guest:

- test_vmalloc vm_map_ram passed 50/50 64-page batches and 100/100 one-page
  fallbacks.
- With page_owner=on, all 25 runs produced the expected partial batch because
  page owner deliberately uses the one-page fallback.
- The alloc_tag ioctl selftest passed 4/4 tests.
- The migration selftest passed 6/6 tests.
- The page-fragment smoke, aligned, and nonaligned tests passed 3/3.
- khugepaged -s 2 passed 22 non-swap tests. Its four swap-dependent tests
  reported failure because the guest had no swap configured.

No BUG, WARNING, lockdep, or atomic-sleep diagnostics were reported.

Cc: Vlastimil Babka <vbabka@kernel.org>

Brendan Jackman (3):
  mm/page_alloc: add an alloc_flags-aware folio allocator
  mm/mempolicy: plumb alloc_flags through folio allocation
  mm/filemap: plumb alloc_flags through folio allocation

Gregory Price (3):
  mm/page_alloc: clarify bulk allocator flag scope
  mm/page_alloc: refactor alloc_flags preparation
  mm/page_alloc: let the bulk allocator carry alloc_flags

 mm/filemap.c    |  45 ++++++++--
 mm/mempolicy.c  |  44 +++++++---
 mm/mempolicy.h  |  28 +++++++
 mm/page_alloc.c | 217 ++++++++++++++++++++++++++++--------------------
 mm/page_alloc.h |  10 +++
 5 files changed, 236 insertions(+), 108 deletions(-)
 create mode 100644 mm/mempolicy.h

-- 
2.55.0

