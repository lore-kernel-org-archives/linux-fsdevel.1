Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C0298CA3
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177579; cv=none; b=Hm6RoT8PyyKTE5z8i4DorwcmnClXhd/0VthuRO0PwEW2ovqgcDl30Q532FbR0CRrssQFbBu3BhPA7MWYpfIBAKWH8v9uhP4peQz8oVK1VRbc8iAu38gdTbBVbZoIn2Gf/8axYyGEvVK5DjiNa5n2Kmiz5jvirngzsMrAABLuUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177579; c=relaxed/simple;
	bh=xv6hyo3wHnARNC0rgEWHbcd91G8ogVFTL8F2tbSY/Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHy/5QaqbIZk0sl1z+QItNxW9GtFci3Br+gAkFSTRD4La4LYmx8YYMuyCfgHE60yd2ozZuq5OxaqtuRDykag4hgZpxLlCJdpNHglLKAr5P5R4CoR1SyE5wlNiS6xxY35trNfZjM8gwKOU3SlE9/hRhweQavYynArUrY/Jq84/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C5t1hanl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xvbf4E44; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C5t1hanl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xvbf4E44; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C5t1hanl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xvbf4E44";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C5t1hanl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xvbf4E44"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 125C175BD9;
	Thu, 11 Jun 2026 11:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781177576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbdo83APk20Gd3K2eHaziMotS1aHP6+sGgw407a0j74=;
	b=C5t1hanlmkOKkUOd4DnwzpHjbGYlgA2yD3hsT9P/86jnazUUdr4AdwzAMCCYEvlv4xdX/H
	u3I+cTHUKRJK5osKbZSPp2zrwJhlxm3bs8AyyJoq9tAqVg8ZM7VjxG7Ncd3lYkwSV6xq+D
	EMA0Ue1qeZB9UE1rgUbvFdkNpHJCJ0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781177576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbdo83APk20Gd3K2eHaziMotS1aHP6+sGgw407a0j74=;
	b=Xvbf4E44cGIH7/aYx8zsHrDILYQVL1AVrioYyih/VlZYPgWuL3l+KagDnBf7XhVQpkBk/e
	jFmp4kzsiDZlTQCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781177576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbdo83APk20Gd3K2eHaziMotS1aHP6+sGgw407a0j74=;
	b=C5t1hanlmkOKkUOd4DnwzpHjbGYlgA2yD3hsT9P/86jnazUUdr4AdwzAMCCYEvlv4xdX/H
	u3I+cTHUKRJK5osKbZSPp2zrwJhlxm3bs8AyyJoq9tAqVg8ZM7VjxG7Ncd3lYkwSV6xq+D
	EMA0Ue1qeZB9UE1rgUbvFdkNpHJCJ0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781177576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbdo83APk20Gd3K2eHaziMotS1aHP6+sGgw407a0j74=;
	b=Xvbf4E44cGIH7/aYx8zsHrDILYQVL1AVrioYyih/VlZYPgWuL3l+KagDnBf7XhVQpkBk/e
	jFmp4kzsiDZlTQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04B2B779A7;
	Thu, 11 Jun 2026 11:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2eMdAeicKmoAIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Jun 2026 11:32:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97680A10CE; Thu, 11 Jun 2026 13:32:51 +0200 (CEST)
Date: Thu, 11 Jun 2026 13:32:51 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, Song Liu <song@kernel.org>
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
Message-ID: <yguigvx3sapcemq2oudlc6lmiwmxr27zx572oyqocbvefnpt3s@z3oj2pzgdjuj>
References: <dff837f6-7480-4984-8728-802ddd78dda4@linux.alibaba.com>
 <CAOQ4uxi7DceKuh6+qGjuQJEFiE=HEFu4dMrc++VXUknRnX26JQ@mail.gmail.com>
 <95371379-97e9-4cb4-8358-ec014b765b74@linux.alibaba.com>
 <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com>
 <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
 <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
 <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
 <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,alibaba.com:email]
