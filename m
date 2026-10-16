Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126893B27E8;
	Fri, 16 Oct 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146109; cv=none; b=hx2bqLJc9nkei5Wpy9A96W1BWHbK3kTR4sO8xG/TvcJWqGVf0G75p3I12R/wHQpACne3pbNKnq73HRYAv0aJtO0PtnRfZ5vWkW8E3iZx70LCno5Wt+XaBdAL5tKrnbmzFEbhenmyXZQwwk2HstnKjMpI2an5pS5lHtK3lDWpTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146109; c=relaxed/simple;
	bh=C8QGU4HA3aUofV7H5R8Vzj1TWla1A53rsd47BX4swJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi52hZRWMgLY8+NSrpnl6UAOY0l9q2TT9mSW9exgU3LEpz75x7+RuOlk4FdwKeIxOb8c65daPgpRpFttLB5X9GKcZ6DynidjJxtHgq3i4nIEyILOnvrpaFx2wxaBLW8ekncyZbuHMbv2770eWDZxhrz0EvXL09sZb8QSPlsU8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lko/KOQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lko/KOQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F841F000C5;
	Fri, 16 Oct 2026 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146107;
	bh=eCepIudj7vov6ZGXiPy9w4RZwye94YHk4gS2To7BfWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lko/KOQbacRGMbvVSxjkV7/T1BDxt50UtOC7VnyQ2RPPAjLn1XmqNPJNo+plkkCrJ
	 YsDdIWIDOm9/4vzLQCWDrASV+qBnrQTNuS9xCLq+fBEIjJUpTtVFBKlOsnxID5EvvC
	 dTd9IQfIluzRtwluG3zFDzUsBXUJT0+kAzf4EnFUhcU+ceYqpDjmsTf47leRYoybeD
	 KoCSqTu+VagCWnIGjWdA1pEjTr7KdZJFvwyUlS+ZUk6Ye2kf30J4U+hAW00Izgu19D
	 Ur26sAHRTUmQDKqqbKo/NViV7Dk5kbPUKruMI7KDS80z02IGZHg3j09e9UPP5up7iM
	 ECtqWKi/Y8zAw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 11/19 for v7.4] vfs iomap
Date: Fri, 16 Oct 2026 12:21:33 +0200
Message-ID: <20261016-vfs-7.4-rc1.iomap-a7ba039d4f24@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7181; i=brauner@kernel.org; h=from:subject:message-id; bh=C8QGU4HA3aUofV7H5R8Vzj1TWla1A53rsd47BX4swJU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/LX+V/GEHduuVZ3b9V1a5VMxz3X3l0cEOKx+Hi6ws o81usEl1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRWVcZGdYZOUooTGV+YHuB Zd27Z/FGFUte+tu1S5Re2vdU8KD5xTqGfwaa3Zmr5xz0audXaEju+SK8t6tQ/6DbkZ03VfkOhce qsgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the iomap changes for this cycle.

The bulk is lazy bounce buffering for checksummed reads. XFS bounce
buffers every direct read on a device that requires stable pages for
checksumming so that userspace modifying the buffer while the read is
in flight can't corrupt the data and fail the checksum. That burns DRAM
bandwidth and CPU for copies that are almost never needed and, since
the bounce buffer was a bio_vec, produced smaller and unaligned I/Os
with 4k pages, i.e. 1 MB minus 4k. Now the read goes to the user buffer
first and only a checksum failure allocates a bounce buffer and reads
again. Integrity verification moves out of iomap into the filesystem
so it can handle errors its own way, T10 PI handling for direct I/O
moves into ->submit_io() to match buffered I/O, and a sysfs knob
restores the old behaviour for the rare application that really does
modify in-flight buffers. The block side gains bio_prepare_reissue(),
exports fs_bio_integrity_{alloc,free}(), caps atomic writes by the PI
buffer size and fixes an integer overflow in max_integrity_io_size()
and a PI verification bug with an initial bvec offset. The old read
side bounce buffering in the block layer is removed. This is a branch
shared with the block tree and may also reach you through the block
pull request.

Three error handling regressions are fixed. A failed
->writeback_submit() left wpc->wb_ctx pointing at an already completed
ioend which was then submitted a second time and corrupted
ip->i_ioend_list on XFS. iomap_fiemap() lost an iteration error when it
flushed the pending extent and marked a truncated list as complete. And
a failed direct I/O bio lost its error when the sub-block tail zeroing
succeeded. An XFS error tag to inject the writeback failure comes with
it.

iomap_dio_hole_iter() respects the block size alignment when
iov_iter_zero() stops short at a page boundary, which btrfs with 8k
blocks on 4k pages hit as an assertion since it disables page faults
during direct I/O. The homegrown deferral of error completions to task
context is replaced with bio_complete_in_task(). Plus an unused
parameter, two typo fixes and a kernel-doc fix.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.iomap

