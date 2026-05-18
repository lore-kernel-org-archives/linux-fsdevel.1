Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5CC3D0BE5;
	Mon, 18 May 2026 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089787; cv=none; b=G6qPk38d7SGZ24iaMRe0cQ8lVYGMokL5e/A7hC6xxSZCxdXiJN5rvTnny3FAkZ4zMWAf4oOohCgJqd52nqpZ59YWp7U9WtYxpsyL9+sf/iUURCk7EVomuH+pVqFW3frbJzi2a2Gdg8kKbiJ536OkpxomYxhcZTf/0mv1zCj5/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089787; c=relaxed/simple;
	bh=xb9BlCblh67NNZ/oIEh4HPfAdBxpljrTYZquI60FKKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hz6yYqfoVEQrZJQVgrOGgm9jMEitX+vxNfu9v5cf2Bp9+XcK+rUXcZAzg2eHEiuP2VAIIFp7y7w5q3T4UwzxrnX/hHGsw8DBA5+dOrx/BFDZiBpT3p54dfqpaD+FMTc/R9U8Qgb+zsqYg7KrFz4/pZQyMyaSDADyXmTfrAY8I4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaul3VJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaul3VJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2259AC2BCB7;
	Mon, 18 May 2026 07:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779089787;
	bh=xb9BlCblh67NNZ/oIEh4HPfAdBxpljrTYZquI60FKKs=;
	h=From:To:Cc:Subject:Date:From;
	b=oaul3VJwfF/slX/qPkEHyAFZ4d5wOA+ECaFo9CldNsEIoVeg/+9CtoWSs1gFOk+bN
	 4M3QXIMvwcx/hz6kh9uLe20obwadTUHXFbf9YTgOTaGgif4yI1OSC6Di6kCRMiM2Qd
	 zN+cLzrdADxFzU0nm6F0t4QbBiyKyI2SSSwqQyeBK7mZPUHZx2OH2skBRM7mLwJPwX
	 ohDWtsPHxP7bZTwbs5L2KujJ+7Nl8/0gQ60NBcCtTtmYgcWJBKlbMZ0cDyOQrazxeO
	 S77fQAa0YYBWzvw9DImfbvzKLpMa8o02UaKpJAwEfv53AzMQB9DWR8HJ2ysYuQmZFZ
	 pz1EINoO6GySQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.1] vfs fixes
Date: Mon, 18 May 2026 09:35:59 +0200
Message-ID: <20260518-vfs-7.1-rc5.fixes-3eded3a501f4@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5935; i=brauner@kernel.org; h=from:subject:message-id; bh=xb9BlCblh67NNZ/oIEh4HPfAdBxpljrTYZquI60FKKs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRxHcxksjkfvL3gt69a7S2vt/94paqOzrlRnN8g3ON12 sTh9FeZjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsO8HIsJC54o1LocRSn7nh BQ48t3pFbs/81dTn3Lmq9nu3+cyecEaGNz92Tj7wacmG1zUX1wovfn5g65Zn7xwYtk4qiZs3tZi /jQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a fixes for the current development cycle. Note that AI
related review sometimes delays fixes a bit because we find more fixes
for the fixes. I might try and send smaller but more fixes PRs if this
trend keeps up.

- Fix various netfslib bugs

- Fix an out-of-bounds write when listing idmappings.

- Fix the return values in jfs_mkdir() and orangefs_mkdir().

- Fix a writeback writeback array overflow in fuse.

- Fix a forced iversion increment on lazytime timestamp updates

- Reject a negative timeval component in kern_select().

- Fix error return when vfs_mkdir() fails in the cachefiles code.

- Fix wrong error code returned for pidns ioctls.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc5.fixes

for you to fetch changes up to 8a220d1c312c66194f4a33dd52d1fba42bc2b341:

  cachefiles: Fix error return when vfs_mkdir() fails (2026-05-15 15:32:43 +0200)

----------------------------------------------------------------
vfs-7.1-rc5.fixes

Please consider pulling these changes from the signed vfs-7.1-rc5.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Breno Leitao (1):
      fs/select: reject negative timeval components in kern_select()

Christian Brauner (1):
      Merge patch series "netfs: Miscellaneous fixes"

