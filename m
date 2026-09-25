Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF04D957A;
	Fri, 25 Sep 2026 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353183; cv=none; b=tXitdYDSdDlpfGuxU66iHIBfYcVdUxYVVFGCY/C6jkU0+yfck64QAhKjupa+xtpyrZp3CzUClKLn4KbfPW+K39uT5vTpgkHL463bnrQtlJP+533rO230qZI5tZ/3+LC/EB8u8qpoCU/qXf4XA5Y2tbc3lryInWTo7nPfaAPkUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353183; c=relaxed/simple;
	bh=7SPfgT3yxAtUy4/I7jtEfVht8qM404aP0hv4bacumsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOAepRxdSxtprP4ZMwY7Ei0CH+L/seic6DwQJpBTMSQw/MSmHtnuT636+w6EkOsvEF8jJQou+u/EBC9wNsEq/yyRIBoWQUc5N0TyHrtURc9clr9FiUgPB7y9eBw5Kca0upeLmEKmyMSSQKxCByp5y9oDe4Wfbl02C6huwoKrJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOWhbPX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOWhbPX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98511F000FF;
	Fri, 25 Sep 2026 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790353181;
	bh=GUDwkH9+BOmXyNnZzKsLz6X0f0k83C9EHLFD/tQ4fMw=;
	h=From:To:Cc:Subject:Date;
	b=HOWhbPX8G08VpVlkwopza9PxKXeUNb46KCzqk01LFYmVlA8bCchZLIglDrD3Ge/xh
	 SbgVc2/vuG6AnCmqg3DSaZ1bVc/utCKSxMz3YgXAlUUdT27XNO8Tvn+Pnu3YZuPeaH
	 ak9RP4nFAnAiv0XvN6SsSqV8AY0f9FfijzFT69qs+wXbPgKFz5wwYyREOB2C/r0BPE
	 pvRR1WtTLk0kZhA34W3ADJQbr20IxsXxZ9lAg+SShNFuBD8525jQ3gnWxsilAGb/is
	 acaKl7Vg79G421vCUQt//2Xw7x/wADx9YCMICnLB5ON8+Rm/u7zeszhzl0kIYOb+P8
	 6aY4e3FWUYq7g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.3] vfs fixes
Date: Fri, 25 Sep 2026 18:19:27 +0200
Message-ID: <20260925-vfs-7.3-rc5.fixes-924ff07b1ab1@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6572; i=brauner@kernel.org; h=from:subject:message-id; bh=7SPfgT3yxAtUy4/I7jtEfVht8qM404aP0hv4bacumsI=; b=kA0DAAoWkcYbwGV43KIByyZiAGq2nxahE/tCKIIuMV//RZkIMSWvxODqcICxwPywSdhYFmX4C oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmq2nxYACgkQkcYbwGV43KIqCwD/e5iD l7RdSclmSYI+RpQskohVIomlbLa4myqmJ8xJWCkA/iUeMZ94Dym7UjdrkslEMb5vvrdh6WT5nn/ YhXKhR3oB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains fixes for the current development cycle:

- Revert "put_mnt_ns(): leave mounts connected". This allows the
  creation of reference count cycles in a very trivial way. We can't
  bring this in until we have fixed the underlying cause.

- vfs: Don't create the private nullfs instance for kthreads under
  namespace_sem to avoid false lockdeps complaints.

- binfmt_misc

  * Copy the name into a stack buffer and look up the copy in
    bpf_binprm_select_interp().

  * bpf_binprm_set_interp() and bpf_binprm_set_interp_arg(): Check the
    private copy instead so the string that gets staged is the kstring
    that was checked.

- netfs

  * Make netfs_read_gaps() use separate sink folios rather than one
    reused sink folio to discard unwanted data so that cifs checksum
    checking sees all the data that was fetched.

  * Trim reads down to i_size so afs symlinks read correctly from the
    cache.

  * Wrap the direct mempool ->alloc() calls the GFP_KERNEL paths make
    in alloc_hooks() via a new mempool_alloc_noreserve() helper.

- iov_iter: Use iov_iter_alignment() for the start and length check
  added to iov_iter_extract_bvecs() this cycle. It used iter_iov_addr()
  and iter_iov_len() which are only valid for ITER_UBUF and ITER_IOVEC
  iterators.

- super: Make iterate_supers_type() deletion-safe.

- inode: Stop evict_inodes() from rescanning the same inodes.

- writeback: Bound the cleanup_offline_cgwb() rescans.

- ntfs3: Use d_instantiate_new() in ntfs_create_inode().

- ovl: Fix a use-after-free in the ovl_do_mkdir() debug print.

