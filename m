Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451E3B8BB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716190; cv=none; b=Vm6bW7mAgikYQ2A+7/liDcuRIMaWdDZY9o1gPfwmNv/wCyrbaqgDFJxNJeXR+jrNg6Cn+h9cNzE/5RgK530ztZnEwTtAch5HuzWelSyFlOWUGUETR3JMYOIFpfCTm0OsILcD2HAuKTw+a260zRXDsucDe/XiaSLkQCletsFPT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716190; c=relaxed/simple;
	bh=Z8yxHqMG9g05yiv+bIhS1KZXMzsu4GimcTWNeDUuN2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOC7bvwA1vmm5SvaIgqUnHxf5xwFk8wgBvpB0I7uDIFvfnqMS4FxTXMsLeaXSoUfCzSIfHskYZouww6fu7e2lXaaR7qY/yOcdJTFa0adwcN2wxlHj0cb/h6m51VgworzxJ3THm2iM+1jNWvD4149bRhVYcI0/PG/BtP0jo6p4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h31ZSqXC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9xd4KzmO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h31ZSqXC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9xd4KzmO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h31ZSqXC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9xd4KzmO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h31ZSqXC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9xd4KzmO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 021426C2C3;
	Wed, 17 Jun 2026 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781716184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DcMHKVtKqsBG0wRCJ/CPN+jPdn/UTziur14m5gtNaQ=;
	b=h31ZSqXCMF9T3OOyYU74FLkI6Nptppp0WjvcycB/C+eenpZ7hYaaol2nLco/jr2fslkavy
	1WxGCnfxIgUVkw+hkcQKef740ZCWj0Y8af/JHvJIKXELmHc4HL/5ciH6SMQLZ5pxxt/mzI
	i7YA6ijsPwWKIFAKL03zzFz68GAk/cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781716184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DcMHKVtKqsBG0wRCJ/CPN+jPdn/UTziur14m5gtNaQ=;
	b=9xd4KzmOAx7lAWOI7KduXR9idPxE6bIqrvN8B0Ac5TlMNvR6G9aA3sfO/+V6JTmyL6+eph
	bg9iNcH7CPkJkPDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h31ZSqXC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9xd4KzmO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781716184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DcMHKVtKqsBG0wRCJ/CPN+jPdn/UTziur14m5gtNaQ=;
	b=h31ZSqXCMF9T3OOyYU74FLkI6Nptppp0WjvcycB/C+eenpZ7hYaaol2nLco/jr2fslkavy
	1WxGCnfxIgUVkw+hkcQKef740ZCWj0Y8af/JHvJIKXELmHc4HL/5ciH6SMQLZ5pxxt/mzI
	i7YA6ijsPwWKIFAKL03zzFz68GAk/cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781716184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DcMHKVtKqsBG0wRCJ/CPN+jPdn/UTziur14m5gtNaQ=;
	b=9xd4KzmOAx7lAWOI7KduXR9idPxE6bIqrvN8B0Ac5TlMNvR6G9aA3sfO/+V6JTmyL6+eph
	bg9iNcH7CPkJkPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E863F779A8;
	Wed, 17 Jun 2026 17:09:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6ai5ONfUMmqaQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jun 2026 17:09:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9113FA0EC0; Wed, 17 Jun 2026 19:09:43 +0200 (CEST)
