Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC83EE1FD;
	Fri, 16 Oct 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146259; cv=none; b=g31fPNcJU3LLEbedNGVZoT204mNxtCFWBdVfo0r1BIjdXy+D8gI5n/fukoXo2FA4m5icwq+SMpBYgVVlkECdrli/eSrjY2WH7rD8vlDdAbdfBMtNrczWPyJIXDqSSdwAiGv17vmrIzNi6hBZrUTuDTVu98jsLHwW2lEnIVt9GBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146259; c=relaxed/simple;
	bh=OOLQTFgRbWSGzbbrsLXuxrdKToo0E9T353rxPlPRxng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VG3AMdE29HybATWMhRcBS1aV2lRaaDhzCmfGj/2rpHF05INdooG7dMeC1fIr03N+9Zr+lG+3rr0Wy44hqcfI0JLuLXyUiMROyLl0x+Z0LAimbdUZQvnOfA6nepXbTfcPFYWEr5Z87FhfkPlN6PBsriWwC419hIAg/uEKUtZDzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA+6o2Qp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA+6o2Qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B101F000C4;
	Fri, 16 Oct 2026 10:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146257;
	bh=Y2vZApD0hFg9CWPibYCTBIK60BbhdtEDwCq4bfOYBLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IA+6o2QphWvTUOvT8CP1zIbu/746OIi/FQcSGWOsCdJ+nncM6pwNJKVeex3eRpT9i
	 qVdHQA+5HvOv0MqJxk8rDir64mjUF6UixFAP7maRI1qXttc7tVeOCNsdl34Y2Y7SmT
	 /CzY/Ohjgd3oIAILhkO3RVIMbhAdD4sx3Idrk1J09avnYxYg6+vPJrMs9/tC+uxkp6
	 HdLmWySe3heeV7DSmdwV2cVovqBjSa/2KK37L45TbsKdGfVRiOA6d7no2e9Pnnx2vY
	 Vb2Bq4xIyE4j2L86wMn0M95X5BD83Q5XfBNFsP3voO2NX+YXDTx8732/Poim1QNHbU
	 uMpJpFWH9xMYg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 14/19 for v7.4] vfs misc
Date: Fri, 16 Oct 2026 12:23:48 +0200
Message-ID: <20261016-vfs-7.4-rc1.misc-4e00f3bd0c83@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13427; i=brauner@kernel.org; h=from:subject:message-id; bh=OOLQTFgRbWSGzbbrsLXuxrdKToo0E9T353rxPlPRxng=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/O3i1c3wVnGhqGt98N2js24tObPc5UjZ34UV/p6dv a/Drwdpd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkeTIjw5bZ6aK/3He67RZY +d686GVUr/XhSLVJyWbFSw/Gbf+8+Asjw/l7GfKf2GRXBtne/9iw60P+Ps6PTg/sFEqmTwzS4Wh dzQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Fixes

- aio: a keyed poll completion on an epoll instance could recurse into
  the same epoll waitqueue lock when the result eventfd is watched by
  that very instance. An unprivileged process could make a CPU spin on
  the recursive lock. eventfd-backed poll completions are always
  deferred now.

- fsnotify_inoderemove() is only called once the inode is really dead,
  no nlink and no aliases, and open_by_handle_at() can't add an alias
  to a dead inode anymore. The race could crash fsnotify or lose inode
  mark notifications.

- devtmpfs: the conversion of the public instance to ->get_tree() broke
  reconfiguring the shared superblock's options on later mounts which
  made the boot time defaults permanent. A reconfigure context is kept
  in fc->fs_private so the parse ops can forward options to the
  underlying filesystem.

- ufs truncated the 64-bit directory size to an unsigned int in
  ufs_last_byte(). A crafted image with a 4 GiB directory produced an
  out-of-folio read in ufs_find_entry() and, with CONFIG_UFS_FS_WRITE,
  a write into an adjacent page.

