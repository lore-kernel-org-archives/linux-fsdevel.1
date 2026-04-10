Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B13DA5C8;
	Fri, 10 Apr 2026 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834288; cv=none; b=SAXvLMZiNHr7PofRTE1h0Q81pFGlrR0/Yf72zoex6BSVuejT4lp1pNfKdgYdJvTP+zlDyV8/tG8Pxs5VC4/kRJ9fkHXFiw2I+MddH5HhbjSwRvTWgOFYtZHaa1biBxkDWtDRj7yJeE4AB0i+pGdrCMmIz/rwvb4iJ+yfD6Woy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834288; c=relaxed/simple;
	bh=0lI6o0QaaueDRhtmAhU+GU45hUg1f1YH3Dss65h9JKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oerQzTkHKOZux9aitGqtYooeyhOfCOJb3yoEwaEtF15S1YhwGVL3cVZO7zcqLYqMFr1QQJ4i55hjdoqKJABl0L9Jn6yqwpiGvw07eLl5m5GSsHlvkdGqfjxXCHrIXSSolf4FGdx4InylffnQiH7a9asJILWeGRRz2O8GITAiFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEf+tCKu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEf+tCKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC88C2BCC7;
	Fri, 10 Apr 2026 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834288;
	bh=0lI6o0QaaueDRhtmAhU+GU45hUg1f1YH3Dss65h9JKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEf+tCKuf55L1WO9m1rjneRU5Q5bmt8SXHc2BmzQJD50GuUIzqNekyY47+Md0LZ5W
	 X4Sxae1CxNdOVo2wueeyGJAGMdPJamrQpctduroaM5hP/UK2dIcPRfTuU8gVC/saxm
	 XlOXJ7YlBTi/yflfPM7i/+Q8NNmJtlkLU1b4ROsbUAMfXOyT9DqLqea60v/KSWqFkh
	 DsnfBwa9zvOKx/McczSEmV7zkVhWc9Cwcvhxw/hHBfa96qd/ipqhmTOJoi6YHTwcKA
	 FH5u7t1lBPqtmSRZNZ98qMDE3QitGi+EHJxzAQ3wcMsNzLdj+0KNuxUnt6VE5AGNGY
	 XUJFVKd6fwzSQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 04/12 for v7.1] vfs integrity
Date: Fri, 10 Apr 2026 17:17:13 +0200
Message-ID: <20260410-vfs-integrity-v71-caf8be59f7dd@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6999; i=brauner@kernel.org; h=from:subject:message-id; bh=0lI6o0QaaueDRhtmAhU+GU45hUg1f1YH3Dss65h9JKk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFFmtJnYlYYZy4+S4db1c0je3SkRN0RR/sphTxkj+z d6TPyfEdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykxILhr/iTyyd401g4Nkf2 heidPTnzWmLUuaq9U+YL7xCvlODqi2NkmBNdtEH30NmtHU9UZ63j9tCOODD7oo/NLudvDM09vE+ 2cwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This adds support to generate and verify integrity information (aka T10
PI) in the file system, instead of the automatic below the covers
support that is currently used.

The implementation is based on refactoring the existing block layer PI
code to be reusable for this use case, and then adding relatively
small wrappers for the file system use case. These are then used in
iomap to implement the semantics, and wired up in XFS with a small
amount of glue code.

Compared to the baseline this does not change performance for writes,
but increases read performance up to 15% for 4k I/O, with the benefit
decreasing with larger I/O sizes as even the baseline maxes out the
device quickly on my older enterprise SSD.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

diff --cc fs/iomap/bio.c
index edd908183058,f989ffcaac96..000000000000
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@@ -8,66 -9,33 +9,77 @@@
  #include "internal.h"
  #include "trace.h"

 +static DEFINE_SPINLOCK(failed_read_lock);
 +static struct bio_list failed_read_list = BIO_EMPTY_LIST;
 +
