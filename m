Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307679;
	b=xt7Ktij95f695t2NLwp7Z72vPPj0k7P79gOlNOGZJyWuBvMuXuD5XsFd1DdDUd4KIeS0
	 3poBazqlfVK8TrgVpj50vqcTd5FRkMuuV+DEnYZTnQ+CDdkRi/CFUo0mvIqO7NJ30Dyx9
	 JzChAk0smQfi4fPBRcMP6G7sAmWCr3si+/L/8GqYsVJBwXKfrfObZtycDsWBHKB9+E7ga
	 XBs0hK9MieKBQxlsXWIIVya2z1Z2VxrNW9mJLDb8slYJgW71ns1BpsAOaRGnXN1FWoRwd
	 3+qfoAkFOaCxcO69Md2rsj4aF4k/XOQbBYab3UCo3MtRqzae9cs6i18L1ZnQ/qyHl0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307679;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=musk+utB1KfWcXDecDGeXhJbvzifsbZCNqbV6Pr8GHE=;
	b=mS09IpxhfVzduzuy33LIQvkGhvASGM0SgJhLioSmX9ABYaRiYe3Ew58OPXy7FPmUaVG+
	 mQ61ZU/szRYfV1daAcLIubjneYKSJLCdzZXmjH1vfHDFSqzNHhONN8DfE8JnFfVAKT1aw
	 IGQ2+DsQi30hLoEaNPXx6hZl2r2YKSKv5GffMcrR1N3x/hAMWWH/aUPYat+U7BfosnFbE
	 +2hKnagOi5/CMbMEPZDlXt/5Eht5uh4YGfIrq25QOHB9ag2FeWyrDuO56YsTlSG78mVH9
	 LA/5ozqXRBeuZJXFOcNaRodxlHAV3Y7y0HKJ0GDHy1nS2zxVe2vNpLlawO1dBBmCaEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bjd+2Fzf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEE1606A31C;
	Tue, 10 Nov 2026 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bjd+2Fzf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE5E1F0089F;
	Tue, 10 Nov 2026 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307678;
	bh=musk+utB1KfWcXDecDGeXhJbvzifsbZCNqbV6Pr8GHE=;
	h=From:To:Cc:Subject:Date;
	b=Bjd+2FzfWgs1r5CaYTKJ2dqdFylBLe36fcIRBVaTnzcc/Pq8lNC++m80t8iQYPXT5
	 9jdJMi1SU9cnmiQp7qWwFRy13BLSuQGSHcbb+xXThq77LwpMk6NK8hgVFzY9SNiQGS
	 QliIcWhKRZllitF37MulWnvwPw2uHJynbsG+pqs9ha5oodYn4xaCZAhY8kH5HYIQCs
	 UwHulAs0kXsrxdy/FqNU/GAMI0tTjH2T4G090wzgwRe6lpgfZz3HfsAq8CB/ApsESY
	 jJVfnWoORwCwF2mGWY2mjt7/h7rK1un0GDg6awUim6QqyUu5ucFytRAietEOdD5Hpg
	 OlUxtLV4fqoYg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.4] vfs fixes
Date: Tue, 10 Nov 2026 11:47:42 +0100
Message-ID: <20261110-vfs-7.4-rc3.fixes-a971ed79be85@brauner>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11731; i=brauner@kernel.org; h=from:subject:message-id; bh=USaOZFgtrjm7+lXKWZybDrDvfVgr7XHE4Q8JGFPQlvM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9+hbcJvPnyY0F1T9CC4RKXFp8BS6Z2aV+Knywdc6UK VcM7VWLOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyN5nhn/WvNRxTZ05OZPl1 c+fZs91K5UKPcyZL1G+PMoyuETbL0mP4p785W5/Npvbkgd/GkzymzT7uMWnavSXma1fL+SkGPCs RZQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */

This contains fixes for the current development cycle:

- libfs: Make readdir on tmpfs walk the offset tree in offset order
  instead of d_children to avoid skipping entries or relisting the whole
  directory.

  It's faster too. Listing a million entries takes 114ms instead of
  146ms, and 113ms instead of 470ms with four processes listing in
  parallel.

- iomap: Finish the ->iomap_next() conversion that started in v7.3.
  The nilfs2 and fuse ext_map iomap code added this merge window is
  converted so now we can remove the ->iomap_begin()/->iomap_end()
  fallback. We waited until the new iomap users from other trees were in
  mainline otherwise this would have been very messy.

- errseq: Retry with the current value when the cmpxchg() in
  errseq_check_and_advance() fails to avoid an old value coming back
  later hiding the errors.

- aio: Hold an extra count for exit_aio() itself so it can't return
  before the last free_ioctx_reqs() callback has called complete().

- pidfd: Fail the namespace ioctls with EREMOTE unless the target is
  visible in the caller's pid namespace like PIDFD_GET_INFO does.

