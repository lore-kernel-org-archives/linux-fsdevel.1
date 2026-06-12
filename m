Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B125B083;
	Fri, 12 Jun 2026 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277368; cv=none; b=JF83l0BdYUnd2Yzwfrq1ZvPBIxrstvKyC3nH61zI8poZKYuxm12vVnUzp7l0Jj5cz1mxawHfAaVLken7/9OdxH8h0lh7vac5X1NG8g9n5NbtY60CUkreYFtHwzZtaVa3Rz0mFD+ispWcFYtxLs/lkldekINDOAQFvQvBBmX7oPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277368; c=relaxed/simple;
	bh=oOk82uF7BHbAr8DmzFTXqPMcL/BJs/zd1IyL6x/5gAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVNNP6VrVLLYkFKBDOEMR1kvkeSkCNClbzN8ZwoNq7oSq7so2yajcqJASpHxjXiDUSVsUjWcjwf9QtnU9Dm5TSFvluV+1nzmsX4rZfRynnFAkfIYxJLJAHRp/egSKToe6nwDxG2/cGpgfuidHdoBtNaCuebO7TsN3LVmNO3rTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxxpTYfk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxxpTYfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963EC1F000E9;
	Fri, 12 Jun 2026 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277366;
	bh=KYpn4OwosbLWk+ytjnwWRyJSM8cp1r6gLxVvIM6hKpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GxxpTYfkXsWodjJ3OPwurJVUoKUVl02QRCcPWg8LkAAknsh4uA95Vo2Xmay4bNCPV
	 eIPaTsGlqWIedsVe2fdY1hxXMKzdvDtPI6CDwFhYscnvDoQfapdlj1V5w3bMsWY4Po
	 F/9XOhISpE52NREkCH6nMxLHUR9JkzLBv7vCsI6F/s3MkmbhBtdOQYwskSv2v46cxC
	 gdHlRFN6IbY/B6t9o3xKkGz0n5mS+qxKbLJuuko9BYCB0bb6nEmW+bAIcwO36gzps9
	 gFdlaPuCTh+mENb2MlU4nrVdpNowEnkcnx1855lPWfcWw/inF/s8/+dvMOWMysq0HK
	 VssvvdbU0bYrw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 15/16 for v7.2] vfs misc
Date: Fri, 12 Jun 2026 17:16:01 +0200
Message-ID: <20260612-vfs-misc-v72-13d57389d260@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18599; i=brauner@kernel.org; h=from:subject:message-id; bh=oOk82uF7BHbAr8DmzFTXqPMcL/BJs/zd1IyL6x/5gAo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKG061v2qUOaOX51Rsq6IgaKNxir5L2WnMl+f+Gbno Ncu5GbWUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHFeoY/PCwTIz6ZHs3bY7dz 6e41voU/zt+Yvf+x84vHGi+2JH2pNmVkODuB5aS27o9NhwU39+dpRe5cbXN1iaPHi6U2JpXMp11 0uAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Features

- Reduce pipe->mutex contention by pre-allocating pages outside the
  lock in anon_pipe_write().

  anon_pipe_write() called alloc_page() once per page while holding
  pipe->mutex. The allocation can sleep doing direct reclaim and runs
  memcg charging, which extends the critical section and stalls any
  concurrent reader on the same mutex. Now up to 8 pages are
  pre-allocated before the mutex is taken, leftovers are recycled into
  the per-pipe tmp_page[] cache before unlock, and any remainder is
  released after unlock, keeping the allocator out of the critical
  section on both sides. On a writers x readers sweep with 64KB writes
  against a 1 MB pipe throughput improves 6-28% and average write
  latency drops 5-22%; under memory pressure - when the cost of
  holding the mutex across reclaim is highest - throughput improves
  21-48% and latency drops 17-33%. The microbenchmark is added to
  selftests.

- uaccess/sockptr: fix the ignored_trailing logic in
  copy_struct_to_user() to behave as documented and the usize check in
  copy_struct_from_sockptr() for user pointers, and add
  copy_struct_{from,to}_bounce_buffer() and copy_struct_to_sockptr()
  helpers for upcoming users (IPPROTO_SMBDIRECT, IPPROTO_QUIC).

