Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380837;
	b=OahkTGit0tWJpyqMDxrtT1HYqaQILIsVudvvmdjyxtgoYL315pcMYWxtwIRPH35pFLzk
	 BeoBwEYhUrREGLjRHI4MSaa0zphQIoLXTp9r6ySwn2Y3YFdyshB71iBp4HYsGg5NAWNcv
	 cuxii2qsa5og3ZFC8KyOY73dI4Jo3uaqjQgGDA56kX3kI+yJ1/5gtXoZV19rRMSam/YkF
	 mswF3spMeNv5zNbbTwY4bckDZr1QH1dj8EPjuC6ngJhwxIDRmO3tCsUsCAAzFcwTuVAlU
	 ku5CIksJZhl9rsNvBNKsfoNQaWB05M6bvZq5uuDSm/WZAewx2SZ3HFOORLGyI9tu21w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380837;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=GbsNLN4nfmecZngIyVjXGY/OgjisXLgIAFbK+bDay40=;
	b=Q200KLJZDS82LfAOi5axvTtz2vetebwsEwoUMf5zf//7Azm8zYwZsF5XDgS4kMWAzoKt
	 3oZKSzWyMI7czG4RYmEtlMPcE8z8hWR/jfprn1dL2Y4OxDuRCY43gD6OED50EfTMENh0s
	 f0xLvMYjqhnXMgT1Ay+RvsA6JqWv9I/EACsY6f3fHhCYBLI1x1T0RDhVSBCs+8QQpMXlp
	 rrctUgZZEKGZKR1+crfkQMEFP6zSU+0erU4ULsALQY+YmqujeKb1o0Qo9QXa5IcBMnR3r
	 2uY//sBeQHXUoRU2QugkSy3gqXgS4AKeYceEPqrdlO5juZfONY5kirVJ+Jz4S2v5/cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ai68jmAc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2D606A31A;
	Fri, 30 Oct 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ai68jmAc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844A81F000C1;
	Fri, 30 Oct 2026 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380836;
	bh=GbsNLN4nfmecZngIyVjXGY/OgjisXLgIAFbK+bDay40=;
	h=From:To:Cc:Subject:Date;
	b=Ai68jmAcsGR3R4yuAmGN8na3m1UHUEfVlUVHoKW5oJOZjthoMCQoSthFsmWyG2Xc2
	 Rzl+qINxfBSJdOvohOvTximqmIZxlZLPWBqMKN5Z7vo+lRSmEQxtIWWgfxvTXJTiWi
	 Zw2p3abMwHM09cLRZiay5DzsXNonbBk3CXS77M/tzI7RSogcLB+TJg6YZ6oMbghYuY
	 L3oOJhhfFMEYITywSjTrKIiUxUmz/P5fzulYGNzykiJEXgM2+GXN88qszjauR0yPHQ
	 2smSwB5PUb9L7RRzc2Fvpb6KqqhYvKPmw/uBMcOb8NEe0qHA2BHXG/uhhNRr6y0Kmu
	 OvnFdD3Q+Dukw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.4] vfs fixes
Date: Fri, 30 Oct 2026 18:20:21 +0100
Message-ID: <20261030-vfs-7.4-rc1.fixes-92f660b23a8a@brauner>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20441; i=brauner@kernel.org; h=from:subject:message-id; bh=Nv4CqPVU9hkel5IUyOxd1XjMaL4tjUy1BYtRbcPA4Ec=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9uXjD6dnsY11Tzl2xTJmgxcMdlf81uuTVmZIoqUk7o uZXvGJV6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIKkdGhoadi+Zd+/jlRbYg 4w+hqo/hKx/unFzgMO8q210ZId3l/OyMDAdyXENX2N0rWS/mHN66dLb76br3W5aGF1n7hbUeubL 0ITsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

As is the new normal, this is larger set of fixes for this cycle. I have
a bunch of fixes in the pipeline but no need to delay the current set
any longer than necessary.

/* Summary */

- writeback:

  * Update dirtied_when instead of dirtied_time_when when a wb switch
    puts an inode at the newest end of the target b_dirty list. The list
    was left out of order so move_expired_inodes() could stop before
    older inodes, and the lazytime expiration timestamp was reset.

  * Clear the old wb's dirty-I/O state and bandwidth contribution when a
    batch of inode switches leaves its dirty lists empty. An empty wb
    stayed scheduled for periodic writeback and inflated
    bdi->tot_write_bandwidth.

  * Take wb_switch_rwsem across the inode scan of
    cleanup_offline_cgwb(). The v7.3-rc5 fix that rotates scanned inodes
    let a scan racing a sync()'s queue_io() move lazytime inodes past
    the sync's cutoff, so sync() returned without persisting their
    timestamps.

  * Don't kick writeback for an IOCB_DONTCACHE write on an inode that
    has no wb yet. With cgroup writeback an O_DIRECT RWF_DONTCACHE write
    to a block device dereferenced NULL.

