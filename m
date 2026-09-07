Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB2413D62;
	Mon,  7 Sep 2026 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810853; cv=none; b=DoMoSOsela8yy79Li5LQwCHYEcNSGyxZPrc0dZQziwpUxtUVv9i8rQRiXujFuQD0vNRhpnV6wNIOef9s5E7LSsi6I7WAQKolPwzgRg67IR31JJW0R+bTcBKx3pw6DZHn4Bs6DWeOGtyhgsY2EiCyEHEdfcp6aUT/eSE0ltmeh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810853; c=relaxed/simple;
	bh=vZnN4KU1cWaEFbNnzCzPt2Wdmzgtn0Dy+55Sn17gtT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loWeJAVAmX7JHFYgsAJyLYQQn0rBoIyhKIc3C8TJKp8evhIOIvaw+SLN/oHzPd2FjqurZhSfr5UsXkmE/RYX3aD+rH4iTwF7jpGNkVDFkMkV+GL6CigzW9S8ryl/pur1+KCUHr/C/nS5MBw5PUNzHo7Np/+3UlGezMgRMoJ23A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7Huh7to; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7Huh7to"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3321F00A3A;
	Mon,  7 Sep 2026 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788810851;
	bh=BEUL0SljeIyq1NT5NrU2gpIGhYcIPt2sqlLxa+OdvBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U7Huh7to+wvW/QhflgkMntofgOu4uxc+43i29/GW0wPcugj9po7OvqZNodFKHamNJ
	 QDv7LJsPdqV8i3gqta3u5z9nHFS46AbjNueUmlsf+/bAIAFrEFJIWGWn6EbecoLXMf
	 aGct/ZyQfVGpD41ggHxy2fcZcUgEpnpRwlYptWqNKKMqdXh/nSQfhxIyHi54XLD/dx
	 vsec7TZbxxwRgTbSFkRP3HbrtxJSN6REKJHSxXTBMf98NAUQiXq3mWslZkjJy9zNJL
	 2Ev0wxYNzterJ5kT/NciqJOttqXmoIRs1i0FYa0H//Qe2JZ+QFXVSs1WFdyK/EHj9/
	 rPimLjqpzb61w==
Message-ID: <8f797f01-e958-404e-bcdf-283da960e95c@kernel.org>
Date: Mon, 7 Sep 2026 21:54:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mm/vma: only permit MAP_PRIVATE /dev/zero to be
 mapped anonymous
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
 <20260902-map-private-dev-zero-v1-3-a578c730cec7@kernel.org>
 <d6dc52e3-b27d-4663-848c-a2f270fb4c5d@kernel.org> <ap71GOPAeKHfHp5J@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ap71GOPAeKHfHp5J@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>> I was wondering whether we should call this "map_is_private_anon", due to
>> MAP_ANON|MAP_SHARED. But looking at __mmap_new_vma(), the existing "is_anon" is
>> also limited to MAP_ANON|MAP_PRIVATE.
> 
> A 'shared anon' mapping is not anon at all, and that's handled early in
> do_mmap().
> 
> I wish that we didn't confuse people by allowing MAP_SHARED | MAP_ANON as a
> shorthand but there we are.
> 
> So I don't like to make that distinction on the basis that a 'shared
> anon' mapping isn't something that exists :)
> 
> And then imagine vma_is_private_anonymous() vs. vma_is_anonymous() etc. It would
> get silly, quick...
> 

Yeah, agreed.

