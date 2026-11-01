Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552816;
	b=za1EZ0vbXjDl54MHKBeyIq3AQMH6l5imzPqU+IvrsErhKwOXIw1GnqV3nvu9OZcN10Jh
	 X5QoUwhF7Pk4lqDJAY8SgfWb8t0bTCLgEwlfywll2KhFIKB+qTmjO/WlMrJeR140CXOVY
	 Ie5bJWSS16NcYygT35PIvb5u6s5sdvCjvHG4velcjQdl7o7WM7dmJHB9+uN8FDD3gHXib
	 rVVscIoau3A720w2Z/qSEe8G4UzVYo2yR6Ry+NpHQDOn5hQfKgQ9fFfR0hd+S2o8zYjkT
	 fjiNFCDcZyLrEapPPzYY+j/iR3l9x1ai3ZDnn23hgE56spq+HmGyc6AqpLc66Z/ZSug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552816;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SSP10FG90qh8b5f5aDg1OH/wNNAY2fjTeu+XEqiARZs=;
	b=Cjj4MlgqrfwLHw47Spm9is9Xik++QupjKcKgLaanspxkAXo+JvYpcr2M2QgzYwwEr1s1
	 ulJ5eG7WCkEtKvELcLq4iU2fPs2Iin5txuz9W/w3iE+r8UCYj+Z35O0KAYkSU9rt4wuCl
	 I0wpBK8X5B/m6M/MdXftG0GNcmGnqCSUKg2fgPn2t27XWw5N/IpfQiFuhe3hjxPr+zwDO
	 71rIarXOS9bobrp204XMZeOTI7lLdcDz54NN20E3xfeHZHmDRv4gK0QwcBA55d0/R1Z1Q
	 aYBA4i03ftvGQI5mS9kGGSjmq1sYTQQMsdvM4SoZ1M3fYedvvuydwZBsR5FulTg9AcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P5T/0GiJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9C606A324;
	Sun,  1 Nov 2026 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5T/0GiJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5411F000C1;
	Sun,  1 Nov 2026 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793552815;
	bh=SSP10FG90qh8b5f5aDg1OH/wNNAY2fjTeu+XEqiARZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P5T/0GiJ+afhGq3aagkAB3C9wrvvQlvJMSJpK3pP/ZxT3hK3GSsQv/p0H6ED/sqyl
	 bQOA9JYjdVehpIx8dvmGqovlLihGvyV4J1DlW8atohp1X/CNfYMiPgbHpJXTEgwna+
	 KxmMjqxC9+LqmXxxNGQZW3siu+I7ef8UslxIf4ZAS09GI9sY52zC2pgSmwYECCYJYm
	 n/01P50O0RsiayWhTV05qjbOdDO84w9AIEGAjznwuCXnzVj3yw7SV+4zv9DwbKTS/w
	 pUuNyZZOZpGxxSFHy5j1vZWvApPsEnx9aK3STZ6AYP9V6KcDXSmFtAYpP3Kr2q2M4D
	 TJCROKNCDQqGQ==
Date: Sun, 1 Nov 2026 17:06:53 +0000
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
Subject: Re: [PATCH 2/2] MAINTAINERS: move SLAB ALLOCATOR under MEMORY
 MANAGEMENT
Message-ID: <audw9R-_gyYkwkGJ@minisforum>
References: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org>
 <20261101-maint-page_alloc-update-v1-2-27e8c246b13d@kernel.org>
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
In-Reply-To: <20261101-maint-page_alloc-update-v1-2-27e8c246b13d@kernel.org>

On Sun, Nov 01, 2026 at 05:34:49PM +0100, Vlastimil Babka (SUSE) wrote:
> Following David's consolidation of several other MM subcomponents, do
> the same for the slab allocator.
> 
> Rename the section to MEMORY MANAGEMENT - SLAB ALLOCATOR and move it to
> remain in alphabetical order.
> 
> Remove Andrew as M: to signify he's not the primary person for picking
> patches in this subcomponent. get_maintainers will continue CCing him on
> most patches via the catch-all MM entry. David prefers not being added
> for mail volume reasons.
> 
> Indicate the primary integration branch (slab/for-next) in the T: entry.
> It will now be integrrated via the mm/linux integration tree.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Acked-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
