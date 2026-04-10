Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054083E3D88;
	Fri, 10 Apr 2026 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834372; cv=none; b=vFsAesrrBbsN6aOjK/ZGv5jAweVshqqL4fnB+K1ynkJN323I5OaGAYgYn3n4dDg0GAP7HiW6C/aTw+X7JHUs43vWN0JjYDn7fTunGAdUPS8KOC2x6hTdby0wa52CbS39EDylFeyBAs63pOiUlK7c7JruFAZlONgoAUm1cbWUOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834372; c=relaxed/simple;
	bh=lOmsCeiPL+1W5z4WX8TMBhDgJeDgyLjBvK8/8rMuhyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6YMDicBAcn1Sc9PWty/985vV0u7y4i0UuqdxPMUArOE14XOgYgeKeZWPYdaGYxBoeXEAinyuRvWc+Eq2pTy2ey/OGB0SPjJ6YibEkBZXP9hNHexlUH9cOmTs0gj4RAbqVC8oSlmVQ+XKRGA5ETHGwBJQ841514HRtaCNU1sbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkA7laL+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkA7laL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5E8C2BC87;
	Fri, 10 Apr 2026 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834371;
	bh=lOmsCeiPL+1W5z4WX8TMBhDgJeDgyLjBvK8/8rMuhyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkA7laL+KOnw4oOKRSKGE3hTwr8TL3Xdk9wIeRXM+2MJTSD+4b66auz1ClArpIpEp
	 kjHPyjG/5w5HqaykgRsVZeH5SlN+YsvBCRFKnAYsAbyz0jKgDpdrHQUzLLyXD9tvcD
	 u8hQiOA4RHHqct/wDoQtuqVpQyDY+s1DD+Z5ehFkmB+bfU6s7ZdKxOjtqAAp9b9EzX
	 LbvA9iR2gj7ntIXEz7M5E8kMEFsUqzIV92CdRx289+JZFqYQjqF86lQ+qhYzSTQ5Ed
	 VJrHFxfwNgnSvJjON4oaY8G0HjBHvQHyHWY70o9mqup6bOgp/wX749KY/tZ9q2cV49
	 KaBGhucyl+XDQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 08/12 for v7.1] vfs bh metadata
Date: Fri, 10 Apr 2026 17:19:24 +0200
Message-ID: <20260410-vfs-bh-metadata-v71-f0c1c7c747fc@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7918; i=brauner@kernel.org; h=from:subject:message-id; bh=lOmsCeiPL+1W5z4WX8TMBhDgJeDgyLjBvK8/8rMuhyo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFPlXqX+d0UxhJ0PcZuMN++7P8be/UFDAMmXVofWt9 d7XxTXbO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby05OR4efJ7yfVlmZrdIg7 Wx+c+c28Sb/lTG7Gbvv+5VcXlZl52jIyzNnNLFC94cX7rW7OcwPqmKcc+74uiWN+YvVS5ZmKd75 84wUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

The work in this pr cleans up the mess that has accumulated over the
years in metadata buffer_head tracking for inodes, moves the tracking
into dedicated structure in filesystem-private part of the inode (so
that we don't use private_list, private_data, and private_lock in struct
address_space), and also moves couple other users of private_data and
private_list so these are removed from struct address_space saving 3
longs in struct inode for 99% of inodes.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

