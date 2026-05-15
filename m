Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F553ED128;
	Fri, 15 May 2026 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880961; cv=none; b=DacdEWNm+1jsqtvJGyfodhDykuRbQdAM/+tGmeyc3XAlRP7b2w/2KXj6D3fi9nuoRGkisQY6G49hymllRZPKoLCxRK8JK2g16F+4lWduJbrnp+yYxzY8XrWendkxZzn3O59Fnop2JYXn/iVFppJdjaKbgQJRkxUNUvf19wiFSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880961; c=relaxed/simple;
	bh=5jR0EPpQbz/LEcayC4+RQ4S8xoN1bNi4Tu91p2fnpgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDzQpqUAvrZoPVrQ8bkdhu1QWFGNvEK56RbjDIJeAcvAKFDgy9o88Xap7LQvBnqnG/daB79esn1k1vytY0lXmDY+GIr3qotJLlAU9EjzciQUbqs2e/O3mZ19pUvqSU0mor67g4nMc76lXn17vrVWtIhTUAeAYRwcDxa/25EiOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7gZAs4b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7gZAs4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41A6C2BCB0;
	Fri, 15 May 2026 21:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778880960;
	bh=5jR0EPpQbz/LEcayC4+RQ4S8xoN1bNi4Tu91p2fnpgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7gZAs4bq952EgcjujXeAro9bCVVI+S8LRcJ+4Jtw+wFbDzsmZbibRMbvhpavj+QB
	 du2Eaog1wFNpmr+hN4yxLnD4OsAVo+Z/+S5JbYwstkk1qKocHTm2SX597bAts0VANt
	 MHNwWXsY3+NrQkOP82wxLad+xD7yPFVhHV02mQWaeodbK/wH1QK7WbFfQsuSnxeLan
	 PhLl497l0t3FfvfVz78Ei/Djyg9eko2dAcjYnrskfIaflt2eAz7nu2tQTuKYvuGHoT
	 MNqihmwMJNPqAvaqiuSfnTaxu94RoNt9qiSd/J+MPPtxFH//uOfzQ33wBUaUJTo/eb
	 dXmS2Kcq0LthQ==
Date: Fri, 15 May 2026 14:36:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev,
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH 1/9] fuse: enable caching of timestamps
Message-ID: <20260515213600.GE9568@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206510.4103309.7610933581068572895.stgit@frogsfrogsfrogs>
 <20260514220921.GI9544@frogsfrogsfrogs>
 <CAOQ4uxja1znK3pz3YAX2uFM-GFVS1zENHJzHBLAVrVqcz6bVhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxja1znK3pz3YAX2uFM-GFVS1zENHJzHBLAVrVqcz6bVhw@mail.gmail.com>

