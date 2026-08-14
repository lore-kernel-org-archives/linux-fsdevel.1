Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE7E46D2AC;
	Fri, 14 Aug 2026 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712888; cv=none; b=at+UzoRWy01B12b186AkT1prZ+d8uIvgooXlcFnDsdetdPZZt3fvM00y/KDvr4QgLjK0Il7dlZmvqQsOtkz267rKUTO0zHi21ArXAIwck7Tll/O2Rz3t6F7cqAjjFYp4Pkx84QkgNNbBvagOaj5Jvp8uvHkV8IfRBU3TH/eThcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712888; c=relaxed/simple;
	bh=+I2S6/DsSNGhVIx9pPYF5R9Fr1fy1mqAyBL1pDyJ1Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wb0tWUq1SLWFPTPBnD+8B/la8ZAkvhyPtfEgCiZcPveSDrdt58H2KmUw3tV+v0crVUaQe+2bDe+mgHW8UQe2BP+m6xic6KMJZH17yXUAOzkqDn1Y1fDc54/fPRQKhynBoSicBb4CK+Jj2jL/FGA6vKdPF6lrhm0ncE03jl2BGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYkhK/tj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYkhK/tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8357C1F000E9;
	Fri, 14 Aug 2026 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712886;
	bh=+I2S6/DsSNGhVIx9pPYF5R9Fr1fy1mqAyBL1pDyJ1Mk=;
	h=From:To:Cc:Subject:Date;
	b=NYkhK/tjxGAnfoeT+nmk4h1XZPk06AbPqdt4eRTwpyEyjEMk/vxg8Syufl0+93fYS
	 cnJKiExr+tNdRuDyrWiCd9uEbVXz41L+x96vQ8VHveMH3VrQECzzcQCDLdV5ziY4Fz
	 lcluqZTSTXH8iMIct5uVvz6XGGWRHrUraJtRiBiINS+/xucTQ90wy5twzu8uR3R68Z
	 M7diACKA6gz8UBGqp2nNL+tmhM8BddwSklOtmgxXsWxhIHu+9wUPBXmqKUx0qRiObC
	 s8yxfluY8Z/jsJp3D/aldnpUABwSIZvgxVkex8DBBREMxUOPCnYMFcbgHSfwIbkV7l
	 ucl+ewP9WghuA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 00/18 for v7.3] v7.3
Date: Fri, 14 Aug 2026 15:07:12 +0200
Message-ID: <20260814-vfs-v73-6e884cb31ac9@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5184; i=brauner@kernel.org; h=from:subject:message-id; bh=+I2S6/DsSNGhVIx9pPYF5R9Fr1fy1mqAyBL1pDyJ1Mk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVC3MrPFzr4eGamx3DUeD036zhfL6+duWWSoXSa20Tr 196k7m7o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLaXxkZjmufCkmS1AtYd5Zx yafulbejBNPeV8f/V167+Jbt6h+ppxgZPrxvuWn0YqMj2/S0Tz+myNRKddYcs9i19vbPd0tycvL E+QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This is the batch of pull requests for the v7.3 merge window.

We remove three subsystems taking about five thousand lines with them.
These are very old filesystem drivers. EFS, the read-only SGI IRIX
format that predates XFS, has been orphaned and goes. freevxfs goes too.
Cachefiles ondemand mode also goes out now that EROFS over fscache,
its only in-tree user, has been removed.

I've sent the pull request that makes kernel threads stop sharing
filesystem state with userspace which I've kept in -next continously for
multiple cycles. So kernel threads no longer share filesystem state with
PID 1. Since the beginning, init_task, PID 1 and every kthread have
shared one fs_struct, which is why pivot_root() rewrites the fs_struct
of all kthreads and why userspace can move the ground out from under the
kernel.

PID 1 now gets its own fs_struct and kthreads are anchored in a private
nullfs instance that cannot be mounted on and cannot be used to follow
other mounts. So path lookup from a kthread fails by default. Anything
that legitimately needs to look something up in init's filesystem state
must opt-in explicitly via scoped_with_init_fs().

This also sees the addition of a minimal new pseudofs called "failfs"
which came out of some requests to shed fs state for lookup purposes
without having to resort to any namespace shenanigans. In failfs every
operation fails and is the counterpart to nullfs. Its root cannot be
opened at all. A single instance is mounted during early boot and
belongs to no mount namespace. This lets a task shed its filesystem
state completely. With its root or working directory in failfs it must
anchor every lookup at an explicit file descriptor. failfs is reachable
through FD_FAILFS_ROOT which is understood by fchdir() and by the new
fchroot() system call.

Overlayfs learns to support idmapped mounts itself so a whole merged
tree can be shown under a different ownership.

We now make it possible to share a block device between multiple
superblocks. erofs can mount read-only blob devices shared between many
superblocks. Because we only tracked a single superblock a freeze, thaw,
removal or sync on such a device was never propagated to all the
superblocks using it. And there was no way to find them. So add an
efficient table to lookup all superblocks using a given block device. A
bunch of pre-existing fixes fell out of this work as well.

Another chunk is iomap's conversion to a single ->iomap_next() callback
which finishes the move to an iterator model. Every iomap operation
drove its iteration through a struct iomap_ops holding ->iomap_begin()
and ->iomap_end(). That means every step of every iteration is an
indirect call. The work this cycle collapses both into one
->iomap_next() callback that finishes the previous mapping and produces
the next one. This lets callers inline the iteration loop and pass its
->iomap_next() as a compile time constant. That means the compiler can
turn it into a direct and hence inlineable call.

We've also changed sync_inode_metadata() and
writeback_single_inode(). They now persist not only the inode but all
metadata associated with it. A new .sync_inode_metadata superblock
operation is called from __writeback_single_inode(). Alongside it a new
I_METADATA_WRITEBACK state flag is added. So filesystems no longer need
their own mmb_fsync() implementations and can just use simple_fsync().
All metadata is now written for IS_SYNC and IS_DIRSYNC inodes. Races
where several fsyncs raced and mmb_sync() could return before all
buffers were really persisted are fixed since I_SYNC now serializes
properly. The I_METADATA_WRITEBACK scheme also fixes the case where a
WB_SYNC_NONE writeback landing between write(2) and fsync(2) left
fsync(2) failing to persist the inode. That problem is not specific to
filesystems using the generic metadata bh tracking, and the ones that do
not are left alone.

lookup_open() is refactored so that mnt_want_write(), the parent
locking and the delegated_inode retry loop live inside it. nfsd gets a
vfs_lookup_open() to reuse and thus stops open-coding the helper.
audit_inode_child() is now also called on failure there. This matches
what vfs_create() and vfs_mkdir() have always done. And the excl
argument to ->create() is removed.

binfmt_misc sees the largest rework. I've upstreamed a bunch of fixes
you merged during this cycle already. They fell out of this work (two
write access imbalances on interpreter files, an out-of-bounds flag scan
when a register string uses a flag character as its delimiter, and an
'F' entry that could pin its own instance). The new work adds support
for having dynamic policies for how to execute binaries. E.g., this
allows for the interpreter to be computed per binary. That is what
relocatable, hermetic binaries in Nix-style store layouts have needed,
where the right dynamic loader can only be determined relative to the
location of the binary itself and neither PT_INTERP nor a fixed
interpreter string can express it. But the mechanism allows for generic
policies to be expressed.

Thanks!
Christian