diff --cc fs/ext4/fsync.c
index bd8f230fa507,aa80af2b4eea..000000000000
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@@ -83,23 -83,12 +83,23 @@@ static int ext4_fsync_nojournal(struct
                                int datasync, bool *needs_barrier)
  {
        struct inode *inode = file->f_inode;
 +      struct writeback_control wbc = {
 +              .sync_mode = WB_SYNC_ALL,
 +              .nr_to_write = 0,
 +      };
        int ret;

-       ret = generic_buffers_fsync_noflush(file, start, end, datasync);
+       ret = mmb_fsync_noflush(file, &EXT4_I(inode)->i_metadata_bhs,
+                               start, end, datasync);
 -      if (!ret)
 -              ret = ext4_sync_parent(inode);
 +      if (ret)
 +              return ret;
 +
 +      /* Force writeout of inode table buffer to disk */
 +      ret = ext4_write_inode(inode, &wbc);
 +      if (ret)
 +              return ret;
 +
 +      ret = ext4_sync_parent(inode);
-
        if (test_opt(inode->i_sb, BARRIER))
                *needs_barrier = true;

Merge conflicts with other trees
================================

[1]: https://lore.kernel.org/linux-next/aca_9wyB29931jgP@sirena.co.uk
[2]: https://lore.kernel.org/linux-next/acbAlnfUcjBSLNpt@sirena.co.uk

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.bh.metadata

for you to fetch changes up to 6e22726900ea54d72cbc6f053c0fa581de023de6:

  Merge patch series "fs: Move metadata bh tracking from address_space" (2026-03-26 15:03:38 +0100)

----------------------------------------------------------------
vfs-7.1-rc1.bh.metadata

Please consider pulling these changes from the signed vfs-7.1-rc1.bh.metadata tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "fs: Move metadata bh tracking from address_space"

Jan Kara (42):
      ext4: Use inode_has_buffers()
      gfs2: Don't zero i_private_data
      ntfs3: Drop pointless sync_mapping_buffers() and invalidate_inode_buffers() calls
      ocfs2: Drop pointless sync_mapping_buffers() calls
      bdev: Drop pointless invalidate_inode_buffers() call
      ufs: Drop pointless invalidate_mapping_buffers() call
      exfat: Drop pointless invalidate_inode_buffers() call
      fs: Remove inode lock from __generic_file_fsync()
      udf: Switch to generic_buffers_fsync()
      minix: Switch to generic_buffers_fsync()
      bfs: Switch to generic_buffers_fsync()
      fat: Switch to generic_buffers_fsync_noflush()
      fs: Drop sync_mapping_buffers() from __generic_file_fsync()
      fs: Rename generic_file_fsync() to simple_fsync()
      fat: Sync and invalidate metadata buffers from fat_evict_inode()
      udf: Sync and invalidate metadata buffers from udf_evict_inode()
      minix: Sync and invalidate metadata buffers from minix_evict_inode()
      ext2: Sync and invalidate metadata buffers from ext2_evict_inode()
      ext4: Sync and invalidate metadata buffers from ext4_evict_inode()
      bfs: Sync and invalidate metadata buffers from bfs_evict_inode()
      affs: Sync and invalidate metadata buffers from affs_evict_inode()
      fs: Ignore inode metadata buffers in inode_lru_isolate()
      fs: Stop using i_private_data for metadata bh tracking
      hugetlbfs: Stop using i_private_data
      aio: Stop using i_private_data and i_private_lock
      fs: Remove i_private_data
      kvm: Use private inode list instead of i_private_list
      fs: Drop osync_buffers_list()
      fs: Fold fsync_buffers_list() into sync_mapping_buffers()
      fs: Move metadata bhs tracking to a separate struct
      fs: Make bhs point to mapping_metadata_bhs
      fs: Switch inode_has_buffers() to take mapping_metadata_bhs
      fs: Provide functions for handling mapping_metadata_bhs directly
      ext2: Track metadata bhs in fs-private inode part
      affs: Track metadata bhs in fs-private inode part
      bfs: Track metadata bhs in fs-private inode part
      fat: Track metadata bhs in fs-private inode part
      udf: Track metadata bhs in fs-private inode part
      minix: Track metadata bhs in fs-private inode part
      ext4: Track metadata bhs in fs-private inode part
      fs: Drop mapping_metadata_bhs from address space
      fs: Drop i_private_list from address_space

 block/bdev.c                |   8 -
 fs/adfs/dir.c               |   2 +-
 fs/adfs/file.c              |   2 +-
 fs/affs/affs.h              |   2 +
 fs/affs/amigaffs.c          |  12 +-
 fs/affs/file.c              |  25 +--
 fs/affs/inode.c             |  14 +-
 fs/affs/namei.c             |   9 +-
 fs/affs/super.c             |   1 +
 fs/aio.c                    |  78 ++++++--
 fs/bfs/bfs.h                |   1 +
 fs/bfs/dir.c                |  16 +-
 fs/bfs/inode.c              |   6 +-
 fs/buffer.c                 | 454 +++++++++++++++++---------------------------
 fs/exfat/file.c             |   2 +-
 fs/exfat/inode.c            |   1 -
 fs/ext2/ext2.h              |   1 +
 fs/ext2/file.c              |   6 +-
 fs/ext2/inode.c             |  17 +-
 fs/ext2/super.c             |   1 +
 fs/ext4/ext4.h              |   1 +
 fs/ext4/ext4_jbd2.c         |   3 +-
 fs/ext4/fsync.c             |   5 +-
 fs/ext4/inode.c             |   9 +-
 fs/ext4/super.c             |   4 +-
 fs/fat/dir.c                |  17 +-
 fs/fat/fat.h                |   1 +
 fs/fat/fatent.c             |  15 +-
 fs/fat/file.c               |   8 +-
 fs/fat/inode.c              |   7 +-
 fs/fat/namei_msdos.c        |   6 +-
 fs/fat/namei_vfat.c         |   2 +-
 fs/gfs2/glock.c             |   1 -
 fs/hugetlbfs/inode.c        |  11 +-
 fs/inode.c                  |  24 +--
 fs/libfs.c                  |  37 ++--
 fs/minix/dir.c              |   2 +-
 fs/minix/file.c             |  10 +-
 fs/minix/inode.c            |   6 +-
 fs/minix/itree_common.c     |  11 +-
 fs/minix/minix.h            |   3 +
 fs/ntfs3/file.c             |   3 -
 fs/ntfs3/inode.c            |   1 -
 fs/ocfs2/dlmglue.c          |   1 -
 fs/ocfs2/namei.c            |   3 -
 fs/omfs/file.c              |   2 +-
 fs/qnx4/dir.c               |   2 +-
 fs/qnx6/dir.c               |   2 +-
 fs/udf/dir.c                |   2 +-
 fs/udf/directory.c          |   5 +-
 fs/udf/file.c               |   9 +-
 fs/udf/inode.c              |  16 +-
 fs/udf/namei.c              |   2 +-
 fs/udf/super.c              |   1 +
 fs/udf/truncate.c           |   2 +-
 fs/udf/udf_i.h              |   1 +
 fs/udf/udfdecl.h            |   1 +
 fs/ufs/dir.c                |   2 +-
 fs/ufs/file.c               |   2 +-
 fs/ufs/inode.c              |   1 -
 include/linux/buffer_head.h |  29 ++-
 include/linux/fs.h          |  15 +-
 include/linux/hugetlb.h     |   1 +
 mm/hugetlb.c                |  10 +-
 virt/kvm/guest_memfd.c      |  12 +-
 65 files changed, 474 insertions(+), 492 deletions(-)
