Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3839CD10;
	Fri, 14 Aug 2026 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713156; cv=none; b=Cbow6r84wfTJHNbWNGGAZYvzgpuO/tWl3TLIErHK6Vw1JqxqNC17v5WPR4e763erFPrrcxa3nyJ+d7BnvGSr5bPjSaT7SyJGG4JGQC784FXiNSpbNBLU5J0XcWy+q0bTtx6OK4JwpU1Z1SbQJX/B/fs+MhRJVmPYpgXfCNhzB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713156; c=relaxed/simple;
	bh=k12iJhaf7+U5717bUuPC8dXWyfVc5sRmnlybQHPh4G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL+XtjMfbOCQnZyilmeirADa0HsUoVmV8734spTFdIh7DhN3fYWQS3DyEn1C9pWhj0wlFUkV6s+e6CvlcZM5d1I8dNR9mTJ98d3u0zowsj7XQ0ZJywzPTe8yBiyykAleiPIWoAIwEe1bm/9j4tQYObCQEuieyskvv4n7arofmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrAXFKza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrAXFKza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5163E1F000E9;
	Fri, 14 Aug 2026 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713154;
	bh=Wxq4i0p0jRp4Qn1tOY7uSNaa9J6R2w3VXaVAJXbAuGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SrAXFKzakLAm/31g8aUE0f3Y+2Ee8/nsA4hIxLrEcpDwBkUUJ3sb3V4VppfsH0Tic
	 snp0hcrFsy45Yd5gHB+MdNetaVy0161hHXXKbMdq3cDNerkPKXONzYaUy6AGCioBXP
	 7fpyijjSjzsyqDiLRTxaTwrQ7VdR/nuyraOSkxSbH9PiwxXEDjT0igbvSe6HpKQ0Ug
	 StgcWra/TNYf0t6/tFarn02SCPKIMXEJZMZ5Ge4254la50PAoAiVaehG0Y89dvOACs
	 6/zXeLiPGjjdRstP95h9kGbEXvKNBKQPJLOnGNK6XBTdV38iuFzJWv7DECi0Btbtgp
	 iQtes7+98UI3g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 08/18 for v7.3] vfs iomap
Date: Fri, 14 Aug 2026 15:12:24 +0200
Message-ID: <20260814-vfs-7.3-rc1.iomap-78c92ce13812@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8494; i=brauner@kernel.org; h=from:subject:message-id; bh=k12iJhaf7+U5717bUuPC8dXWyfVc5sRmnlybQHPh4G4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi1iWbNPefktBe6Vn33rJog8Bs/cJXTG36wiS8DRtC 30uVxHXUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEp2xkZfv+rDZPLXXS61uLC 1x8X7Q9VK0w/mqosyxYhayGnur3hKcP/mimqPmbF5s+4eZXP9u6Zbn9updsDb5cv/2REI75c6z3 FDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

The bulk of this is the conversion of iomap to a single ->iomap_next()
callback and thus finishing the move to an iterator model.

Every iomap operation drove its iteration through a struct iomap_ops
holding ->iomap_begin() and ->iomap_end(). iomap_iter() only ever sees
those as pointers. That means every step of every iteration is an
indirect call.

This collapses both into one ->iomap_next() callback that
finishes the previous mapping and produces the next one. This lets
callers inline the iteration loop and pass its ->iomap_next() as a
compile time constant. That means the compiler can turn it into a direct
and hence inlineable call.

This also allows future callers to express custom logic to drive the
iteration forward better. xfs, btrfs, ext4, ext2, erofs, f2fs, gfs2,
hpfs, fuse, exfat, zonefs, ntfs, ntfs3 and the block device
mapping are all converted. No functional changes are intended.

This also adds a simple direct I/O path for small reads. On Gen5 NVMe
the __iomap_dio_rw() dominates 4K random reads. The same single-core
io_uring poll mode workload reaches ~3.2M IOPS against the raw block
device but only ~1.92M through ext4 or XFS.

__iomap_dio_rw(), iomap_iter(), iomap_dio_bio_iter() and kfree() were at
the top of the profile. The new path is very lightweight if no special
behavior is requested. The bio comes from a dedicated bioset and laid
out so the whole request is a single cacheline aligned allocation.
Completion runs inline.

That takes ext4 from 1.92M to 2.19M IOPS in the original workload. fio
shows around:

* 4% at libaio queue depths of 64 and up
* around 5% for io_uring
* up to 10% for io_uring poll mode at depth 256

on both ext4 and xfs.

A few other patches:

- iomap_folio_mark_uptodate() lets a filesystem that writes
  into the page cache outside the iomap read and write paths keep
  iomap's internal uptodate bitmap in sync, which fuse needs for
  server-pushed notify stores before it can enable large folios;

- two fixes for iomap_bio_read_folio_range_sync(): a potential crash
  when device integrity behavior is changed and a missing bio_uninit().

- a folio batch release fix on iomap callback failures

- FGP_NOFS is dropped from iomap_get_folio()

- documentation fix

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

[1]: https://lore.kernel.org/linux-next/anMt1DKhBq-9Hk7h@sirena.org.uk
     https://lore.kernel.org/linux-next/CAJnrk1ZqzifYSFNg1tBNz15p2WBe+rMVfRT5yq=B+wCemLt+4g@mail.gmail.com

