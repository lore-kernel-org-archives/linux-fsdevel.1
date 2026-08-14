Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD02E739E;
	Fri, 14 Aug 2026 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713190; cv=none; b=Ik1wWvMcdFFaSOXr2OONnEqBxB2rQUwibGCxWmKDJX6/oY9RbKCq2cartFksfiCuz9iS1adHzskHEdLA2xsxQ2VS2E5JtCSLzX8ZYgEC66jN7USNPIDScj1F2YiNQRMZqhNoq6vH611lSLkwxDZgYWRpbATAieOaNQHsCtwvrm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713190; c=relaxed/simple;
	bh=Cg23cxJHLqwCFG9+BzqSSrMdiT/akD1HegXX0otbzUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qxp6Y4MHQsfSm6aaSNK7RdDY2Pni2OoBtvDwyjTrpxKsz41x26gCkeokeDhHqi2JDv/1s6Q7QKvSQ5zI+f6+PnVO1giJNpObM4Lg0dByiB/3suOsMky7bwqn5UdPrwVU+ONJddZv5lksGJykzSkLF70ZfZNDUdh2m3jL8kyXqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzkrSMRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzkrSMRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF5A1F000E9;
	Fri, 14 Aug 2026 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713188;
	bh=qp84ZngsE3lt+KQRSgF0dkrU7EQuuG/J+AH4D5j4LkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VzkrSMRpIriwBlrgBiKhFmkp31ERYS4H0XvGbNKxfN5xQTqpwyAiGoEJ6cf7Ye1wm
	 u/As2yr4HUnzwImmEYHVWTmocTufogSFShuUwJ5EqX4ccYYCbNlY9kuYpeg04y4p5D
	 ttr76Ae1TR7FeD32DhPrWIwik3SE9n+qN0hmFqojBmvOqfMpbHCY/DpeuVlyjUr1Tq
	 PVeu2IPvk+Plc+BDl3dptJUM90f9lOqRROOfYxD0IvGm8UenXZhBLYvBmJCw67supO
	 w2jPzZX/G3ksGdPyj5qjbwossOysxuQVqJmMeu1dLL6rYYCOXHaqhFC63VdZB7QIGg
	 QEK4Jew9YRjIA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 10/18 for v7.3] vfs kthread
Date: Fri, 14 Aug 2026 15:12:59 +0200
Message-ID: <20260814-vfs-7.3-rc1.kthread-f4580c1bc853@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5674; i=brauner@kernel.org; h=from:subject:message-id; bh=Cg23cxJHLqwCFG9+BzqSSrMdiT/akD1HegXX0otbzUQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi8RP/mwz8/y6gGZp1Q2B06w3Vtuwpnvl5q32/B3sJ nZrtfvWjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl8sGNkmP3lD4+R5MvtrfuS vylI7+Xol4pfX75Fa9reZW++6h3fr8nIsEB5XvvRU9Z63rNc2Q+XZ/bss9FZ4XCzdSIz+/7Vqoz 8/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This stops kernel threads from sharing filesystem state with userspace.
This work is about 3 cycles old and has been in -next for about that
time.

When the kernel boots init_task creates PID 1 and then kthreadd. From
that point every kthread and PID 1 share the same fs_struct. That is why
pivot_root() has to rewrite the fs_struct of all kthreads. The rewriting
exists so that kthreads can use init's filesystem state when they want
to. It also means userspace can move the ground out from under the
kernel.

PID 1 now gets a completely separate fs_struct. All kthreads are
anchored in a private SB_KERNMOUNT instance of nullfs that cannot be
mounted on and cannot be used to follow other mounts. Userspace init
can no longer affect kthread filesystem state and kthreads can no
longer affect userspace fs state without explicit opting in to that.

Path lookup from a kthread now fails by default. It makes it
deliberately hard to offload security sensitive operations into init's
filesystem state from a kthread.

Places that legitimately need to look something up there opt in through
the new scoped_with_init_fs() which temporarily overrides the caller's
fs_struct with init's. usermodehelpers remain the only kernel tasks that
genuinely share init's filesystem state, since they execute random
binaries in the root filesystem (excellent...).