- devpts rejects max=0 instead of silently lifting the per-instance pty
  limit. The value wrapped into ida_alloc_max() and became unlimited.

- fs_pin publishes pins with the rcu list helpers so the kill paths
  reading the lists under rcu see the initialization.

- dentry_kill() reports a Tasks-RCU quiescent state. Its cond_resched()
  is the only reschedule point on the dentry teardown path and
  cond_resched() isn't a quiescent state for Tasks-RCU, so Meta kept
  seeing rcu_tasks stalls in btrfs subvolume deletion.

- writeback sizes foreign flushes by the target wb's dirty pages instead
  of the memcg-wide count which over or undersized a single bdi flush.

- nfsd READ emitted two fsnotify access events on the iterator path
  since vfs_iocb_iter_read() already sends one. A READ on a krb5i or
  krb5p mount showed up twice in inotify.

- pipe and splice pass a poll key when waking readers and writers so
  epoll, poll() and select() waiters only wake for the event they asked
  for.

- the iso8859-14 Unicode to charset tables had page01 duplicated as
  page1e so 29 code points mapped to the wrong bytes and 22 that aren't
  in the charset were accepted.

- orangefs doesn't wait for an unmount service operation that never
  returns on system shutdown and uses ssize_t for strscpy() errors.

- __register_chrdev() checks the kobject_set_name() return value.

- selftest fixes: the openat2 tests hardcoded O_LARGEFILE to 0x8000
  which is O_NOFOLLOW on powerpc, resolve_test makes /tmp a mountpoint
  so RESOLVE_NO_XDEV has a boundary to trip over, file_stressor moves
  into its own directory with a 30 minute timeout, the kernfs listxattr
  test skips when SELinux exposes security.selinux, the namespaces
  active reference tests wait for the thread via a PIDFD_THREAD pidfd
  since pthread_join() returns before exit_nsproxy_namespaces(), the
  idmapped_tmpfile test chowns its directory into the mapped range, the
  clone3 CLONE_CLEAR_SIGHAND test adds CLONE_VM so it fails for the
  intended reason, the pidfd PPID error message prints the values it
  compares and fscontext_ns gets a .gitignore.

Cleanups

- vmcore prints the release of the crashed kernel from the VMCOREINFO
  note so a kdump that dies before the dump lands still says which
  kernel it was for.

- initramfs allocates hardlink hash entries with the validated cpio
  name length instead of PATH_MAX, which put every entry in kmalloc-8k.

- the unused dax_layout_busy_page() is removed,
  dax_layout_busy_page_range() becomes static and dax_folio_init()
  drops a redundant list initialization.

- vfs_empty_path() is removed, it has had no callers since
  getname_maybe_null().

- comment and documentation fixes in aio, bpf_fs_kfuncs, fs-writeback,
  inode, read_write, squashfs and the vfs.rst copy of struct
  file_system_type.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This conflicts with mainline in tools/testing/selftests/Makefile and
