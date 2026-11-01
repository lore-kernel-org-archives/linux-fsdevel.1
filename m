Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552621;
	b=qSjkId1WZLf0G6EFAkyO6iFXnqjWqVRuIZq0weRCEe4SVKbLZ7nLwCJQLTbz+vcsyFPF
	 iwAFx5OYG0FoeC+yyl/WquTnk2od5ENOi7RoWYRxCLZjIZeQEcr+/sEw7e4I4t3zra5WK
	 pk/OfgnSXfCtCQCvycCICSCCt6u/3pWn+L117VV/FItSEGYNanOajhvMJTbpPDOlWAJcq
	 bRQygfkcA02DqKINur9A1t9tzvdKuTU667aImwv9KW0WgRa1ynSJJ3n+oPp8rFGjM2xA3
	 OHOlI+YOAbkNYuWcv38iUwpRDlYNd33VMxNRdUzg4/XTaynpkhjFao0TJ+Wd5UbYVEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552621;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0bVBCo8jJc6AJMoyYP1WZHYEekFaCa4NsYZA8oZ2ur4=;
	b=bgubONbuQKA4Qkdzhvq3/ayMxsPUSJfAJzmoB9LpzvpPtNSqgT1VeY8/BQpR5CaMWEDB
	 pbdU5SUoi3ggw9WlgrOh1Uz+iXQ/jlFqk2jr0hLMbunvqOfvMsU8sA6CwJ8vwjQBSeY64
	 znmHPnetIn8d/ljNeIESV9FuA1VUzb1DWOOzo9yU/mdLW4JSkyenAawncnt0h7JOUttst
	 25VJmiWEOiRyvwapWe0Z3A0YKJk1IbEwkaYvnT/Lnyuw1HiwR0wSxtGmvywVYoPNQ/BTD
	 sHtROaAy7KFHmocfyS6w0zpjWwUH4h0AhsfairpR2WtpMXYT3Ft25K0RNn14Nwyxbiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kRZ/G8e4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C8606A324;
	Sun,  1 Nov 2026 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRZ/G8e4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C95D1F000C1;
	Sun,  1 Nov 2026 17:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793552621;
	bh=0bVBCo8jJc6AJMoyYP1WZHYEekFaCa4NsYZA8oZ2ur4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kRZ/G8e4qQH/g/ZCaXnqR3qVQQUAjnJzwLJKJzios0BnWdldjeE8R6vt6/30bglNu
	 T0zVL/GBKJqj91hiXsumxr/p1NogtrUlNUbamVLxYZvBGmbkEL0BkBaS1N2QwSsY0D
	 0oz4bfbcBrACvSX5nRoRvGApir96Y2LBGr+uMZZ+YK9ulNj0zF1m32qYaEax2yldfo
	 0tLwGVPECc8D7YCC+VhL4hKRTtRFzTSKnme0DlSE+oYOF1wrNhtFmdEW2n11QdCHS6
	 5VpPEi9gn5bcZDPtWgDFvlDWGpM/ngZM8U2L3mw0Xox99D4wqTfWfYtyq+Rix1/i67
	 LpYajbj0g5tWg==
Date: Sun, 1 Nov 2026 17:03:37 +0000
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
Message-ID: <audw0QKojvZU8J7e@minisforum>
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
> ---

Acked-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