- bpf: add a sleepable bpf_real_inode() kfunc that resolves the real
  inode backing a dentry via d_real_inode(). On overlayfs the inode
  attached to the dentry doesn't carry the underlying device
  information; this is used by the filesystem restriction BPF program
  that was merged into systemd.

- docs: add guidelines for submitting new filesystems, motivated by
  the maintenance burden abandoned and untestable filesystems impose
  on VFS developers, blocking infrastructure work like folio
  conversions and iomap migration.

Fixes

- libfs: set SB_I_NOEXEC and SB_I_NODEV by default in init_pseudo()
  and drop the now-redundant assignments in callers. This began as a
  one-line dma-buf fix for a path_noexec() warning; a pseudo
  filesystem has no reason not to set SB_I_NOEXEC. All init_pseudo()
  callers were audited: the only visible effect is on dma-buf where
  SB_I_NOEXEC silences the warning.

- Handle set_blocksize() failures in legacy filesystems (bfs, hpfs,
  qnx4, jfs, befs, affs, isofs, minix, ntfs3, omfs). Mounting a device
  with a sector size > PAGE_SIZE crashed roughly half of them; the
  rest had the same missing error handling pattern. Plus a follow-up
  releasing the superblock buffer_head when setting the minix v3 block
  size fails.

- mount: honour SB_NOUSER in the new mount API.

- fs/fcntl: fix a SOFTIRQ-unsafe lock order in fasync signaling by
  switching the process-group paths of send_sigio() and send_sigurg()
  from read_lock(&tasklist_lock) to RCU, matching the single-PID path.

- vfs: add an FS_USERNS_DELEGATABLE flag and set it for NFS, fixing
  delegated NFS mounts (fsopen() in a container with the mount
  performed by a privileged daemon) that broke when non-init s_user_ns
  was tied to FS_USERNS_MOUNT.

- selftests/namespaces: fix a hang in nsid_test where an unreaped
  grandchild kept the TAP pipe write-end open, a waitpid(-1) race in
  listns_efault_test, and a false FAIL on kernels without listns()
  where the tests should SKIP.

- filelock: fix the break_lease() stub signature for
  CONFIG_FILE_LOCKING=n.

- init/initramfs_test: wait for the async initramfs unpacking before
  running; the test and do_populate_rootfs() share the parser state.

- fs/coredump: reduce redundant log noise in
  validate_coredump_safety().

- iomap: pass the correct length to fserror_report_io() in
  __iomap_write_begin().

- backing-file: fix the backing_file_open() kerneldoc.

Cleanups

- initramfs: refactor the cpio hex header parsing to use hex2bin()
  instead of the hand-rolled simple_strntoul() which is reverted, and
  extend the initramfs KUnit tests to cover header fields with 0x
  prefixes.

- Replace __get_free_pages() and friends with kmalloc()/kzalloc()
  across quota, proc, ocfs2/dlm, nilfs2, nfs, nfsd, libfs, jfs, jbd2,
  isofs, fuse, select, namespace, configfs, binfmt_misc, bfs, and the
  do_mounts init code - part of the larger work of replacing page
  allocator calls with kmalloc().

- Use clear_and_wake_up_bit() in unlock_buffer() and
  journal_end_buffer_io_sync() instead of open-coding the sequence.

- Drop unused VFS exports: unexport drop_super_exclusive(), remove
  start_removing_user_path_at(), and fold __start_removing_path() into
  start_removing_path().

- fs/read_write: narrow the __kernel_write() export with
  EXPORT_SYMBOL_FOR_MODULES().

- vfs: uapi: retire octal and hex constants in favor of (1 << n) for
  the O_ flags. Finding a free bit for a new flag across the
  architectures was needlessly hard with the mixed bases.

- dcache: add extra sanity checks of dead dentries in dentry_free()
  via a new DENTRY_WARN_ONCE() that also prints d_flags.

- iov_iter: use kmemdup_array() in dup_iter() to harden the allocation
  against multiplication overflow.

- fs/pipe: write to ->poll_usage only once.

- vfs: remove an always-taken if-branch in find_next_fd().

- dcache: use kmalloc_flex() for struct external_name in __d_alloc().