- dcache: Unpoison the inline name buffer in __d_alloc() for KMSAN.

- autofs: Fix a pipe file reference leak in autofs_kill_sb().

- bpf: Drop the path_unlink and path_rmdir hooks from the list of hooks
  for which the verifier rewrites bpf_{set,remove}_dentry_xattr() to
  the _locked variants.

- squashfs: Range check the xz dictionary size before shifting by it.

- selftests: Add the missing eventfd, open_tree_ns, openat2 and xattr
  filesystems selftests to TARGETS and drop the stale openat2 entry
  left behind when those tests moved.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 50d05c7c76c96b90462f24debacca971d2e86713:

  Merge tag 'landlock-7.3-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux (2026-09-09 11:00:35 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc5.fixes

for you to fetch changes up to b78b728e21c32ec4c330b299f657fb1eb02dffc2:

  netfs: Fix missing alloc tagging of direct mempool allocations (2026-09-25 17:30:39 +0200)

----------------------------------------------------------------
vfs-7.3-rc5.fixes

Please consider pulling these changes from the signed vfs-7.3-rc5.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Amir Goldstein (1):
      ovl: fix UAF in ovl_do_mkdir() debug print

Andrea Parri (1):
      bpf: fs/xattr: don't assume the inode is locked in path_unlink/path_rmdir

Chris Mason (2):
      binfmt_misc: fix OOB read in bpf_binprm_select_interp()
      binfmt_misc: fix racy checks in bpf set_interp kfuncs

Christian Brauner (7):
      fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga
      fs: don't create the private nullfs mount under namespace_sem
      Merge patch series "binfmt: fixes for kres reports"
      Revert "selftests/filesystems: add mntns cleanup test"
      Revert "put_mnt_ns(): leave mounts connected"
      Merge patch series "Revert "put_mnt_ns(): leave mounts connected""
      super: make iterate_supers_type() deletion-safe

David Howells (3):
      block: Fix start and length check added to iov_iter_extract_bvecs()
      netfs: Fix netfs_read_gaps() to use separate sink folios
      netfs, afs: Fix symlink reading

Disha Goel (1):
      selftests/filesystems: fix missing and stale TARGETS entries

Drif Abdelmalek Mohamed Said (1):
      dcache: unpoison the inline name buffer in __d_alloc()

Hao Ge (1):
      netfs: Fix missing alloc tagging of direct mempool allocations

Hui Peng (1):
      autofs: fix sbi->pipe file reference leak in autofs_kill_sb()

Julian Sun (1):
      fs: avoid repeated scans in evict_inodes()

Patrick Lu (Anthropic) (1):
      writeback: bound cleanup_offline_cgwb() rescans by rotating scanned inodes

Ran Hongyun (1):
      squashfs: Add dictionary size range check to prevent shift-out-of-bounds

 fs/autofs/inode.c                                  |  4 ++
 fs/binfmt_misc_bpf.c                               | 35 +++++++++++--
 fs/bpf_fs_kfuncs.c                                 |  4 --
 fs/dcache.c                                        |  4 ++
 fs/fs-writeback.c                                  | 25 ++++++++--
 fs/inode.c                                         | 11 ++--
 fs/kernfs/mount.c                                  |  4 +-
 fs/namespace.c                                     | 27 ++++++----
 fs/netfs/buffered_read.c                           | 34 +++++++------
 fs/netfs/objects.c                                 |  4 +-
 fs/netfs/read_collect.c                            |  5 ++
 fs/netfs/rolling_buffer.c                          |  2 +-
 fs/ntfs3/inode.c                                   |  7 +--
 fs/overlayfs/overlayfs.h                           |  4 +-
 fs/squashfs/xz_wrapper.c                           |  6 +--
 fs/super.c                                         | 39 +++++++--------
 include/linux/mempool.h                            |  7 +++
 lib/iov_iter.c                                     | 18 ++++++-
 tools/testing/selftests/Makefile                   |  6 ++-
 .../selftests/filesystems/mntns_cleanup/.gitignore |  2 -
 .../selftests/filesystems/mntns_cleanup/Makefile   |  6 ---
 .../filesystems/mntns_cleanup/mntns_cleanup_test.c | 58 ----------------------
 22 files changed, 165 insertions(+), 147 deletions(-)
 delete mode 100644 tools/testing/selftests/filesystems/mntns_cleanup/.gitignore
 delete mode 100644 tools/testing/selftests/filesystems/mntns_cleanup/Makefile
 delete mode 100644 tools/testing/selftests/filesystems/mntns_cleanup/mntns_cleanup_test.c
