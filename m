Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EF375ACB;
	Fri, 16 Oct 2026 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146476; cv=none; b=QiqHWzD1AkhbNsonn4iVD4J0yDnHBO0ZvqdhY6PyWLgBssjqShcU90HtOnnsgePmRRVho3bUvP4uYUdyuJd9igWx0x52X8iS79uAL+LJauZwvIm2EwimRQSJDkV+joM8mEStri74QJ6fMJRUb8+JARVfz+cCU7D+aLYKR86wQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146476; c=relaxed/simple;
	bh=EgTKb5AMVHJ+BR5EyeBgRqL1TqgF1IHocQPi6ygcHK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=So5c+e74jFLmmve26T5YUHOr9CZTpOdVpJh58Fm0nO1zdES6M0Gyo8L1eZ1ZBNGvyI/nJvCaWBnQqY1A2YtELBtamVJSHq9oAJYBmBxdzCmRFznytky09BVed+vfsPIKXgzvOyT8M8S0ieOBIK+OWrSKyVetCD18nvWc11j4U/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgTb/ALU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgTb/ALU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E024C1F000C4;
	Fri, 16 Oct 2026 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146475;
	bh=RxdbxU6xVAPUHbvfbqgDHbHG2mvTfQPnDG1dpU7wbSM=;
	h=From:To:Cc:Subject:Date;
	b=BgTb/ALUfRrxMW7fBCcThtsk90GNT9Vh2tjmi2tLMf++heQtAYV3hUQ5TQ+tK68yR
	 qtp0YWh6bAAVrabsRsySO74Q1X5McfIKVoA6uf82DWrGb2pMyhuhVYFXoiKuGYDh+O
	 1+l+5NFOSGK4N8GyLqo1Bw8+gmoHSXJIAm7adRyu+5b56Gkfv00/p5eBR7Qji6eNEW
	 mIV4wmY1s5sINQS1MkFXH/io3+GIUsMgNNBuzoS9GLq34ij4Na9ydExTo05VvTHMVV
	 joDu+BAn6oi/ZNrgyz2RbYwJdvkalyopyO79MqH6db+4baV5dmWD9C2gTEUIjNyE8b
	 D2trD3nUKGDoA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.3] vfs fixes
Date: Fri, 16 Oct 2026 12:27:37 +0200
Message-ID: <20261016-vfs-7.3-rc8.fixes-c224354747ab@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9296; i=brauner@kernel.org; h=from:subject:message-id; bh=EgTKb5AMVHJ+BR5EyeBgRqL1TqgF1IHocQPi6ygcHK0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/CMrHT6jYUr9vDNLMqeWuAs46PRF3XPTkpwrp9ven 1EdtmN5RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERs7zH84XYLEWeMOWEZyTyF e8uMZNkUg5Bz6ZJVr+tOxZ62nHblLCPDnS+LHlvabHJ9Vy2V+c03z5q1lqsl++VMH8PfWnumcZe wAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains last fixes for the current development cycle:

- Fix a range of use-after-frees during rcu pathwalk caused by non-rcu
  frees. Whatever ->permission(), ->d_revalidate(), ->get_link(),
  ->d_hash() and ->d_compare() read in rcu mode has to be freed after a
  grace period. umount(2) hides most of it because namespace_unlock()
  waits for one, but a chdir() out of a lazily unmounted directory or
  the close() of the last file on it drops the last reference without.

  * ext4_get_link() reads the sbi and the extent status counters for a
    symlink stored in a data block. Both are freed after a grace period
    now.

  * The unicode map of casefolded ext4, f2fs and tmpfs was freed under
    generic_ci_d_hash() and generic_ci_d_compare().

  * ntfs3 with nocase freed its sbi and mount options under its dentry
    hash and compare. A remount freed the old options right away too.

  * eventfs freed an eventfs_inode after an SRCU grace period only
    while tracefs_d_revalidate() reads it under rcu_read_lock().

  * afs and 9p are only saved by the grace period their private bdi
    gets in bdi_unregister(). They stop depending on it.

  * create_ipc_ns() leaked the mqueue mount and its superblock on a
    late failure. A long-term mount needs kern_unmount().

- Don't let idle threads pin the initramfs. The idle threads of the
  secondary cpus are forked from PID 1 with a private copy of its
  fs_struct, aren't on the task list so pivot_root() never moves them
  and never exit. So the initramfs stayed pinned forever on every
  machine with more than one cpu, 70 to 150 MB in the reports. They
  share init_fs now like init_task does.

- A mount that copy_tree() leaves out can't take over a lock.
  copy_tree() drops mounts of mount namespace files from the copies it
  makes for unshare(CLONE_NEWNS) and propagation without looking at
  MNT_LOCKED. So root in a user namespace could bind a child's
  /proc/<pid>/ns/mnt beneath a locked cover, let it take the lock over,
  unshare(CLONE_NEWNS) and read the file. copy_tree() refuses with
  EPERM now and the move beneath a locked mount is refused up front.

- Revert "namei: don't reveal overmounted entries in refwalk" from the
  rc7 fixes. The bug class is bigger than that patch.

- namei: lookup_fast_for_open() checked ->d_inode while
  traverse_mounts() checks the type in d_flags, which is set second, so
  a refwalk racing the instantiation could fail an O_CREAT open with
  ENOENT. Use d_is_negative() in both places.

- Drop the smp_mb()s in mntput_no_expire_slowpath() and do_umount()
  that mnt_get_count()'s own barrier made redundant.

- fsnotify: a mark added while fsnotify_destroy_marks() walks the
  connector could be missed and the connector detached, so an fdinfo
  read called igrab(NULL). New marks are refused during teardown.

