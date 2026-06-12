Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E1A946A;
	Fri, 12 Jun 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277230; cv=none; b=FV5VQIDcsRX2dVPmZTCmByyWEL/rgsUzE5Zn2TgdGe92Nj+2NM3LDkoOfFSkvGJeXWiko9k92JVBJjgz5s8TXYqmQUesbTqaPIcjE7IxFXCPx5BKqQ4HIR3r7ji7mnu9VNfSsyn/v3A9Qmy/4zC1zAZX+c01uwa7rACF7WuRaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277230; c=relaxed/simple;
	bh=XgeD5couSNDfIUduFZBCTnEJG0aV+TuuiIslFX6o7wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEQb3R1MBfOAQRs/4wxjfGmd2/6kp4+jN5SfXfa1kVBvZKCLwswxsKy5YD2PnX5s8Xu79ZVWL3Y8IpfCGq/Wi0zqvSYFkQhCS8I7JHjbYsSnLPtm2FpNnaBjI2t+AXOw4wkrKl3gLcoZVXR402RtRV1H9e6LHCTHrJdsa6WINW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXANXnfc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXANXnfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126201F000E9;
	Fri, 12 Jun 2026 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277228;
	bh=w3GlT7j6qiShsksij6MWTbMQ2h/pwds0C1qEs+CH6Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZXANXnfcLEOjFpr9dKaFgiyrc1UA+tJq5vSslf8M4MoSvmpO6oNfmUWKVADoTsfUA
	 RQ027ErBeIwwfKUiPk5wemy/RyKt76VYbrCINst2y5fxJ1YBOusSk676/zZrT3+pF+
	 SO/v06DwVSs4aQ9IgeQsaHwFbG+vySl+/vLpGm6qyCtpiVIa/O7oLwa6qIzNfxd1sw
	 Gm2C10FjtMavPtuV9rK9hGEoo6NHAr2G2YCe/QGq4moULcaE9HnqnSANTJVz5Wp1vr
	 hKfgCN379ah9BxzcZHfQQFUP3FDvbRwdZKYD1ntNrM0JAdnerKeC6zGPbwA7QPPUKX
	 IxzHkxqLoKkDA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 08/16 for v7.2] vfs openat2
Date: Fri, 12 Jun 2026 17:13:40 +0200
Message-ID: <20260612-vfs-openat2-v72-268139f61842@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7077; i=brauner@kernel.org; h=from:subject:message-id; bh=XgeD5couSNDfIUduFZBCTnEJG0aV+TuuiIslFX6o7wI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKKl9XNDFvHfTlf/Ooiu0HLLnz53fcKbaJOCluPbcH 8eXHVVr6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI+yZGhnvhq08rTeLoc9wa pxuosH7nvmiJKQ8NzkxqYuOZKff5GSPD//Jj53w0yyZ0T1b4FV184Oj2orLceM7eyD1nnb1V9XZ f5wYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the openat2 changes for this cycle:

Features

- Add O_EMPTYPATH to openat(2)/openat2(2). To get an operable file
  descriptor from an O_PATH file descriptor it is possible to use
  openat(fd, ".", O_DIRECTORY) for directories, but other file types
  require going through open("/proc/<pid>/fd/<nr>") and thus depend on
  a functioning procfs. With O_EMPTYPATH an empty path string is
  accepted and LOOKUP_EMPTY is set at path resolution time, allowing
  to reopen the file behind the file descriptor directly. Selftests
  are included.

- Add an OPENAT2_REGULAR flag for openat2(2) which refuses to open
  anything but regular files with the new EFTYPE error code. This
  implements the "ability to only open regular files" feature
  requested by userspace via uapi-group.org and protects services
  from being redirected to fifos, device nodes, and friends.

  All atomic_open implementations were audited for OPENAT2_REGULAR
  handling. Explicit checks were added to ceph, gfs2, nfs (v4), and
  cifs/smb - these are the filesystems whose atomic_open can encounter
  an existing non-regular file and would otherwise call finish_open()
  on it or return a misleading error code. The remaining
  implementations (9p, fuse, vboxsf, nfs v2/v3) only call
  finish_open() on freshly created files and use finish_no_open() for
  lookup hits, letting the VFS catch non-regular files via the
  do_open() safety net.

Cleanups

- Migrate the openat2 selftests to the kselftest harness and move
  them under selftests/filesystems/. The tests were written in the
  early days of selftests' TAP support and the modern kselftest
  harness is much easier to follow and maintain. The contents of the
  tests are unchanged and the new emptypath tests are ported on top.

- Make the LAST_XXX last-type constants private to fs/namei.c. The
  only user outside of fs/namei.c was ksmbd which only needs to know
  whether the last component is a regular one, so
  vfs_path_parent_lookup() now performs the LAST_NORM check
  internally. The ints are replaced with a dedicated enum last_type.

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

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.openat2

