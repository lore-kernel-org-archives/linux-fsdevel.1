Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003946;
	b=hs9I7MaVHGjSK3pGPrV0yOFXV0ZVF4na58IJ9u1eyvLFP9oBDi02u8AwxTlo6mxO2lRc
	 fIk697FocWVbLoKIwCwQOd/yBOlJsp27hAFc73dNeeIiQjPfyMkUNcsGpJNKm3XIzpzeW
	 /yytSP7zVe0Z/2c+M9ZH6W5RmFHa0Uxtq84Iq70kXJiydqljaBdpMt59lCSkSwXpHXTOa
	 5kzeQchOVpHC5oACfr0iI7jToSwZ8+XhOvHJNQ2WRv3DaPlBiQ//5oKXBAWHkgCvnYFzk
	 n9jgAUkycKEm9iXvJEjgLKftu2dcKgjumdGutUcnTQHTLoMcCAbr6fstkVABMPpFuLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003946;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=epBVrGZiw1creBvuYOePhoSdCzgWgXCOkWpLld3FPh8=;
	b=VnZAXoDZCT/nv7essSYCBC79x4ajYL9UG9O1Lag6c1pP+pMf1rxGvHtZNVfhHNemQu28
	 Rs7gGO5zInaDqJ9g5gUf6ieoJ1FnKybSeDwEILWh1pgbjrRh5/NBdy+HMxscoEgKdGPCr
	 hZBRdJ2Tki0SKVfIGb0bo3UoFTiM0crW4BSdDUNdtGl57I4ETEoRr879/wY2hyW1uVFFH
	 qUcU9FdiQfSn4ETyxa+x70MmDdP2VjhrvX0TWZKqkM/cFuY+HAt5qrS5d/afw9EHoqM0n
	 pr+eloyFcf+oOiZr2fYGvm0dgeD1BEIzZL8h+KHYy9Z1vAiObd33MCC/xxm0GNkpijg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXXJ2R0J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2D606A31C;
	Wed, 18 Nov 2026 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXXJ2R0J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04FF1F000C6;
	Wed, 18 Nov 2026 12:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795003945;
	bh=epBVrGZiw1creBvuYOePhoSdCzgWgXCOkWpLld3FPh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XXXJ2R0J07MlKzGSwWu2Ztiv4YkTe+gqNLjFMOxXUTiqc4KhcH/eJEWxVN7VQM116
	 cNXqLxlFhUHJ8b+uND7+oerzPM38gJdjj0EIHS5jjoV26s5vq9ie2EDCKWGMd28ES9
	 Hczw4PXnJ9cJTSDkjHo/lQpCxhKXGuIbLH9GClLCRri2llSYafn1JTyhTibDDUQaoE
	 7p31kQGSigBrTorB0Aso2vAFqpbRvlZegUa3yhW6vEEzmvMx28m0TIejxJFrFf0+3m
	 MXoGpnzAjwGpCfwhPDQn2qu1O8ze7DwTbiDl6RFv80riVktXjfpwU/hcwj/tAKPR0S
	 oHS/+luRr9Oiw==
Date: Wed, 18 Nov 2026 12:12:20 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ahuang12@lenovo.com
Subject: Re: [PATCH mm-unstable v2 1/1] fs/proc/task_mmu: avoid spurious
 seq_file warning on interrupted VMA lookup
Message-ID: <av2V-JWdu8GqKtMT@gremlin>
References: <20261118103421.776-1-adrianhuang0701@gmail.com>
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
In-Reply-To: <20261118103421.776-1-adrianhuang0701@gmail.com>

(micro-nit - no need to say 1/1 for a single patch :)

On Wed, Nov 18, 2026 at 06:34:21PM +0800, Adrian Huang (Lenovo) wrote:
> Commit 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under
> per-vma lock") introduced the possibility of returning -EINTR from
> proc_get_vma() when a fatal signal interrupts mmap_read_lock_killable().
>
> The issue can be reproduced using stress-ng's VMA stressor, which reads
> /proc/self/maps while concurrently modifying VMAs and periodically
> terminates child processes with SIGKILL. The reproduced command is:
>
>   # stress-ng --vma 0 -t 60
>
> When the VMA lookup is interrupted, proc_get_vma() returns an error
> pointer without advancing the position index. Consequently,
> seq_read_iter() emits the following rate-limited informational message:
>
>   seq_file: buggy .next function m_next did not update position index
>
> Save the current position in priv->last_pos before checking the VMA
> lookup result, allowing it to be reused by both successful and error
> paths. Advance the position index when returning an error to avoid
> the spurious warning, while preserving the original error handling.
>
> Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

LGTM and:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> Changes since v1:
>   - Simplify the error handling and comments as suggested by Lorenzo.
>   - Clarify the fatal-signal trigger and the cosmetic nature of the warning.
>
>  fs/proc/task_mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 22361607020d..564e52f7ddc6 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -216,16 +216,17 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
>
>  retry:
>  	vma = get_next_vma(priv, *ppos);
> -	/* EINTR of EAGAIN is possible */
> +	/* Store previous position to be able to restart if needed */
> +	priv->last_pos = *ppos;
>  	if (IS_ERR(vma)) {
>  		if (PTR_ERR(vma) == -EAGAIN && fallback_to_mmap_lock(priv, *ppos))
>  			goto retry;
>
> +		/* Advance to avoid spurious buggy seq warning in dmesg */
> +		(*ppos)++;
>  		return vma;
>  	}
>
> -	/* Store previous position to be able to restart if needed */
> -	priv->last_pos = *ppos;
>  	if (vma) {
>  		/*
>  		 * Track the end of the reported vma to ensure position changes
> --
> 2.43.0
>

--
Cheers, Lorenzo
