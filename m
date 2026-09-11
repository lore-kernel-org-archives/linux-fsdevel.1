Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACB4AEBE5;
	Fri, 11 Sep 2026 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151216; cv=none; b=psTUDSL9AvcrL93MgBO6IyXS3LoxuWzi5qe3bGMi7lmaHt6gXfo/G+bvKDU4yCL/v4rxHYle5ZMr6iKnMxj+CrkDMor/MHRw0tAMkEL+QdTZPwFjFqSCL6N/nmn+DfWjiHYJesjYKg9cpGGj3vCluEAXQHsGQ0zWmuIdcImztZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151216; c=relaxed/simple;
	bh=vkhyf6ZBPu9hq+BJ9KILIffSpoP6g4+ZP39pvN9mtTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STEV0LUkvPBZtv+USPSulzi33ajl9cb/YswsCl6LIUfKdt5YSQ59hvfyQ7IyD61Zz51UfwiHJURnz+JBWcjt2nV9h5hAc/Cqfm6YsH1z5DKdMWQMMedOiYlBN0OPfNXa363t+uBJN++dDPDN/0VIRocSfv0yFjB0Ur9djnLJjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZbb/QQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZbb/QQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29791F000FF;
	Fri, 11 Sep 2026 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789151214;
	bh=YJ0O0JaLtVP+XxR8QGsN0vFEwgtrJIgdHqxaxpf//gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RZbb/QQNX947GjiHM/rvFaywRPpzDljnISz8So1ljEZ/W8YoDwh9lmfhKxMaOMllH
	 f1jlg/Wwwwt18W5lDeTYH/n3A7Gd7uFOvx+37M0qlmGQOxoW72W9dV4EcO5YSCnhdy
	 fsphlPKbsHtFVb1lVgLvymKWotj/WXeBweyF9/lEiTnKySR/AgEFuvA/JSYOr2fwYJ
	 8L1X8UJhd0OxFGuB1KiOr+6TIYDYA7FdE6cTZTIwZl92pXwKfiL7cjlLcLhpJuzfkO
	 LzHutFm+dtFAQ0Db8AKfLt35gLgngcMPJisdPRfBWmsDj598nFYBxdENzGOtasOwYc
	 upxzEE+ORsLrQ==
Date: Fri, 11 Sep 2026 19:26:49 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] proc/task_mmu: change proc_get_vma() to stop
 returning gate VMA at the end
Message-ID: <aqRF4YB7Ijk9PmRM@gremlin>
References: <20260910234737.1340642-1-surenb@google.com>
 <20260910234737.1340642-6-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910234737.1340642-6-surenb@google.com>

On Thu, Sep 10, 2026 at 04:47:35PM -0700, Suren Baghdasaryan wrote:
> proc_get_vma() returning gate VMA at the end is desirable for the its
> current m_start/m_next callers, as they need to report a gate VMA at the
> end of the address space. This behavior is very specific to these callers
> and makes proc_get_vma() hard to use for other purposes.
>
> Move this usage-specific behavior into the callers themselves so that
> proc_get_vma() returns either a valid VMA, an error or a NULL when no
> more VMAs are available. This makes it more generic, simpler and usable
> in the later patches.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Yes, very good change, thanks!

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ecce7ce116cb..9a3c996c1d61 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -236,9 +236,6 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
>  		 * found the extended vma with the same vm_start.
>  		 */
>  		*ppos = vma->vm_end;
> -	} else {
> -		*ppos = SENTINEL_VMA_GATE;
> -		vma = get_gate_vma(priv->lock_ctx.mm);

Yeah this is just so confusing as-was.

>  	}
>
>  	return vma;
> @@ -248,6 +245,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  {
>  	struct proc_maps_private *priv = m->private;
>  	struct proc_maps_locking_ctx *lock_ctx;
> +	struct vm_area_struct *vma;
>  	loff_t last_addr = *ppos;
>  	struct mm_struct *mm;
>
> @@ -280,16 +278,31 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  	if (last_addr == SENTINEL_VMA_GATE)
>  		return get_gate_vma(mm);
>
> -	return proc_get_vma(m, ppos);
> +	vma = proc_get_vma(m, ppos);
> +	if (vma)
> +		return vma;
> +
> +	/* Return gate VMA at the end */
> +	*ppos = SENTINEL_VMA_GATE;
> +	return get_gate_vma(mm);
>  }
>
>  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
>  {
> +	struct proc_maps_private *priv = m->private;
> +	struct vm_area_struct *vma;
> +
>  	if (*ppos == SENTINEL_VMA_GATE) {
>  		*ppos = SENTINEL_VMA_END;
>  		return NULL;
>  	}
> -	return proc_get_vma(m, ppos);
> +	vma = proc_get_vma(m, ppos);
> +	if (vma)
> +		return vma;

OK so I guess the logic is, iterate through every VMA, then once you run out,
report the gate VMA. Makes sense.

> +
> +	/* Return gate VMA at the end */
> +	*ppos = SENTINEL_VMA_GATE;
> +	return get_gate_vma(priv->lock_ctx.mm);
>  }
>
>  static void m_stop(struct seq_file *m, void *v)
> --
> 2.55.0.1007.g17ff1f9808-goog
>

--
Cheers, Lorenzo
