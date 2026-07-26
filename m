Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DB3C1089;
	Sun, 26 Jul 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080264; cv=none; b=Bc3t3qMR35fbiIt7kBTOrQTzDIuI5V86MP7Jsnl1CKUZoXDzwEKLpAF68Z7TA68onfwY79UCOVQbu+y9d5n3koGF+ZfGGP6BRIkjIUfe2nkOrHVLNXYInf6EboeLIagzandU1qe6QpcAztrob5RbPCHwZmJ0lGO/x4/twYB/WBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080264; c=relaxed/simple;
	bh=nZHRw02F2a9PU7XOkKXurBol/A6/HW5HEko+CumfsWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXiyeG6NPlWjsv+8RVnCOCpQ5dLKevLcQf1V46MSo1p3hknv21OmaJDfYOP9olvRe7ww79c3H8Fkpuk+9rHXeYOJA2VLppxHDdxcMYm2weT3+m4ItxLdtI2hHvhg+Z/2hUYAiGC617cvjLz3ZDJ27QtjFrSK6ZZMCKDo3MvOjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIZPRsGQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIZPRsGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F77C1F000E9;
	Sun, 26 Jul 2026 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785080254;
	bh=UpjTsCzK6WmfaG8zhJL5mTX4KcE25hvm0eyeM4fUZDs=;
	h=From:To:Cc:Subject:Date;
	b=CIZPRsGQINRwN3PHM5OMJWylrdTtlJB/vDKHerYjQrmRY9dY3IIsjDe51r5iFv2Jk
	 Ex//Rp/D+1N/qi0bf1eBUCoea7smtuCQUwcUuZLLzqCuA+oqK646ao2IZxvV8FStvo
	 yfo2IsgLwVe/Aj8YGUZpvTsShucrVwvVwuWqanG30Hh8dPjY7zRK8SM8DZ+QYYnoej
	 hn/Zf6na6qHyvXtplAerHYZpkrmUJ9NdBH3z+xpKpI/TAoi+chPrTSbs+JH4HCNkoo
	 JKJCGV4+pK3BvI3hSo/DAE8qEcyepLmn0cP2bRthT5ffNyYhONr3VyM6CFQmpdv+5N
	 47Lgtpz6dTfcA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.2] vfs fixes
Date: Sun, 26 Jul 2026 17:37:10 +0200
Message-ID: <20260726-vfs-7.2-rc5.fixes-40ccd95afb90@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8634; i=brauner@kernel.org; h=from:subject:message-id; bh=nZHRw02F2a9PU7XOkKXurBol/A6/HW5HEko+CumfsWE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSlaW55MXeL0z+3GVPWKauLSDa0Gt7+fNBKoH59nNzM3 /ZnTm0L6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5EuMDLNNby+sM/Q9f63k BLsNk7Zhl8Gn+Nf6TotqRO+Jt2U89mRkuGDZ2iznEn636cSkSr5bxfslTljNMXr6znY+b9Dl48t iOAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

A bit later than intended today so no problem if we need to push this
past -rc5.

/* Summary */

This contains fixes for the current development cycle:

- vfs: Preserve the ACL_DONT_CACHE state in forget_cached_acl().
  ACL_DONT_CACHE is meant to be a permanent opt-out from ACL caching
  which FUSE relies on for servers that don't negotiate FUSE_POSIX_ACL.
  The helper replaced it with ACL_NOT_CACHED, silently re-enabling the
  cache, and as fuse doesn't invalidate the cache for such servers a
  properly timed get_acl() returned stale ACLs. Comes with a fuse
  selftest reproducing this.

- pidfs:

  * Preserve PIDFD_THREAD when a thread pidfd is reopened via
    open_by_handle_at(). PIDFD_THREAD shares the O_EXCL bit which
    do_dentry_open() strips after the flags have been validated, so the
    reopened pidfd silently became a process pidfd. Comes with a
    selftest.

  * Add a pidfs_dentry_open() helper so the regular pidfd allocation
    path and the file handle path share the code that forces O_RDWR and
    reapplies the pidfd flags that do_dentry_open() strips.

  * Handle FS_IOC32_GETVERSION in the compat ioctl path.

  * Make pidfs_ino_lock static.

- iomap:

  * Fix the block range calculation in ifs_clear_range_dirty() so a
    partial clear doesn't drop the dirty state of blocks the range only
    partially covers.

  * Support invalidating partial folios so a partial truncate or hole
    punch with blocksize < foliosize doesn't leave stale dirty bits
    behind.

  * Only set did_zero when iomap_zero_iter() actually zeroed something.

  * Guard ifs_set_range_dirty() and ifs_set_range_uptodate() against
    zero-length ranges where the unsigned last-block calculation
    underflows and bitmap_set() writes far beyond the ifs->state
    allocation.

  * Don't merge ioends with different io_private values as the merge
    could leak or corrupt the private data of the individual ioends.

- exec:

  * Raise bprm->have_execfd only once the binfmt_misc interpreter has
    actually been opened. The flag was set as soon as a matching 'O' or
    'C' entry was found. If the interpreter open failed with ENOEXEC
    the exec fell through to the next binary format with have_execfd
    raised but no executable staged and begin_new_exec() NULL derefed
    past the point of no return.

  * Fix an unsigned loop counter wrap in transfer_args_to_stack() on
    nommu. An overlong argument or environment string pushes bprm->p
    below PAGE_SIZE, the stop index becomes zero, and the loop never
    terminates, wrapping its counter and copying garbage from in front
    of the page array into the new process stack.

  * Make binfmt_elf_fdpic only honour the first PT_INTERP like
    binfmt_elf does. Each additional PT_INTERP overwrote the previous
    interpreter, leaking the name allocation and the interpreter file
    reference together with the write denial open_exec() took, leaving
    the file unwritable for as long as the system runs.

