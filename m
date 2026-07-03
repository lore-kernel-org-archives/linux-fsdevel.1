Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C9B343D86;
	Fri,  3 Jul 2026 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078335; cv=none; b=Hf2nKHO8kKvV4lq0KSJKPlvIm139vK88iO382gEmOuF6y4lJPU5VKukPnHD5p1Yw/p6JjR+Y6Pk8WBP8qFKkXDwXJeT/0BuuYv2VF8FUg0nTefAA2fYQ2fi5U57crnwgQ1W2ZjEUPTHtpjMuoHwIiZ+wrMRy8cdKTfp/TNT0YQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078335; c=relaxed/simple;
	bh=uyy/sbpTZ3mgh/Ls/CcnWDHfkO3k+LVD/ltOMQNLEDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JLiAJl/jNimQY06tcfwWSett6Rc89/5RDLGZDUC0LT6G2YvAUQcff9euZqXcL5qp+knJ9e8bdiXLEFKj2U//8Patxm8ZHEuVSwjBq8XN5yK0+ETBqPZUHXOelEG6FzD4qPtRNCEUriu6lyOxO8VcSL9gymow0h4OwSszcn0aPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDNPOyQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDNPOyQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306C81F000E9;
	Fri,  3 Jul 2026 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078333;
	bh=1fyxa3RlE62tZ4lXVOKwOlmc+55+Uo1jIG9flFilIy8=;
	h=From:To:Cc:Subject:Date;
	b=LDNPOyQ24zgOUZIPNztfOVTpT6n+8NzbC2QHCxo2cBxj8yL0tImUPJIv8vbVCeL3Z
	 orPbG2Hv3e/99JoXSef8930kTWqcpGPRZybyY2wz8PM71njrc4Qx7+hoV0P0UDRAtQ
	 x25bmBRiNR2U2H2UIOsgFyKmUTDl7nGRAZDaWUNel2dmtKOMKF3+1yvs6gOmfdNkk2
	 CXjEtw2JNAg1/7JnNnNinLthwcgSxEQHlzlRwhqBuVQysXXVEgdtB+U5pJCHP2lSP7
	 uwu69QmRd0V1xOmRc4UOQzjd1LY3hY0+Bt2++r88P39PmkWqOaIFECbKbDzFoQTTaU
	 VddBd+qYfF9Hg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.2] vfs fixes
Date: Fri,  3 Jul 2026 13:32:02 +0200
Message-ID: <20260703-vfs-7.2-rc2.fixes-115a53229423@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13239; i=brauner@kernel.org; h=from:subject:message-id; bh=uyy/sbpTZ3mgh/Ls/CcnWDHfkO3k+LVD/ltOMQNLEDQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5z91e9uHiF1N5od7t/evPXmc+EDDLeqJf4r6b3tn6s cdXv57H1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR4DuMDLeCatzEWa4t6rBl 7zkQNvPY/8btueemLb4cqdfaGeFZvJqR4ZDyymvXFuxRN97LEW+f03hL/z9f8O8NMQ++GZ9zV6r 3YQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains fixes for the current development cycle:

- netfs:

  * the decision when to disallow write-streaming with fscache in use,
    handling of asynchronous cache object creation, a double fput in
    cachefiles, clearing S_KERNEL_FILE without the inode lock held, page
    extraction bugs in the iov_iter helpers (a potential underflow, a
    missing allocation failure check, a memory leak, and a folio offset
    miscalculation), writeback error and ENOMEM handling, DIO write
    retry for filesystems without a ->prepare_write() method, and the
    replacement of the wb_lock mutex with a bit lock plus writethrough
    collection offload so that multiple asynchronous writebacks don't
    interfere with each other.

  * Fix the barriering when walking the netfs subrequest list during
    retries as it was possible to see a subrequest that was just added
    by the application thread.

- iomap:

  * Change iomap to submit read bios after each extent instead of
    building them up across extents. The old behavior was considered
    problematic for a while and now caused an actual erofs bug.

  * Guard the ioend io_size EOF trim in iomap against underflow
    when a concurrent truncate moves EOF below the start of the ioend,
    wrapping io_size to a huge value.

- overlayfs

  * Fix a stale overlayfs comment about the locking order.

  * Store the linked-in upper dentry instead of the disconnected
    O_TMPFILE dentry during overlayfs tmpfile copy-up. With a FUSE or
    virtiofs upper layer ->d_revalidate() would try to look up "/" in
    the workdir and fail, causing persistent ESTALE errors that broke
    dpkg and apt.

- vfs-bpf: Have the bpf_real_data_inode() kfunc take a struct file
  instead of a dentry so it is usable from the bprm_check_security,
  mmap_file, and file_mprotect hooks, and rename it from
  bpf_real_inode() to make the data-inode semantics explicit. The kfunc
  landed this cycle so the change is safe.

- afs: NULL pointer dereferences in the callback
  service and in afs_get_tree(), several memory and refcount leaks,
  missing locking around the dynamic root inode numbers and premature
  cell exposure through /afs, a netns destruction hang caused by a
  misplaced increment of net->cells_outstanding, a bulk lookup
  malfunction caused by the dir_emit() API change, inode
  (re)initialisation issues, and assorted smaller fixes to error codes,
  seqlock handling, and debug output.