Date: Wed, 17 Jun 2026 19:09:43 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, Song Liu <song@kernel.org>
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
Message-ID: <kfrjt5r5g7frylkeep4sghwxoelb2zx3d232hk4v3dahzxbcpd@kfldymnymhha>
References: <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com>
 <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
 <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
 <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
 <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
 <yguigvx3sapcemq2oudlc6lmiwmxr27zx572oyqocbvefnpt3s@z3oj2pzgdjuj>
 <CAOQ4uxi2Mx4ZB48DhQJWOvt6UBur3LnrkttgRjo72U4+Cu81iQ@mail.gmail.com>
 <20260617-vorfahren-haften-nullnummer-b0d6fccadae3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617-vorfahren-haften-nullnummer-b0d6fccadae3@brauner>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 021426C2C3
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,linux.alibaba.com,vger.kernel.org,szeredi.hu,kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 17-06-26 15:37:33, Christian Brauner wrote:
> On Thu, Jun 11, 2026 at 05:25:56PM +0200, Amir Goldstein wrote:
> > On Thu, Jun 11, 2026 at 1:32 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 10-06-26 17:40:27, Amir Goldstein wrote:
> > > > On Wed, Jun 10, 2026 at 3:18 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > > > On 2026/6/10 20:21, Jan Kara wrote:
> > > > > > On Wed 10-06-26 16:17:33, Gao Xiang wrote:
> > > > > >> Amir just suggested that I posted a long off-list discussion
> > > > > >> on the list right now, but since it seems to relate to
> > > > > >> `sb->s_writers.rw_sem` locking design, I am not quite sure
> > > > > >> how deep I could help generally: But here it goes.
> > > > > >>
> > > > > >> The background is that we have discussed a generic deadlock
> > > > > >> timing for several months as below:
> > > > > >>
> > > > > >> fsA is a filesystem which supports fsfreeze, such as EXT4/XFS/...
> > > > > >>
> > > > > >> fsB is a filesystem which have some relationship with a
> > > > > >> userspace daemon (e.g. a filesystem with fanotify HSM hooks /
> > > > > >>    fanotify + EROFS file-backed mounts / a FUSE filesystem or
> > > > > >>    a filesystem backed by a virtual block device)
> > > > > >>
> > > > > >> Thread A                           Thread B                                 Userspace deamon
> > > > > >>   write(fsA_fd, mmap(fsB_fd))
> > > > > >>    file_start_write()
> > > > > >>     (take SB_FREEZE_WRITE read lock)
> > > > > >>
> > > > > >>     handle fsB mmap fault read
> > > > > >>      -> notify userspace and wait
> > > > > >>
> > > > > >>                                     freeze_super
> > > > > >>                                     (try to take SB_FREEZE_WRITE write lock)
> > > > > >>                                                                              received/handling fsB mmap read request
> > > > > >>                                                                              (do random something...)
> > > > > >>                                                                              write(fsA_fd2)
> > > > > >>                                                                               (take SB_FREEZE_WRITE read lock)
> > > > > >> The problem timing here is thread A does
> > > > > >> `write(fsA_fd, mmap(fsB_fd))` => file_start_write() (rwsem read),
> > > > > >> then hits page fault and wait for userspace deamon to finish
> > > > > >> the request;
> > > > > >>
> > > > > >> Thread B does fsfreeze on fsA so it is waiting a write lock
> > > > > >> (sb_wait_write(), rwsem write) and blocked on thread A;
> > > > > >>
> > > > > >> And the userspace deamon is a handler handling page fault,
> > > > > >> and trying to write to another file (fsA_fd2) on fsA again
> > > > > >> and blocked on thread B (file_start_write(), rwsem read).
> > > > > >>
> > > > > >> because of the specific locking timing is `R->W->R`, at least
> > > > > >> the whole workflow won't proceed so the related processes
> > > > > >> (and fsA above) will be stuck.
> > > > > >
> > > > > > Thanks a lot for the good summary! It has helped me to look at the problem
> > > > > > from a bit different angle and I don't think it's actually specific to
> > > > > > filesystem freezing or fanotify HSM. Consider the following simple setup:
> > > > > >
> > > > > > You have XFS filesystem fsA. On it you have a file imageA and you setup
> > > > > > loop device loop0 over imageA and mount it as some filesystem fsB. Now you
> > > > > > do write(imageA_fd, mmap(fsB_fd)) and you get a nice system deadlock (tried
> > > > > > that and it really works :)). The problem is that write to imageA_fd
> > > > > > acquires exclusively i_rwsem in imageA, then goes on to fault page on fsB
> > > > > > which maps to a read from loop0 which maps to a read from imageA and
> > > > > > xfs_file_read_iter() wants to acquire i_rwsem for imageA again.
> > > > >
> > > > > Ah, great catch, but mainly because XFS takes i_rwsem read lock
> > > > > on read paths LOL.
> > >
> > > Well, yes, that makes things particularly easy to hit but e.g. with direct
> > > IO much more filesystems (in particular everybody using iomap) than just XFS
> > > are prone to similar issues.
> > >
> > > > > Yes, yet this deadlock sounds more like a fixed flow/pattern, which
> > > > > is somewhat slightly different than fsfreeze issue since fanotify
> > > > > needs racy between threads (causing RWR order casually and cause
> > > > > Linux rwsem model deadlock) and may not need stacking filesystems.
> > >
> > > This example demostrates that the problem isn't specific to HSM or filesystem
> > > freezing. Yes, filesystem freezing given its filesystem wide scope is
> > > expanding the deadlock potential to more cases but the underlying problem
> > > really is that if you manage to do a syscall that holds locks on filesystem
> > > A and then ends up accessing filesystem B that's stacked on top of A, you
> > > are violating the expected lock ordering and this can lead to deadlocks.
> > >
> > > > > > Also with the use of filesystem freezing on fsA, write to any target
> > > > > > file (not only imageA) in fsA can create such deadlock if the page fault on
> > > > > > the stacked filesystem ends up wanting to do some modification of imageA.
> > > > > > So I don't think blocking IO to the loop device backing file will be even a
> > > > > > complete fix.
> > > > > >
> > > > > > I think the underlying reason why that write(imageA_fd, mmap(fsB_fd))
> > > > > > pattern causes issues is that it essentially creates a loop in the stacked
> > > > > > filesystem graph which can cause all sorts of lock inversions compared to
> > > > > > the natural order of taking locks for the stacked filesystems. So can we
> > > > > > somehow forbid that? Or do we simply not care and if priviledged user does
> > > > > > something stupid, he gets to reboot the machine? Any other ideas?
> > > >
> > > > Very unbacked idea, but something along the lines of:
> > > >
> > > > /*
> > > >  * sb_{start,end}_write() scope an "sb write transaction"
> > > >  */
> > > >
> > > > @@ -1283,6 +1283,8 @@ struct task_struct {
> > > >         /* Journalling filesystem info: */
> > > >         void                            *journal_info;
> > > >
> > > > +       /* Stacked filesystem write transactions: */
> > > > +       struct super_block
> > > > *sb_write_stack[SB_WRITE_MAX_STACK_DEPTH];
> > > > +       int                                         sb_write_stack_depth;
> > > > +
> > > >         /* Stacked block device info: */
> > > >         struct bio_list                 *bio_list;
> > > >
> > > > I don't know what a decent value of SB_WRITE_MAX_STACK_DEPTH
> > > > would be but its not the same as FILESYSTEM_MAX_STACK_DEPTH,
> > > > because loop/nbd/backing device also contributes to sb_write_stack_depth.
> > >
> > > I was thinking about something similar but then realized this won't fly -
> > > the deadlock chain is often split among multiple processes. Even in the
> > > case I've shown above there's the task doing the nasty write which holds
> > > i_rwsem on imageA and then a workqueue thread that actually does the loopback
> > > device IO which is trying to take it as well. No single process creates
> > > a loop, only all of them together form the loop.
> > 
> > Yap. I was considering whether we could copy the sb_tx_stack to the kiocb..
> > 
> > >
> > > > The rule is that sb_start_write(sb) pushes the sb to the tx stack
> > > > after checking no loops in the stack.
> > > >
> > > > In the common non-stacked case, there are no checks so the push/pop
> > > > should be quite cheap compared to the sb_writers locks.
> > > >
> > > > For the read side I hope that we do not need to track "read transactions"
> > > > in the stack and that it is enough to check the write stack in page faults and
> > > > stacked reads in loop/nbd/backing.
> > >
> > > That's another problem. Reads can create deadlocks as well. If you do
> > > read(imageA_fd, mmap(fsB_fd)) in the setup I've outlined in my previous
> > > email on XFS, you are holding i_rwsem for read for imageA and then doing a
> > > write fault to fsB which translates to a read from imageA which needs
> > > shared i_rwsem for imageA again. If you are lucky, this can pass but if
> > > someone tries to acquire imageA's i_rwsem for write inbetween (and blocks),
> > > your second shared i_rwsem acquisition will block and you have a deadlock.
> > >
> > 
> > Yeh we could introduce sb_read(sb) scopes but that would be a bit nasty.
> > The two-fds syscalls (e.g. sendfile()) makes this scoping even more challenging.
> > 
> > > > Note that the unscoped kiocb_start_write() in aio/uring will need to be
> > > > extended so that the write transaction scope will cover the io submission
> > > > to cover the page faults in input buffers.
> > > >
> > > > I have no idea about the feasibility of this and how much of the holes
> > > > this actually closes but if looking at the narrow use case of pre-content
> > > > events it might just be enough.
> > >
> > > What looks like the most feasible approach to me is to record in struct
> > > task we are doing a read/write syscall for fsA
> > 
> > read/write_iter could be nested within stacked fs, so we really need a stack
> > of transactions, but this one could be [FILESYSTEM_MAX_STACK_DEPTH]
> > 
> > > and in the page fault
> > > handler once we have the VMA we can check that fsB isn't fsA's ancestor in
> > > the "filesystem dependency graph". Making the check cheap enough should be
> > > doable (we could for example do the loop check traversal only if the
> > > stacking depth of fsB is higher than that of fsA, caching the stacking
> > > depth in the superblock, which would deal with 99.99% cases) but maintaining
> > > the dependency graph will take some work...
> > 
> > My crystal ball tells me we are probably not going to do that :-/
> > But if we did, it would have been nice to validate that LOOP_CHANGE_FD
> > does not set the backing file of loopA to a file on fsB ;)
> 
> LOOP_CHANGE_FD should be removed. I proposed that years ago because it's
> problematic in other ways. Everyone agreed as it was effectively unused
> I just never bothered pushing it through. So let's not worry about that
> let's kill it instead. Here's the patch from 2023:
> 
> From 46db77d781d329b7fc7b3245dd295a69026f6ec0 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Mon, 6 Nov 2023 16:29:32 +0100
> Subject: [PATCH] loop: remove support for swapping loop fds
> 
> We did not find any users of LOOP_CHANGE_FD.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I'm for trying this. Just maybe we could print a deprecation warning if
LOOP_CHANGE_FD is used for a while before deleting it completely? To not
outright break possible users if there are some by any chance?

								Honza

