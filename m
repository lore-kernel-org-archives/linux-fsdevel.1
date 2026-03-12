Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534D3F881C;
	Thu, 12 Mar 2026 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332961; cv=none; b=kF5b4BHEr0pqwfBOtMnmUgShGmJXil4Y4ayVpB5hFcaGfTeunN5itH5Tab5DX1+J03EkMSoiIrMrjLrKudkGSXR20TVK7f75HWwx91YKbo9n2wuEPwqyt93BgTjPIuZsetzPb/frZB1F8lCMbxelU3xvN9Og18NkYtMDQWqHeck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332961; c=relaxed/simple;
	bh=esrxzo7O2XultXBeTVh76znaZn4Meg5fnMTPIPJ8BWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skCX/oEQ+O/MOAdcQntLVmMXN2GL3Z2TRVItYcqN/du/dGLx0Ay9ENrMCArlOPiqDbiKZ1jp13m1HcnRb9EjhRW4XgvT4Z+qSHT6PG1tPYsEVnBf7Ht2B3pHWsLVxD7fG99GGRuimALNPSyy+KckmR3+A5KL2FZe5+aYD3Ps/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxsHJar2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxsHJar2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1E6C19424;
	Thu, 12 Mar 2026 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773332961;
	bh=esrxzo7O2XultXBeTVh76znaZn4Meg5fnMTPIPJ8BWo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YxsHJar25XCxy++kk2lfpo4bYkVK8BiiggwX9cnq8b15rOCJH7/GPI/eoTDEZ7kJN
	 HapIoVB7rxzwjilkiOoxM6VVN6wIw1aG4XhbK4QnnenBonCbHrQTpUPy6St4aTAAU+
	 KDFC+h/ReMiNFCSoKC3SxPjxz7ckIyz3slLWc58TsNW5gnSryqnsAylMSPeTPvnRJQ
	 M//9Jj6NmD7jOmFw6ubRjpxu4VwZ0U1V2atOHbwoDZW9wrwd6oxUMzeC8xDObldszU
	 h0qY0ztCQvEAO5yLH/wTo1bQkEh2tJrsz69Rw24gRf4kPG34LzMMQ0BsKaOEvdedTk
	 fgZfxe6dWQ1Hw==
Message-ID: <60ba4311-01f8-4ff3-a2df-e1b3fb6db699@kernel.org>
Date: Thu, 12 Mar 2026 17:29:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] huge_mm: add stubs for THP-disabled configs
To: hev <r@hev.cc>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260310031138.509730-1-r@hev.cc>
 <20260310031138.509730-2-r@hev.cc>
 <bca4ea00-3052-425b-8f39-729d504fd4db@kernel.org>
 <7937d789-539f-47db-838f-c153ca6cfc50@kernel.org>
 <CAHirt9gpZ98HQCXStEQMMfe6TEnSzmD04BM313h2LJGJ1K-hJw@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAHirt9gpZ98HQCXStEQMMfe6TEnSzmD04BM313h2LJGJ1K-hJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/12/26 17:12, hev wrote:
> Hi David,
> 
> On Thu, Mar 12, 2026 at 11:57 PM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
>>
>> On 3/12/26 16:53, David Hildenbrand (Arm) wrote:
>>>
>>> There are other ways to enable PMD THP. So I don't quite think this is
>>> the right tool for the job.
>>
>> Ah, you care about file THPs ... gah.
>>
>> Why can't we simply do the alignment without considering the current
>> setting?
> 
> The main motivation of raising the alignment here is to increase the
> chance of getting PMD-sized THPs for executable mappings.
> 
> If THP is not in "always" mode, the kernel will not automatically
> collapse file-backed mappings into THPs, so the increased alignment
> would not actually improve THP usage.
> 
> In that case we would only be introducing additional padding in the
> virtual address layout, which slightly reduces ASLR entropy without
> providing a practical benefit.

Well, that parameter can get toggled at runtime later? Also, I think
that readahead code could end up allocating a PMD THP (I might be
wrong about that, the code is confusing).

Let's take a look at __get_unmapped_area(), where we don't care about
ASLR entropy for anonymous memory:

} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && !file
	   && !addr /* no hint */
	   && IS_ALIGNED(len, PMD_SIZE)) {

Interestingly we had:

commit 34d7cf637c437d5c2a8a6ef23ea45193bad8a91c
Author: Kefeng Wang <wangkefeng.wang@huawei.com>
Date:   Fri Dec 6 15:03:45 2024 +0800

    mm: don't try THP alignment for FS without get_unmapped_area
    
    Commit ed48e87c7df3 ("thp: add thp_get_unmapped_area_vmflags()") changes
    thp_get_unmapped_area() to thp_get_unmapped_area_vmflags() in
    __get_unmapped_area(), which doesn't initialize local get_area for
    anonymous mappings.  This leads to us always trying THP alignment even for
    file_operations which have a NULL ->get_unmapped_area() callback.
    
    Since commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
    boundaries") we only want to enable THP alignment for anonymous mappings,
    so add a !file check to avoid attempting THP alignment for file mappings.
    
    Found issue by code inspection.  THP alignment is used for easy or more
    pmd mappings, from vma side.  This may cause unnecessary VMA fragmentation
    and potentially worse performance on filesystems that do not actually
    support THPs and thus cannot benefit from the alignment.


I'm not sure about the "VMA fragmentation" argument, really. We only consider
stuff that is already multiples of PMD_SIZE.

Filesystem support for THPs is also not really something you would handle, and it's
a problem that solves itself over time as more filesystems keep adding support for
large folios.

So I think we should try limiting it to IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE),
but not checking the runtime toggle.

-- 
Cheers,

David
