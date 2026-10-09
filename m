Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446E47F3B7;
	Fri,  9 Oct 2026 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536860; cv=none; b=D0lithbOzTdvmZplDtYerzIzPuYd///8FGpI3kvJ7XiVnjk7xB9g7DGgTgoQ7uzRJ/OGnK9wSVmgLrKntGsJoewZ/NHWauVXvI0/FdglwJuKcgvkK2WXXxXOJJrDvGxs7y2ch/5C5JywLi0bor7/ckJLBJ/fqJuqlBJUmgB9cgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536860; c=relaxed/simple;
	bh=XxnHrXIVVm/c+9Rt/9NC8ZDCoEx33MM/epNACB49mLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYqE9zK5zJoMyvWbnt+g3mtoIx5Kz7IGsIcHBqed8QHviCNgLMIjLIImGqKDAFIARCEDpeGAHBqlZ4y3d5xooSED8IDVl/SBEtzbdVCRpXQh2JTSsTJ26oEsmD2V597EgW83ZAKPHHWwQQYC3uzvbFjg5xljz1iAO8fE/nDDfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giIzo97k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giIzo97k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264AF1F000FF;
	Fri,  9 Oct 2026 09:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791536851;
	bh=zE+rUZxb1h4I8DaKk91wqc+JP0OvCXLlcey6XVUQuNc=;
	h=From:To:Cc:Subject:Date;
	b=giIzo97kjfPGF1lTaXDMpBux1PxC0iTh+2Dfpbh2eBrwwPpxZxVAUM/AIq251Yhtc
	 lWVxFj5MOZagi1fD6vbLsiox1DGw+Dpv920+CYmKVx/amy9bR4LV83Xx6fdPh/Qh4g
	 /KDi9U4Gc3Kk4kL6vii0r3E+xah0fsvx0Yu5M26LsWdprT+3Hocs83bXs7DLqgcMLk
	 dg2bQqDi4pDn7fbuQZM8300Y8ITWrMdwa8djMxwmvKm6zvXA5ZvBViOt3rhTdGu4cM
	 nNJ8DYhQ8KUfiMJoAf+cxXyzHYqmJ/xzlsB8FOw7XrisYS3iAXPYVK3pcWlgdx9a0w
	 QSxEVN0eh0Xhg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.3] vfs fixes
Date: Fri,  9 Oct 2026 11:05:13 +0200
Message-ID: <20261009-vfs-7.3-rc7.fixes-cbe1a4036c84@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23882; i=brauner@kernel.org; h=from:subject:message-id; bh=XxnHrXIVVm/c+9Rt/9NC8ZDCoEx33MM/epNACB49mLs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdWJfdVlFvsaQ5llVm+e5d32ZZm2WVLWmaVW2u4im5O f+d3Xf/jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm4CzL804jb8uzU3f987aEH tLz4Zm9NP/NqSm3ihGuci/yC97salTH8lWVNWySfeeWd3IFtfnuND15WuRBy1UdZ9XLkmQtGT0O fcQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains fixes for the current development cycle. As discussed
yesterday, let's get it fixed now. I added the selftests as well because I
think there quite crucial for this but if that bothers you I can drop them next
time and only do the fixes themselves.

All of them came out of a review of the mount code that started with a
bug report. The review modeled the corner cases of mount propagation,
unmounting and mount reference counting and turned up a lot of bugs.
Most of them years old. Most fixes come with a selftest.

