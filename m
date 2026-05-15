Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEBC405C21;
	Fri, 15 May 2026 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881938; cv=none; b=GxFehDatlOdyS8kKdPHFA9SZTWDpqA6op1Y64kbRmJYmjhsvdsyAYwLDPsmFHs7L0Acowaxnbffge0uu8afvZTVndzoYN0EbLurR1d6uJcu7OPDQ6PYQnOqsDtrO8ddpO7NLut8nGtYvy+KVJILanRgHaaJbtG9YJg3CLYcxgnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881938; c=relaxed/simple;
	bh=jxvIskEuhqz66+mwSZu9oyckRryPxQYUN84Thr7orFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdZ5t8tjNsDW0dFG6RbN9Mrgp2Qf1s9K4W6Imu+HJN6g2Hd3CS7oxj/RHWkpfA2T+6o3EgIPmnA6/pWUaD4pZVYp7ggKvWTLLhwDGBAE6kO5DcfikjuRHWSjDIXdSlztx4I/GGxPciwWR24iaTh5X0xXEWv4F+l7We4Xnzyrke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7uRLx+u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7uRLx+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC3DC2BCB0;
	Fri, 15 May 2026 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778881937;
	bh=jxvIskEuhqz66+mwSZu9oyckRryPxQYUN84Thr7orFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7uRLx+u+6e+zy/6HqRK1foytnMNOhtQ068Kmf7yyFNftjQhA1WrLI8EHTdfNSAQB
	 mB2Z48lOfhnGGLjVy7I0sZJI1dofC5eHOUzF08n4v7zETXS0TlJQRM9HIL7t7ab0Hb
	 nRiPAxnHNe4N3vwXdtFCtoNkk3lQMyo/zGCXFibMVf89PJNwSe7le2Z6X+oiKBMMg6
	 igxBVyfsMhj0IvlfC3GTOxXCXeyBde24Kz1HaWi+1jSYFYEbHCGOK0uOVnG5+NePmb
	 O1LS9OanZDLBjMqnJ7/Va77A6nFq6tCH9hDKnkvTCflICyi40AyI4QuwicxhNJ8RV7
	 QAIU57DLuoROg==
Date: Fri, 15 May 2026 14:52:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev,
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH 6/9] fuse: let the kernel handle KILL_SUID/KILL_SGID for
 iomap filesystems
Message-ID: <20260515215217.GG9568@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206617.4103309.9491664333731079107.stgit@frogsfrogsfrogs>
 <20260514221847.GL9544@frogsfrogsfrogs>
 <CAOQ4uxgU7Gsqd3H7v=izpm8Wbjrc7Qzv_BHzB8WQNpg=X4oMvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgU7Gsqd3H7v=izpm8Wbjrc7Qzv_BHzB8WQNpg=X4oMvQ@mail.gmail.com>

On Fri, May 15, 2026 at 11:43:23PM +0200, Amir Goldstein wrote:
> On Fri, May 15, 2026 at 12:18 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Apr 29, 2026 at 07:34:38AM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Let the kernel handle killing the suid/sgid bits because the
> > > write/falloc/truncate/chown code already does this, and we don't have to
> > > worry about external modifications that are only visible to the fuse
> > > server (i.e. we're not a cluster fs).
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/dir.c |   11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > >
> > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > index 61015e83888ee4..e664a60200ee26 100644
> > > --- a/fs/fuse/dir.c
> > > +++ b/fs/fuse/dir.c
> > > @@ -2477,6 +2477,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
> > >       struct inode *inode = d_inode(entry);
> > >       struct fuse_conn *fc = get_fuse_conn(inode);
> > >       struct file *file = (attr->ia_valid & ATTR_FILE) ? attr->ia_file : NULL;
> > > +     const bool is_iomap = fuse_inode_has_iomap(inode);
> > >       int ret;
> > >
> > >       if (fuse_is_bad(inode))
> > > @@ -2485,15 +2486,19 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
> > >       if (!fuse_allow_current_process(get_fuse_conn(inode)))
> > >               return -EACCES;
> > >
> > > -     if (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID)) {
> > > +     if (!is_iomap &&
> > > +         (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
> > >               attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |
> > >                                   ATTR_MODE);
> > >
> > >               /*
> > >                * The only sane way to reliably kill suid/sgid is to do it in
> > > -              * the userspace filesystem
> > > +              * the userspace filesystem if this isn't an iomap file.  For
> > > +              * iomap filesystems we let the kernel kill the setuid/setgid
> > > +              * bits.
> > >                *
> > > -              * This should be done on write(), truncate() and chown().
> > > +              * This should be done on write(), truncate(), chown(), and
> > > +              * fallocate().
> >
> > FWIW Codex noticed that in iomap mode we still send FATTR_KILL_SUIDGID
> > even though we claim the kernel is supposedly handling the mode
> > stripping for us.  Granted I've been starting to suspect that some of
> > these file attribute related things ought to be gated on exclusive mode
> > and not iomap mode.  Will have to do a comprehensive review when I get
> > through the current round of bot complaints.
> 
> As I told Joanne in PASSTHROUGH_INO review
> https://lore.kernel.org/fuse-devel/CAOQ4uxipQJt5zskb_THxueGi_MXpFdywFiGpd_nmWeY_sMHwzQ@mail.gmail.com/
> 
> Why do we need to deal with these special cases at all?
> 
> I understand that you want iomap to be per inode and that
> both you and Miklos are in favor of allowing mixing iomap and passthrough
> and other inode iomodes on the same filesystem, that's fine.

You misunderstand me -- I'm not that enthusiastic about mixing.  I just
don't want to trade away flexibility if it's important to someone.  OTOH
the silence about that particular topic convinces me nobody will really
care.

> But we also made a note that the iomap patch set is very big and we would
> all benefit if we could start with a slightly leaner patch set.
> 
> Mixing on the same filesystem, iomap inodes where kernel handles
> killpriv and regular inodes where server handles killpriv seems like
> too much freedom to me.
> 
> The moment that filesystem opts-in for IOMAP, can we say that
> the rest of the inodes are at least "local-only" (no remote changes
> of those other inodes)? so server should not be able to have both
> iomap and handle_killpriv enabled.
> 
> If IOMAP is going to be merged via the FUSEX protocol, this is one
> of the FUSEX requirements anyway.

I'm 100% onboard with "you can have *one* type of file IO path per fuse
connection".

--D