tools/testing/selftests/filesystems/Makefile between commits
d59ac79915daa ("selftests/filesystems: fix missing and stale TARGETS
entries") and 66cda7ec9abec ("selftests/filesystems: check that an
immutable inode takes no write hint") in mainline and commit
5550456dad376 ("selftests/filesystems: Move file_stressor to dedicated
subdirectory") from this tree:

diff --cc tools/testing/selftests/Makefile
index bc4fdb6f5337,08f228765a93..000000000000
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@@ -35,11 -35,9 +35,12 @@@ TARGETS += fchmodat
  TARGETS += filesystems
  TARGETS += filesystems/binderfs
  TARGETS += filesystems/epoll
 +TARGETS += filesystems/eventfd
  TARGETS += filesystems/failfs
  TARGETS += filesystems/fat
+ TARGETS += filesystems/file_stressor
 +TARGETS += filesystems/openat2
 +TARGETS += filesystems/open_tree_ns
  TARGETS += filesystems/overlayfs
  TARGETS += filesystems/statmount
  TARGETS += filesystems/mount-notify
diff --cc tools/testing/selftests/filesystems/Makefile
index 93e2cc9123b0,bc4bfb677589..000000000000
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@@ -1,7 -1,7 +1,7 @@@
  # SPDX-License-Identifier: GPL-2.0
  
  CFLAGS += $(KHDR_INCLUDES)
- TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog ustat_test rw_hint_test
 -TEST_GEN_PROGS := devpts_pts anon_inode_test kernfs_test fclog ustat_test
++TEST_GEN_PROGS := devpts_pts anon_inode_test kernfs_test fclog ustat_test rw_hint_test
  TEST_GEN_PROGS += idmapped_tmpfile
  TEST_GEN_PROGS_EXTENDED := dnotify_test
  

It also conflicts with the vfs-7.4-rc1.coredump tag in fs/coredump.c
between commit 3aa5ebec7895c ("coredump: describe the holes when
COREDUMP_SPARSE is negotiated") from that tag and commit 21a62663d4734
("fs: fix typos in comments") from this tag. The coredump tag is merged
before this one. The typo fix touches a comment the coredump tag
rewrites, so the coredump tag's version of the comment wins.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.misc

for you to fetch changes up to 9ba6627ef6b12debd1c54443939718db63234274:

  selftests/filesystems: Fix idmapped_tmpfile layer dir ownership (2026-10-12 11:24:28 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.misc

Please consider pulling these changes from the signed vfs-7.4-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Ali Ahmet Memiş (1):
      nls: fix the Unicode to charset tables of iso8859-14

Amir Goldstein (1):
      fs: make sure to call fsnotify_inoderemove() only once when inode is dead

Bjoern Doebel (1):
      selftests/filesystems: Fix idmapped_tmpfile layer dir ownership

Breno Leitao (4):
      pipe: pass a poll key when waking writers after a resize
      splice: pass a poll key when waking pipe readers and writers
      vmcore: report the release of the crashed kernel
      dcache: report a Tasks-RCU quiescent state in dentry_kill()

Christian Brauner (3):
      Merge patch series "selftests/filesystems: selftest fixes"
      Merge patch series "fs/dax: Clean up busy page lookup helpers"
      Merge patch series "selftests/filesystems/openat2: fix O_LARGEFILE definitions for non-arm64 architectures"

Chuck Lever (1):
      splice: emit a single fsnotify access event per NFSD READ

Daehyeon Ko (1):
      aio: prevent eventfd/epoll recursion on poll

Disha Goel (4):
      selftests/filesystems: Move file_stressor to dedicated subdirectory
      selftests/filesystems: skip listxattr kernfs test if xattrs are present
      selftests/filesystems/openat2: fix O_LARGEFILE definitions for non-arm64 architectures
      selftests/filesystems/openat2: make /tmp a mountpoint inside private namespace

Eric Sandeen (1):
      devtmpfs: restore mount option reconfiguration on get_tree

Hemanth Selam (1):
      fs: fix typos in comments

Kaitao Cheng (3):
      fs/dax: Remove redundant deferred list initialization
      fs/dax: Remove unused dax_layout_busy_page()
      fs/dax: Make dax_layout_busy_page_range() static

Karl Mehltretter (2):
      fs_pin: publish pins with RCU list helpers
      docs/vfs: Fix the struct file_system_type copy

Mahad Ibrahim (1):
      selftests/filesystems: Add .gitignore for fscontext_ns_test

Manush Prajwal (3):
      fs: fix comment typo in bpf_fs_kfuncs.c
      fs: fix comment typo in fs-writeback.c
      fs: fix comment typo in inode.c

Mark Sercombe (1):
      fs/aio: fix comment typos

Mike Marshall (2):
      orangefs_super: don't wait on service operation on system shutdown.
      orangefs: use ssize_t instead of size_t for error codes...

Paul Dolan (2):
      selftests/clone3: tighten CLONE_CLEAR_SIGHAND conflict test
      selftests/pidfd: fix PPID values in error message

Ray Lee (1):
      squashfs: fix inode number description in documentation

Ricardo B. Marlière (SUSE) (1):
      selftests/namespaces: Wait for thread exit via pidfd in active-ref tests

Sang-Heon Jeon (1):
      fs: remove unused vfs_empty_path()

Tao Cui (1):
      devpts: reject max=0 instead of silently lifting the limit

Thorsten Blum (1):
      initramfs: Reduce hardlink hash allocation sizes

Xin Yin (1):
      writeback: size foreign flushes by target wb dirty pages

YANXIN LI (1):
      ufs: use u64 for directory size in ufs_last_byte

Yingchao Deng (1):
      fs: fix misleading comments in read_write.c

bui duc phuc (1):
      chardev: check return value of kobject_set_name() in __register_chrdev()

 Documentation/filesystems/squashfs.rst             |   6 +-
 Documentation/filesystems/vfs.rst                  |   2 +-
 drivers/base/devtmpfs.c                            | 108 ++++++++++++---------
 fs/aio.c                                           |  11 ++-
 fs/bpf_fs_kfuncs.c                                 |   4 +-
 fs/char_dev.c                                      |   4 +-
 fs/coredump.c                                      |   2 +-
 fs/dax.c                                           |  26 ++---
 fs/dcache.c                                        |  29 +++++-
 fs/devpts/inode.c                                  |   2 +
 fs/fs-writeback.c                                  |  23 ++---
 fs/fs_pin.c                                        |   9 +-
 fs/inode.c                                         |   2 +-
 fs/namespace.c                                     |   2 +-
 fs/nfsd/vfs.c                                      |  13 +--
 fs/nls/nls_iso8859-14.c                            |  26 +++--
 fs/orangefs/orangefs-debugfs.c                     |  10 +-
 fs/orangefs/super.c                                |  18 ++++
 fs/pipe.c                                          |   2 +-
 fs/proc/vmcore.c                                   |  20 ++++
 fs/read_write.c                                    |   8 +-
 fs/splice.c                                        |  70 +++++++++----
 fs/ufs/dir.c                                       |   2 +-
 include/linux/dax.h                                |  12 ---
 include/linux/fs.h                                 |  19 +---
 include/linux/splice.h                             |   4 +-
 include/uapi/linux/fs.h                            |   2 +-
 init/initramfs.c                                   |  11 ++-
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/clone3/clone3_clear_sighand.c        |   6 +-
 tools/testing/selftests/filesystems/.gitignore     |   1 -
 tools/testing/selftests/filesystems/Makefile       |   2 +-
 .../selftests/filesystems/file_stressor/.gitignore |   2 +
 .../selftests/filesystems/file_stressor/Makefile   |   6 ++
 .../{ => file_stressor}/file_stressor.c            |   0
 .../selftests/filesystems/file_stressor/settings   |   3 +
 .../selftests/filesystems/fscontext_ns/.gitignore  |   2 +
 .../selftests/filesystems/idmapped_tmpfile.c       |   7 ++
 tools/testing/selftests/filesystems/kernfs_test.c  |  16 ++-
 .../selftests/filesystems/openat2/openat2_test.c   |  10 +-
 .../selftests/filesystems/openat2/resolve_test.c   |   7 +-
 .../selftests/namespaces/ns_active_ref_test.c      |  29 ++++++
 tools/testing/selftests/pidfd/pidfd_open_test.c    |   2 +-
 43 files changed, 340 insertions(+), 201 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/file_stressor/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/file_stressor/Makefile
 rename tools/testing/selftests/filesystems/{ => file_stressor}/file_stressor.c (100%)
 create mode 100644 tools/testing/selftests/filesystems/file_stressor/settings
 create mode 100644 tools/testing/selftests/filesystems/fscontext_ns/.gitignore