- eventpoll: Wake the next waiter when a woken waiter returns early
  because of a fatal signal to avoid sleeping forever.

- backing-file: Pass RWF_NOAPPEND on to synchronous writes to the
  backing file.

- initrd: Flush the deferred fput() of the ramdisk file before mounting
  root.

- iov_iter: Take an unsigned long segment count in import_iovec(). The
  upper 32 bits of the count passed to readv(), writev() and friends
  were dropped before the UIO_MAXIOV check.

- splice: Advance the pipe tail before checking for a full bvec array
  in splice_to_socket(). The last buffer was counted again, so MSG_MORE
  was set although the pipe was empty and small TCP transfers waited
  for the cork timeout.

- vfs:

  * Reject negative offsets for SEEK_DATA and SEEK_HOLE in
    default_llseek() and use must_set_pos() for its whence handling.

  * Only clear tv_nsec in timestamp_truncate() when clamping changed
    the seconds. Timestamps whose seconds were exactly at a filesystem
    time limit lost their subsecond part.

  * Don't leak the kernel-internal STATX_ATTR_CHANGE_MONOTONIC in
    stx_attributes_mask.

  * Clamp the FIONREAD result to the int range so a file with 4 GiB
    left isn't reported as empty.

  * Fix the SEEK_CUR f_lock check.

- selftests: Fix the statmount and mount_setattr tests on 32-bit and
  s390, build the fchmodat2 and openat2 tests without sanitizers when
  the toolchain lacks the runtimes and fix a clang warning in the
  mount-notify test.

- docs: Fix a docutils warning in porting.rst.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 05441d697f7f9a927264f4058cbbc6a03dfcac9d:

  Merge tag 'cocci-7.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux (2026-11-03 08:36:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc3.fixes

for you to fetch changes up to 1448959fe3d013ffdb8302d17e4a8fdad2d2da95:

  fs: fix the SEEK_CUR f_lock condition (2026-11-09 16:04:55 +0100)

----------------------------------------------------------------
vfs-7.4-rc3.fixes

Please consider pulling these changes from the signed vfs-7.4-rc3.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Abbott Liu (1):
      initrd: flush deferred fput() before mounting root

Andrea Parri (1):
      iov_iter: take an unsigned long segment count in import_iovec()

Avi Weiss (2):
      fs: clamp FIONREAD result to int range
      splice, net: avoid MSG_MORE when the bvec array fills

Chen Linxuan (1):
      pidfd: restrict task access ioctls to the caller's pid namespace

Chris Mason (1):
      backing-file: pass RWF_NOAPPEND to synchronous writes

Christian Brauner (9):
      libfs: make i_rwsem the lock of the offset tree
      libfs: walk offset directories in offset order
      libfs: end offset readdir at positions past DIR_OFFSET_EOD
      Merge patch series "libfs: fix readdir of offset directories"
      Merge patch series "iomap: remaining patches for iomap_iter_next conversion"
      Merge patch series "errseq: fix lost writeback errors in errseq_check_and_advance()"
      Merge patch series "fs: fix and deduplicate whence handling in default_llseek()"
      aio: don't let exit_aio() return before complete() is done
      fs: fix the SEEK_CUR f_lock condition

Hungyu Lin (1):
      vfs: preserve subsecond timestamps at filesystem time limits

Jeff Layton (1):
      statx: don't leak STATX_ATTR_CHANGE_MONOTONIC in stx_attributes_mask

Joanne Koong (5):
      nilfs2: convert iomap ops to ->iomap_next()
      fuse: convert ext_map iomap ops to ->iomap_next()
      iomap: remove ->iomap_begin()/->iomap_end() legacy path
      iomap: pass iomap_iter_next_fn directly instead of struct iomap_ops
      Documentation: iomap: update docs to reflect iomap_iter_next model

Mani Tofigh (1):
      eventpoll: wake the next waiter when a woken waiter is killed

Randy Dunlap (1):
      fs: porting.rst: use literal string to avoid warning

Sasha Levin (4):
      selftests/statmount: fix format warnings on 32-bit and s390
      selftests/mount_setattr: build with a 64-bit off_t
      selftests: probe for sanitizer support in fchmodat2 and openat2
      selftests/fs/mount-notify: fix the indentation in the fsmount test

Shashank Mohan Jain (2):
      errseq: don't let errseq_check_and_advance() hide later errors
      lib/tests: errseq: add a concurrent check_and_advance test

