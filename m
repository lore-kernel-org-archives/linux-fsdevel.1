Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554241;
	b=h2bI9eqlS92fN01wdM9bQbPCKKelxST5FHYJ7n/YXhLmbxvtShTzLQncMrn0y9NNAFaP
	 KrWXK5ZDszGbFiVgVlTHmZw+WsGsWOX/IF0mcu7MM+O3SaNN/X/JJ/7aAca5zffNBwIS4
	 2whPUbRKFMLKjVAY61cKnzTiWxVTXmgkLo7KktI4n1QsrEccGfVrPZ2FB5SGxk3P47/Ih
	 ChqqQJxu9uEgrBlU3cysYJQ11T/Ch2y9v/s1uerOMlfzHxYqs9UGr1OhsZ5PleRUldbdX
	 1cK/OdfO+Y6xNg6LCFWnk5x7kmHB+I1rvPfGewex9Yk6FDGAbMEqbjHhkEbi5sYroVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554241;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3yjT4uLUMkuD27R6BJuNehLVUXuISjPFuRqD0wtplj8=;
	b=eG4KWb7T1EReThOAcdHGga1SMBqbf5x4hZ3eT8xNC5XyC8ONcooWKz7iCLQhdokcYoUU
	 so75Bp44HLhzTUpGKd3ku1bvPozFJcYj/ri+NPYHI9ti1+ypo0Y6DOMJ1DeIKu7kqSKJo
	 boKVLmNUQMR+d8HyuzFaxAwoxmN2Zw/t1EG9m765XMn6e/tUUDCiz6DA0Et06KPD5Xc9Z
	 mI5Hu0055oqyNjyEYnufdYeFw4Vek/3u8P2YUmtAAVRIMwLGlIxACKKtW0hrjti+8DsaC
	 8dTuOAuBGovMowjtJGthJ5pfj4dWR3TfTGH2fdP8jqqsU1m6Ytjfvh5ChWFrt2Lkhkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9P47yac;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8B606A325;
	Sun,  1 Nov 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9P47yac
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F02B1F000C1;
	Sun,  1 Nov 2026 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793554241;
	bh=3yjT4uLUMkuD27R6BJuNehLVUXuISjPFuRqD0wtplj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y9P47yac+uhWhB5RjcPOXxPsZmYKXJ0KZmUiefS66FujIGl81416n9FY5nAwYtECI
	 8ral0CluzQ5Il5hoeHd9AlTbnzeQ+t+dhJX90DvybLfu44Otl4DL3RFRyB+wVs/nC3
	 CslgtwcgzDGD0QLiYf1nLKnFeNSswHkV96Gikg7lzj/KrZI6NfBvGGasi88xbD004x
	 IZcHyzNbFU0QX35ExNLnBnFWcaUEc7wxtQi5sWj+3ur5NBMQc3Adl4HZX/tq6zWZsR
	 Gvt4DgUq6B3K6/jR9xFBSZq2llTv4tapMxUCHUVRRek36Qx+WrI/h+WbJoHKaNRLD9
	 VX5oMtg5kvJXA==
Date: Sun, 1 Nov 2026 17:30:38 +0000
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: add Johannes as the page allocator
 co-maintainer
Message-ID: <aud2VVt5zp2i1BkB@minisforum>
References: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org>
 <20261101-maint-page_alloc-update-v1-1-27e8c246b13d@kernel.org>
 <audw0QKojvZU8J7e@minisforum>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <audw0QKojvZU8J7e@minisforum>

On Sun, Nov 01, 2026 at 05:03:41PM +0000, Harry Yoo wrote:
> On Sun, Nov 01, 2026 at 05:34:48PM +0100, Vlastimil Babka (SUSE) wrote:
> > Johannes is a long-time expert and reviewer for the page allocator and
> > has agreed to step up to a co-maintainer role, so do that. Thanks!
> > 
> > Additionally, page allocator is joining the MM transition, following the
> > MM core updates from David [1].
> > 
> > Patches will be collected in the mm/page_alloc git tree and integrated
> > via the mm/linux integration tree. To signify the change from Andrew's
> > mm tree, remove Andrew as M: - get_maintainers will continue CCing him
> > on most patches via the catch-all MM entry. David prefers not being
> > added for mail volume reasons.
> > 
> > [1] https://lore.kernel.org/all/20261030-maintainers-v1-7-97278f8a5f54@kernel.org/
> > 
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
> 
> Acked-by: Harry Yoo (Meta) <harry@kernel.org>

Forgot to add:

I couldn't agree more that Johannes Weiner has been making valuable
contributions to the page allocator.

Congratulations and thanks for stepping up as a maintainer, Johannes!

-- 
Cheers,
Harry / Hyeonggon
