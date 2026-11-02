Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610607;
	b=LHs6Haz2NJdZywVCVG9KQghxjgcFhKwfZtWQbaKuZmFuQREBKt6lO7OxC58IP5tH8wpT
	 HlVgsaWexkdGe6d3Pv+BhthFptyufsD7eL+/FtpZsidAeZnaJimJFSQJ8JppWGNFgBeqZ
	 8qPEmAssl05iYIBrIkwRk5z1Yt+zPk8YTKPKz/8iFfA2bJ60vsKjZtX2ZWVd+PlCF4c++
	 3sT+BPoxwU7oVKw8Gh9QjSwV4pbfd+3C5AKXlFFf7vqHR7PnKL64BSkhdgWm8AEgeGr7B
	 1vyvvZdS/QlfdbWnNcEZlKumChGMRrPW2CeuCHjzxMOhfOl7NrfOSGfpAsRnGAS+vXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610607;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wkTC+he0qPm39vRqMgtbm34FMLdGD5gTPbWYAvKJPAM=;
	b=xw64PRhaflaZO5wHgShOv3RSv+gkCsbgtwxRInvbgO6H0KxKN7wVajWSgjXVJ/SxfXgK
	 4NAIo5pIajN8tG8LVLMD6amZr9NSyXrJBE/ESy3V25JsdSRbQU9wEBGQu0W9cTrTYeY3H
	 Z6/vndaDABcFQwzKe/bivW7g6Vr/aPiLSRxcLCKXl7/VS3sqy1DFQbzUBBOzkSeaorcCu
	 vjIKnbtWqgzE4aNW5rw02nd5pN2oBgMa8sn7FaGJelX1amupNXfMCpAYRRT+kiPSvMUGY
	 4MXsnn/AALnmTHYFMylp8Tz33OWNVvollNHpiTYCl8TwFx1foOgwYv8HvtOJKg17taA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GY/pK+HG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4609606A324;
	Mon,  2 Nov 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GY/pK+HG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B703F1F000C1;
	Mon,  2 Nov 2026 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793610606;
	bh=wkTC+he0qPm39vRqMgtbm34FMLdGD5gTPbWYAvKJPAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GY/pK+HGdMiCW+9zjMunUpA5s2ZA8dMTkpxAtDFoh7B5X6P0YdI7nklSo+LjJPbzl
	 cgzR+Hw9tByzBlDzALAO7FDxkavgBONB5j6/AiQteCScFaXb4xlQZKknl3qWu2jZMz
	 tijp9HxFwwa9PdBuYVNTYwEQF8Q2o1oba1xaNRkBwnUMF7XeFadwgkxmtIq7Fyi/gI
	 xDnoUH+A+TxbC8ibodn/RAYDXxaunq/HpN172ip3tkjkzZ72sqGg8jf/vwdkDX9jEp
	 J93CIkHco55aOwhrzYPJ6XMZsRMDfuCDOaE2xpqjOJy+WKK27bIv7QH54EtjpXwydU
	 pmDgZBOl+Wa4A==
Date: Mon, 2 Nov 2026 09:09:59 +0000
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
Subject: Re: [PATCH 2/2] MAINTAINERS: move SLAB ALLOCATOR under MEMORY
 MANAGEMENT
Message-ID: <auhTYEX5xCe1ApQ5@gremlin>
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

LGTM so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  MAINTAINERS | 59 +++++++++++++++++++++++++++++------------------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7cfb28a9029..e449ee3009ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17815,6 +17815,35 @@ F:	mm/shmem_quota.c
>  F:	tools/testing/selftests/memfd/
>  F:	tools/testing/selftests/tmpfs/
>
> +MEMORY MANAGEMENT - SLAB ALLOCATOR
> +M:	Vlastimil Babka <vbabka@kernel.org>
> +M:	Harry Yoo <harry@kernel.org>
> +R:	Hao Li <hao.li@linux.dev>
> +R:	Christoph Lameter <cl@gentwo.org>
> +R:	David Rientjes <rientjes@google.com>
> +R:	Roman Gushchin <roman.gushchin@linux.dev>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mm/slab.git slab/for-next
> +F:	Documentation/ABI/testing/sysfs-kernel-slab
> +F:	Documentation/admin-guide/mm/slab.rst
> +F:	Documentation/mm/slab.rst
> +F:	include/linux/mempool.h
> +F:	include/linux/slab.h
> +F:	include/trace/events/kmem.h
> +F:	lib/tests/slub_kunit.c
> +F:	mm/failslab.c
> +F:	mm/mempool.c
> +F:	mm/slab.h
> +F:	mm/slab_common.c
> +F:	mm/slub.c
> +F:	scripts/gdb/linux/slab.py
> +F:	tools/cgroup/memcg_slabinfo.py
> +F:	tools/include/linux/slab.h
> +F:	tools/lib/slab.c
> +F:	tools/mm/slabinfo-gnuplot.sh
> +F:	tools/mm/slabinfo.c
> +
>  MEMORY MANAGEMENT - SWAP
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Chris Li <chrisl@kernel.org>
> @@ -25809,36 +25838,6 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
>  F:	drivers/nvmem/layouts/sl28vpd.c
>
> -SLAB ALLOCATOR
> -M:	Vlastimil Babka <vbabka@kernel.org>
> -M:	Harry Yoo <harry@kernel.org>
> -M:	Andrew Morton <akpm@linux-foundation.org>
> -R:	Hao Li <hao.li@linux.dev>
> -R:	Christoph Lameter <cl@gentwo.org>
> -R:	David Rientjes <rientjes@google.com>
> -R:	Roman Gushchin <roman.gushchin@linux.dev>
> -L:	linux-mm@kvack.org
> -S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mm/slab.git
> -F:	Documentation/ABI/testing/sysfs-kernel-slab
> -F:	Documentation/admin-guide/mm/slab.rst
> -F:	Documentation/mm/slab.rst
> -F:	include/linux/mempool.h
> -F:	include/linux/slab.h
> -F:	include/trace/events/kmem.h
> -F:	lib/tests/slub_kunit.c
> -F:	mm/failslab.c
> -F:	mm/mempool.c
> -F:	mm/slab.h
> -F:	mm/slab_common.c
> -F:	mm/slub.c
> -F:	scripts/gdb/linux/slab.py
> -F:	tools/cgroup/memcg_slabinfo.py
> -F:	tools/include/linux/slab.h
> -F:	tools/lib/slab.c
> -F:	tools/mm/slabinfo-gnuplot.sh
> -F:	tools/mm/slabinfo.c
> -
>  SLCAN CAN NETWORK DRIVER
>  M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
>  L:	linux-can@vger.kernel.org
>
> --
> 2.56.0
>

--
Cheers, Lorenzo