Siddharth Chintamaneni (2):
      fs: reject negative offsets for SEEK_DATA and SEEK_HOLE in default_llseek()
      fs: use must_set_pos() in default_llseek()

 Documentation/filesystems/iomap/design.rst         | 140 +++++++++++++++------
 Documentation/filesystems/iomap/operations.rst     |  68 +++++-----
 Documentation/filesystems/iomap/porting.rst        |  16 ++-
 Documentation/filesystems/porting.rst              |   2 +-
 block/fops.c                                       |  10 +-
 fs/aio.c                                           |   4 +-
 fs/backing-file.c                                  |   7 +-
 fs/btrfs/direct-io.c                               |   8 +-
 fs/dax.c                                           |  48 +++----
 fs/erofs/data.c                                    |  28 ++---
 fs/erofs/internal.h                                |   3 +-
 fs/erofs/zmap.c                                    |   7 +-
 fs/eventpoll.c                                     |  11 +-
 fs/exfat/file.c                                    |  14 +--
 fs/exfat/inode.c                                   |   6 +-
 fs/exfat/iomap.c                                   |  22 +---
 fs/exfat/iomap.h                                   |   6 +-
 fs/ext2/ext2.h                                     |   3 +-
 fs/ext2/file.c                                     |   4 +-
 fs/ext2/inode.c                                    |   9 +-
 fs/ext4/ext4.h                                     |  10 +-
 fs/ext4/extents.c                                  |   8 +-
 fs/ext4/file.c                                     |  22 ++--
 fs/ext4/inode.c                                    |  58 +++------
 fs/f2fs/data.c                                     |   6 +-
 fs/f2fs/f2fs.h                                     |   3 +-
 fs/f2fs/file.c                                     |   4 +-
 fs/file.c                                          |  10 +-
 fs/fuse/dax.c                                      |  10 +-
 fs/fuse/ext_map.c                                  |  11 +-
 fs/fuse/file.c                                     |  10 +-
 fs/fuse/virtio_fs.c                                |   3 +-
 fs/gfs2/aops.c                                     |   6 +-
 fs/gfs2/bmap.c                                     |   9 +-
 fs/gfs2/bmap.h                                     |   2 +-
 fs/gfs2/file.c                                     |   6 +-
 fs/gfs2/inode.c                                    |   6 +-
 fs/hpfs/file.c                                     |   6 +-
 fs/inode.c                                         |   3 +-
 fs/internal.h                                      |   1 -
 fs/ioctl.c                                         |   5 +-
 fs/iomap/buffered-io.c                             |  40 +++---
 fs/iomap/direct-io.c                               |   8 +-
 fs/iomap/fiemap.c                                  |   8 +-
 fs/iomap/iter.c                                    |  13 +-
 fs/iomap/seek.c                                    |   8 +-
 fs/iomap/swapfile.c                                |   4 +-
 fs/iomap/trace.h                                   |  12 +-
 fs/libfs.c                                         | 133 ++++++++------------
 fs/nilfs2/file.c                                   |   2 +-
 fs/nilfs2/iomap.c                                  |   4 +-
 fs/nilfs2/iomap.h                                  |   4 +-
 fs/ntfs/aops.c                                     |   6 +-
 fs/ntfs/file.c                                     |  20 +--
 fs/ntfs/inode.c                                    |   2 +-
 fs/ntfs/iomap.c                                    |  42 ++-----
 fs/ntfs/iomap.h                                    |  10 +-
 fs/ntfs3/file.c                                    |  16 +--
 fs/ntfs3/inode.c                                   |  13 +-
 fs/ntfs3/ntfs_fs.h                                 |   3 +-
 fs/pidfs.c                                         |   8 ++
 fs/read_write.c                                    |  48 +++----
 fs/remap_range.c                                   |   6 +-
 fs/splice.c                                        |   2 +-
 fs/stat.c                                          |   6 +-
 fs/xfs/xfs_aops.c                                  |   8 +-
 fs/xfs/xfs_file.c                                  |  53 ++++----
 fs/xfs/xfs_iomap.c                                 |  55 ++------
 fs/xfs/xfs_iomap.h                                 |  16 +--
 fs/xfs/xfs_iops.c                                  |   4 +-
 fs/xfs/xfs_reflink.c                               |   6 +-
 fs/zonefs/file.c                                   |  22 ++--
 include/linux/dax.h                                |  18 ++-
 include/linux/fs.h                                 |   9 +-
 include/linux/iomap.h                              |  66 +++++-----
 include/linux/stat.h                               |   3 +
 include/linux/uio.h                                |   8 +-
 init/do_mounts_rd.c                                |   5 +
 lib/errseq.c                                       |  29 +++--
 lib/iov_iter.c                                     |   6 +-
 lib/tests/errseq_kunit.c                           | 110 +++++++++++++++-
 mm/shmem.c                                         |   2 +-
 tools/testing/selftests/fchmodat2/Makefile         |  18 ++-
 .../filesystems/mount-notify/mount-notify_test.c   |   8 +-
 .../testing/selftests/filesystems/openat2/Makefile |  18 ++-
 .../filesystems/statmount/statmount_test.c         |   4 +-
 .../filesystems/statmount/statmount_test_ns.c      |   5 +-
 tools/testing/selftests/mount_setattr/Makefile     |   2 +-
 88 files changed, 776 insertions(+), 732 deletions(-)