- vfs: Refuse O_TMPFILE creation with an unmapped fsuid or fsgid and add
  a selftest for it.

- Add Jori Koolstra as vboxsf maintainer, taking over from Hans de
  Goede.

- Release the pages attached to a short atomic dio bio; the REQ_ATOMIC
  size check error path leaked them.

- procfs: Only bump the parent directory link count when registering
  directories in procfs. Registering regular files inflated the count
  and leaked a link on every create and remove cycle.

- minix: Avoid an unsigned overflow in the minix bitmap block count
  calculation that let crafted images with huge inode or zone counts
  pass superblock validation and crash the kernel during mount.

- cachefiles: Fix a double unlock in the cachefiles nomem_d_alloc error path
  left over from the start_creating() conversion.

- fat: Stop fat from reading directory entries past the 0x00
  end-of-directory marker. If the trailing on-disk slots aren't
  zero-filled the driver surfaced arbitrary garbage as directory
  entries.

- freexvfs: Don't BUG() on unknown typed-extent types in freevxfs, reachable
  via ioctl(FIBMAP) on a crafted image; fail with an I/O error instead.

- orangefs: Keep the readdir entry size 64-bit in orangefs fill_from_part().
  Truncating it to __u32 bypassed the bounds check and led to out-of-bounds
  reads triggerable by the userspace client.

- xfs: Fix the error unwind in xfs_open_devices() which released the rt
  device file twice and left dangling buftarg pointers behind that were
  freed again when the failed mount was torn down.

- exec: Fix an off-by-one in the comment documenting the maximum binfmt
  rewrite depth in exec_binprm(). The code allows five rewrites, not
  four; restricting the code would break userspace so the comment is
  fixed instead.

- file handles: Reject detached mounts in capable_wrt_mount(). A
  detached mount can be dissolved concurrently, leaving a NULL mount
  namespace that open_by_handle_at() would dereference.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 665159e246749578d4e4bfe106ee3b74edcdab18:

  Merge tag 'probes-fixes-v7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace (2026-06-30 17:50:44 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc2.fixes

for you to fetch changes up to 5c6ce05e406520290c1d89da97fb3cd70c09137d:

  netfs: Fix barriering when walking subrequest list (2026-07-03 11:52:41 +0200)

----------------------------------------------------------------
vfs-7.2-rc2.fixes

Please consider pulling these changes from the signed vfs-7.2-rc2.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Alan Urmancheev (1):
      exec: fix off-by-one in binfmt max rewrite depth comment

Amir Goldstein (1):
      ovl: fix comment about locking order

Bryam Vargas (1):
      orangefs: keep the readdir entry size 64-bit in fill_from_part()

Christian Brauner (8):
      fs: refuse O_TMPFILE creation with an unmapped fsuid or fsgid
      selftests/filesystems: test O_TMPFILE creation on idmapped mounts
      Merge patch series "fs: refuse O_TMPFILE creation with an unmapped fsuid or fsgid"
      Merge patch series "afs: Miscellaneous fixes"
      bpf: have bpf_real_data_inode() take a struct file
      xfs: fix the error unwind in xfs_open_devices()
      Merge patch series "netfs: Miscellaneous fixes"
      Merge patch series "iomap: consolidate bio submission"

Christoph Hellwig (2):
      iomap: consolidate bio submission
      iomap: submit read bio after each extent

Dan Carpenter (1):
      afs: Fix error code in afs_extract_vl_addrs()

David Howells (31):
      afs: Fix double netfs initialisation in afs_root_iget()
      afs: Remove setting of AS_RELEASE_ALWAYS for symlinks and mountpoints
      afs: Fix directory inode initialisation order
      afs: Fix bulk lookup malfunction due to change in dir_emit() API
      afs: Fix misplaced inc of net->cells_outstanding
      afs: Fix reinitialisation of the inode, in particular ->lock_work
      afs: Fix callback service message parsers to pass through -EAGAIN
      afs: Use scoped_seqlock_read() rather than manually doing seqlock stuff
      afs: Fix missing NULL pointer check in afs_break_some_callbacks()
      afs: Fix leak of ungot volume
      afs: Fix vllist leak
      afs: Fix lack of locking around modifications of net->cells_dyn_ino
      afs: Fix premature cell exposure through /afs
      afs: Fix the volume AFS_VOLUME_RM_TREE is set on
      afs: Fix unchecked-length string display in debug statement
      netfs: Fix decision whether to disallow write-streaming due to fscache use
      netfs: Fix netfs_create_write_req() to handle async cache object creation
      cachefiles: Fix double fput
      cachefiles: Fix file burial to take lock when unsetting S_KERNEL_FILE
      iov_iter: Fix potential underflow in iov_iter_extract_xarray_pages()
      iov_iter: Fix missing alloc fail check in iov_iter_extract_bvec_pages()
      iov_iter: Fix a memory leak in iov_iter_extract_user_pages()
      iov_iter: Remove unused variable in kunit_iov_iter.c
      scatterlist: Fix offset in folio calc in extract_xarray_to_sg()
      netfs: Fix kdoc warning
      netfs: Replace wb_lock with a bit lock for asynchronicity
      netfs: Fix writethrough to use collection offload
      netfs: Fix writeback error handling
      netfs: Fix folio state after ENOMEM whilst under writeback iteration
      netfs: Fix DIO write retry for filesystems without a ->prepare_write()
      netfs: Fix barriering when walking subrequest list

