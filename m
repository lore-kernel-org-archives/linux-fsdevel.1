Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471F3FE351;
	Fri, 14 Aug 2026 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713299; cv=none; b=WeRiPA0ZsCuy6wM3iBsE8i4Em2l7+sIN/8LzDLAMd+mi6ArL5w6VZlXjAPxQqdnYGDGBxOp8oKFJI0Uw9wQTQSwDkQpzTj7vbsV+SHtrl1ZOMHSiE2Fjpwy0z7fWFPQK3uBTTQ3Nr9iqIsDuliDJ0mtw2ZLGrDjgRob54fGgEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713299; c=relaxed/simple;
	bh=DtOIzN0nlkf2AkZB94McgXv0Euhl5BUiS9BQekZvw0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MewBfwJ14nOsRyTxObQeSVzYdgc6Iw6i+XN+u3LU9fMGCmFU7K5CTTJCDsyZZSjqySg5GcJZYF3FQVD4ZduFcqVDHZqemDhlXImphu6XpqnKPFxNBNwMDM6jd1pu4Qb1nSfw+Zd18Vb/zPXmEJ4i3Ut47QTCA9edR47DJPo5Oyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddWwXUrg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddWwXUrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB891F000E9;
	Fri, 14 Aug 2026 13:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713297;
	bh=6GglcKFx1Bq8AfSOI7sVeqt3eGDeePzY1BG05m101SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ddWwXUrg/e785jrOJOglvlE8MB12bKaqdtCk51oZy1YaIq4WFREuu5yKub0/ovEzh
	 PUxASneJqzlzK77u2XlSeaJ5H8Pp74e0odmlJOA4yC8HvJM43DtBpLLQmDxy6TXqRD
	 K9FFcxiwq83LZtrAVUGU4kyYSXPOiCOnGxFzjJ0YuIbp+bvdulQPo9rxoktbsWaGqL
	 c2JWFIm0LsWrKMySINVSSh1wOBz71sO5yF2bUlMa9e0eI2TrGGvZXXHtrpwWorUpIx
	 lN6GPuAEQlV/7e9Vh5+s0FK11qI+dYvjz+Uc4UnVVExQqnYXJcZepcFqey+U+XWsI/
	 skdwvocA84o3g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 17/18 for v7.3] vfs super
Date: Fri, 14 Aug 2026 15:14:46 +0200
Message-ID: <20260814-vfs-7.3-rc1.super-03a7095ebb84@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7863; i=brauner@kernel.org; h=from:subject:message-id; bh=DtOIzN0nlkf2AkZB94McgXv0Euhl5BUiS9BQekZvw0o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi5wqNBOvCKkWDT1ixJB1LSzmo6ju2x+ykt1mBf6GZ 1oMJfd0lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATCTfnOGfgspJ6Us/X9ydN3WS y9TaIyWfwzZ8/spy5M+Gq2aX52/7UMzwz4Cpd//Pa6LTgz2FzO9wVDcarvfxOhNbrBy7qXPtifX 1jAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

- Make it possible to share a block device between multiple filesystems.
  erofs can mount read-only blob devices shared between many
  superblocks. Because we only tracked a single superblock a freeze,
  thaw, removal or sync on such a device was never propagated to all the
  superblocks using it, and there was no way to find them. So add an
  efficient table to lookup all superblocks using a given block device.

- A bunch of pre-existing fixes fell out of this work. A block-device
  freeze racing a btrfs device change could leave the whole filesystem
  stuck frozen. A bdev_freeze() issued by "dmsetup suspend" or an LVM
  snapshot resolves that holder to freeze the filesystem. and
  bdev_thaw() resolves it again to thaw. A freeze landing while btrfs is
  adding, removing or replacing a device freezes the filesystem. The
  membership change then drops that link. So the matching thaw could no
  longer find the superblock.

  Forbid freezing a device for the duration of a membership change,
  modelled on deny_write_access()/allow_write_access().

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

[1]: https://lore.kernel.org/linux-next/ak4urgJRb-83KEUI@sirena.org.uk

