Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413195;
	b=qd5Zngnq8uYQU8EPcR5KFKxGI+IdKaxKiVu6jZuyDfeVYB6bFv9r4/1/1JWODeL++EJ5
	 pXtb6l2XL7Qt7hWKquCW6eTgM/wWYU88lB/lC8SlYn88oBzGZstmtEJ8HaLlo2Z9CCWJL
	 aw3FbxKsJWouPloFTDtE9lhlL6fObcwuZ6r5gNxeS00SADx2/z2UNgpbGRM06YkCG7JWN
	 H2qm6P/meVevA4RdvoNRaMWS+x+6LFkGFX4wXm4bb9EVKgK4GCFJOTe5HjYxlwZtD28Xz
	 pVfudnt7yH8Q+Zgr/Bvho75i5eVST/jf/nASzFg0aTB1v1u3/xA2FJMtS+5NEYzm3rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=eQLd8QgogrHpSVXIhi24k1QGI+Nh03QUKUs1yU2g3aM=;
	b=Z5H4pBO1SMyoEeRsnoT1bPA6tkt6HaxufYbnh3VwvHez5akeXQ0dbRLyYvKqu++udLCe
	 YQqtlAH1B7BKfAVKuf07nv8h97DIIB+AkG6bw37LZyR35A5SsPN9QESano1zqfT++RGf/
	 M6yGZ0Sx5RcrXPoCgwgqgqy0R5KyCMLLN+leBjUvodr8eoVdms7R0iDPlBY6YEHzcw3CB
	 NcgaE2o0Lleyf3I/ShJ7KV3QpuIU4nWHYAZu+a0xx4TkSTJX67FBoUb9tLHTiT2kQwfr2
	 JC/hy9cSqbbNu+YFt3nCzK/GDd2/5XOpUVMBWsAT38ONzxYamo/6M0U9GOUVjH7bL9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=kegsq8uh;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44837606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 05:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44837606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=kegsq8uh
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b3402105b9so19013347b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 21:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795413193; x=1796017993; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eQLd8QgogrHpSVXIhi24k1QGI+Nh03QUKUs1yU2g3aM=;
        b=kegsq8uhmtxjR/pJOhtAujkXAVHKSFRBNZ5lrlH8efJHm2VcBfXxdujDKKMzi5Mipr
         SfZAkGi5sRSP+SBD+2v7+dgCYbevza04Rs72gGs6ihAO9KvLXlkEoHv3/sb+u215IWoK
         T4VxePiP3BCDMF9LUIJVizvgJEpFQ3Q5wjM0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795413193; x=1796017993;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQLd8QgogrHpSVXIhi24k1QGI+Nh03QUKUs1yU2g3aM=;
        b=TRE6K54GyS7HGIFv7RSeQZv06fat3SKGBFR/KG/f9miXplfeF3DMmgRULAp/+j5hZA
         ImbjzQszdoXjwO9JEsOZ6lF+0+SiDreeH2DvPp2d4wVxAdf4R9um5tcVGXLn5ky5ph5P
         E6TslVERCruyXwSHLKZ0XtXvbWNFSui2ITsbXoEer2RYMlOQtGhWVXzj6/mcruLFOZAm
         oCLiIcT/D0rfALb0fvtxxp2dRd6aLQc2Gh+hZ+wQ6gXxXbq2Dc/1qIXDsvsRDd1vAC8P
         hVJtulUpfWzYwY6hJ7Pc9JCPUMnpslrjC7p/Pu2lFNLwhOicC5d2p1lIVNZ6zNe6H6tb
         seiw==
X-Forwarded-Encrypted: i=1; AL+hErFJASObWznnpt7JILb+SZ7kURsgpRs2D4lo0ZRfbTLKu1FnWKsRrCOSgpg/lg7xGo8lmtTmRMrAQ+1Fv4eP@vger.kernel.org
X-Gm-Message-State: APuU4Z9zMP11WxF1oeajx2YGPRjEeBm3ZULIjpJpkvA8RzVnPy5Fj85V
	SavbWEuh+DwmEHxZ+GWJD2ilvvNuFJZXWC83sYD8HX+VreuraJ4CodUOkYneeF1opMA=
