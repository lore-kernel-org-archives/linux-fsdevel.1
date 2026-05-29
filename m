Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0194330666;
	Fri, 29 May 2026 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040712; cv=none; b=MxzupJ/BFY2RKer0MRQS/8B7YyeLOgkxKxwggm15+N2U8rXUIZhvkRURm55iBq3ApCGFogoU3qZ7APn/gPcpTNNYdmN4oFd/3umsdyWdnXhEw1yKHobljEp6XH+flrwv1jjLZh98ZXlx66F/3MbTG61F3a+VDcptiAmQzpxjmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040712; c=relaxed/simple;
	bh=icE6oeDyFZHyWSqKYqz1F1LJfnYRwe6fQEAJcmZZ//M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWW+3BgaHgU6Y3g4c/nOOULF66NNHnpCeZiDWqkjBR9VZEF31Xvo4rwWVSL5OPX5jRZx/9DoYJIjsYYNq4poHqevOG79QFo51E0ekyYwXCple3gjSOS+ZIjr+sxX11wXtT10nIxJlaCnyiJYM6E96KSwY1YUKl4urlw4bt6z+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3lQviWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3lQviWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412581F00893;
	Fri, 29 May 2026 07:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780040711;
	bh=BfU2QDjd341DStvm6XpOxML+HizNxEZQg7DSLoctvcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h3lQviWhnhaQ6nARGr0hqiPygZ9kKGp5O4RqP6hUDMiD3mvhUUQ+4ddR4IbtmGK3Q
	 /i4CRioO7Hnsj2PZxvNK+zoH32iy35OFxHroJ/7ynffkkixnUewmH9ZAJ7HraodoqS
	 qJSQHUMCkFmDdNehOKTwNlzgfNTVy/WFUhnihI+EEgz5rvlCUbhAFQBbchdILfX4zK
	 4esjtXE7u7jRJYxpAAHnHFSwHXqcbH+jlF4//Z4uD2QH4tF96iQJA6BucCYDiGnyfn
	 X8kbUC7JsDc+swEkxemd5IqaLLGMrjgR2Rdo+XrNR/9DgQfBGeTvDXYuWFIMO9v38F
	 qtmaJY+hyE57w==
Date: Fri, 29 May 2026 09:45:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] eventpoll: fix use-after-free in
 clear_tfile_check_list()
Message-ID: <20260529-quast-epilog-gelernt-a381bb87c32e@brauner>
References: <20260529042507.87593-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529042507.87593-1-kartikey406@gmail.com>

On Fri, May 29, 2026 at 09:55:07AM +0530, Deepanshu Kartikey wrote:
> syzbot reports a slab-use-after-free read in clear_tfile_check_list()
> during EPOLL_CTL_ADD when ep_insert() takes an error path that calls
> ep_remove() before do_epoll_ctl_file() drains ctx->tfile_check_list.
> 
> ep_remove_file() decides whether to kmem_cache_free() a struct
> epitems_head by testing v->next == NULL, on the convention that NULL
> means "this head is not linked on any check list". list_file() pushes
> a head onto ctx->tfile_check_list by storing the previous list head
> into head->next; when the list is empty that store is NULL, so the
> head that ends up at the tail of the check list also has next == NULL.
> ep_remove_file() then misreads the tail as "not linked" and frees it.
> clear_tfile_check_list() later walks the list and dereferences
> head->next on the freed object:
> 
>   BUG: KASAN: slab-use-after-free in
>        clear_tfile_check_list+0x114/0x380 fs/eventpoll.c:2443
>   Allocated by task 5985:
>     ep_attach_file fs/eventpoll.c:1751 [inline]
>     ep_register_epitem fs/eventpoll.c:1833 [inline]
>     ep_insert+0x512/0x1820 fs/eventpoll.c:1876
>   Freed by task 5985:
>     ep_remove+0x155/0x2a0 fs/eventpoll.c:1135
>     ep_insert+0x1372/0x1820
> 
> Terminate ctx->tfile_check_list with EP_UNACTIVE_PTR (the existing
> non-NULL sentinel used elsewhere in this file for inactive list
> slots) so that next == NULL unambiguously means "not on any check
> list". list_file() stores the sentinel when the list is empty,
> reverse_path_check() and clear_tfile_check_list() stop the walk on
> the sentinel, and do_epoll_ctl_file() seeds ctx->tfile_check_list
> with it. The guard in ep_remove_file() then correctly refuses to
> free a head while it remains on the check list.
> 
> Reported-by: syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=69a3d7738ad3aa175caf
> Link: https://lore.kernel.org/all/20260523091107.61880-1-kartikey406@gmail.com/T/ [v1]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2: Reuse the existing EP_UNACTIVE_PTR sentinel instead of adding a
>     new EP_TFILE_LIST_END define, per review feedback.
> ---
>  fs/eventpoll.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index a569e98d4a99..2fc3b14d7ab2 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -472,7 +472,13 @@ static void list_file(struct file *file, struct ep_ctl_ctx *ctx)
>  
>  	head = container_of(file->f_ep, struct epitems_head, epitems);
>  	if (!head->next) {
> -		head->next = ctx->tfile_check_list;
> +		/*
> +		 * Terminate the check list with EP_UNACTIVE_PTR (non-NULL)
> +		 * so that head->next == NULL unambiguously means "not on
> +		 * any check list". ep_remove_file() relies on that
> +		 * invariant to decide whether the head is safe to free.
> +		 */
> +		head->next = ctx->tfile_check_list ? : (struct epitems_head *)EP_UNACTIVE_PTR;

I'm still confused why all the casts are needed...