This conflicts with the ntfs tree in fs/ntfs/iomap.c between commit
9cf6ac617e8e9 ("ntfs: serialize resident iomap reads with mrec_lock") from
the ntfs tree and commit 7a7bf7551624f ("ntfs: convert iomap ops to
->iomap_next()") from this tree:

diff --cc fs/ntfs/iomap.c
index 73c50171285aa,d0964ac840d9f..0000000000000
--- a/fs/ntfs/iomap.c
+++ b/fs/ntfs/iomap.c
@@@ -283,22 -274,13 +283,24 @@@ static int ntfs_read_iomap_begin(struc
  		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
  {
  	return __ntfs_read_iomap_begin(inode, offset, length, flags, iomap,
 -			srcmap, true);
 +			srcmap, true, true);
  }
  
 -static DEFINE_IOMAP_ITER_NEXT(ntfs_read_iomap_next, ntfs_read_iomap_begin);
 +static int ntfs_read_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 +		ssize_t written, unsigned int flags, struct iomap *iomap)
 +{
 +	struct ntfs_inode *base_ni = iomap->private;
 +
 +	if (base_ni)
 +		mutex_unlock(&base_ni->mrec_lock);
 +	return written;
 +}
 +
++static DEFINE_IOMAP_ITER_NEXT_END(ntfs_read_iomap_next, ntfs_read_iomap_begin,
++				  ntfs_read_iomap_end);
+ 
  const struct iomap_ops ntfs_read_iomap_ops = {
- 	.iomap_begin = ntfs_read_iomap_begin,
- 	.iomap_end = ntfs_read_iomap_end,
+ 	.iomap_next = ntfs_read_iomap_next,
  };
  
  /*

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.iomap

for you to fetch changes up to 9948bc9aa1c2e5e77ab989a8e5d5eec829e967d5:

  Merge patch series "fixes for iomap_bio_read_folio_range_sync" (2026-08-12 09:22:40 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.iomap

Please consider pulling these changes from the signed vfs-7.3-rc1.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
Benjamin Wu (1):
      docs: fix grammatical error in iomap docs

Brian Foster (1):
      iomap: release the folio batch on iomap callback failures

Christian Brauner (4):
      Merge patch series "iomap: add simple dio path for small direct I/O"
      Merge patch series "iomap/fuse: add helper to keep uptodate bitmap in sync"
      Merge patch series "iomap: convert to in-iter iomap_next() model"
      Merge patch series "fixes for iomap_bio_read_folio_range_sync"

Christoph Hellwig (4):
      iomap: decouple simple direct I/O reads from iomap_dio_rw
      iomap: use GFP_NOWAIT when application for iomap_dio_simple allocations
      iomap: don't free integrity payload that doesn't exist
      iomap: iomap_bio_read_folio_range_sync is missing a call to bio_uninit

Fengnan Chang (3):
      iomap: factor out iomap_dio_alignment helper
      iomap: pass error code to should_report_dio_fserror directly
      iomap: add simple dio path for small direct I/O

Joanne Koong (19):
      fuse: don't clear folio uptodate on writethrough errors
      iomap: add helper to mark folio uptodate
      fuse: use iomap helper to mark folio uptodate
      iomap: split iomap_iter() logic into iomap_iter_next()
      iomap: add ->iomap_next()
      xfs: convert iomap ops to ->iomap_next()
      btrfs: convert iomap ops to ->iomap_next()
      ntfs3: convert iomap ops to ->iomap_next()
      ntfs: convert iomap ops to ->iomap_next()
      ext4: convert iomap ops to ->iomap_next()
      erofs: convert iomap ops to ->iomap_next()
      zonefs: convert iomap ops to ->iomap_next()
      ext2: convert iomap ops to ->iomap_next()
      block: convert iomap ops to ->iomap_next()
      f2fs: convert iomap ops to ->iomap_next()
      gfs2: convert iomap ops to ->iomap_next()
      hpfs: convert iomap ops to ->iomap_next()
      fuse: convert iomap ops to ->iomap_next()
      exfat: convert iomap ops to ->iomap_next()

Matthew Wilcox (Oracle) (1):
      iomap: Remove FGP_NOFS from iomap_get_folio()

 Documentation/filesystems/iomap/design.rst |   2 +-
 block/fops.c                               |   4 +-
 fs/btrfs/direct-io.c                       |   6 +-
 fs/erofs/data.c                            |   6 +-
 fs/erofs/zmap.c                            |   5 +-
 fs/exfat/iomap.c                           |  10 +-
 fs/ext2/inode.c                            |   6 +-
 fs/ext4/ext4.h                             |   3 +
 fs/ext4/extents.c                          |   4 +-
 fs/ext4/file.c                             |   4 +-
 fs/ext4/inode.c                            |  10 +-
 fs/f2fs/data.c                             |   4 +-
 fs/fuse/dax.c                              |   6 +-
 fs/fuse/file.c                             |  24 +---
 fs/fuse/notify.c                           |   4 +-
 fs/fuse/virtio_fs.c                        |   3 +-
 fs/gfs2/bmap.c                             |   6 +-
 fs/hpfs/file.c                             |   4 +-
 fs/iomap/bio.c                             |   3 +-
 fs/iomap/buffered-io.c                     |   8 +-
 fs/iomap/direct-io.c                       | 190 +++++++++++++++++++++++++++--
 fs/iomap/iter.c                            | 128 ++++++++++---------
 fs/ntfs/iomap.c                            |  32 +++--
 fs/ntfs3/inode.c                           |   6 +-
 fs/xfs/xfs_file.c                          |  18 +--
 fs/xfs/xfs_iomap.c                         |  41 +++++--
 fs/xfs/xfs_iomap.h                         |   4 +
 fs/zonefs/file.c                           |   9 +-
 include/linux/iomap.h                      | 178 ++++++++++++++++++++++++---
 29 files changed, 569 insertions(+), 159 deletions(-)
