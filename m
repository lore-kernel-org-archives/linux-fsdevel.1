Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF303DA5B3;
	Fri, 10 Apr 2026 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834200; cv=none; b=amtqOK+M+PuF8ffOmhPTuqsuxcVyzia+DqRtRFSc9hIrmJKdFDP7g2uvdMn9Rq7AIejxXZmEM0U7vulh42MIJfKkbwlMeGZgGHh/p1Vge/XFX6PrhNBXsfRCbIlVgvsqHh7PucvpUD8xajf0xkvO7L+K5wq/WZQqxvVMIAVSVPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834200; c=relaxed/simple;
	bh=ouBz9XS6IK9U9PkSEL1EJ5UnsvbkKel3/U0qkAHagCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOkKfHPyxhauwu1Fr7wFT1pYMrQYlzl6WM0QIqHsiyIS/SoNGFy5YKBOFoFWOW1E4ewlDZh5MBNR/YJidyqKVN5nManMZJXs/DGk+VtPxgRtMt4sUUvrZvyJnYMu7TaGtcnSlRvbOaUWb98DliLWXDy7J2KEuEenAoGh20yCWhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PomoGY0F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PomoGY0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9F1C19421;
	Fri, 10 Apr 2026 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834199;
	bh=ouBz9XS6IK9U9PkSEL1EJ5UnsvbkKel3/U0qkAHagCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PomoGY0F3P4hAFsBPJo9Q44bY3dyQWHZP9Zq7Ci64nBElDhYidCsF4/6jpN1rms84
	 EnPRYtTXWiPzgxdnQs9vbh+sD8wB+aHFd/F9p8p3+xZn3psPWSjHfZeLddO5pA/Lf+
	 XMUJH5iZKhip6m8XN0wXBwsZqaXOb/pCzXDNuV/br84Z3WjJSl6E4K1fxHf7qjsKuB
	 N7v8xN/sNmyw2gtWmecHlbjSzqkJ/wcLouWYZBgO43r+UzCCUS3+Kh6H1bDodhlUwE
	 +P/H9IwikRYuitfap9ATp09/ZAKkK0LHqL+iDx5hbOtZiDI9X5eyYh95G6syjsCZMV
	 DxOfMFWlQGkoQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 02/12 for v7.1] vfs xattr
Date: Fri, 10 Apr 2026 17:16:30 +0200
Message-ID: <20260410-vfs-xattr-v71-9b287a50d751@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6258; i=brauner@kernel.org; h=from:subject:message-id; bh=ouBz9XS6IK9U9PkSEL1EJ5UnsvbkKel3/U0qkAHagCg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFAkMTL7KWP9r9/vtGvsvRAet+7c1ojF/defF/ceDF u301LW51VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRzQcZGdaeV/Y3mbD8z4LV Abzf/ia86pkl9u+TgbL3nDj+P/ySLZyMDK9MN+17qs254fz3L7YHpr1yXnk81ub3f6YtZmwZil2 1kgwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Rework simple xattrs and support user.* xattrs on sockets
This reworks the simple_xattr infrastructure and adds support for
user.* extended attributes on sockets.

The simple_xattr subsystem currently uses an rbtree protected by a
reader-writer spinlock. This series replaces the rbtree with an
rhashtable giving O(1) average-case lookup with RCU-based lockless
reads. This sped up concurrent access patterns on tmpfs quite a bit
and it's an overall easy enough conversion to do and gets rid or
rwlock_t.

The conversion is done incrementally: a new rhashtable path is added
alongside the existing rbtree, consumers are migrated one at a time
(shmem, kernfs, pidfs), and then the rbtree code is removed. All three
consumers switch from embedded structs to pointer-based lazy
allocation so the rhashtable overhead is only paid for inodes that
actually use xattrs.

With this infrastructure in place the series adds support for user.*
xattrs on sockets. Path-based AF_UNIX sockets inherit xattr support
from the underlying filesystem (e.g. tmpfs) but sockets in sockfs -
that is everything created via socket() including abstract namespace
AF_UNIX sockets - had no xattr support at all.

