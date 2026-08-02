Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFF21A459;
	Sun,  2 Aug 2026 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785663159; cv=none; b=SZozKQ6Ra2AtGs2PVH6z0ZC3IM2yMaQYBhTxBGZrwmKVkdqgIN+jy8/Ff8eZI4L1M23LEnLMO927iOuZl0hpAcasqFxvYE1Vij5uk/9j/q1dFOuR17HLz3PsmJadX6OjRUhQjnFErfl5qUSUOMUku6MMck8KRHfnmMZD9xDBwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785663159; c=relaxed/simple;
	bh=wsJfcxF+zXKhhxCG3mZJV5k9zfaak0nkXTv6ixT2kI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDhPVGN7lYBfXDRAPqvP/hDK5a90dahqUnkOlCtPq/P3m9uM0uGxlbmS17mKotu/4TmEe3xI20/24rmHG2ulPjkBtKNNrEQw6kr+tNVa2MXJBoaDQxaOLwTJ4hk+kRqQsGZ5z+3HhFSqsfuOVQNxiSa2ALwrgBygj4b3NSkBUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aErhjZzY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aErhjZzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFCA1F000E9;
	Sun,  2 Aug 2026 09:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785663158;
	bh=Ma6AWXAeTTct2nkWjiBXi4bm+okRWMwqVMmUTQi9zZY=;
	h=From:To:Cc:Subject:Date;
	b=aErhjZzYu1baQ+C0zkrwT5thfKyvFypoz/rTgbjozLvmEwP6TDT6eT3yc/7feujaj
	 5hvGQFjnNtRrmRisH4PkBhUf7ghOzGmxgj2AeLwb28qV5Dm0HuaRw5d1AM+OH2QzRZ
	 ngsVXvdG7j0hS7e0dcfIv+dd4gT6zByRH4+1xPGgzrDDIF/c/GzbfgWuywHwM12x6t
	 lvGb8WGzH8UYJx0999itdifKnUC6EILfMWT19sKjr3fU98ayiJuX6tDaNm+uIIxOAy
	 1R5j0nlOdkJu4ZIGMWLvZOkxnNDwjw//FO9egsTaBSvIVl1euxeOa3X+p+Su60lG47
	 8tPIq8I/C6cng==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.2] vfs fixes
Date: Sun,  2 Aug 2026 11:31:26 +0200
Message-ID: <20260802-vfs-7.2-rc6.fixes-d7f38ab4daa2@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6053; i=brauner@kernel.org; h=from:subject:message-id; bh=wsJfcxF+zXKhhxCG3mZJV5k9zfaak0nkXTv6ixT2kI4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTl863YcN598pejHY+ieots+HfH7WhRbP3JadwUlal+6 86K1QnSHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZm8/I8CSv8sTaI803GVo1 N1fM0p19bJOcLKdUYkLnBq2olsfZkQx/OGsaA6c9SlitxM0w/8fxhG3nlI3ry41v7jD4xjxpjlA rEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains fixes for the current development cycle:

- binfmt_misc:

  * Don't let an 'F' entry pin its own instance. An entry registered
    with 'F' opens its interpreter at registration time and holds that
    file until the entry is freed, so an entry nobody removes by hand
    is only closed once the binfmt_misc superblock is shut down. If the
    interpreter lives on a mount that keeps that superblock alive the
    two pin each other and the file is never closed. That's reachable
    by pointing the interpreter at the instance itself or by using the
    instance as an overlayfs lower layer, and once the mount namespace
    is gone there's nothing left to unregister through either.

  * Restore write access when removing an entry. Registering with the
    MISC_FMT_OPEN_FILE flag opens the interpreter via open_exec() which
    denies write access for as long as the entry exists, but removal
    only did filp_close() and never restored it. The inode's
    i_writecount stayed permanently negative and opening the
    interpreter for writing kept failing with ETXTBSY long after the
    entry was gone.

  * Use exe_file_deny_write_access() for the interpreter clone so both
    sides base their decision on the same mode.

  * Reject a flag character as the field delimiter. create_entry() pads
    the buffer with the delimiter so the field parsers terminate even
    on a truncated string, but check_special_flags() consumes flag
    characters instead of scanning for the delimiter. If the delimiter
    is itself a flag character the padding stops acting as a terminator
    and the scan keeps reading past the end of the allocation. Such a
    registration was always rejected, just only after the out of bounds
    read has already happened.

  * Don't leak the user namespace when the mount fails. bm_get_tree()
    hands its reference to get_tree_keyed() and sget_fc() moves it into
    sb->s_fs_info, but generic_shutdown_super() only calls ->put_super()
    from inside the if (sb->s_root) branch and bm_fill_super() can fail
    before either s_root or s_op is in place. Drop the reference in
    ->kill_sb() instead, which runs unconditionally.

