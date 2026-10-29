Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315794;
	b=maShQoXneVP4HvhH6cuQVIXrgYR2yDGtizTR2jlaFE5HifolImO2Cu8QQvQqWiJdkI1I
	 nqJzAGiiTgPXyc3N0ZuF0iwpSaITJBU9jVLjsEdg73VCipkyK30wGxEGtUjM2330p1Y0r
	 91XwjeIEj44pbiPvXaooHA4tMkfTphfHteIWP5ZYIZhL9FVp8sVW7yn1JexQZ2KSwwXpR
	 cqaik8/NCj94ErUF5RZ2AadeuG/eRgNkFwB3cbFE7oAxlu+eBvo37TNtwF5K5IXirgiz4
	 ZU6bEVda9oO0zLTRbsTlg1KBmPFPVfxcO3sdAhUFKvjuRMfm3yAHlbwMRVDVnrdgwtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=3fmE280TvwYgL1SpHpcTgt7nw3en3MelpBcz6M9OOWk=;
	b=lPB1YMFP39nXteIpZ/REbXLkrT7IxCSXwmy4g06lWAZTvUJCQb9SNWfWHq9Qhm0PVYKj
	 E6w0Sa6LjyeTUDZaUGQycQj24yreZpZ/S6jT26tHzaPxPmC11M1aqzzqRYG1RU/VcYeLO
	 CYdcmgpSCSmWKxHLFgwXC4YQlN4Z89uKMVFnS68Tl4+Jed2RTaq3pcqEMu1fZdXzg4Vuq
	 ZMdeLOFY2149+xoGCR6Dc15fMpCzKKNSrTj6N0N782TSYwHWAOs4h4mC7JlsskwHO6o0F
	 dKPJLvbKcqScACCVs3+O1k7YPFyOLbxPQj64191ucGtNUEVm4GHUjCVRz1Rg6th0/jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pkArMhrE;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE9606A31D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 23:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92EE9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pkArMhrE
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so28885ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793315793; x=1793920593; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fmE280TvwYgL1SpHpcTgt7nw3en3MelpBcz6M9OOWk=;
        b=pkArMhrE1jC7hZiUFJ5bFlNREJAg/sMOcRWZOq9fGPBFun1oHDlSrITxDOErkPefMg
         wKP5BsVjYN24s8kTH56YdJ0ePck1+gSp2JP2CBe9i9cKQrci8fnvezDohh4IxqHAQwXr
         FuSYH6xJm4NrElJ5IYikZh0atmfVVDudq8DFYwVZn5YQjqG4pJcpY1xiarMqVGLYsNhw
         2INQvbECPAe6u5CkFosje88KshBFSv2LZ/shCNlaEKyU8jRcz9mngNUaN/+Ls3e46pco
         vXWbIru49VFW3yblEFZ5u+kqFvWKxzYwntufZRBawc24oPtI0it3Xc5kA3QzYYkE8Ed0
         ME6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315793; x=1793920593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3fmE280TvwYgL1SpHpcTgt7nw3en3MelpBcz6M9OOWk=;
        b=l/h1lte1RxBtEk1pp7t72ymCDah24k+2mEggd5C7guivc0hDq3nbHhxDQgPOI/O+S+
         POR0/beZzVpCleuuj76pDmcsDA40Nay2F6aMWDIao4CPJIhbz+NS+2EyphchgHZQsbe4
         tz4tyjxYZ8JyuWBbuwsI8p+fwp9QINSKpI2AxxmnH0WtpMvk1dnmSIjV1BW6UUB1ow5J
         yvYtvQ9W2HbVmEovuIrpKIhJeVGikWm8an7mGX1u9mBFOrXiab1rpRPXtV7dtUYYN+YX
         FDZJfazV3XeucKGKUg/bAonUX0dYb0Jr6sRXbkSIQPGRt+ZdfjDfAnFU0iKOQiwNUFeU
         Rkxg==
X-Forwarded-Encrypted: i=1; AKwUvBxPBmi1R5H0/3h6qagagzmt/2WnykKbHAIF6kFzDeCmvhZKUG1+jNVyPhRPHQ/8KTqFfV/SrhJyQzFiqW2+@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5RR2UfntKx229kz71dT6TFkB0wDbwKx0DwntRUTKlwxhKGGYl
	bN8Mm6/NkzJE5LMcK1lDpmvo8yX64zLbk+MC9O6rhydlhPVfDQNBlqObAEmXIHfeEA==
