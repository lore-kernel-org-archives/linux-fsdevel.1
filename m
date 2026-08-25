Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE13CE4B6
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646700; cv=none; b=NU3rdDz4dH5188+IHP0Xf/qpwTLPOSqNs6v5G0dK6O3ZqsR8MjmEg6gB4ewhKsNXbYR0sk9BRNbxOVs4Ok13ClMpCztT8Wi6kd+zlq723HhtNPFgXyywyswuCcb/o5OAtRFwqr+sBb4EtC2nviaY4N0G6n27Ni3PoQR1BnnGDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646700; c=relaxed/simple;
	bh=ZYhAQBcWSQN8z5GJ1aACclinzf39I8Vkm0CcDs/1js0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU9wOAV3jvxfS6ID60KSxFidFiE7D6dmFMIr6L9ibsM704uZjt/As1zNQYzdy9wNlc2tf1/q5Ut/hOjgSIerA9+ADgQputvr7G9PSjDNFrzGw1qntBfx3DCOjP7fc4nmPAEblzir4K2tK/mejZERDL61I64J8DNUFMAW5qW/4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5OCbYap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5OCbYap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C731F00A3D;
	Tue, 25 Aug 2026 08:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787646698;
	bh=6jcVuJtrzfEtM9prxYlosEdDpFr5qr6LnwE7Zah30QA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=S5OCbYapRm0km9uPuedMjFuUoxnXo8KQTa3IlLYLUskH3GYCpqf52og9RaA8UQkPc
	 1YxdPmzOzNe7mvsoOMzDXvnRrkjtWMZFF+2op7RselwwXEfRU+mMrbpqfivhdCcfMK
	 TS9anlNRbaPJAQf0+vjOKPpRhfSJjBMSC3FFd93WG81HQfuemV4ff1F0QaIRMy3EoP
	 NKG8/JodK9AiefK/PsvbLZFPQc3qXkKdxsgqfwtku4zEBAokFTk9PKhU/Oa52Cu0Gq
	 eFJNzvvvT9IR7FJhJwdNOxOQ5w4hdHZ/U35ix9bEH1k7s2Cf0YaVLL2YB9XcIoc9AR
	 6kCyHK2T6WIrg==
Message-ID: <b682a12f-ac03-4032-851a-f4f7ced4ffa0@kernel.org>
Date: Tue, 25 Aug 2026 10:31:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Extend xas_split* to support splitting
 arbitrarily large entries
To: Matthew Wilcox <willy@infradead.org>,
 Artem Lytkin <iprintercanon@gmail.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Zi Yan <ziy@nvidia.com>,
 Kiryl Shutsemau <kas@kernel.org>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20251117224701.1279139-1-ackerleytng@google.com>
 <20260824194755.216000-1-iprintercanon@gmail.com>
 <aoyqIBz1EoY0R8qw@casper.infradead.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <aoyqIBz1EoY0R8qw@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 22:31, Matthew Wilcox wrote:
> On Mon, Aug 24, 2026 at 10:47:55PM +0300, Artem Lytkin wrote:
>> I'm asking because there is a second user for it that has nothing to do
>> with guest_memfd. On arm64 with 64K pages HPAGE_PMD_ORDER is 13 and
>> MAX_XAS_ORDER is 11, so MAX_PAGECACHE_ORDER clamps to 11 and shmem never
>> offers a PMD order. MADV_COLLAPSE on tmpfs returns -EINVAL there, and
>> huge=always hands out order-11 folios at best, so ShmemPmdMapped never
>> leaves zero. Every other page cache file system tops out at order 11 as
>> well, which is 128M and not PMD-mappable. pagemap.h admits it outright:
>> "xas_split_alloc() does not support arbitrary orders. This implies no
>> 512MB THP on ARM64 with 64KB base page size." Kiryl's khugepaged
>> selftest series skips the shmem and file cases altogether for exactly
>> this reason, and on 6 August he confirmed in that thread that uniform
>> splits still go through xas_split_alloc(), so xas_try_split() on its
>> own does not lift the cap.
> 
> But why would you want it?  With 64KiB pages on arm64, you need 512MiB
> for a PMD-sized page, and that's just too big for current hardware.
> What's your bandwidth?  40GB per DIMM?  With 8 DIMMs, that's an
> aggregate of 320GB bandwidth, so that restricts you to 640 page faults
> per second.  That's too few for almost all workloads.
> 
> The page allocator also isn't great at doing order-13 allocations.

I heard some use cases using 512M THPs on arm64 to back VMs, but it's mostly
anon pages, and not really ordinary pagecache.

> 
> Since arm64 does support 2MiB TLBs, even with a 512MiB PMD size, I'm
> not sure there's a huge performance win waiting for you on the other
> side of all this work.
> 
> IOW is this driven by a real need, or just some completionist thing?
> 
>> That case needs two new levels of nodes rather than one: 130 nodes,
>> 73 KiB, a long way from the 1G to 4K split Matthew was worried about.
>> Raising MAX_XAS_ORDER to 3 * XA_CHUNK_SHIFT - 1 covers it, and
>> MAX_PAGECACHE_ORDER stays min()'d with HPAGE_PMD_ORDER, so no page cache
>> caller can ask for the order-17 worst case that cap admits.
> 
> 130 nodes is still a lot to ask the slab allocator for!  With 64KiB
> pages it's not too bad -- you get 112 per page.  But still ...

IMHO it would be nice if we could just support such splits.

I've always been thinking of it like this: you end up consuming the exact same
memory if you wouldn't have allocated THPs in the first place.

But a buddy-like split is clearly preferable. (or avoiding splitting in the
first place :) )

-- 
Cheers,

David
