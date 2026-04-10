Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB974C14;
	Fri, 10 Apr 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834117; cv=none; b=niAcKYEfoXqKWRT6QufuRfCgAJBq7AGHcDjZi79wL1kR2tBJ8lznHrZ/04XzUrOT29gX6ENnoHoOEg8PGiIc4vlR8r0Rx8LIK++XgEcCR+B0rdLxnykVg+VkQumh306BvCwVrUc4ivAb/tXdc//XhWVJAUcFs8tZZqn2+XxYRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834117; c=relaxed/simple;
	bh=+s8UCQ7e7KipXT0+I2OPxRc8iFd4hRF22+8RJKTSRQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mk950AXZCG7Yo+twaJgEddZ9aNn+2nPAWwgGKkgsKpGBEa05+HW2M3hnRhODgA7yiJoNwfHNR8LFsycmC/Md7h3mTw/Qp85+JpZSXW3kTZi9DUaduH2xGQuzBT8aN2gNDlRvLU7nLZPg+V4zK/OjlADTiah07l3ySP03dWjE+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU7RR5jT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU7RR5jT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A80BC19421;
	Fri, 10 Apr 2026 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834117;
	bh=+s8UCQ7e7KipXT0+I2OPxRc8iFd4hRF22+8RJKTSRQA=;
	h=From:To:Cc:Subject:Date:From;
	b=QU7RR5jTZ0pV9FnU3uTqDO9EeyCoFAj7pGCkqY3tyFXiexiKlUTpQEUDguRGUS9Za
	 fL1kqJDE1HAX7bDyln35hqBzT74VypZLx+Y6EyyEhRJ77W1UcUznfhHhQ9gTeSATvB
	 FyBWKjtoRfoDDK0Gc+27NvF82NTrv5EEcxIkXlvKW3jPfMdWDLFrwJ58F/4DDfrBZe
	 xAxZKkGQGcHWAwSqay0bpI/Cdrna4QUlGA6IRRYD9auuwhQ6QYZQ328c4RBzPYiC6m
	 Hlx2L4/cbdjPS3kEOPjll4s8qeTrENwQBU9/gmtB3Ue8gxBEmo/czMTUqhQmD3IIvz
	 +ajutW//3lPPw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.0] vfs fixes
Date: Fri, 10 Apr 2026 17:14:49 +0200
Message-ID: <20260410-vfs-fixes-52296d845868@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3900; i=brauner@kernel.org; h=from:subject:message-id; bh=+s8UCQ7e7KipXT0+I2OPxRc8iFd4hRF22+8RJKTSRQA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFH4vk9Db3tO/2F7G+cGz6LjADbu/NV+/+D/qXNGx7 4vOTP1ws6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi8ycy/DPw2Gsq0m0v7Tkz 3XZi3855MeU7KkrYdEvumMfJ9c2b+ICRodv88pTgRg3HzbzPEzmOsBzw7zV9Y+Pd6+1cJXva/Dc nIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a batch of late-stage fixes for this cycle. The kernfs
rework can also go into during the v7.2 merge window. In which case you
can either just cherry-pick the cachefiles and epoll fix.

The kernfs rbtree is keyed by (hash, ns, name) where the hash is seeded
with the raw namespace pointer via init_name_hash(ns). The resulting
hash values are exposed to userspace through readdir seek positions, and
the pointer-based ordering in kernfs_name_compare() is observable
through entry order.

Switch from raw pointers to ns_common::ns_id for both hashing and
comparison. A preparatory commit first replaces all const void *
namespace parameters with const struct ns_common * throughout
kernfs/sysfs/kobject so the code can access ns->ns_id. Also compare the
ns_id when hashes match in the rbtree to handle crafted collisions.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit d0c3bcd5b8976159d835a897254048e078f447e6:

  Merge tag 'libcrypto-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux (2026-03-30 13:40:48 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc8.fixes

for you to fetch changes up to cb76a81c7cec37bdf525164561b02665cd763421:

  kernfs: make directory seek namespace-aware (2026-04-09 14:36:52 +0200)

----------------------------------------------------------------
vfs-7.0-rc8.fixes

Please consider pulling these changes from the signed vfs-7.0-rc8.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (3):
      kernfs: pass struct ns_common instead of const void * for namespace tags
      kernfs: use namespace id instead of pointer for hashing and comparison
      kernfs: make directory seek namespace-aware

NeilBrown (1):
      cachefiles: fix incorrect dentry refcount in cachefiles_cull()

Nicholas Carlini (1):
      eventpoll: defer struct eventpoll free to RCU grace period

 drivers/base/class.c                |  4 +--
 drivers/base/core.c                 |  7 ++--
 drivers/infiniband/core/device.c    |  5 +--
 drivers/infiniband/ulp/srp/ib_srp.c |  7 ++--
 drivers/net/bonding/bond_sysfs.c    |  4 +--
 drivers/net/ipvlan/ipvtap.c         |  5 +--
 drivers/net/macvtap.c               |  5 +--
 fs/cachefiles/namei.c               |  5 +++
 fs/eventpoll.c                      |  6 +++-
 fs/kernfs/dir.c                     | 68 ++++++++++++++++++++++++++-----------
 fs/kernfs/file.c                    |  2 +-
 fs/kernfs/kernfs-internal.h         |  2 +-
 fs/kernfs/mount.c                   |  2 +-
 fs/nfs/sysfs.c                      | 16 +++++----
 fs/sysfs/dir.c                      |  6 ++--
 fs/sysfs/file.c                     |  8 ++---
 fs/sysfs/mount.c                    | 10 +++---
 fs/sysfs/symlink.c                  |  7 ++--
 fs/sysfs/sysfs.h                    |  4 +--
 include/linux/device/class.h        |  6 ++--
 include/linux/kernfs.h              | 40 +++++++++++++---------
 include/linux/kobject.h             |  4 +--
 include/linux/kobject_ns.h          | 13 +++----
 include/linux/netdevice.h           |  4 +--
 include/linux/sysfs.h               | 24 ++++++-------
 include/net/net_namespace.h         |  8 ++---
 lib/kobject.c                       |  8 ++---
 lib/kobject_uevent.c                | 13 ++++---
 net/core/net-sysfs.c                | 50 +++++++++++++--------------
 net/core/net_namespace.c            |  8 ++---
 net/sunrpc/sysfs.c                  | 17 ++++++----
 net/wireless/sysfs.c                |  4 +--
 32 files changed, 216 insertions(+), 156 deletions(-)