- Rework connected mounts.

  A mount that is unmounted together with its parent can stay attached
  to the parent to keep its mountpoint covered. That happens when the
  mountpoint is removed with rmdir(), unlink() or rename(), when a
  detached tree is dissolved, and for locked mounts in any umount that
  isn't synchronous, including the teardown of their mount namespace.
  The parent then owns the child and drops it on its own final
  mntput(). So any reference from the child's superblock back to one of
  its ancestors becomes a cycle that is never freed.

  A loop device backed by an image on a tmpfs and mounted on that same
  tmpfs is enough. Remove the directory the tmpfs is mounted on from
  the host, let the container's mount namespace exit, and the loop
  device, the tmpfs and the filesystem on the loop device are leaked
  for good. The same works with autofs, zram, ecryptfs, binfmt_misc,
  fuse passthrough, zloop, a mass storage gadget and md, and the
  selftests have reproducers for them. This has been possible since
  v4.1. It is also why "put_mnt_ns(): leave mounts connected" was
  reverted in -rc5. Keeping every mount of a dying mount namespace
  connected made these cycles trivial to create.

  Every unmounted mount is now detached from its parent. Where the
  mountpoint has to stay covered the mount leaves a cover on the parent
  instead, allocated together with the mount. A lookup on the unmounted
  parent that hits a cover finds an empty immutable directory or file
  on the private nullfs instance. Nothing leads from a cover to another
  mount, so no unmounted mount owns another one and no cycle can form.

  This is visible to userspace. A formerly connected mount can no
  longer be reached through its unmounted parent and ".." inside it
  leads nowhere, as for every other lazily unmounted mount.

  With that the private nullfs instance becomes reachable from
  userspace, so it now refuses mounts on top, is mounted read-only, and
  refuses fsnotify marks and file locks. Its inodes are shared by every
  holder and a watch or a lock would otherwise reach across users.
  may_decode_fh() now also decides its subtree check under a single
  mount_lock hold, as a racing umount could otherwise let it decode
  into what a locked child covered.

- umount:

  * Don't silently unmount busy mounts. Since v4.13 propagate_umount()
    takes down propagated copies of the victim with children as long as
    each child is an overmount or another copy of the victim, but
    propagate_mount_busy() only ever checked copies without children or
    with just an overmount. A container that moved a tree beneath its
    copy of a host mount lost that tree from under its open file
    descriptor to a plain umount() on the host. propagate_mount_busy()
    now applies the same rules, walking each chain of copies once.

  * Don't let a migrating task hide its reference from umount().
    mnt_get_count() sums the per-cpu counters under mount_lock but the
    mntget() and mntput() fast paths don't take it. A task that takes a
    reference on a cpu the sum has already passed and drops it after
    migrating to one the sum hasn't reached yet hides the reference it
    held to begin with, and umount() succeeds with the file still open.
    Gets and puts now live in separate per-cpu counters and all puts
    are summed before all gets with a full barrier in between, the way
    srcu_readers_active_idx_check() does it. mntget() is unchanged and
    mntput() gains an smp_wmb().

  * Check each submount for references right before unmounting it.
    shrink_submounts() and mark_mounts_for_expiry() checked all their
    victims up front. Unmounting the first could move a busy overmount
    to where the next victim's propagated copy is looked up and it was
    then unmounted without a check.

  * Never expire a locked mount. A shrinkable mount moved beneath a
    locked mount with MOVE_MOUNT_BENEATH takes over the lock, and
    umount() of an unlocked ancestor expired it and revealed what it
    covered. That umount() now fails with EBUSY as it does for any
    other locked child. A lazy umount still takes the whole tree.

