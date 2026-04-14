Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74C37E2E9;
	Tue, 14 Apr 2026 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164321; cv=none; b=C9/z8Mo9E0fZyQlylrwh2asON5qxEgvKJ+iDOVTPqj/06MPhtpg6cQI6s62hBqVCyOxb213gDUhSf8OntoVvROM5XTaL4J+GQw6wxarLmWfNWWFsB4Fz7hCDlccfoJBdfVSvAcdMtsePu1XkuwYzaQ6b+xb6Wy+8Wn1Jynf292g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164321; c=relaxed/simple;
	bh=JCtui1lYKnHf3ZVUSfPJVnQeZB3H0dRk8/K+IfqXGwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4tjVpUofN+x1RlkVTL54eX2DBDL/Pdb+QwWIuIZX9CK2dqoNIICOuwmseIQFb5hEIAZzJtAzdz0isjzbNg27iTgllJSjrjzhr+I+huVEOBC0RpicI+htcvBkW9upF3CfDsFJKAjIn0L55TLG4qJEfjWlW+X5XWzq4/JTH7aeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtZxGax4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtZxGax4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E546C19425;
	Tue, 14 Apr 2026 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776164321;
	bh=JCtui1lYKnHf3ZVUSfPJVnQeZB3H0dRk8/K+IfqXGwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtZxGax4Nc97GgujyWo5gTK6ba1Q0/zoOqHnICd6wLOi0CD47kn4pP0mlfYudSIDn
	 m30Jogv0l4Xl1CqpjgBbxFY0RaBwbZlkW9ouSC0mR2MB1ImnNXO6fSKZAGK3YAGs3a
	 Q6FmD1k9WVF5TJ6rEtwvkoWI4yx6oIkmt62BjE8LKFnjocKuiK1KVujWQm2Isn2tus
	 LAqWBKAj4Kk6wAB6qJ/0uDzhX2g+JXQk8q6UX1tfRvvv9WElb68BbKOHWUsd2EOHC3
	 gpE+0SwNNObNi22lWpRXR+t9Wj1RXml+jkbws49TEG7iM+BmzXW/cB8lox8W6GxjGG
	 4r1A9kRJ+pgJQ==
Date: Tue, 14 Apr 2026 12:58:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 11/12 for v7.1] vfs mount
Message-ID: <20260414-textur-anbahnen-004b3ac3ab8f@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
 <20260410-vfs-mount-v71-89e63a03df4d@brauner>
 <CAHk-=wiA_XzFe_YswO4hezv7MQH6D66k-MBWEZwFJ4urut1aJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiA_XzFe_YswO4hezv7MQH6D66k-MBWEZwFJ4urut1aJQ@mail.gmail.com>

> This is why different branches should be independent things. When they
> contain each other, there's no point. One bad branch poisons the
> others.

Usually all branches I sent are completely independent of another unless
the merge conflict is just needlessly nasty or it is shared with another
tree. Here this clearly worked to our detriment. Sorry about that, I
failed to mention the dependency explicitly as I usually do.

I dropped the merge of the audit branch that you disagreed with from
this branch. The only commits that had to be reapplied on top are
selftest fixes and one syzbot bugfix. I hope this is ok now.

Hey Linus,

/* Summary */

* Add FSMOUNT_NAMESPACE flag to fsmount() that creates a new mount
  namespace with the newly created filesystem attached to a copy of the
  real rootfs. This returns a namespace file descriptor instead of an
  O_PATH mount fd, similar to how OPEN_TREE_NAMESPACE works for
  open_tree().

  This allows creating a new filesystem and immediately placing it in a
  new mount namespace in a single operation, which is useful for
  container runtimes and other namespace-based isolation mechanisms.

  This accompanies OPEN_TREE_NAMESPACE and avoids a needless detour via
  OPEN_TREE_NAMESPACE to get the same effect. Will be especially useful
  when you mount an actual filesystem to be used as the container
  rootfs.

* Currently, creating a new mount namespace always copies the entire
  mount tree from the caller's namespace. For containers and sandboxes
  that intend to build their mount table from scratch this is wasteful:
  they inherit a potentially large mount tree only to immediately tear
  it down.

  This series adds support for creating a mount namespace that contains
  only a clone of the root mount, with none of the child mounts. Two new
  flags are introduced:

  - CLONE_EMPTY_MNTNS (0x400000000) for clone3(), using the 64-bit flag space.
  - UNSHARE_EMPTY_MNTNS (0x00100000) for unshare()

  Both flags imply CLONE_NEWNS. The resulting namespace contains a
  single nullfs root mount with an immutable empty directory. The
  intended workflow is to then mount a real filesystem (e.g., tmpfs)
  over the root and build the mount table from there.

