Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072574;
	b=2HckLTxHlPgm+6VueitqIe6gaaSaJ2nGaupjFn5h5kzNbauIWq3ilhVw5gPMYHQVf/Z8
	 EZWMwh6YzpFCuZVVXG7iC9PxABPMtuPEKk1w5hLfKT5fgeSSpwCQuFspyVF2bOtPBsrxH
	 WcP7vpePvAwqq6WDptBd0dloKODQxHDvc/1jYgTg0RtlYbis+JUlmN/ekRiCwJykY1994
	 BcY83gZJPoUia/tRQOevQonh3r7wemsbZvcjaTVe0T/Cm9IjA+i2bok//oWEMMnqncpGr
	 CccvvwyQtEIg9/QWPD0+NXuE1UJXtVDgOquYU/KlkfkPoFlkhU8PcwIWou2ObSSHKuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
	b=Oezxq7YfK50ACnXL1xtxCVxaY1FmAtmQAlyk82H+PNHDgAGZ0HzVNOPAoLrDHIt651HK
	 +6xYmXP+0Tb2Uqm5iW3WVqTcrIXFGzzDZICldBaLcKzoKJTLgBnOM2kuOkpzcklp0wjaF
	 r27RSCE4FpofZMWaoMMZqXz6b0AWPaHU6uoCK5zwWcssGVfX+fGRjoU3UQ7bBkpJF3gNe
	 z3i4hzIKVhMrOhzSEMNUblfhvteyuy2KkNqgqGgl1GMQyVG2G79TYodtAhj7v3bsgjJ3C
	 jKziSXCld1+9aKg4yHDfvj4RpkHQMwIUHOg7bHeR6oK5HPe5tr3PLQlEWjohHYGcg/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TP6Wb0G9;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B9606A329
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 03:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C25B9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TP6Wb0G9
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4682977f9aso427190966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 20:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072572; x=1793677372; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
        b=TP6Wb0G9zLDqWuDXb4AhwPpwuHlSKdtp7vOXpYDf7eGm1a80xAQ1Kk7a3BAwdBSgbf
         7jIsPCCAndPaIyaXMt1h9L+v3YN04he2Yn/CRRvHVdHgoUlgLlSgwa9hE7a1amSX74cH
         Kwjdvwabbe16pgNJqcLstwt0irlt7+SuIDQSlFjPA8tQknv+O8lFGJzh6gB7RDu1kMgs
         b7Ioo0qZ28U44QqcJ5fTkQnZXkb4QTONZ/A3yzR+1a7MYD/SYCY6zoTd6EcwzJuhItLH
         0B0L6IlHYe4/Vnwr07ZM2/roJJBr1DR/QdSECM7/FpaBVLw/yoke4fT7pykNvEVAzfsJ
         pBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072572; x=1793677372;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
        b=HjneAe7qqqR5D/pounkHwUQU8naManN8q3r2Gxv2JI7tLNMXcVv24vEAR9ZKm0SkHv
         X9SEFvnfpVbdm0yDehKFmPuC1fqVyRrEbQgE6jXNTWOJKT7l8O5MMCJroaqDyzADPOip
         +3PTCYD65wKO2bwwuXRfc4ACkUgNXF88zUzwrFjrm78b4RIh1/sI2hMeuh0PR1UQpREN
         V17nv3lVwSq+f+OUXatKX1dsz9tRHFTl724KdPl7ES/5E5r66dFZo8Bwxjy5L2m6cqmk
         dFPMVst5a3cbyV/lJhMv+IM297nDlgvItsZFehILgAilKvLYYhMfW3OJ2kchnf/hZ4gT
         V+Ug==
X-Forwarded-Encrypted: i=1; AKwUvBzHCyVkrHbCQJ2GdnprwSkmXNlrbxTcX3w2us6kgvk9nbtbmsUUVKY3AvNPHgFykaZvhAB8QdvRo74hXOZO@vger.kernel.org
X-Gm-Message-State: AFq9FYL9XnmSSQEmMPUINk5AVqDlJ6vgHOwfwhjENzXt4BdkZ36C8KXj
	ZyWGPTZ+ayAi1BmfPW62sPYOCpVsOJ1QOB3XES9ozKO7xwB21oQPk+Xg5cW16GwjZBU=
X-Gm-Gg: AYBFou3TdI26frvssrANv/UgWQRmxZPPkF48NogEYQviQ5K34+YDDpw4SxYuZJEOITV
	MKkPO3Uf9s2nlDjzJlysmCQfgKlxhPTdzPbIyZUIcwMs65SDSkNWJYBS1vP5CBfapE6UU1DdIvi
	zv2E2N9Q92ejkTikCLwBAGu/rd3M6p593tAA2HNjsCu1JcWsc2ukCZHBRMjL2mhJv2f154OIl4t
	uNRHBlfr0b+350lqEHVgUIJO7wdmfplK6uIpzX0H+ApTQLMung0V6jGSVqwn81ZDZVBe1HYqBVV
	qk2LzgciY/6Y1L3RoaW0mIbVANBol3d7Xgn6j6XJui0B+KHb7iKNOiIRm91koef1DNqHKI42Ki6
	pWfSTT2RF9BJq4LFPMrWCOItIX2Q2e+Kp9D1gjnGbVVZGvUkaL2Pp/WwUW5nQu00kgQ0UX2owHy
	am+irfcNeOhhBIyv0wpOSOwdnTewIgP4TzCzgVXMdXmgX6FQETd1fbrh4JlSUChwP7Nrn9m0XsM
	FaNP79DnLbcFeOhvGuN1myXGbOQRfpXHxkz1ISgog6wT+nb2JL5z873By1fPtHVbc2P
X-Received: by 2002:a17:907:96a4:b0:c42:102f:15d7 with SMTP id a640c23a62f3a-c46bdbf000fmr901757066b.10.1793072572116;
        Mon, 26 Oct 2026 20:42:52 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4a::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649997sm382056866b.42.2026.10.26.20.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:42:50 -0700 (PDT)
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
Subject: Re: [PATCH 28/46] mm/mmu_notifier: set ->mm only after mmgrab()
From: Gregory Price <gourry@gourry.net>
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
In-Reply-To: <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:42:49 -0700
Message-Id: <179307256988.1171062.17835586018092384558.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> Radeon uses a non-NULL notifier->mm to decide whether to call
> mmu_interval_notifier_remove() when freeing a buffer object.
> __mmu_interval_notifier_insert() sets ->mm before validating the range,
> so a wrapping userptr range can leave ->mm set after insertion fails.
> Cleanup then tries to remove an unregistered notifier for which no mm
> reference was acquired.
> 
> Set ->mm only after mmgrab(), once insertion can no longer fail. While
> we could fix radeon's code instead, setting ->mm on success only makes
> the code more robust.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 3506ff69c3ec ("drm/radeon: use mmu_interval_notifier_insert")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price <gourry@gourry.net>