- namei: use QSTR() instead of QSTR_INIT() in path_pts().

- sync_file_range: delete dead S_ISLNK code.

- Comment fixes: retire a stale comment in fget_task_next() and fix
  assorted spelling mistakes.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This has a merge conflict with the ext4 tree in fs/jbd2/journal.c
between commit bbe9015f23432b ("jbd2: remove special jbd2 slabs") from
the ext4 tree and commit 2f6702dc6fdcf0 ("jbd2: replace
__get_free_pages() with kmalloc()") from this tree. The change in this
tree is a subset of the ext4 tree's commit, so the conflict can be
resolved by taking the ext4 side. Reported in [1].

It was suggested in [2] to drop the patch from this tree. But the
patch is part of the merged "fs: replace __get_free_pages() call with
kmalloc()" series with a dozen commits on top of it, so dropping it
would have meant rewriting the whole branch after it had been exposed
in linux-next. Since the change is a strict subset of the ext4 commit,
taking the ext4 side during the merge yields the identical end result.

[1]: https://lore.kernel.org/linux-next/aiq8CByJNMlXo6Be@sirena.co.uk
[2]: https://lore.kernel.org/linux-next/airBGjtjTf3Yuy0X@casper.infradead.org

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.misc

for you to fetch changes up to aa5c4fe3ba0cb2af90bbcfa7a8ef4fefcd5c2370:

  backing-file: fix backing_file_open() kerneldoc parameter (2026-06-10 09:49:25 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.misc

Please consider pulling these changes from the signed vfs-7.2-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Agatha Isabelle Moreira (2):
      fs: buffer: use clear_and_wake_up_bit() in unlock_buffer()
      fs: jbd2: use clear_and_wake_up_bit() in journal_end_buffer_io_sync()

Al Viro (1):
      mount: honour SB_NOUSER in the new mount API

Alexey Dobriyan (1):
      sync_file_range: delete dead S_ISLNK code

Amir Goldstein (1):
      docs: add guidelines for submitting new filesystems

Andy Shevchenko (5):
      initramfs: Sort headers alphabetically
      initramfs: Refactor to use hex2bin() instead of custom approach
      vsprintf: Revert "add simple_strntoul"
      kstrtox: Drop extern keyword in the simple_strtox() declarations
      fs/read_write: Do not export __kernel_write() to the entire world

Breno Leitao (2):
      fs/pipe: pre-allocate pages outside pipe->mutex in anon_pipe_write
      selftests/pipe: add pipe_bench microbenchmark

Christian Brauner (11):
      Merge patch series "uaccess/sockptr: copy_struct_ fixes and more helpers"
      Merge patch series "selftests/namespaces: Fix test hangs and false failures"
      Merge patch series "initramfs: test and improve cpio hex header validation"
      Merge patch series "drop unused VFS exports"
      Merge patch series "fix crashes when mounting legacy file system with sector size > PAGE_SIZE"
      Merge patch series "fs: refactor code to use clear_and_wake_up_bit()"
      Merge patch series "fs: replace __get_free_pages() call with kmalloc()"
      Merge patch series "fs/pipe: reduce pipe->mutex contention by pre-allocating outside the lock"
      Merge patch series "libfs: set SB_I_NOEXEC and SB_I_NODEV in init_pseudo()"
      bpf: add bpf_real_inode() kfunc
      filelock: fix break_lease() stub signature for CONFIG_FILE_LOCKING=n

Christoph Hellwig (15):
      fs: unexport drop_super_exclusive
      fs: remove start_removing_user_path_at
      fs: fold __start_removing_path into start_removing_path
      bfs: handle set_blocksize failures
      hpfs: handle set_blocksize failures
      qnx4: handle set_blocksize failures
      jfs: handle set_blocksize failures
      befs: handle set_blocksize failures
      affs: handle set_blocksize failures
      isofs: handle set_blocksize failures
      minix: handle set_blocksize failures
      ntfs3: handle set_blocksize failures
      omfs: handle set_blocksize failures
      minix: release the sb buffer_head when setting the v3 block size fails
      iomap: pass the correct len to fserror_report_io in __iomap_write_begin

David Disseldorp (2):
      initramfs_test: add fill_cpio() inject_ox parameter
      initramfs_test: test header fields with 0x hex prefix

Jeff Layton (2):
      dcache: add extra sanity checks of the dentry in dentry_free()
      vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS

Jia He (1):
      init/initramfs_test: wait_for_initramfs() before running

John Hubbard (2):
      libfs: set SB_I_NOEXEC and SB_I_NODEV by default in init_pseudo()
      libfs: drop redundant SB_I_NOEXEC/SB_I_NODEV in init_pseudo() callers

Jori Koolstra (2):
      vfs: remove always taken if-branch in find_next_fd()
      vfs: uapi: retire octal and hex numbers in favor of (1 << n) for O_ flags

Li RongQing (1):
      fs/coredump: reduce redundant log noise in validate_coredump_safety

Li Wang (1):
      backing-file: fix backing_file_open() kerneldoc parameter

Mateusz Guzik (2):
      fs/pipe: write to ->poll_usage only once
      fs: retire stale comment in fget_task_next()

Mike Rapoport (Microsoft) (18):
      init: do_mounts: use kmalloc() for allocations of temporary buffers
      quota: allocate dquot_hash with kmalloc()
      proc: replace __get_free_page() with kmalloc()
      ocfs2/dlm: replace __get_free_page() with kmalloc()
      nilfs2: replace get_zeroed_page() with kzalloc()
      NFS: replace __get_free_page() with kmalloc() in nfs_show_devname()
      NFS: remove unused page and page2 in nfs4_replace_transport()
      NFSD: replace __get_free_page() with kmalloc() in nfsd_buffered_readdir()
      libfs: simple_transaction_get(): replace get_zeroed_page() with kzalloc()
      jfs: replace __get_free_page() with kmalloc()
      jbd2: replace __get_free_pages() with kmalloc()
      isofs: replace __get_free_page() with kmalloc()
      fuse: replace __get_free_page() with kmalloc()
      fs/select: replace __get_free_page() with kmalloc()
      fs/namespace: use __getname() to allocate mntpath buffer
      configfs: replace __get_free_pages() with kzalloc()
      binfmt_misc: replace __get_free_page() with kmalloc()
      bfs: replace get_zeroed_page() with kzalloc()

Mingyu Wang (1):
      fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling

Qingshuang Fu (1):
      fs: fix spelling mistakes in comment

Ricardo B. Marlière (3):
      selftests/namespaces: Kill grandchild in nsid fixture teardown
      selftests/namespaces: Fix waitpid race in listns_efault_test cleanup
      selftests/namespaces: Skip efault tests when listns() is not available

Stefan Metzmacher (5):
      uaccess: fix ignored_trailing logic in copy_struct_to_user()
      sockptr: fix usize check in copy_struct_from_sockptr() for user pointers
      uaccess: add copy_struct_{from,to}_bounce_buffer() helpers
      sockptr: let copy_struct_from_sockptr() use copy_struct_from_bounce_buffer()
      sockptr: introduce copy_struct_to_sockptr()

Thorsten Blum (2):
      dcache: use kmalloc_flex() in __d_alloc
      namei: use QSTR() instead of QSTR_INIT() in path_pts

Wang Haoran (1):
      iov_iter: use kmemdup_array for dup_iter to harden against overflow

 .../filesystems/adding-new-filesystems.rst         | 195 +++++++
 Documentation/filesystems/index.rst                |   1 +
 Documentation/filesystems/porting.rst              |   1 -
 arch/alpha/include/uapi/asm/fcntl.h                |  34 +-
 arch/arm/include/uapi/asm/fcntl.h                  |   8 +-
 arch/arm64/include/uapi/asm/fcntl.h                |   8 +-
 arch/m68k/include/uapi/asm/fcntl.h                 |   8 +-
 arch/mips/include/uapi/asm/fcntl.h                 |  22 +-
 arch/parisc/include/uapi/asm/fcntl.h               |  28 +-
 arch/powerpc/include/uapi/asm/fcntl.h              |   8 +-
 arch/sparc/include/uapi/asm/fcntl.h                |  34 +-
 fs/affs/affs.h                                     |   5 -
 fs/affs/super.c                                    |   6 +-
 fs/aio.c                                           |   1 -
 fs/anon_inodes.c                                   |   2 -
 fs/backing-file.c                                  |  13 +-
 fs/befs/linuxvfs.c                                 |   3 +-
 fs/bfs/inode.c                                     |   7 +-
 fs/binfmt_misc.c                                   |   4 +-
 fs/bpf_fs_kfuncs.c                                 |  16 +
 fs/buffer.c                                        |   4 +-
 fs/configfs/file.c                                 |   7 +-
 fs/coredump.c                                      |   3 +-
 fs/dcache.c                                        |  18 +-
 fs/exec.c                                          |   6 +-
 fs/fcntl.c                                         |   8 +-
 fs/file.c                                          |  18 +-
 fs/file_table.c                                    |   4 +-
 fs/fuse/ioctl.c                                    |   5 +-
 fs/hpfs/super.c                                    |   3 +-
 fs/iomap/buffered-io.c                             |   2 +-
 fs/isofs/dir.c                                     |   5 +-
 fs/isofs/inode.c                                   |   3 +-
 fs/jbd2/commit.c                                   |   4 +-
 fs/jbd2/journal.c                                  |   7 +-
 fs/jfs/jfs_dtree.c                                 |  16 +-
 fs/jfs/super.c                                     |   3 +-
 fs/libfs.c                                         |   7 +-
 fs/minix/inode.c                                   |   3 +-
 fs/namei.c                                         |  25 +-
 fs/namespace.c                                     |  11 +-
 fs/nfs/fs_context.c                                |   8 +-
 fs/nfs/nfs4namespace.c                             |  15 +-
 fs/nfs/super.c                                     |   4 +-
 fs/nfsd/vfs.c                                      |   4 +-
 fs/nilfs2/ioctl.c                                  |   4 +-
 fs/nsfs.c                                          |   1 -
 fs/ntfs3/super.c                                   |   8 +-
 fs/ocfs2/dlm/dlmdebug.c                            |  24 +-
 fs/ocfs2/dlm/dlmdomain.c                           |   8 +-
 fs/ocfs2/dlm/dlmmaster.c                           |   5 +-
 fs/ocfs2/dlm/dlmrecovery.c                         |   4 +-
 fs/omfs/inode.c                                    |   6 +-
 fs/pidfs.c                                         |   2 -
 fs/pipe.c                                          | 106 +++-
 fs/proc/base.c                                     |  16 +-
 fs/qnx4/inode.c                                    |   3 +-
 fs/quota/dquot.c                                   |  11 +-
 fs/read_write.c                                    |   5 +-
 fs/select.c                                        |   4 +-
 fs/super.c                                         |  12 +-
 fs/sync.c                                          |   3 +-
 include/linux/filelock.h                           |   2 +-
 include/linux/fs.h                                 |   1 +
 include/linux/kstrtox.h                            |   9 +-
 include/linux/namei.h                              |   1 -
 include/linux/sockptr.h                            |  28 +-
 include/linux/uaccess.h                            |  65 ++-
 include/uapi/asm-generic/fcntl.h                   |  50 +-
 init/do_mounts.c                                   |  21 +-
 init/initramfs.c                                   |  68 ++-
 init/initramfs_test.c                              |  97 +++-
 lib/iov_iter.c                                     |   8 +-
 lib/vsprintf.c                                     |   7 -
 mm/secretmem.c                                     |   2 -
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/namespaces/listns_efault_test.c      |  33 +-
 tools/testing/selftests/namespaces/nsid_test.c     |  14 +-
 tools/testing/selftests/pipe/.gitignore            |   1 +
 tools/testing/selftests/pipe/Makefile              |   9 +
 tools/testing/selftests/pipe/pipe_bench.c          | 616 +++++++++++++++++++++
 virt/kvm/guest_memfd.c                             |   2 -
 82 files changed, 1464 insertions(+), 390 deletions(-)
 create mode 100644 Documentation/filesystems/adding-new-filesystems.rst
 create mode 100644 tools/testing/selftests/pipe/.gitignore
 create mode 100644 tools/testing/selftests/pipe/Makefile
 create mode 100644 tools/testing/selftests/pipe/pipe_bench.c
