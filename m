Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793415808;
	b=yOAGw3XITDXPvLBdUQGOzeIf1/YVg5yJ4lJSdJHQxi0s4FSxVNjEnG0/KZgL4XOHCeVo
	 KUuhFu+mURIJzEDVPZQZ/+dsGvDvCN9A98nH8CnjvWdW/gHgJg8/seRW+uj1F96iftDvi
	 rwQ7Vkox/emIEXHtescztmzy4LojIrDRooNB60CMqQtGcqos5AD5xavMgyTxSdqQUeWwJ
	 h7ry/HGancac25V7ahlxPPPG0RFeOtf/ArUBkn8dEHzdD1HEe3HH13L/+8t2k8k9oC89v
	 7AYhmQQdwrxmCxjC3h7PlhulLiz9b8HrAg33QAuWdWD+W4I0Bm2Pg7MKPb7XvMTRxIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793415808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=CykDRQmyupGap9MJ8JD7H5K9Ycd/s3V7wlgI2ffH55o=;
	b=12PehhlrmyfHxycvmPg681ZzITV1ELmYzIOrryR6HCzKZwwDKW06shfl5Grq0qRalfrs
	 bCFnrXUFCJ6XwmARv89qBSqQyi/2fhHvj823sZSnbVRu76BjX7d5px0xeF/98MXjJGunv
	 rsbWkrgyMY13AEIF2hchW/ccvNv+rUsGbF2Nf6vGci7A2czrf1Slw/xIcap4LNVEOtxps
	 S6Rj7RtAGniS427krHoOslhsefCKZ3n2NsZ7PM4Fhw3bQBDsPCzqFeXzmRWd26U06DQwr
	 ajkMkMQqN+OEiLLlPMO08oeR3kqXfCZcnSILPkZguiFT2cRgmB61SlLOUXY0J+mfmNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W9M2eNVq;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347CD606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 03:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 347CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W9M2eNVq
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so27515ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 20:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793415807; x=1794020607; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CykDRQmyupGap9MJ8JD7H5K9Ycd/s3V7wlgI2ffH55o=;
        b=W9M2eNVqGDvnd6v/5r9OUqnw+qzQQykMbnpeCsUIdhVBWnVu4c0e4mxbP8S+5Ch5TQ
         UNV6HFUjENL+G4Mpexvpqm8QjQq2CPsh4xag+HJLLqLaTOE4CNcUrqHQ+XLGrmMIwWUG
         KrNYM2VnYVSJCafdXRdBRDAtgiOhOKDOmXbeePa/ubYxpcXm9gOiFYwinyfrf9LqhJbq
         DAKW7anXdBpummBWPaUftfsJKuq0ZW62MC/UeMEwhmaIn3FZ+bvgeXeJAj3DR2byJwfx
         DFYneQFULA+hyoq+IHqtql3KTMhJrb+WvzFMmPqyEQODXp3x2/zaODOe9saWCjOJO2eb
         0CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793415807; x=1794020607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CykDRQmyupGap9MJ8JD7H5K9Ycd/s3V7wlgI2ffH55o=;
        b=Q+dyEwTT+y+JoRJkWJlb/+9TdNDKf0WtzKmScK3RTCMqX/UNzY+4MKCS3iP+5AQnsR
         dDzk46tbOGnZdpTkHQWVDstteYHUGggvZpUERw680UsIpycyXes+l8/xfZhAiYgwQYtY
         dC09xJe7D5EXhQxxMmIoYudV19RMjqZdfxq/kZfVQ7QHLF9OWS++re1FwYX5iQuIiY6Z
         HcFBdBS4ewrIQAYOyn0YLh/RvMEm8UlF9CdfDO04fMZbK4Vk9sayC5hT9SZtv5G6xpGJ
         JTtES6uYeWKbd/XvQG8npsX8/PMhUc3GcFFWaO1BT5NSBJ8V2U8yAvaaNvrG3f+uvuaY
         Q+jA==