- static void __iomap_read_end_io(struct bio *bio)
+ static u32 __iomap_read_end_io(struct bio *bio, int error)
  {
-       int error = blk_status_to_errno(bio->bi_status);
        struct folio_iter fi;
+       u32 folio_count = 0;

-       bio_for_each_folio_all(fi, bio)
+       bio_for_each_folio_all(fi, bio) {
                iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
+               folio_count++;
+       }
+       if (bio_integrity(bio))
+               fs_bio_integrity_free(bio);
        bio_put(bio);
+       return folio_count;
  }

 +static void
 +iomap_fail_reads(
 +      struct work_struct      *work)
 +{
 +      struct bio              *bio;
 +      struct bio_list         tmp = BIO_EMPTY_LIST;
 +      unsigned long           flags;
 +
 +      spin_lock_irqsave(&failed_read_lock, flags);
 +      bio_list_merge_init(&tmp, &failed_read_list);
 +      spin_unlock_irqrestore(&failed_read_lock, flags);
 +
 +      while ((bio = bio_list_pop(&tmp)) != NULL) {
-               __iomap_read_end_io(bio);
++              __iomap_read_end_io(bio, blk_status_to_errno(bio->bi_status));
 +              cond_resched();
 +      }
 +}
 +
 +static DECLARE_WORK(failed_read_work, iomap_fail_reads);
 +
 +static void iomap_fail_buffered_read(struct bio *bio)
 +{
 +      unsigned long flags;
 +
 +      /*
 +       * Bounce I/O errors to a workqueue to avoid nested i_lock acquisitions
 +       * in the fserror code.  The caller no longer owns the bio reference
 +       * after the spinlock drops.
 +       */
 +      spin_lock_irqsave(&failed_read_lock, flags);
 +      if (bio_list_empty(&failed_read_list))
 +              WARN_ON_ONCE(!schedule_work(&failed_read_work));
 +      bio_list_add(&failed_read_list, bio);
 +      spin_unlock_irqrestore(&failed_read_lock, flags);
 +}
 +
  static void iomap_read_end_io(struct bio *bio)
  {
 -      __iomap_read_end_io(bio, blk_status_to_errno(bio->bi_status));
 +      if (bio->bi_status) {
 +              iomap_fail_buffered_read(bio);
 +              return;
 +      }
 +
-       __iomap_read_end_io(bio);
++      __iomap_read_end_io(bio, 0);
+ }
+
+ u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
+ {
+       return __iomap_read_end_io(&ioend->io_bio, ioend->io_error);
  }

- static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
+ static void iomap_bio_submit_read(const struct iomap_iter *iter,
+               struct iomap_read_folio_ctx *ctx)
  {
        struct bio *bio = ctx->read_ctx;

Merge conflicts with other trees
================================

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.integrity

for you to fetch changes up to 1b63f91d1c9013629fb2005ace48b7aeead32330:

  Merge patch series "support file system generated / verified integrity information v4" (2026-03-10 10:29:18 +0100)

----------------------------------------------------------------
vfs-7.1-rc1.integrity

Please consider pulling these changes from the signed vfs-7.1-rc1.integrity tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (2):
      Merge branch 'for-7.1/block-integrity'
      Merge patch series "support file system generated / verified integrity information v4"

Christoph Hellwig (16):
      block: factor out a bio_integrity_action helper
      block: factor out a bio_integrity_setup_default helper
      block: add a bdev_has_integrity_csum helper
      block: prepare generation / verification helpers for fs usage
      block: make max_integrity_io_size public
      block: add fs_bio_integrity helpers
      block: pass a maxlen argument to bio_iov_iter_bounce
      iomap: refactor iomap_bio_read_folio_range
      iomap: pass the iomap_iter to ->submit_read
      iomap: only call into ->submit_read when there is a read_ctx
      iomap: allow file systems to hook into buffered read bio submission
      ntfs3: remove copy and pasted iomap code
      iomap: add a bioset pointer to iomap_read_folio_ops
      iomap: support ioends for buffered reads
      iomap: support T10 protection information
      xfs: support T10 protection information

 block/Makefile                |   2 +-
 block/bio-integrity-auto.c    |  80 ++++---------------------
 block/bio-integrity-fs.c      |  81 +++++++++++++++++++++++++
 block/bio-integrity.c         |  64 ++++++++++++++++++++
 block/bio.c                   |  17 +++---
 block/blk-mq.c                |   6 +-
 block/blk-settings.c          |  13 ----
 block/blk.h                   |   6 +-
 block/t10-pi.c                |  12 ++--
 drivers/nvdimm/btt.c          |   6 +-
 fs/fuse/file.c                |   5 +-
 fs/iomap/bio.c                | 135 ++++++++++++++++++++++++++++--------------
 fs/iomap/buffered-io.c        |   8 +--
 fs/iomap/direct-io.c          |  15 ++++-
 fs/iomap/internal.h           |  14 +++++
 fs/iomap/ioend.c              |  30 ++++++++--
 fs/ntfs3/inode.c              |  57 ++----------------
 fs/xfs/xfs_aops.c             |  47 +++++++++++++--
 fs/xfs/xfs_iomap.c            |   9 ++-
 include/linux/bio-integrity.h |  12 +++-
 include/linux/bio.h           |   2 +-
 include/linux/blk-integrity.h |  28 +++++++--
 include/linux/blkdev.h        |  34 +++++++++--
 include/linux/iomap.h         |  20 ++++++-
 24 files changed, 470 insertions(+), 233 deletions(-)
 create mode 100644 block/bio-integrity-fs.c
