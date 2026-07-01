Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1D37186F;
	Wed,  1 Jul 2026 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928837; cv=none; b=ienuhSG5nfOixA5KQ7BypowCmUZZ0zCIV3h/3tkUHAQkcfLTSiGqQAYQMlrIwrEZoLMw/EGzKjyP2W9syQ8O5GB0eOf2fMyxonzot7j1YrQCl+qjpqEqPvUK6dSTahIC6I2EWVqddXbqdmwupGgjZSnj7aUGyRUvxybL02Fn/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928837; c=relaxed/simple;
	bh=T+ZeMDdQstt14YXQihJiZSCH+wvykfRe5gQOSa+Iugc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix3zwsYE1xGSzhN3pUsR42YDg0ne1DKkWRM7n9KP17p/GHMvX5GUmkVFlHU47kPvvg+VIOpKUOL6Sm05cmY2HeTIt9mNAObC6qKE4c9HAsWt4C7r/0IN1gmhhHOI26IKSRIEf87R2QUbk/pF6++aIExwMLFeEMTPFOdYvgI3dwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oADoV7su; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oADoV7su"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E28981F000E9;
	Wed,  1 Jul 2026 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782928836;
	bh=eRqiZY2ScRUCJ4VpnIrR57NXCBViTODVv97Vt+oRZ1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oADoV7su119m2azC1HyD+1j6VVf1aNDzarLOCRxmH8U3KZAWaGuAiUYaNzXoZLyQ5
	 Dzbjs6jQF0YHprhx3QUze4/ngyGg/T9V/QoUkQYBO08G4N+60+JJzyR6EmpPN1y7uS
	 ELhNklQN5WxyiUWMEVicmyZuhcN8IVFrPkbVt+EpalMNs+LSmjQDYaTph41AaTgv6X
	 4XyjCozgj+d1Qnuw/bqEJM3kB/UU9CctQ/MC+PfColOhiCerds24d4wYAwMTEVzFEv
	 SpNXyGflTKowuSB6qA1VA5jNwC4RNuBtoJ6xqcg/F6ArJcc081e34lt88Q2CyOdnvp
	 Scl5G5L9Of5Mw==
Date: Wed, 1 Jul 2026 11:00:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeremy Bingham <jbingham@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz,
	hch@infradead.org, viro@zeniv.linux.org.uk,
	syzkaller@googlegroups.com
Subject: Re: [PATCH v2 0/4] minix: convert to iomap and add direct I/O
Message-ID: <20260701180035.GA6507@frogsfrogsfrogs>
References: <cover.1782619718.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1782619718.git.jbingham@gmail.com>

On Sat, Jun 27, 2026 at 10:15:52PM -0700, Jeremy Bingham wrote:
> This is v2 of the minix iomap conversion series. The original v1
> submission (3 patches) was tested by syzbot, which found four issues.
> Three were straightforward; the fourth, a null pointer dereference in
> page_symlink when creating symlinks, required more substantial changes.
> 
> The original description follows:
> 
> This series converts the minix filesystem from the buffer_head-based
> I/O path to the iomap API, and adds direct I/O support in the process.
> 
> The conversion is straightforward: minix's indirect block tree mapping
> logic (from itree_common.c) is reworked into an iomap_begin/iomap_end
> implementation. The iomap_end callback is a no-op since minix has no
> extents or transactions to finalize.
> 
> Patch 1 adds the iomap infrastructure: the new iomap.c file, wrapper
> functions and iomap_ops structs in itree_v1.c and itree_v2.c, and the
> relevant declarations in minix.h.
> 
> The iomap.c file is #include'd into itree_v1.c and itree_v2.c rather
> than compiled as a standalone translation unit. This is because the
> minix filesystem versions (V1 vs V2/V3) have different block_t sizes
> (16-bit vs 32-bit) and different indirect tree depths. This follows
> the existing pattern in minix where itree_common.c is included into
> both itree_v1.c and itree_v2.c. Each version provides a thin wrapper
> and a corresponding iomap_ops struct.

