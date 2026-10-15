Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20A5275A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072095; cv=none; b=sEO1oEQuDniDjOSqZjhMQa+VA+5Ks6PklEYmt8aUnFsENuQcBkHyDKv7EtvdMVrqX6WgJq09FD89Y8U8E/FfthYcy1m/qrSKLPEbSugYVHIcYdPqRZokKL6saC7MxSJja64C+vN8mfA/uSQfbT4UEP0jFwCogD1ffclik6iBF0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072095; c=relaxed/simple;
	bh=/nk+BfkEgTJrPJRefeazVKcxt5H1TBsjREb4AnG69FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppwn5P8Sik3uGDmB94m0MeJ8D8qt8TqUdk2GyGiZPrJuu8MSIptNv9EtiHjwbagBWqGSbMhL5PvEjRFmuB6XT9htfZWFLfar2DRww5A3UL4Fia3rnfH5FgeruehIs8sfpx4tZo4w7YArDq95VirTGY7GmrzFPN74LuNg3nK7+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EgRpUvEa; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EgRpUvEa"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91b63bd2030so63763516d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792072093; x=1792676893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TxnvmrOxX1kKFV6pDOanox6haeqxL61LHWivdGG7JgE=;
        b=EgRpUvEaHVBa7pUx/Qu4/VTWlGU+KEBl8VcNDwr26ZDQS2y0jr4htlBD1JemjBfd9f
         TbEFCTJ0nTnaxcIm05gMRWwYjRjfvUABdnfXCdd0x691HU4hsMc9+eM3VaVq2/xccBtO
         ndRsaYuipLtnwsuaV6nYBtv8Cmiq14WqfqohXsR6W9RSTO1GgDIXAb6XuEsmY9aTTArc
         ohOCEboLVTx5NRrLNYXillrRCTYqDUA64aizGO4KyJ2UAbv0euHWeDKJ+wcwlyogHBdB
         QI3yNBOqbwqEf3DOFVfU9SHIQIv8QzokbiFmZizRT2gjJOvi6cJ95jGEM33i+7HNfu/h
         EvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792072093; x=1792676893;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TxnvmrOxX1kKFV6pDOanox6haeqxL61LHWivdGG7JgE=;
        b=kRSoZlDfGqGt45mlnEDg9YJzRe9L1lOLMEnlv/tC9IX3xaTGEyoQGEAUd5HvRJX0qJ
         AQDqTzcW3X9din5yYTqKFhivA8wBWUtB5yoOGUIlzaoZ7DRS0pT6hAGqqjF6Hojc5LkC
         4mJnHIVuYbrj4XRdYMkf32bLfBztSY8jaYqOsAScDK2bnybO/RDZjVOVbF5gJ9L85KkV
         6gtEnRyuOCbk+gjen5qAZP9T5Nb465lyXBemt4Td5JcMwv2VRtlBCbAkN38EzOev6HkD
         rlNDHe9Hm4DnwsRzR62Lvsm5ueam2al2GW6U6F22SCFrnzVxFLFbWtCUQSJqsZwKwrqf
         2lgQ==
X-Forwarded-Encrypted: i=1; AKwUvBx572nbHHJkZSQoyJiM3rU5wfZyNrCdmlk8+eECFkUDIMiRgwo8EUoTHQ6wJ0gfZQLYUS/HV97Qwrsbai8I@vger.kernel.org
X-Gm-Message-State: AFq9FYKx/gOuqYxdFFC+4T0KW2oyuj0HMAFUCzIKU6+wnPKATJYtJA8k
	ocVSmcFCVm+sfeKJ3m3vlB16EXChW7LZY3OhRkdroZZPdwKaywcbHsLKQWK52YWHSl4=
