Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1F1DF755;
	Sun, 29 Mar 2026 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774818374; cv=none; b=kWZQb+U/uJ8EW4xpq+RG3MoSL6d6cjQA0SF3j8eOCP9JYlj4PS5D0JWEoXg8ZjZrglIladg6+vCEx9GBKLIjrpvS2Owy4USjluhpCC9AJhmNcxRCIhNNv3Rs2AJtYHCIJ4hvcskHjDkZo2Usyq9pTIONaa6EM3TWAaF4hAHau7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774818374; c=relaxed/simple;
	bh=miKE+jJbvoXtdpjtS++2uMlMb3Ab/grwgmQ2uu1bADM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQ+F7+7IhgEj6jV0Hh14x7Z3JCnGH6s9/6o6wb6pwksA9deIRiTHgiXqtdYhFgtfWd/+7sNMSs8b13olqDe68xwh/6M4BXZ7Ajbr/9NhBfhAMKZ8LZKk9BD5yyIL6X0zVJf541LjV8KyFV/3398T6Fi3fzr7MAHbq2WtAcnjF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGIW3kQf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGIW3kQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B47C116C6;
	Sun, 29 Mar 2026 21:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774818374;
	bh=miKE+jJbvoXtdpjtS++2uMlMb3Ab/grwgmQ2uu1bADM=;
	h=From:To:Cc:Subject:Date:From;
	b=BGIW3kQfNkZldOkiv4QICCKtKOTZIQYySToU+Au+OlqorMICWniVIyJ1YT10uK1N0
	 59jHaBfVQsh7Sr8+mvHS7yhSielzSKkerk9XyUaRw8+Snpi7nEo3Z3xwC+n/+BH3/v
	 Xc154L2WE+ZcDgFNeEdRosC6AsylFaBfrCIIyujI7royqfrv+Tvd5dmBDT/RaB+A66
	 BxMmPgBM0pciK2WlYc/eO92hzpQNil6GjubcPIdHLsn2VgR1bPSzlowweu4YZFUAh0
	 QO526EJBPsGZfkjdzWPA3I+Nt5Vss61QCprgMRd4BLA+BkqA8eno4SCtrAsxUtJM96
	 Re6P5YXk60Oog==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.0] vfs fixes
Date: Sun, 29 Mar 2026 23:06:07 +0200
Message-ID: <20260329-vfs-fixes-846b973993eb@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5329; i=brauner@kernel.org; h=from:subject:message-id; bh=miKE+jJbvoXtdpjtS++2uMlMb3Ab/grwgmQ2uu1bADM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSenOLgNuV8qfF8W/3t4csf/T/6wkTn8cnlq8qyg9ffc /NaO2taQEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBELGcxMnzX26bBafP0TOzl oubA+5VnuuZXCP0yvnNk76pZsW7KrzUZ/ofdS9pVbvax8IKLkNf+1n17Cq8aLVon0TF1TwzjOvM fz7gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

Sorry for being late with this. Feel free to delay this after you have
tagged. I didn't get around to sending a pull request earlier
unfortunately as the vfs ci took quite a while to run.

/* Summary */

This contains fixes for this cycle:

- Fix netfs_limit_iter() hitting BUG() when an ITER_KVEC iterator reaches
  it via core dump writes to 9P filesystems. Add ITER_KVEC handling
  following the same pattern as the existing ITER_BVEC code.

- Fix a NULL pointer dereference in the netfs unbuffered write retry path
  when the filesystem (e.g., 9P) doesn't set the prepare_write operation.

- Clear I_DIRTY_TIME in sync_lazytime for filesystems implementing
  ->sync_lazytime. Without this the flag stays set and may cause
  additional unnecessary calls during inode deactivation.

- Increase tmpfs size in mount_setattr selftests. A recent commit bumped
  the ext4 image size to 2 GB but didn't adjust the tmpfs backing store,
  so mkfs.ext4 fails with ENOSPC writing metadata.

- Fix an invalid folio access in iomap when i_blkbits matches the folio
  size but differs from the I/O granularity. The cur_folio pointer would
  not get invalidated and iomap_read_end() would still be called on it
  despite the IO helper owning it.

- Fix hash_name() docstring.

- Fix read abandonment during netfs retry where the subreq variable used
  for abandonment could be uninitialized on the first pass or point to a
  deleted subrequest on later passes.

- Don't block sync for filesystems with no data integrity guarantees. Add
  a SB_I_NO_DATA_INTEGRITY superblock flag replacing the per-inode
  AS_NO_DATA_INTEGRITY mapping flag so sync kicks off writeback but
  doesn't wait for flusher threads. This fixes a suspend-to-RAM hang on
  fuse-overlayfs where the flusher thread blocks when the fuse daemon is
  frozen.

- Fix a lockdep splat in iomap when reads fail. iomap_read_end_io()
  invokes fserror_report() which calls igrab() taking i_lock in hardirq
  context while i_lock is normally held with interrupts enabled. Kick
  failed read handling to a workqueue.

- Remove the redundant netfs_io_stream::front member and use
  stream->subrequests.next instead, fixing a potential issue in the
  direct write code path.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit d320f160aa5ff36cdf83c645cca52b615e866e32:

  iomap: reject delalloc mappings during writeback (2026-03-04 14:31:56 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc6.fixes

for you to fetch changes up to 0e764b9d46071668969410ec5429be0e2f38c6d3:

  netfs: Fix the handling of stream->front by removing it (2026-03-26 15:18:45 +0100)

----------------------------------------------------------------
vfs-7.0-rc6.fixes

Please consider pulling these changes from the signed vfs-7.0-rc6.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      selftests/mount_setattr: increase tmpfs size for idmapped mount tests

Christoph Hellwig (1):
      fs: clear I_DIRTY_TIME in sync_lazytime

Darrick J. Wong (1):
      iomap: fix lockdep complaint when reads fail

David Howells (2):
      netfs: Fix read abandonment during retry
      netfs: Fix the handling of stream->front by removing it

Deepanshu Kartikey (2):
      netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators
      netfs: Fix NULL pointer dereference in netfs_unbuffered_write() on retry

Joanne Koong (2):
      iomap: fix invalid folio access when i_blkbits differs from I/O granularity
      writeback: don't block sync for filesystems with no data integrity guarantees

Jori Koolstra (1):
      vfs: fix docstring of hash_name()

 fs/fs-writeback.c                                  | 36 +++++++++++----
 fs/fuse/file.c                                     |  4 +-
 fs/fuse/inode.c                                    |  1 +
 fs/iomap/bio.c                                     | 51 +++++++++++++++++++++-
 fs/iomap/buffered-io.c                             | 15 ++++---
 fs/namei.c                                         | 10 ++++-
 fs/netfs/buffered_read.c                           |  3 +-
 fs/netfs/direct_read.c                             |  3 +-
 fs/netfs/direct_write.c                            | 15 +++++--
 fs/netfs/iterator.c                                | 43 ++++++++++++++++++
 fs/netfs/read_collect.c                            |  4 +-
 fs/netfs/read_retry.c                              |  5 ++-
 fs/netfs/read_single.c                             |  1 -
 fs/netfs/write_collect.c                           |  4 +-
 fs/netfs/write_issue.c                             |  3 +-
 include/linux/fs/super_types.h                     |  1 +
 include/linux/netfs.h                              |  1 -
 include/linux/pagemap.h                            | 11 -----
 include/trace/events/netfs.h                       |  8 ++--
 .../selftests/mount_setattr/mount_setattr_test.c   |  2 +-
 20 files changed, 168 insertions(+), 53 deletions(-)
