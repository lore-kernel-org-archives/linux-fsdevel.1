Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6851B347FE1;
	Mon, 18 May 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104914; cv=none; b=DF0o2a/i6OiXx41o+WHHka0t2mzrtn8IQ5IsSlBH/VILMQERYBNObzMsrxa8aVY+jZaRo3lUeyh3wRYBEYVt88yy1gctLi+qpDM7eG99rAGbYXoNhFKmBOPiXTmg1MdBbHmj7SXyBJEHBCCg2oTrn4sCDlPODH4NK2dt4ZzV2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104914; c=relaxed/simple;
	bh=qkPcJ/zylYk2dPkwzgQJ4Dui7Xt+5Z4nn1gBwmmmjes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kvzseaEROglVA/RUI9QhxTAYhM2xK8f/DpHO1lpAvcy+YI4bVAQMtG9ZL97JszbE3yu0UyL80v0JNjqVNXnX/WA/bZ63gcD5VOCAVJahOHAhRcWa6YC+GOvDn0B/9oK59eOah3H6iNzihkHb7LpocP7hd6KyL8+dVpwhd1liBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlrGPdvv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlrGPdvv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D02C2BCB7;
	Mon, 18 May 2026 11:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104914;
	bh=qkPcJ/zylYk2dPkwzgQJ4Dui7Xt+5Z4nn1gBwmmmjes=;
	h=From:To:Cc:Subject:Date:From;
	b=hlrGPdvvm05R0bMUfPclsCrVe6W72OWveM7TjgaBwP4Zd33XDbtnjJHJFICvSlLsh
	 /Ix0Z6g/rN4vo8zqur8k/0fHBgYu7uFVrqcerpqo2mjaUpUTMwKf3sqP9O/gPmfHhl
	 TFrgOmmzILYwl70sOVkGM9I551dFP8DMq5oiL7BiZh5dzPd3c0uPwxp3GFFdZ1jy1B
	 hYzhx8wBAA+rV3OKRh1NIYuyMklye7Cie6fXvWLyPIALEmkF80JNLJn3Y+/hTZ+yMa
	 BI2WyQmNA4lseD++davjllFUZWJH0t/AVJoktqBibf+JTjyBxM2GwhxODTQLsNS0uH
	 bq/vkE/GAt25A==
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
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 00/11] exfat: convert to iomap
Date: Mon, 18 May 2026 20:46:54 +0900
Message-Id: <20260518114705.9601-1-linkinjeon@kernel.org>
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

v4:
  - Declare initialized variables before uninitialized ones in
    __iomap_write_begin.
  - Clean up the logic for handling ei->valid_size in the non-alloc
    iomap read path.
  - Rename exfat_cluster_to_phys to exfat_cluster_to_phys_bytes.
  - Use end variable in exfat_fallback_buffered_write.

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
  exfat: add data_start_bytes and exfat_cluster_to_phys_bytes() helper
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
 fs/exfat/file.c        | 263 +++++++++++++++++++++++--------
 fs/exfat/inode.c       | 342 ++++++-----------------------------------
 fs/exfat/iomap.c       | 263 +++++++++++++++++++++++++++++++
 fs/exfat/iomap.h       |  15 ++
 fs/exfat/namei.c       |  28 ++--
 fs/exfat/super.c       |   5 +-
 fs/iomap/buffered-io.c |   4 +
 include/linux/iomap.h  |   4 +
 14 files changed, 703 insertions(+), 447 deletions(-)
 create mode 100644 fs/exfat/iomap.c
 create mode 100644 fs/exfat/iomap.h

-- 
2.25.1

