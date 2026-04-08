Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2F3358B9;
	Wed,  8 Apr 2026 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775618469; cv=none; b=U/epAm8Nz9hGSkq88Dvo0hGFrcwORgHNqQ+B4EIfdMOLuC0NIwM0TTOOPFPo9C8ZyJBrQ6F7BVacVbBaN9mh2V4T79W4b6zIRbmH89uZy8ZlOX5U3KzfY8DcUFq8IprXuMDDFlZwVxpF+DOip5FDWNsq3lDesThHVVC3hs1qp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775618469; c=relaxed/simple;
	bh=KnNKUv3eJ5Gv1Q9yr28xE3tQt7BYIq2Uf+I/m02aYU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUDrflJ3QXjWxEoTNqkuUKxKIoNsAb7HfTXKzK91SUZhdXw/gErn+QU4MFMLXEaKhx1VepyRG/M0IdQ/PyM/lSrAGkvQPBi5NGw0wTxXala+UZORf+dladYY3aK/SK+GIE5ZhqLEjuOhbhTEZlF6bU7Rzox4jzb7/5Ls6nao/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLEPRTWT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLEPRTWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D6FC2BC9E;
	Wed,  8 Apr 2026 03:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775618468;
	bh=KnNKUv3eJ5Gv1Q9yr28xE3tQt7BYIq2Uf+I/m02aYU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLEPRTWTWMuvM/pn2Zr3e5H/+PLyJBECnRsfx1IGeGWsRnf26c+Oi0w/RvsESOVHG
	 7S6pzzD3w5uEpO12RHBP1XtQYody9cJRCesG7dUo4GzeMtXVwmTgAfFSFt2l4GOwpR
	 PVha60LqnCGgwSU4v5KZEMFpOqENdbT2EX4MAmcxDtlorLrkPkv0+huBcH28qH+NeZ
	 UlOu67M81w9Zu2+ad+L+6cftiWIjQNvBqUk2YlIcW5bPrGuRAu5VZ7Mb1LbVME+uqT
	 eOKKLRs4RFg8U4iqZa8vWcu0RNR2zeyb24O5lF3My47GN7sgy9q3aHitw6UO66K0WE
	 eNox0fC2T52Zw==
Date: Wed, 8 Apr 2026 12:21:06 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Denis M. Karpov" <komlomal@gmail.com>
Cc: rppt@kernel.org, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	ljs@kernel.org, vbabka@kernel.org, jannh@google.com,
	peterx@redhat.com, pfalcato@suse.de, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] userfaultfd: allow registration of ranges below
 mmap_min_addr
Message-ID: <adXJop1d0QdH2Mwm@hyeyoo>
References: <20260407081442.6256-1-komlomal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407081442.6256-1-komlomal@gmail.com>

On Tue, Apr 07, 2026 at 11:14:42AM +0300, Denis M. Karpov wrote:
> The current implementation of validate_range() in fs/userfaultfd.c
> performs a hard check against mmap_min_addr without considering
> capabilities, but the mmap() syscall uses security_mmap_addr()
> which allows privileged processes (with CAP_SYS_RAWIO) to map below
> mmap_min_addr. Furthermore, security_mmap_addr()->cap_mmap_addr() uses
> dac_mmap_min_addr variable which can be changed with
> /proc/sys/vm/mmap_min_addr.
> 
> Because userfaultfd uses a different check, UFFDIO_REGISTER may fail
> with -EINVAL for valid memory areas that were successfully mapped
> below mmap_min_addr even with appropriate capabilities.
> 
> This prevents apps like binary compilers from using UFFD for valid memory
> regions mapped by application.
> 
> Replace the rigid mmap_min_addr check with security_mmap_addr() to align
> userfaultfd with the standard kernel memory mapping security policy.

Perhaps worth adding

Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")

> Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
> 
> ---
>  fs/userfaultfd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index bdc84e521..dbfe5b2a0 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1238,15 +1238,13 @@ static __always_inline int validate_unaligned_range(
>  		return -EINVAL;
>  	if (!len)
>  		return -EINVAL;
> -	if (start < mmap_min_addr)
> -		return -EINVAL;
>  	if (start >= task_size)
>  		return -EINVAL;
>  	if (len > task_size - start)
>  		return -EINVAL;
>  	if (start + len <= start)
>  		return -EINVAL;
> -	return 0;
> +	return security_mmap_addr(start);

Hmm but it looks bit strange to check capability for address that is
already mapped by mmap(). Why is this required?

>  }

-- 
Cheers,
Harry / Hyeonggon