Yuck.  I guess that's /one/ way to avoid having a geometry struct
capturing those details... :(

> Patch 2 converts the regular file address space operations to iomap:
> read_folio, readahead, writepages (with a writeback callback), bmap,
> and folio lifecycle helpers. Directory inodes continue to use
> buffer_head-based operations via a new minix_dir_aops, since directory
> handling still relies on buffer head chunks for prepare/write_begin.
> 
> Patch 3 converts the file_operations: replacing the generic read/write
> iterators with iomap-aware versions, adding direct I/O read/write paths
> using iomap_dio_rw, and setting FMODE_CAN_ODIRECT in the open handler.
> 
> The minix iomap implementation was adapted from the out-of-tree xiafs
> iomap conversion. The xiafs module itself borrowed heavily from the
> modernized minix kernel module. The exfat iomap changes were an
> additional reference for both conversions.
> 
> Changes since v1:
> 
>   * Added a fourth patch to fix the symlink and truncate issues:
>     - Replaced page_symlink with a custom __page_symlink that writes
>       the target directly to a data block via minix_new_block +

Sounds to me like it's time to write iomap_write_symlink.

int
iomap_symlink_write(struct inode *inode, const char *target, int len,
		const struct iomap_ops *ops,
		const struct iomap_write_ops *write_ops, void *private)
{
	struct kvec vec = {
		.iov_base	= target,
		.iov_len	= len,
	};
	struct iomap_iter iter = {
		.inode		= inode,
		.pos		= 0,
		.len		= len,
		.flags		= IOMAP_WRITE,
		.private	= private,
	};
	struct iov_iter iov;
	int ret;

	iov_iter_kvec(&iov, ITER_SRC, &vec, 1, iov.iov_len);

	while ((ret = iomap_iter(&iter, ops)) > 0)
		iter.status = iomap_write_iter(&iter, &iov, write_ops);

	if (unlikely(iter.pos == 0))
		return ret;

	mark_inode_dirty(inode);
	return 0;
}
EXPORT_SYMBOL_GPL(iomap_symlink_write);


>       sb_getblk, bypassing the aops write path (which no longer has
>       write_begin/write_end). Added a matching custom minix_get_link
>       that reads the target from the data block via sb_bread, similar
>       to ext4_get_link. No iomap-based filesystem in the kernel uses
>       page_symlink; XFS, GFS2, and ext4 all handle symlink storage

That's because they embed headers and crcs in the symlink file data
and/or do fancy things with inline targets.  xfs has its own buffer
cache, so there's no need to duplicate it with the pagecache and then
have to interpret ondisk formats.

>       directly. The on-disk format is unchanged.
>     - Fixed a buffer_head/iomap type confusion in truncate:
>       block_truncate_page attaches buffer_heads to data folios, but
>       minix_aops now uses iomap which interprets folio->private as
>       struct iomap_folio_state. truncate() now dispatches between
>       iomap_truncate_page (for regular files/symlinks) and
>       block_truncate_page (for directories) based on the inode's aops.
>     - Added .setattr = minix_setattr to minix_symlink_inode_operations
>       so symlinks truncate properly through the iomap path.
> 
>   * Patch 1 (iomap infrastructure): minix_get_block is now exported
>     (non-static) so the directory aops and iomap writeback path can
>     use it. Added minix_iomap_ops_ver() inline helper and extern
>     declarations for minix_aops and the version-specific iomap_ops.
>     Fixed unsigned -> unsigned int in minix_blocks_needed and
>     minix_find_first_zero_bit to silence checkpatch warnings.
> 
>   * Patch 2 (aops conversion): unchanged in approach; minor cleanup
>     of the writeback callback and minix_bmap conversion.
> 
>   * Patch 3 (file operations): minix_setattr is now exported for reuse
>     by the symlink inode operations in patch 4.
> 
> Testing: the full series has been tested with mkfs.minix V1/V2/V3,
> exercising file creation, read/write, overwrite, append, binary data,
> directories, symlinks (full path, relative, directory symlinks), hard
> links, truncation (shrink/grow), large files (1MB, exercising indirect
> blocks), deep nesting (20 levels), 100 files in one directory,
> deletions, remount persistence, and fsck.minix. All pass cleanly. The
> four syzbot-reported issues are resolved.
> 
> Jeremy Bingham (4):
>   minix: add iomap infrastructure
>   minix: convert address space operations to iomap
>   minix: convert file operations to iomap and add direct I/O
>   minix: fix symlilnk and truncate for iomap compatibility
> 
>  fs/minix/file.c         | 157 ++++++++++++++++++++++++++++++++++++++--
>  fs/minix/inode.c        |  90 ++++++++++++++++++++---
>  fs/minix/iomap.c        | 114 +++++++++++++++++++++++++++++
>  fs/minix/itree_common.c |  11 ++-
>  fs/minix/itree_v1.c     |  25 ++++++-
>  fs/minix/itree_v2.c     |  17 ++++-
>  fs/minix/minix.h        |  30 +++++++-
>  fs/minix/namei.c        | 137 ++++++++++++++++++++++++++++++++++-
>  8 files changed, 558 insertions(+), 23 deletions(-)
>  create mode 100644 fs/minix/iomap.c
> 
> -- 
> 2.47.3
> 
> 