The visible result is that /proc/2/root is a nullfs with an empty
mountinfo while /proc/1/root is the real root.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.kthread

for you to fetch changes up to b4343aebd3a4dd255b15b2e5b1363d6399da302f:

  initramfs_test: use test init/exit hooks to override init fs (2026-07-31 12:56:51 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.kthread

Please consider pulling these changes from the signed vfs-7.3-rc1.kthread tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (27):
      fs: add switch_fs_struct()
      fs: notice when init abandons fs sharing
      fs: add scoped_with_init_fs()
      fs: add real_fs to track task's actual fs_struct
      fs: make userspace_init_fs a dynamically-initialized pointer
      rnbd: use scoped_with_init_fs() for block device open
      crypto: ccp: use scoped_with_init_fs() for SEV file access
      scsi: target: use scoped_with_init_fs() for ALUA metadata
      scsi: target: use scoped_with_init_fs() for APTPL metadata
      btrfs: use scoped_with_init_fs() for update_dev_time()
      coredump: use scoped_with_init_fs() for coredump path resolution
      fs: use scoped_with_init_fs() for kernel_read_file_from_path_initns()
      ksmbd: use scoped_with_init_fs() for share path resolution
      ksmbd: use scoped_with_init_fs() for filesystem info path lookup
      ksmbd: use scoped_with_init_fs() for VFS path operations
      pnfs/blocklayout: use scoped_with_init_fs() for SCSI device lookup
      initramfs: use scoped_with_init_fs() for rootfs unpacking
      af_unix: use scoped_with_init_fs() for coredump socket lookup
      fs: stop sharing fs_struct between init_task and pid 1
      fs: add umh argument to struct kernel_clone_args
      devtmpfs: create private mount namespace
      nullfs: make nullfs multi-instance
      fs: start all kthreads in nullfs
      fs: stop rewriting kthread fs structs
      fs: stop rewriting paths for PF_EXITING | PF_DUMPCORE
      Merge patch series "fs,kthread: start all kthreads in nullfs"
      initramfs_test: use test init/exit hooks to override init fs

 drivers/base/devtmpfs.c           |   2 +-
 drivers/block/rnbd/rnbd-srv.c     |   4 +-
 drivers/char/misc_minor_kunit.c   |  25 +++++----
 drivers/crypto/ccp/sev-dev.c      |  12 ++---
 drivers/target/target_core_alua.c |  11 +++-
 drivers/target/target_core_pr.c   |   4 +-
 fs/btrfs/volumes.c                |  11 +++-
 fs/coredump.c                     |  11 ++--
 fs/fs_struct.c                    | 103 ++++++++++++++++++++++++++++++++++++--
 fs/kernel_read_file.c             |   9 +---
 fs/namespace.c                    |  16 +++---
 fs/nfs/blocklayout/dev.c          |  15 ++++--
 fs/nullfs.c                       |  12 ++---
 fs/proc/array.c                   |   4 +-
 fs/proc/base.c                    |   8 +--
 fs/proc_namespace.c               |   4 +-
 fs/smb/server/mgmt/share_config.c |   4 +-
 fs/smb/server/smb2pdu.c           |   4 +-
 fs/smb/server/vfs.c               |   9 ++--
 include/linux/fs_struct.h         |  34 +++++++++++++
 include/linux/init_task.h         |   1 +
 include/linux/sched.h             |   1 +
 include/linux/sched/task.h        |   1 +
 init/init_task.c                  |   1 +
 init/initramfs.c                  |  14 ++++--
 init/initramfs_test.c             |  19 ++++++-
 init/main.c                       |  10 +++-
 kernel/fork.c                     |  53 ++++++++++++--------
 kernel/kcmp.c                     |   2 +-
 kernel/umh.c                      |   6 +--
 net/unix/af_unix.c                |  17 +++----
 31 files changed, 311 insertions(+), 116 deletions(-)
