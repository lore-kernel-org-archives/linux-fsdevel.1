Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141725;
	b=ZMS4IyWPmkj3zwNDOlobOmOzWSfBKR7czhxzJidWyv14wEDg1LQDaTf9eAHEN7wlOFKb
	 HCeZn5H0xxoZIg62EcuCJJpcPyjkAOciWW27XTGNZQKxwI/JH79WUgHBu3ZCWnV2B/87i
	 +LUBldg9wSCrnHXwq4t+JZ6hEwAWKcZI3Z5rxBFhuifnxsk3GNA9UJ+uucye2emJSEfO6
	 ms9WYCfZtK4eT/5SPrQS6Mb9yGwcL6yb9NUJVSB6ssgZ+w/MK5enFxWmtRg643Nc5gj2U
	 Q68sLe7H+3jCfQ63z4nolUur6TyKdnIVOuw2VQJwfwLV1GIb6Ct85KsTVz1gMRZYCNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=KTV8eg2on2B99kAeZJ8uQmhlFR662/OZM2R8QtayN34=;
	b=QnjSs34frK2k1s/9RP0K2wmmAJP+TLYQRmxAH3LX1za3Pl1joLQtmEa3dKzuS95OIdaU
	 lfmcjiOfK0Pol6/WvnSCDvaBqj4+z6c3CrRj/w3Ema1oLBmPYkQDRALrOeU7Vh4q22q9L
	 lpO2OcoxGW8WyQeWQguFgiQTatxx3t7wraFqSvNlWRKxHM6fVITFOiWPJh3ntbP1uhaAp
	 ymBoUF4vkIsL5Da6Gaye8mfreIIOMRFc+kupuLTpz+Q00ILxvXO3k7ekN7opprC1rfykv
	 YKihQdHJBZiRRJubMhe3w5Eagecq4IZAAbsEoFso4NR2j9+hyx+PI2divXfndeQi9/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DC3FJv8+;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F3606A329
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 22:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 757F3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DC3FJv8+
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2db33db4de9so27095ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793141725; x=1793746525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KTV8eg2on2B99kAeZJ8uQmhlFR662/OZM2R8QtayN34=;
        b=DC3FJv8+i3On134fP2jAv4hX43hfN+7oCq00cQxNIJfVMQaiGXTB9eJvWw3odQ2Ogc
         oTfb5SDyzrAtranJahrV7HJLjnFqzp/UATmFYw1gOq4AD15jqGjlzDsZ+eVthKApk/ga
         Cv5KzWzWMSynaBKwZZEIMhz17QQ2BQ0VQDR/VATKEwtM/9a1I23xpnESAeT7xsZRE5dW
         +r8akfqeupcuBAFwvLH5L1o9fPyb4hy5MrE8mAgQKUgvz7kFR9JRX279bOpLNKmth5sl
         XPtvz5eOAEh1COKBQIqY0XpTtlCCy45xdU4CRSVdY8NC97nsctjiaMG5KNBGZv/sHii8
         vRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141725; x=1793746525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KTV8eg2on2B99kAeZJ8uQmhlFR662/OZM2R8QtayN34=;
        b=0exj6TCyBpQjPv0IbLnLBb2oSw8kYvdIFjX6Ly4WDW/EsFvZN5baFeIfcUg9fiShYi
         Yn0omO4Z63HktUNxBjMbS9gXfyXAI7WICqCBcG176qnhI51BzOJDQzwDryqQJ95X0NTH
         Wj783rp9ywPXuIPVCimL96nPlZKngIMK6AzUU8/7yE8iFAZ35Qe4Jf9RCLQNFb03ZvIw
         xZUOXwJ7rQyMjz53VkS0pvoH1xtx4/A8K8O3vPg22Nq+pTmuvORqwCwQPh/imeeEnyyX
         7fpS/ZlEWgtChZDjzSRpXqCgd/vnngAtnga2bpJ0imcSeeclSWkAM5WdtFx2qVcA02hC
         04nA==
X-Forwarded-Encrypted: i=1; AKwUvBxwOmBnIIEnQ6H0ZtroqG8opxgX9HySQ5w4cw7GTDhsZ3Pr6yty8A+yOLWNjPDb9vEVErqa+L8jMSfW0FM1@vger.kernel.org
X-Gm-Message-State: AFq9FYLAsc0SvHQD1PtO/heBLxF/WSM/NvSjf4pxPq6SdZbHPCrBzN4y
	iVmTWMX1BF1L3p57Wlhd8ITJV05h7bt29UKPZ8bM2vCrqmLsIn+amPCXBqlfEA43Dg==
X-Gm-Gg: AYBFou1u2Fn8UkvmjLQKAhpBaWFmksPq8Sd/O2UlZZ9p8JS/9HGxBpkWN4RzXS6y3sX
	MgqUB8vb7dDhYvOr+2GCS1GqErmw0yIxgSofFerLC7CAyIQTT/UEkMxF219m9qw6U1ACf4HCw5A
	PAiTyznoZS/gQcf37A7gAldSeT5UKWWyricmm9c+16FOXag6DHDvLFEEQeHtlRz5SoYhtfSR+8A
	csT+hWALrFDYxbpqNa3aO/TijjtsoFqZb4qbZUmFZ3ReXEiTAZvzDoMTBb5CvtRO9J74iLBPt54
	B/bwWa9mGesJqsaDSb519WCmlf7Ag1NL4RwKZHh5fIy7cybyzBsl81tDqhXnaxbEbVAGBuDjlBX
	ZuBrUU9C+FjOwLxBwEyjvuhJe3MQ/R4lECrkpamsk+P5D38lgSBw+GlRE54LaIotouVv5CKi0nu
	7xdyBUuZoNuysCT3JW1bIo/CkamOczyvSZf0gT1dWX876xpzTYR6RegKBysWJJ/r1YLwevujxnj
	uuI9/ZXh9dL53JxRJTBzZ8rzbAqFn22O6FTnAlaCDONyauFClqj5f89Kme86co8utwXXQvSErTY
	OjJXW+tQJMJiobBhAD01EWm2I1wB73cva0O2mWaIitemPbNZTFIYsTANx84Ta7TxgkSKXgPMhR3
	j6e7NlD1byG2mgdl/ufrx+w==