- Overmounts and locked mounts:

  * Unhash a dentry before detaching the mounts on it. unlink(), rmdir()
    and rename() detach the mounts on the victim but only d_delete() it
    once its inode is unlocked, a window that includes an expedited RCU
    grace period. In between, a lookup from a mount namespace in which
    the dentry is a mountpoint found it hashed, positive and uncovered.
    Drop the dentry first, as d_invalidate() already does.

  * Don't reveal overmounted entries in refwalk. A refwalk that had
    grabbed the dentry before the unlink never rechecked it the way
    rcuwalk does with d_seq and mount_lock. Without any artificial
    widening three walkers read the covered file 27 times in a minute.
    step_into() now fails an unhashed dentry marked DCACHE_CANT_MOUNT
    with -ESTALE and the walk is retried.

  * Keep covered mounts covered in OPEN_TREE_NAMESPACE. Creating such a
    mount namespace only takes a user namespace and the copy followed
    bind mount rules: no children without AT_RECURSIVE and no
    unbindable mounts with it. An unprivileged user could see what
    mounts covered in the source, such as the parts of /proc and /sys
    that container runtimes mask. If the caller doesn't own the source
    mount namespace a non-recursive copy of a mount with something
    mounted below the requested directory is now refused and a
    recursive copy includes unbindable mounts, the way unshare() copies.

  * Keep the lock on a mount that a propagated copy is moved beneath.
    MNT_LOCKED moved to any mount that ended up beneath a locked mount,
    propagated copies included. A host mount and umount on a directory
    covered by a locked mount in a less privileged mount namespace left
    that cover unlocked for the namespace's owner to remove. Only mounts
    the caller places beneath take over the lock now.

  * Handle mount locking for automounts correctly. Which copies to lock
    was decided by the mount namespace of the task that triggered the
    automount. A task in a user namespace that triggered one on a host
    mount through a file descriptor got the host's own automount locked
    while its own copy stayed unlocked and could have nosuid, nodev and
    noexec cleared. Use the owner of the mount namespace the mount lands
    in.

- Use-after-free and crashes:

  * Refuse an automount below a mount that is in no namespace. The
    private clones overlayfs uses for its layers have the
    MNT_NS_INTERNAL error pointer as their namespace, which
    finish_automount() let through and count_mounts() dereferenced. A
    fanotify filesystem mark on an overlayfs lower layer hands out file
    descriptors on such a clone. With debugfs as the lower layer opening
    "tracing" oopses with namespace_sem held for writing and every mount
    operation on the system blocks from then on.

  * Reset the old parent's ->overmount in mnt_change_mountpoint(). When
    propagate_umount() moved an overmount off a mount that a file
    descriptor kept alive, MOVE_MOUNT_BENEATH through that descriptor
    later followed the stale pointer into the freed overmount.

  * statmount() with STATMOUNT_BY_FD and pivot_root() read the parent of
    a mount that may be unmounted and only held by a file descriptor,
    while the parent's final mntput() can free it. statmount() now reads
    it under mount_lock and pivot_root() first checks that both mounts
    are in the caller's mount namespace.

  * Queue a mount only once for mount notifications. A mount reparented
    by one umount_tree() and taken down by the next under the same
    namespace_sem hold, as in shrink_submounts(), was queued twice. That
    cut the mounts queued in between out of notify_list while it still
    pointed at them, and once they were freed every later mount
    operation walked freed memory.

  * Don't let a pseudo dentry become the root of a mount. A bind mount
    of a bpf token file did that with a DCACHE_NORCU dentry, which is
    freed without an RCU grace period while lockless path walks may
    still look at it. Refuse to clone such a mount.

  * Don't inherit MNT_UMOUNT in clone_mnt(). A bind mount of a lazily
    unmounted nsfs or pidfs mount through its file descriptor started
    out flagged as unmounted. Among other things __detach_mounts() then
    dropped the namespace's reference on it, the mount outlived its
    namespace and mount_setattr() through the descriptor read the freed
    namespace. A recursive bind mount of such a mount also copied the
    unmounted stack still attached to it. That now fails with EINVAL,
    copying the mount itself still works.

  * Remove the fsnotify marks of a mount namespace in free_mnt_ns()
    instead of the RCU callback that frees the namespace, where taking
    the group mutexes meant sleeping in softirq context.

