Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB73D88E6;
	Tue, 24 Mar 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342301; cv=none; b=TYepLdcR275+YVLVeKVCUV9Z6YYSGrTtL6il+auAijtZWzFTFwP0puaNBg4yjDp+oB1muzKCHdvgwm0Bc/JaWSbOtaAwOQ2OJDe3Tlee1JndKYvD39R8mZxVbkXI8x0cgmBMBPZka834W9PEjr6nXuju2/kNXVeEd42+x/IjAy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342301; c=relaxed/simple;
	bh=MCVEK7Uy7kSgqvx88xO+6jxwJM48WzBfVnlulZ4Y5GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2KMn/Ce2+7f1yHJ6LH2VNvhyy6YeMFWdm4kMbA/SI0VVd+hPD7lk4KKakroZvoNMa5iViQcF9iNtqtpFUGIDngrj2QzXrEcRtlUPhVcxCzyZ0ULdmn1j9Pe8XT2B4kfL3ibTSYOBE8ipXBfj6RE1GGrH6sQkHccYfQdVyIX6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5pA00vr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5pA00vr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F86DC19424;
	Tue, 24 Mar 2026 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774342300;
	bh=MCVEK7Uy7kSgqvx88xO+6jxwJM48WzBfVnlulZ4Y5GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5pA00vrKH1i6oryi7GAHi0gW0eV3NAk1n5gRsgixc4E3kw8aGUwWWIbqmVnYwNl0
	 yqCHvkeu3cdvhJq18BCkmneulFmq4n6EXIWcs/cbp5jVyJ4bn8TLp0S+q59CYf79+5
	 1bxhjAn/+flkbvLD68WAZEa4/P4dm+2tD/ZyMTtZ3xX1P/cdqeu+GenYrQT7lTcSQk
	 XeXzwmRii7IENAyPcRcxW9Lhgj41Lhj4eL82nwKun6N7FbEaa1Hxe1SmEYRrRzdt3t
	 MhSD9/P4q7qSwDwLb6AjALk7kJN3MEB9ynRSLHCYjVK07IyZkBc8/mueVACtsf2EZp
	 za3qldnDkMDOw==
Date: Tue, 24 Mar 2026 09:51:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, jack@suse.cz, 
	shuah@kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	dmatlack@google.com, pratyush@kernel.org, skhawaja@google.com
Subject: Re: [PATCH 1/2] liveupdate: prevent double management of files
Message-ID: <20260324-langzeitfolgen-altgedienten-ccef17d19349@brauner>
References: <20260321175808.57942-1-pasha.tatashin@soleen.com>
 <20260321175808.57942-2-pasha.tatashin@soleen.com>
 <CA+CK2bD2aNu-NByET4KkBP0n2j8WQE2zjxb4g-1cv2hYfjaRZQ@mail.gmail.com>
 <20260323-leibhaftig-blasinstrument-58ec408b3c40@brauner>
 <CA+CK2bC6S7pFCYR0XS1ZPxw9HKjWgxy=0DkszYNjMUi735o_1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bC6S7pFCYR0XS1ZPxw9HKjWgxy=0DkszYNjMUi735o_1Q@mail.gmail.com>