The xattr_permission() checks are reworked to allow user.* xattrs on
S_IFSOCK inodes. Sockfs sockets get per-inode limits of 128 xattrs and
128KB total value size matching the limits already in use for kernfs.

The practical motivation comes from several directions. systemd and
GNOME are expanding their use of Varlink as an IPC mechanism. For
D-Bus there are tools like dbus-monitor that can observe IPC traffic
across the system but this only works because D-Bus has a central
broker. For Varlink there is no broker and there is currently no way
to identify which sockets speak Varlink. With user.* xattrs on sockets
a service can label its socket with the IPC protocol it speaks (e.g.,
user.varlink=1) and an eBPF program can then selectively capture
traffic on those sockets. Enumerating bound sockets via netlink
combined with these xattr labels gives a way to discover all Varlink
IPC entrypoints for debugging and introspection.

Similarly, systemd-journald wants to use xattrs on the /dev/log socket
for protocol negotiation to indicate whether RFC 5424 structured
syslog is supported or whether only the legacy RFC 3164 format should
be used.

In containers these labels are particularly useful as high-privilege
or more complicated solutions for socket identification aren't
available.

The series comes with comprehensive selftests covering path-based
AF_UNIX sockets, sockfs socket operations, per-inode limit
enforcement, and xattr operations across multiple address families
(AF_INET, AF_INET6, AF_NETLINK, AF_PACKET).

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

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.xattr

for you to fetch changes up to 98779186aa0b3367489a87c6d8bc0911f577444e:

  Merge patch series "xattr: rework simple xattrs and support user.* xattrs on sockets" (2026-03-02 11:06:43 +0100)

----------------------------------------------------------------
vfs-7.1-rc1.xattr

Please consider pulling these changes from the signed vfs-7.1-rc1.xattr tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (15):
      xattr: add rcu_head and rhash_head to struct simple_xattr
      xattr: add rhashtable-based simple_xattr infrastructure
      shmem: adapt to rhashtable-based simple_xattrs with lazy allocation
      kernfs: adapt to rhashtable-based simple_xattrs with lazy allocation
      pidfs: adapt to rhashtable-based simple_xattrs
      xattr: remove rbtree-based simple_xattr infrastructure
      xattr: add xattr_permission_error()
      xattr: switch xattr_permission() to switch statement
      xattr: move user limits for xattrs to generic infra
      xattr,net: support limited amount of extended attributes on sockfs sockets
      xattr: support extended attributes on sockets
      selftests/xattr: path-based AF_UNIX socket xattr tests
      selftests/xattr: sockfs socket xattr tests
      selftests/xattr: test xattrs on various socket families
      Merge patch series "xattr: rework simple xattrs and support user.* xattrs on sockets"

 fs/kernfs/dir.c                                    |  15 +-
 fs/kernfs/inode.c                                  |  99 +----
 fs/kernfs/kernfs-internal.h                        |   5 +-
 fs/pidfs.c                                         |  64 +--
 fs/xattr.c                                         | 423 +++++++++++++------
 include/linux/kernfs.h                             |   2 -
 include/linux/shmem_fs.h                           |   2 +-
 include/linux/xattr.h                              |  47 ++-
 mm/shmem.c                                         |  46 +-
 net/socket.c                                       | 119 ++++--
 .../testing/selftests/filesystems/xattr/.gitignore |   3 +
 tools/testing/selftests/filesystems/xattr/Makefile |   6 +
 .../filesystems/xattr/xattr_socket_test.c          | 470 +++++++++++++++++++++
 .../filesystems/xattr/xattr_socket_types_test.c    | 177 ++++++++
 .../filesystems/xattr/xattr_sockfs_test.c          | 363 ++++++++++++++++
 15 files changed, 1546 insertions(+), 295 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/xattr/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/xattr/Makefile
 create mode 100644 tools/testing/selftests/filesystems/xattr/xattr_socket_test.c
 create mode 100644 tools/testing/selftests/filesystems/xattr/xattr_socket_types_test.c
 create mode 100644 tools/testing/selftests/filesystems/xattr/xattr_sockfs_test.c