- statmount/listmount/listns:

  * Refuse statmount() string requests with a buffer that isn't larger
    than struct statmount.

  * Don't wrap around with a U64_MAX cursor in listmount() and listns().

  * Don't end listns() at an inactive namespace.

  * Only add init_ipc_ns and init_net to the namespace trees if
    CONFIG_IPC_NS and CONFIG_NET_NS are enabled.

- iomap:

  * Only mark blocks uptodate in __iomap_write_begin() after reading
    them and let __iomap_write_end() mark the zeroed blocks uptodate
    once the copy from userspace succeeded.

  * Check a chunk against max_integrity_io_size() on its own before the
    bio size check.

  * Only enforce block alignment for direct I/O into holes and
    unwritten extents if IOMAP_DIO_FSBLOCK_ALIGNED is set.

- backing-file:

  * Check S_APPEND and S_IMMUTABLE on the backing inode. FUSE
    passthrough opens the backing file with vfs_open() which skips
    may_open(), so anyone who may open the FUSE file for writing could
    overwrite an append-only backing file anywhere or write to an
    immutable one. Open, mmap and writes now check the backing inode
    the way may_open() and do_mmap() do.

  * Always call kiocb_end_write() for a queued write

  * Let backing files inherit FMODE_NONOTIFY from the user file. The
    event fds fanotify creates for permission events on a stacked
    filesystem raised FS_OPEN_PERM on the real path from inside the
    listener's read() and deadlocked listeners with marks on both
    layers.

- pidfs:

  * Look the task up before checking for exit information in
    PIDFD_GET_INFO and start over if the task no longer owns the pid
    once all fields have been read. A caller racing release_task() got
    neither PIDFD_INFO_PID nor PIDFD_INFO_EXIT or ESRCH although the
    exit information was available, and a caller racing a sub-thread's
    exec reported that thread's tid as the pid.

  * Clear the mask bits of fields that lie beyond the struct size the
    caller passed. The uapi header promises that the mask names no such
    field but a caller passing PIDFD_INFO_SIZE_VER0 got the coredump and
    supported mask bits set for fields that were never written.

- aio:

  * Give the aio ring a ->read_folio that fails with EIO so a fault on a
    ring whose file was truncated gets SIGBUS instead of jumping to
    NULL.

  * Check nr_events against the ring size before doubling it in
    ioctx_alloc().

- splice:

  * Only write back an implicit file position in do_splice() when the
    splice helper succeeded. splice doesn't take f_pos_lock so a failed
    splice restored a stale snapshot over a position that a concurrent
    getdents() had moved. On ext2 the next readdir then trusted an
    offset inside a directory entry.

  * Retry tee() when the input pipe was emptied or the output pipe
    filled between the prep steps and link_pipe() instead of returning 0
    while the input pipe still has writers, as splice_pipe_to_pipe()
    does.

- ucount:

  * Take the reference that pins a ucounts level on the 0 -> 1
    transition before checking the rlimit.

  * Read the parent ucounts before dropping the rlimit count in
    do_dec_rlimit_put_ucounts().

- inode:

  * Rotate inodes whose page cache couldn't be dropped to the tail of
    the LRU.

  * Skip inodes that another LRU walker is isolating.

- setns:

  * Set nsset->flags before anything in prepare_nsset() can fail so the
    error path drops the cred prepared for CLONE_NEWUSER. A failing
    setns() with CLONE_NEWUSER and CLONE_NEWNS leaked it together with
    its user namespace.

  * Refuse setns(CLONE_NEWNS) for a task that shares its fs_struct again
    when more namespaces are requested.

- minix:

  * Restore uptodate on the pinned bitmap buffers before redirtying them
    after a failed writeback instead of tripping the warning in
    mark_buffer_dirty(), as ext2 and ext4 do for their superblock
    buffers.

  * Reject rmdir() of a directory with a corrupted link count with
    EFSCORRUPTED instead of hitting the drop_nlink() warning.

