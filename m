Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B281F27442;
	Wed,  1 Apr 2026 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028756; cv=none; b=N1Kfcu4iTQdH7kuI1g2IWKwxXb7PGKTzOTMKYBPDbSzSKyBV0zD0RbQ1hJpGz+2Y7HinT74jLSX4pCQUVl4ko+e0zyAtzpBgeQzLUjNETz66rbTHHlBkF9IY58oACFoLXHX9S+U+z0Pi/81E/DpruHH0vUAjyL8+ui3EuPtRb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028756; c=relaxed/simple;
	bh=Xn630OcqIQHi39xngA8rdVFLMzJ6oRMn/HMdRSOCPls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHYkD2Hk+jEz9eBNR/JKoO8J7S3hrJznTwKja+dch2CvGO1emIiKcT0pXnbIu0AkHjc/gzYNuJDKVG7iQlzn7pOt7iIL1MjvSEasigsQZjTW1uRmbIrjxkvTft6UcG7iiYvFsxT05bnEd2imCFUPf9t9YuvzCqSOf5Im96nfavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=humF71eb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="humF71eb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63542C4CEF7;
	Wed,  1 Apr 2026 07:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775028756;
	bh=Xn630OcqIQHi39xngA8rdVFLMzJ6oRMn/HMdRSOCPls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=humF71ebabeqOf720kG9Kp3v1uYNN24B/eb+zf0MwE0EGHGt2SYsVKdjAeLFIYQPE
	 JpKTQti9qdA1UD0aJ2wjmmtixB9bFuBuNiNW0fwF3ilqHrSx2t8VLzRyRIbw6bmN2c
	 saJYL9J6ElfuXkNpR6MQZlw5JCLTibOual5FmZzEu5pm/AbinbE1hM/XAFIdXV+6lp
	 ry3tOJfVitrM3Lyzuapcby8OwKWlDVY+ikszsrQmDUWK8FIDdhxWVxq5Q8e1n+TcQb
	 aqgJswJUKR+MLwPFaGtVmpizs2Uk+dbXHjxKIPqVsgEKItt6A0x3cOseQpYN4SmQs0
	 PcSyJjFVX2qNQ==
Message-ID: <e1431688-17ba-4881-9536-b598383ed2d8@kernel.org>
Date: Wed, 1 Apr 2026 09:32:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/2] Fix storing in XArray check_split tests
To: Zi Yan <ziy@nvidia.com>
Cc: Ackerley Tng <ackerleytng@google.com>, willy@infradead.org,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, michael.roth@amd.com,
 dev.jain@arm.com, vannapurve@google.com
References: <cover.1771831836.git.ackerleytng@google.com>
 <6ada27e1-8f85-4b85-8c25-bc9207b2624d@kernel.org>
 <87FD20AF-55B6-4129-9AED-E2E854593883@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <87FD20AF-55B6-4129-9AED-E2E854593883@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 17:49, Zi Yan wrote:
> On 16 Mar 2026, at 12:23, David Hildenbrand (Arm) wrote:
> 
>> On 2/23/26 08:34, Ackerley Tng wrote:
>>> Hi,
>>>
>>> I hit an assertion while making some modifications to
>>> lib/test_xarray.c [1] and I believe this is the fix.
>>>
>>> In check_split, the tests split the XArray node and then store values
>>> after the split to verify that splitting worked. While storing and
>>> retrieval works as expected, the node's metadata, specifically
>>> node->nr_values, is not updated correctly.
>>>
>>> This led to the assertion being hit in [1], since the storing process
>>> did not increment node->nr_values sufficiently, while the erasing
>>> process assumed the fully-incremented node->nr_values state.
>>>
>>> Would like to check my understanding on these:
>>>
>>> 1. In the multi-index xarray world, is node->nr_values definitely the
>>>    total number of values *and siblings* in the node?
>>>
>>> 2. IIUC xas_store() has significantly different behavior when entry is
>>>    NULL vs non-NULL: when entry is NULL, xas_store() does not make
>>>    assumptions on the number of siblings and erases all the way till
>>>    the next non-sibling entry. This sounds fair to me, but it's also
>>>    kind of surprising that it is differently handled when entry is
>>>    non-NULL, where xas_store() respects xas->xa_sibs.
>>>
>>> 3. If xas_store() is dependent on its caller to set up xas correctly
>>>    (also sounds fair), then there are places where xas_store() is
>>>    used, like replace_page_cache_folio() or
>>>    migrate_huge_page_move_mapping(), where xas is set up assuming 0
>>>    order pages. Are those buggy?
>>
>> Zi, do you have any familiarity with that code and could help?
> 
> Not much. But I used lib/test_xarray.c to did a test:
> 
> 1. initialize an xarray with order 6 and set entry to 0,
> 
> 2. add a new xas like XA_STATE(xas0, xa, 0);
> 3. xas_store(&xas0, xa_mk_value(32));
> 
> 4. add a new xas like XA_STATE(xas0, xa, 16);
> 5. xas_store(&xas0, xa_mk_value(48));
> 
> The outcome is that xas_store() does not change xarray structure,
> namely the orders are preserved. No issue is present.
> 
> After 2 and 3, the xarray is still order 6, but its 0-63 entries (all order-6)
> are changed from 0 to 32.
> After 4 and 5, the xarray is still order 6, but its 0-63 entries
> are changed from 32 to 48.
> 
> I will need to dig into the code more to explain how xas_store() works.

Zi,

we discussed this topic with Willy in the THP cabal call. I did not get
all the details, do you remember our conclusion?

(I can try getting access to the recording)

-- 
Cheers,

David
