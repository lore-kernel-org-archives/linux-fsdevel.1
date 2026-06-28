Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63E2192F9
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782623773; cv=none; b=Jv70L4EKyL2PtoS802ziGaHQXzn55TPTQQPCG36rDjKfIwZvaHHVqZF+4os+HwdNFt0jS6rtR0qQOUmTihsTR+NFj6wPP5vlF9NPGigCIswcAZtwHMXL2+lPqyabIN9/kjNbNHtT2rparxwRLXNxwfTbIysUyobGJU5mzd6vSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782623773; c=relaxed/simple;
	bh=LdhaZleNJRUwe4JYQuAWBqYshk0fLsleZK5Xr/J1ruk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+tpolg40Hwht5tRS/ce2Asxzk5o3mNy343nAHKgZz0ka56jlbNMeGr3uJcqozQcTtiJiM+E9QMoCKMzVuEJtTRPDlXK8XXdEbi6rZEY3cQusc3IsnCPn7xWuJktRVxbsTC9RX6P45pjwp98m3C/vTg4bhsZgk4EQyB0CHCw450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqLWrOdc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqLWrOdc"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c858961a8efso845366a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2026 22:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782623770; x=1783228570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+LC5/gwwqovrpJnoWSyelRC02LAWuq1l82/9MF6QXA=;
        b=CqLWrOdchF+Inc+idSjyeC0+u6myse7x4zmGuqi3vRKfLXBm/h6kd0gXehY0SM3XK1
         vGhe9//S9n5ammB/bJaFHWInfYiQYmKd6tQi94n2nOqgC5OANHx5FuUYXpOE6IOBvKyn
         GNt+mkrUHRCZ8zdYSSrtwOsRQQUrZXJ+rSnCWj62+Jfa+qN/9GVRhqmoaHRHTtU3uALh
         4bTtRXXLRaFzraB+QaMbLuZiVwaCFLElnxw8hy9tAC4RbN0DgU31qQfZ+wQ/hRn94nHC
         zqZCLViYMXTz3tH8eULL3KG7+FlRoUKXlCooM+gWbT96Xc7CXRZKy1HmJHw+Ve/rkkMS
         W9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782623770; x=1783228570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+LC5/gwwqovrpJnoWSyelRC02LAWuq1l82/9MF6QXA=;
        b=E2iNRUBXSaTlUUrv+FN6ndX2FU4SRbG3A7AI6gsNcTLSm1vgbe2gVWCnGt9x/YEqJD
         VukqNsLKrdApX1rsrgRAgGtcwNSVKaZhrUl7goyo/rskYqswkjKUzAcfligCAJd1LbE0
         uOzCrD4uuhHQXaNS8xYjOwZKH6BwZTcetdDd+KcuDLkRqI7VOMHMtC27Z2khPpwfYFfJ
         AFQekwAxAi2xzl70eRNuQaagt66qz/tk/WWZQFZDN9s2jLEOs/mhtruqWDlv2sQnuSgO
         JUxilc1xRd/11PNGXmAfKFp9UIgIjrLFX0thS2nmaA6QDrLD3zxfQrjBNxqcn16RwKwb
         wE+w==
X-Gm-Message-State: AOJu0Yys3TerfvwIcDLlOmRf17ip07A0cnRh9vxlOrmx4W+V52++FiSx
	P5vcbtiY1K5hZR71WYtaRRCkLwYEi/wHE/po50DK7bqsLL/qGMUktbAq1RqUbZ9m
X-Gm-Gg: AfdE7clhc5ALH1BpgDR3h4N4QIx0oWDMocL0RBJYOyAUlTu86GGXouBrgpI3sETAnei
	YLBWYXcJR0e1mchx++FKIVO04toY/5n62j30S0GIKLacNNB26/Jgp0bzkl1BfA5UArhzoxCJScc
	IKsKdezUgMtsT6AA3212A2Nll8lE3F6NjDrwqYnnBe/pw/1AMLTC5TBh4WXlUd3OmGjvQBMIFS7
	QefDIu734OxmDaEoQFvr++swuzAoTwQE8cMJNPvgO8WWq2u7G2HrHgVYAb8spIXBRM4FSZhlZAQ
	CxoM7RZfLUkhkK2Put0SwNnrXtX8mvqzS6oeOaR/PwCNH9WZFNvZw3cp5yIx5Ak9i6CMlh2RVCV
	nnteTM4bvJr0NhSnLmb1zwrnJD6L82c7yL478YsW5O1Rui8+VTWxb6pmOb8aD58Y=
X-Received: by 2002:a05:6a20:ae24:b0:3bf:6c08:2b28 with SMTP id adf61e73a8af0-3bf6c084aa6mr5243025637.48.1782623769655;
        Sat, 27 Jun 2026 22:16:09 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9dc216csm5793263a12.9.2026.06.27.22.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 22:16:08 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	hch@infradead.org,
	viro@zeniv.linux.org.uk,
	syzkaller@googlegroups.com,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v2 0/4] minix: convert to iomap and add direct I/O