On Fri, May 15, 2026 at 10:33:34PM +0200, Amir Goldstein wrote:
> Sorry I was absent from iomap review for a while.
> Using these Codex replies as opportunity to get back to it..
> 
> On Fri, May 15, 2026 at 12:09 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Apr 29, 2026 at 07:33:20AM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Cache the timestamps in the kernel so that the kernel sends FUSE_SETATTR
> > > calls to the fuse server after writes, because the iomap infrastructure
> > > won't do that for us.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/dir.c        |    5 ++++-
> > >  fs/fuse/file.c       |   18 ++++++++++++------
> > >  fs/fuse/fuse_iomap.c |    6 ++++++
> > >  fs/fuse/inode.c      |   13 +++++++------
> > >  4 files changed, 29 insertions(+), 13 deletions(-)
> > >
> > >
> > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > index 3a76eea04c6425..11898102adefe2 100644
> > > --- a/fs/fuse/dir.c
> > > +++ b/fs/fuse/dir.c
> > > @@ -2265,7 +2265,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > >       struct fuse_attr_out outarg;
> > >       const bool is_iomap = fuse_inode_has_iomap(inode);
> > >       bool is_truncate = false;
> > > -     bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
> > > +     bool is_wb = (is_iomap || fc->writeback_cache) &&
> > > +                  S_ISREG(inode->i_mode);
> > >       loff_t oldsize;
> > >       int err;
> > >       bool trust_local_cmtime = is_wb;
> > > @@ -2405,6 +2406,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > >       spin_lock(&fi->lock);
> > >       /* the kernel maintains i_mtime locally */
> > >       if (trust_local_cmtime) {
> > > +             if ((attr->ia_valid & ATTR_ATIME) && is_iomap)
> > > +                     inode_set_atime_to_ts(inode, attr->ia_atime);
> > >               if (attr->ia_valid & ATTR_MTIME)
> > >                       inode_set_mtime_to_ts(inode, attr->ia_mtime);
> > >               if (attr->ia_valid & ATTR_CTIME)
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index fa67b20f5ad3ae..eecd0610fbd3e5 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -262,7 +262,7 @@ static int fuse_open(struct inode *inode, struct file *file)
> > >       int err;
> > >       const bool is_iomap = fuse_inode_has_iomap(inode);
> > >       bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
> > > -     bool is_wb_truncate = is_truncate && fc->writeback_cache;
> > > +     bool is_wb_truncate = is_truncate && (is_iomap || fc->writeback_cache);
> > >       bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
> > >
> > >       if (fuse_is_bad(inode))
> > > @@ -477,12 +477,14 @@ static int fuse_flush(struct file *file, fl_owner_t id)
> > >       struct fuse_file *ff = file->private_data;
> > >       struct fuse_flush_in inarg;
> > >       FUSE_ARGS(args);
> > > +     const bool is_iomap = fuse_inode_has_iomap(inode);
> > >       int err;
> > >
> > >       if (fuse_is_bad(inode))
> > >               return -EIO;
> > >
> > > -     if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
> > > +     if ((ff->open_flags & FOPEN_NOFLUSH) &&
> > > +         !fm->fc->writeback_cache && !is_iomap)
> > >               return 0;
> > >
> > >       err = write_inode_now(inode, 1);
> > > @@ -518,7 +520,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
> > >        * In memory i_blocks is not maintained by fuse, if writeback cache is
> > >        * enabled, i_blocks from cached attr may not be accurate.
> > >        */
> > > -     if (!err && fm->fc->writeback_cache)
> > > +     if (!err && (is_iomap || fm->fc->writeback_cache))
> > >               fuse_invalidate_attr_mask(inode, STATX_BLOCKS);
> > >       return err;
> > >  }
> > > @@ -820,8 +822,10 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
> > >        * If writeback_cache is enabled, a short read means there's a hole in
> > >        * the file.  Some data after the hole is in page cache, but has not
> > >        * reached the client fs yet.  So the hole is not present there.
> > > +      * If iomap is enabled, a short read means we hit EOF so there's
> > > +      * nothing to adjust.
> > >        */
> > > -     if (!fc->writeback_cache) {
> > > +     if (!fc->writeback_cache && !fuse_inode_has_iomap(inode)) {
> > >               loff_t pos = folio_pos(ap->folios[0]) + num_read;
> > >               fuse_read_update_size(inode, pos, attr_ver);
> > >       }
> > > @@ -870,6 +874,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > >                           unsigned int flags, struct iomap *iomap,
> > >                           struct iomap *srcmap)
> > >  {
> > > +     WARN_ON(fuse_inode_has_iomap(inode));
> > > +
> > >       iomap->type = IOMAP_MAPPED;
> > >       iomap->length = length;
> > >       iomap->offset = offset;
> > > @@ -2021,7 +2027,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
> > >        * Do this only if writeback_cache is not enabled.  If writeback_cache
> > >        * is enabled, we trust local ctime/mtime.
> > >        */
> > > -     if (!fc->writeback_cache)
> > > +     if (!fc->writeback_cache && !fuse_inode_has_iomap(inode))
> > >               fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
> 
> 
> It is so easy to get lost in the code handling attr cache coherency
> between kernel and server, so many little details (a.k.a maintenance
> nightmare). It's not great now, and becoming worse with iomap.
> 
> On top of existing writeback_cache special casing and now iomap
> more special casing, passthrough code also has special cases
> that may need to be handled better.
> 
> Can we maybe abstract some of these open coded checks in
> a way which is easier to review?

One way would be to decide that if the fuse server sets FUSE_CAP_IOMAP,
it doesn't get to use any of the other functionality -- no dax,
passthrough, writeback_cache, submounts, or anything like that.
Whatever the fuse server thinks is its dataset for inodes and the
directory tree, those are the *only* files you get to have.

The downside here is that fuse servers lose a lot of flexibility, since
(afaict) you can have a fuse filesystem with (say) a combination of
passthrough and writeback_cache files, and that's why (IMO) the codebase
is /really/ hard to understand.

Then we can simplify quite a lot of the special casing crap all over
fuse because I can create my own iomap-based file_operations.  For
example, ->open becomes:

static int fuse_iomap_open(struct inode *inode, struct file *file)
{
	struct fuse_mount *fm = get_fuse_mount(inode);
	bool is_truncate = (file->f_flags & O_TRUNC);
	int err;

	if (fuse_is_bad(inode))
		return -EIO;

	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
	if (fuse_inode_has_atomic(inode))
		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;

	err = generic_file_open(inode, file);
	if (err)
		return err;

	inode_lock(inode);
	filemap_invalidate_lock(inode->i_mapping);
	err = fuse_dax_break_layouts(inode, 0, -1);
	if (err)
		goto out_inode_unlock;

	err = fuse_do_open(fm, get_node_id(inode), file, false);
	if (err)
		goto out_mmaplock;

	fuse_iomap_finish_open(ff, inode);

	if (is_truncate)
		fuse_truncate_update_attr(inode, file);
		truncate_pagecache(inode, 0);
		fuse_iomap_open_truncate(inode);
	}

out_mmaplock:
	filemap_invalidate_unlock(inode->i_mapping);
out_inode_unlock:
	inode_unlock(inode);
	return err;
}

Obviously there are a lot of fuse features that I'd just turn on
automatically if the fuse server sends FUSE_CAP_IOMAP (like atomic
truncate on open mode and killpriv) to eliminate even more special
casing.

Another source of simplification would be to make iomap/exclusive mode
more aggressive.  In that mode, the kernel uses all its file attribute
update logic and pushes changes down to the fuse server.  All the attr
caching and timeout stuff goes away, becauase local filesystems are not
cluster/network filesystems and don't have to worry about pushing
changes up to the kernel.

OTOH at this point I've forked fuse.  But if I'm going to do that, I
might as well just burn the whole thing down and start over.  I don't
yet have a good vision for how to handle the slow stuff like the
directory tree.

> Thinking about some attr_mask in the inode which determines for
> every attribute, who owns the authoritative copy, server or kernel.
> For example, for (writeback_cache || iomap)  kernel owns ATTR_MTIME.

For iomap/exclusive mode, the kernel should own all attributes.  I'm not
sure the current codebase actually *does* that though.

> This is very hand wavy and far from dealing with all the complexity
> in every specific case, but the bottom line is - very hard to review that
> this is all correct and nothing missing and very hard to figure out
> what's going on when looking at the code
> for humans I mean... Codex seems to be doing well ;)

Not really, it's been hallucinating from the start.  That's why half the
comments are credited to codex, and the other half are the WTFs I found
while scouring the codebase whilst trying to understand what nonsense it
was telling me.

--D
