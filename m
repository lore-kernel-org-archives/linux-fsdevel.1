Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC13EFD28;
	Thu, 28 May 2026 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972148; cv=none; b=k0AEQ5F9u42vZL4leexX6m9LeJcB4dSgh74JKRVSLXv/fVXHrdhY+6Cyj2s2x3VXGDyhCTKhdyn0dBPOEyvAamBOnFOXHUPjb46YiGU7T5bZuDOtVJw1+ygjL9XPlQqNxcXGjAeuovw94ZSOpA92awIPG9mgy71k1WNY6c7T+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972148; c=relaxed/simple;
	bh=QjdCLWWX/H/grBUq7I5ZM3PN008iZKz9sKZ/1xSxPbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idsHg8qiDW38WthiVmkm9wRis5hXE/rgnwFnlNb5zOF/ka3lUY0Xqz3jfI31L0w0Mn0fISr3lXMD67SnHS9hHqrV6nbsMSibd1TS1Ro7AAa4wNbJeU4GK5+lDhkC2gV5Zii9yTWUEHvSd4L92f75x5J36c8cc6gQJGPbv9iVAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzsYg1Ns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzsYg1Ns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5A81F00A3C;
	Thu, 28 May 2026 12:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779972147;
	bh=C5i+/XRpUzgwloG7CI+oy9DlxNL0wvo9H3vzYWIX5rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IzsYg1NsnAOEgGSm7GgU8EHLZnGsKm5SqmLclZYB5Oy6y/ae2cMh/lj2/bQFSZU4C
	 K5kDfc2Sn20K9PH5uDY5C9JCHbD4CJo2wnHJwW9gMujpg7miT+rJP/Pvb4+ytAOURn
	 ATRfmLqjC2NGAvK1QoIeJSgKdMT5FWbtKnusCHrdDceg1b6HnHflYHQRG7kJJuUpkP
	 4H7hxaf1lXmxVqXCRAxfK2HwMKVDr97MzWiXW4AXhWQXwJQ25bgZjhNtifNStYnDq9
	 UQfLDBo2mPPB8EpAEtOZB7kQhgZVY4k+h828+ahy4vQPj9x4q2DiVTLIbtl7ou7t/Z
	 cO69vNNkgBZlA==
Date: Thu, 28 May 2026 14:42:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
Subject: Re: [PATCH] eventpoll: fix use-after-free in clear_tfile_check_list()
Message-ID: <20260528-wendung-vielleicht-klargemacht-27241ff15b32@brauner>
References: <20260523091107.61880-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260523091107.61880-1-kartikey406@gmail.com>

On Sat, May 23, 2026 at 02:41:07PM +0530, Deepanshu Kartikey wrote:
> syzbot reports a slab-use-after-free read in
> clear_tfile_check_list() during EPOLL_CTL_ADD when ep_insert()
> takes an error path that calls ep_remove() before
> do_epoll_ctl_file() drains ctx->tfile_check_list.
> 
> ep_remove_file() decides whether to kmem_cache_free() a struct
> epitems_head by testing v->next == NULL, on the convention that
> NULL means "this head is not linked on any check list".
> list_file() pushes a head onto ctx->tfile_check_list by storing
> the previous list head into head->next; when the list is empty
> that store is NULL, so the head that ends up at the tail of the
> check list also has next == NULL. ep_remove_file() then misreads
> the tail as "not linked" and frees it. clear_tfile_check_list()
> later walks the list and dereferences head->next on the freed
> object:
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
> Terminate ctx->tfile_check_list with a non-NULL sentinel
> (EP_TFILE_LIST_END) so that next == NULL unambiguously means
> "not on any check list". list_file() stores the sentinel when
> the list is empty, reverse_path_check() and
> clear_tfile_check_list() stop the walk on the sentinel, and
> do_epoll_ctl_file() seeds ctx->tfile_check_list with it. The
> guard in ep_remove_file() then correctly refuses to free a head
> while it remains on the check list.
> 
> Reported-by: syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=69a3d7738ad3aa175caf
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/eventpoll.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index a569e98d4a99..349d79e8ddc8 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -222,6 +222,15 @@
>  
>  #define EP_UNACTIVE_PTR ((void *) -1L)
>  
> +/* Non-NULL sentinel terminating ctx->tfile_check_list, so that
> + * "head->next == NULL" unambiguously means "this head is not on any
> + * check list" -- the invariant ep_remove_file() and list_file() rely
> + * on. Without this, the tail of the check list aliases the
> + * "not linked" state and ep_remove_file() may free a head that
> + * clear_tfile_check_list() still references.
> + */
> +#define EP_TFILE_LIST_END ((struct epitems_head *)EP_UNACTIVE_PTR)

Better than the other fix but I'm really confused about this define...