- netfs:

  * Clear PG_private_2 on a copy-to-cache append failure.

  * Handle a rolling buffer allocation failure in single-object
    writeback and drop the extra folio reference
    netfs_write_folio_single() took before the append.

  * Release the batched readahead folios when
    rolling_buffer_load_from_ra() fails in
    netfs_prepare_read_iterator() after earlier folios have already
    been batched.

  * Fix the folio_queue ENOMEM in writeback by adding a mempool and
    passing gfp flags into the rolling buffer helpers.

- iomap:

  * Add a separate bio_set for iomap_split_ioend(). It can split
    bios that already come from iomap_ioend_bioset and deadlock once that
    bioset is exhausted.

- afs:

  * Set call->async for an asynchronous afs_fs_fetch_data() the way
    afs_fs_fetch_data64() already does.

  * Subtract subreq->transferred from subreq->len in afs_fs_fetch_data()
    rather than adding it.

  * Fix a UAF when sending a message.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 62cc90241548d5570ee68e01aaba6506964e9811:

  Merge tag 'mm-hotfixes-stable-2026-07-27-14-18' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2026-07-27 14:36:26 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc6.fixes

for you to fetch changes up to c679ce3be6cb63763d68ab9b5d9d73ddc0a40762:

  iomap: add a separate bio_set for iomap_split_ioend (2026-07-31 11:49:09 +0200)

----------------------------------------------------------------
vfs-7.2-rc6.fixes

Please consider pulling these changes from the signed vfs-7.2-rc6.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (8):
      Merge patch series "afs: Miscellaneous fixes"
      Merge patch series "netfs: Miscellaneous fixes"
      binfmt_misc: don't let an 'F' entry pin its own instance
      Merge patch series "binfmt_misc: don't let an 'F' entry pin its own instance"
      binfmt_misc: restore write access when removing an entry
      binfmt_misc: use exe_file_deny_write_access() for the interpreter clone
      binfmt_misc: reject a flag character as the field delimiter
      binfmt_misc: don't leak the user namespace when the mount fails

Christoph Hellwig (1):
      iomap: add a separate bio_set for iomap_split_ioend

David Howells (4):
      afs: Fix afs_fs_fetch_data() to set call->async
      afs: Fix afs_fs_fetch_data() to subtract transferred from len
      afs: Fix UAF when sending a message
      netfs: Fix folio_queue ENOMEM in writeback by adding a mempool

Yichong Chen (3):
      netfs: clear PG_private_2 on copy-to-cache append failure
      netfs: handle single writeback rolling buffer allocation failure
      netfs: release readahead folios on iterator preparation failure

 fs/afs/fsclient.c              |  5 +++-
 fs/afs/internal.h              |  3 ++-
 fs/binfmt_misc.c               | 54 ++++++++++++++++++++++++++----------------
 fs/iomap/ioend.c               | 21 ++++++++++++++--
 fs/netfs/buffered_read.c       | 10 ++++----
 fs/netfs/internal.h            |  1 +
 fs/netfs/main.c                |  7 ++++++
 fs/netfs/objects.c             | 30 +++++++++++++----------
 fs/netfs/read_pgpriv2.c        |  3 ++-
 fs/netfs/rolling_buffer.c      | 22 ++++++++++-------
 fs/netfs/write_issue.c         | 15 ++++++++----
 include/linux/netfs.h          |  1 +
 include/linux/rolling_buffer.h |  6 ++---
 13 files changed, 119 insertions(+), 59 deletions(-)