- overlayfs:

  * Compare the full escaped xattr prefix including the trailing dot.
    An xattr like "trusted.overlay.overlayfoo" was misclassified as an
    escaped overlay xattr.

  * Check read access to the copy_file_range() source with the source's
    mounter credentials.

- super: Thawing a filesystem whose block device was frozen with
  bdev_freeze() deadlocked. Dropping the last block layer freeze
  reference from under s_umount ends up in fs_bdev_thaw() which
  reacquires s_umount on the same task. Pin the superblock with an
  active reference instead and call bdev_thaw() without holding
  s_umount.

- procfs: Return EACCES instead of success when the ptrace access check
  for namespace links fails.

- afs: Use afs_dir_get_block() rather than afs_dir_find_block() for
  block 0 in afs_edit_dir_remove(), matching afs_edit_dir_add().

- Push the memcg gating of ->nr_cached_objects() down into the btrfs
  and shmem callbacks instead of skipping every callback during
  non-root memcg reclaim. The blanket check short-circuited XFS whose
  inode reclaim hook is intentionally driven from per-memcg contexts to
  free memcg-charged slab.

- eventpoll: Pin files while checking reverse paths. Since struct file
  became SLAB_TYPESAFE_BY_RCU a concurrent close could free and recycle
  the file under the check which then took and dropped the f_lock of
  whatever live file now occupies that slot.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc5.fixes

for you to fetch changes up to 749d7aa0377aae32af8c0a4ad43371e7bf830ab5:

  super: fix emergency thaw deadlock on frozen block devices (2026-07-26 17:08:52 +0200)

----------------------------------------------------------------
vfs-7.2-rc5.fixes

Please consider pulling these changes from the signed vfs-7.2-rc5.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Amir Goldstein (3):
      fs: preserve ACL_DONT_CACHE state in forget_cached_acl()
      selftests/fuse: add ACL_DONT_CACHE regression test
      ovl: check access to copy_file_range source with src mounter creds

Chen Changcheng (1):
      fs/super: fix emergency thaw double-unlock of s_umount

Christian Brauner (10):
      binfmt_misc: set have_execfd only once the interpreter is opened
      exec: fix unsigned loop counter wrap in transfer_args_to_stack()
      binfmt_elf_fdpic: only honour the first PT_INTERP
      Merge patch series "Fix for unintended FUSE ACL cache"
      pidfs: preserve thread pidfds reopened by file handle
      selftests/pidfd: check PIDFD_THREAD survives open_by_handle_at()
      Merge patch series "pidfs: preserve thread pidfds reopened by file handle"
      pidfs: add pidfs_dentry_open() helper
      Merge patch series "iomap: trivial fixes for ext4 conversion"
      super: fix emergency thaw deadlock on frozen block devices

David Howells (1):
      afs: Fix afs_edit_dir_remove() to get, not find, block 0

Guidong Han (1):
      eventpoll: pin files while checking reverse paths

Jann Horn (1):
      proc: Fix broken error paths for namespace links

Li Chen (1):
      pidfs: handle FS_IOC32_GETVERSION in compat ioctl

Mateusz Guzik (1):
      pidfs: make pidfs_ino_lock static

Usama Arif (1):
      fs: push nr_cached_objects memcg gating into individual filesystems

Yichong Chen (1):
      ovl: fix trusted xattr escape prefix matching

Zhang Yi (6):
      iomap: correct the range of a partial dirty clear
      iomap: support invalidating partial folios
      iomap: fix incorrect did_zero setting in iomap_zero_iter()
      iomap: fix out-of-bounds bitmap_set() with zero-length range
      iomap: add comments for ifs_clear/set_range_dirty()
      iomap: prevent ioend merge when io_private differs

 fs/afs/dir_edit.c                                  |   2 +-
 fs/binfmt_elf_fdpic.c                              |   4 +
 fs/binfmt_misc.c                                   |   5 +-
 fs/btrfs/super.c                                   |  10 +
 fs/eventpoll.c                                     |  18 +-
 fs/exec.c                                          |   2 +-
 fs/iomap/buffered-io.c                             |  58 +++-
 fs/iomap/ioend.c                                   |   2 +
 fs/overlayfs/file.c                                |  16 +-
 fs/overlayfs/xattrs.c                              |   2 +-
 fs/pidfs.c                                         |  54 +++-
 fs/posix_acl.c                                     |   7 +
 fs/proc/namespaces.c                               |   4 +-
 fs/super.c                                         |  34 +-
 include/linux/memcontrol.h                         |  21 ++
 mm/shmem.c                                         |  10 +
 tools/testing/selftests/filesystems/fuse/Makefile  |  10 +
 .../filesystems/fuse/fuse_acl_cache_test.c         | 347 +++++++++++++++++++++
 .../selftests/pidfd/pidfd_file_handle_test.c       |   1 +
 19 files changed, 553 insertions(+), 54 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test.c
