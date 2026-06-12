Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC92BE7D1;
	Fri, 12 Jun 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277333; cv=none; b=IFKwnpiQGRpShO84HfR+2UItoEE9KT8palRLCiRx3s7stGpdRxwppiSpNKXfjp6kWuzEItfTUwfM4umazWpuJmEiR5R6s9Xj5xyLfTirb+4dKjiGWY2Gc5v67Svt40Ly+XKJhpWJM92pv6WgmRjom6Hw4rMuqdOhhdwodYlHfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277333; c=relaxed/simple;
	bh=EvuLtigPmhILkRuqoreQhrXjImoBs8NZjrFsV7fG1A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMuN9bWqQfpXnKhIjC/OIARZX4m1jKEtZEXpfBU/+9ouX9ea6CvNezGq6++KlQPBahIqLaEfKiEyS/MpeqLUxF6j3uJrEEduuHfJjVpnyBEXWng+EyVM9LQ54BxR9/1VixVzeWC19nJ3lL6nhutUfjYrnqWlibEqOPtvXwtR4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjHunoIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjHunoIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB071F000E9;
	Fri, 12 Jun 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277332;
	bh=F4mnnN53ZvIK3onb5gKLgMudzEMvJsGHHuXkPmw+27Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjHunoISAKpmPuvLmjK6I1J/QooSr2mvBbxzceHDJuAp35fRErrS11x6by+vns13l
	 dq4YQ39bsWbJJNPU1fqvdLVZ5OSSojGf2BNnJWAS4kO9Y3owFo75TfkjEnET+1AKgZ
	 KXlLtmxT6l3fuRtkIwNrc4fzAXmqivYwMSDaN4GcFWMdJdZx5sWDTc6aMg8JVoYYeq
	 XXiiSAcHcfuUY2ECpgjzMBPTiPBeqjAjsEjCLpvQ2xaJVP0SuF180nYekN6F++V7q/
	 9rMViUdoR+e5vSl4sYFmXBDnGcVcXnWtmWlBpjiVd2IRo5wbE1yT7QwWntXeHQ6YV5
	 Lf6jEEMRCybSw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 13/16 for v7.2] vfs iomap
Date: Fri, 12 Jun 2026 17:15:26 +0200
Message-ID: <20260612-vfs-iomap-v72-3c93b1aa4390@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6252; i=brauner@kernel.org; h=from:subject:message-id; bh=EvuLtigPmhILkRuqoreQhrXjImoBs8NZjrFsV7fG1A8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKE1IjOZ4zcT6i+94xI/V/NWGrQ+qCpSFXiwKrc7tO TaF7XFDRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQE9jD8Yj6w9byR2f0nLz9f ytnrufD+nYXTu89YV01zmPr08M9GxwhGhgWCq3Zkrbt/u0l4OUeg8Iw7nY/z3vfnhbr68PTM+ti SwggA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the iomap changes for this cycle:

* Add the vfs infrastructure required to implement fs-verity support
  for XFS with a post-EOF merkle tree: fsverity generates and stores a
  zero-block hash, and iomap learns to verify data on buffered reads,
  to handle fsverity during writeback via the new IOMAP_F_FSVERITY
  flag, and to write fsverity metadata through iomap_fsverity_write().

* Skip the memset of the iomap in iomap_iter() once the iteration is
  done. In high-IOPS scenarios (4k randread NVMe polling via io_uring)
  the pointless memset wasted memory write bandwidth; this improves
  IOPS by about 5% on ext4 and xfs.

* Add balance_dirty_pages_ratelimited() to iomap_zero_iter(), aligning
  it with iomap_write_iter(). This prepares for the exFAT iomap
  conversion where zeroing beyond valid_size can trigger large-scale
  zeroing operations that caused memory pressure without throttling.

* Remove the over-strict inline data boundary check. If a filesystem
  provides a valid inline_data pointer and length there is no reason
  to require that inline data must not cross a page boundary.

* Don't make REQ_POLLED imply REQ_NOWAIT, matching the earlier
  equivalent block layer fix: there are valid cases to poll for I/O
  completion without REQ_NOWAIT, and REQ_NOWAIT for file system writes
  is currently not supported as writes aren't idempotent.

* Introduce IOMAP_F_ZERO_TAIL for filesystems that maintain a separate
  valid data length (exFAT, NTFS). For a write starting at or beyond
  valid_size, __iomap_write_begin() now zeroes only the tail portion
  of the block while preserving valid data before it, instead of
  leaving stale data in the page cache. The flag is also added to the
  iomap trace event strings.

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