>>
>>> +{
>>> +	if (!map_is_private(map))
>>> +		return false;
>>> +
>>> +	return !map->file || file_is_dev_zero(map->file);
>>> +}
>>> +
>>>  /*
>>>   * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
>>>   * possible.
>>> @@ -2634,8 +2647,7 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>>>  static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
>>>  	struct mmap_action *action)
>>>  {
>>> -	const bool is_anon = !map->file &&
>>> -		!vma_flags_test(&map->vma_flags, VMA_SHARED_BIT);
>>> +	const bool is_anon = map_is_anon(map);
>>>  	struct vma_iterator *vmi = map->vmi;
>>>  	int error = 0;
>>>  	struct vm_area_struct *vma;
>>> @@ -2651,7 +2663,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
>>>
>>>  	vma_iter_config(vmi, map->addr, map->end);
>>>
>>> -	if (is_anon)
>>> +	if (is_anon && !map->file)
>>>  		vma_set_anonymous(vma);
>>>
>>>  	vma_set_range(vma, map->addr, map->end, map->pgoff, map->anon_pgoff);
>>> @@ -2669,6 +2681,10 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
>>>  	else if (!is_anon)
>>>  		error = shmem_zero_setup(vma);
>>>
>>> +	/* Temporary MAP_PRIVATE-/dev/zero workaround. */
>>> +	if (is_anon && map->file)
>>> +		vma_set_anonymous(vma);
>>> +
>>>  	if (error)
>>>  		goto free_iter_vma;
>>>
>>> @@ -2777,6 +2793,10 @@ static int call_mmap_prepare(struct mmap_state *map,
>>>  	if (err)
>>>  		return err;
>>>
>>> +	/* Hooks cannot mark themselves anonymous. */
>>
>> I guess this comment will be stale soon (after #4 where you drop the
>> set_anonymous part).
> 
> Not really, it's there to catch drivers doing something silly/broken (likely by
> mistake).
> 
> I want to catch that early. I have a 36 patch series that extends this kind of
> idea... a lot :)
> 
>>
>> Should it be
>>
>> "vm_ops are strictly required with mmap_prepare"
>>
>> or sth like that?
> 
> Well that's confusing though, because desc->vm_ops defaults to &dummy_vma_ops,
> and we absolutely do not require drivers to set vm_ops at all.
> 
> And as far as the driver is concerned maybe it's NULL? They maybe don't realise
> :)
> 
> So the idea is to say don't allow them to try to do something they can't do.

Yes, but my point is that the comment

"cannot mark themselves anonymous"

will not really be correct after the next patch, no?

> 
>>
>>> +	if (!desc->vm_ops)
>>> +		return -EINVAL;
>>> +
>>>  	err = call_action_prepare(map, desc);
>>>  	if (err)
>>>  		return err;
>>> @@ -2799,10 +2819,7 @@ static int call_mmap_prepare(struct mmap_state *map,
>>>  static void set_vma_user_defined_fields(struct vm_area_struct *vma,
>>>  		struct mmap_state *map)
>>>  {
>>> -	if (map->vm_ops)
>>> -		vma->vm_ops = map->vm_ops;
>>> -	else	/* Only /dev/zero should do this. */
>>> -		vma_set_anonymous(vma);
>>> +	vma->vm_ops = map->vm_ops;
>>>  	vma->vm_private_data = map->vm_private_data;
>>>  }
>>>
>>> @@ -2882,7 +2899,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>>>  		allocated_new = true;
>>>  	}
>>>
>>> -	if (have_mmap_prepare)
>>> +	if (have_mmap_prepare && !map_is_anon(&map))
>>>  		set_vma_user_defined_fields(vma, &map);
>>
>> Ah, we have mmap_zero_prepare() for handling the shmem_zero_setup_desc(). I was
>> just about to ask whether we can just get rid of this here.
>>
>>
>> But, hold on, do we now even need that? Could core-mm now take care of that as
>> well, and we could just remove mmap_zero_prepare() entirely?
>>
>> That is, we'd make shmem_zero_setup() in __mmap_new_vma() take care of this?
>> Then we might not even need shmem_zero_setup_desc() anymore.
>>
>> Maybe harder than it sounds at first.
> 
> I think I'd rather that be a follow up :) this series is about eliminiating the
> one last (I hope?) corner case for anon VMAs.
Right; having to deal with anonymous mappings that have mmap_prepare is rather
suboptimal. Ideally we'd just handle the odd dev-zero special-casing early in
the mmap path also for MAP_SHARED, and avoid messing with mmap_prepare entirely.

So agreed that this can be done separately.

-- 
Cheers,

David