- Propagation and copies:

  * Keep a copied mount unbindable. Since v6.17 clone_mnt() didn't copy
    the unbindable flag, so every mount namespace created with
    CLONE_NEWNS had bindable copies of all unbindable mounts. This had
    been fixed once before.

  * Refuse MOVE_MOUNT_SET_GROUP on an unbindable mount. It made the
    mount an unbindable slave, a state nothing else can produce, or
    silently dropped the unbindable flag. CRIU applies MS_UNBINDABLE
    after restoring sharing and isn't affected.

  * Check a recursive bind mount for mount namespace loops. Recursively
    bind mounting a tree from another mount namespace could put a mount
    of a namespace's file inside that same namespace, which then pins
    itself and all its mounts. Repeating it leaks without limit, the
    reproducer took Shmem from 380 kB to 65916 kB. The copy is now
    checked with check_for_nsfs_mounts() before it is grafted, as
    move_mount() does.

  * Look at the topmost mount for a mount namespace file.
    attach_recursive_mnt() never looked at the topmost mount of the
    source's chain of overmounts. If that was the chain's only mount
    namespace file an existing mount at a propagated destination got
    buried below the root of the nsfs file where no path walk reaches
    it.

  * Don't put a mountpoint on a dentry that's being removed.
    attach_recursive_mnt() makes a mountpoint of the source's root
    without its inode lock, so a racing rmdir() of that directory could
    leave a mount on it that nothing ever detaches. d_set_mounted() now
    checks cant_mount() as well.

- nullfs:

  * Take no inode lock for readdir of an immutable directory. The root
    of every empty mount namespace is the same nullfs directory and
    iterate_dir() held its i_rwsem across ->iterate_shared(). A reader
    whose buffer faults on a FUSE mount of its own holds it for as long
    as its server wants, and with an exclusive locker queued behind it
    every lookup that misses the dcache, every create and every mount in
    that directory waits. One user of an empty mount namespace stalls
    all others. Directories with the new FOP_IMMUTABLE flag skip the
    lock.

  * Refuse to reconfigure internal superblocks through fspick(),
    MS_REMOUNT or the read-only remount that a synchronous umount() of
    the root does. For nullfs only root in the initial user namespace
    could do it, but the superblock is shared by every mount namespace
    and the flags showed up in statfs() for all of them.

  * Don't update the access time on nullfs and refuse F_SET_RW_HINT on
    an immutable inode.

- unshare: Free an nsproxy that was never installed with nsproxy_free()
  when set_cred_ucounts() fails. put_nsproxy() dropped active references
  that were never taken, which triggered a warning and hid the caller's
  own namespaces from listns().