* Allow MOVE_MOUNT_BENEATH to target the caller's rootfs, allowing to
  switch out the rootfs without pivot_root(2).

  The traditional approach to switching the rootfs involves
  pivot_root(2) or a chroot_fs_refs()-based mechanism that atomically
  updates fs->root for all tasks sharing the same fs_struct. This has
  consequences for fork(), unshare(CLONE_FS), and setns().

  This series instead decomposes root-switching into individually
  atomic, locally-scoped steps:

  fd_tree = open_tree(-EBADF, "/newroot", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
  fchdir(fd_tree); move_mount(fd_tree, "", AT_FDCWD, "/", MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH);
  chroot(".");
  umount2(".", MNT_DETACH);

  Since each step only modifies the caller's own state, the
  fork/unshare/setns races are eliminated by design.

  A key step to making this possible is to remove the locked mount
  restriction. Originally MOVE_MOUNT_BENEATH doesn't support mounting
  beneath a mount that is locked. The locked mount protects the
  underlying mount from being revealed. This is a core mechanism of
  unshare(CLONE_NEWUSER | CLONE_NEWNS). The mounts in the new mount
  namespace become locked. That effectively makes the new mount table
  useless as the caller cannot ever get rid of any of the mounts no
  matter how useless they are.

  We can lift this restriction though. We simply transfer the locked
  property from the top mount to the mount beneath. This works because
  what we care about is to protect the underlying mount aka the parent.
  The mount mounted between the parent and the top mount takes over the
  job of protecting the parent mount from the top mount mount. This
  leaves us free to remove the locked property from the top mount which
  can consequently be unmounted:

  unshare(CLONE_NEWUSER | CLONE_NEWNS)

  and we inherit a clone of procfs on /proc then currently we cannot
  unmount it as:

  umount -l /proc

  will fail with EINVAL because the procfs mount is locked.

  After this series we can now do:

  mount --beneath -t tmpfs tmpfs /proc umount -l /proc

  after which a tmpfs mount has been placed beneath the procfs mount.
  The tmpfs mount has become locked and the procfs mount has become
  unlocked.

  This means you can safely modify an inherited mount table after
  unprivileged namespace creation.

  Afterwards we simply make it possible to move a mount beneath the
  rootfs allowing to upgrade the rootfs.

  Removing the locked restriction makes this very useful for containers
  created with unshare(CLONE_NEWUSER | CLONE_NEWNS) to reshuffle an
  inherited mount table safely and MOVE_MOUNT_BENEATH makes it possible
  to switch out the rootfs instead of using the costly pivot_root(2).

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

This will have a merge conflict with:
[1]: https://lore.kernel.org/20260410-namespaces-misc-v71-000ced4f8b7a@brauner
[2]: https://lore.kernel.org/20260410-vfs-pidfs-v71-b736f79a20b9@brauner

It can be resolved as follows:

diff --cc include/uapi/linux/sched.h
index 149dbc64923b,4e76fce9f777..000000000000
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@@ -34,11 -34,9 +34,12 @@@
  #define CLONE_IO              0x80000000      /* Clone io context */

  /* Flags for the clone3() syscall. */
 -#define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 -#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
 +#define CLONE_CLEAR_SIGHAND   (1ULL << 32) /* Clear any signal handler and reset to SIG_DFL. */
 +#define CLONE_INTO_CGROUP     (1ULL << 33) /* Clone into a specific cgroup given the right permissions. */
 +#define CLONE_AUTOREAP                (1ULL << 34) /* Auto-reap child on exit. */
 +#define CLONE_NNP             (1ULL << 35) /* Set no_new_privs on child. */
 +#define CLONE_PIDFD_AUTOKILL  (1ULL << 36) /* Kill child when clone pidfd closes. */
+ #define CLONE_EMPTY_MNTNS     (1ULL << 37) /* Create an empty mount namespace. */

  /*
   * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --cc kernel/fork.c
index 55a6906d3014,dea6b3454447..000000000000
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@@ -2941,9 -2906,9 +2951,9 @@@ static inline bool clone3_stack_valid(s
  static bool clone3_args_valid(struct kernel_clone_args *kargs)
  {
        /* Verify that no unknown flags are passed along. */
--      if (kargs->flags &
-           ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP |
-             CLONE_AUTOREAP | CLONE_NNP | CLONE_PIDFD_AUTOKILL))
 -          ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND |
 -            CLONE_INTO_CGROUP | CLONE_EMPTY_MNTNS))
++      if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND |
++                           CLONE_INTO_CGROUP | CLONE_AUTOREAP | CLONE_NNP |
++                           CLONE_PIDFD_AUTOKILL | CLONE_EMPTY_MNTNS))
                return false;

        /*
@@@ -3092,9 -3057,11 +3102,9 @@@ void __init proc_caches_init(void
   */
  static int check_unshare_flags(unsigned long unshare_flags)
  {
 -      if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
 +      if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_SIGHAND|
                                CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
-                               CLONE_NS_ALL))
 -                              CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|
 -                              CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP|
 -                              CLONE_NEWTIME | UNSHARE_EMPTY_MNTNS))