X-Gm-Gg: AZFdTZe8w0eRO+3ir5mI/EabJDRVB6gzb7QhxGJ2ZpXvExQYCIgJLHEt1QlsCJSAy2i
	7kuG7N/eZ1Y4ZRTTWVvVQyqYsoJMa1FyRdLs1lakjiesl+2sv87YcXwGZMyr3UesgLRH23gh+7r
	vanPoO7GwfR+bKCtmU20FuDDyWJCWslKJMv0GMdDM82Ra+8NQr70vSTYAF7Amhon9ZLGrLX/tPU
	ch5AbeBIy7Vqw87bJU6GUe+CTRSIN5VZOf/lSXoiockO72uBp4SVtHFU1YzYLpjfbf/W5bsz5xy
	2BacKDprEl7tUoXihIfVQGHTZRM5pvx7rB3LaDgl+MwEAYt40VorK7Ujh9LJdYeUJKyoQ4m2p+1
	WHtHcnfqpeQNmzn/VwzlUpIiXnZmZrKTMOJT6Fo0++bIjyzoCi2qYs8e0a6GIacSk6iSUtvcPLe
	rjYogzRKBV9L5axnq2CgFFxdrnfgKNmfQ2FIpxKjkvoR8D19cTVA+k1aY95sIuxgmffZrTOro63
	0V3KEwB1BguqX+5LHFUrgnS2qXf1hIbWEcP6DYWBJRjmZoA3JrNfYtZpxhYVp23SuAx2r3jzVyc
	9S4JQGfViDDV8h7kUq18Lo4N3B46cYDW1nAIVoNQZGpXNagnlqeTczTKlBGKObSw1a21AIhMrms
	7JSpydpt3hBZkl8BIX88PN7dNYaAUc/pSGyOfRzXraa9rVNQhDW64gPHTm0kvPjjBOMjguVBtFX
	9Ztet9QsDIhgy4RhAMhRuuosmOSOyTZUw7zOakGRjsHMwu6zLUiVNrQ5/AcxOLMD8uU0zkF8sLt
	CWMaznsSmmq5gC7r1FQbaj0mtJ47q4aOKHydFvMub+Q9f3gooCzrg9v7mq2MeB3Fw==
X-Received: by 2002:a05:690c:630f:b0:8b4:dfc2:be60 with SMTP id 00721157ae682-8b520528bc4mr36338177b3.107.1795413193110;
        Sun, 22 Nov 2026 21:53:13 -0800 (PST)
Received: from [172.20.0.3] (static-host-74-205-137-217.epbinternet.com. [74.205.137.217])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202dd36dsm41031237b3.26.2026.11.22.21.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:53:11 -0800 (PST)
Date: Sun, 22 Nov 2026 21:53:09 -0800
From: Chris Down <chris@chrisdown.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	William Kucharski <william.kucharski@oracle.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 0/2] mm: fix deadlock on the folio lock due to inode
	eviction
In-Reply-To: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
References: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <awPUxY7eDWuo_5qP@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi David,

Thanks, this looks good. I exercised that in a VM:

- with the series applied, migrate_pages() on a virtiofs file mapping
   no longer allocates destination folios while it holds folios from
   the batch locked
- splitting a file THP no longer passes __GFP_FS to the XArray node
   allocations
- and the migration and split_huge_page selftests still pass

That said, I didn't manage to practically trigger the deadlock with a
virtiofs mbind() migration racing an unmap before this patch. It might
just be that I am unlucky though, and the code looks correct.

Given that for the whole series:

Reviewed-by: Chris Down <chris@chrisdown.name>

Chris