> ---
>  drivers/block/loop.c | 100 ++-----------------------------------------
>  1 file changed, 4 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 9f2d412fc560..ce6cb2125187 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -106,7 +106,7 @@ static DEFINE_MUTEX(loop_validate_mutex);
>   *
>   * Since loop_validate_file() traverses on other "struct loop_device" if
>   * is_loop_device() is true, we need a global lock for serializing concurrent
> - * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
> + * loop_configure()/__loop_clr_fd() calls.
>   */
>  static int loop_global_lock_killable(struct loop_device *lo, bool global)
>  {
> @@ -554,97 +554,6 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
>  	return 0;
>  }
>  
> -/*
> - * loop_change_fd switched the backing store of a loopback device to
> - * a new file. This is useful for operating system installers to free up
> - * the original file and in High Availability environments to switch to
> - * an alternative location for the content in case of server meltdown.
> - * This can only work if the loop device is used read-only, and if the
> - * new backing store is the same size and type as the old backing store.
> - */
> -static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
> -			  unsigned int arg)
> -{
> -	struct file *file = fget(arg);
> -	struct file *old_file;
> -	int error;
> -	bool partscan;
> -	bool is_loop;
> -
> -	if (!file)
> -		return -EBADF;
> -
> -	/* suppress uevents while reconfiguring the device */
> -	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
> -
> -	is_loop = is_loop_device(file);
> -	error = loop_global_lock_killable(lo, is_loop);
> -	if (error)
> -		goto out_putf;
> -	error = -ENXIO;
> -	if (lo->lo_state != Lo_bound)
> -		goto out_err;
> -
> -	/* the loop device has to be read-only */
> -	error = -EINVAL;
> -	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
> -		goto out_err;
> -
> -	error = loop_validate_file(file, bdev);
> -	if (error)
> -		goto out_err;
> -
> -	old_file = lo->lo_backing_file;
> -
> -	error = -EINVAL;
> -
> -	/* size of the new backing store needs to be the same */
> -	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
> -		goto out_err;
> -
> -	/* and ... switch */
> -	disk_force_media_change(lo->lo_disk);
> -	blk_mq_freeze_queue(lo->lo_queue);
> -	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
> -	lo->lo_backing_file = file;
> -	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
> -	mapping_set_gfp_mask(file->f_mapping,
> -			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
> -	loop_update_dio(lo);
> -	blk_mq_unfreeze_queue(lo->lo_queue);
> -	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> -	loop_global_unlock(lo, is_loop);
> -
> -	/*
> -	 * Flush loop_validate_file() before fput(), for l->lo_backing_file
> -	 * might be pointing at old_file which might be the last reference.
> -	 */
> -	if (!is_loop) {
> -		mutex_lock(&loop_validate_mutex);
> -		mutex_unlock(&loop_validate_mutex);
> -	}
> -	/*
> -	 * We must drop file reference outside of lo_mutex as dropping
> -	 * the file ref can take open_mutex which creates circular locking
> -	 * dependency.
> -	 */
> -	fput(old_file);
> -	if (partscan)
> -		loop_reread_partitions(lo);
> -
> -	error = 0;
> -done:
> -	/* enable and uncork uevent now that we are done */
> -	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
> -	return error;
> -
> -out_err:
> -	loop_global_unlock(lo, is_loop);
> -out_putf:
> -	fput(file);
> -	goto done;
> -}
> -
>  /* loop sysfs attributes */
>  
>  static ssize_t loop_attr_show(struct device *dev, char *page,
> @@ -1222,12 +1131,11 @@ static int loop_clr_fd(struct loop_device *lo)
>  
>  	/*
>  	 * Since lo_ioctl() is called without locks held, it is possible that
> -	 * loop_configure()/loop_change_fd() and loop_clr_fd() run in parallel.
> +	 * loop_configure() and loop_clr_fd() run in parallel.
>  	 *
>  	 * Therefore, use global lock when setting Lo_rundown state in order to
>  	 * make sure that loop_validate_file() will fail if the "struct file"
> -	 * which loop_configure()/loop_change_fd() found via fget() was this
> -	 * loop device.
> +	 * which loop_configure() found via fget() was this loop device.
>  	 */
>  	err = loop_global_lock_killable(lo, true);
>  	if (err)
> @@ -1558,7 +1466,7 @@ static int lo_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		return loop_configure(lo, mode, bdev, &config);
>  	}
>  	case LOOP_CHANGE_FD:
> -		return loop_change_fd(lo, bdev, arg);
> +		return -EOPNOTSUPP;
>  	case LOOP_CLR_FD:
>  		return loop_clr_fd(lo);
>  	case LOOP_SET_STATUS:
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
