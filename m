Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4C43934B;
	Fri, 14 Aug 2026 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713221; cv=none; b=LcQflVSd9zJpCtQiUvtudLYDIKzE+uFK2oeOfoksgKZSdnqx9mw9aznbNp+r+W4cIRGRPjQugq1IhvzA4o1YFxcEsEoOXBwuwBzbZjcklCQ3tlcuur/YAu6jEaua2Ws2LsyRHCaUrOvHEA2P+t9hgNV6hAONzZeb0YJXBYqTRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713221; c=relaxed/simple;
	bh=+4fJmQF1kbazrdxXDQKrqkCjAZ6K3eCKhfy5A5R5N9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzTFW2AWKxsO2owNO03ck6svd8dDWHFtkUq751KzN+wqKe7iX5wsRMYFwAulS+Op/I3dYXEqbdauFrsJD/ivPbEJM5GOUaFi5PHTuw4eTpSb3dMoSiJygEVutT1LUJn1+WZFci5/cXdW5BVfsK5eSoUrX3ZJvrE9jmdK1G6ztow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv+jVUgJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv+jVUgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A697A1F000E9;
	Fri, 14 Aug 2026 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713219;
	bh=zKXfa0zQKqf2bvKVddlOj3K6JNUPcAlljEqhdxCIxZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nv+jVUgJmVVkNA3FLLaBVN20n5Qdlq87E7HPvIO3cIFUjgmFMbtAZjPbFybDaSuy+
	 cJHD0y2SsG4apTFFwoNDuyBo8Jthq+kxAmAKDExoTE9AzGfWW1B1H686lUGJySQllU
	 b1EzIi1DgkMIKppHJQbDTh0mJDBBjzXE8/x5GbspahJdcg6p977ycgOHzDS/nGbdoB
	 7sLkgDlxSd0NtyEJ86dTvqsen0fUGk3rvFBAdo0imTqo3h4xsIhk53l77pVeRoo3eM
	 HXzqA504Gq3lgLgHeto++aRsR36tIKFnS+7JO04ehr9FjfL2uqcI9/bCvAwHWMQ4Mp
	 7BkQ+dlqpde/A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 12/18 for v7.3] vfs misc
Date: Fri, 14 Aug 2026 15:13:26 +0200
Message-ID: <20260814-vfs-7.3-rc1.misc-abaa1db7ff94@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13783; i=brauner@kernel.org; h=from:subject:message-id; bh=+4fJmQF1kbazrdxXDQKrqkCjAZ6K3eCKhfy5A5R5N9U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi9R8N0vkSMpp5qizyOtkY/8ox7E7T2X3Hq2rh1lXN QmodMd2lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATOSMFCPDEZEotmtdrDECllOm uQvs0nFZ8rC0fPoPv/k3xL0eaQj9Zfgfudj1zfKSH9+YLLRu80+y1Pi194DSvFuus9hOa1w8+W4 dJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

- The lockref dead-count handling is tidied up. The open-coded check for
  a count below zero as the dead marker relies on information the caller should
  not have.

- make put_mnt_ns() leave mounts connected. Destroying a mount namespace
  disconnected its mounts from their mount points. So a file descriptor still
  open on the parent of a mount point could be used to peek under it.

  Locked mounts were already kept connected to prevent exactly that. But a
  mount is only locked when its tree is copied across a user namespace
  boundary. So a mount namespace set up by a privileged component had no locked
  mounts and its mounts were disconnected. Passing UMOUNT_CONNECTED keeps every
  mount connected and prevents that bug.

- vfs_prepare_mode() passes S_IFDIR for directories. I meant to fix that ago
  but didn't get to it. So now someone finally did it. That kills the exception
  where the could be 0 when a directory was created whereas every other
  creation operation passed it explicitly already.

- move long delayed work for ufs, jffs2, hfsplus, hfs and affs from the
  per-cpu system_long_wq to the new unbound system_dfl_long_wq. None of that
  work relies on per-cpu state and the work item is enqueued with
  queue_delayed_work() whose timer is global anyway. So it may as well benefit
  from scheduler task placement.