David Lee (1):
      fhandle: reject detached mounts in capable_wrt_mount()

Farhad Alemi (1):
      freevxfs: don't BUG() on unknown typed-extent type

Fengnan Chang (1):
      iomap: release pages on atomic dio size mismatch

Hongling Zeng (1):
      cachefiles: Fix double unlock in nomem_d_alloc error path

Joanne Koong (1):
      fuse: call fuse_send_readpages explicitly from fuse_readahead

Jori Koolstra (1):
      MAINTAINERS: take over vboxsf from Hans de Goede

Krzysztof Wilczyński (1):
      proc: only bump parent nlink when registering directories

Li RongQing (1):
      afs: Remove erroneous seq |= 1 in volume lookup loop

Matteo Croce (1):
      fat: stop reading directory entries past the end-of-directory marker

Matvey Kovalev (1):
      afs: fix NULL pointer dereference in afs_get_tree()

Michael Bommarito (1):
      minix: avoid overflow in bitmap block count calculation

Morduan Zang (1):
      iomap: guard io_size EOF trim against concurrent truncate underflow

Nan Li (1):
      afs: handle CB.InitCallBackState3 requests without a server record

Souvik Banerjee (1):
      ovl: use linked upper dentry in copy-up tmpfile

Yuto Ohnuki (1):
      afs: check for duplicate servers in VL server list

Zilin Guan (1):
      afs: use kvfree() to free memory allocated by kvcalloc()


 MAINTAINERS                                        |   2 +-
 fs/afs/callback.c                                  |  17 +--
 fs/afs/cell.c                                      |  27 +++-
 fs/afs/cmservice.c                                 |   7 +-
 fs/afs/dir.c                                       |  40 +++--
 fs/afs/dynroot.c                                   |   2 +-
 fs/afs/fs_operation.c                              |   2 +-
 fs/afs/inode.c                                     |  15 +-
 fs/afs/internal.h                                  |   3 +-
 fs/afs/super.c                                     |   5 +-
 fs/afs/symlink.c                                   |   4 +-
 fs/afs/vl_list.c                                   |  24 ++-
 fs/afs/volume.c                                    |   2 +-
 fs/bpf_fs_kfuncs.c                                 |  23 +--
 fs/cachefiles/namei.c                              |   4 +-
 fs/exec.c                                          |   2 +-
 fs/exfat/iomap.c                                   |   5 +-
 fs/fat/dir.c                                       |  44 +++++-
 fs/fhandle.c                                       |   2 +-
 fs/freevxfs/vxfs_bmap.c                            |   3 +-
 fs/fuse/file.c                                     |  14 +-
 fs/iomap/bio.c                                     |  15 +-
 fs/iomap/buffered-io.c                             |  16 +-
 fs/iomap/direct-io.c                               |   7 +-
 fs/iomap/ioend.c                                   |   8 +-
 fs/minix/minix.h                                   |   2 +-
 fs/namei.c                                         |   4 +
 fs/netfs/buffered_read.c                           |   2 +-
 fs/netfs/buffered_write.c                          |   2 +-
 fs/netfs/direct_write.c                            |  18 +--
 fs/netfs/internal.h                                |  12 ++
 fs/netfs/locking.c                                 |  95 ++++++++++++
 fs/netfs/read_retry.c                              |   7 +-
 fs/netfs/write_collect.c                           |  10 ++
 fs/netfs/write_issue.c                             |  55 +++----
 fs/netfs/write_retry.c                             |   7 +-
 fs/ntfs/aops.c                                     |   6 +-
 fs/ntfs3/inode.c                                   |   5 +-
 fs/orangefs/dir.c                                  |   7 +-
 fs/overlayfs/copy_up.c                             |  12 +-
 fs/overlayfs/inode.c                               |   4 +-
 fs/proc/generic.c                                  |   9 +-
 fs/xfs/xfs_aops.c                                  |   3 +-
 fs/xfs/xfs_super.c                                 |   3 +
 include/linux/iomap.h                              |   2 +
 include/linux/netfs.h                              |  13 +-
 lib/iov_iter.c                                     |  20 ++-
 lib/scatterlist.c                                  |   1 +
 lib/tests/kunit_iov_iter.c                         |   5 +-
 tools/testing/selftests/filesystems/.gitignore     |   1 +
 tools/testing/selftests/filesystems/Makefile       |   4 +
 .../selftests/filesystems/idmapped_tmpfile.c       | 168 +++++++++++++++++++++
 52 files changed, 592 insertions(+), 178 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/idmapped_tmpfile.c
