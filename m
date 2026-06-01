Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F333F8C5
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307003; cv=none; b=LgEaCSMetCIlShfPZuDyBMA14cz6qP5fBjZ7dMF342UkaNpaO3SBTf5YuajpfITBAd2a+lNLWB+sIjnL4jgv9n3OeBVTjobGY4RMgxAQgke9+h0s8J8irHDr/ieb4/Yozc39TNRgoQUycD1/PnL01EuN5RfFOjSMmxa9JoHbLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307003; c=relaxed/simple;
	bh=vB9HAqr1io+JCVuMDocmxtnzHNpKH/qbAlYpybbwzfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcTJAI3NZBj18zx3+6/g1iTNBIXP6B7WooKS7pBVPz48f9wgmF15pCOD/NPWFUPnV4Z1AiffZZc/JZXu91mSSgjS6Hv6n99Ai8dHp9o3SW/ljq+pk1l9RUjRwXP8RkCsiOLySxV11vjZrBM/G8bl1ileMjVSyY4qKcpJDLK42DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p86NKhR5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p86NKhR5"
Message-ID: <d144b0a1-acd5-4d08-aab0-5b2dc8219219@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780306989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZFkDlb0M/DK/+4npGDmhkRBwuIrbB14olid11Coyvg=;
	b=p86NKhR5i/z2Uh1CGWtYdPqyJsB+l0ogupMPW57FzLrGY97HrT45jbXoDRvfhPQV6Ko/kB
	2hro5IL7lC1A5P78SDTfsqD7kOeIkD0+PPOkCGMw6SlHX/T7JIK1pyusIGtQ8D3kehnye3
	M7VgyTjtAKFZd3DPmFiYvQRNTNJOE8E=
Date: Mon, 1 Jun 2026 10:43:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/2] mm: use mapping_max_folio_order() for
 force_thp_readahead order
To: Jan Kara <jack@suse.cz>
Cc: Pedro Falcato <pfalcato@suse.de>, willy@infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc,
 Andrew Donnellan <andrew+kernel@donnellan.id.au>, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, brauner@kernel.org,
 catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org,
 kevin.brodsky@arm.com, lance.yang@linux.dev,
 "Liam R. Howlett" <liam@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@pedro-suse.lan,
 ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20260528165635.2068012-1-usama.arif@linux.dev>
 <20260528165635.2068012-3-usama.arif@linux.dev>
 <ahlh2vdHEGo6ZSot@pedro-suse.lan>
 <cc9a1cf7-7b96-439a-b0be-ecdcf27b5da5@linux.dev>
 <ahmSolHvUChl-3vM@pedro-suse.lan>
 <185f1caf-b33d-4467-beb5-51bd8520ac78@linux.dev>
 <u52xvwk2fjjk2izdb4wvuqq2zhc5neb4q6usimcxejluuyngxw@d64sc6rvojyp>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <u52xvwk2fjjk2izdb4wvuqq2zhc5neb4q6usimcxejluuyngxw@d64sc6rvojyp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 30/05/2026 16:16, Jan Kara wrote:
> On Fri 29-05-26 15:11:54, Usama Arif wrote:
>> On 29/05/2026 14:40, Pedro Falcato wrote:
>>> On Fri, May 29, 2026 at 01:19:03PM +0100, Usama Arif wrote:
>>>>
>>>> which means mapping_max_folio_order(mapping) <= MAX_PAGECACHE_ORDER <= HPAGE_PMD_ORDER is always
>>>> true, and you dont need the min3(..) in your diff.
>>>>
>>>> Now the question is if then why not just do:
>>>>
>>>> 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
>>>> 		if (mapping_large_folio_support(mapping)) {
>>>> 			force_thp_readahead = true;
>>>> 			thp_order = min_t(unsigned int,
>>>> 					  mapping_max_folio_order(mapping),
>>>> 					  get_order(SZ_2M));
>>>> 		}
>>>> 	}
>>>>
>>>>
>>>> This is because this will regress the 16K ARM case where we already got 32M
>>>> folios. Someone might upgrade the kernel and start getting 2M folios now.
>>>
>>> So maybe limit to 32MB? It's still arbitrary but at least you get simpler
>>> logic. If the architecture does not support 32MiB folios, it will clamp
>>> the maximum folio order to HPAGE_PMD_ORDER, and you get the same result.
>>>
>>> Does this sound correct?
>>>
>>
>> Yes, so if we replace it with SZ_32M, it sounds correct. I just think
>> the 32M size is too large. But as you pointed out, even 2M can be too large...
> 
> So AFAIU the practical discussion is about two options:
> 
> 1) limiting at 2MB with a slighly more complicated logic to keep mapping at
> PMD order for 16k pagesize on ARM but use 2MB pages for 64k pagesize on ARM
> 
> or
> 
> 2) limit at 32MB with simple logic which results in larger (32MB) folios
> with 16k and 64k pagesize on ARM and thus larger memory overhead.
> 
> I'd like to maybe offer option 3): limit at 2MB with simple logic. This
> will reduce folio size on 16k pagesize ARM compared to 1) but do we really
> care? I.e., is there big enough practical performance impact with conpte
> and other tricks ARM is playing?
> 

I think the logic isn't that complicated for 1, but I am happy with option 3.

>>> Bottom line is that changing things will always affect someone :) Particularly
>>> since the logic we have is not too careful at deciding what should or should
>>> not be a THP (both in anon and file cases). And if (once?) we make it smarter,
>>> it will surely also regress someone!
>>
>> Yes completely agree on this as well.
>>
>> So personally I do have a preference of keeping the cap at 2M atleast initially
>> while we currently try and solve the issues we see with 2M alone. As we are already
>> seeing reports of thrashing and compaction with just 2M, I dont think the logic
>> in this patch with just an if else is that complicated.
>>
>> Matthew, Jan, do you have any thoughts or strong preferences on cap size?
> 
> Frankly, no strong opinion. I'd think 3) is worth trying for its simplicity
> and seeing whether somebody complains, otherwise I can live with both 1)
> and 2).


Thanks! Yes, let me send this. 

Andrew I will send this as a new and hopefully last revision as I am not sure
if you would like another fixup on top of this series! Thanks!


> 
> 								Honza