/* Smaller fixes and cleanups */

- unlock_buffer() and journal_end_buffer_io_sync() use clear_and_wake_up_bit()

- the pipe page pools are unified into a single per-pipe pool and the extra
  wake_up(rd_wait) is limited to EPOLLET consumers

- eventpoll now computes its timer slack lazily in ep_poll()

- shrink_dcache_for_umount() keeps making progress on busy roots

- excess xarray nodes are freed in clear_inode()

- romfs detects hard link cycles

- the user path of nested backing files is fixed

- pidfd holds exec_update_lock around the namespace ioctl

- non-memcg-aware nr_cached_objects is skipped during memcg slab shrink

- iomap_write_iter() always returns status

- mangle_path() is renamed to seq_mangle_path()

- inode timestamp accessors are annotated

- new regression test for pipe->poll_usage. 

- a few documentation, kernel-doc and selftest fixes

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

[1]: https://lore.kernel.org/linux-next/amnyXEARrAoFoPAj@sirena.org.uk

This conflicts with the gfs2 tree in two places. Both are caused by
commit 91e27ed8a387c ("lockref: tidy up dead count handling") from
this tree, which renames __lockref_is_dead() to lockref_is_dead() and
converts all callers, including the ones in gfs2.

The first conflict is in fs/gfs2/glock.c against commit da26828b82a45
("gfs2: Remove the glock lru list and shrinker"). Reported in [1].

[2]: https://lore.kernel.org/linux-next/an208OpVMNEI2Zfo@sirena.org.uk

The second conflict is in fs/gfs2/lock_dlm.c against commit
657e5af4fe0b9 ("gfs2: harden gfs2_glock_hold").

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.misc