X-Received: by 2002:a17:903:11c6:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2eb0029f8a1mr1832445ad.2.1793141724187;
        Tue, 27 Oct 2026 15:55:24 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662e1fcsm516911b3a.30.2026.10.27.15.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:55:22 -0700 (PDT)
Date: Tue, 27 Oct 2026 22:55:18 +0000
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
Message-ID: <auEksxfAi9lHFXmT@google.com>
References: <20261026220546.3114241-1-skhawaja@google.com>
 <CALCETrXNEWQNPjtuHnTfVFOafeJ7APXq288Cq16Q5adDNYx9+A@mail.gmail.com>
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
In-Reply-To: <CALCETrXNEWQNPjtuHnTfVFOafeJ7APXq288Cq16Q5adDNYx9+A@mail.gmail.com>

On Mon, Oct 26, 2026 at 03:46:34PM -0700, Andy Lutomirski wrote:
>On Mon, Oct 26, 2026 at 3:06 PM Samiullah Khawaja <skhawaja@google.com> wrote:
>>
>> This series introduces F_SEAL_PUNCH_HOLE, a new memfd seal that prevents
>> holes from being punched into a shmem or hugetlbfs memfd while leaving
>> the file fully writable.
>>
>> Background
>> ==========
>>
>> Drivers such as udmabuf and iommufd (via IOMMU_IOAS_MAP_FILE) use
>> memfd_pin_folios() to pin the folios backing a memfd and hand them to a
>> device for DMA. Pinning keeps those folios allocated, but it does not
>> keep them in the file. If userspace later calls
>> fallocate(FALLOC_FL_PUNCH_HOLE) or madvise(MADV_REMOVE) on the range,
>> the folios are dropped from the page cache while the device continues
>> to use them. The pin holder is never notified, and from that point on
>> the device and the file silently diverge.
>>
>> The existing seals only partially address this. F_SEAL_SHRINK prevents
>> pages from being dropped by truncation, which is why udmabuf requires
>> it. Hole punching, however, is only blocked by F_SEAL_WRITE and
>> F_SEAL_FUTURE_WRITE, and both of those also forbid writes. That makes
>> them unusable for memory that must stay writable, such as guest RAM or
>> DMA buffers, and udmabuf explicitly rejects memfds that carry them.
>>
>> Proposal
>> ========
>>
>> F_SEAL_PUNCH_HOLE fills this gap. Once it is set,
>> fallocate(FALLOC_FL_PUNCH_HOLE) and madvise(MADV_REMOVE) fail with
>> -EPERM, while reads, writes and resizing are unaffected. Combined with
>> F_SEAL_SHRINK, it guarantees that userspace cannot remove pages from
>> the memfd while the memfd remains writable.
>
>How does this solve the problem?  F_SEAL is about a userspace
>contract, and if there are existing users of the APIs in question, it
>makes very little sense to start making those users fail because they
>haven't taken the appropriate seal.

It doesn't change any existing behaviour, nothing starts failing for
users that don't set the seal, and drivers wouldn't require it. It's
opt-in. Userspace that wants the guarantee seals the memfd, and a kernel
user that pins it can check for the seal and rely on the pages staying
in the file. For example, the iommufd live update path could skip
verifying the pinned pages at preserve time when the seal is present,
and do the full check otherwise.

https://lore.kernel.org/all/arVYa_90j0oN1hnu@google.com/
>
>Would it make more sense for the drivers in question to set some flag
>(refcount?) on the file to block hole punching?  Or perhaps to have
>the hole punch code notice that it's trying to punch out a folio that
>is pinned or otherwise referenced and to refuse to do it?

The pins already keep the memory alive while it's used for DMA; the
problem is only that the page silently stops being part of the file.
Refusing to punch pinned folios on every file would change behaviour for
existing users: fallocate() would start failing whenever a page is
pinned, even briefly by O_DIRECT. A flag set on the file by long-term
pinners would avoid the short-term case, but it would still make punches
start failing for existing users of those drivers, which is why I went
for an opt-in seal.

Another option, closer to what you mentioned, but opt-in, is instead of
sealing the whole file against hole punching, a seal that only protects
pinned pages. Punching, shrinking and truncating keep working on a
sealed memfd, except where they would remove a page that is currently
pinned; those would fail with -EBUSY. Files without the seal behave
exactly as today, so existing users are unaffected, and pinned memory is
guaranteed to stay part of the file.
>
>To some extent, the issue you're describing is maybe broader than just
>the APIs you're contemplating.  If I open a file and then do something
>in thread A that GUP's the file and punch a hole in the file in thread
>B, I'm doing something weird, and I can imagine plenty of ways it
>could go wrong.  (Especially if it's GUP for write.  I hope we already
>get that case right.)
>
>-- 
>Andy Lutomirski
>AMA Capital Management, LLC

Thanks,
Sami
