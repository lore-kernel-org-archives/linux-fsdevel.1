Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F746EF92;
	Fri, 14 Aug 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713121; cv=none; b=DNHMQBiWXXo9aX9/MaEqJMmsZc+wgIXkQuCKHzhRAZ/AhA+AU9gKyNnFVQmJBr2I4c/3m89I6GpwYht/61lIr/ABik2KOgWsx2hp8QGq4/2hChNgkgqIie3UaJrWVi0FVtWaNM7nJPhg5sbBLjQbQrdJ2IXhb5gmhVvdV9ZTs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713121; c=relaxed/simple;
	bh=88YnAL5so+YeY6r+SGW0IwPmGKfuQMQm5vU+04emtF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/JK6MXblZHSdlFYSsCFqLLFurE+Reu70FmOE52NhoiLoDiKVowwaOlV4/l7Ydd5X1gNePeYqTGrnivRgs0grBGgpOf+TxLb1HhnJADCu9ygmHSM2cHfndpBaYEYFjDdKqyle6Tr0+6qoqlTwTR+COPejrWdxB8n5IuzJR7P5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmjL2W8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmjL2W8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90A91F000E9;
	Fri, 14 Aug 2026 13:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713118;
	bh=sl0fQSsjTFAtkBilRv1AjN6dRFTTEe04m/55U0ji7O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TmjL2W8Q1ubyh9xj0Xn493QPsK+3fAw4ckwM0Bye3ZXW/3nDjkZ2QvShn2Jbd5RyD
	 /GRh4FI8pa8t8LwUcUMbIVfJZMDrQP5q2Ba7MWxufHvicCwAdMG5EAJ8yo2Y6/faDK
	 5MnuLDNdrDA87zwyactsO0qDfcmZ85gJhqf/4+b26EYLbC7Np1zFwptFwKJxUncM42
	 clOFtsTPx/aYzOFanKAcTZAp4nRaByYJs/AYCOoLMqRKzCfdTGEeLRI/ovDYP1jL5x
	 xo2zTKo8M59FCHDPFAbrJVpf3HPEiOtJzaeUwvyuVo2ix/y+mqUcpo7gLP+cWW72Zo
	 qofwsohUevvbw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 05/18 for v7.3] vfs failfs
Date: Fri, 14 Aug 2026 15:11:51 +0200
Message-ID: <20260814-vfs-7.3-rc1.failfs-903759d156dd@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5334; i=brauner@kernel.org; h=from:subject:message-id; bh=88YnAL5so+YeY6r+SGW0IwPmGKfuQMQm5vU+04emtF0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi0hKbSnJOn5i67d79XGyC1ZcFX7rpFD3YR/vE7Vvr 35r/vX/31HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARwTyGv2LJM80aDq+6UuIT pXn4gmP9B0/VprOZR8S9eZt3v1h5p5+RYdai49UhUcXSq7OmH/N7dXhN75qn2j+cvfafPpJ8d1J bFSMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Add failfs and expose a FD_FAILFS_ROOT sentinenel. This allows userspace
to shed their filesystem state completely. A process with its root or
working directory in failfs must anchor every path lookup at an explicit
file descriptor. Absolute paths, absolute symlinks and AT_FDCWD-relative
lookups simply fail.

Failfs is the counterpart to nullfs. nullfs says adds a permanently
empty, immutable directory whose lookups fail with ENOENT but which can
be opened, read, stat'd and mounted upon. Failfs on the other hand fails
every operation. The root cannot be opened at all. A single instance is
mounted during early boot via kern_mount(), which makes it logically
distinct from every mount namespace.

This is accompanied by a new fchroot() system call which makes chrooting
via a file descriptor a first class concept. It's possible to chroot
into failfs as an unprivileged user provided the task has no new
privileges set.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.failfs

for you to fetch changes up to 1d38e750a389e919c1608dbc61cd5c93cd4915dc:

  Merge patch series "fs: add failfs" (2026-07-27 17:18:00 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.failfs

Please consider pulling these changes from the signed vfs-7.3-rc1.failfs tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (8):
      fs: add failfs
      fs: support FD_FAILFS_ROOT in fchdir()
      fs: add fchroot()
      fs: support FD_FAILFS_ROOT in fchroot()
      arch: hookup fchroot() system call
      selftests/filesystems: add failfs selftests
      Documentation: add failfs documentation
      Merge patch series "fs: add failfs"

 Documentation/filesystems/failfs.rst               |  73 +++
 Documentation/filesystems/index.rst                |   1 +
 arch/alpha/kernel/syscalls/syscall.tbl             |   1 +
 arch/arm/tools/syscall.tbl                         |   1 +
 arch/arm64/tools/syscall_32.tbl                    |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl              |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl            |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |   1 +
 arch/s390/kernel/syscalls/syscall.tbl              |   1 +
 arch/sh/kernel/syscalls/syscall.tbl                |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl             |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl             |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |   1 +
 fs/Makefile                                        |   2 +-
 fs/d_path.c                                        |   3 +-
 fs/failfs.c                                        | 166 ++++++
 fs/internal.h                                      |   4 +
 fs/namespace.c                                     |   1 +
 fs/open.c                                          |  51 +-
 include/linux/syscalls.h                           |   1 +
 include/uapi/asm-generic/unistd.h                  |   6 +-
 include/uapi/linux/fcntl.h                         |   1 +
 include/uapi/linux/magic.h                         |   1 +
 scripts/syscall.tbl                                |   1 +
 tools/include/uapi/asm-generic/unistd.h            |   6 +-
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     |   1 +
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |   1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   1 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      |   1 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   |   1 +
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl  |   1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  |   1 +
 tools/scripts/syscall.tbl                          |   1 +
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/failfs/.gitignore        |   2 +
 .../testing/selftests/filesystems/failfs/Makefile  |   5 +
 .../selftests/filesystems/failfs/failfs_test.c     | 585 +++++++++++++++++++++
 44 files changed, 931 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/filesystems/failfs.rst
 create mode 100644 fs/failfs.c
 create mode 100644 tools/testing/selftests/filesystems/failfs/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/failfs/Makefile
 create mode 100644 tools/testing/selftests/filesystems/failfs/failfs_test.c