- userns: Keep the exec securebits and their locks when creating or
  joining a user namespace. set_cred_user_ns() reset all securebits to
  SECUREBITS_DEFAULT so anyone who may create a user namespace could
  shed SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE with a
  single unshare(CLONE_NEWUSER).

- fs: Honor FOP_UNSIGNED_OFFSET in sys_llseek() and in the pread64(),
  pwrite64(), preadv() and pwritev() wrappers.

- proc/kcore: Advance the vmalloc retry in read_kcore_iter() by the
  last vread_iter() copy instead of the running total.

- eventpoll: Return the error when the wakeup source for EPOLLWAKEUP
  can't be created in EPOLL_CTL_MOD instead of reporting success
  without suspend protection.

- coredump: Mark do_coredump() noinline_for_stack.

- nsfs: Check the trailing bytes of a namespace file handle in bytes
  instead of words.

- netfs: Restore the per-level and per-point decoding of the debug
  mask.

- exportfs: Release the directory file get_name() opened with
  __fput_sync(). From nfsd's kernel threads the deferred fputs arrived
  faster than delayed_fput retired them and each pinned the directory's
  readdir state, growing unreclaimable slab by about 90 MB per second
  under a parallel tree walk.

- fs: Call ramfs_kill_sb() for a ramfs rootfs. Since rootfs can be
  unmounted as of v7.0 its struct ramfs_fs_info was leaked.

- signal: Check the blocked mask for every entry
  dequeue_synchronous_signal() looks at. The scan could select a blocked
  synchronous signal and deliver it while blocked.

- super: Convert the superblock device table from an rhltable to a
  plain hashtable under a spinlock. This fixes a bug from v7.3 where
  fs_bdev_freeze() froze a btrfs filesystem through a stale member that
  open_ctree() had already released while the freeze was waiting for SB_BORN.

- fork: Leave rcu_users at zero until copy_process() can't fail anymore.
  bpf_task_acquire() handed out trusted references to the new task from
  the task_alloc LSM hook and sched_ext's ops.init_task() and a failing
  fork freed the task behind them.

- xattr: Always run cap_convert_nscap() for a security.capability write.
  A zero-length setxattr() skipped it and let an unprivileged caller
  without CAP_SETFCAP or write permission on the file plant an empty
  security.capability xattr that made every execve() of the binary fail
  with EINVAL.

- namei: Skip the S_ISDIR assertion in

- proc: Refuse to mount on entries below /proc/<pid>/net like fd/,
  fdinfo/ and map_files/. proc_net_d_revalidate() always fails so the
  first lookup by anyone with search permission ran d_invalidate() on
  the dentry and detached every mount on it, locked mounts included.

- libfs: Hold one mount reference for all pins instead of one per pin.
  The pin count is what keeps the mount alive, so the per-pin reference
  only cost a mntget() and a mntput() through
  mntput_no_expire_slowpath() for every debugfs, tracefs, securityfs or
  configfs file that comes and goes.

- iov_iter: Return 0 from iov_iter_alignment() for an empty iterator of
  any type.

- watch_queue: Give info_id its own storage instead of overlaying it
  with rcu_head.

- filelock: Take an active superblock reference while waiting for a
  delegation break. After a lazy umount closing the delegation holder
  could shut down the superblock under the waiter whose final iput()
  then ran shmem_evict_inode() on freed state.

- fs: Skip the copy_file_range() write limit checks when there is no
  data to copy.

- bpf: Allow bpf_d_path() from fentry on filp_close_sync(). Since
  close_range() became synchronous this cycle close(), close_range()
  and the closes on exec and exit no longer go through filp_close().
  fexit stays rejected since the file may be gone by then.

- fs_pin: Dequeue the wait entry unconditionally in pin_kill(). A
  spuriously woken waiter kept its on-stack entry queued, took that as
  proof that the pin was alive and used the freed acct structure when
  umount() of the accounting file raced acct(2).

- dcache: Don't fail __d_obtain_alias() for an inode without links and
  aliases. The ESTALE check added this cycle broke open_by_handle_at()
  and nfsd file handle decoding on NFS and FUSE where i_nlink is just
  what the server last reported and the handle may well still be valid.

- selftests/ovl: Fix the mountinfo expectations of the detached layer
  test which has failed since it was added.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614:

  Merge tag 'driver-core-7.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core (2026-10-21 18:53:14 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.fixes

for you to fetch changes up to a522dd871024a0f065bfa7638afdb929607f58fc:

  fs: don't fail __d_obtain_alias() for unlinked inodes (2026-10-30 17:18:39 +0100)

----------------------------------------------------------------
vfs-7.4-rc1.fixes