X-Forwarded-Encrypted: i=1; AKwUvBx87zrvx6jFhvRZnTXr9pU/l2Sx6tnvBe/sDX8CaDoDS9SqdX1oppgjhdDhil1A1zczlMzzTYbmnztVlqw8@vger.kernel.org
X-Gm-Message-State: AFq9FYIVugbNwI3dWJf229KYcL9JtXYfLkdLZ+aMEI5SzfRziI0kmng9
	lx/oS7NLJjH46/l/2a7Yh6OUlqNTF7ZQ3AEUk2g08X1dQ7Jt+LSR7L3UV5LWmd7pcw==
X-Gm-Gg: AYBFou3ODYiV5Q7qZytiUW0qrrd6BrviX5irhbmUF9MHhrWIFA0SkdyPqj56O+bGtm8
	OCw6cVjW2gkm3uHUIXh8RakZTH3X1VEYzthd4qRscgwqrgV4SP97wXJ3MAj0xyzVqt29Nceiw3d
	3nE4dk7GsfLnDCx0Nd63hDD/vcDLyeYT8WIcPALOOLXGgReCF13uLM+nvRML8AtmhmOVKV5NRnq
	HYXWQvQEu8YTgXPGu4MXXOEFWaPavlPg7eSAiJxoPlzt0yF67vhVCkO9Fl8DfxduqGqCzaaMrH7
	E4NvI5ocez7s4zEyrc7/IQbcnYewJcX6+82KvbW4zG+AOSSe1Gdbm8urYfl/XzLywI17hD0NmHV
	73tBWgMToPIIn9d46rQhF+3oiR+27XDJQT8AVP1Fos79A3Z47TJkYh4T3Qy54MNTXhObkVvHupa
	FVqwvEHLhtWii2q2y1bI1gGHkV0SKz7fu3FbjrQksxBPKnw3ovV5yH9luWq5cg3oFM6U6TxBG0t
	vKtKitnrb4OLutdJJVH24XNlTN/An8pSSyBX+OWQz5fRrdFk4eUV0KRARmtnZ+hW3G+G3/TK0zc
	7plkihRg0p+4B/GQa/ZzlAqk9V8iPOp5nNttti0dj2aE6MU58BGTqGAa9176vSB6VuBE3DqGHT+
	SL0OLG+fbHfZ1FAzrJOZHeUXhmtaOfSg5iKyLyUlEmME=
X-Received: by 2002:a17:903:2c04:b0:2c9:b404:b55 with SMTP id d9443c01a7336-2eb1b8c1cddmr13716365ad.6.1793415806880;
        Fri, 30 Oct 2026 20:03:26 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm5927972a91.6.2026.10.30.20.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:03:25 -0700 (PDT)
Date: Sat, 31 Oct 2026 03:03:21 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Shuah Khan <shuah@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
Message-ID: <auVRLPmbWYvMnly-@google.com>
References: <20261026220546.3114241-1-skhawaja@google.com>
 <d4891333-43ea-4d74-9fb9-6ad8dac1a446@kernel.org>
 <20261030121113.GB3889730@ziepe.ca>
 <2c7aa5c1-3af3-4654-b244-1257d05c9d45@kernel.org>
 <auTR9SnDLsLVmnJ7@google.com>
 <CALCETrV5eqg6d9=+BQhCpRwBNe3aCQiut8vxPBs8b7PToqjaHg@mail.gmail.com>
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
In-Reply-To: <CALCETrV5eqg6d9=+BQhCpRwBNe3aCQiut8vxPBs8b7PToqjaHg@mail.gmail.com>

