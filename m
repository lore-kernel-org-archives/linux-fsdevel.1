Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D447042C;
	Fri, 14 Aug 2026 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713314; cv=none; b=NZiHxPMHlA6lvO6c8KlaIazNWbwDlJJHiL+omvKalCkgG+MaYd2mvfFkMutSiCZDrJKvwBjExu/MVR6kU5ldMZuZqIDSJ2UbNLxFuuUkAvMW2FR4Emql3KggTAy+CSi4JWJrnWrt/bQGu0wHQyHIwJHiTGAQI0yoZItTS/evqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713314; c=relaxed/simple;
	bh=osqLKK9SExQ3HnievCPWyw+Pk5B7ser0cKsPhWCelG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzWYBl1gyPWcSdthYiWxTpHKuLa7te0uFpA+WvdLVMmCjrgtn0YTiP3Otb5F9v6YF5JmsFFzKhYobI5/sDMcYeO1cyxVT0OB3vyJEWEAJ5wekFK+OgOoGnaL9dBdQSTYRi7tnIHcHKho+Ir5sn8ah5zfqOPURviwMCLSVpPYaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVZMxmiX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVZMxmiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B821F000E9;
	Fri, 14 Aug 2026 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713312;
	bh=7noRXPPNKyNXWdWzzOBT2JyMctWg9ksO3JHrU1R6GJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVZMxmiXoosSveKqQQlKJHXN2wgztKTSAgaeSfAoukVGHUGQukP5mQBMVOgqurFdq
	 GVhr4j3EZ7zu6IBdSbCnb/DIcq49ydq7ISGBucMQwrPN90jB8m6+atoqzFz0IWgNYz
	 M4yX80yduni1hT71dNKg2XOdc20lKf+nNDP42I74DMA3MXUlRGTCPJVQ6WIXFX9OkA
	 TgjkktT5c2/jfvv+BgBbW6RU+8rU2SOf4jtzr6X5F6IKM67Ful9yi8kohd3sQOE5we
	 ctJUadC4JYxd+0CVbKL1fQMejzb6Udh66PhJIVJTxiBdzyKiH3yp2NGAc3I0NCrz1N
	 +tH27F6smVSgA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 18/18 for v7.3] vfs sync
Date: Fri, 14 Aug 2026 15:15:02 +0200
Message-ID: <20260814-vfs-7.3-rc1.sync-55166eaa0000@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7380; i=brauner@kernel.org; h=from:subject:message-id; bh=osqLKK9SExQ3HnievCPWyw+Pk5B7ser0cKsPhWCelG8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi9y2W8eW/qhDes9sz9unPXQ0FFK/WjdqravofXyr/ ltj5JWvHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5ncrI8KPEc92kIou+xxGm 3PvZb74UkXBXvOvCwRrwTF9lZ3jWEUaGbd1enMl/nLSEdwQs68qfxHjphvd+7pmTjij+L9nydIE oPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This makes sync_inode_metadata() and writeback_single_inode() persist
not only the inode but all metadata associated with it.

A new .sync_inode_metadata superblock operation is called from
__writeback_single_inode(). Alongside it a new I_METADATA_WRITEBACK
state flag is added.

Filesystems no longer need their own mmb_fsync() implementations and can
just use simple_fsync(). All metadata is now written for IS_SYNC and
IS_DIRSYNC inodes. Races where several fsyncs raced and mmb_sync() could
return before all buffers were really persisted are fixed since I_SYNC
now serializes properly.

The I_METADATA_WRITEBACK scheme also fixes the case where a
WB_SYNC_NONE writeback landing between write(2) and fsync(2) left
fsync(2) failing to persist the inode. That problem is not specific to
filesystems using the generic metadata bh tracking, and the ones that
do not are left alone.

ext2, udf, bfs, minix, fat and ext4 in nojournal mode have their data
integrity writeout fixed and are converted. affs drops metadata bh
tracking and mmb_fsync() is removed.

A few other fixes came out of this:

- a UAF in mark_buffer_write_io_error()

- missed inode writeback when racing with __writeback_single_inode()

- ext4 allocating the mapping_metadata_bhs struct on demand

- three fat fixes: a lost inode update in do_msdos_rename() with
  DIRSYNC, inode buffer write errors not propagating out of
  fat_sync_inode_metadata() and directory entries not being persisted on
  fsync(2) of the root directory.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

[1]: https://lore.kernel.org/linux-next/ams9K7q5NMj9ifmm@sirena.org.uk

