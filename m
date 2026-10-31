Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475043;
	b=lXnVZoVSFvSj8FoQ6zzRRIv7CHtjT9BzmMilPHIaiaMDNgEdo/zeIMnZqHdsfHCerw5P
	 qSmb/Nq+zyofl27hj1u66ntxzrezF7stGCO8tpoQKf+HWUsk9kMRpaHJDvkUJrw+6rUtX
	 DfScQLkH+AChgJJrsh2/BdtTyVRMHJc4jw2VUv2/y8agX3N1ZRqaQyhmkiBp//woF9sII
	 bH1HhAaLSzUTJ6JRTRfOgUhEezfiMIrNCYnKzB/DR+u2Dc7ljBVuvPmRIDAarFRFfSgg9
	 7bJyWD0+esUP7O0xsBYT8H7vCJk+NuCs/p4F/k3SMFjQZQ3JuvGFZTlAmjve2aS8x1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=+8QGpnyPZ7DhkQpiphg595uJGsoBZBg/wk/3XMNmDqI=;
	b=snMYCmQWww23mDlKhElryKnjwPvoIx8zCQDEPPwlrFCs2nkMHdrY4yspy8BqQgAIxOSa
	 YnH0/CNBwwpcpthx8H+lWwu5bR2hrbA6Mm6cKhzBbkw1/W88WK0qqjvmxSX2QanSIqBX0
	 URg1rcAU9d0NmoRz8lehVBJG6afYfCjurJhzrAESXJ6ZTG/UoZAXYArx75rA2AwkJlgGM
	 NbNB2/acGXtcZfHsBqBYiEtUogRY4DTeQNJiGJoiq35XAz0AHdSt94QOBmnhPS3tRtGcH
	 qQUEL03Td+Jaeu7Lo/w7n5iCB/Eb9CzN17T1zyqlVt3Fhe9k6DgLl2AQ0nTBFh+WIaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a7kLzHFb;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35390606A31E
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 19:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35390606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a7kLzHFb
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9f6a16afcso31765ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 12:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793475042; x=1794079842; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+8QGpnyPZ7DhkQpiphg595uJGsoBZBg/wk/3XMNmDqI=;
        b=a7kLzHFb1yszRejaXnZrybmPvFYj7onPrb+xEd+eeS8Ujm0n1pZvNl5Ct4Lzp4rzFB
         ZecOI2HdzhFFyuWlRO5GlbB7HPvNdSOJOooNIMoasIuoIpd467vISRd6xVJHR26uz29E
         WQXb8BaWiHtFJtibkG11c41EEoFa1JOXOPNj1qAH+ni8tC4SgtjNKmAKJbwUq9RN8WNx
         ciWBJcRLXO1wonXgk2nrywZraX0rakuRNU3qoICJacoDI46lfooA6zBsAGeTtDzooc49
         r3oEbVGIwW45O45wLJBhax8VqqSXy1SPcA/08V+DbGJxtoQIh6xLJk7xAxjxi4nPOKg7
         g+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475042; x=1794079842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+8QGpnyPZ7DhkQpiphg595uJGsoBZBg/wk/3XMNmDqI=;
        b=fbgRcG5ZOJp3Mnh4XreB1PX+SOCjzxleFwpiFaQrmQV3DKztbynNxTaTD6GpPgqYUU
         0c58R1QAOepqnVjZVdOvvt8JIkDk33KURpoBRT0uUC4Y31dj9jjaxoJS3qnzBLdsEYTa
         ocSqTitLi4C0WGusVCw8caiB5+4F+PK4aMGaHYIAqVWKB08uJNIgWUCqfuYpGZY0rOlo
         6kYndyG0DlWWdAhck9qNnV2G+8pyC/eyc3toy6ro3IJVclV2V1onMWqnFOkd3P7yig3O
         +wXM3sz9YsTHYMOXgrK7R2M5rYUxKgidwEAI4TvXT+YkAAdqiL+I46c/QGpOJjvNj2G7
         s76g==
