Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97C349CC4;
	Fri, 12 Jun 2026 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277299; cv=none; b=Q/uvNGfFCruKYjzI2K6TewLYAMYIMG/Pjr+6AoV4DXLxY/t3+6aveGeFqhReMPLKCBAidpwJxxjxR4rpzni+SSVSOHEZrNsiDv6RnrkoN0Y3OvfHzGJV2RPqWTLdz29CrV7uQuPPOBrIfB00/y8MoXOpZkdzoGjNiu4fDwr76r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277299; c=relaxed/simple;
	bh=JqrvVuCLBfaMCmqxmR807caFooPzajjRiDVZVXoiwJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNipK+9wRKbCx7bWG1M6yxA2j+PhQr+Z/YemfUkzE9/Ut9B/tn2Gz4HRosPHkxh8yNW3c8d0UJfZ7PbHZr8sfdP6z0SSEFUYEGDp1XBbQPgiAntiJJhIEfi0mCMEQ9hNKpp/Zl16ZYfQ8W+mkdeE1kRxmPgFpY3rjQa2qSW1Qxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvAs67gt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvAs67gt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED141F000E9;
	Fri, 12 Jun 2026 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277298;
	bh=WVy7dHaaM5dV/XMUGhEGAcy6n9vBc9EzBnJ46O1aL+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DvAs67gtyRudGQr09qhIE1FMfcX91xE4/ZsnGHVtAGh9xP4Bhymks9aQIBTbgKW9v
	 HSLZPGTsbOUJ7bY3/b5Gz1Zme14rFFXDUWQXgY6zuACk2T4PuGhfZ8Ft98sVnipzZY
	 dnrjtpUiR+US2bR8UBnKVvj97k5LpsX3mMximP822nNQkAyRB1Io2jQ1c0CtkrBRLi
	 uJiDduftWySk7sEmioHkp269ERFq2EfXPyhYSNdYBjTSifFkvSjKfhQ3K0LchcK25T
	 OeDyERIe2dQhyrNRXWbnj4UHoDuCd4j9TVzA5ENh1EKV83EXzr72KLG2YLnjuAiAlN
	 cvpZI9KLxGmvg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 11/16 for v7.2] vfs bh
Date: Fri, 12 Jun 2026 17:14:35 +0200
Message-ID: <20260612-vfs-bh-v72-d55cbf8fd827@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5052; i=brauner@kernel.org; h=from:subject:message-id; bh=JqrvVuCLBfaMCmqxmR807caFooPzajjRiDVZVXoiwJg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKOUy98Xfv75q3iGFFY2rPi5Sl9EWmLmqdPEtJ/PXj Ey3FEIfdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEt5vhv+eN7R/fflnllsVs kFq7Iuq2pUEK85o2oU+MpWUvJm+ZP4mR4dCDurk5Lz1OTkiI7qitOL81kEtiJuNVxtxA3geFDwV qmQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This removes b_end_io from struct buffer_head.

Instead of setting bio->bi_end_io to end_bio_bh_io_sync() which then
calls bh->b_end_io(), the new bh_submit() and __bh_submit() interfaces
set bio->bi_end_io to the appropriate completion handler directly,
replacing two indirect function calls in the completion path with one.
It is also one fewer function pointer in the middle of a writable data
structure that can be corrupted, it shrinks struct buffer_head from
104 to 96 bytes allowing roughly 7% more buffer_heads to be cached in
the same amount of memory, and it removes some atomic operations as
the buffer refcount is no longer incremented before calling the end_io
handler.

All in-tree users (fs/buffer.c itself, ext4, jbd2, ocfs2, gfs2,
nilfs2, and md-bitmap) are converted, and submit_bh(),
mark_buffer_async_write(), and end_buffer_write_sync() are removed.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.bh

for you to fetch changes up to f0d857543e4d37464759c338f46ad6c85a618a2e:

  Merge patch series "Remove b_end_io from struct buffer_head" (2026-06-04 10:28:17 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.bh

Please consider pulling these changes from the signed vfs-7.2-rc1.bh tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Remove b_end_io from struct buffer_head"

Matthew Wilcox (Oracle) (34):
      buffer: Remove forward declaration of submit_bh_wbc()
      buffer: Add bh_submit()
      buffer: Remove mark_buffer_async_write_endio()
      buffer: Add bh_end_read(), bh_end_write() and bh_end_async_write()
      buffer: Convert write_dirty_buffer to bh_submit()
      buffer: Convert __bread_slow to bh_submit()
      buffer: Convert __sync_dirty_buffer to bh_submit()
      buffer: Convert __bh_read to bh_submit()
      buffer: Convert __bh_read_batch to bh_submit()
      buffer: Convert block_read_full_folio to bh_submit()
      buffer: Convert __block_write_full_folio to __bh_submit()
      ext4; Convert __ext4_read_bh() to bh_submit()
      ext4: Convert ext4_fc_submit_bh() to bh_submit()
      ext4: Convert write_mmp_block_thawed() to bh_submit()
      ext4: Convert ext4_commit_super() to bh_submit()
      jbd2: Convert journal commit to bh_submit()
      jbd2: Convert jbd2_write_superblock() to bh_submit()
      ocfs2: Convert ocfs2_write_block to bh_submit()
      ocfs2: Convert ocfs2_read_block to bh_submit()
      ocfs2: Convert ocfs2_read_blocks to bh_submit()
      ocfs2: Convert ocfs2_write_super_or_backup to bh_submit()
      gfs2: Convert gfs2_metapath_ra to bh_submit()
      gfs2: Convert gfs2_dir_readahead to bh_submit()
      gfs2: Remove use of b_end_io in gfs2_meta_read_endio()
      gfs2: Convert gfs2_aspace_write_folio to bh_submit()
      buffer: Remove mark_buffer_async_write()
      nilfs2: Convert nilfs_btnode_submit_block to bh_submit()
      nilfs2: Convert nilfs_gccache_submit_read_data to bh_submit()
      nilfs2: Convert nilfs_mdt_submit_block to bh_submit()
      md-bitmap: Convert read_file_page and write_file_page to bh_submit()
      buffer: Remove submit_bh()
      buffer: Remove b_end_io
      buffer: Change calling convention for end_buffer_read_sync()
      buffer: Remove end_buffer_write_sync()

 Documentation/filesystems/locking.rst |  14 --
 Documentation/trace/ftrace.rst        |   4 +-
 drivers/md/md-bitmap.c                |  27 +--
 drivers/md/raid5.h                    |   6 +-
 fs/buffer.c                           | 385 ++++++++++++++++++----------------
 fs/ext4/ext4.h                        |  10 +-
 fs/ext4/fast_commit.c                 |   8 +-
 fs/ext4/ialloc.c                      |   6 +-
 fs/ext4/mmp.c                         |   5 +-
 fs/ext4/super.c                       |  18 +-
 fs/gfs2/bmap.c                        |  13 +-
 fs/gfs2/dir.c                         |  12 +-
 fs/gfs2/meta_io.c                     |  13 +-
 fs/jbd2/commit.c                      |  13 +-
 fs/jbd2/journal.c                     |   4 +-
 fs/nilfs2/btnode.c                    |   4 +-
 fs/nilfs2/gcinode.c                   |   4 +-
 fs/nilfs2/mdt.c                       |   4 +-
 fs/ocfs2/buffer_head_io.c             |  16 +-
 include/linux/buffer_head.h           |  16 +-
 mm/vmscan.c                           |   2 +-
 21 files changed, 288 insertions(+), 296 deletions(-)
