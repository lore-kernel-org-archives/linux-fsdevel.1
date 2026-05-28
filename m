Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575CE3E63BB;
	Thu, 28 May 2026 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973380; cv=none; b=lwf7yCiEe1Iip6pZC241S2vNxiaqchnEHa2ES/w2ubfAkHtSeDm1KICZQsk7KDbm0cOLkCs+LVfMthufhbwuz6RL7SOQoXrqGWbZDQTDZ0IjPf3a2an4UEP2JT7RzYUxWMjYemxbeV0jkvKxGs4mI9ieIyfePmEKKV2ljtCoOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973380; c=relaxed/simple;
	bh=hp3N1BlaCEBo40AI5r7xHP6l+ggEflBpXEwKQIjkybQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m53Sakjc9cETl4nYf+OiT3a7IwbDKw2FjLdCadtffqcu+Iaay6NndtiTPIBEsG6yp8R4ofXVHgXPu4rhKOOXKFD7VUmRUGD5CUEZLgttY2HmNlbtaW5+kcLWV/ls/wdOZT0EIuUI68cJIZuFWJkR9MG4f8P1r52wsW5q6whTiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPwCWdO5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPwCWdO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564341F00A3A;
	Thu, 28 May 2026 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779973378;
	bh=TIAUg/ZVKNqvTA8OMB2jX9V/vIvoB2IFv0g+QQaqho8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OPwCWdO5JiTusiyHJ5/gGhmCfAS/U+AbZ9hPU3j9riiMXkSChnWQco0zNOuvpoB5k
	 YZEjwHBmMScYY45vzZgHOtKjb6qlCMnascrpq4ymIXjxCRPT5a/j7n9vab1KkukjvH
	 aly2lokpEZh9ujZn/Mtvq8MWq8F3rXg0VLf9e58l/Lw4zjpCUt6QEIByJDJmtTZn7K
	 GfX2jwDfJ6FcTcEMGj0kQJU1raQIRvxtmp3O3Dysb1sIE/xI1g9T5KHvl/XRRMiYkf
	 kfhhFyTVJ4z3viR8UUYlfrr1rwQu3NnkrcmIlhWrYp4naJwIn1G7Yynx8ROuRgN4Pz
	 D3veNFhZ8lp4A==
Date: Thu, 28 May 2026 14:02:55 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Daniel Palmer <daniel@thingy.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH] tmpfs/ramfs: Let memfd_create() work on nommu
Message-ID: <ahg6FiMo7cEQxod_@lucifer>
References: <20260523130445.1101818-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523130445.1101818-1-daniel@thingy.jp>

+cc Liam

On Sat, May 23, 2026 at 10:04:45PM +0900, Daniel Palmer wrote:
> Currently trying to use memfd_create() on nommu returns
> an error with errno set to EFBIG. The manpage memfd_create()
> doesn't have EFBIG as a possible error value.
>
> Doing some digging this is coming from 0 getting passed as
> newsize to ramfs_nommu_expand_for_mapping() and that getting
> into get_order() and there "The result is undefined if the size is 0".
>
> Whatever comes out of get_order() is then used in the following
> logic and that results in the EFBIG that causes the syscall
> to fail and the errno in userspace.
>
> If newsize is 0 there is nothing to do so just return.
>
> Roughly tested on m68k nommu by creating a process, creating
> an memfd, forking another process, mmap()ing the memfd in the
> child, writing into the mapping, then mmap()ing in the parent
> and checking that the right data is there.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

I don't really have the setup to check it, but I don't see a problem with
this so:

Acked-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>
> Really not sure if this is correct. It works for me but on
> nommu a lot of things just work because there is no MMU to
> shout about badness.

:)

>
> Maybe shashiko will say this is a dumb patch and explain
> the proper fix. :)

No see below I think this is correct.

>
> Also I had almost no idea who to send this to from the output
> of get_maintainer.pl.

Yeah this file doesn't really belong anywhere... the mm bits of nommu are
(ostensibly :P) maintained by me and Liam though.

>
>  fs/ramfs/file-nommu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
> index 2f79bcb89d2e..fb471bf88ab7 100644
> --- a/fs/ramfs/file-nommu.c
> +++ b/fs/ramfs/file-nommu.c
> @@ -69,6 +69,9 @@ int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
>  	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
>
>  	/* make various checks */
> +	if (!newsize)
> +		return 0;
> +

Hmm yeah get_order() literally says the result is undefined if you input 0,
and it bizarrely returns BITS_PER_LONG - PAGE_SHIFT in that case.

So this isn't correctly handling 0 size at all.

Also in the case of a mmu, this function collapses to a stub that just
returns 0 and the rest of __shmem_file_setup() runs fine if size == 0.

So yeah this is probably right!

>  	order = get_order(newsize);
>  	if (unlikely(order > MAX_PAGE_ORDER))
>  		return -EFBIG;
> --
> 2.53.0
>
>
>

Cheers, Lorenzo