X-Gm-Gg: AYBFou1s2B9b1q4MLaMxAx8R7O+RRkYXoJ28IQUsDYZXndxXS2JSkI7RlCj5MYSU2VT
	GzYI/nLJId5IIMw4Y2qTxitALZFYzvaU3g+0xLB1KAh8BItmUeICSesT9/6LD9R/hk2q4TiW4Ay
	QTjFilXHF5EbNXew1c/Je3UsrDR4r/e6Po3fZZyAW2KAZKyt812GuzoW+KVxVO5ZAbIn/0I+7xq
	h+WuJDKhQ/kKP89Gad30kON38U2xvA0RAoz5yQrDMLMDOqoE7RuxF/lpCyEZhuUw9bhBRK3RvLR
	ybTf11WjsLaxwsThSVGGypnUDLws/6TrRsH5+Hp0mHH7tX7kv4wgjHCGqj4YkAcqGlelQ+N31tL
	uj3D6zKvCJRgJgj2tSA5bB/aykbMc0NsVzgVoavCPSrV4MZ47yAhtMCRl+uo5UdmCBlpq333WeS
	dxL8jCcfB07fVJWAwKrp/B+08eUlUdskHGm4XG+H6HESdbB/reUrQhw3Gukp9sAEgz9nQoJtbKN
	p/mHCRsj06U+KaeoLR2iJ5ie0Ucso6CErHgojKmjcsh5FnM1TbIWKA7GiFkvba+CM9Q1JtixXsG
	YH7xO3xCZANUBx1th2V1v2M80l6C9VpDimkKZICHPGxkv2OKM+ELnZLAApqHluQCaCxmohCAHSD
	fznTkLKP6eEpezCF+Lyayyg==
X-Received: by 2002:a17:902:d2ce:b0:2eb:188a:1c06 with SMTP id d9443c01a7336-2eb1ec12e12mr7097365ad.9.1793315792099;
        Thu, 29 Oct 2026 16:16:32 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84542a13sm1362240a91.5.2026.10.29.16.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:16:30 -0700 (PDT)
Date: Thu, 29 Oct 2026 23:16:27 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
Message-ID: <auPKfqh_YjRU9Ui3@google.com>
References: <20261026220546.3114241-1-skhawaja@google.com>
 <CALCETrXNEWQNPjtuHnTfVFOafeJ7APXq288Cq16Q5adDNYx9+A@mail.gmail.com>
 <auEksxfAi9lHFXmT@google.com>
 <CALCETrXDY2e8x2kdr-FQvFLs-Y7FwNozXGDvqqM6yvVA7QLV3g@mail.gmail.com>
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
In-Reply-To: <CALCETrXDY2e8x2kdr-FQvFLs-Y7FwNozXGDvqqM6yvVA7QLV3g@mail.gmail.com>

On Tue, Oct 27, 2026 at 08:57:29PM -0700, Andy Lutomirski wrote:
>On Tue, Oct 27, 2026 at 3:55 PM Samiullah Khawaja <skhawaja@google.com> wrote:
>>
>> On Mon, Oct 26, 2026 at 03:46:34PM -0700, Andy Lutomirski wrote:
>> >On Mon, Oct 26, 2026 at 3:06 PM Samiullah Khawaja <skhawaja@google.com> wrote:
>> >>
>> >> This series introduces F_SEAL_PUNCH_HOLE, a new memfd seal that prevents
>> >> holes from being punched into a shmem or hugetlbfs memfd while leaving
>> >> the file fully writable.
>> >>
>> >> Background
>> >> ==========
>> >>
>> >> Drivers such as udmabuf and iommufd (via IOMMU_IOAS_MAP_FILE) use
>> >> memfd_pin_folios() to pin the folios backing a memfd and hand them to a
>> >> device for DMA. Pinning keeps those folios allocated, but it does not
>> >> keep them in the file. If userspace later calls
>> >> fallocate(FALLOC_FL_PUNCH_HOLE) or madvise(MADV_REMOVE) on the range,
>> >> the folios are dropped from the page cache while the device continues
>> >> to use them. The pin holder is never notified, and from that point on
>> >> the device and the file silently diverge.
>> >>
>> >> The existing seals only partially address this. F_SEAL_SHRINK prevents
>> >> pages from being dropped by truncation, which is why udmabuf requires
>> >> it. Hole punching, however, is only blocked by F_SEAL_WRITE and
>> >> F_SEAL_FUTURE_WRITE, and both of those also forbid writes. That makes
>> >> them unusable for memory that must stay writable, such as guest RAM or
>> >> DMA buffers, and udmabuf explicitly rejects memfds that carry them.
>> >>
>> >> Proposal
>> >> ========
>> >>
>> >> F_SEAL_PUNCH_HOLE fills this gap. Once it is set,
>> >> fallocate(FALLOC_FL_PUNCH_HOLE) and madvise(MADV_REMOVE) fail with
>> >> -EPERM, while reads, writes and resizing are unaffected. Combined with
>> >> F_SEAL_SHRINK, it guarantees that userspace cannot remove pages from
>> >> the memfd while the memfd remains writable.
>> >
>> >How does this solve the problem?  F_SEAL is about a userspace
>> >contract, and if there are existing users of the APIs in question, it
>> >makes very little sense to start making those users fail because they
>> >haven't taken the appropriate seal.
>>
>> It doesn't change any existing behaviour, nothing starts failing for
>> users that don't set the seal, and drivers wouldn't require it. It's
>> opt-in. Userspace that wants the guarantee seals the memfd, and a
>> kernel user that pins it can check for the seal and rely on the pages
>> staying in the file. For example, the iommufd live update path could
>> skip verifying the pinned pages at preserve time when the seal is
>> present,
>> and do the full check otherwise.
>
>Can you clarify the API you're proposing and the issue?  It seems to
>me like the user is expected to preserve HWPT state by creating a
>memfd, then using some new API to tell the driver to "persist" its
>state into the memfd (possibly by binding its existing state as folios
>into the memfd)?  And userspace is supposed to seal the memfd against
>growing and shrinking but not against writes?
>
>What if the user writes to the file?  What if the user populates
>pages/folios into the file before using it to preserve HWPT?  What if
>the user mmaps the file?
>
>Have I understood this correctly at all?  Why does memfd make sense?
>If the goal is to attach a bunch of pre-existing pages to a file so
>that the page preservation machinery can preserve them, wouldn't it
>make more sense to have a handoverfd mechanism where the kernel can
>make a handoverfd that stores its purpose and logically represents
>some pages but does *not* allow read or write or fallocate or any
>other user operation that actually acts on the data or its memory
>layout?
>

