Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806A3EC2E7;
	Tue, 31 Mar 2026 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949629; cv=none; b=K9HhjsK9quTknhKNlVwiK+8503+80hTxEqV8awxQ+7HLSrUoLFazZLUkvCnxJxXiY2zEOfJbuYe+BTdiJDegwbWJjD0KeMExm/JDTyT0XzcpQGegGRT8XTenlHyuB4Ow/TEp3eGyWVT+SQdqiNOeFDZyVxKy7f61FTO1Nj90vZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949629; c=relaxed/simple;
	bh=MdJ9ChSNl9qkWCRUekDGGT5ohssAShwNiTeODdZBFc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBV3usezuyNxBACBYnRiFCchTnMeVStltQMA6/cHm1ic7qwiy76z0a4GqIPyAYJDL2i5lRDJi/dOUWnFFSkHq8RfaSl9ikvk306IRk+C0rVuW7WXE09T414fwN3cQgT3W4GwZPuftQTCt/NoIzR8WdG+dEZOgPi0aC6WAm2wpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUgSSYHh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUgSSYHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DC2C19423;
	Tue, 31 Mar 2026 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774949629;
	bh=MdJ9ChSNl9qkWCRUekDGGT5ohssAShwNiTeODdZBFc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUgSSYHhlm+LABd6P/XjiP4jA46FEn0NWjPNgR6RX7agkJBeih2vWKLUmn2EFSQ97
	 XTlUXRpmZcWXrCajoRK8zb56pRgCPao6SEkz/WlieyoXMWVwkKdC0NsbuThHofITs+
	 psbQl8lWzMbdxu69CANJFL14EATiLVpSMQG+++JnSDFYm3MlaaFOw4BeEb38VrMwD1
	 O3vtWhwMDq6a158xDkSfDnOYV+Bz6+DjT0IuOmEq7RK+KIQ+so7cOBAsKUUgnaoYgX
	 XmBbVl5tCb/Fzi13qV2SxgqsAsA8kPU8wSn+JJe/fshH5Cy/UBIsp5Xa+7t7/KfQxw
	 gAkgv6JxHk6uQ==
Date: Tue, 31 Mar 2026 11:33:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
Message-ID: <20260331-hornissen-beklagen-f63db82fdcc1@brauner>
References: <20260320130615.1109449-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320130615.1109449-1-kartikey406@gmail.com>

On Fri, Mar 20, 2026 at 06:36:15PM +0530, Deepanshu Kartikey wrote:
> 
> When do_splice_direct_actor() is called with the same inode
> for both input and output files (either via the same fd or a
> dup'd fd), it causes a hung task in blkdev_write_iter().
> 
> The deadlock occurs because sendfile() calls do_splice_direct()
> which tries to acquire inode_lock_shared() for reading, while
> the write side already holds the same inode lock, causing the
> task to block indefinitely in rwsem_down_read_slowpath().
> 
> Fix this by checking if the input and output files share the
> same inode before proceeding, returning -EINVAL if they do.
> This mirrors the existing check in do_splice() for the
> pipe-to-pipe case where ipipe == opipe.
> 
> Reported-by: syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d31a3b77e5cba96b9f69
> Tested-by: syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---

@Jens?

>  fs/splice.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 9d8f63e2fd1a..c0ad1859de34 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1199,6 +1199,9 @@ static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
>  	if (unlikely(out->f_flags & O_APPEND))
>  		return -EINVAL;
>  
> +	/* Prevent deadlock when splicing a file to itself */
> +	if (file_inode(in) == file_inode(out))
> +		return -EINVAL;
>  	ret = splice_direct_to_actor(in, &sd, actor);
>  	if (ret > 0)
>  		*ppos = sd.pos;
> -- 
> 2.43.0
> 