On Fri, Oct 30, 2026 at 03:43:53PM -0700, Andy Lutomirski wrote:
>On Fri, Oct 30, 2026 at 10:40 AM Samiullah Khawaja <skhawaja@google.com> wrote:
>>
>> On Fri, Oct 30, 2026 at 03:39:40PM +0100, David Hildenbrand (Arm) wrote:
>> >On 10/30/26 13:11, Jason Gunthorpe wrote:
>> >> On Fri, Oct 30, 2026 at 11:20:30AM +0100, David Hildenbrand (Arm) wrote:
>> >>> On 10/26/26 23:05, Samiullah Khawaja wrote:
>> >>>> This series introduces F_SEAL_PUNCH_HOLE, a new memfd seal that prevents
>> >>>> holes from being punched into a shmem or hugetlbfs memfd while leaving
>> >>>> the file fully writable.
>> >>>>
>> >>>> Background
>> >>>> ==========
>> >>>>
>> >>>> Drivers such as udmabuf and iommufd (via IOMMU_IOAS_MAP_FILE) use
>> >>>> memfd_pin_folios() to pin the folios backing a memfd and hand them to a
>> >>>> device for DMA. Pinning keeps those folios allocated, but it does not
>> >>>> keep them in the file. If userspace later calls
>> >>>> fallocate(FALLOC_FL_PUNCH_HOLE) or madvise(MADV_REMOVE) on the range,
>> >>>> the folios are dropped from the page cache while the device continues
>> >>>> to use them. The pin holder is never notified, and from that point on
>> >>>> the device and the file silently diverge.
>> >>>
>> >>> We have the exact same situation when userspace maps anonymous folios into vfio
>> >>> and then desides to MADV_DONTNEED the pages. Or any other memory backend that is
>> >>> used for such purposes.
>> >>>
>> >>> User space must not zap/punch things that might be pinned elsewhere.
>> >>>
>> >>> That's not specific to memfd, udmabuf, iommufd or anything else.
>> >>>
>> >>> I don't see a reason to make userspace (that should not shoot itself into the
>> >>> foot) a kernel feature it must activate itself to not shoot itself into the foot.
>>
>> Agreed, for normal use this is userspace's problem. The seal was meant
>> for the kernel to cheaply verify at preserve time that nothing was
>> punched.
>>
>> >>
>> >> The issue is live update doesn't preserve those background punched
>> >> folios and now we have created an UAF attack on the kernel across
>> >> kexec if you don't do something about it.
>> >>
>> >> There was some notion here that with the right sealing flags we could
>> >> tell if everything was 'live update compatible' and then know that
>> >> these attacks are impossible.
>> >Just remember that there was any hole punch and refuse to live update this instance.
>> >
>> >We could likely implement "we saw hole punch on a pinned folio" as well, but I
>> >don't think that's required initially.
>>
>> If I understand correctly, you mean recording on the memfd that a hole
>> punch happened, and refusing the live update if it did? That would work
>> and is much cheaper than what we do today, where iommufd walks all the
>> mapped pages at preserve time. For truncate, the existing F_SEAL_SHRINK
>> is enough or I can record that also on the memfd. I will send patches
>> for this.
>
>This entire situation continues to give me the willies.  After much
>prodding and contemplating (in my own brain), I got a friendly LLM to
>report:
>
>--- begin AI output ---
>
>IOMMU_IOAS_MAP_FILE uses memfd_pin_folios(). Collapse [MADV_COLLAPSE
>or khugepaged] checks the old folio’s reference count, so a pin
>acquired before that check makes collapse fail.
>
>  The problematic interleaving is:
>
>  1. collapse_file() locks and unmaps the old folio, then passes its
>reference-count check (mm/khugepaged.c:2446).
>  2. memfd_pin_folios() (mm/gup.c:3483) obtains the old folio from the
>file’s XArray and pins it, without taking the folio lock.
>  3. Collapse copies the contents and replaces the old cache entries
>with the new huge folio. It does not repeat the reference check or
>freeze the old count.
>  4. IOAS retains the old physical pages; accesses through the file
>use the new folio.
>
>--- end AI output ---
>
>Is this correct?  I haven't personally verified it.  But this whole

Yes, I think this is correct. memfd_pin_folios() pins the folios
directly without taking the folio lock. Other page cache lookups lock
the folio and recheck folio->mapping, e.g. shmem_get_folio_gfp(). Only
memfd_pin_folios() misses it.

This scenario is different from punch hole or MADV_DONTNEED where the
user decides to remove the pinned memory. Here the kernel is removing
the pinned page without the user knowing. Collapse already checks the
refcount to avoid this.

The recent fix [1] by Chris already takes the folio lock for !uptodate
folios. I think we can take the lock unconditionally and recheck
folio->mapping, that should fix this. I can send a patch for this fix,
if folks agree.

[1] https://lore.kernel.org/all/20261029-fixes_core-v2-20-a64ce7f83abb@kernel.org/

Thanks,
Sami