The exfat tree carries the same "iomap: introduce IOMAP_F_ZERO_TAIL
flag" patch as this tree as a dependency for the exFAT iomap
conversion, so the merge gets a conflict in include/linux/iomap.h
together with the IOMAP_F_FSVERITY additions from this tree. Reported
in [1]. It can be resolved as follows:

[1]: https://lore.kernel.org/linux-next/aiKrepiU3-L6KRqJ@sirena.org.uk

diff --combined include/linux/iomap.h
index cea6bbc97b6ef,3582ed1fe2361..0000000000000
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@@ -91,6 -91,14 +91,14 @@@ struct vm_fault
  #endif /* CONFIG_BLK_DEV_INTEGRITY */
  #define IOMAP_F_ZERO_TAIL	(1U << 10)

+ /*
+  * Indicates reads and writes of fsverity metadata.
+  *
+  * Fsverity metadata is stored after the regular file data and thus beyond
+  * i_size.
+  */
+ #define IOMAP_F_FSVERITY	(1U << 11)
+
  /*
   * Flag reserved for file system specific usage
   */
@@@ -345,6 -353,9 +353,9 @@@ static inline bool iomap_want_unshare_i
  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
  		const struct iomap_ops *ops,
  		const struct iomap_write_ops *write_ops, void *private);
+ int iomap_fsverity_write(struct file *file, loff_t pos, size_t length,
+ 		const void *buf, const struct iomap_ops *ops,
+ 		const struct iomap_write_ops *write_ops);
  void iomap_read_folio(const struct iomap_ops *ops,
  		struct iomap_read_folio_ctx *ctx, void *private);
  void iomap_readahead(const struct iomap_ops *ops,
@@@ -421,6 -432,7 +432,7 @@@ struct iomap_ioend
  	loff_t			io_offset;	/* offset in the file */
  	sector_t		io_sector;	/* start sector of ioend */
  	void			*io_private;	/* file system private data */
+ 	struct fsverity_info	*io_vi;		/* fsverity info */
  	struct bio		io_bio;		/* MUST BE LAST! */
  };

@@@ -495,6 -507,7 +507,7 @@@ struct iomap_read_folio_ctx
  	struct readahead_control *rac;
  	void			*read_ctx;
  	loff_t			read_ctx_file_offset;
+ 	struct fsverity_info	*vi;
  };

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.iomap

for you to fetch changes up to b7bae6880e8de2a5f693c18d87ad5cc26f157eb2:

  iomap: Add IOMAP_F_ZERO_TAIL flag to trace event strings (2026-06-05 13:36:42 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.iomap

Please consider pulling these changes from the signed vfs-7.2-rc1.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
Andrey Albershteyn (4):
      fsverity: generate and store zero-block hash
      iomap: introduce IOMAP_F_FSVERITY and teach writeback to handle fsverity
      iomap: teach iomap to read files with fsverity
      iomap: introduce iomap_fsverity_write() for writing fsverity metadata

Chi Zhiling (1):
      iomap: add dirty page control to iomap_zero_iter

Christian Brauner (1):
      Merge patch series "vfs infrastructure for fs-verity support for XFS with post EOF merkle tree"

Christoph Hellwig (1):
      iomap: don't make REQ_POLLED imply REQ_NOWAIT

Fengnan Chang (1):
      iomap: avoid memset iomap when iter is done

Namjae Jeon (3):
      iomap: remove over-strict inline data boundary check
      iomap: introduce IOMAP_F_ZERO_TAIL flag
      iomap: Add IOMAP_F_ZERO_TAIL flag to trace event strings

 fs/iomap/buffered-io.c       | 116 ++++++++++++++++++++++++++++++++++++++-----
 fs/iomap/direct-io.c         |   5 +-
 fs/iomap/ioend.c             |   1 +
 fs/iomap/iter.c              |  12 ++---
 fs/iomap/trace.h             |   4 +-
 fs/verity/fsverity_private.h |   3 ++
 fs/verity/measure.c          |   4 +-
 fs/verity/open.c             |   3 ++
 fs/verity/pagecache.c        |  22 ++++++++
 include/linux/bio.h          |  14 ------
 include/linux/fsverity.h     |   8 +++
 include/linux/iomap.h        |  27 ++++++----
 12 files changed, 170 insertions(+), 49 deletions(-)
