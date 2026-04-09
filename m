Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF539023C;
	Thu,  9 Apr 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747605; cv=none; b=lIgdtjl/4dcY7xQBU6U5PpyzFapN6JMpGswbXcI5KlqwJ4POXTQ7dFQBxqdNm36GrMxmqDaE+h8PgNsWkKKN5HOqjLPbxfNDZvKdEAXk3v5FxItpzDMWNjAuXLtmfCW6wLnomHVBNGJHAvHmhet0ipdvm7bMMH7hpdVPrDi7a1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747605; c=relaxed/simple;
	bh=owesWMMhEZ10jRbXPNEnxMG0zX+QmTfFOcYuaS6Uh0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7OZHjPTSXqE6oqnPC12DsG2FrrVc7lScgy+Nf4aY2nEZufVyvL1+foIwxZnorMV+LpGIvdXmURCYEwAUK4r2sDd/XNQxMeM+XVoR2ivnEeCa8wzRfDqhOT4LTCewW1ivMyZn21JVHwVCCGDKvsotbqet54FyqMTXrBmz2AT6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4EN9yu5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4EN9yu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ECCC116C6;
	Thu,  9 Apr 2026 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775747605;
	bh=owesWMMhEZ10jRbXPNEnxMG0zX+QmTfFOcYuaS6Uh0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4EN9yu524R4fMKtvtcTuJmGimqWFPvuyMWu5Y+SlnHXdSp+SHpy8AtM2EXrf1522
	 rXrnFY8/E5aAHwDVA0tlaQk+rsUzOydQolkX2P8gn+nAHCetUtkzB2mxwLJ2dWaej/
	 SevoiQOBFet5p4dBRVg3GCjZ8t6KTwvFLfgV8O48llfr3A3yO2Kz+JlIzNhP0uDSw4
	 mtdrfqI8M/fsL/wa33uQffEvI2UxZtt2/8BOTJeLX2Tt6fimxeCAfaS+gAhC71N6EF
	 ZUcN9x87gzSTFDol4yR+vKH1kft72K1FWXfiSoOlNpzr310/3F5quZSDr++OwnN+2M
	 u5BEbnaY47OpA==
Date: Thu, 9 Apr 2026 18:13:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Denis M. Karpov" <komlomal@gmail.com>
Cc: harry@kernel.org, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	ljs@kernel.org, vbabka@kernel.org, jannh@google.com,
	peterx@redhat.com, pfalcato@suse.de, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	usama.arif@linux.dev
Subject: Re: [PATCH v2] userfaultfd: allow registration of ranges below
 mmap_min_addr
Message-ID: <adfCDR9Rh9p6aZun@kernel.org>
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

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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

-- 
Sincerely yours,
Mike.