for you to fetch changes up to a0f61a936b36a340998825cb945e5fdf03468988:

  fs/iomap: document ret parameter of iomap_iter_continue (2026-10-13 16:59:01 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.iomap

Please consider pulling these changes from the signed vfs-7.4-rc1.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
Andrea Parri (4):
      iomap: don't resubmit an ioend after ->writeback_submit() failed
      xfs: add an error tag to inject a ->writeback_submit() failure
      iomap: don't lose a fiemap iteration error when emitting the last extent
      iomap: don't lose a failed direct I/O bio's error when zeroing the tail

Christian Brauner (4):
      Merge patch series "iomap: fix typos and repeated words in comments"
      Merge patch series "lazy bounce buffering for checksummed reads v3"
      Merge patch series "use bio_complete_in_task for iomap error reporting"
      Merge patch series "iomap: fix error handling regressions"

Christoph Hellwig (24):
      block: avoid integer overflows in max_integrity_io_size
      block: cap atomic write size by PI buffer size constraints
      block: improve aligning down bios in bio_iov_iter_bounce_write
      block: split bio_iov_iter_bounce_write
      block: export fs_bio_integrity_{alloc,free}
      block: add a bio_prepare_reissue helper
      block: pass a maxlen argument to bio_iov_iter_get_pages
      block: warn on too larger integrity allocations
      iomap: respect maximum I/O size in iomap_dio_bio_iter_one
      iomap: add a iomap_ioend_flags helper
      iomap: add a IOMAP_IOEND_INTEGRITY flag
      iomap,xfs: move T10 PI handling for direct I/O into ->submit_io
      xfs: move PI generation into xfs_submit_zoned_bio
      block,iomap: fix protection information verification with initial bvec offset
      iomap: better read bounce buffering support
      xfs: use BIO_COMPLETE_IN_TASK for bounce buffered read I/Os
      iomap,xfs: move integrity verification to the file system
      xfs: add support for lazy direct read bounce buffering
      xfs: add error injection for lazy bounce buffering
      xfs: log a message at mount time when using integrity protection
      block,iomap: remove the old read side bounce buffering support
      iomap: use bio_complete_in_task for buffered read failures
      iomap: use bio_complete_in_task for buffered write failures
      iomap: use bio_complete_in_task for buffered simple dio read failures

Hemanth Selam (2):
      iomap: fix typo "metdata" in comment
      iomap: fix repeated word 'the' in comment

Muhammad Mahdi Amirpour (1):
      fs/iomap: document ret parameter of iomap_iter_continue

Pankaj Raghav (1):
      iomap: remove the unused ifs parameter from ifs_find_dirty_range

Qu Wenruo (1):
      iomap: follow the alignment requirement for iomap_dio_hole_iter()

Vincent Mailhol (1):
      block: store GPT attributes as a raw value

 block/bio-integrity-fs.c      |  15 ++-
 block/bio-integrity.c         |   1 +
 block/bio.c                   | 219 ++++++++++++++----------------------------
 block/blk-map.c               |   2 +-
 block/blk-settings.c          |   6 ++
 block/fops.c                  |   3 +-
 block/partitions/efi.h        |   8 +-
 fs/iomap/bio.c                |  50 +---------
 fs/iomap/buffered-io.c        |   8 +-
 fs/iomap/direct-io.c          |  96 ++++++++----------
 fs/iomap/fiemap.c             |   8 +-
 fs/iomap/ioend.c              | 178 ++++++++++++++++++++++------------
 fs/iomap/iter.c               |   1 +
 fs/xfs/libxfs/xfs_errortag.h  |   8 +-
 fs/xfs/xfs_aops.c             |  13 +--
 fs/xfs/xfs_buf.c              |  11 +++
 fs/xfs/xfs_file.c             |  11 +--
 fs/xfs/xfs_ioend.c            | 137 ++++++++++++++++++++++++--
 fs/xfs/xfs_ioend.h            |   2 +
 fs/xfs/xfs_mount.h            |   8 ++
 fs/xfs/xfs_reflink.c          |   5 +
 fs/xfs/xfs_super.c            |   1 +
 fs/xfs/xfs_sysfs.c            |  78 ++++++++++++++-
 fs/xfs/xfs_trace.h            |   1 +
 fs/xfs/xfs_zone_alloc.c       |   4 +
 include/linux/bio-integrity.h |   3 +-
 include/linux/bio.h           |  11 ++-
 include/linux/blkdev.h        |   8 +-
 include/linux/iomap.h         |  38 +++++++-
 29 files changed, 565 insertions(+), 369 deletions(-)