X-Forwarded-Encrypted: i=1; AKwUvByVHZytkmBnjXZcnGjxM4xLBWvODiDEMNxljPXzQMyTZHFbuBuMsJvQGmCKqCwHcig4D9U5X9Pqn1Uf5jaA@vger.kernel.org
X-Gm-Message-State: AFq9FYINaDYRSLz5S26yI4UX39r0fuycMqLxgJJEF3AFC8DTdjC4S16i
	5KF5zYuaLR50+ZLAj5f4HxVFrEEClYWyZGx5XHVlqO32ruA7DuidfV39vIna62/gOw==
X-Gm-Gg: AYBFou2mDr1CCuOIUwN1zvc+EWyO3yOh3ylq/6EHgucYX/8HySrj1SHtFSypuuKBwMg
	/cdY3ZRH1SNWVLJ7FlA1hdmVnpT8PWCdi5pflw9wOhdH+Y0TbEg7D4pLvMbcTlYk7G/+BF55o34
	QxKDgP5rpEg8bjeRuZ/opvL1prgsSh+qRkQhxZOEZjDfD9x+TmDaIm4USF3iKGJPfdfRF5vVdUs
	H9IJQ9baLjTy7AUl0arRNyTgBpxKDhfTEog5PXp93jD9aUTbpL77ZefZzyby8zjEtpkKWN+K2p3
	30ZH7WB657ZB62kxBFy2KSZpyQSrnVmVRADtXXERibCyH5onLy8Jd+Sc58R4AgVUtXZjQTNmus3
	gxR8UdGtAxMZONyKMhv0X6rGIrXhfxRSKMbTnRWXtaE5KZ34R1clgpohBoVYoHODL4Pxsu/B0Ut
	JZzi5DoWyfP48/WHbLcM0OGMtM5VhHnPQclld2rcxQGfDHIJE6VvaPwWi1HF4214siDkSmM4ulR
	iSrhzzT4KjnpIKl6kuz2Ow+9mD/MKt2TYJnzih0fPIB//ZIOW5NW2xY7Cqf/WR57/HyikRqBcMl
	ibko7nuZgXFJb/i88+6tEh3yH+lIHIa3+1cQx2frYAr2Cp4tTGUjZKbxQQyfkGtxz9S+P7Uvdt+
	1df7wBdH5SBDPhUq8g7xXBQ==
X-Received: by 2002:a17:903:3904:b0:2e2:d665:6ad8 with SMTP id d9443c01a7336-2eb1b81b9e8mr16615795ad.4.1793475041906;
        Sat, 31 Oct 2026 12:30:41 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm12552004a91.15.2026.10.31.12.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:30:39 -0700 (PDT)
Date: Sat, 31 Oct 2026 19:30:36 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Shuah Khan <shuah@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
Message-ID: <auZAViCjlzN3gd6g@google.com>
References: <20261026220546.3114241-1-skhawaja@google.com>
 <d4891333-43ea-4d74-9fb9-6ad8dac1a446@kernel.org>
 <20261030121113.GB3889730@ziepe.ca>
 <2c7aa5c1-3af3-4654-b244-1257d05c9d45@kernel.org>
 <auTR9SnDLsLVmnJ7@google.com>
 <CALCETrV5eqg6d9=+BQhCpRwBNe3aCQiut8vxPBs8b7PToqjaHg@mail.gmail.com>
 <auVRLPmbWYvMnly-@google.com>
 <bb50fcfa-9d71-4905-a76a-ab7bc149d62b@kernel.org>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb50fcfa-9d71-4905-a76a-ab7bc149d62b@kernel.org>