Date: Sat, 27 Jun 2026 22:15:52 -0700
Message-ID: <cover.1782619718.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the minix iomap conversion series. The original v1
submission (3 patches) was tested by syzbot, which found four issues.
Three were straightforward; the fourth, a null pointer dereference in
page_symlink when creating symlinks, required more substantial changes.

The original description follows:

This series converts the minix filesystem from the buffer_head-based
I/O path to the iomap API, and adds direct I/O support in the process.

The conversion is straightforward: minix's indirect block tree mapping
logic (from itree_common.c) is reworked into an iomap_begin/iomap_end
implementation. The iomap_end callback is a no-op since minix has no
extents or transactions to finalize.

Patch 1 adds the iomap infrastructure: the new iomap.c file, wrapper
functions and iomap_ops structs in itree_v1.c and itree_v2.c, and the
relevant declarations in minix.h.

The iomap.c file is #include'd into itree_v1.c and itree_v2.c rather
than compiled as a standalone translation unit. This is because the
minix filesystem versions (V1 vs V2/V3) have different block_t sizes
(16-bit vs 32-bit) and different indirect tree depths. This follows
the existing pattern in minix where itree_common.c is included into
both itree_v1.c and itree_v2.c. Each version provides a thin wrapper
and a corresponding iomap_ops struct.

Patch 2 converts the regular file address space operations to iomap:
read_folio, readahead, writepages (with a writeback callback), bmap,
and folio lifecycle helpers. Directory inodes continue to use
buffer_head-based operations via a new minix_dir_aops, since directory
handling still relies on buffer head chunks for prepare/write_begin.

Patch 3 converts the file_operations: replacing the generic read/write
iterators with iomap-aware versions, adding direct I/O read/write paths
using iomap_dio_rw, and setting FMODE_CAN_ODIRECT in the open handler.

The minix iomap implementation was adapted from the out-of-tree xiafs
iomap conversion. The xiafs module itself borrowed heavily from the
modernized minix kernel module. The exfat iomap changes were an
additional reference for both conversions.

Changes since v1:

  * Added a fourth patch to fix the symlink and truncate issues:
    - Replaced page_symlink with a custom __page_symlink that writes
      the target directly to a data block via minix_new_block +
      sb_getblk, bypassing the aops write path (which no longer has
      write_begin/write_end). Added a matching custom minix_get_link
      that reads the target from the data block via sb_bread, similar
      to ext4_get_link. No iomap-based filesystem in the kernel uses
      page_symlink; XFS, GFS2, and ext4 all handle symlink storage
      directly. The on-disk format is unchanged.
    - Fixed a buffer_head/iomap type confusion in truncate:
      block_truncate_page attaches buffer_heads to data folios, but
      minix_aops now uses iomap which interprets folio->private as
      struct iomap_folio_state. truncate() now dispatches between
      iomap_truncate_page (for regular files/symlinks) and
      block_truncate_page (for directories) based on the inode's aops.
    - Added .setattr = minix_setattr to minix_symlink_inode_operations
      so symlinks truncate properly through the iomap path.

  * Patch 1 (iomap infrastructure): minix_get_block is now exported
    (non-static) so the directory aops and iomap writeback path can
    use it. Added minix_iomap_ops_ver() inline helper and extern
    declarations for minix_aops and the version-specific iomap_ops.
    Fixed unsigned -> unsigned int in minix_blocks_needed and
    minix_find_first_zero_bit to silence checkpatch warnings.

  * Patch 2 (aops conversion): unchanged in approach; minor cleanup
    of the writeback callback and minix_bmap conversion.

  * Patch 3 (file operations): minix_setattr is now exported for reuse
    by the symlink inode operations in patch 4.

Testing: the full series has been tested with mkfs.minix V1/V2/V3,
exercising file creation, read/write, overwrite, append, binary data,
directories, symlinks (full path, relative, directory symlinks), hard
links, truncation (shrink/grow), large files (1MB, exercising indirect
blocks), deep nesting (20 levels), 100 files in one directory,
deletions, remount persistence, and fsck.minix. All pass cleanly. The
four syzbot-reported issues are resolved.

Jeremy Bingham (4):
  minix: add iomap infrastructure
  minix: convert address space operations to iomap
  minix: convert file operations to iomap and add direct I/O
  minix: fix symlilnk and truncate for iomap compatibility

 fs/minix/file.c         | 157 ++++++++++++++++++++++++++++++++++++++--
 fs/minix/inode.c        |  90 ++++++++++++++++++++---
 fs/minix/iomap.c        | 114 +++++++++++++++++++++++++++++
 fs/minix/itree_common.c |  11 ++-
 fs/minix/itree_v1.c     |  25 ++++++-
 fs/minix/itree_v2.c     |  17 ++++-
 fs/minix/minix.h        |  30 +++++++-
 fs/minix/namei.c        | 137 ++++++++++++++++++++++++++++++++++-
 8 files changed, 558 insertions(+), 23 deletions(-)
 create mode 100644 fs/minix/iomap.c

-- 
2.47.3