This conflicts with the ext3 tree in fs/ext2/xattr.c between commit
6abf69e2e7f91 ("ext2: Simplify error handling of IO error when adding
xattr") from the ext3 tree and commit 356984d1a5c32 ("ext2: Fix lost
inode updates for IS_SYNC inodes") from this tree:

diff --cc fs/ext2/xattr.c
index 5f49ec4afc36f,be63f89402a38..0000000000000
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@@ -777,16 -777,20 +777,16 @@@ ext2_xattr_set2(struct inode *inode, st
  	/* Update the inode. */
  	EXT2_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
  	inode_set_ctime_current(inode);
+ 	mark_inode_dirty(inode);
  	if (IS_SYNC(inode)) {
  		error = sync_inode_metadata(inode, 1);
 -		/* In case sync failed due to ENOSPC the inode was actually
 -		 * written (only some dirty data were not) so we just proceed
 -		 * as if nothing happened and cleanup the unused block */
 -		if (error && error != -ENOSPC) {
 -			if (new_bh && new_bh != old_bh) {
 -				dquot_free_block_nodirty(inode, 1);
 -				mark_inode_dirty(inode);
 -			}
 +		/*
 +		 * Inode writeout failed. Backing everything out is complex so
 +		 * let's just leave it for e2fsck to cleanup the mess.
 +		 */
 +		if (error)
  			goto cleanup;
- 	} else
- 		mark_inode_dirty(inode);
 -		}
+ 	}
  
  	error = 0;
  	if (old_bh && old_bh != new_bh) {

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.sync

for you to fetch changes up to 974d0be0cb8e48d63b9d413a2e1a8fba16cd2583:

  writeback: Export __inode_attach_wb() (2026-07-28 14:08:52 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.sync

Please consider pulling these changes from the signed vfs-7.3-rc1.sync tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (5):
      Merge patch series "fs: Fix missed inode write during fsync"
      fat: Fix lost inode update in do_msdos_rename() with DIRSYNC
      fat: Propagate inode buffer write errors from fat_sync_inode_metadata()
      fat: Fix persisting directory entries on fsync(2) of the root directory
      writeback: Export __inode_attach_wb()

Jan Kara (20):
      affs: Drop support for metadata bh tracking
      fs: Fix possible UAF in mark_buffer_write_io_error()
      fs: Fix missed inode writeback when racing with __writeback_single_inode
      ext4: Allocate mapping_metadata_bhs struct on demand
      fs: Provide way for filesystem to wait for metadata writeback
      ext2: Fix lost inode updates for IS_SYNC inodes
      ext2: Drop __ext2_write_inode()
      ext2: Avoid unnecessary inode buffer writeback for sync(2)
      ext2: Fix data integrity writeout issues
      udf: Fix data integrity writeout issues
      udf: Use sync_inode_metadata() to writeout IS_SYNC inode
      udf: Drop udf_sync_inode()
      udf: Use sync_inode_metadata() in udf_evict_inode()
      udf: Fold udf_update_inode() into udf_write_inode()
      bfs: Fix data integrity writeout issues
      minix: Fix data integrity writeout issues
      ext4: Fix data integrity writeout issues in nojournal mode
      fat: Fix missed inode writeback during fsync(2)
      fat: Replace fat_sync_inode() with sync_inode_metadata()
      vfs: Remove mmb_fsync()

 fs/affs/affs.h                 |   2 -
 fs/affs/amigaffs.c             |  12 ++---
 fs/affs/file.c                 |  25 +++++-----
 fs/affs/inode.c                |  13 ++----
 fs/affs/namei.c                |   9 ++--
 fs/affs/super.c                |   1 -
 fs/bfs/dir.c                   |   9 +---
 fs/bfs/inode.c                 |  30 +++++++++---
 fs/buffer.c                    |  83 ++++-----------------------------
 fs/ext2/dir.c                  |   2 +-
 fs/ext2/ext2.h                 |   3 +-
 fs/ext2/file.c                 |  17 +------
 fs/ext2/inode.c                |  49 ++++++++++++--------
 fs/ext2/super.c                |   1 +
 fs/ext2/xattr.c                |   4 +-
 fs/ext4/ext4.h                 |  14 +++++-
 fs/ext4/ext4_jbd2.c            |  25 ++++++++--
 fs/ext4/fsync.c                |  24 ++--------
 fs/ext4/inode.c                | 102 +++++++++++++++++++++++++++--------------
 fs/ext4/super.c                |  16 +++++--
 fs/fat/dir.c                   |   6 +--
 fs/fat/fat.h                   |   1 -
 fs/fat/file.c                  |   9 ++--
 fs/fat/inode.c                 |  63 ++++++++++++++++++-------
 fs/fat/misc.c                  |   7 +--
 fs/fat/namei_msdos.c           |  33 +++++++------
 fs/fat/namei_vfat.c            |  20 ++++----
 fs/fs-writeback.c              |  34 +++++++++++---
 fs/libfs.c                     |   7 ++-
 fs/minix/dir.c                 |   2 +-
 fs/minix/file.c                |   9 +---
 fs/minix/inode.c               |  52 ++++++++++++++-------
 fs/minix/minix.h               |   1 -
 fs/udf/dir.c                   |   2 +-
 fs/udf/file.c                  |  11 ++---
 fs/udf/inode.c                 |  54 +++++++++++-----------
 fs/udf/super.c                 |   1 +
 fs/udf/udfdecl.h               |   2 +-
 include/linux/buffer_head.h    |   4 --
 include/linux/fs.h             |  10 +++-
 include/linux/fs/super_types.h |   2 +
 41 files changed, 409 insertions(+), 362 deletions(-)
