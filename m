Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C239768E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161252; cv=none; b=LfwKf4jeQuYSpKQH6yF7pwhoGWK5bYcNHE4Ucx9qR6duJh/4uk3HEWE5mH4ZMSafV2WgGbqD7YWBQzebZyO4oJkuFxXU1trNhLlboquLLerWMMVT3TQvvl98yFVoD7pSkJbDGb3H1yMphpvEWvFbCvyD2/hiQ31485AzC6EvGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161252; c=relaxed/simple;
	bh=HbCnxRwzdxRHsMDYnZoDSXu/uOhcPiKq7KVZ5otnXFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/FvnVMvjnJOehmKukaumgFpeAnyB+I+9KFqjwBXwczoj44UfSWL+H9WXijDFRIezY7GV4q8wEJ11yZto9HZ+u2InjWDMeNVoZb6OBJuukn+q9nkP6fzc0zvMthbQcBi0LmwPB8vdHYr9Rw3LTHO0YJSCo+UapbcC1UInchTjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so6619525e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 03:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161249; x=1776766049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=II8LeYdAi1nzRAWUa9ndZauL/fI7IO61aYIab8wrj/c=;
        b=BGLkRRtED2UzXYERzpEdbnx2Zbl7XiPN0GwiD95ngjf8LftB82lRF9rVOZDzQ4jdS+
         3MDn2X9QKJZiyB6zBnaskOkuNqgUMtP5Iq+dfIUDvHXRqrCKPrZNaouErjMj68bEAthg
         lUAG8e1xbfpJ5QJGv3/RHq55ERCfHqrzB5gBnej02OPSGJy7lVIxzhnMUT6REnRR2Df/
         rK0Jeexl1c6mnCJQmanMeoSjGLVfvPpDdb8FwTb+zFjSpjKqV+URFzglJSZiq6jIUDsM
         KU+VEfIweIFX6sqibzzf9MzUou4kquP9CmvsNfhsp6yo9JfpeUMCdlmtRm8yP0rwoM+s
         Lmag==
X-Gm-Message-State: AOJu0YxzpAY657TCKUKq5Cdb5IAayJztDtnIo4xpwA/sXSJr3d0oO3Tg
	b5ymh4qWO+obrStWWkVyJMch0DNnh4z3QwuPdLuuUXsTSgirwQnUJlKR3yXnjW/U
X-Gm-Gg: AeBDiesWOU3Dw0PcwWbOw4PbuXZt3DnME3uT11A+KfHt2e+h1BzfAZWp75k0GJ4lHjW
	UMvu8ARjKZ0lRP2Gbnw9+1VQOc5zFK0Spl31QyulENXVNiXFTHlvISDpG1nWweh358CMZiBLf61
	/LOwCb8b9kJdiCI8XyC4Sz42lDncLgvWuHCsx7ecMbfLG/ceFbl3Q/ZMknV2aMhlnFifToupei0
	FSAYH8g0eO6o9mP3TJmIpRifTCJuiC+j7ZbzNyec+TvAifAl1KC8gobiPAwx2+TXjXU4FvqJMnq
	kKSfPK1Y787b8QtuNqNWr4iX/iDTKKGd2rCd70RokzgeW8gScHQZkVz6fN6h1CP2MROrjmQPMDk
	c3y4cNWEYrwQYMVtjoeK6muv1QM0YfwfTIfEQNYQGNJlyXzycHZRyXBfBKT9MKuFT+mRPTJ+eLR
	475i3xeDCKURow/UwD3nAKYX/OCTKpYllp2mjcHB5y35UHg9CqYuuvff1obLxf4oLv6We9Cdc8e
	T1zNtbF3qszfA==
X-Received: by 2002:a05:600c:1d14:b0:486:f634:f2e with SMTP id 5b1f17b1804b1-488d68b4086mr121841425e9.4.1776161248728;
        Tue, 14 Apr 2026 03:07:28 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm65870545e9.5.2026.04.14.03.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:07:28 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger.kernel@dilger.ca,
	pedro.falcato@gmail.com,
	xiang@kernel.org,
	Aurelien DESBRIERES <aurelien@hackers.camp>
Subject: [PATCH v3 00/12] ftrfs: Fault-Tolerant Radiation-Robust Filesystem
Date: Tue, 14 Apr 2026 14:07:13 +0200
Message-ID: <20260414120726.5713-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413230601.525400-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v3 of the FTRFS patch series. FTRFS is a Linux kernel filesystem
designed for dependable storage in radiation-intensive environments,
implementing Reed-Solomon FEC at the filesystem block level for in-place
correction of silent bit flips on single-device embedded systems (MRAM,
NOR flash) without external redundancy.

