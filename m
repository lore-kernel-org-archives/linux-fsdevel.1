Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C99322B8F;
	Thu, 15 Oct 2026 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058535; cv=none; b=Fw9p7wM4dsq6w5ULDGix3hxJ7tQRjvYKYgndrSLI517lMVw8N4GSCV7fo1WMn7sID1xz4cOu4bS14IYZbYk+lpHnsWqGtrpkvEcVePZA9dvOQJzavIvp2c3aX3N56WU8cpjnsF2RKqiUFmll9OoQAJQgg6efKjO/eTq9x+WDCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058535; c=relaxed/simple;
	bh=T33GmSIa8ZXcZcboQ6eeHkUwMBfXwo2O+4ayOOp6DVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnXUW6ordD9JJOl1rm0h71oZsZda26V9wfN/xvf/eUrINpvN1GtRVVk2L22YcYsN4Z5W6VbeqS7j4ZSTbEDieT63zAtv8JosOA/73NKI+e2CqgzaHgxV7g2CAhQ0dqZRin8ZMVcnNVKvslSquFmNvBpuTCnjeoTDsxMDeaD+6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iko2b0kk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iko2b0kk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256631F000C4;
	Thu, 15 Oct 2026 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058531;
	bh=5Pqi9+FJ5ewTDOrXx6NJLaiZDN05LqWUpfO1uWA0Wgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Iko2b0kk0bIGk8QVSE1lc+78pqVzKqFb/c6PX07rt8o/L64rRlfyLiAwQAvvm2D2f
	 F1G7/yeHsYCSltPOKzyG4dRvWl2wAq1Ha0lYOadrYRg8C/7VlDR3MhOfmEOuyYI3O6
	 1TR/hjFFUBSJGsWQ/bRc4w/sr6l1jJFyO4MqJ+MrCO//h0SsbVvwQv9lwP5HZZqHsq
	 xlBSvSeMPrQFaVZ5njxYJNPyR9/+2VYRrfm/xfsKCfbTvAsehGYV3ndjTxJxoN5hVZ
	 jav4uXA7zZ5PVeUMKQEjlF2ppEl4ByteA+ZH9MsjRxFrCuLnIOu3m/+n7yq50ydTGC
	 1V4mGjBjkdvAg==
Message-ID: <1f36992d-00c1-4f74-9947-b543ed794cf0@kernel.org>
Date: Thu, 15 Oct 2026 12:02:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] mm: pass alloc_flags through folio, filemap, and
 bulk allocators
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, willy@infradead.org, brendan.jackman@linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com, jack@suse.cz, akpm@linux-foundation.org,
 ziy@nvidia.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, surenb@google.com, mhocko@suse.com,
 hannes@cmpxchg.org
References: <20260923211041.3127588-1-gourry@gourry.net>
 <asdTptfeLkuypU8t@gourry-fedora-PF4VCD3F>
 <df588805-6f97-4ef6-a64f-39222669bf3a@kernel.org>
 <asloWFM96BATH8SB@gourry-fedora-PF4VCD3F>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <asloWFM96BATH8SB@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/26 01:28, Gregory Price wrote:
> On Fri, Oct 09, 2026 at 10:55:05PM +0200, David Hildenbrand (Arm) wrote:
>> I do agree that two sets of flags is suboptimal, but likely more flexible. I
>> guess an alloc_flags only interface is not easily possible ...

Agree with the alloc_flags option of all the other options.

>> I do wonder whether it should be:
>> 
>> 	typedef int __bitwise alloc_flags_t;
>> 
>> instead of "unsigned int alloc_flags".
>> 
>> ... while at it

Can't hurt, but given how it's internal only it didn't seem that urgent as
for gfp.

> Does it make sense to leave alloc_flags to internal-only state
> and just implement a new flag field?
> 
> gfp_t       -> describe the page (fully public)
> req_t       -> describe the allocator behavior (mm-internal only)
> alloc_flags -> internal allocator state only

Maybe in that case the remaining alloc_flags should just become 1-bit fields
directly in struct alloc_context so we don't manage 3 separate bitwise
types. Or more bits in case of ALLOC_WMARK?

Depends on how much work this would be (and if you want to do it) and how
the result would like.
> typedef int __bitwise pa_req_t; /* Page Allocator Request Flags */
> 
> #define PA_REQ_DEFAULT        0
> #define PA_REQ_NOLOCK         BIT(0) /* from ALLOC_NOLOCK */
> #define PA_REQ_NO_CODETAG     BIT(1) /* from ALLOC_NO_CODETAG */
> #define PA_REQ_SPREAD_DIRTY   BIT(2) /* from __GFP_WRITE */
> #define PA_REQ_DEFER_INIT     BIT(3) /* from __GFP_SKIP_ZERO */
> #define PA_REQ_ZERO_TAGS      BIT(4) /* from __GFP_ZERO_TAGS */
> #define PA_REQ_NO_FALLBACK    BIT(5) /* select no fallback list */
> #define PA_REQ_NO_OOM         BIT(6) /* do not oom */
> 
> Off the bat we recover 2 ALLOC flags and 3 GFP flags. Possibly more with
> a bit more work.
> 
> Then we get:
> 
> #define PA_REQ_PRIVATE        BIT(7) /* allow private node allocation */
> #define PA_REQ_UNMAPPED       BIT(8) /* page must be unmapped */
> 
> And we might not even need a new zonelist for private nodes in this case
> as long as we require internal users to pass PA_REQ_PRIVATE and add a
> function like
> 
> folio_alloc_private(void *owner, ...) {
>    /* validate (pgdat->owner == owner) before allowing allocation */
>    __folio_alloc(..., req | PA_REQ_PRIVATE | PA_REQ_NOFALLBACK, ...);
> }
> 
> User still has the option to request NO_OOM via __GFP_THISNODE :]
> 
> ~Gregory

