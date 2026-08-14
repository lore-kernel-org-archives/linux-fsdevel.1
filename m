Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078EC39CD10;
	Fri, 14 Aug 2026 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713203; cv=none; b=sAsjBf7ZknnnYwmMIvMH31MCNVcbFdfD1xhblKvdsIVWBpBqtyZ9C49XyLgZXyUbb7LqooPAqOv5wAGZ1YWN+L1NMD545BF/FV8YD5MMRlyi0KNfeFPHDkZYFfoAUbR5HShlB5pYArFbaw9IPO34nQMSkpnt2wrgxeFGoxAHnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713203; c=relaxed/simple;
	bh=P9611caXuFdg3L+KlPD/bBx+O5KKLkxSM5Wrpk14RWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn2M72//kuasnWP9NL/A2yIfrcbmAPDsIRVhzvR1m3HEpanG9YOQOw+vaPDXZaPyKbaJ24PuOkSAW/ZEKk5jSTWogh4U7dJ36heZZEmS2/molARvDJESI+O6EauSheYJ9Y/4fHc3kK72V/aGoMsF9J8io7dDHV6kWfHU+KJudjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN3kqCfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN3kqCfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD5C1F000E9;
	Fri, 14 Aug 2026 13:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713201;
	bh=10kRZrgFyLkV7Sxjtth/z4/OkUVt8JaNAIiQuq0acvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZN3kqCfSRO5PAL92IYIr3oqjAlTw100uIaUWZ1TNeGH9ULBt8uV3JAcgiPbLAWaVv
	 Yqh2iNUe3njNpjwDJh3BatovrV6hQUl9YFyRSUyQwZkoHjXRAH/kzWgZqMsDHuRn9+
	 ItnbYCq4okxEArD7LbWcgKHt3RxHOgokCnFZUBBAa2BGLidBH+3XvVZXL4l5k83ru0
	 BBVGMttqA8fwb4RxHib3vREOTTG6pPxJJ8utQSuZSoPVOYAmJH4/AJCwgx3tB2/4CJ
	 2Azfx+I1lwOIi7bgLCWwj36kd+OHHz3UaDzh7JPPxZlb5SCAtkaEe7x6xbXfP8/alY
	 tZJrEKG3VEqOA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 11/18 for v7.3] vfs lookup
Date: Fri, 14 Aug 2026 15:13:13 +0200
Message-ID: <20260814-vfs-7.3-rc1.lookup-945fe3fb6a45@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5149; i=brauner@kernel.org; h=from:subject:message-id; bh=P9611caXuFdg3L+KlPD/bBx+O5KKLkxSM5Wrpk14RWI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi2TPLb5zhId37cZXNdNfX35+yOWZevXh14WMRVwyv 7/eT64K6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIDBlGhq1x7i0Xikq9b7OH 8OydtHmbuNWe25LVPjmbLP+sv8Tr68zw30EmVnyPp9SRKYp7DtTeWFYY3bT70NK9Tvn34ioOBir MYQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This refactors lookup_open() and adds vfs_lookup_open() for nfsd.
mnt_want_write() and parent locking are moved into lookup_open()
itself.

audit_inode_child() is also now called in lookup_open() on failure. That
is the calling convention in vfs_create() and vfs_mkdir(), but
lookup_open() made no such call when atomic_open() should have created a
file and did not. And neither did the regular ->create() path fwiw.

This also contains work to remove the unneded excl argument from the
->create() inode op.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.lookup

