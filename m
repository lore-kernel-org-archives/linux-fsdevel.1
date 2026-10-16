Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835B329E5A;
	Fri, 16 Oct 2026 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145947; cv=none; b=p0WEYSS8C6wJK6CrT1/JtmUFuG9dfURvkbX/gwqOE1YzEct7C80Xkc8KSc4Y7RJQ2DZeWgElMW5AgzwotCemXdoK/DJ00oGbvjGWTxMUUMGR8qHLB+aeJtcUwOdKkUVDArYzKBnVjFleoGEQ7jpdcWEl0IMwChzoM9U5l6zASfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145947; c=relaxed/simple;
	bh=e0dOSOnxeOXOfd2/l7kHXL6TVBEKuXRUS7i3/87Z8S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tvd4bmM4i+ht3ADzTK6yAYpUpK9BQjLuZLttlbABZ9EY5kjwrMW2qgW64o0gtj1AYueQdyjJC5nkEqayztzhsdd3uewokHK5RLEzVcE1S3ygcxGJylTThFaJ/03nsb8RPTu/tnadtoI0GXVjYuf8wX48VfTGOKkfx844ObbOt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGG45cPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGG45cPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F6D1F000C4;
	Fri, 16 Oct 2026 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145946;
	bh=2V6okvCUtN5rt6q4iwvHYcjDTyJ1f2JdZMB0YT/CC0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eGG45cPdOFYdd4IGkJPX7+5IGVlAUjZv12fk3I4/6LB24K3wpTVWZfd26RgV8SNM+
	 ZKIIQiR3aecQQB/+JqY0GZquuEmTV+iDCGDOfiuwyf3g/IcZ7Aq7oWjLXtMz3tpy7X
	 uYif9cqekJnIvLr6h51Cjxf1YzLart2eqdp82wwfL3W6SnsIJ6yQ/mBIY72CLc9tmu
	 YkZ58/t2rZ0STMiI4/g8n2P09qK3X0jNURSli/9x+mWmnC8UjkSB3VcjsYwWH19aPn
	 prMVpHPsCqv+v6MV4lP7EvgpwDPdtOn3530oTTN/YNU3N/sMgjuRMIDBJBWJOVMGg7
	 GVO99ND1hBbLg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 09/19 for v7.4] vfs file
Date: Fri, 16 Oct 2026 12:18:45 +0200
Message-ID: <20261016-vfs-7.4-rc1.file-c45175e298c8@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4484; i=brauner@kernel.org; h=from:subject:message-id; bh=e0dOSOnxeOXOfd2/l7kHXL6TVBEKuXRUS7i3/87Z8S0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/MX3n82l8sUZq1uRRfOl38SeXryvQpt/yVG3LYc+T 54bkCnn0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARR2tGhpt7z+w4nvGg6HC8 SQpL7y+Pmc462nM+CMhu2i6S+23tIWaG/4UPCtddU0h/wKd6RJjz93xz04iV+/6KZb275MwZFMl gwgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This annotates struct fdtable's fd array with __counted_by_ptr so KASAN
and the fortified functions can bounds check it against max_fds and
adds a KUnit suite for fdtable. A follow-up uses __struct_size() in the
test since sparse doesn't know __builtin_dynamic_object_size().

FD_PREPARE() is simplified. It was built as an ACQUIRE-style guard on
infrastructure that was never needed. The ACQUIRE machinery and
CLASS_INIT() go away, the variable is declared with __cleanup()
directly, struct fd_prepare loses its err field since the fd either
holds the descriptor or the error, and callers get a const pointer to
the guard behind a UNIQUE_ID() name so they can't shadow it. Code
generation is identical.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This conflicts with mainline in fs/namespace.c between commit
7253a6ff640df ("namespace: drop the file's reference first in
dissolve_on_fput()") in mainline and commit 64cbb36448ff2 ("file: make
struct fd_prepare const and kill its err field") from this tree:

diff --cc fs/namespace.c
index 59fb227df39f,0f5c00816775..000000000000
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@@ -4701,9 -4544,9 +4701,9 @@@ SYSCALL_DEFINE3(fsmount, int, fs_fd, un
  
  	FD_PREPARE(fdf, (flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
  		   dentry_open(&new_path, O_PATH, fc->cred));
- 	if (fdf.err) {
+ 	if (fdf->fd < 0) {
 -		dissolve_on_fput(new_path.mnt);
 +		dissolve_on_fput(no_free_ptr(new_path.mnt));
- 		return fdf.err;
+ 		return fdf->fd;
  	}
  
  	/*

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.file

for you to fetch changes up to fae37d5e3c4e94aef334825ab89f66efcfe489b2:

  Merge patch series "file: simplify and harden cleanup handling" (2026-09-23 09:28:02 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.file

Please consider pulling these changes from the signed vfs-7.4-rc1.file tag.

Thanks!
Christian

----------------------------------------------------------------
Bill Wendling (2):
      vfs: Annotate struct fdtable's fd field with __counted_by_ptr
      vfs: Add KUnit tests for fdtable

Christian Brauner (7):
      Merge patch series "vfs: Annotate struct fdtable's fd field with __counted_by_ptr"
      vfs: use __struct_size() in the fdtable KUnit test
      file: simplify FD_PREPARE()
      file: declare the FD_PREPARE() variable with __cleanup() directly
      cleanup: remove CLASS_INIT()
      file: make struct fd_prepare const and kill its err field
      Merge patch series "file: simplify and harden cleanup handling"

 arch/powerpc/platforms/cell/spufs/inode.c |  12 +--
 drivers/gpio/gpiolib-cdev.c               |  18 ++---
 drivers/gpu/drm/msm/msm_perfcntr.c        |   4 +-
 drivers/media/mc/mc-request.c             |   8 +-
 drivers/misc/ntsync.c                     |   6 +-
 fs/Kconfig                                |   8 ++
 fs/eventfd.c                              |   4 +-
 fs/eventpoll.c                            |   6 +-
 fs/file.c                                 |  12 ++-
 fs/namespace.c                            |  12 +--
 fs/nsfs.c                                 |   4 +-
 fs/tests/.kunitconfig                     |   2 +
 fs/tests/fdtable_kunit.c                  |  72 +++++++++++++++++
 fs/xfs/xfs_handle.c                       |   6 +-
 include/linux/cleanup.h                   |   7 --
 include/linux/fdtable.h                   |   2 +-
 include/linux/file.h                      | 130 +++++++++++-------------------
 io_uring/mock_file.c                      |   8 +-
 kernel/bpf/bpf_iter.c                     |   6 +-
 kernel/bpf/token.c                        |   6 +-
 mm/userfaultfd.c                          |   6 +-
 net/core/scm.c                            |   8 +-
 net/handshake/netlink.c                   |   8 +-
 net/kcm/kcmsock.c                         |   6 +-
 24 files changed, 204 insertions(+), 157 deletions(-)
 create mode 100644 fs/tests/.kunitconfig
 create mode 100644 fs/tests/fdtable_kunit.c