Please consider pulling these changes from the signed vfs-7.4-rc1.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Amir Goldstein (2):
      selftests/ovl: fix detached layer mountinfo expectations
      fs: don't fail __d_obtain_alias() for unlinked inodes

Arnd Bergmann (1):
      coredump: reduce stack usage in vfs_coredump

Avi Weiss (1):
      signal: skip blocked signals in dequeue_synchronous_signal()

Chris Mason (3):
      aio: fix NULL deref when a fault races ring truncation
      iov_iter: fix NULL deref in iov_iter_alignment()
      backing-file: always end a queued write

Christian Brauner (23):
      Merge patch series "writeback: fix timestamp and dirty-state handling in wb switches"
      Merge patch series "fs: honor FOP_UNSIGNED_OFFSET in llseek and positional I/O"
      selftests/filesystems: add a test for freezing a shared block device
      super: convert to plain hashtable
      Merge patch series "super: convert to a plain hashtable"
      statmount: don't copy the reserved empty string past the buffer
      selftests/filesystems: check short buffers for statmount() strings
      listmount: don't wrap around with a U64_MAX cursor
      selftests/filesystems: check listmount() with a U64_MAX cursor
      listns: don't wrap around with a U64_MAX cursor
      selftests/namespaces: check listns() with a U64_MAX cursor
      Merge patch series "fs: fixes for statmount() short buffers and listmount()/listns() cursors"
      iomap: don't mark unwritten parts of a folio uptodate
      Merge patch series "iomap: fixes for short copies and integrity bio sizes"
      userns: don't drop the exec securebits
      selftests/exec: check that user namespaces keep the exec securebits
      Merge patch series "userns: keep the exec securebits"
      proc: don't let an entry below /proc/<pid>/net be a mountpoint
      libfs: hold one mount reference for all pins
      backing-file: enforce append-only and immutable backing inodes
      Merge patch series "fs: fixes for aio rings, backing files and iov_iter_alignment()"
      Merge patch series "pidfs: do not report fields that do not fit into the caller's struct"
      ns: don't add init_ipc_ns and init_net without namespace support

Chuck Lever (1):
      exportfs: Release the get_name() directory file synchronously

Daehyeon Ko (1):
      splice: avoid stale f_pos writeback on error

Dominik Maier (1):
      xattr: always invoke cap_convert_nscap() for security.capability writes

Edvard Conrad (1):
      fs: let backing files inherit FMODE_NONOTIFY from the user file

Hungyu Lin (1):
      fs: skip copy_file_range write limits when there is no data

Ihor Solodrai (1):
      bpf: Allow bpf_d_path() from filp_close_sync()

Jan Kara (1):
      aio: avoid request count overflow in ioctx_alloc()

Josef Bacik (7):
      writeback: don't kick a missing wb for dontcache writes
      fork: Let nobody keep a task that may not come to life
      iomap: keep large chunks from defeating the bio cap
      namei: don't assert S_ISDIR on a stale rcu-walk inode
      mount: refuse setns() with a shared fs_struct again
      nstree: don't end listns() at an inactive namespace
      pidfs: don't let PIDFD_GET_INFO miss a reaped task

Julian Sun (2):
      writeback: reset dirtied_when when switching wbs
      writeback: clear old wb dirty state after inode switches

Karl Mehltretter (2):
      netfs: Restore selective debug mask handling
      fs: fix ramfs_fs_info leak when rootfs is unmounted

Liz Fong-Jones (1):
      writeback: keep cleanup_offline_cgwb()'s scan out of syncs

Nguyen Ngoc Thang (1):
      minix: reject rmdir of a directory with a corrupted link count

Nickolai Zeldovich (9):
      proc/kcore: advance the vmalloc retry by the last copy, not the total
      nsfs: check the trailing bytes of a file handle in bytes, not words
      nsproxy: Fix cred leak in the error path of prepare_nsset()
      ucount: take the rlimit reference before checking the limit
      pidfs: do not report fields that do not fit into the caller's struct
      selftests/pidfd: test that fields beyond the struct size are not reported
      splice: retry tee() instead of returning 0 when it races
      ucount: read the parent ucounts before dropping the rlimit count
      fs_pin: do not trust the pin after a spurious wakeup in pin_kill()

Nikolaos Karaolidis (2):
      fs: rotate inodes whose page cache could not be dropped
      fs: don't lose inodes that another LRU walker is isolating

Qu Wenruo (1):
      iomap: only follow dio alignment requirement if specified

