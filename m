Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F095A374183
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699438; cv=none; b=h4E55FqXdVFL/nqPQRTA0oZqURtXYVuiDK+2Qgt/WwK4jn2qpT3oakZRcbIcy5b3oRlI5v/yRGwqvMOHTTIofConfBiHIyt/HYJ4J8b7IjNFqR+gw4e2ImrBJuOS5g5C4tdjKTz0BjXPxh7eWlnkil0GIWbIlamuykYD62L0vMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699438; c=relaxed/simple;
	bh=IyyJMi7zPwn5aDcvOkYvk2n/48jPMfx+VyvC/C5ynGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp60kSWFtuUEg0anBTBEVEDxgR4dctvbn/5Uer4W94peD7+zWnbz7KQjYR1PXmIeAhj7BEU+ULkN5OAI7KhublOe4P777Ks2htLN6qOCg367Kr/+xLZb5Vcd0EzRv0U+yhH5IcItxKkfttRwT7kZgkjHjSZzg5Ff8otXcOUoHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+6pE2pM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+6pE2pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B27C116C6;
	Thu,  5 Mar 2026 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772699437;
	bh=IyyJMi7zPwn5aDcvOkYvk2n/48jPMfx+VyvC/C5ynGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+6pE2pMJ8eA/sgIrVOnNXfzfmGrnCAf9YRW/w3MFdSoxh0qseE/ROGlo4PanvJf7
	 WzhVLQ0CA6FEYFDoFKOv+W17RHOvtGBEgUsjEuZhfH11Sa7Gt3YuUwc1QSg4C2v/+U
	 +wdU5Dfb3L17RoNi+8WWFkLYDJHOaa7oLfbOdMTR3gsiepGviK+VNLOCqo0VZCXvQq
	 JPLoJ4uIvi0Rjq+c6nlPR0RTDMwPanwmKJDQKyl8bnb84Nll6FfiWeqpLdY/o3URLo
	 26mivd0iDu+XZ67R4QhUFijMbgAcX69YcGAkJauoS2So1AcINF0T9gcINiCviXpcLm
	 vmepa4yQh15Yw==
Date: Thu, 5 Mar 2026 08:30:30 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add mm-related procfs files to MM sections
Message-ID: <2cb16db9-75c8-4df6-b4e9-ea2a8b260d1b@lucifer.local>
References: <20260305-maintainers-proc-v1-1-d6d09b3db3b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-maintainers-proc-v1-1-d6d09b3db3b6@kernel.org>

On Thu, Mar 05, 2026 at 09:26:29AM +0100, Vlastimil Babka (SUSE) wrote:
> Some procfs files are very much related to memory management so let's
> have MAINTAINERS reflect that.
>
> Add fs/proc/meminfo.c to MEMORY MANAGEMENT - CORE.
>
> Add fs/proc/task_[no]mmu.c to MEMORY MAPPING.
>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Acked-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3553554019e8..39987895bcfc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16683,6 +16683,7 @@ F:	include/linux/ptdump.h
>  F:	include/linux/vmpressure.h
>  F:	include/linux/vmstat.h
>  F:	include/trace/events/zone_lock.h
> +F:	fs/proc/meminfo.c
>  F:	kernel/fork.c
>  F:	mm/Kconfig
>  F:	mm/debug.c
> @@ -16998,6 +16999,8 @@ S:	Maintained
>  W:	http://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>  F:	include/trace/events/mmap.h
> +F:	fs/proc/task_mmu.c
> +F:	fs/proc/task_nommu.c
>  F:	mm/interval_tree.c
>  F:	mm/mincore.c
>  F:	mm/mlock.c
>
> ---
> base-commit: 7fcd8889fbf318409163ff5033fe161dd2a73243
> change-id: 20260305-maintainers-proc-30e45ca9e434
>
> Best regards,
> --
> Vlastimil Babka (SUSE) <vbabka@kernel.org>
>
