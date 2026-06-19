Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22DC1FBEBC
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853929; cv=none; b=k0azq2NpFLCGk6R6d5GvoEb88QfDt5gOa/kwwVJgHjzBHDoj2YETan5FKE8QQWnxGQDQTJssnGXaTnUxVR44W/qQppWcW2PPLQBpdNwrc31AXqM4UyMeyIuJ32F0cH9b9E1Hnv24qVchwQNFQIv571PoR0p1YsLqSAPpaV5HFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853929; c=relaxed/simple;
	bh=oCTxZRZUcxKAihry9JfVCozPwHpcRgwmDqY41lIp9ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba4FcHaR1Pc9mLDrZVcWF3w0zYyLBMqMRaNNY4cTlx+kIhSibRaDVsVWJgJYFKkV/WNTk12z4VV/5nNjixKmItcumXExq4jsHmHladJNoxzcHvbfqG2T9akCjvAU3cdAw9FDuzkpw10fFExW6dTwb2sutj3jLXsb0t2sQwIuSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGjBAPu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGjBAPu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2041F000E9;
	Fri, 19 Jun 2026 07:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781853927;
	bh=wBKXTvgnLzZ4YQAV1KXZei0DVlX9rYp1Stai+raEcmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kGjBAPu3S68FfW3TgWAzwsgz4uWbt6npR8osLIgEGOzEksQk+KNSezaP4+0OdzSu+
	 inNDa+t77tVbLhoWTmEbx29Oh2QkbNqVDdTFB5Kk7GLG7F+Qd3qv8fCimmZbVclwph
	 by9kShDFlgTxgoKvf5Ge2QmPSLikj4XGSUNLPAqGbFuHRIl7A8sTmCpG1EZPgabnnu
	 lAoIX0ejC4NX6qpw1o2+nxUhdZUsiQd56QOzFimaJhS2Zj/tsvesDT59cxH90shQFY
	 81ZVgV8WxmviSdpAlaad5I6LS6Szzqz/VtIS6hioN2YScwUzAZoOyjUCMc1jFPCgTW
	 YsIRj5iwyY1wA==
Date: Fri, 19 Jun 2026 09:25:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, Song Liu <song@kernel.org>
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
Message-ID: <20260619-zenit-betiteln-urzeiten-c8fca9ed6a80@brauner>
References: <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com>
 <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
 <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
 <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
 <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
 <yguigvx3sapcemq2oudlc6lmiwmxr27zx572oyqocbvefnpt3s@z3oj2pzgdjuj>
 <CAOQ4uxi2Mx4ZB48DhQJWOvt6UBur3LnrkttgRjo72U4+Cu81iQ@mail.gmail.com>
 <20260617-vorfahren-haften-nullnummer-b0d6fccadae3@brauner>
 <kfrjt5r5g7frylkeep4sghwxoelb2zx3d232hk4v3dahzxbcpd@kfldymnymhha>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kfrjt5r5g7frylkeep4sghwxoelb2zx3d232hk4v3dahzxbcpd@kfldymnymhha>