for you to fetch changes up to 895741772f6ca989da565bcbe4673f12d3d0ac31:

  Merge patch series "fs/namei.c: comment and coding style fixups" (2026-07-31 10:37:40 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.lookup

Please consider pulling these changes from the signed vfs-7.3-rc1.lookup tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (6):
      Merge patch series "VFS: refactor lookup_open and add vfs_lookup()"
      Merge patch series "vfs: call audit_inode_child() in lookup_open() on failure"
      fs/namei.c: update stale comments in lookup_open()
      fs/namei.c: fix kerneldoc of atomic_open() and vfs_lookup_open()
      fs/namei.c: fix coding style in atomic_open() and lookup_open()
      Merge patch series "fs/namei.c: comment and coding style fixups"

Jori Koolstra (3):
      vfs: move create error && negative dentry case in lookup_open() up
      vfs: call audit_inode_child() in lookup_open() on failure
      fs/namei.c: update kerneldoc of atomic_open()

NeilBrown (4):
      VFS: move mnt_want_write() and locking into lookup_open()
      VFS: move delegated_inode retry loop into lookup_open()
      VFS: add vfs_lookup_open() for nfsd
      Remove excl arg to ->create inode_operation

 Documentation/filesystems/locking.rst |   2 +-
 Documentation/filesystems/porting.rst |   8 +
 Documentation/filesystems/vfs.rst     |   2 +-
 fs/9p/vfs_inode.c                     |   3 +-
 fs/9p/vfs_inode_dotl.c                |   3 +-
 fs/affs/affs.h                        |   2 +-
 fs/affs/namei.c                       |   2 +-
 fs/afs/dir.c                          |   4 +-
 fs/bad_inode.c                        |   2 +-
 fs/bfs/dir.c                          |   2 +-
 fs/btrfs/inode.c                      |   2 +-
 fs/ceph/dir.c                         |   2 +-
 fs/coda/dir.c                         |   2 +-
 fs/ecryptfs/inode.c                   |   2 +-
 fs/efivarfs/inode.c                   |   2 +-
 fs/exfat/namei.c                      |   2 +-
 fs/ext2/namei.c                       |   2 +-
 fs/ext4/namei.c                       |   2 +-
 fs/f2fs/namei.c                       |   2 +-
 fs/fat/namei_msdos.c                  |   2 +-
 fs/fat/namei_vfat.c                   |   2 +-
 fs/fuse/dir.c                         |   2 +-
 fs/gfs2/inode.c                       |   5 +-
 fs/hfs/dir.c                          |   2 +-
 fs/hfsplus/dir.c                      |   2 +-
 fs/hostfs/hostfs_kern.c               |   2 +-
 fs/hpfs/namei.c                       |   2 +-
 fs/hugetlbfs/inode.c                  |   2 +-
 fs/jffs2/dir.c                        |   4 +-
 fs/jfs/namei.c                        |   2 +-
 fs/minix/namei.c                      |   2 +-
 fs/namei.c                            | 351 ++++++++++++++++++++++++----------
 fs/nfs/dir.c                          |   4 +-
 fs/nfs/internal.h                     |   2 +-
 fs/nilfs2/namei.c                     |   2 +-
 fs/ntfs/namei.c                       |   2 +-
 fs/ntfs3/namei.c                      |   2 +-
 fs/ocfs2/dlmfs/dlmfs.c                |   3 +-
 fs/ocfs2/namei.c                      |   3 +-
 fs/omfs/dir.c                         |   2 +-
 fs/orangefs/namei.c                   |   3 +-
 fs/overlayfs/dir.c                    |   2 +-
 fs/ramfs/inode.c                      |   2 +-
 fs/smb/client/cifsfs.h                |   2 +-
 fs/smb/client/dir.c                   |   2 +-
 fs/ubifs/dir.c                        |   2 +-
 fs/udf/namei.c                        |   2 +-
 fs/ufs/namei.c                        |   3 +-
 fs/vboxsf/dir.c                       |   4 +-
 fs/xfs/xfs_iops.c                     |   5 +-
 include/linux/fs.h                    |   2 +-
 include/linux/namei.h                 |   3 +
 ipc/mqueue.c                          |   2 +-
 mm/shmem.c                            |   2 +-
 54 files changed, 313 insertions(+), 171 deletions(-)