David Howells (22):
      netfs: Fix cancellation of a DIO and single read subrequests
      netfs: Fix missing locking around retry adding new subreqs
      netfs: Fix missing barriers when accessing stream->subrequests locklessly
      netfs: Fix netfs_read_to_pagecache() to pause on subreq failure
      netfs: Fix potential for tearing in ->remote_i_size and ->zero_point
      netfs: Fix zeropoint update where i_size > remote_i_size
      netfs: Fix potential uninitialised var in netfs_extract_user_iter()
      netfs: Fix overrun check in netfs_extract_user_iter()
      netfs: Fix netfs_invalidate_folio() to clear dirty bit if all changes gone
      netfs: Defer the emission of trace_netfs_folio()
      netfs: Fix streaming write being overwritten
      netfs: Fix potential deadlock in write-through mode
      netfs: Fix read-gaps to remove netfs_folio from filled folio
      netfs: Fix write streaming disablement if fd open O_RDWR
      netfs: Fix early put of sink folio in netfs_read_gaps()
      netfs: Fix leak of request in netfs_write_begin() error handling
      netfs: Fix potential UAF in netfs_unlock_abandoned_read_pages()
      netfs: Fix partial invalidation of streaming-write folio
      netfs: Fix folio->private handling in netfs_perform_write()
      netfs: Fix netfs_read_folio() to wait on writeback
      netfs, afs: Fix write skipping in dir/link writepages
      afs: Fix the locking used by afs_get_link()

Hongling Zeng (2):
      fs: Fix return in jfs_mkdir and orangefs_mkdir
      cachefiles: Fix error return when vfs_mkdir() fails

Junxi Qian (1):
      fuse: fix writeback array overflow when max_pages is one

Junyoung Jang (1):
      fs/statmount: fix slab out-of-bounds write in statmount_mnt_idmap

Pankaj Raghav (1):
      fs: fix forced iversion increment on lazytime timestamp updates

Paulo Alcantara (1):
      netfs: fix error handling in netfs_extract_user_iter()

Viacheslav Dubeyko (1):
      netfs: fix VM_BUG_ON_FOLIO() issue in netfs_write_begin() call

Zhihao Cheng (1):
      nsfs: fix wrong error code returned for pidns ioctls

 fs/9p/v9fs_vfs.h             |  13 --
 fs/9p/vfs_inode.c            |   6 +-
 fs/9p/vfs_inode_dotl.c       |  12 +-
 fs/afs/Makefile              |   1 +
 fs/afs/dir.c                 |  79 +++++++-----
 fs/afs/file.c                |  24 +++-
 fs/afs/fsclient.c            |   4 +-
 fs/afs/inode.c               | 127 ++++---------------
 fs/afs/internal.h            |  45 ++++---
 fs/afs/symlink.c             | 278 ++++++++++++++++++++++++++++++++++++++++
 fs/afs/validation.c          |  14 +-
 fs/afs/write.c               |   2 +-
 fs/afs/yfsclient.c           |   4 +-
 fs/cachefiles/namei.c        |   2 +
 fs/fuse/file.c               |   5 +-
 fs/inode.c                   |   8 +-
 fs/jfs/namei.c               |   2 +-
 fs/mnt_idmapping.c           |   2 +
 fs/netfs/buffered_read.c     |  73 ++++++-----
 fs/netfs/buffered_write.c    | 174 ++++++++++++++++---------
 fs/netfs/direct_read.c       |  42 ++----
 fs/netfs/direct_write.c      |   6 +-
 fs/netfs/internal.h          |   3 +
 fs/netfs/iterator.c          |  41 ++++--
 fs/netfs/misc.c              |  41 ++++--
 fs/netfs/read_collect.c      |  19 ++-
 fs/netfs/read_retry.c        |  17 ++-
 fs/netfs/read_single.c       |  23 ++--
 fs/netfs/write_collect.c     |  15 ++-
 fs/netfs/write_issue.c       |  49 ++++---
 fs/netfs/write_retry.c       |   6 +-
 fs/nsfs.c                    |   2 +-
 fs/orangefs/namei.c          |   2 +-
 fs/select.c                  |  11 ++
 fs/smb/client/cifsfs.c       |  38 ++++--
 fs/smb/client/cifssmb.c      |   3 +-
 fs/smb/client/file.c         |  13 +-
 fs/smb/client/inode.c        |  14 +-
 fs/smb/client/readdir.c      |   3 +-
 fs/smb/client/smb2ops.c      |  42 +++---
 fs/smb/client/smb2pdu.c      |   3 +-
 include/linux/list.h         |  37 ++++++
 include/linux/netfs.h        | 295 +++++++++++++++++++++++++++++++++++++++++--
 include/trace/events/netfs.h |   8 ++
 44 files changed, 1171 insertions(+), 437 deletions(-)
 create mode 100644 fs/afs/symlink.c
