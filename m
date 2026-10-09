Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B81371876;
	Fri,  9 Oct 2026 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579313; cv=none; b=Yht2xDNm2Y4CVhqouiGlA773JCVua5Go70jeUrSqO8qjQHcQuFkyncipcfGiMDIxMqKUj9fR17AEKlAgqDC0dLPG4oVrRf+7nDhstriGmQtaIocHUcDwk6M5OI4v7iHK6F2XjAGgW0jYZhDxqIL0+40Yh3kc+NWTwo7zVyUoaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579313; c=relaxed/simple;
	bh=p51NQjUwX1nA/+Pp2hS3WMcCbWiZklc67T2vUrFIhPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QohFOMhQC7d4bsAZqUk3xioQFaxLlwftAqU5/uQF/c1Mjs/bMtL7hp06+Q+M/y8yH8w6aUuA9lrk/YnQbUhp1Yj+F714NrX/Z+9m6e0ivyabpV5Ve5PNIeKJjiE5r6n3pAU2PdDUmwYgK7pzwE1GNENOckALiMSWmitIvWlLp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyI9u/to; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyI9u/to"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893391F000FF;
	Fri,  9 Oct 2026 20:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791579311;
	bh=9Bvt+Xsa7sXVl1fng5tFEayRF5yMEOd/Tzvn8BVb9qI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MyI9u/to/xTOcMPWlUQbiGOT3v8o/iNOpYRWNH4gz7+sgcbhLJ947FpiF8oINFqwH
	 p/9Nd7nkxASalFk2NWrnH17gHaF/A+JVAAXBThFQZQDMbzRMqEVk3AfYq67TfSa2vV
	 WVPtLY+fDREnfFuJQsAiQBGXf4tWaQu5z7y6bcJTNg/nGjjlVv7f3LMDAFXuaOlvTD
	 l0J4iLDoFFE1Ar50jDUljIkEjZ3EOLkOjaV21XNDQwWenew+l5CtZs4xeV+ZgH3UJ/
	 3CEbRx9e87dzk0y/W4a7lua24GyPC/5+EMLiohjsazE0f53jKThEPmVAnKmV3agU+I
	 9SDkknHP/+QyA==
Message-ID: <df588805-6f97-4ef6-a64f-39222669bf3a@kernel.org>
Date: Fri, 9 Oct 2026 22:55:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] mm: pass alloc_flags through folio, filemap, and
 bulk allocators
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
 willy@infradead.org, vbabka@kernel.org, brendan.jackman@linux.dev
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com, jack@suse.cz, akpm@linux-foundation.org,
 ziy@nvidia.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, surenb@google.com, mhocko@suse.com,
 hannes@cmpxchg.org
References: <20260923211041.3127588-1-gourry@gourry.net>
 <asdTptfeLkuypU8t@gourry-fedora-PF4VCD3F>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <asdTptfeLkuypU8t@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 11:10, Gregory Price wrote:
> On Wed, Sep 23, 2026 at 05:10:34PM -0400, Gregory Price wrote:
>> This six-patch series first separates allocator behavior flags from
>> the bulk allocator fast-path flags and shares their validation and
>> preparation. It then passes alloc_flags through the MM-internal folio,
>> NUMA policy, filemap, and bulk helpers.
> 
> I had various discussions this week regarding ALLOC_ZONELIST_PRIVATE and
> ALLOC_UNMAPPED, and whether adding alloc_flags to the APIs is a good/bad
> idea and what the alternatives are.  I'd like to summarize the notes
> here and try to find a way forward.
> 
> recommendations that were made:
> 
> 1) re-use unused GFP flags
>    #define __GFP_X  __GFP_DMA
>    or simply delete/replace __GFP_DMA

If so, I think the latter,

> 
>    There presently are no truly unused GFP flags, though there may be
>    some users who can be shuffled around if we are willing to add
>    functions.

I once had patches to convert __GFP_SKIP_ZERO and __GFP_SKIP_KASAN to alloc
flags instead. Nobody outside core-mm should be setting these, ever.

> 
> 2) alias 2+ incompatible GFP flags to make a new one
>    #define GFP_A (__GFP_NORETRY | __GFP_RETRY_MAYFAIL)
>    #define GFP_B (__GFP_NORETRY | __GFP_NOFAIL)
>    #define GFP_C (__GFP_NOFAIL | __GFP_RETRY_MAYFAIL)
>    #define GFP_X (__GFP_DMA | __GFP_DMA32)
>    #define GFP_Y (__GFP_DMA | __GFP_HIGHMEM)
>    #define GFP_Z (__GFP_DMA32 | __GFP_HIGHMEM)
> 
>    These are all nonsensical combinations.
> 
>    Downside: We should probably just forbid these, otherwise the function
>    contract just ends up being confusing - i.e. (__GFP_DMA | __GFP_DMA32)
>    should just warn / return NULL.
> 

Not a fan of this.

> 
> 3) expose alloc_flags as mm-internal only flags (this series)
>    in addition - convert some GFP flags to ALLOC flags
> 
>    In 99% of callers they would simply add ALLOC_DEFAULT (0).
> 
>    The upside - it seems like there are 2-3 GFP flags that may be
>    good candidates for conversion to alloc flags:
>      __GFP_WRITE
>      __GFP_ZEROTAGS
>      __GFP_SKIP_ZERO

Yes, as mentioned above that was my plan.

> 
>    And the zone/zonelist selectors seem like candidates to free up GFP
>    flags by turning them into internal-only flags and giving drivers
>    some kind of explicit API, e.g.:
>      __GFP_DMA/__GFP_DMA32 -> dma_alloc(...) -> intenal ALLOC_DMA|32
> 
>    I considered whether __GFP_THISNODE should actually be broken up,
>    as it actually means two things (don't oom, use thisnode zonelist)
>    Something like:
>      ALLOC_NO_OOM
>      ALLOC_THISNODE_ZONELIST  (or keep __GFP_THISNODE)
> 
>    The downside is yet another flag interface in the page allocator.
>    Note: This is basically 1/2 way done, this series finishes it.

I do agree that two sets of flags is suboptimal, but likely more flexible. I
guess an alloc_flags only interface is not easily possible ...

I do wonder whether it should be:

	typedef int __bitwise alloc_flags_t;

instead of "unsigned int alloc_flags".

... while at it

-- 
Cheers,

David