Based on: Fuchs, Langer, Trinitis - ARCS 2015, TU Munich / MOVE-II CubeSat.
Full text: https://www.cfuchs.net/chris/publication-list/ARCS2015/FTRFS.pdf

Changes since v2 (<20260413230601.525400-1-aurelien@hackers.camp>):

  - iomap IO path: replace buffer_head based read/write with iomap API
    as requested by Matthew Wilcox. Implements ftrfs_iomap_begin/end,
    iomap_writeback_ops (writeback_range/writeback_submit), and uses
    iomap_bio_read_ops for the read path. buffer_head is retained for
    metadata IO (inode table, directory blocks) as discussed.

  - rename: implement ftrfs_rename in namei.c. Handles same-dir and
    cross-dir rename for files and directories, updates '..' entries
    and nlink counts. RENAME_EXCHANGE and RENAME_WHITEOUT return
    -EINVAL (not supported in v3).

  - RS FEC decoder: implement full RS(255,239) decoder in edac.c using
    Berlekamp-Massey error locator polynomial, Chien search, and Forney
    algorithm for in-place correction. Corrects up to 8 symbol errors
    per 255-byte subblock. Returns -EBADMSG if uncorrectable.

  - Radiation Event Journal: persistent ring buffer of 64 x 24 bytes
    in the superblock reserved area. Records block number, timestamp
    (ns), symbols corrected, and per-entry CRC32 for each RS correction
    event. Written under spinlock via ftrfs_log_rs_event(). No existing
    Linux filesystem provides this filesystem-level radiation event
    history - VxWorks HRFS, btrfs scrub, and NVMe SMART all operate
    at different layers.

AI tooling disclosure (Documentation/process/coding-assistants.rst):
  Assisted-by: Claude:claude-sonnet-4-6
  The submitter takes full responsibility for all code, has reviewed,
  tested, and debugged every patch.

Testing:
  - qemuarm64, kernel 7.0 final (Yocto Styhead 5.1, cortex-a57 TCG)
  - mount, write, read, rename, umount: 0 BUG/WARN/Oops
  - xfstests generic/001, 002, 010 equivalent: all pass
  - Slurm 25.11.4 HPC cluster validation (3-node parallel jobs)
  - checkpatch.pl: 0 errors, 0 warnings on all modified files

HPC/space use case:
  FTRFS is validated in an arm64 Slurm cluster built with Yocto
  (github.com/roastercode/yocto-hardened, branch arm64-ftrfs).
  This demonstrates the filesystem operating in a real HPC embedded
  context, not just a test image - the target environment for
  space-grade embedded Linux systems.

Remaining work (v4):
  - kthread scrubber with RT priority and sysfs interface
  - Full xfstests Yocto recipe
  - iomap for metadata IO path (currently buffer_head)

Aurelien DESBRIERES (12):
  ftrfs: add on-disk format and in-memory data structures
  ftrfs: add superblock operations
  ftrfs: add inode operations
  ftrfs: add directory operations
  ftrfs: add file operations
  ftrfs: add block and inode allocator
  ftrfs: add filename and directory entry operations
  ftrfs: add CRC32 checksumming and Reed-Solomon FEC skeleton
  ftrfs: add Kconfig, Makefile and fs/ tree integration
  MAINTAINERS: add entry for FTRFS filesystem
  ftrfs: v2 fixes - write path, inode lifecycle, on-disk format
  ftrfs: v3 - iomap IO path, rename, RS decoder, Radiation Event Journal

 MAINTAINERS       |   6 +
 fs/ftrfs/Kconfig  |  49 +++++
 fs/ftrfs/Makefile |  46 ++++
 fs/ftrfs/alloc.c  | 251 +++++++++++++++++++++
 fs/ftrfs/dir.c    | 126 +++++++++++
 fs/ftrfs/edac.c   | 277 +++++++++++++++++++++++
 fs/ftrfs/file.c   | 197 +++++++++++++++++
 fs/ftrfs/ftrfs.h  | 201 +++++++++++++++++
 fs/ftrfs/inode.c  | 104 +++++++++
 fs/ftrfs/namei.c  | 548 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ftrfs/super.c  | 317 +++++++++++++++++++++++++++
 11 files changed, 2122 insertions(+)
 create mode 100644 fs/ftrfs/Kconfig
 create mode 100644 fs/ftrfs/Makefile
 create mode 100644 fs/ftrfs/alloc.c
 create mode 100644 fs/ftrfs/dir.c
 create mode 100644 fs/ftrfs/edac.c
 create mode 100644 fs/ftrfs/file.c
 create mode 100644 fs/ftrfs/ftrfs.h
 create mode 100644 fs/ftrfs/inode.c
 create mode 100644 fs/ftrfs/namei.c
 create mode 100644 fs/ftrfs/super.c

-- 
2.52.0