for you to fetch changes up to dcacab904fe78d60840ba947a104993ee9ded887:

  selftests/namespaces: Fix racy pipe handshake in timens and pidns_separate (2026-08-13 12:20:42 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.misc

Please consider pulling these changes from the signed vfs-7.3-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Agatha Isabelle Moreira (2):
      fs: buffer: use clear_and_wake_up_bit() in unlock_buffer()
      fs: jbd2: use clear_and_wake_up_bit() in journal_end_buffer_io_sync()

Amin Vakil (1):
      selftests: proc: include fcntl.h in proc-pidns

Baokun Li (1):
      fs: fix user path of nested backing files

Ben Dooks (1):
      fs: nullfs should include mount.h

Breno Leitao (1):
      fs/pipe: unify the page pools into a single per-pipe pool

Brian Foster (1):
      iomap: always return status from iomap_write_iter

Chen Linxuan (1):
      pidfd: hold exec_update_lock around namespace ioctl

Christian Brauner (5):
      Merge patch series "fs: refactor code to use clear_and_wake_up_bit()"
      Merge patch series "vfs: pass S_IFDIR mode to vfs_prepare_mode()"
      Merge patch series "fs: Move long delayed work on system_dfl_long_wq"
      Merge patch series "put_mnt_ns(): leave mounts connected"
      Merge patch series "lockref tidy ups + touch ups to it's usage by dcache"

Jann Horn (1):
      fs: document semantics of kstat::{uid,gid} fields

Johannes Berg (1):
      seq_file: rename mangle_path to seq_mangle_path

Jori Koolstra (31):
      vfs: pass S_IFDIR mode to vfs_prepare_mode()
      9p: drop redundant S_IFDIR from mkdir
      affs: drop redundant S_IFDIR from mkdir
      afs: drop redundant S_IFDIR from mkdir
      autofs: drop redundant S_IFDIR from mkdir
      btrfs: drop redundant S_IFDIR from mkdir
      ceph: drop redundant S_IFDIR from mkdir
      ext2: drop redundant S_IFDIR from mkdir
      ext4: drop redundant S_IFDIR from mkdir
      f2fs: drop redundant S_IFDIR from mkdir
      gfs2: drop redundant S_IFDIR from mkdir
      hfs: drop redundant S_IFDIR from mkdir
      hfsplus: drop redundant S_IFDIR from mkdir
      hpfs: drop redundant S_IFDIR from mkdir
      hugetlbfs: drop redundant S_IFDIR from mkdir
      jffs2: drop redundant S_IFDIR from mkdir
      jfs: drop redundant S_IFDIR from mkdir
      minix: drop redundant S_IFDIR from mkdir
      nilfs2: drop redundant S_IFDIR from mkdir
      ntfs3: drop redundant S_IFDIR from mkdir
      ocfs2: drop redundant S_IFDIR from mkdir
      ocfs2: dlmfs: drop redundant S_IFDIR from mkdir
      omfs: drop redundant S_IFDIR from mkdir
      orangefs: drop redundant S_IFDIR from mkdir
      ramfs: drop redundant S_IFDIR from mkdir
      udf: drop redundant S_IFDIR from mkdir
      ufs: drop redundant S_IFDIR from mkdir
      nfs: drop redundant S_IFDIR from mkdir
      ubifs: drop redundant S_IFDIR from mkdir
      xfs: drop redundant S_IFDIR from mkdir
      ntfs: drop redundant S_IFDIR from mkdir

Karl Mehltretter (1):
      dcache: keep shrink_dcache_for_umount() making progress on busy roots

Luis Henriques (1):
      posix_acl: remove useless code

Malaya Kumar Rout (1):
      selftests/statmount: Fix file descriptor leak in setup_namespace

Manush Prajwal (1):
      fs: fix switch/case indentation in sysfs() syscall

Marco Crivellari (5):
      ufs: Move long delayed work on system_dfl_long_wq
      fs/jffs2: Move long delayed work on system_dfl_long_wq
      hfsplus: Move long delayed work on system_dfl_long_wq
      hfs: Move long delayed work on system_dfl_long_wq
      affs: Move long delayed work on system_dfl_long_wq

Mateusz Guzik (2):
      lockref: tidy up dead count handling
      dcache: use lockref routines for dead count checks

Matthew Wilcox (Oracle) (1):
      fs: Free any excess xarray nodes in clear_inode()

Noah Orlando (2):
      put_mnt_ns(): leave mounts connected
      selftests/filesystems: add mntns cleanup test

Oleg Nesterov (2):
      pipe: only enable the extra wake_up(rd_wait) for EPOLLET consumers
      selftests/epoll: add a regression test for pipe->poll_usage

Randy Dunlap (1):
      nstree: add/fix struct ns_id_req kernel-doc member fields

Ricardo B. Marlière (SUSE) (1):
      selftests/namespaces: Fix racy pipe handshake in timens and pidns_separate

Shivank Sharma (1):
      initramfs: fix typo in reserve_initrd_mem comment

Usama Arif (2):
      fs/super: skip non-memcg-aware nr_cached_objects in memcg slab shrink
      eventpoll: compute timer slack lazily in ep_poll()

Wang Yan (1):
      selftests/filesystems: fix spelling error in statmount test comment

Yichong Chen (1):
      fs: remove stale inode_insert5() kernel-doc parameter

Yu Peng (1):
      fs: annotate inode timestamp accessors

Yuhong Cheng (1):
      docs: filesystems: porting: fix spelling of returned and instead

이상호 (1):
      romfs: detect hard link cycles

 Documentation/filesystems/porting.rst              |   2 +-
 fs/9p/vfs_inode.c                                  |   2 +-
 fs/9p/vfs_inode_dotl.c                             |   1 -
 fs/affs/namei.c                                    |   2 +-
 fs/affs/super.c                                    |   2 +-
 fs/afs/dir.c                                       |   2 +-
 fs/autofs/root.c                                   |   2 +-
 fs/backing-file.c                                  |   2 +-
 fs/btrfs/inode.c                                   |   2 +-
 fs/ceph/dir.c                                      |   3 +-
 fs/coda/dir.c                                      |   7 +-
 fs/dcache.c                                        |  23 ++-
 fs/erofs/zdata.c                                   |   4 +-
 fs/eventpoll.c                                     |   6 +-
 fs/ext2/namei.c                                    |   2 +-
 fs/ext4/namei.c                                    |   2 +-
 fs/f2fs/namei.c                                    |   2 +-
 fs/filesystems.c                                   |  18 +-
 fs/fuse/dir.c                                      |   8 +
 fs/gfs2/glock.c                                    |   6 +-
 fs/gfs2/inode.c                                    |   2 +-
 fs/gfs2/lock_dlm.c                                 |   6 +-
 fs/gfs2/quota.c                                    |   4 +-
 fs/hfs/dir.c                                       |   2 +-
 fs/hfs/super.c                                     |   2 +-
 fs/hfsplus/dir.c                                   |   2 +-
 fs/hfsplus/super.c                                 |   2 +-
 fs/hpfs/namei.c                                    |   4 +-
 fs/hugetlbfs/inode.c                               |   2 +-
 fs/inode.c                                         |  42 ++---
 fs/iomap/buffered-io.c                             |   4 +-
 fs/jffs2/dir.c                                     |   2 -
 fs/jffs2/wbuf.c                                    |   2 +-
 fs/jfs/namei.c                                     |   2 +-
 fs/minix/namei.c                                   |   2 +-
 fs/namei.c                                         |   7 +-
 fs/namespace.c                                     |   2 +-
 fs/nfs/dir.c                                       |   2 +-
 fs/nilfs2/namei.c                                  |   2 +-
 fs/ntfs/namei.c                                    |   2 +-
 fs/ntfs3/namei.c                                   |   2 +-
 fs/nullfs.c                                        |   2 +
 fs/ocfs2/dlmfs/dlmfs.c                             |   2 +-
 fs/ocfs2/namei.c                                   |   2 +-
 fs/omfs/dir.c                                      |   2 +-
 fs/orangefs/namei.c                                |   2 +-
 fs/pidfs.c                                         |  43 +++--
 fs/pipe.c                                          | 191 ++++++++++-----------
 fs/posix_acl.c                                     |   2 -
 fs/ramfs/inode.c                                   |   2 +-
 fs/romfs/super.c                                   |   8 +
 fs/seq_file.c                                      |  11 +-
 fs/smb/client/inode.c                              |   7 +
 fs/stat.c                                          |   2 +-
 fs/super.c                                         |  19 +-
 fs/ubifs/dir.c                                     |   2 +-
 fs/udf/namei.c                                     |   2 +-
 fs/ufs/namei.c                                     |   2 +-
 fs/ufs/super.c                                     |   2 +-
 fs/xfs/xfs_buf.c                                   |   4 +-
 fs/xfs/xfs_iops.c                                  |   2 +-
 fs/xfs/xfs_qm.c                                    |   4 +-
 include/linux/fs.h                                 |  20 +--
 include/linux/lockref.h                            |  12 +-
 include/linux/pipe_fs_i.h                          |  26 ++-
 include/linux/seq_file.h                           |   2 +-
 include/linux/stat.h                               |   4 +-
 include/uapi/linux/nsfs.h                          |   7 +-
 init/initramfs.c                                   |   2 +-
 lib/lockref.c                                      |   2 +-
 lib/seq_buf.c                                      |   2 +-
 tools/testing/selftests/Makefile                   |   1 +
 .../filesystems/epoll/epoll_wakeup_test.c          |  23 +++
 .../selftests/filesystems/mntns_cleanup/.gitignore |   2 +
 .../selftests/filesystems/mntns_cleanup/Makefile   |   6 +
 .../filesystems/mntns_cleanup/mntns_cleanup_test.c |  58 +++++++
 .../filesystems/statmount/statmount_test.c         |   5 +-
 tools/testing/selftests/namespaces/nsid_test.c     |   4 -
 tools/testing/selftests/proc/proc-pidns.c          |   1 +
 79 files changed, 419 insertions(+), 266 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/mntns_cleanup/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/mntns_cleanup/Makefile
 create mode 100644 tools/testing/selftests/filesystems/mntns_cleanup/mntns_cleanup_test.c