Sanan Hasanov (1):
      minix: restore uptodate on bitmap buffers before redirtying them

Stian Halseth (2):
      fs: fix llseek() result for files with unsigned offsets
      fs: allow positional I/O on files with unsigned offsets

Tianyi Chen (1):
      eventpoll: propagate wakeup source creation failure in ep_modify()

Zhao Gongyi (1):
      filelock: keep superblock active through delegation wait

Zhiyu Zhang (1):
      watch_queue: keep info_id separate from rcu_head

 Documentation/userspace-api/check_exec.rst         |   4 +
 block/bdev.c                                       |   2 +-
 fs/aio.c                                           |  16 +-
 fs/backing-file.c                                  |  44 +-
 fs/coredump.c                                      |   6 +-
 fs/dcache.c                                        |  19 +-
 fs/eventpoll.c                                     |  18 +-
 fs/exportfs/expfs.c                                |   6 +-
 fs/fs-writeback.c                                  |  18 +-
 fs/fs_pin.c                                        |  15 +-
 fs/inode.c                                         |  15 +-
 fs/internal.h                                      |   1 -
 fs/iomap/bio.c                                     |   2 +-
 fs/iomap/buffered-io.c                             |   3 +-
 fs/iomap/direct-io.c                               |  26 +-
 fs/iomap/internal.h                                |   9 +
 fs/iomap/ioend.c                                   |   3 +-
 fs/libfs.c                                         |  12 +-
 fs/minix/bitmap.c                                  |  26 +-
 fs/minix/namei.c                                   |   4 +
 fs/namei.c                                         |  10 +-
 fs/namespace.c                                     |   9 +-
 fs/netfs/internal.h                                |  32 +-
 fs/nsfs.c                                          |   4 +-
 fs/pidfs.c                                         |  51 ++-
 fs/proc/generic.c                                  |   5 +-
 fs/proc/kcore.c                                    |   8 +-
 fs/read_write.c                                    |  46 +-
 fs/splice.c                                        |  55 ++-
 fs/super.c                                         | 332 ++++++--------
 fs/xattr.c                                         |   2 +-
 include/linux/filelock.h                           |  13 +-
 include/linux/fs.h                                 |   4 +-
 include/linux/fs/super_types.h                     |  11 +-
 include/linux/iomap.h                              |   3 +-
 include/linux/watch_queue.h                        |   6 +-
 init/do_mounts.c                                   |  10 +-
 ipc/namespace.c                                    |   7 +
 ipc/shm.c                                          |   2 -
 kernel/fork.c                                      |  12 +-
 kernel/nsproxy.c                                   |   2 +-
 kernel/nstree.c                                    |  80 ++--
 kernel/signal.c                                    |   5 +-
 kernel/trace/bpf_trace.c                           |  15 +-
 kernel/ucount.c                                    |  28 +-
 kernel/user_namespace.c                            |   5 +-
 kernel/watch_queue.c                               |   2 +-
 lib/iov_iter.c                                     |   4 +
 net/core/net_namespace.c                           |   4 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/bpf/prog_tests/d_path.c    |   7 +-
 tools/testing/selftests/bpf/progs/test_d_path.c    |   2 +-
 .../testing/selftests/bpf/progs/verifier_d_path.c  |  21 +
 tools/testing/selftests/exec/check-exec.c          |  83 ++++
 .../selftests/filesystems/freeze/.gitignore        |   2 +
 .../testing/selftests/filesystems/freeze/Makefile  |   7 +
 tools/testing/selftests/filesystems/freeze/config  |   4 +
 .../selftests/filesystems/freeze/loop_util.h       |  64 +++
 .../filesystems/freeze/shared_bdev_test.c          | 479 +++++++++++++++++++++
 .../filesystems/overlayfs/set_layers_via_fds.c     |  18 +-
 .../filesystems/statmount/listmount_test.c         |  11 +
 .../filesystems/statmount/statmount_test.c         |  61 ++-
 tools/testing/selftests/namespaces/listns_test.c   |  34 ++
 tools/testing/selftests/pidfd/pidfd.h              |  16 +
 tools/testing/selftests/pidfd/pidfd_info_test.c    |  48 +++
 65 files changed, 1462 insertions(+), 412 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/freeze/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/freeze/Makefile
 create mode 100644 tools/testing/selftests/filesystems/freeze/config
 create mode 100644 tools/testing/selftests/filesystems/freeze/loop_util.h
 create mode 100644 tools/testing/selftests/filesystems/freeze/shared_bdev_test.c