for you to fetch changes up to 318643721de396012da102723f337f35ba7ec1e9:

  vfs: replace ints with enum last_type for LAST_XXX (2026-05-29 09:47:02 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.openat2

Please consider pulling these changes from the signed vfs-7.2-rc1.openat2 tag.

Thanks!
Christian

----------------------------------------------------------------
Aleksa Sarai (4):
      selftests: move openat2 tests to selftests/filesystems/
      selftests: openat2: move helpers to header
      selftests: openat2: switch from custom ARRAY_LEN to ARRAY_SIZE
      selftests: openat2: migrate to kselftest harness

Christian Brauner (4):
      Merge patch series "selftests: openat2: migrate to kselftest harness"
      Merge patch series "vfs: add O_EMPTYPATH to openat(2)/openat2(2)"
      Merge patch series "OPENAT2_REGULAR flag support for openat2"
      selftests: openat2: port emptypath_test to kselftest harness

Dorjoy Chowdhury (3):
      openat2: introduce EFTYPE error code
      openat2: new OPENAT2_REGULAR flag support
      kselftest/openat2: test for OPENAT2_REGULAR flag

Jori Koolstra (4):
      vfs: add O_EMPTYPATH to openat(2)/openat2(2)
      selftest: add tests for O_EMPTYPATH
      vfs: make LAST_XXX private to fs/namei.c
      vfs: replace ints with enum last_type for LAST_XXX

 arch/alpha/include/uapi/asm/errno.h                |   2 +
 arch/mips/include/uapi/asm/errno.h                 |   2 +
 arch/parisc/include/uapi/asm/errno.h               |   2 +
 arch/sparc/include/uapi/asm/errno.h                |   2 +
 fs/ceph/file.c                                     |   4 +
 fs/fcntl.c                                         |   4 +-
 fs/gfs2/inode.c                                    |   7 +
 fs/namei.c                                         |  48 ++-
 fs/nfs/dir.c                                       |   4 +
 fs/open.c                                          |  41 ++-
 fs/smb/client/dir.c                                |  18 +-
 fs/smb/server/vfs.c                                |  15 +-
 include/linux/fcntl.h                              |  20 +-
 include/linux/namei.h                              |   7 +-
 include/uapi/asm-generic/errno.h                   |   2 +
 include/uapi/asm-generic/fcntl.h                   |   4 +
 include/uapi/linux/openat2.h                       |   7 +
 tools/arch/alpha/include/uapi/asm/errno.h          |   2 +
 tools/arch/mips/include/uapi/asm/errno.h           |   2 +
 tools/arch/parisc/include/uapi/asm/errno.h         |   2 +
 tools/arch/sparc/include/uapi/asm/errno.h          |   2 +
 tools/include/uapi/asm-generic/errno.h             |   2 +
 tools/include/uapi/linux/openat2.h                 |  43 +++
 .../selftests/{ => filesystems}/openat2/.gitignore |   0
 .../selftests/{ => filesystems}/openat2/Makefile   |   9 +-
 .../selftests/filesystems/openat2/emptypath_test.c |  77 +++++
 .../selftests/filesystems/openat2/helpers.h        | 135 ++++++++
 .../{ => filesystems}/openat2/openat2_test.c       | 262 ++++++++-------
 .../filesystems/openat2/rename_attack_test.c       | 159 +++++++++
 .../{ => filesystems}/openat2/resolve_test.c       | 368 ++++++++++++---------
 tools/testing/selftests/openat2/helpers.c          | 109 ------
 tools/testing/selftests/openat2/helpers.h          | 108 ------
 .../testing/selftests/openat2/rename_attack_test.c | 160 ---------
 33 files changed, 920 insertions(+), 709 deletions(-)
 create mode 100644 tools/include/uapi/linux/openat2.h
 rename tools/testing/selftests/{ => filesystems}/openat2/.gitignore (100%)
 rename tools/testing/selftests/{ => filesystems}/openat2/Makefile (65%)
 create mode 100644 tools/testing/selftests/filesystems/openat2/emptypath_test.c
 create mode 100644 tools/testing/selftests/filesystems/openat2/helpers.h
 rename tools/testing/selftests/{ => filesystems}/openat2/openat2_test.c (63%)
 create mode 100644 tools/testing/selftests/filesystems/openat2/rename_attack_test.c
 rename tools/testing/selftests/{ => filesystems}/openat2/resolve_test.c (74%)
 delete mode 100644 tools/testing/selftests/openat2/helpers.c
 delete mode 100644 tools/testing/selftests/openat2/helpers.h
 delete mode 100644 tools/testing/selftests/openat2/rename_attack_test.c