This conflicts with commit d943e68edc5cb ("selftests/filesystems:
test O_TMPFILE creation on idmapped mounts") in
tools/testing/selftests/filesystems/Makefile and
tools/testing/selftests/filesystems/.gitignore. Both that commit and
commit a21db4dcaf4ad ("selftests/filesystems: add ustat() coverage")
from this tree register a new selftest on the same two lines. The
conflict resolves by keeping both.

This tag additionally conflicts with two of the earlier tags in this
pull request series, so please merge it after them:

  - with vfs-7.3-rc1.mount
  - with vfs-7.3-rc1.misc

Both resolve by keeping both sides.

diff --cc fs/namespace.c
index 3c382c2bdeec,7cef6dae0854..1ecd96c918b3
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@@ -6270,6 -6259,11 +6270,8 @@@ void __init mnt_init(void
  				HASH_ZERO,
  				&mp_hash_shift, &mp_hash_mask, 0, 0);
  
 -	if (!mount_hashtable || !mountpoint_hashtable)
 -		panic("Failed to allocate mount hash table\n");
 -
+ 	super_dev_init();
+ 
  	kernfs_init();
  
  	err = sysfs_init();
diff --cc fs/super.c
index 2c52c321885f,a62af36f7aaf..05e443173038
--- a/fs/super.c
+++ b/fs/super.c
@@@ -24,7 -24,7 +24,8 @@@
  #include <linux/export.h>
  #include <linux/slab.h>
  #include <linux/blkdev.h>
 +#include <linux/memcontrol.h>
+ #include <linux/rhashtable.h>
  #include <linux/mount.h>
  #include <linux/security.h>
  #include <linux/writeback.h>		/* for the emergency remount stuff */
diff --cc tools/testing/selftests/filesystems/.gitignore
index a78f894157de,1bd53d54553c..9eb185fb2f9d
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@@ -5,4 -5,4 +5,5 @@@ fclo
  file_stressor
  anon_inode_test
  kernfs_test
 +idmapped_tmpfile
+ ustat_test
diff --cc tools/testing/selftests/filesystems/Makefile
index a7ec2ba2dd83,bbdd40b167fa..03be337c1f35
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@@ -1,8 -1,7 +1,8 @@@
  # SPDX-License-Identifier: GPL-2.0
  
  CFLAGS += $(KHDR_INCLUDES)
- TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
+ TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog ustat_test
 +TEST_GEN_PROGS += idmapped_tmpfile
  TEST_GEN_PROGS_EXTENDED := dnotify_test
  
  include ../lib.mk

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.super

for you to fetch changes up to 9ac8fd831252e52aa78399eaccc11a72f6c2af1a:

  super: fix dying superblock warning messages (2026-08-12 09:20:35 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.super

Please consider pulling these changes from the signed vfs-7.3-rc1.super tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (24):
      block: allow making a block device unfreezable
      block: split bdev_yield_claim() out of bdev_fput()
      btrfs: deny freezing a device while it is being removed
      btrfs: deny freezing a device while it is being added
      btrfs: deny freezing devices undergoing a replace
      Merge patch series "block,btrfs: fix frozen-superblock strand on device add/remove/replace"
      super: convert s_count to refcount_t s_passive
      super: take lock after last reference count
      fs, block: move blk_mode_t and fop_flags_t into <linux/types.h>
      ext4: use anonymous devices for KUnit test superblocks
      ocfs2: don't reset s_dev on dismount
      fs: maintain a global device-to-superblock table
      fs: add dedicated block device open helpers for filesystems
      xfs: port to fs_bdev_file_open_by_path()
      btrfs: open via dedicated fs bdev helpers
      ext4: open via dedicated fs bdev helpers
      fs: look up superblocks via the device table in fs_holder_ops
      fs: tolerate per-superblock freeze errors on shared devices
      erofs: open via dedicated fs bdev helpers
      f2fs: open via dedicated fs bdev helpers
      super: make fs_holder_ops private
      fs: look up the superblock via the device table in user_get_super()
      selftests/filesystems: add ustat() coverage
      Merge patch series "fs: support freeze/thaw/mark_dead/sync with shared devices"

Karl Mehltretter (1):
      super: fix dying superblock warning messages

Yun Zhou (1):
      block: reject block device inodes with i_rdev == 0 in lookup_bdev()

 block/bdev.c                                     | 125 ++++-
 fs/btrfs/dev-replace.c                           |  65 ++-
 fs/btrfs/ioctl.c                                 |   4 +-
 fs/btrfs/volumes.c                               | 105 +++-
 fs/btrfs/volumes.h                               |   6 +-
 fs/cramfs/inode.c                                |   2 +-
 fs/erofs/super.c                                 |  35 +-
 fs/ext4/extents-test.c                           |   9 +-
 fs/ext4/mballoc-test.c                           |   9 +-
 fs/ext4/super.c                                  |  12 +-
 fs/f2fs/super.c                                  |   6 +-
 fs/internal.h                                    |   1 +
 fs/namespace.c                                   |   2 +
 fs/ocfs2/super.c                                 |   1 -
 fs/romfs/super.c                                 |   2 +-
 fs/super.c                                       | 624 ++++++++++++++++-------
 fs/xfs/xfs_buf.c                                 |   2 +-
 fs/xfs/xfs_super.c                               |  10 +-
 include/linux/blk_types.h                        |   2 +-
 include/linux/blkdev.h                           |  12 +-
 include/linux/fs.h                               |   2 -
 include/linux/fs/super.h                         |   8 +
 include/linux/fs/super_types.h                   |   4 +-
 include/linux/types.h                            |   2 +
 tools/testing/selftests/filesystems/.gitignore   |   1 +
 tools/testing/selftests/filesystems/Makefile     |   2 +-
 tools/testing/selftests/filesystems/ustat_test.c | 135 +++++
 27 files changed, 882 insertions(+), 306 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/ustat_test.c
