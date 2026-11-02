Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610568;
	b=VLFVQaEZVrHlgRrSWWzRHRRl/ruPDfQe4Ecjw49THdZocfbMZR07o4op4AXVBNKSQt37
	 4kBVb/8ydRRlkpu9jOuahlKNMxrWps1MX1ze+G9rItj/O7RiGu7bhabev3+cpCjtU5GnU
	 JOmiZRa4WC6UFxvluPdk7aheSSKxgmnqtcpzjJGwOMyVg3AFAl3D9d69x3uOqo8h3x8vQ
	 P++Lc1lg7N3bJ5F632nHIJcPFOPJc8+QXx4fzvcDtwNuiceW53Utn3ztYP4bkFnK2ZxN5
	 g2Dfd4vejHT+T01eoeSqh3mb00gq/2UL0rtkfqxF3aUb5wzcn9cU19Ok4bsB84p56sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610568;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b/cF6WMzcjKaJKZ5oQKJkStJ8KKrbT8J01NBjCuG4xA=;
	b=rSrozUTuYAdGSUMzZ2F9KBcahroKk+JTkXxuurM3Fc/RdkyLFB9lTtCmN6V751fxJ0GN
	 FfihmXEU5MUvgn8Niv3j+LWn54EAamu6YoJNfZLRAcjnmFdNjfRppJ/52NZxjZAAOwa9H
	 CZvLJh8E355PPeHTmTV6p9UQbXwdZFeOjmfqksk62wQwMLCsMTXoYWnFmFRKNHNrrtzJJ
	 JPpIfoY9MxuEuOASmeib6OGoyC+EpBMTVng7sfDThkmJKhlR9AAAsd2uklWUq9Z9svadf
	 Pq32vKDDZZCUpjHdjUn0ea5wGnkOfPGpniSjhfbW8YOKEdkuLDtW6CTNHGrpWOw9csg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7O1MaO9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C60606A332;
	Mon,  2 Nov 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7O1MaO9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BECB1F000C1;
	Mon,  2 Nov 2026 09:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793610567;
	bh=b/cF6WMzcjKaJKZ5oQKJkStJ8KKrbT8J01NBjCuG4xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E7O1MaO9SjuMyxTFmrgaga3GDsG+Fg7gKkAhGPXB6FQWs+hFpLzvqUX88ZE0tAYjC
	 AXABiP5xrYUF7z9zwjGYYGloS56DzTVoFij3UTR5frb+bI5TbMrdN6HcdEO9zCEiPB
	 +URPLLdf8JBZ8VSxGiJ3sp7Ug0JxLpGrZIyupnMGn7glvjdjgMm39ep4O9YSjfzQ7u
	 MOUuVe1D4WA+A4pq4+svuYVsIj+/QRz/FaDwnmcLfFDltdW9CLAaDbPVHrT5NUUQ8W
	 Rhpxp3gI6PdMDqi/cYgCnqRLxV3DJ5beHMTtvg3hrWiHYCVHNX9MetcvQ4FiHppZI0
	 kn0+5LH/hEM7A==
Date: Mon, 2 Nov 2026 09:09:20 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: add Johannes as the page allocator
 co-maintainer
Message-ID: <auhTLSjyu-sNlQAB@gremlin>
References: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org>
 <20261101-maint-page_alloc-update-v1-1-27e8c246b13d@kernel.org>
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
In-Reply-To: <20261101-maint-page_alloc-update-v1-1-27e8c246b13d@kernel.org>

On Sun, Nov 01, 2026 at 05:34:48PM +0100, Vlastimil Babka (SUSE) wrote:
> Johannes is a long-time expert and reviewer for the page allocator and
> has agreed to step up to a co-maintainer role, so do that. Thanks!
>
> Additionally, page allocator is joining the MM transition, following the
> MM core updates from David [1].
>
> Patches will be collected in the mm/page_alloc git tree and integrated
> via the mm/linux integration tree. To signify the change from Andrew's
> mm tree, remove Andrew as M: - get_maintainers will continue CCing him
> on most patches via the catch-all MM entry. David prefers not being
> added for mail volume reasons.
>
> [1] https://lore.kernel.org/all/20261030-maintainers-v1-7-97278f8a5f54@kernel.org/
>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Well deserved, congrats Johannes!

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b68bc3626709..d7cfb28a9029 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17720,15 +17720,15 @@ F:	include/uapi/linux/oom.h
>  F:	mm/oom_kill.c
>
>  MEMORY MANAGEMENT - PAGE ALLOCATOR
> -M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Vlastimil Babka <vbabka@kernel.org>
> +M:	Johannes Weiner <hannes@cmpxchg.org>
>  R:	Suren Baghdasaryan <surenb@google.com>
>  R:	Michal Hocko <mhocko@suse.com>
>  R:	Brendan Jackman <brendan.jackman@linux.dev>
> -R:	Johannes Weiner <hannes@cmpxchg.org>
>  R:	Zi Yan <ziy@nvidia.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mm/page_alloc.git page_alloc/for-next
>  F:	include/linux/compaction.h
>  F:	include/linux/gfp.h
>  F:	include/linux/page-isolation.h
>
> --
> 2.56.0
>

--
Cheers, Lorenzo
