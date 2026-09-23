Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2048EC9C
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163642; cv=none; b=Rz/7M8/PMsD0NdIsoJKOLzU37pj85ANeIFNBFJoCKcwei/D+d2pVWQosrrbo1u+Ghmno3n6ASS2O3zZ3G1ZYM2VRobY6wlR8BTA8kXrFPrsuGDSfMOsFFB7WZYDpPRRIVzrgIZmZdvbqWeWzHF+3O/Iw5EqfZmrKH3td8eytMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163642; c=relaxed/simple;
	bh=2KVMZc1khXoqBLinI7C9vu+1xPBD2oT+P24LYaIAQP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fT+3JutT9Q5nEp1ioxCLCp0sJKL/WyKhWZ3MCp37iLaEWKLlEMO0dt5zEQVzAL32aMMQCsDPYRy0pLUC1bvZ6v6j8sY9Q9wcNRXJd19ttkwecgIHGYhzD1GPzxfUSTyGAyTPCOxGhSzbH/KFSEUrvWTlCFLMbrESGAFYrNID2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekCZ/Dpx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekCZ/Dpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D8C1F000FF;
	Wed, 23 Sep 2026 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790163630;
	bh=ELwqlQOQpFWXNbqYfRTf6Nxzmx4A5X4UMjcGUF8ui/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ekCZ/Dpxd4UXfjUpPJgFSz+5Qae1qUCR1vSSZ8gxKyDdMCl1jyddCKLqopYldDgj1
	 USDujZCPTeZhGiUDptREnXMGr1shGrif+fIvQoFMpJPidLd5R0DqS1zOJ8nfFMTYG+
	 dq0GuoMp4dgKLR79+EmQaRwvZYATQHJErH887908uZwyhKnvAuQCgqkGUxWfWj0IBZ
	 8b/cXJGID70KBufVBtlnM+b92J7fia77hD7wYjjK7NnliafUE2G9fUSvta2wgzDtCy
	 rtF9JdpAYG3E3YmJgIBrGXTkEcL+BGrBC4VVjbPfe+XYn72fBHsz+zzKdL9i0VrM3R
	 mRT19O4etE54A==
Message-ID: <7a23511f-365f-436f-b934-6a520510409c@kernel.org>
Date: Wed, 23 Sep 2026 13:40:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/15] hugetlb: Use the has_hwpoisoned flag
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jane Chu
 <jane.chu@oracle.com>, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <christian@brauner.io>,
 Jiaqi Yan <jiaqiyan@google.com>, "Gregory Price (Meta)" <gourry@gourry.net>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-9-willy@infradead.org>
 <a51a6236-8881-4479-8f04-39676e0e1f14@kernel.org>
 <an3uN4TAAZ2miXhe@casper.infradead.org>
 <7608c80e-645b-4d07-bba3-ef45ee36fba4@kernel.org>
 <arGidwZQrrWVPAoj@casper.infradead.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <arGidwZQrrWVPAoj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/26 23:32, Matthew Wilcox wrote:
> On Fri, Sep 18, 2026 at 03:44:12PM +0200, David Hildenbrand (Arm) wrote:
>> I'm a terrible person and it took me way too long to get back to this :(
>>
>>>
>>> You make it sound so easy ;-)
>>
>> Heh, as long as you hold a folio reference it really is :)
>>
>>>
>>> If we don't hold a reference on the folio, then the folio (whether it's
>>> hugetlb or not) can be split.  And then folio_test_hwpoison() can hit
>>> the assertion that it's now a tail page.
>>
>> Right. I am/was missing the connection to "generic_file_read_iter() in hugetlbfs".
> 
> We might be able to split this into two series at this point.  

That would be good, because I suspect the "generic_file_read_iter() in
hugetlbfs" part is less controversial than the hugetlb cleanup and we can just
merge that easily without touching too much other code.

[...]

>>> If we could get rid of HVO, we could do it entirely on struct page.
>>
>> That's what I hope we will achieve at some point.
> 
> I'm not sure that's a realistic hope in the next few years. 

:(

> Even if
> we get struct page down to 8 bytes, that's 2MB of memory per 1GiB allocation
> (assuming 4KiB pages).  Always a tempting target for someone looking for
> memory savings.

Ack

> 
> I would prefer an out-of-line tree that doesn't rely on a bit in struct
> page.  Maybe a bit in struct folio wuld be fine (which tells you whether
> it's OK to skip the tree search).

Yes, that would likely be better. A single bit would likely just remove any
overhead of checking in the common case (no hwpoison).

Not sure what to do with non-folio things.

> 
>>> Or, as above, entirely rearchitecture hwpoison handling to not be based
>>> around pages or folios any more.
>>>
>>>
>>> Blame Sashiko!  I'm going to ignore it in future, but it's really good
>>> at nerd-sniping "hey all of this is already broken and you could fix it
>>> as part of this series".
>>
>> Right, and this is only the tip of the iceberg, because the entire hwpoison
>> infrastructure is a complete hacked-on racy piece of ... engineering excellence.
>>
>> To summarize my question: is it possible to separate for this series the
>> pagecache part (Use generic_file_read_iter() in hugetlbfs) from all the hugetlb
>> hwpoison rework?
>>
>> OTOH, if it's really not avoidable, please let me know.
> 
> I think Sashiko will whine and complain incessantly if we drop the
> race elimination patches off the front.  I can try it, but is it worth
> doing?  

Note that Sashiko will apparently no longer complain about preexisting stuff.
I've been told that these reports are now collected elsewhere.

So I wouldn't worry about Sashiko crying about hwpoison stuff that was broken
for ever. I'd rather have fixes for that handled separately (after we properly
discuss a better long-term solution to handle most these races and where to
store hwpoison information long-term).


-- 
Cheers,

David