On Mon, Mar 23, 2026 at 09:18:03AM -0400, Pasha Tatashin wrote:
> On Mon, Mar 23, 2026 at 7:55 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sat, Mar 21, 2026 at 09:04:53PM -0400, Pasha Tatashin wrote:
> > > On Sat, Mar 21, 2026 at 1:58 PM Pasha Tatashin
> > > <pasha.tatashin@soleen.com> wrote:
> > > >
> > > > Currently, LUO does not prevent the same file from being managed twice
> > > > across different active sessions.
> > > >
> > > > Add a new i_state flag I_LUO_MANAGED and update luo_preserve_file()
> > > > to check and set this flag when a file is preserved, and clear it in
> > > > luo_file_unpreserve_files() when it is released.
> > > >
> > > > Additionally, set this flag in luo_retrieve_file() after a file is
> > > > successfully restored in the new kernel, and clear it in
> > > > luo_file_finish() when the LUO session is finalized.
> > > >
> > > > This ensures that the same file (inode) cannot be managed by multiple
> > > > sessions. If another session attempts to preserve an already managed
> > > > file, it will now fail with -EBUSY.
> > > >
> > > > Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> > > > Acked-by: Jan Kara <jack@suse.cz>
> > > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > > ---
> > > >  include/linux/fs.h           |  5 ++++-
> > > >  kernel/liveupdate/luo_file.c | 27 ++++++++++++++++++++++++---
> > > >  2 files changed, 28 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index 23f36a2613a3..692a8be56f3c 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -712,6 +712,8 @@ is_uncached_acl(struct posix_acl *acl)
> > > >   * I_LRU_ISOLATING     Inode is pinned being isolated from LRU without holding
> > > >   *                     i_count.
> > > >   *
> > > > + * I_LUO_MANAGED       Inode is being managed by a live update session.
> > > > + *
> > > >   * Q: What is the difference between I_WILL_FREE and I_FREEING?
> > > >   *
> > > >   * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
> > > > @@ -744,7 +746,8 @@ enum inode_state_flags_enum {
> > > >         I_CREATING              = (1U << 15),
> > > >         I_DONTCACHE             = (1U << 16),
> > > >         I_SYNC_QUEUED           = (1U << 17),
> > > > -       I_PINNING_NETFS_WB      = (1U << 18)
> > > > +       I_PINNING_NETFS_WB      = (1U << 18),
> > > > +       I_LUO_MANAGED           = (1U << 19),
> > > >  };
> > > >
> > > >  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> > > > diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> > > > index 5acee4174bf0..86911beeff71 100644
> > > > --- a/kernel/liveupdate/luo_file.c
> > > > +++ b/kernel/liveupdate/luo_file.c
> > > > @@ -248,6 +248,7 @@ static bool luo_token_is_used(struct luo_file_set *file_set, u64 token)
> > > >   * Context: Can be called from an ioctl handler during normal system operation.
> > > >   * Return: 0 on success. Returns a negative errno on failure:
> > > >   *         -EEXIST if the token is already used.
> > > > + *         -EBUSY if the file descriptor is already preserved by another session.
> > > >   *         -EBADF if the file descriptor is invalid.
> > > >   *         -ENOSPC if the file_set is full.
> > > >   *         -ENOENT if no compatible handler is found.
> > > > @@ -276,6 +277,14 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
> > > >         if (err)
> > > >                 goto  err_fput;
> > > >
> > > > +       scoped_guard(spinlock, &file_inode(file)->i_lock) {
> > > > +               if (inode_state_read(file_inode(file)) & I_LUO_MANAGED) {
> > > > +                       err = -EBUSY;
> > > > +                       goto err_free_files_mem;
> > > > +               }
> > > > +               inode_state_set(file_inode(file), I_LUO_MANAGED);
> > > > +       }
> > > > +
> > > >         err = -ENOENT;
> > > >         list_private_for_each_entry(fh, &luo_file_handler_list, list) {
> > > >                 if (fh->ops->can_preserve(fh, file)) {
> > > > @@ -286,11 +295,11 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
> > > >
> > > >         /* err is still -ENOENT if no handler was found */
> > > >         if (err)
> > > > -               goto err_free_files_mem;
> > > > +               goto err_unpreserve_inode;
> > > >
> > > >         err = luo_flb_file_preserve(fh);
> > > >         if (err)
> > > > -               goto err_free_files_mem;
> > > > +               goto err_unpreserve_inode;
> > > >
> > > >         luo_file = kzalloc_obj(*luo_file);
> > > >         if (!luo_file) {
> > > > @@ -320,6 +329,9 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
> > > >         kfree(luo_file);
> > > >  err_flb_unpreserve:
> > > >         luo_flb_file_unpreserve(fh);
> > > > +err_unpreserve_inode:
> > > > +       scoped_guard(spinlock, &file_inode(file)->i_lock)
> > > > +               inode_state_clear(file_inode(file), I_LUO_MANAGED);
> > > >  err_free_files_mem:
> > > >         luo_free_files_mem(file_set);
> > > >  err_fput:
> > > > @@ -363,6 +375,9 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
> > > >                 luo_file->fh->ops->unpreserve(&args);
> > > >                 luo_flb_file_unpreserve(luo_file->fh);
> > > >
> > > > +               scoped_guard(spinlock, &file_inode(luo_file->file)->i_lock)
> > > > +                       inode_state_clear(file_inode(luo_file->file), I_LUO_MANAGED);
> > > > +
> > > >                 list_del(&luo_file->list);
> > > >                 file_set->count--;
> > > >
> > > > @@ -609,6 +624,9 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
> > > >         *filep = luo_file->file;
> > > >         luo_file->retrieve_status = 1;
> > > >
> > > > +       scoped_guard(spinlock, &file_inode(luo_file->file)->i_lock)
> > > > +               inode_state_set(file_inode(luo_file->file), I_LUO_MANAGED);
> > > > +
> > > >         return 0;
> > > >  }
> > > >
> > > > @@ -701,8 +719,11 @@ int luo_file_finish(struct luo_file_set *file_set)
> > > >
> > > >                 luo_file_finish_one(file_set, luo_file);
> > > >
> > > > -               if (luo_file->file)
> > > > +               if (luo_file->file) {
> > > > +                       scoped_guard(spinlock, &file_inode(luo_file->file)->i_lock)
> > > > +                               inode_state_clear(file_inode(luo_file->file), I_LUO_MANAGED);
> > > >                         fput(luo_file->file);
> > > > +               }
> > > >                 list_del(&luo_file->list);
> > > >                 file_set->count--;
> > > >                 mutex_destroy(&luo_file->mutex);
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > > Sashiko: https://sashiko.dev/#/patchset/20260321175808.57942-1-pasha.tatashin@soleen.com
> > >
> > > Sashiko reported two problems:
> > >
> > > 1. Are there any issues with mixing goto-based error handling and scope-based
> > > cleanups like scoped_guard() in the same function?
> > >
> > > Initially, I thought that there should not be any problems, however,
> > > after looking this up  I found in include/linux/cleanup.h the
> > > following comment:
> > >
> > >  * Lastly, given that the benefit of cleanup helpers is removal of
> > >  * "goto", and that the "goto" statement can jump between scopes, the
> > >  * expectation is that usage of "goto" and cleanup helpers is never
> > >  * mixed in the same function.
> >
> > There's a compile-time switch you might want to turn on when
> > test-compiling code like this. I forget exactly what it is. Something
> > like jump-over-uninit or something.
> >
> > >
> > > Well, good to know, will not use goto inside scoped_guards.
> > >
> > > 2. Additionally, does setting I_LUO_MANAGED on the inode break the preservation
> > > of anonymous inodes? Many file types (like eventfd, epoll, timerfd,
> > > signalfd)
> > >
> > > This is actually a very good point. It looks like everyone who uses
> > > anon_inode_getfd() has one shared inode. This is not a problem for the
> > > existing LUO user memfd, or for the upcoming vfiofd and memfd, but
> > > kvm-vmfd and kvm-cpufd also use it, and that might be a problem in the
> > > future once we add support for Orphaned VMs.
> > >
> > > Therefore, we have two choices: either use a hash table, which adds
> > > performance and memory overhead, or delegate this double-check to the
> > > LUO file handlers, as they can use a private context to know if the FD
> > > is already preserved.
> >
> > So, I'm not happy about I_LUO_MANAGED. I don't think we need driver
> > specific stuff in struct inode and not in i_state. Track this in the
> > driver please. I don't want this precedent and I'd rather have you get
> 
> I am planning to use an xarray in the next version.
> 
> > used to implementing such things in the driver right away rather than
> > offloading this on general infrastructure. If we let this slide struct
> > inode will be 2MB 1 in year.
> 
> Claiming that a single flag bit precedent would cause the overall
> struct to grow by 2MB in a year is a slight exaggeration. :-)

Hm, you say that. But then you don't get ~5-10 patches a year that "just
add a new member into struct inode with 4-8 bytes"... I'm just making an
exaggerated point ofc. :)

But struct inode is used everywhere and I want it contained and small
and whatever lands in it - even flags - better be VFS generic stuff.

We sometimes do carve out exceptions for _filesystem drivers_ where no
other way is possible ofc. But I don't think this should extend to
drivers/.