Not quite. Let me elaborate my use case.

For live update we need to preserve HWPT (iommu domain) so the devices
can continue to do DMA during live update. Domains are preserved by
preserving page tables and relevant data structures using KHO.

To make sure that the devices can only DMA to preserved memory, the user
preserves the memfds (into KHO) that are mapped in the preserved hwpts.
During iommufd preservation we need to check that the memory backing the
iommu mappings is preserved. We do this by checking if the mapped memfd
is preserved, but if the memfd had a hole punched into it before its
preservation then the punched pages will not be preserved. For this we
need to do a complete page table walk and test each page separately.

A punch hole seal, before the memfd preservation, allows iommufd to
optimize the validation path and avoid doing full page walks.

The HWPTs are not preserved into memfd; the memfds are mapped into HWPT
and we need to make sure that the mapped memfd has not mutated and the
pages mapped from it are preserved. Also it is ok if the user writes to
the file or mmaps it.

>>
>> https://lore.kernel.org/all/arVYa_90j0oN1hnu@google.com/
>> >
>> >Would it make more sense for the drivers in question to set some flag
>> >(refcount?) on the file to block hole punching?  Or perhaps to have
>> >the hole punch code notice that it's trying to punch out a folio that
>> >is pinned or otherwise referenced and to refuse to do it?
>>
>> The pins already keep the memory alive while it's used for DMA; the
>> problem is only that the page silently stops being part of the file.
>> Refusing to punch pinned folios on every file would change behaviour for
>> existing users: fallocate() would start failing whenever a page is
>> pinned, even briefly by O_DIRECT. A flag set on the file by long-term
>> pinners would avoid the short-term case, but it would still make punches
>> start failing for existing users of those drivers, which is why I went
>> for an opt-in seal.
>
>Wait a moment here.  Given my comments above, I'm not sure this is
>relevant to this patchset, but...
>
>As far as I know, right now, a program can open a file, register some
>of its pages with io_uring or RDMA, and then use io_uring or RDMA to
>write to those pages later.
>
>And another program can open that same file and use fallocate to punch a hole.
>
>And then the first program thinks it's reading into the file, and it
>ends up not reading into the file.  Which makes the hole punch
>operation rather different from the write-zeros operation that it's
>supposed to be a fancy version of.
>
>Now this doesn't sound like a security problem per se, since the
>offending hole-puncher needed write access (admittedly that write
>access is only needed at hole punch time, not in the indefinite future
>when weird behavior happens).  But this whole sequence seems highly
>suspect to me.
>
>Are you *sure* it wouldn't make sense for a GUP'd or similar reference
>(whether pinned or not) to *actually preserve that folio's status as
>part of the file*?  Or maybe for there to be an extra pin bit to do
>this?  Because the current behavior is pretty strange.  And I'm not at
>all convinced that anyone would really object if the kernel prevents
>hole-punching a range with an active GUP, especially if this behavior
>is restricted to writable GUPs.
>
>I admit that truncate seems slightly different in the sense that it
>seems more likely that someone would be annoyed by an inability to
>truncate a file.  But still, truncate does have the same issue.  Maybe
>extending a file could notice that there is still a folio covering the
>newly extended range and stick that back into the file?  Seems messy.

For live update either approach works. If pinned pages cannot be punched
or truncated, iommufd can rely on that directly and the seal is not
needed. I went with an opt-in seal only to avoid changing existing
behaviour. If folks are fine with blocking punch hole and truncate on
pinned pages, I can send patches for that instead.

>
>
>-- 
>Andy Lutomirski
>AMA Capital Management, LLC

Thanks,
Sami