++                              CLONE_NS_ALL|UNSHARE_EMPTY_MNTNS))
                return -EINVAL;
        /*
         * Not implemented, but pretend it works if there is nothing
diff --cc kernel/nsproxy.c
index 63b44ee79847,1bdc5be2dd20..000000000000
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@@ -211,9 -213,12 +212,10 @@@ int unshare_nsproxy_namespaces(unsigne
        struct nsproxy **new_nsp, struct cred *new_cred, struct fs_struct *new_fs)
  {
        struct user_namespace *user_ns;
+       u64 flags = unshare_flags;
        int err = 0;

-       if (!(unshare_flags & (CLONE_NS_ALL & ~CLONE_NEWUSER)))
 -      if (!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 -                     CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP |
 -                     CLONE_NEWTIME)))
++      if (!(flags & (CLONE_NS_ALL & ~CLONE_NEWUSER)))
                return 0;

        user_ns = new_cred ? new_cred->user_ns : current_user_ns();

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.mount.v2

for you to fetch changes up to cad3bf1c330274d11f25f1b7afae9b9dba13fbd3:

  selftests/namespaces: remove unused utils.h include from listns_efault_test (2026-04-14 09:31:18 +0200)

----------------------------------------------------------------
vfs-7.1-rc1.mount.v2

Please consider pulling these changes from the signed vfs-7.1-rc1.mount.v2 tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (21):
      mount: start iterating from start of rbtree
      mount: simplify __do_loopback()
      mount: add FSMOUNT_NAMESPACE
      tools: update mount.h header
      selftests/statmount: add statmount_alloc() helper
      selftests: add FSMOUNT_NAMESPACE tests
      Merge patch series "fsmount: add FSMOUNT_NAMESPACE"
      namespace: allow creating empty mount namespaces
      selftests/filesystems: add tests for empty mount namespaces
      selftests/filesystems: add clone3 tests for empty mount namespaces
      Merge patch series "namespace: allow creating empty mount namespaces"
      move_mount: transfer MNT_LOCKED
      move_mount: allow MOVE_MOUNT_BENEATH on the rootfs
      selftests/filesystems: add MOVE_MOUNT_BENEATH rootfs tests
      Merge patch series "move_mount: expand MOVE_MOUNT_BENEATH"
      mount: always duplicate mount
      selftests/statmount: remove duplicate wait_for_pid()
      selftests/empty_mntns: fix statmount_alloc() signature mismatch
      selftests/empty_mntns: fix wrong CLONE_EMPTY_MNTNS hex value in comment
      selftests/fsmount_ns: add missing TARGETS and fix cap test
      selftests/namespaces: remove unused utils.h include from listns_efault_test

 fs/namespace.c                                     |  194 ++--
 include/uapi/linux/mount.h                         |    1 +
 include/uapi/linux/sched.h                         |    7 +
 kernel/fork.c                                      |   17 +-
 kernel/nsproxy.c                                   |   21 +-
 tools/include/uapi/linux/mount.h                   |   14 +-
 tools/testing/selftests/Makefile                   |    3 +
 .../selftests/filesystems/empty_mntns/.gitignore   |    4 +
 .../selftests/filesystems/empty_mntns/Makefile     |   12 +
 .../empty_mntns/clone3_empty_mntns_test.c          |  938 ++++++++++++++++
 .../filesystems/empty_mntns/empty_mntns.h          |   25 +
 .../filesystems/empty_mntns/empty_mntns_test.c     |  725 +++++++++++++
 .../empty_mntns/overmount_chroot_test.c            |  225 ++++
 .../selftests/filesystems/fsmount_ns/.gitignore    |    1 +
 .../selftests/filesystems/fsmount_ns/Makefile      |   10 +
 .../filesystems/fsmount_ns/fsmount_ns_test.c       | 1135 ++++++++++++++++++++
 .../selftests/filesystems/move_mount/.gitignore    |    2 +
 .../selftests/filesystems/move_mount/Makefile      |   10 +
 .../filesystems/move_mount/move_mount_test.c       |  492 +++++++++
 .../selftests/filesystems/open_tree_ns/Makefile    |    2 +-
 .../filesystems/open_tree_ns/open_tree_ns_test.c   |   43 +-
 .../selftests/filesystems/statmount/statmount.h    |   51 +
 .../filesystems/statmount/statmount_test.c         |   45 +-
 .../filesystems/statmount/statmount_test_ns.c      |   25 -
 tools/testing/selftests/filesystems/utils.c        |    4 +-
 tools/testing/selftests/filesystems/utils.h        |    2 +
 .../selftests/namespaces/listns_efault_test.c      |    1 -
 27 files changed, 3814 insertions(+), 195 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/empty_mntns/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/empty_mntns/Makefile
 create mode 100644 tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
 create mode 100644 tools/testing/selftests/filesystems/empty_mntns/empty_mntns.h
 create mode 100644 tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c
 create mode 100644 tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c
 create mode 100644 tools/testing/selftests/filesystems/fsmount_ns/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fsmount_ns/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fsmount_ns/fsmount_ns_test.c
 create mode 100644 tools/testing/selftests/filesystems/move_mount/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/move_mount/Makefile
 create mode 100644 tools/testing/selftests/filesystems/move_mount/move_mount_test.c