On Sat, Oct 31, 2026 at 10:32:32AM +0100, David Hildenbrand (Arm) wrote:
>On 10/31/26 04:03, Samiullah Khawaja wrote:
>> On Fri, Oct 30, 2026 at 03:43:53PM -0700, Andy Lutomirski wrote:
>>> On Fri, Oct 30, 2026 at 10:40 AM Samiullah Khawaja <skhawaja@google.com> wrote:
>>>>
>>>> >On 10/30/26 13:11, Jason Gunthorpe wrote:
>>>> >> On Fri, Oct 30, 2026 at 11:20:30AM +0100, David Hildenbrand (Arm) wrote:
>>>> >>>
>>>> >>> We have the exact same situation when userspace maps anonymous folios
>>>> into vfio
>>>> >>> and then desides to MADV_DONTNEED the pages. Or any other memory backend
>>>> that is
>>>> >>> used for such purposes.
>>>> >>>
>>>> >>> User space must not zap/punch things that might be pinned elsewhere.
>>>> >>>
>>>> >>> That's not specific to memfd, udmabuf, iommufd or anything else.
>>>> >>>
>>>> >>> I don't see a reason to make userspace (that should not shoot itself into
>>>> the
>>>> >>> foot) a kernel feature it must activate itself to not shoot itself into
>>>> the foot.
>>>>
>>>> Agreed, for normal use this is userspace's problem. The seal was meant
>>>> for the kernel to cheaply verify at preserve time that nothing was
>>>> punched.
>>>>
>>>> >>
>>>> >> The issue is live update doesn't preserve those background punched
>>>> >> folios and now we have created an UAF attack on the kernel across
>>>> >> kexec if you don't do something about it.
>>>> >>
>>>> >> There was some notion here that with the right sealing flags we could
>>>> >> tell if everything was 'live update compatible' and then know that
>>>> >> these attacks are impossible.
>>>> >Just remember that there was any hole punch and refuse to live update this
>>>> instance.
>>>> >
>>>> >We could likely implement "we saw hole punch on a pinned folio" as well, but I
>>>> >don't think that's required initially.
>>>>
>>>> If I understand correctly, you mean recording on the memfd that a hole
>>>> punch happened, and refusing the live update if it did? That would work
>>>> and is much cheaper than what we do today, where iommufd walks all the
>>>> mapped pages at preserve time. For truncate, the existing F_SEAL_SHRINK
>>>> is enough or I can record that also on the memfd. I will send patches
>>>> for this.
>>>
>>> This entire situation continues to give me the willies.  After much
>>> prodding and contemplating (in my own brain), I got a friendly LLM to
>>> report:
>>>
>>> --- begin AI output ---
>>>
>>> IOMMU_IOAS_MAP_FILE uses memfd_pin_folios(). Collapse [MADV_COLLAPSE
>>> or khugepaged] checks the old folio’s reference count, so a pin
>>> acquired before that check makes collapse fail.
>>>
>>>  The problematic interleaving is:
>>>
>>>  1. collapse_file() locks and unmaps the old folio, then passes its
>>> reference-count check (mm/khugepaged.c:2446).
>>>  2. memfd_pin_folios() (mm/gup.c:3483) obtains the old folio from the
>>> file’s XArray and pins it, without taking the folio lock.
>>>  3. Collapse copies the contents and replaces the old cache entries
>>> with the new huge folio. It does not repeat the reference check or
>>> freeze the old count.
>>>  4. IOAS retains the old physical pages; accesses through the file
>>> use the new folio.
>>>
>>> --- end AI output ---
>>>
>>> Is this correct?  I haven't personally verified it.  But this whole
>>
>> Yes, I think this is correct. memfd_pin_folios() pins the folios
>> directly without taking the folio lock. Other page cache lookups lock
>> the folio and recheck folio->mapping, e.g. shmem_get_folio_gfp(). Only
>> memfd_pin_folios() misses it.
>>
>> This scenario is different from punch hole or MADV_DONTNEED where the
>> user decides to remove the pinned memory. Here the kernel is removing
>> the pinned page without the user knowing. Collapse already checks the
>> refcount to avoid this.
>>
>> The recent fix [1] by Chris already takes the folio lock for !uptodate
>> folios. I think we can take the lock unconditionally and recheck
>> folio->mapping, that should fix this. I can send a patch for this fix,
>> if folks agree.
>
>I have another patch from Anthropic on my "rework schlop" queue that should fix
>this:
>
>"mm/gup: pin memfd folios under the folio lock".
>
>
>We'd do just what we do in other context now, which is checking under folio lock
>whether the folio was truncated.
>
>Care to send a proper fix?

Sure, I will send a fix.

Thanks,
Sami
