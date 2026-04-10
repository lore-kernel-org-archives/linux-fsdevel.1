Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963339BFFF;
	Fri, 10 Apr 2026 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834160; cv=none; b=Z+upLKRZbBVKVaC76gWjuse/jmR6oiJawicvJlg2J+aXPAA2z3TBJ7QnW1oIgxDWsF7vpxMNZbjwe9ZCjsNLNexDhqUUnbKsHCA2TIKdKMGNg9E3x+8c9Y/XrEHSqlcJKGjP1/Fkm8NgpFHp5jk+guIaHuY2SnDspFLTTZO0ZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834160; c=relaxed/simple;
	bh=Q7EuoafMZ/JdHKgE8NivSWOD5qW87lbfxrHcFJKxL7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfarUmVAtFvLMoRY0reXUu/2WAwgycyd2NN3alvR9kTfuPX6vbF/Q5pDwgfrMem81pNvkHqe6kGI4HxZ6aCO6ErmMQx7F1AvKcrLsfoNpuIDIDQP2hw1W7aVVnfKwcDmwZd2qRC30BdWJpksghuHWK6cRh1/B/3E3sE3XP9/hbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxwxNLbe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxwxNLbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1824DC19421;
	Fri, 10 Apr 2026 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834160;
	bh=Q7EuoafMZ/JdHKgE8NivSWOD5qW87lbfxrHcFJKxL7g=;
	h=From:To:Cc:Subject:Date:From;
	b=PxwxNLbeszQIuspwL81tqV1aSA0JxEPUycd2uK2MEumRh0hoKT0CjfRuJxZLkeWoY
	 Ogx2/TSzMK7BLqlVgk376NNvfveegnQhfMxmypl0WJLu95q4dLO/gXGVfqh8kgAOHp
	 s2lzdHhAULbgoe41dJVZiix4yAvo4rhB7Py5z3sOnyPcCZHaYrNXZMxRYgic0EvAlT
	 9408PHQgfy8s0CSXjgrBS9JhLEx1k7MkOsHXCv2EwMK0Xao3iYlCmairO3pgbYl9Oe
	 GUpWuu/EEobEqDS4R+ozEZm8WmV/ydNt7ggPIkjl1B1ucn7n43FP+B14U7woJ4ELd6
	 XK7/gNKlNGR4g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 00/12 for v7.1] v7.1
Date: Fri, 10 Apr 2026 17:15:35 +0200
Message-ID: <20260410-vfs-v71-b055f260060c@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5241; i=brauner@kernel.org; h=from:subject:message-id; bh=Q7EuoafMZ/JdHKgE8NivSWOD5qW87lbfxrHcFJKxL7g=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFFGc1ZfqeDXutTvDds41T0vn86oF809byrFO7Jxvd a7QrvSFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5pcvwV856rrzHJae1Zi+D dr3Y86qAVf9by6Gj16W/a1avnnDo7EZGhh33j/9wenjgwOPsDRwi545Y6m2zXWV2LPH1zabiyC6 Pf5wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This is the batch of pull requests for the v7.1 merge window.

This cycle has several new features and a good amount of infrastructure
work.

There are three new clone3() flags for pidfd-based process lifecycle
management. CLONE_AUTOREAP makes a child auto-reap on exit without
becoming a zombie. Unlike SA_NOCLDWAIT or SIG_IGN on SIGCHLD this is a
per-process property on the child, not a parent-scoped setting affecting
all children. The flag survives reparenting so subreaper or init won't
need to deal with it. CLONE_NNP sets no_new_privs on the child at clone
time, allowing the parent to impose it without affecting itself.
CLONE_PIDFD_AUTOKILL ties a child's lifetime to the pidfd returned from
clone3() - when the last reference to that struct file is closed the
kernel sends SIGKILL to the child. This is useful for container
runtimes, service managers, and sandboxed subprocess execution where the
child must die if the parent crashes. CLONE_PIDFD_AUTOKILL requires both
CLONE_PIDFD and CLONE_AUTOREAP. The pidfd_info struct also gains a
coredump_code field.