- pipe: a failed second fasync enable on an O_RDWR FIFO removed the
  existing reader entry and cleared FASYNC while the writer entry
  stayed, a use-after-free in send_sigio() later.

- watch_queue: post_one_notification() could see nr_notes before the
  note pool behind it and dereference a NULL array. An unprivileged
  user can trigger that with a key watch. Publish nr_notes last.

- pid_namespace: zap_pid_ns_processes() waits without bound for a
  tracer outside the namespace to reap its zombies and neither wait
  was freezable, so every suspend attempt failed.

- exit: is_child_subreaper and has_child_subreaper shared a word with
  other bitfields written without a common lock, so racing prctl()s
  lost a bit. They are separate bools now.

- autofs: a notification write that failed on a pipe the daemon had
  already replaced put the superblock into catatonic mode again and
  closed the replacement. Only do that for the current pipe.

- ovl: reject a lowerdir ending with an unescaped backslash with EINVAL
  instead of a confusing ENOENT later.

- ocfs2/dlm: take dlm_reco_state_lock when the debugfs state file walks
  the recovery participant list.

- samples/pidfd: fix the userprogs typo that kept pidfd-metadata from
  being built.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc8.fixes

for you to fetch changes up to 214897acc8c2e5d6b63189d23ccaed6fa2af45a9:

  Revert "namei: don't reveal overmounted entries in refwalk" (2026-10-16 10:50:57 +0200)

----------------------------------------------------------------
vfs-7.3-rc8.fixes

Please consider pulling these changes from the signed vfs-7.3-rc8.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Aviv Vaknin (1):
      pid_namespace: make zap_pid_ns_processes() freezable

Cen Zhang (1):
      ocfs2/dlm: Protect the recovery list during debugfs reads

Cen Zhang (Microsoft) (1):
      watch_queue: Fix note pool publication race in watch_queue_set_size()

Christian Brauner (19):
      ext4: free the sbi after a grace period
      afs: free the super info after a grace period
      9p: free the session after a grace period
      eventfs: free the eventfs_inode after an rcu grace period too
      ipc: drop the mqueue mount with kern_unmount() on setup failure
      unicode: free the map after a grace period
      ntfs3: free the sbi after a grace period
      ntfs3: free replaced mount options after a grace period
      Merge patch series "fs: fix a range of UAFs during rcu pathwalk caused by non-rcu frees"
      fs: drop the smp_mb()s that mnt_get_count() made redundant
      Merge patch series "fs: drop the smp_mb()s that mnt_get_count() made redundant"
      fs: pass flags to copy_fs()
      namei: test for a negative dentry the way traverse_mounts() does
      namespace: a mount that copy_tree() leaves out can't take over a lock
      fs: let idle threads share init_fs
      selftests/filesystems: test that a mntns file can't take over a lock
      Merge patch series "fs: don't let idle threads pin the initramfs"
      Merge patch series "namespace: a mount that copy_tree() leaves out can't take over a lock"
      Revert "namei: don't reveal overmounted entries in refwalk"

Guanglei Zhu (1):
      ovl: reject lowerdir ending with unescaped backslash

Kyle Zeng (2):
      pipe: preserve existing fasync readers on writer setup failure
      fsnotify: prevent mark additions during connector teardown

Nickolai Zeldovich (1):
      exit: fix lost-update race on the child_subreaper bitfields

Sasha Levin (1):
      samples: pidfd: fix userprogs typo

Sung Byeongchan (1):
      autofs: ignore notification errors from a replaced pipe

 fs/9p/v9fs.h                                       |   1 +
 fs/9p/vfs_super.c                                  |   4 +-
 fs/afs/internal.h                                  |   2 +
 fs/afs/super.c                                     |   2 +-
 fs/autofs/waitq.c                                  |  25 ++++-
 fs/ext4/ext4.h                                     |   2 +
 fs/ext4/extents-test.c                             |   2 +
 fs/ext4/extents.c                                  |   1 +
 fs/ext4/extents_status.c                           |   7 +-
 fs/ext4/extents_status.h                           |   1 +
 fs/ext4/super.c                                    |  13 ++-
 fs/namei.c                                         |  32 +-----
 fs/namespace.c                                     |  33 ++++--
 fs/notify/mark.c                                   |  11 ++
 fs/ntfs3/dir.c                                     |  13 ++-
 fs/ntfs3/ntfs_fs.h                                 |   3 +
 fs/ntfs3/super.c                                   |  49 ++++++---
 fs/ocfs2/dlm/dlmcommon.h                           |   2 +
 fs/ocfs2/dlm/dlmdebug.c                            |   5 +-
 fs/ocfs2/dlm/dlmrecovery.c                         |   2 +-
 fs/overlayfs/params.c                              |   3 +
 fs/pipe.c                                          |   6 +-
 fs/tracefs/event_inode.c                           |  10 +-
 fs/unicode/utf8-core.c                             |  21 +++-
 include/linux/fsnotify_backend.h                   |   1 +
 include/linux/sched/signal.h                       |   4 +-
 include/linux/unicode.h                            |   1 +
 ipc/namespace.c                                    |   2 +-
 kernel/exit.c                                      |   2 +-
 kernel/fork.c                                      |  20 +++-
 kernel/pid_namespace.c                             |   2 +-
 kernel/watch_queue.c                               |  11 +-
 samples/pidfd/Makefile                             |   2 +-
 .../umount_propagation/locked_mount_test.c         | 122 +++++++++++++++++++++
 34 files changed, 325 insertions(+), 92 deletions(-)