- Smaller changes: mount_setattr() checks the target before it walks the
  tree to allocate peer group ids, unshare() puts the old fs_struct
  before the old namespaces, dissolve_on_fput() drops the file's
  reference to the tree itself, disconnect_mount() is simplified and
  the documentation of the propagated unmount rule is brought up to
  date.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit aa5e44b29ffe4eaa08cc2237fd65bc2596bc023e:

  autofs: fix sbi->pipe file reference leak in autofs_kill_sb() (2026-09-25 16:51:46 +0200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc7.fixes

for you to fetch changes up to 3d399224425573875b6f6f1181bd8cf9a28cc7d1:

  namespace: simplify disconnect_mount() (2026-10-07 00:45:50 +0200)

----------------------------------------------------------------
vfs-7.3-rc7.fixes

Please consider pulling these changes from the signed vfs-7.3-rc7.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (63):
      mount: keep a copied mount unbindable
      selftests/filesystems: check that a copied mount namespace keeps unbindable
      mount: refuse MOVE_MOUNT_SET_GROUP on an unbindable mount
      selftests/move_mount_set_group: check that an unbindable target is refused
      fs: don't silently unmount busy mounts
      selftests/filesystems: check that a busy propagated copy blocks a synchronous umount
      fs: don't let a migrating task hide its reference from do_umount()
      docs: update the unmount propagation rule
      Merge patch series "mount: a few gnarly fixes"
      namespace: reset the old parent's ->overmount in mnt_change_mountpoint()
      statmount: read the parent of an unmounted mount under mount_lock
      namespace: don't inherit MNT_UMOUNT in clone_mnt()
      namespace: don't copy an unmounted mount tree
      namespace: check the target before walking it in do_mount_setattr()
      fs: refuse fspick() on internal superblocks
      fs: put the old fs_struct before the old namespaces in unshare()
      namespace: drop the file's reference first in dissolve_on_fput()
      selftests/filesystems: check that an unmounted mount tree isn't walked
      selftests/filesystems: check that a dead mount's overmount isn't followed
      Merge patch series "mount: a few additional bugfixes"
      namespace: queue a mount only once for mount notifications
      namespace: check a submount for references right before unmounting it
      selftests/filesystems: check that a busy submount survives a synchronous umount
      namespace: check a recursive bind mount for mount namespace loops
      selftests/filesystems: check that a recursive bind mount can't pin the caller's mount namespace
      namespace: keep covered mounts covered in OPEN_TREE_NAMESPACE
      selftests/filesystems: check that OPEN_TREE_NAMESPACE keeps mounts covered
      namespace: look at the topmost mount for a mount namespace file
      selftests/filesystems: check that a mount namespace file on top doesn't bury a mount
      namespace: check the mounts before reading their parents in pivot_root()
      namespace: don't reconfigure internal superblocks via remount and umount
      selftests/filesystems: check that the nullfs root can't be reconfigured
      namespace: remove the fsnotify marks of a mount namespace in process context
      dcache: don't put a mountpoint on a dentry that's being removed
      unshare: don't drop active namespace references that were never taken
      namespace: don't let a pseudo dentry become the root of a mount
      Merge patch series "mount: more bugfixes, the Oprah edition"
      namespace: unhash a dentry before detaching the mounts on it
      namei: don't reveal overmounted entries in refwalk
      fcntl: refuse F_SET_RW_HINT on an immutable inode
      selftests/filesystems: check that an immutable inode takes no write hint
      namespace: refuse an automount below a mount that is in no namespace
      namespace: handle mount locking for automounts correctly
      nullfs: don't update the access time
      namespace: never expire a locked mount
      namespace: keep the lock on a mount that a propagated copy is moved beneath
      selftests/filesystems: check that a lock lands on the right mount and stays
      selftests/filesystems: check the atime of the empty mount namespace root
      selftests/filesystems: check that an automount below an overlay layer is refused
      fhandle: decide the subtree check under mount_lock
      namespace: keep the private nullfs instance in knullfs
      namespace: nothing is mounted on or written through knullfs
      fsnotify: let a filesystem refuse marks on its objects
      nullfs: refuse file locks
      readdir: take no inode lock on an immutable directory
      selftests/filesystems: add a helper that holds a readdir in a page fault
      selftests/filesystems: check that reading the root of an empty mount namespace stalls nobody
      Merge patch series "mount: more bugfixes, trapped in the Black Lodge edition"
      nullfs: add an empty immutable regular file
      namespace: rework connected mounts
      selftests/filesystems: test covered mounts
      Merge patch series "namespace: rework connected mounts"
      namespace: simplify disconnect_mount()

 Documentation/filesystems/propagate_umount.txt     |   12 +-
 Documentation/filesystems/sharedsubtree.rst        |   20 +-
 fs/dcache.c                                        |    4 +-
 fs/fcntl.c                                         |    3 +
 fs/fhandle.c                                       |   20 +-
 fs/file_table.c                                    |    3 +-
 fs/fs_context.c                                    |    4 +
 fs/mount.h                                         |   18 +-
 fs/namei.c                                         |   29 +
 fs/namespace.c                                     |  461 ++++--
 fs/notify/mark.c                                   |    4 +
 fs/nullfs.c                                        |  123 +-
 fs/pnode.c                                         |  112 +-
 fs/readdir.c                                       |   13 +-
 include/linux/fs.h                                 |    3 +
 include/linux/mount.h                              |    2 +-
 include/linux/nsproxy.h                            |    1 +
 kernel/fork.c                                      |   12 +-
 kernel/nsproxy.c                                   |    2 +-
 tools/testing/selftests/Makefile                   |    3 +
 tools/testing/selftests/filesystems/.gitignore     |    1 +
 tools/testing/selftests/filesystems/Makefile       |    2 +-
 .../selftests/filesystems/empty_mntns/.gitignore   |    3 +
 .../selftests/filesystems/empty_mntns/Makefile     |    5 +
 .../empty_mntns/internal_sb_reconfigure_test.c     |  108 ++
 .../filesystems/empty_mntns/nullfs_atime_test.c    |  129 ++
 .../filesystems/empty_mntns/root_readdir_test.c    |   45 +
 .../filesystems/mntns_unbindable/Makefile          |    6 +
 .../mntns_unbindable/mntns_unbindable_test.c       |  227 +++
 .../selftests/filesystems/mount_cycle/.gitignore   |    8 +
 .../selftests/filesystems/mount_cycle/Makefile     |   12 +
 .../selftests/filesystems/mount_cycle/config       |   39 +
 .../filesystems/mount_cycle/locked_handle_test.c   |  377 +++++
 .../filesystems/mount_cycle/loop_cycle_test.c      | 1542 ++++++++++++++++++++
 .../filesystems/mount_cycle/mount_cover_test.c     |  579 ++++++++
 .../filesystems/mount_cycle/nsfs_rbind_loop_test.c |  193 +++
 .../mount_cycle/overmount_ns_file_test.c           |  190 +++
 .../mount_cycle/overmount_reparent_test.c          |  181 +++
 .../selftests/filesystems/mount_cycle/settings     |    1 +
 .../filesystems/mount_cycle/unmounted_tree_test.c  |  484 ++++++
 .../selftests/filesystems/open_tree_ns/.gitignore  |    1 +
 .../selftests/filesystems/open_tree_ns/Makefile    |    2 +-
 .../open_tree_ns/open_tree_ns_covered_test.c       |  195 +++
 .../selftests/filesystems/overlayfs/.gitignore     |    1 +
 .../selftests/filesystems/overlayfs/Makefile       |    1 +
 .../filesystems/overlayfs/automount_in_layer.c     |  174 +++
 tools/testing/selftests/filesystems/readdir_hold.h |  224 +++
 tools/testing/selftests/filesystems/rw_hint_test.c |  129 ++
 .../filesystems/umount_propagation/Makefile        |    6 +
 .../umount_propagation/locked_mount_test.c         |  432 ++++++
 .../umount_propagation/shrink_submounts_test.c     |  211 +++
 .../umount_propagation/umount_propagation_test.c   |  226 +++
 .../move_mount_set_group_test.c                    |   74 +-
 53 files changed, 6462 insertions(+), 195 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/empty_mntns/internal_sb_reconfigure_test.c
 create mode 100644 tools/testing/selftests/filesystems/empty_mntns/nullfs_atime_test.c
 create mode 100644 tools/testing/selftests/filesystems/empty_mntns/root_readdir_test.c
 create mode 100644 tools/testing/selftests/filesystems/mntns_unbindable/Makefile
 create mode 100644 tools/testing/selftests/filesystems/mntns_unbindable/mntns_unbindable_test.c
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/Makefile
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/config
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/locked_handle_test.c
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/loop_cycle_test.c
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/mount_cover_test.c
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/nsfs_rbind_loop_test.c
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/overmount_ns_file_test.c
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/overmount_reparent_test.c
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/settings
 create mode 100644 tools/testing/selftests/filesystems/mount_cycle/unmounted_tree_test.c
 create mode 100644 tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_covered_test.c
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/automount_in_layer.c
 create mode 100644 tools/testing/selftests/filesystems/readdir_hold.h
 create mode 100644 tools/testing/selftests/filesystems/rw_hint_test.c
 create mode 100644 tools/testing/selftests/filesystems/umount_propagation/Makefile
 create mode 100644 tools/testing/selftests/filesystems/umount_propagation/locked_mount_test.c
 create mode 100644 tools/testing/selftests/filesystems/umount_propagation/shrink_submounts_test.c
 create mode 100644 tools/testing/selftests/filesystems/umount_propagation/umount_propagation_test.c