The mount namespace work introduces FSMOUNT_NAMESPACE for fsmount()
which creates a new mount namespace with the newly created filesystem
attached, returning a namespace fd instead of an O_PATH mount fd. This
accompanies last cycle's OPEN_TREE_NAMESPACE and is especially useful
when mounting a real filesystem to serve as a container rootfs.

Also new is support for creating empty mount namespaces via
CLONE_EMPTY_MNTNS for clone3() and UNSHARE_EMPTY_MNTNS for unshare().
These create a namespace containing only a single nullfs root mount with
an immutable empty directory. The intended workflow is to mount a real
filesystem over the root and build the mount table from scratch, which
avoids copying and tearing down the entire parent mount tree.

MOVE_MOUNT_BENEATH is extended to target the caller's rootfs and to
transfer the MNT_LOCKED property from the top mount to the mount
beneath. This allows safely modifying an inherited mount table after
unprivileged namespace creation via unshare(CLONE_NEWUSER | CLONE_NEWNS)
and makes it possible to switch out the rootfs without pivot_root(2).

The simple_xattr subsystem is reworked from an rbtree protected by a
reader-writer spinlock to an rhashtable with RCU-based lockless reads.
All consumers (shmem, kernfs, pidfs) are converted and the rbtree code
is removed. On top of this, user.* extended attributes are now supported
on sockets. Sockfs sockets get per-inode limits of 128 xattrs and 128KB
total value size. The practical motivation comes from systemd and GNOME
expanding their use of Varlink as an IPC mechanism - with user.* xattrs
a service can label its socket with the IPC protocol it speaks and eBPF
programs can selectively capture traffic on those sockets.

The inode->i_ino field is widened from unsigned long to u64. This is a
treewide change affecting format strings and tracepoints across 222
files. On 64-bit hosts this makes no material difference but it
eliminates the 32-bit hashing hacks various filesystems had to use.

Filesystem-level T10 protection information support is added. The
existing block layer PI code is refactored to be reusable and wired up
through iomap into XFS. This increases read performance up to 15% for
4k I/O compared to the automatic below-the-covers block layer approach.

The metadata buffer_head tracking accumulated in struct address_space
over the years is cleaned up and moved into filesystem-private inode
structures. The private_list, private_data, and private_lock fields are
removed from struct address_space, saving 3 longs in struct inode for
the vast majority of inodes.

The audit subsystem's excessive dput/dget calls during context setup and
reset are addressed by adding a pool of extra fs->pwd references to
fs_struct. This avoids the spinlock contention on the pwd dentry lock
that was causing noticeable performance regressions on systems with many
CPUs doing open/close with audit enabled.

The directory locking centralization continues. The remaining places
where explicit inode_lock(), lock_rename(), or similar are used outside
the core VFS are converted to use the start_creating/start_removing/
start_renaming interfaces. The biggest changes are in overlayfs,
with smaller conversions in cachefiles, nfsd, apparmor, and selinux.
lock_rename(), lock_rename_child(), and unlock_rename() are unexported.

The writeback subsystem gets new helper APIs and f2fs, gfs2, and nfs are
converted to stop accessing writeback internals directly.

Smaller items include namespace helper macros (FOR_EACH_NS_TYPE(),
CLONE_NS_ALL), FAT timestamp conversion KUnit tests, removal of unused
fs_context infrastructure now that the conversion is finished, a fix
for architecture-specific compat_ftruncate64 enforcing the non-LFS file
size limit, trivial ->setattr rename cleanups, dcache bucket count
fixes, mbcache shrink work ordering fix, omfs superblock validation,
a coredump tracepoint, dirent_size() helper, scoped user access
conversion, runtime const for file/bfile caches, and permitting
dynamic_dname()s up to NAME_MAX.

Thanks!
Christian