X-Spam-Level: 

On Wed 10-06-26 17:40:27, Amir Goldstein wrote:
> On Wed, Jun 10, 2026 at 3:18 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > On 2026/6/10 20:21, Jan Kara wrote:
> > > On Wed 10-06-26 16:17:33, Gao Xiang wrote:
> > >> Amir just suggested that I posted a long off-list discussion
> > >> on the list right now, but since it seems to relate to
> > >> `sb->s_writers.rw_sem` locking design, I am not quite sure
> > >> how deep I could help generally: But here it goes.
> > >>
> > >> The background is that we have discussed a generic deadlock
> > >> timing for several months as below:
> > >>
> > >> fsA is a filesystem which supports fsfreeze, such as EXT4/XFS/...
> > >>
> > >> fsB is a filesystem which have some relationship with a
> > >> userspace daemon (e.g. a filesystem with fanotify HSM hooks /
> > >>    fanotify + EROFS file-backed mounts / a FUSE filesystem or
> > >>    a filesystem backed by a virtual block device)
> > >>
> > >> Thread A                           Thread B                                 Userspace deamon
> > >>   write(fsA_fd, mmap(fsB_fd))
> > >>    file_start_write()
> > >>     (take SB_FREEZE_WRITE read lock)
> > >>
> > >>     handle fsB mmap fault read
> > >>      -> notify userspace and wait
> > >>
> > >>                                     freeze_super
> > >>                                     (try to take SB_FREEZE_WRITE write lock)
> > >>                                                                              received/handling fsB mmap read request
> > >>                                                                              (do random something...)
> > >>                                                                              write(fsA_fd2)
> > >>                                                                               (take SB_FREEZE_WRITE read lock)
> > >> The problem timing here is thread A does
> > >> `write(fsA_fd, mmap(fsB_fd))` => file_start_write() (rwsem read),
> > >> then hits page fault and wait for userspace deamon to finish
> > >> the request;
> > >>
> > >> Thread B does fsfreeze on fsA so it is waiting a write lock
> > >> (sb_wait_write(), rwsem write) and blocked on thread A;
> > >>
> > >> And the userspace deamon is a handler handling page fault,
> > >> and trying to write to another file (fsA_fd2) on fsA again
> > >> and blocked on thread B (file_start_write(), rwsem read).
> > >>
> > >> because of the specific locking timing is `R->W->R`, at least
> > >> the whole workflow won't proceed so the related processes
> > >> (and fsA above) will be stuck.
> > >
> > > Thanks a lot for the good summary! It has helped me to look at the problem
> > > from a bit different angle and I don't think it's actually specific to
> > > filesystem freezing or fanotify HSM. Consider the following simple setup:
> > >
> > > You have XFS filesystem fsA. On it you have a file imageA and you setup
> > > loop device loop0 over imageA and mount it as some filesystem fsB. Now you
> > > do write(imageA_fd, mmap(fsB_fd)) and you get a nice system deadlock (tried
> > > that and it really works :)). The problem is that write to imageA_fd
> > > acquires exclusively i_rwsem in imageA, then goes on to fault page on fsB
> > > which maps to a read from loop0 which maps to a read from imageA and
> > > xfs_file_read_iter() wants to acquire i_rwsem for imageA again.
> >
> > Ah, great catch, but mainly because XFS takes i_rwsem read lock
> > on read paths LOL.

Well, yes, that makes things particularly easy to hit but e.g. with direct
IO much more filesystems (in particular everybody using iomap) than just XFS
are prone to similar issues.

> > Yes, yet this deadlock sounds more like a fixed flow/pattern, which
> > is somewhat slightly different than fsfreeze issue since fanotify
> > needs racy between threads (causing RWR order casually and cause
> > Linux rwsem model deadlock) and may not need stacking filesystems.

