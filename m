Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07744BCAC
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777992248; cv=none; b=dqdbHw+BI6bImN6TEl5L7WA3PRfD7agxqIRyZLwFxi9COAKKyiFsI1JjxoErRDS5HpTMx7HcBniuks8POdSFJOfAEQzeTzoD+qZrwL4419M6hSBEe02tgrLeo/g8Z5Un6Z/Hdp7Q36Q5EMB0dIwcdl3MoxuXe5SWfNeNNu7LxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777992248; c=relaxed/simple;
	bh=sJ1FkjPsRbzQizJUznEHuhNPDw227vUNlg5aTigQ4Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNAfYhF4U/ccoy7nPeTF4CDJkCoCLBzehm2z1PI0CmwLTkiaQ+BGRl5wunOb+a1uyAQl2CuMGpG9BJHpSNJ4hJLue6D5hOZYDBN5+agUUjOP8P5eAZ5QUSQKkaXI4JyU43gAVQWeFebnlJlxgGHn8XxY9B709/pIs6uLt2G+IMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=bbeZRZlH; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="bbeZRZlH"
X-KPN-MessageId: d819d003-4890-11f1-8a9e-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d819d003-4890-11f1-8a9e-005056ab378f;
	Tue, 05 May 2026 16:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=EpkfHYDX9N36ztJc2XbQY5BO+uE0H/CU/VDcE+8AHjA=;
	b=bbeZRZlH99trB392SOY3R65FM+yETtrWK9Bxv0XI+ZpxkHWXJHHWhVPkGtEtnADkbkTkJhdjL3K7t
	 HqKAP4wO8Dfas5AWXADInIeWrVSPtTeOl0HjSdHEpBHTp6FCBCI0zV+3Zbu7/b/uIthUXHqRRaDdoI
	 FlCI8k3nt8fH12nMO5z7McW2ONtE/4E5GaLF6aTKoOJY2SYJRqnWIdzQn/YGeEETflbjs83MhiqZfc
	 xLkqC+F1n9e9/LuGuRSt6FqBSQHod2IxNyqql2uPtNLAKR2bVnwtYHHXUxG3tf2rAAsaSvwZQCITPf
	 HqJEJCBEx3I3GLdvQ2D9PaZzeYMgqzA==
X-KPN-MID: 33|Jq0cOGL0rjqmzvd1bcL7OgQl73bPb2TM0tWIB9TK65o4xDg+LtDc0s9qo4fBlse
 CBKGset0WhPuJvhf1b4oqnX/wT4ULDNX1yZbCXOsnhVA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zbVZQVf1Cv6U+B29KN7YnrXIyD6146KtqzupM40dCiizNeYwv6+yB8IFc8Uf4m8
 iOq4dvERLLlWUdAcsJimRyQ==
Received: from localhost (unknown [178.226.144.191])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id d7d3101a-4890-11f1-a6cc-005056abf0db;
	Tue, 05 May 2026 16:43:56 +0200 (CEST)
Date: Tue, 5 May 2026 16:43:48 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot <syzbot@syzkaller.appspotmail.com>
Subject: Re: [PATCH] fs/namespace: fix NULL pointer dereference in
 do_lock_mount()
Message-ID: <afn88B9Z5TM-0d0T@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Vineet Agarwal <agarwal.vineet2006@gmail.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot <syzbot@syzkaller.appspotmail.com>
References: <20260505095156.178351-1-agarwal.vineet2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505095156.178351-1-agarwal.vineet2006@gmail.com>

On Tue, May 05, 2026 at 03:21:31PM +0530, Vineet Agarwal wrote:
> Syzkaller reported a NULL pointer dereference in do_lock_mount()
> when calling inode_lock() on a dentry without an associated inode.
> 
> where_to_mount() may return a negative dentry (without an inode)
> due to concurrent unlink or mount changes. The current code does
> not validate this before calling inode_lock(), leading to a crash.

Can you explain what call path could lead to having path here refer
to a negative dentry? Is it not the case that a positive dentry's
d_inode is stable as long as you hold a reference to the dentry? If,
so it cannot be killed underneath us.

> 
> Fix this by checking dentry and dentry->d_inode before acquiring
> the inode lock.
> 
> Reported-by: syzbot <syzbot@syzkaller.appspotmail.com>

This is not enough. Which syzbot issue are you trying to fix?

> Closes: https://syzkaller.appspot.com/
> Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
> ---
>  fs/namespace.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe919abd2f01..b1dccdf06836 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2760,6 +2760,17 @@ static void do_lock_mount(const struct path *path,
>  			}
>  		}
>  
> +		if (unlikely(!dentry || !dentry->d_inode)) {
> +			err = -ENOENT;
> +			if (&m->mnt != path->mnt) {
> +				if (dentry)
> +					dput(dentry);
> +				mntput(&m->mnt);
> +			}
> +			res->parent = ERR_PTR(err);
> +			return;
> +		}
> +
>  		inode_lock(dentry->d_inode);
>  		namespace_lock();
>  
> -- 
> 2.54.0
> 

Thanks,
Jori.
