Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434D3B4E9D;
	Thu,  9 Apr 2026 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731423; cv=none; b=WvQmcQNrpuIyqv6f6+8n+IJ8uxYs7kcF0sF+kupaJ76P1cnbUOv/VmrDnoXY3QGR/kEHES8L4Y5AWPqPi/GDqBopzad3dbFJv2I9pYTQab3x8UILnLXlrT4oWMzx99pYGWPorJQT4XuHIyZNwfHccV9nJGD645Ph1Kg6HK/zIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731423; c=relaxed/simple;
	bh=5ml8mhhklm4HBRD0vDuN9qP5ofPgl4kjNMeUuK18QGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvC46n3gxFW/LCTYbjVh7eXzzRcheliShg89Aj3DJ8mBtbaYfy+SMq23ys7vdsW/rWre3A/cFPpIL7u+1YkEwf3qYZG6NssDnSADvx8GYHyKmO5oIGB2aigm/Ab8DlhEvVEYY34LbXdDn/xTU4WbgAb8bf2Z5yEIyevyKpaVb9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1mGk+uV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1mGk+uV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C869FC4CEF7;
	Thu,  9 Apr 2026 10:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775731423;
	bh=5ml8mhhklm4HBRD0vDuN9qP5ofPgl4kjNMeUuK18QGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1mGk+uVsWVNNwAuFFURUf9UZHih8sBBd4h80F2ws7Tq9q+/Jto0fxGGLVvf+JRHA
	 CjfTETaNUEXPjrlE3a+FuxugUUMxCNJw7koLBXE80KdImHw7TBsovAyAO0rjrjUzw7
	 67ZAuIl92UvVjlryJjQPf68g9kb+Nw7QvnLqVFzhgp+JDT2Q9wCyZ33f5SRhvhJRDj
	 0j6+n69s2Yw+UENuNAA3BlEQdqm5EHUvsPjly9dIYXKnZ3fygeqjMI9Wu9SKFRzdS1
	 8XudLwhctfto2SuTccbP1+UdzVZSRD5HXBYkYVlHWg8ZJNsLbjpUgLZ+QCXcLvKIsY
	 RWTYoAK12wh2A==
Date: Thu, 9 Apr 2026 11:43:37 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Denis M. Karpov" <komlomal@gmail.com>
Cc: harry@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, jannh@google.com, peterx@redhat.com, 
	pfalcato@suse.de, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	usama.arif@linux.dev
Subject: Re: [PATCH v2] userfaultfd: allow registration of ranges below
 mmap_min_addr
Message-ID: <adeCuu2ByxD3Sx1l@lucifer>
References: <20260409103345.15044-1-komlomal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409103345.15044-1-komlomal@gmail.com>

On Thu, Apr 09, 2026 at 01:33:45PM +0300, Denis M. Karpov wrote:
> The current implementation of validate_range() in fs/userfaultfd.c
> performs a hard check against mmap_min_addr. This is redundant because
> UFFDIO_REGISTER operates on memory ranges that must already be backed
> by a VMA.
>
> Enforcing mmap_min_addr or capability checks again in userfaultfd is
> unnecessary and prevents applications like binary compilers from
> using UFFD for valid memory regions mapped by application.
>
> Remove the redundant check for mmap_min_addr.
>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Denis M. Karpov <komlomal@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
> v2:
> - Remove the check entirely rather than replacing it, as suggested by
>   Harry Yoo and Lorenzo Stoakes.
> - Added Fixes tag.
> - Link to v1: https://lore.kernel.org/r/20260407081442.6256-1-komlomal@gmail.com
> ---
>  fs/userfaultfd.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index bdc84e521..4b53dc4a3 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1238,8 +1238,6 @@ static __always_inline int validate_unaligned_range(
>  		return -EINVAL;
>  	if (!len)
>  		return -EINVAL;
> -	if (start < mmap_min_addr)
> -		return -EINVAL;
>  	if (start >= task_size)
>  		return -EINVAL;
>  	if (len > task_size - start)
> --
> 2.43.0
>