On Wed, Jun 17, 2026 at 07:09:43PM +0200, Jan Kara wrote:
> On Wed 17-06-26 15:37:33, Christian Brauner wrote:
> > On Thu, Jun 11, 2026 at 05:25:56PM +0200, Amir Goldstein wrote:
> > > On Thu, Jun 11, 2026 at 1:32 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Wed 10-06-26 17:40:27, Amir Goldstein wrote:
> > > > > On Wed, Jun 10, 2026 at 3:18 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > > > > On 2026/6/10 20:21, Jan Kara wrote:
> > > > > > > On Wed 10-06-26 16:17:33, Gao Xiang wrote:
> > > > > > >> Amir just suggested that I posted a long off-list discussion
> > > > > > >> on the list right now, but since it seems to relate to
> > > > > > >> `sb->s_writers.rw_sem` locking design, I am not quite sure
> > > > > > >> how deep I could help generally: But here it goes.
> > > > > > >>
> > > > > > >> The background is that we have discussed a generic deadlock
> > > > > > >> timing for several months as below:
> > > > > > >>
> > > > > > >> fsA is a filesystem which supports fsfreeze, such as EXT4/XFS/...
> > > > > > >>
> > > > > > >> fsB is a filesystem which have some relationship with a
> > > > > > >> userspace daemon (e.g. a filesystem with fanotify HSM hooks /
> > > > > > >>    fanotify + EROFS file-backed mounts / a FUSE filesystem or
> > > > > > >>    a filesystem backed by a virtual block device)
> > > > > > >>
> > > > > > >> Thread A                           Thread B                                 Userspace deamon
> > > > > > >>   write(fsA_fd, mmap(fsB_fd))
> > > > > > >>    file_start_write()
> > > > > > >>     (take SB_FREEZE_WRITE read lock)
> > > > > > >>
> > > > > > >>     handle fsB mmap fault read
> > > > > > >>      -> notify userspace and wait
> > > > > > >>
> > > > > > >>                                     freeze_super
> > > > > > >>                                     (try to take SB_FREEZE_WRITE write lock)
> > > > > > >>                                                                              received/handling fsB mmap read request
> > > > > > >>                                                                              (do random something...)
> > > > > > >>                                                                              write(fsA_fd2)
> > > > > > >>                                                                               (take SB_FREEZE_WRITE read lock)
> > > > > > >> The problem timing here is thread A does
> > > > > > >> `write(fsA_fd, mmap(fsB_fd))` => file_start_write() (rwsem read),
> > > > > > >> then hits page fault and wait for userspace deamon to finish
> > > > > > >> the request;
> > > > > > >>
> > > > > > >> Thread B does fsfreeze on fsA so it is waiting a write lock
> > > > > > >> (sb_wait_write(), rwsem write) and blocked on thread A;
> > > > > > >>
> > > > > > >> And the userspace deamon is a handler handling page fault,
> > > > > > >> and trying to write to another file (fsA_fd2) on fsA again
> > > > > > >> and blocked on thread B (file_start_write(), rwsem read).
> > > > > > >>
> > > > > > >> because of the specific locking timing is `R->W->R`, at least
> > > > > > >> the whole workflow won't proceed so the related processes
> > > > > > >> (and fsA above) will be stuck.
> > > > > > >
> > > > > > > Thanks a lot for the good summary! It has helped me to look at the problem
> > > > > > > from a bit different angle and I don't think it's actually specific to
> > > > > > > filesystem freezing or fanotify HSM. Consider the following simple setup:
> > > > > > >
> > > > > > > You have XFS filesystem fsA. On it you have a file imageA and you setup
> > > > > > > loop device loop0 over imageA and mount it as some filesystem fsB. Now you
> > > > > > > do write(imageA_fd, mmap(fsB_fd)) and you get a nice system deadlock (tried
> > > > > > > that and it really works :)). The problem is that write to imageA_fd
> > > > > > > acquires exclusively i_rwsem in imageA, then goes on to fault page on fsB
> > > > > > > which maps to a read from loop0 which maps to a read from imageA and
> > > > > > > xfs_file_read_iter() wants to acquire i_rwsem for imageA again.
> > > > > >
> > > > > > Ah, great catch, but mainly because XFS takes i_rwsem read lock
> > > > > > on read paths LOL.
> > > >
> > > > Well, yes, that makes things particularly easy to hit but e.g. with direct
> > > > IO much more filesystems (in particular everybody using iomap) than just XFS
> > > > are prone to similar issues.
> > > >
> > > > > > Yes, yet this deadlock sounds more like a fixed flow/pattern, which
> > > > > > is somewhat slightly different than fsfreeze issue since fanotify
> > > > > > needs racy between threads (causing RWR order casually and cause
> > > > > > Linux rwsem model deadlock) and may not need stacking filesystems.
> > > >
> > > > This example demostrates that the problem isn't specific to HSM or filesystem
> > > > freezing. Yes, filesystem freezing given its filesystem wide scope is
> > > > expanding the deadlock potential to more cases but the underlying problem
> > > > really is that if you manage to do a syscall that holds locks on filesystem
> > > > A and then ends up accessing filesystem B that's stacked on top of A, you
> > > > are violating the expected lock ordering and this can lead to deadlocks.
> > > >
> > > > > > > Also with the use of filesystem freezing on fsA, write to any target
> > > > > > > file (not only imageA) in fsA can create such deadlock if the page fault on
> > > > > > > the stacked filesystem ends up wanting to do some modification of imageA.
> > > > > > > So I don't think blocking IO to the loop device backing file will be even a
> > > > > > > complete fix.
> > > > > > >
> > > > > > > I think the underlying reason why that write(imageA_fd, mmap(fsB_fd))
> > > > > > > pattern causes issues is that it essentially creates a loop in the stacked
> > > > > > > filesystem graph which can cause all sorts of lock inversions compared to
> > > > > > > the natural order of taking locks for the stacked filesystems. So can we
> > > > > > > somehow forbid that? Or do we simply not care and if priviledged user does
> > > > > > > something stupid, he gets to reboot the machine? Any other ideas?
> > > > >
> > > > > Very unbacked idea, but something along the lines of:
> > > > >
> > > > > /*
> > > > >  * sb_{start,end}_write() scope an "sb write transaction"
> > > > >  */
> > > > >
> > > > > @@ -1283,6 +1283,8 @@ struct task_struct {
> > > > >         /* Journalling filesystem info: */
> > > > >         void                            *journal_info;
> > > > >
> > > > > +       /* Stacked filesystem write transactions: */
> > > > > +       struct super_block
> > > > > *sb_write_stack[SB_WRITE_MAX_STACK_DEPTH];
> > > > > +       int                                         sb_write_stack_depth;
> > > > > +
> > > > >         /* Stacked block device info: */
> > > > >         struct bio_list                 *bio_list;
> > > > >
> > > > > I don't know what a decent value of SB_WRITE_MAX_STACK_DEPTH
> > > > > would be but its not the same as FILESYSTEM_MAX_STACK_DEPTH,
> > > > > because loop/nbd/backing device also contributes to sb_write_stack_depth.
> > > >
> > > > I was thinking about something similar but then realized this won't fly -
> > > > the deadlock chain is often split among multiple processes. Even in the
> > > > case I've shown above there's the task doing the nasty write which holds
> > > > i_rwsem on imageA and then a workqueue thread that actually does the loopback
> > > > device IO which is trying to take it as well. No single process creates
> > > > a loop, only all of them together form the loop.
> > > 
> > > Yap. I was considering whether we could copy the sb_tx_stack to the kiocb..
> > > 
> > > >
> > > > > The rule is that sb_start_write(sb) pushes the sb to the tx stack
> > > > > after checking no loops in the stack.
> > > > >
> > > > > In the common non-stacked case, there are no checks so the push/pop
> > > > > should be quite cheap compared to the sb_writers locks.
> > > > >
> > > > > For the read side I hope that we do not need to track "read transactions"
> > > > > in the stack and that it is enough to check the write stack in page faults and
> > > > > stacked reads in loop/nbd/backing.
> > > >
> > > > That's another problem. Reads can create deadlocks as well. If you do
> > > > read(imageA_fd, mmap(fsB_fd)) in the setup I've outlined in my previous
> > > > email on XFS, you are holding i_rwsem for read for imageA and then doing a
> > > > write fault to fsB which translates to a read from imageA which needs
> > > > shared i_rwsem for imageA again. If you are lucky, this can pass but if
> > > > someone tries to acquire imageA's i_rwsem for write inbetween (and blocks),
> > > > your second shared i_rwsem acquisition will block and you have a deadlock.
> > > >
> > > 
> > > Yeh we could introduce sb_read(sb) scopes but that would be a bit nasty.
> > > The two-fds syscalls (e.g. sendfile()) makes this scoping even more challenging.
> > > 
> > > > > Note that the unscoped kiocb_start_write() in aio/uring will need to be
> > > > > extended so that the write transaction scope will cover the io submission
> > > > > to cover the page faults in input buffers.
> > > > >
> > > > > I have no idea about the feasibility of this and how much of the holes
> > > > > this actually closes but if looking at the narrow use case of pre-content
> > > > > events it might just be enough.
> > > >
> > > > What looks like the most feasible approach to me is to record in struct
> > > > task we are doing a read/write syscall for fsA
> > > 
> > > read/write_iter could be nested within stacked fs, so we really need a stack
> > > of transactions, but this one could be [FILESYSTEM_MAX_STACK_DEPTH]
> > > 
> > > > and in the page fault
> > > > handler once we have the VMA we can check that fsB isn't fsA's ancestor in
> > > > the "filesystem dependency graph". Making the check cheap enough should be
> > > > doable (we could for example do the loop check traversal only if the
> > > > stacking depth of fsB is higher than that of fsA, caching the stacking
> > > > depth in the superblock, which would deal with 99.99% cases) but maintaining
> > > > the dependency graph will take some work...
> > > 
> > > My crystal ball tells me we are probably not going to do that :-/
> > > But if we did, it would have been nice to validate that LOOP_CHANGE_FD
> > > does not set the backing file of loopA to a file on fsB ;)
> > 
> > LOOP_CHANGE_FD should be removed. I proposed that years ago because it's
> > problematic in other ways. Everyone agreed as it was effectively unused
> > I just never bothered pushing it through. So let's not worry about that
> > let's kill it instead. Here's the patch from 2023:
> > 
> > From 46db77d781d329b7fc7b3245dd295a69026f6ec0 Mon Sep 17 00:00:00 2001
> > From: Christian Brauner <brauner@kernel.org>
> > Date: Mon, 6 Nov 2023 16:29:32 +0100
> > Subject: [PATCH] loop: remove support for swapping loop fds
> > 
> > We did not find any users of LOOP_CHANGE_FD.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> I'm for trying this. Just maybe we could print a deprecation warning if
> LOOP_CHANGE_FD is used for a while before deleting it completely? To not
> outright break possible users if there are some by any chance?

Sure, works too. I think the use-cases for this should mostly be gone by
now though. If someone picks up my patch I'm happy to let it go.
