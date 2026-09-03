Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128794A2A69;
	Thu,  3 Sep 2026 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438882; cv=none; b=ByMA7YgeO0Cm2A3OGukeFqsjgzXR5LG2LDv+iw0wf2/ISLN8fszCIl1Wd1jj4PpWv6bJqjSkdg0F57AIQ+O7cwA9w61P2xPDDdSvoIvCSTH69IoW8bL3Hn8eF4yJ08p8nUYsSu/O4A4uB/lZ8o9LYJyCZEQ5waj64Mpn06UjxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438882; c=relaxed/simple;
	bh=skbac+Av+j+XXQu0zANubUepDTRGwgFnB7+UzSNHOFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWNH5eTIbqLq1ia7B3SsMb88pWsX7+2aOksoiUol9cz2WxXCbwJF8mZ0K71OlLUargvYLxjvPyOCABgShWJPoSxcbPAHKCxchxuPtCMSr7fBn5hdEk03QBjTCy/CCBTFy5SlmPrJVKBgEff++Jlf1BV0T6Ruf2fVS8iLS8nx0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0/zDgEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0/zDgEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6C31F000E9;
	Thu,  3 Sep 2026 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788438880;
	bh=uK0Hbb1faKPkbn+cU/4RsAvsMY58CotR+cwVfIyfMWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G0/zDgEFJRV3Fd3FiL6VOiv71LC5tt6dpsEVZ+vUTmxM+NIkfCgQmQCBmUR3efDGs
	 d03+lO5Yzimj4JcFaVVzO2IW2X1IZvoSXrXgIixcVXqV+kWrONGDmqqBS7QC0sjhln
	 8O4USSEsQKziD64eJ0j+N0yOZs67H6km3FbL+OuFzFso7aU11hik0VgMO6mPSJiarf
	 096aqgZsssYcV4yinnALs/mSWYagEgscsV1LbY9kDPbwwxtRqGD+2PZJ53dAh4qbJv
	 2gRW6Hk+qGBW8JNr09rbNX0I9Jkemeaq98CSNtqYud1iuXkknhUDVS9iSXRPLZW8PR
	 OBW163lQPJ7Lw==
Date: Thu, 3 Sep 2026 15:34:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: move drivers/char/mem.c to mm/char-mem.c
Message-ID: <aplpV4lLpDuHQ7pG@kernel.org>
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
 <20260902-map-private-dev-zero-v1-1-a578c730cec7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-map-private-dev-zero-v1-1-a578c730cec7@kernel.org>

On Wed, Sep 02, 2026 at 07:00:18PM +0100, Lorenzo Stoakes (ARM) wrote:
> The memory character driver implements several mm-specific features and is
> always compiled into the kernel, so move it to mm/ where it belongs.
> 
> Among other things the driver implements /dev/mem which provides raw access
> to physical memory, and /dev/zero which either allows mapping of a shmem
> region (if mapped with MAP_SHARED) or, uniquely, anonymous memory (if
> mapped MAP_PRIVATE).
> 
> This change lays the foundations to allow MAP_PRIVATE-/dev/zero to be
> mapped precisely the same as anonymous memory is mapped as currently it is
> an edge case within mm.
> 
> Also update a couple of comments that reference 'drivers/char/mem.c' to
> reference 'mm/char-mem.c'.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS                         | 4 ++--
>  drivers/char/Makefile               | 2 +-
>  mm/Makefile                         | 3 ++-
>  drivers/char/mem.c => mm/char-mem.c | 2 +-
>  mm/shmem.c                          | 2 +-
>  5 files changed, 7 insertions(+), 6 deletions(-)

-- 
Sincerely yours,
Mike.
