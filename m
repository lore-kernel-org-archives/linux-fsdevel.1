Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658B3CE0B8;
	Thu, 28 May 2026 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971871; cv=none; b=ruYu1zeJKaFIa5FbNuRGsQxQJ/OvD49rw0JJY3psVNNlDtmsRrMzJApRS0HpTr+cLbw4fhHmnaBuOe+S4tt8TVLvJs2bBvnKRrn4ObQx6w7EMYxUJtuVI2s1lBNebMgQiUahRYmd419MJ3eD9JVZS2irI3t07I6nn0FHGHEr2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971871; c=relaxed/simple;
	bh=mmnoPt15+qs3RmOtku8ioQ7TvJ3dfcU4zFUNcyxUwP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pch7prN1fabzAjvgIKSkHH0CHdJ+aRnJR6kyMUJckLm59SLUWm2LpVXTbjZVQmbYFV4lp4aCwR0e9fvaed2AMndR8pmMxAVFxzQQWfuMMUb5SImpvMN3OXxVsYRExBqsOWmmCcTDvvi2DaGFDSxuFEbf6WGFoJU2r/0raLD9jf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ6klsev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ6klsev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1938F1F000E9;
	Thu, 28 May 2026 12:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779971870;
	bh=M8G3i6goheh0Mmjf3tA+ST7Bvo3Ily0cO7hQgBU0Ex8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KQ6klsevexAehYbhHUed2ko75nKY2IORdg3vTw3kDnZzL0UKCFcQtXdo3hW5O0pR7
	 hIR7aCLAeAd5ojvvF8lbGNalw48iaJ1i02cqiPMk3qBDZkAjPkEd4QrnqzSZfLntL5
	 f71jkMdD/iRFudMpmVOWORBd+icdlvt31Q6Ay64JY0NeJoJoz6Cjo14c9DMkGa4mhC
	 UMGa5yxKC8Ejo1MBEFnh/KVZN9OeU48fLt6HsAwgG88Cf8leAGHohCNqRU7iQbS1bg
	 IRP6pupvWAzUHlpc233+jK18sbqv2xhMCTPOzkm4YnqczyEWQeR82RnYRzt4sYlcac
	 X/cKxwFG4Mi9A==
Date: Thu, 28 May 2026 14:37:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH next] eventpoll: delay file list memory deallocation
 until unlisting
Message-ID: <20260528-rotwild-summt-kuhhandel-7276ef4c33b7@brauner>
References: <6a10a5e1.050a0220.66ea1.0008.GAE@google.com>
 <tencent_C65896BCE9C2EEE2CCF078666E102DC56D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_C65896BCE9C2EEE2CCF078666E102DC56D0A@qq.com>

On Sun, May 24, 2026 at 06:27:59PM +0800, Edward Adam Davis wrote:
> Commit e09c77d94003 implicitly sets the head->next value within list_file()
> to NULL; this occurs because ctx->tfile_check_list which resides on the stack
> is initialized to NULL. This introduces a potential risk to ep_remove_file(),
> as the decision to reclaim epitems_head depends solely on whether the next
> pointer is NULL. Prior to the introduction of e09c77d94003, the presence of
> the sentinel value EP_UNACTIVE_PTR prevented the next pointer from becoming
> NULL prematurely; the next value would only be updated to NULL during the
> execution of unlist_file(). 
> However, following the introduction of e09c77d94003, list_file() also updates
> the next value to NULL, which ultimately led to the uaf reported in [1].
> 
> To mitigate the risk posed by the potentially NULL next pointer, the memory
> reclamation for the file list originally performed within ep_remove_file()
> has been deferred to unlist_file().
> 
> [1]
> BUG: KASAN: slab-use-after-free in clear_tfile_check_list+0x114/0x380 fs/eventpoll.c:2443
> Read of size 8 at addr ffff88803f021568 by task syz.0.74/5985
> Call Trace:
>  clear_tfile_check_list+0x114/0x380 fs/eventpoll.c:2443
>  do_epoll_ctl_file+0x8fd/0xed0 fs/eventpoll.c:-1
>  
> Allocated by task 5985:
>  ep_attach_file fs/eventpoll.c:1751 [inline]
>  ep_register_epitem fs/eventpoll.c:1833 [inline]
>  ep_insert+0x512/0x1820 fs/eventpoll.c:1876
>  do_epoll_ctl_file+0x8bb/0xed0 fs/eventpoll.c:2651
>  
> Freed by task 5985:
>  kmem_cache_free+0x187/0x6c0 mm/slub.c:6411
>  ep_remove+0x155/0x2a0 fs/eventpoll.c:1135
>  ep_insert+0x1372/0x1820 fs/eventpoll.c:-1
>  do_epoll_ctl_file+0x8bb/0xed0 fs/eventpoll.c:2651
> 
> Fixes: e09c77d94003 ("eventpoll: hoist CTL_ADD scratch state into struct ep_ctl_ctx")
> Reported-by: syzbot+69a3d7738ad3aa175caf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=69a3d7738ad3aa175caf
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/eventpoll.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index a569e98d4a99..66aa4f200909 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1080,6 +1080,8 @@ static void ep_remove_file(struct eventpoll *ep, struct epitem *epi,
>  			v = container_of(head, struct epitems_head, epitems);
>  			if (!smp_load_acquire(&v->next))
>  				to_free = v;
> +			if (!hlist_empty(&v->epitems))
> +				to_free = NULL;

Hm, at the singular-node check, hlist_del_rcu hasn't run yet so
!hlist_empty(&v->epitems) is unconditionally true. So this stops freeing
heads in all cases. Heads that were never on ctx->tfile_check_list
(CTL_ADD without full_check, or any CTL_DEL of a previously-unlisted
head) leak permanently.

Wouldn't something like:

  diff --git a/fs/eventpoll.c b/fs/eventpoll.c
  @@ static int reverse_path_check(struct ep_ctl_ctx *ctx)
  -     for (p = ctx->tfile_check_list; p; p = p->next) {
  +     for (p = ctx->tfile_check_list; p != EP_UNACTIVE_PTR; p = p->next) {

  @@ static void clear_tfile_check_list(struct ep_ctl_ctx *ctx)
        rcu_read_lock();
  -     while (ctx->tfile_check_list) {
  +     while (ctx->tfile_check_list != EP_UNACTIVE_PTR) {
                struct epitems_head *head = ctx->tfile_check_list;
                ctx->tfile_check_list = head->next;

  @@ int do_epoll_ctl_file(...)
  -     struct ep_ctl_ctx ctx = { };
  +     struct ep_ctl_ctx ctx = {
  +             .tfile_check_list = EP_UNACTIVE_PTR,
  +     };

be better?
