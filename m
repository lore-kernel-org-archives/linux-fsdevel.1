Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA3345757;
	Wed, 13 May 2026 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671325; cv=none; b=b/XPV6QwliYiVLjZWeYhWJWMEU6Rlrk6FNqBdpoS1s9ggcSHf72XPoiCkyx6lwe6NPaKEclUXjCCrmds29FxzYU4poCoZRNR/sCaaSkoclUZnQparNGWjCnokHt+1gBJ1mu0OpVrTuTNO8SFw2rWe5q4NL7gebNf9UoC2d2kBFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671325; c=relaxed/simple;
	bh=8jNfAYAZU96IqAOkRyT6wqtLWnYmNIXipezIEDWIr08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z+0wwgIn2Ylva20GiHKygYb2qLa1R5ldkc39TDGvD1xTf3oBaXRBGvU2seLXlWJqEa6pgQwHxVYfNmMjaS7aTf7qj2OeLsS52iG2EWPvQpti/P4vz/vrBrHxArTdQLGiWWb/TdLqGzXAYobAzpJkgCVWZrC/4jGmi2z2M9MnVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlMAGl3R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlMAGl3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E519AC2BCB7;
	Wed, 13 May 2026 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778671324;
	bh=8jNfAYAZU96IqAOkRyT6wqtLWnYmNIXipezIEDWIr08=;
	h=From:To:Cc:Subject:Date:From;
	b=qlMAGl3RXx/h3IVtgVvp635Ey7A1WtwHDujHnt1b+oqVxWS+GL/YI9u2QjvTR5Hoe
	 ygAHs3IbRBDaFwrQrlpBnj9xWe2xZBtTFBkV0teRAfVJz4+TTSwAyeCAAFrzLufI0K
	 4UgiwVJK0qQF7lWpl3gd2OKEXKAxzoOIInlRLbdJTo8584EUd0gxZ6RDfFzThE6StI
	 snC4yekWP2Mm0P8GVSBS43NI619nsxmM0jg4pgulpLF/czFLTm8Mx0ldQBKpJh1JyW
	 ZqjQxEt3pqDcZA2gyT9I/fMRMuyORa//NEMoFr7qko4zmTE4k/ZztDQPwdidbX7vJa
	 GhB9JEiRCRwXg==
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
	chizhiling@163.com,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 00/11] exfat: convert to iomap
Date: Wed, 13 May 2026 20:21:45 +0900
Message-Id: <20260513112156.9122-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


Available in the Git repository at:
===================================
git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git iomap-work


v3:
  - Remove extra >> 9 when adding to inode->i_blocks.
  - Simplify exfat_file_open() by removing unnecessary err variable.
  - Separate exfat_truncate() error return conversion from iomap changes.
  - Fix xfstests failures with 512B cluster size.
  - Make exfat_truncate() return error code.
  - Use inode lock to protect valid_size in exfat_extend_valid_size().
  - Unify num_clusters calculation regardless of may_alloc.
  - Use min_t() to clamp iomap->length.
  - Return early in exfat_write_iomap_end() if no data written.
  - Remove s_lock in exfat_write_iomap_end().
  - Split DIO fallback buffered write into helper function.
  - Remove unnecessary goto in exfat_dio_write_iter().

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

Namjae Jeon (11):
  iomap: introduce IOMAP_F_ZERO_TAIL flag
  exfat: replace unsafe macros with static inline functions
  exfat: add balloc parameter to exfat_map_cluster() for iomap support
  exfat: add exfat_file_open()
  exfat: add support for multi-cluster allocation
  exfat: add data_start_bytes and exfat_cluster_to_phys() helper
  exfat: fix implicit declaration of brelse()
  exfat: add iomap buffered I/O support
  exfat: add iomap direct I/O support
  exfat: add support for SEEK_HOLE and SEEK_DATA in llseek
  exfat: make exfat_truncate() return error code

 fs/exfat/Kconfig       |   2 +-
 fs/exfat/Makefile      |   2 +-
 fs/exfat/balloc.c      |   2 +-
 fs/exfat/dir.c         |  50 +++---
 fs/exfat/exfat_fs.h    | 140 ++++++++++++-----
 fs/exfat/fatent.c      |  30 ++--
 fs/exfat/file.c        | 262 +++++++++++++++++++++++--------
 fs/exfat/inode.c       | 342 ++++++-----------------------------------
 fs/exfat/iomap.c       | 266 ++++++++++++++++++++++++++++++++
 fs/exfat/iomap.h       |  15 ++
 fs/exfat/namei.c       |  28 ++--
 fs/exfat/super.c       |   5 +-
 fs/iomap/buffered-io.c |   4 +
 include/linux/iomap.h  |   4 +
 14 files changed, 705 insertions(+), 447 deletions(-)
 create mode 100644 fs/exfat/iomap.c
 create mode 100644 fs/exfat/iomap.h

-- 
2.25.1