This example demostrates that the problem isn't specific to HSM or filesystem
freezing. Yes, filesystem freezing given its filesystem wide scope is
expanding the deadlock potential to more cases but the underlying problem
really is that if you manage to do a syscall that holds locks on filesystem
A and then ends up accessing filesystem B that's stacked on top of A, you
are violating the expected lock ordering and this can lead to deadlocks.

> > > Also with the use of filesystem freezing on fsA, write to any target
> > > file (not only imageA) in fsA can create such deadlock if the page fault on
> > > the stacked filesystem ends up wanting to do some modification of imageA.
> > > So I don't think blocking IO to the loop device backing file will be even a
> > > complete fix.
> > >
> > > I think the underlying reason why that write(imageA_fd, mmap(fsB_fd))
> > > pattern causes issues is that it essentially creates a loop in the stacked
> > > filesystem graph which can cause all sorts of lock inversions compared to
> > > the natural order of taking locks for the stacked filesystems. So can we
> > > somehow forbid that? Or do we simply not care and if priviledged user does
> > > something stupid, he gets to reboot the machine? Any other ideas?
> 
> Very unbacked idea, but something along the lines of:
> 
> /*
>  * sb_{start,end}_write() scope an "sb write transaction"
>  */
> 
> @@ -1283,6 +1283,8 @@ struct task_struct {
>         /* Journalling filesystem info: */
>         void                            *journal_info;
> 
> +       /* Stacked filesystem write transactions: */
> +       struct super_block
> *sb_write_stack[SB_WRITE_MAX_STACK_DEPTH];
> +       int                                         sb_write_stack_depth;
> +
>         /* Stacked block device info: */
>         struct bio_list                 *bio_list;
> 
> I don't know what a decent value of SB_WRITE_MAX_STACK_DEPTH
> would be but its not the same as FILESYSTEM_MAX_STACK_DEPTH,
> because loop/nbd/backing device also contributes to sb_write_stack_depth.

I was thinking about something similar but then realized this won't fly -
the deadlock chain is often split among multiple processes. Even in the
case I've shown above there's the task doing the nasty write which holds
i_rwsem on imageA and then a workqueue thread that actually does the loopback
device IO which is trying to take it as well. No single process creates
a loop, only all of them together form the loop.

> The rule is that sb_start_write(sb) pushes the sb to the tx stack
> after checking no loops in the stack.
> 
> In the common non-stacked case, there are no checks so the push/pop
> should be quite cheap compared to the sb_writers locks.
> 
> For the read side I hope that we do not need to track "read transactions"
> in the stack and that it is enough to check the write stack in page faults and
> stacked reads in loop/nbd/backing.

That's another problem. Reads can create deadlocks as well. If you do
read(imageA_fd, mmap(fsB_fd)) in the setup I've outlined in my previous
email on XFS, you are holding i_rwsem for read for imageA and then doing a
write fault to fsB which translates to a read from imageA which needs
shared i_rwsem for imageA again. If you are lucky, this can pass but if
someone tries to acquire imageA's i_rwsem for write inbetween (and blocks),
your second shared i_rwsem acquisition will block and you have a deadlock.

> Note that the unscoped kiocb_start_write() in aio/uring will need to be
> extended so that the write transaction scope will cover the io submission
> to cover the page faults in input buffers.
> 
> I have no idea about the feasibility of this and how much of the holes
> this actually closes but if looking at the narrow use case of pre-content
> events it might just be enough.

What looks like the most feasible approach to me is to record in struct
task we are doing a read/write syscall for fsA and in the page fault
handler once we have the VMA we can check that fsB isn't fsA's ancestor in
the "filesystem dependency graph". Making the check cheap enough should be
doable (we could for example do the loop check traversal only if the
stacking depth of fsB is higher than that of fsA, caching the stacking
depth in the superblock, which would deal with 99.99% cases) but maintaining
the dependency graph will take some work...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
