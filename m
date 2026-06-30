Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96832FA30;
	Tue, 30 Jun 2026 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782791937; cv=none; b=n2htVwlBVRsBN++iJBeSP79mWXTUJHaKcY5FLRxmIXKlp1xwK+3vVcCipVGHzaHzvPvgwWyaGg6PKZ4ikcXqPjJEyY7y8CbwC7GCu8gMomtzFNQH/NLAKw6NCSEY3hJlwg+Z03VHs6ad/AKEYGwNvHcGBdauZTU2T7O7SaF6Jzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782791937; c=relaxed/simple;
	bh=BNBCDun1OGDkp3w3Mj7xVI/yyes3zom9OtNp7H3N9+o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MmFOEA/gkYc55/wnIMRDCuIC/JdPBhRZpBQttZ6wF+jNVBSM0vIsaNRy8MTTy8Aw0F58vh7KxSEju+WKzucTbX+KbTCUetoGrLHVOWO6UMWxzA7JQLlg9UFjVs9MWOCCNdWV4UJ/ReDb8vIRSpSwZcYIvLNJVnm+kBsg04fQBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LyAxgN98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LyAxgN98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A33F1F000E9;
	Tue, 30 Jun 2026 03:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782791935;
	bh=N89Up5BXPY/yDZUMYrHxzavh21D3+xcyvzN4VyJg2o0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LyAxgN98kQZcX32CCab64mlHrDaYfRHMLVPQd4Z3hPWx4F/VUBubQdNILCdOwsGEz
	 mMkVWTgJnIG4KM7WGRIk9b16omEFl/XRAuOcUibLZDZTm+C5kTqi4OITXyCThUEuYJ
	 qiYxFdaLVl362tIBMrV+jB2QyOGfOoQHUBe+6fUg=
Date: Mon, 29 Jun 2026 20:58:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Daniel Palmer <daniel@thingy.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [PATCH] tmpfs/ramfs: Let memfd_create() work on nommu
Message-Id: <20260629205854.0062b1fc9588ba9928bb1707@linux-foundation.org>
In-Reply-To: <20260523130445.1101818-1-daniel@thingy.jp>
References: <20260523130445.1101818-1-daniel@thingy.jp>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 22:04:45 +0900 Daniel Palmer <daniel@thingy.jp> wrote:

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

Old patch, older code.   Thanks.

> Really not sure if this is correct. It works for me but on
> nommu a lot of things just work because there is no MMU to
> shout about badness.
> 
> Maybe shashiko will say this is a dumb patch and explain
> the proper fix. :)

Sashiko had no complaints but it seems to have found some unrelated
bugs:

	https://sashiko.dev/#/patchset/20260523130445.1101818-1-daniel@thingy.jp

(tmpfs calls "ramfs_nommu" code.  Who knew?)

> Also I had almost no idea who to send this to from the output
> of get_maintainer.pl.

I suspect most would prefer it's someone else, but this is viro/brauner
stuff, if anyone)

> --- a/fs/ramfs/file-nommu.c
> +++ b/fs/ramfs/file-nommu.c
> @@ -69,6 +69,9 @@ int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
>  	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
>  
>  	/* make various checks */
> +	if (!newsize)
> +		return 0;
> +
>  	order = get_order(newsize);
>  	if (unlikely(order > MAX_PAGE_ORDER))
>  		return -EFBIG;

Oh well, thanks, I'll toss it onto the pile and see what happens.

