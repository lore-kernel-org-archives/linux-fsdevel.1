Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA73F076B;
	Thu,  7 May 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157863; cv=none; b=pAR5MIBTQkT5otB6o/JPfLRiTJ+6ZlI3xEq0mCh7CJLR5Oa1Ayg3KYPynFRyMzeSpnAAo75LaHiiCh+MJdEOkTDMa63Z1mnIDG8AY1Ko26s8l2dGEvWAJcIBCh22r/hY3poFe3cbIKYsMVNNiuYGcxccc2x0fGb93vxmLXF7UCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157863; c=relaxed/simple;
	bh=eX9ozlr6dpDnMxYGr9MISNvxmzW7dQ+tjdwED0IrI3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KdZPFaZwZ1y/9dbzgq6nn+80M2DVmp4T27W/qw/7JETjlVneIgYk0DCRb3t2GWiD66LncveXYLyMF0ITGnxWPqgPBu5g7gaamYvm9N/kEYHCOCovBMLBMRy4+T8JFRDvk/Fniqaqm+yfigfSA9vEDbrDZD3qwKpeTQ8E/Ckv8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZr2GlWK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZr2GlWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A64FC2BCB2;
	Thu,  7 May 2026 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778157862;
	bh=eX9ozlr6dpDnMxYGr9MISNvxmzW7dQ+tjdwED0IrI3s=;
	h=From:To:Cc:Subject:Date:From;
	b=qZr2GlWKF/NTXpT1G5So18UdCwHV5Sk4kX3rCXCeORQDncENnbG/HQCD/EBEbnV3W
	 mxWz7R7g03qtATqlSYvvqROGj79mb2rlTipR1hCbgsCcDC/nI0NqaSDSwBbEi9Kfxs
	 rHVvxyGkAPNCw/5aH76SQCjHRfo6cUXtv0pxpgFpw3B33yVSAZFhBMxydEqI3J02k3
	 hZE3YJxwvnOKFfQHLrgXD24z5rSY5RRSioU/ptiUhdCGNCzo8cnTs+lv/UdClVa+ay
	 r8idyFs9eWNFw31qPsD1Y0wnRC0PVKu/uUyhdeINT3q48UjuAjJ0HIwXrK0K4iT/sQ
	 Wcg/vvg3zjU8Q==
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 0/9] exfat: convert to iomap
Date: Thu,  7 May 2026 21:42:29 +0900
Message-Id: <20260507124238.7313-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series converts the exfat filesystem to the iomap framework for
buffered I/O, direct I/O, and llseek (SEEK_HOLE/SEEK_DATA) support.

iozone benchmark results (4KB cluster size, -s1g -r64k, 1GB file, 64KB record size)

                       1 thread                  4 threads
                     Write      Read           Write      Read
                     (MB/s)    (MB/s)         (MB/s)    (MB/s)
-----------------------------------------------------------------
exfat + iomap patch   332.7     418.1           78.6      82.4
Current exfat         278.4     415.1           42.1      38.0
-----------------------------------------------------------------
Improvement           +19.5%    +0.7%          +86.7%   +117.4%


v2:
  - Replace macros with static inline functions.
  - Remove noop_direct_IO.
  - Consolidate read and write iomap_begin into __exfat_iomap_begin()
  - Zero out stale data in straddle block beyond valid_size.
  - Introduce IOMAP_F_ZERO_TAIL flag to remove exfat_iomap_put_folio().
  - Select FS_IOMAP in Kconfig.
  - Remove unnecessary alignment check in exfat_file_read_iter().
  - Just use generic_file_llseek directly.
  - Move exfat_extend_valid_size to exfat_file_write_iter().
  - Use pagecache_isize_extended() to remove iomap_zero_range in
    exfat_setattr().
  - fix mmap write data corruption with byte-by-byte fallocate.
  - Remove exfat_mkwrite_iomap_begin().

Namjae Jeon (9):
  exfat: replace unsafe macros with static inline functions
  exfat: add balloc parameter to exfat_map_cluster() for iomap support
  exfat: add exfat_file_open()
  exfat: add support for multi-cluster allocation
  iomap: introduce IOMAP_F_ZERO_TAIL flag
  exfat: add data_start_bytes and exfat_cluster_to_phys() helper
  exfat: add iomap buffered I/O support
  exfat: add iomap direct I/O support
  exfat: add support for SEEK_HOLE and SEEK_DATA in llseek

 fs/exfat/Kconfig       |   2 +-
 fs/exfat/Makefile      |   2 +-
 fs/exfat/balloc.c      |   2 +-
 fs/exfat/dir.c         |  50 +++---
 fs/exfat/exfat_fs.h    | 140 ++++++++++++-----
 fs/exfat/fatent.c      |  30 ++--
 fs/exfat/file.c        | 253 +++++++++++++++++++++++-------
 fs/exfat/inode.c       | 342 ++++++-----------------------------------
 fs/exfat/iomap.c       | 247 +++++++++++++++++++++++++++++
 fs/exfat/iomap.h       |  15 ++
 fs/exfat/namei.c       |  28 ++--
 fs/exfat/super.c       |   5 +-
 fs/iomap/buffered-io.c |   4 +
 include/linux/iomap.h  |   4 +
 14 files changed, 678 insertions(+), 446 deletions(-)
 create mode 100644 fs/exfat/iomap.c
 create mode 100644 fs/exfat/iomap.h

-- 
2.25.1

