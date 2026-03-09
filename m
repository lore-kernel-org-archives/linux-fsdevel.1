Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D83ACA6B;
	Mon,  9 Mar 2026 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072873; cv=none; b=FG6hLKejGirSDRjelBXfoSq2GG899wa35yGQpGO5fcALHY/ehdmKsFaDp1H/CEBoUJQ7QweKOdtcraZf4jLtG8DV3+gomcYChIpoIJc99wrPHILZiPEyx9Aw/n5wM3n8jJtFLASLB3KLlJMwIkX3gpmq8K2FGMXWL26xhC/INUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072873; c=relaxed/simple;
	bh=p1jDg/PoZE134/hvzAZp30erwJqRyaAnX8Tci2InXOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8rOAJfw4s0ozmhl6Y+9eNwF31XidrV9SyqIIsulLQejdiiqGV/Ht6EHTFI0KbDGVOV5S/ACq9juBo+03xsVXx3VG++yn+2D0Uv3o3uCNTEzPwDMGxNJbVZCe97Eae9kNdCmtv5skHd4xZIiMBxEyesNkJdtaftfBit2ZzhI9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rIHyROpF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rIHyROpF"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7913540C9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773072871; bh=p1jDg/PoZE134/hvzAZp30erwJqRyaAnX8Tci2InXOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rIHyROpFd/tKHNE2cNLLgwSlk7bC/Xbm5umP3AawrfzYgfiuvY/yRdDBI5REo6fKC
	 +niFUjJQGCUOuG4AC4Q06wb2V5v+NFkg3x6MoeuryvNSOn+xU2cZmFraCDAVHY3v3j
	 7CbmunT6w4hBHEsE6QGd2xBiaspuz1WRDboznSeWWZ+5DUY4nAl9adTmdqCM9/HCCi
	 l5W6THUrTQqmjNw+WVSUrxTnRQzSOT1wJQx3M8ngkpRb0prHUuR2dvaw1RegGHjKcb
	 PuJ6ZAR7/qpWekypRt7R7VGDHNDZPamBJznl1wPy42xS23XRyIfvr3pl6BdyJDRwjO
	 gnApntLob1Wwg==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7913540C9C;
	Mon,  9 Mar 2026 16:14:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan
 <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, Vlastimil Babka
 <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Usama Arif <usamaarif642@gmail.com>, Andi
 Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] docs: filesystems: clarify KernelPageSize vs.
 MMUPageSize in smaps
In-Reply-To: <20260306081916.38872-1-david@kernel.org>
References: <20260306081916.38872-1-david@kernel.org>
Date: Mon, 09 Mar 2026 10:14:30 -0600
Message-ID: <87ms0hvv2x.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> There was recently some confusion around THPs and the interaction with
> KernelPageSize / MMUPageSize. Historically, these entries always
> correspond to the smallest size we could encounter, not any current
> usage of transparent huge pages or larger sizes used by the MMU.
>
> Ever since we added THP support many, many years ago, these entries
> would keep reporting the smallest (fallback) granularity in a VMA.
>
> For this reason, they default to PAGE_SIZE for all VMAs except for
> VMAs where we have the guarantee that the system and the MMU will
> always use larger page sizes. hugetlb, for example, exposes a custom
> vm_ops->pagesize callback to handle that. Similarly, dax/device
> exposes a custom vm_ops->pagesize callback and provides similar
> guarantees.
>
> Let's clarify the historical meaning of KernelPageSize / MMUPageSize,
> and point at "AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped"
> regarding PMD entries.
>
> While at it, document "FilePmdMapped", clarify what the "AnonHugePages"
> and "ShmemPmdMapped" entries really mean, and make it clear that there
> are no other entries for other THP/folio sizes or mappings.
>
> Also drop the duplicate "KernelPageSize" and "MMUPageSize" entries in
> the example.

Applied, thanks.

jon
