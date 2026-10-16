Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D546E008;
	Fri, 16 Oct 2026 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145808; cv=none; b=kH2stxNbOA/rCG1KR7kyQewjlVHdFpOOz94e5j2LI7R8ZbhJhryfhVue+ju0IvLuyugC6gMBDyf77K5VW5lG9k2OyAnYbn5U93s1KB4mOKbPoWgBpvxIi/280dOfWmwnchiwEuNhT3LXaeZTGZH7CboCnaETPk7eUMxsnaehV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145808; c=relaxed/simple;
	bh=1rl4eXvYg1fcsCkbxgV/dWVNn9o8R6wIbgU9LjamBY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMGgz53q8hQ5dGf6ghI1jnx7ErPYH81mmpFs7we4mkdl9kvj6Q4XGz+iSkxQjWdzkO0fIfd6YupMsSv3VIubDoXQ9SXEnTWMgXBtOzcPXqlmTTHQe8vm9iH7LtGOE2CK6oO6eBdE1NwK9+WvVbUl71chd8dcP7aWyabRi6kfmOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2G52Rb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2G52Rb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26981F000C4;
	Fri, 16 Oct 2026 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145806;
	bh=L2utxJUYMM7tIUOO2MI+25CxHcLtJy5xwVz3TkOBZ3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z2G52Rb4HU6+jI0DmrRVs+ZO+3wOJzPuqudlWpodMOrBVkPWj0V/UxXDYDfRQ29ef
	 lA0t2ssKJV/XOqPhT7F0kU1Cy271rlCJD+9G93ZOzCwWtZ5gvPZFHX8yAx06dOdbFm
	 SG+sNV4i3CSpN7JzTEL6REHJ6JAG83AoGb1L5eG+Jww9cVP2SBfw/U7cKNhZ/O5aZi
	 hh2wSMHoKkxYb3/JvM1OMnRnrtMZu7BsonLEfmNacBqIQQEAOmrS2bDTNE8EOXGh9p
	 4KwywddbyDtdEznjiLC0ZuUykYj9gbGzkpnShuQkdIqUb8yWn1wORW+LloO+lpG94P
	 YpGX7ibdZjLQg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 05/19 for v7.4] vfs bh
Date: Fri, 16 Oct 2026 12:16:30 +0200
Message-ID: <20261016-vfs-7.4-rc1.bh-97cf6f68db3d@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7848; i=brauner@kernel.org; h=from:subject:message-id; bh=1rl4eXvYg1fcsCkbxgV/dWVNn9o8R6wIbgU9LjamBY4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/NkkwPTuOXPPxeAD9xuObqr59/FIpJjam40/X57Vv 1vftvqObUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEVrkw/NP877jK7bVP1PtW HT4Vs8+Li2wWzE/Zfo5l5fal194wTf/N8D/w+srNN+/ySavw+UwsE5r7+G9zpp5Q29kVbz1PHlj 1KJsJAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This stops the buffer_head write completion handlers from clearing
BH_Uptodate when a write fails.

A buffer whose write failed still holds exactly the data the filesystem
asked to be written. It's the disk that is stale, not the buffer.
Claiming otherwise has consequences. mark_buffer_dirty() warns when a
filesystem redirties the buffer to retry the write, a buffer that isn't
up to date gets re-read from disk which silently replaces the data with
the stale on-disk copy, and the window between the write completing and
BH_Uptodate being cleared is visible to anyone holding the folio lock.

BH_Write_EIO already records that the last write failed. Every consumer
is moved over to buffer_write_io_error(): the two core helpers in
fs/buffer.c, adfs, ext2, omfs, exfat, fat, ext4, ocfs2, gfs2 and jbd2.
Then write completion stops touching BH_Uptodate in both directions and
BH_Write_EIO is cleared on successful completion instead of at
submission, so a resubmission no longer hides an error that hasn't been
fixed yet. bforget() and invalidation drop the flag so a reused block
doesn't inherit someone else's write error.

The groundwork for this removes b_page from struct buffer_head and lets
a buffer_head point at memory outside the page cache. jbd2's shadow
buffers sit on a slab folio today. A slab folio overloads ->mapping so
mark_buffer_write_io_error() couldn't be called on them at all. They
now point at the frozen data directly with b_folio NULL.

Also included are documentation updates from Matthew for sb_bread(),
sb_breadahead() and mmb_mark_buffer_dirty() and the removal of stale
references to unmap_buffer() and mark_buffer_dirty_inode().

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This conflicts with the mm tree in include/linux/buffer_head.h between
commits effd0cf5f5261 ("md: remove the last use of page_buffers()") and
ebb7205efe614 ("md: use folio_alloc_buffers()") from the mm tree and
commits 1aeacc2cbf86e ("buffer_head: Remove b_page") and 3c9ab45852f63
("jbd2: point the shadow buffer at the frozen data directly") from this
tree. The mm tree removes the page_buffers() macro, this tree switches
bh_offset() to b_folio and adds kmap_local_bh() and kunmap_local_bh()
right above it:

diff --cc include/linux/buffer_head.h
index 4b0b7188472b,e7a701ce029d..f8782b719026
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@@ -172,10 -169,44 +169,39 @@@ static __always_inline int buffer_uptod
  
  static inline unsigned long bh_offset(const struct buffer_head *bh)
  {
- 	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
+ 	return (unsigned long)(bh)->b_data & (folio_size(bh->b_folio) - 1);
+ }
+ 
+ /**
+  * kmap_local_bh - Map the data of a buffer.
+  * @bh: The buffer.
+  *
+  * Buffers usually live in the page cache, but a few are built over memory
+  * which is not.  Those carry no folio and b_data is already a kernel address
+  * which is always mapped, so there is nothing to do for them.  Pair with
+  * kunmap_local_bh().
+  *
+  * Return: A pointer to the buffer's data.
+  */
+ static inline void *kmap_local_bh(const struct buffer_head *bh)
+ {
+ 	if (!bh->b_folio)
+ 		return bh->b_data;
+ 	return kmap_local_folio(bh->b_folio, bh_offset(bh));
+ }
+ 
+ /**
+  * kunmap_local_bh - Unmap the data of a buffer.
+  * @bh: The buffer.
+  * @addr: The address returned by kmap_local_bh().
+  */
+ static inline void kunmap_local_bh(const struct buffer_head *bh, void *addr)
+ {
+ 	if (bh->b_folio)
+ 		kunmap_local(addr);
  }
  
 -/* If we *know* page->private refers to buffer_heads */
 -#define page_buffers(page)					\
 -	({							\
 -		BUG_ON(!PagePrivate(page));			\
 -		((struct buffer_head *)page_private(page));	\
 -	})
 +/* If we *know* folio->private refers to buffer_heads */
  #define folio_buffers(folio)		folio_get_private(folio)
  
  void buffer_check_dirty_writeback(struct folio *folio,

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.bh

for you to fetch changes up to 7c5bb35718a6ecc2001e2f8f6abc068ab926b583:

  Merge patch series "Buffer head documentation updates" (2026-09-10 09:27:29 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.bh

Please consider pulling these changes from the signed vfs-7.4-rc1.bh tag.

Thanks!
Christian

----------------------------------------------------------------
Chao Shi (20):
      buffer: allow a buffer_head to point at memory outside the page cache
      jbd2: point the shadow buffer at the frozen data directly
      buffer: read the folio's mapping directly in buffer_set_crypto_ctx()
      buffer: clear BH_Write_EIO when a buffer is forgotten
      buffer: discard BH_Write_EIO along with the rest of the buffer state
      buffer: detect metadata write errors with buffer_write_io_error()
      adfs: check for a directory write error with buffer_write_io_error()
      ext2: check for an xattr block write error with buffer_write_io_error()
      omfs: check for an inode write error with buffer_write_io_error()
      exfat: check for a directory write error with buffer_write_io_error()
      fat: check for a metadata write error with buffer_write_io_error()
      ext4: check for a metadata write error with buffer_write_io_error()
      ocfs2: check for a metadata write error with buffer_write_io_error()
      ocfs2: check for a stale write error before reusing a metadata buffer
      gfs2: check for a metadata write error with buffer_write_io_error()
      jbd2: report journal write errors with BH_Write_EIO
      jbd2: say what jbd2_freeze_jh_data()'s assertion is actually checking
      jbd2: check for a fast commit write error with buffer_write_io_error()
      buffer: stop touching BH_Uptodate on write completion
      buffer: clear BH_Write_EIO when a write succeeds, not when one starts

Christian Brauner (2):
      Merge patch series "buffer: stop clearing BH_Uptodate when a write fails"
      Merge patch series "Buffer head documentation updates"

Matthew Wilcox (Oracle) (7):
      buffer_head: Remove b_page
      buffer: Remove reference to unmap_buffer()
      fs: Remove references to mark_buffer_dirty_inode()
      buffer: Document sb_bread(), sb_bread_unmovable() and sb_breadahead()
      buffer: Document mmb_mark_buffer_dirty()
      buffer: Refer to folios in comments
      buffer: Rename label

 Documentation/filesystems/porting.rst |   2 +-
 fs/adfs/dir.c                         |   2 +-
 fs/buffer.c                           | 131 ++++++++++++++++++----------------
 fs/exfat/misc.c                       |   2 +-
 fs/ext2/xattr.c                       |   2 +-
 fs/ext4/ext4_jbd2.c                   |   2 +-
 fs/ext4/mmp.c                         |   2 +-
 fs/fat/misc.c                         |   2 +-
 fs/gfs2/log.c                         |   4 +-
 fs/gfs2/lops.c                        |   4 +-
 fs/jbd2/commit.c                      |  22 +++---
 fs/jbd2/journal.c                     |  31 ++++----
 fs/jbd2/transaction.c                 |   2 +-
 fs/ocfs2/buffer_head_io.c             |  12 ++--
 fs/ocfs2/journal.c                    |  25 +++----
 fs/omfs/inode.c                       |   4 +-
 include/linux/buffer_head.h           |  86 +++++++++++++++++++---
 17 files changed, 209 insertions(+), 126 deletions(-)