X-Gm-Gg: AYBFou14ub1zlLuDUOG+IjJGYeL5+4zEja1IUp2/bU3/K1tLWtrR6Ak4egfKKRgA4le
	4OYagmlJkTri5U8+bE649i/g8iBf6x4Hr6PR6d1R14pppnWj6Unj6g4o3NECaPLV4CgJBjoIntx
	KC2Fxc6VGZQMsYhYHdhYIDZ0LCVyrmmbneZOD60kOKNBaMmzqf8RXmE/SWjSb9ykRDfqxXpXuFw
	dMnqBbI/VPQvqGqkaI6Td97yOaMF5EIspaZwkPOHdnpsRAXSFnx1novKEjosv6Oz/tK/WFPYih8
	Iy6XDI/4WLiTtwczXIDc/ilw3krBfqP/mTjZ6zhB4ZYWij+Lqq0TRQ97/KSiMI7psb8QMpzrwnc
	HuKANYyoOD5SX64IIIa5hTB9O01mhco7MW2T+JUzNBA9FNZHybLj0RVpHV+eQ1NFkADoywzokwq
	lWrt0xoz3fXItHn0yZ4PxQ3yMdYJIvvW3EYH17/KQNCxyrAvJhlfjU3BV66KctqH0MS/zPt14Y2
	65tJj0RUo23KsaM8AeMyL+jbIfZAPk15k8n0o17+xxIYb+UojsNDWg=
X-Received: by 2002:a05:620a:4606:b0:93e:c12c:f12d with SMTP id af79cd13be357-93ec12d0608mr3020561585a.72.1792072092737;
        Thu, 15 Oct 2026 06:48:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50b6c4fsm760019685a.47.2026.10.15.06.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:48:12 -0700 (PDT)
Date: Thu, 15 Oct 2026 09:48:10 -0400
From: Gregory Price <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	willy@infradead.org, brendan.jackman@linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, jack@suse.cz, akpm@linux-foundation.org, 
	ziy@nvidia.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	ying.huang@linux.alibaba.com, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org
Subject: Re: [RFC PATCH 0/6] mm: pass alloc_flags through folio, filemap, and
 bulk allocators
Message-ID: <atDYiLYjF_Phxy-h@gourry-fedora-PF4VCD3F>
References: <20260923211041.3127588-1-gourry@gourry.net>
 <asdTptfeLkuypU8t@gourry-fedora-PF4VCD3F>
 <df588805-6f97-4ef6-a64f-39222669bf3a@kernel.org>
 <asloWFM96BATH8SB@gourry-fedora-PF4VCD3F>
 <1f36992d-00c1-4f74-9947-b543ed794cf0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f36992d-00c1-4f74-9947-b543ed794cf0@kernel.org>

On Thu, Oct 15, 2026 at 12:02:06PM +0200, Vlastimil Babka (SUSE) wrote:
> On 10/10/26 01:28, Gregory Price wrote:
> > On Fri, Oct 09, 2026 at 10:55:05PM +0200, David Hildenbrand (Arm) wrote:
> >> I do agree that two sets of flags is suboptimal, but likely more flexible. I
> >> guess an alloc_flags only interface is not easily possible ...
> 
> Agree with the alloc_flags option of all the other options.
> 
> >> I do wonder whether it should be:
> >> 
> >> 	typedef int __bitwise alloc_flags_t;
> >> 
> >> instead of "unsigned int alloc_flags".
> >> 
> >> ... while at it
> 
> Can't hurt, but given how it's internal only it didn't seem that urgent as
> for gfp.
> 
> > Does it make sense to leave alloc_flags to internal-only state
> > and just implement a new flag field?
> > 
> > gfp_t       -> describe the page (fully public)
> > req_t       -> describe the allocator behavior (mm-internal only)
> > alloc_flags -> internal allocator state only
> 
> Maybe in that case the remaining alloc_flags should just become 1-bit fields
> directly in struct alloc_context so we don't manage 3 separate bitwise
> types. Or more bits in case of ALLOC_WMARK?
> 

I think that would be much less disruptive.

> Depends on how much work this would be (and if you want to do it) and how
> the result would like.

I took a short look at converting __GFP_SKIP_ZERO and the change has
bigger than i thought it would be.

Yosry recently said ALLOC_UNMAPPED was being put on hold, and for my
base private node series it seems I will only need to extend folio_alloc
with with alloc flags - so i will probably try to split these efforts up
and carry the minimal folio_alloc patch separately.

Otherwise i'll look at whether we can move some alloc_flags into
alloc_context bit fields somewhat cleanly as a first step.

~Gregory
