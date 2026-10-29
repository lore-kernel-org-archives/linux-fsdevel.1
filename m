Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313455;
	b=ZpDybum8egmJuFQ5bYCzdtEts2GOFPmz2KHjWH75SLfA1oicwzKypWmwXNY0tT+es3s9
	 AdLaG3COer55hOSXz4Gn09DlZC1sAVxm0QtChZpGfK10Oxdl+EXhOx+TV83lo6NCDQc0f
	 9K7LsEDCYeZ9fWbYfBQzk4O1NsatT7EXvgqjklUePhSORWHKXrmQxPEWm0EYrXluwp2Er
	 3fhdPOwG4y0747T1L3R1NSipVTMCMVMO2qRqGuj/V+pY3KG9uRbWE/N1JM7dQz4z7cuwb
	 FmYXMnuQSbcQ6TdWHXIqNg/ZNSNh/zIhdqbJCsOL1Tp/zxWXHTmxXNhY635z8cpBjkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
	b=bxd2sFDVaRXpX96OcoRdcmHMGZWCfGI31QH/MXmgvSbnJqdNSgsaGF1ysAHQP7zFRYCQ
	 iEcOcokhgwI6tLF8Sb7iSYQseBKkX+Y9FIgy/yH4IKsokhD3zi6ZcQZGr89nONXZ2XhDS
	 M8g3QCYM38wQJYTygQbmj9EZJLBz80jSFOi6Dqjef6lPxTbadFDPJusQBdiwkeIfM7V8o
	 PT/EHHT88wX/PB+M8iU2siLI0Hw/X3y9JJO/lzcwzhCjn+rgFBSvo2a4k4Lj81ahnwu9Q
	 sRttH/eigOuC7LCXeozVZWkZkJ6qJ3v1p78wY8posi9cW8iexMnSBm5X56ToiZSEjNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Dj8dQusc;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D012606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 22:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D012606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Dj8dQusc
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917a64f28d0so14978306d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793313453; x=1793918253; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
        b=Dj8dQuscI3pp1qYG8b6KcXsqNxRwgQE+IOWiM0vtUQjEIGh8IwfaD3RVp2Sq+NkZSs
         qHMoSLCbstd/15wF5Qxa2sDK2cDninOwTqsTFByb6LIZeWLpAf55M+HCw+VO3z1ZiSFz
         Z6Y4/NbXOjcmI5YX9a9L3/cxo+EMOJApGFo2tjQ4Jll0Em88E0c83dh9v9h6SXqNx/On
         2wHea5ofylJY3o3NA05JXNgsRQace0begultrDe7a7ROFS6WKgW3x6gh7nqOxJ4i7bJv
         /LExpfmEtFE9vVmiUbQF1EWeWQYpAQErRDpp4Wwd5p72d7ZyNPjiJeWH54OxSiUGzSXi
         GcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313453; x=1793918253;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
        b=RgE9Sgl/EXYZSMh08D8Q2UMIABUhC6qoNvJRmPhhB2o/J5T/3bJ8zxq4M7DiJb6cY+
         XJty3w0nV9cj4NNkuddKAU/UeFkHWbJ6vB3Vy3jRCNvvTQYJmGZZGc7X+ugecH3VsFpq
         o5ZbRLUENI2sJpkkAPXLmZ3sSOXvHVt2Ys34nRBaDTdxrnvq1wisWO48ZqNLTUBO0CIm
         t6OKnIAaZfQVo5OihSXdT9DuNZ0vEaFZO9CS46FbMJKg0GpTZGPsI+GMr9Gh39Z/s/Tn
         SwdhnWsNespIk2rxQC/MifWKSxnIgDeTJJWJY73DbfunxEI3mHZ3OZL9P9vrebOoK596
         s3wQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6IbRmOSaRj0YyFUsCN5+gqsnk0NQqlabq4wDyp0FlQBBsy/i8vKismgrAotN3bcpPmE0gnnTRc4vAgk01@vger.kernel.org
X-Gm-Message-State: AFq9FYJNY2eYqNXjOjqahI4gPjjS0rUGwkfM9FMDDRQJ7jG/kJijwrLi
	8WwaIxzdhwrTWVWn7N+GkYa9Ss1y/3pIFn+9Yr0bppQrKIEX3ROAoQF4VNUTDnhDI7U=
X-Gm-Gg: AYBFou1+EF5uOhlKJZwgzUBXjRkYFBPsC8keNCQW6+wjEsHdDFoTMoJ4AwRxJ5Ll+jF
	5UjdwE4MxGCJ8BSxOJYMAWZvo/pdqTyd1amFsTZ+ukUtrmAyCVYd0sWbNwUJCisrELkOIBUhtZ8
	z6ewc2kFaurYvXO2mD0lW12bZNchBcd0RPPrPkUR0ylLG6XS8dZqiiSguJGB9qOnf7ryHFyKnq7
	9RMf27oAoKTo5flkfeqJpcUXq8LP/fLKqghiiA+9yZZF4DkgDcHjs2cTB1an1h8W7UOYyLyfW+U
	UT4w3GI1r/BRQO7sM67Auou2vNYADP9z6vY6EPvOvZ0JxYNboZSX9hNDKHcLO/U2O39SLFTGkPu
	R2+OJ7E/G4iG2dFTKJw3ufOjBqVVLcpir/u4+onp9T3zupTshUh0m4Subr4UVF4ZQ4/lvM+0j7T
	xz4u7UUQAgXLW1PW78hMkoRccGAd+rwhTmZ103dy9t3OnbVu2thwk6tCL/rCWnTuBCerivmd4Qs
	Yg79Hy4fN+k4892Rml3dDRDZ23nFp6wVlUgUREQ4aXpS5at1BvW3iDUIlcOE99PVL1z1f3csL7h
	yWvL6WZXswdCHAhVFeXkqNEcVHMGXLK3EVYv/F9On840NjTNegyfHGPcjCDABQ7lrCKUtD/AIGu
	6xHGgG4s/RgY+uk6uHBjjlQ==
X-Received: by 2002:a05:6214:401e:b0:917:c073:1b98 with SMTP id 6a1803df08f44-91c90686fc8mr65881526d6.15.1793313453118;
        Thu, 29 Oct 2026 15:37:33 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca6855ea1sm646896d6.8.2026.10.29.15.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:37:32 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 13/47] mm/huge_memory: fix truncate racing with PMD
 zapping
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261029-fixes_core-v2-13-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-13-a64ce7f83abb@kernel.org>
Date: Thu, 29 Oct 2026 18:37:31 -0400
Message-Id: <179331345102.2127828.8211829708894165734.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 21:33 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
> If this was the last mapping, truncation can skip unmapping the folio
> and proceed without waiting for the PMD lock, racing with dirtying.
> 
> ifs_set_range_dirty() can oops if MADV_DONTNEED races with
> ftruncate() on XFS, when we get the folio set dirty after it was found
> to not be mapped anymore.
> 
> Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
> matching the PTE zap path. This keeps the folio mapped while updating
> its state, so truncation must wait for the page table lock.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comment and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

didn't have time to run tests, but this looks trivially correct.

Might be some backport ordering issues between this and commit 14.
Hard to say, didn't look into the history too deeply.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

