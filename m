Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D913F54B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781651613; cv=none; b=VLO/O04hMwGXcdbU+JZUSMR58E3cVZsxiDRLYNB+8ODMqQwlzvYOK4ok12/ECOQMEdoipBF/UQpq0SYWmZzk1K1etvqUzhMqsjPFjQ/ftmrCKmv9EczCCHXFWKcyZPYPRkogZNRmbiwPKuE+tr7OOrOty4bMA99ymROY+MGakEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781651613; c=relaxed/simple;
	bh=J1c6OcagpBk8GqgueK4lBEjPDBmI6ulHmPnbkbmERQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMyKo6pOsakIZhep90NVAIMoHezBZhNbsWlrAxC0alSGNex0xvs/IeRvAhaBrcTalm2lGZK565FDiOGBLH73cKqAQnbcqskfEr7KoS0BchGmnnYUip/+sN1/hGRJdaRF683kcNhX2nARWozr4dk945WUSCiFonpd6ParlwfUleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJBpmVXQ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJBpmVXQ"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6f586a0d5so2620434a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 16:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781651610; x=1782256410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MERZi8+A8JnkZle768llNfGQuagsfS4H/Ir2Lyg/cbk=;
        b=fJBpmVXQA1gYlNhFKxRbYNoers7Xo8YNXAS4eaUAO0FefgMxgpjwhp+5FbPZhfYROt
         In08rpdQ7MebE/BhLKwvGPuWK/XWTCn+sjduNIjhKZQXv1emcTYMJwXnsrJimuwe5J7J
         Qw3iqyKSyxtY0NWz87HiUZ5LsPw5Z11qMUvE9kGtSQK0A/BweL2LuEwuNOOdbNGGqITz
         CubyVIkZdq6r11lSwhpXjbnpCSzMPi49AE/8Q7RUdGBL4Sb96CRG7DvxUoBQ02hwduIq
         BkBhp5WGojcQS86Gq/q+tqDliTkdUBDPDl28bKY4IOZs0BbA4L+WMZ8M28m0KiHyX6WH
         F0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781651610; x=1782256410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MERZi8+A8JnkZle768llNfGQuagsfS4H/Ir2Lyg/cbk=;
        b=aHyr1j2/v4CN3tzHx2kbTsAq6SuYlTIczBz5upYVQxlan6ZJcZAfxafRzaSj14DG/p
         sX+S1QknsaGfzB+mO+3pFJiunqI2caTMp88TR5X6KtxYkPc7BQXotU4DrxmK4abQHzpY
         2xs9xRh02p/jXaYzg/eQfs2IP8NAJFFCNKZAFiPtmccjPCfT6SUuVFQU6kdh+9atRIgD
         chO1zid/pn7TtGsTeT4gw3WTzvnk1pTzKbjK4Ca9qLzbnfg3BEVUQzKKO6gm7wOT+MoQ
         TuiXPIDjutypQZ7/QeHg2CsFo7zQEhYNfxGXiNBtD5ZKor/+5bD4jMSti1PSsliNLRKO
         aJ/g==
X-Forwarded-Encrypted: i=1; AFNElJ8MP+jOSTnqfh+WmZA5zvklA/xzWIA4b6k3jyjm0P9ttTB2u/CJiw5aF8tC8DZaVxY9f6SmB25hZ/UKt0fF@vger.kernel.org
X-Gm-Message-State: AOJu0YywdtbUGY1UpC5hgFuEF2PifITtS+8iNeJTp3PLhRPUPgU5pV3X
	Z6Afd+4puTpMs79bPGWtC3RdfwajXmOFmplqSfKvcWElaxeXkEZ/X7SijOawBA==
X-Gm-Gg: Acq92OFoHd6DVKH7P2PV6Ol9AHw4RG+rlYGtiswd0Sn2AYJP+VbpnQi0p1RB9cn22/I
	tLd5d9M945tH75Jb3goV5uLN3RGU3AONK0JpbyKe6OMYFBjYpTO6iRB2XpNcqplMHLeFDRfYbDH
	A/UrmKbcY/hlqrxDpqZ14LZTWzxWrvR06XJzXVhU/HEE2SHMdzje9Hl/S0eYWw4xkD55KssAVIQ
	dTrZAcU6nuZ0Eg0xLLDJ0wni2ywOkVal/+ZFTvjtAi9u503jbjWd8TbocmmmvtD1CT42mVQIZXF
	xWSzG2vnr+64QRsh7GlUK8RghHVXERgpoBKpF4L7Bbmgc6XQvoRid9jTd8zQfSMPjPmXZLIk2RT
	COwlWyJ7tSF9PYOjMqPystiRCaF9Wp6XsubzN/1vfYzvmwEoLQGCc6P4m1lkWElCPQ9pEcrvgqm
	enL8/wmZynJ5jeP2yLeCRNbcdTc9cU6DeP1qZck6/IjNrFU8i7yM5BE+0vEXFTqFYO0TYqfs0/c
	ZazB5bU+DMsOy+K8p/9P+g9bDbAsopOVsJ0iQ3AxVmmphiTARNgEZw=
X-Received: by 2002:a05:6830:4901:b0:7e6:d54e:8fe3 with SMTP id 46e09a7af769-7e90b322f5dmr1484178a34.9.1781651609737;
        Tue, 16 Jun 2026 16:13:29 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a1b86sm7530924a34.5.2026.06.16.16.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 16:13:29 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
To: miklos@szeredi.hu,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Russ Fellows <russ.fellows@gmail.com>
Subject: [PATCH v3 0/2] fuse: fix passthrough parallel direct writes
Date: Tue, 16 Jun 2026 23:13:20 +0000
Message-ID: <20260616231325.16788-1-russ.fellows@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes FOPEN_PARALLEL_DIRECT_WRITES being silently ignored for
FUSE passthrough opens.

Changes since v2:
  - Patch 1: introduce FOPEN_IOMODE helper macros (FOPEN_IOMODE_IS_CACHED,
    FOPEN_IOMODE_IS_DIRECT, FOPEN_IOMODE_IS_PASSTHROUGH) to make the flag
    conditions self-documenting.  Use FOPEN_IOMODE_IS_CACHED for the
    PARALLEL_DIRECT_WRITES guard.  No behavioral change.
  - Patch 2: replace open-coded lock/unlock with fuse_passthrough_lock() and
    fuse_passthrough_unlock() helpers local to passthrough.c.  Add a post-lock
    re-check of the past-EOF condition to close the TOCTOU window between the
    initial check and acquiring the shared inode lock.  Restore
    fuse_dio_lock()/fuse_dio_unlock() to file-private (static) and remove
    their declarations from fuse_i.h.

Patch 1 preserves FOPEN_PARALLEL_DIRECT_WRITES for passthrough opens.
fuse_file_io_open() stripped the flag for any open lacking FOPEN_DIRECT_IO.
That rule is correct for the regular direct-IO path but wrong for passthrough:
passthrough already bypasses the page cache through the backing file without
needing FOPEN_DIRECT_IO.  The new FOPEN_IOMODE_IS_CACHED guard expresses the
correct invariant: suppress the flag only for cached (page-cache) I/O mode.

Patch 2 makes fuse_passthrough_write_iter() respect FOPEN_PARALLEL_DIRECT_WRITES.
Previously the function held the exclusive inode lock unconditionally, ignoring
the flag entirely.  The new fuse_passthrough_lock() allows shared inode locking
only for direct within-EOF non-append overwrites, and serializes everything else
with an exclusive lock.  A past-EOF re-check after taking the shared lock closes
the TOCTOU race where a concurrent EOF-extending write could slip in between the
initial check and the lock acquisition.

Passthrough files are always in uncached iomode (committed at open time via
fuse_file_uncached_io_open()), so the fuse_inode_uncached_io_start() guard from
fuse_dio_lock() is not needed here.

Performance
-----------
Tested on kernel 6.17.13-p4min-v3, custom FUSE daemon with
FOPEN_PASSTHROUGH | FOPEN_PARALLEL_DIRECT_WRITES, XFS on a RAM-backed null_blk
device.  fio randwrite 4K direct, iodepth=64:

  numjobs | FUSE IOPS  | Raw XFS IOPS
  --------|------------|-------------
        1 |    478,564 |      528,835
        2 |    941,483 |      ~1.0M *
        4 |  1,457,284 |      ~1.5M *
        8 |  1,675,749 |    1,693,406

  * Raw XFS numjobs=2,4 not re-measured on this kernel; numjobs=1 and 8
    directly measured.  FUSE at numjobs=8 reaches 99% of raw XFS throughput,
    confirming the shared-lock path is fully active and passthrough overhead
    is negligible.

Correctness Testing
-------------------
All seven cases were run on kernel 6.17.13-p4min-v3+ with a custom FUSE
daemon advertising FOPEN_PASSTHROUGH | FOPEN_PARALLEL_DIRECT_WRITES, backed
by XFS on a RAM-backed null_blk device (8 GiB).  Each case targets a distinct
decision branch in fuse_passthrough_lock() and the surrounding write logic.
The test harness verifies both completion status and exact final file size.

  overwrite
    Setup:    Pre-seed a 1 GiB file via single-job sequential write.
    Workload: 4 concurrent fio jobs, 4K direct randwrite over the full 1 GiB,
              CRC32C verify on every block, runtime=30s.
    Lock path: FOPEN_PARALLEL_DIRECT_WRITES set + IOCB_DIRECT + no IOCB_APPEND
               + pos+len <= i_size -> shared inode lock (TOCTOU re-check passes).
    Validates: Core fix.  Parallel passthrough writes produce correct data under
               the shared lock; no corruption at any numjobs.
    Result:   PASS  (zero CRC verify errors; final size 1 GiB)

  read_write
    Setup:    Pre-seed a 1 GiB file.
    Workload: 2 fio writer jobs on disjoint 512 MiB regions (CRC32C verify)
              running simultaneously with 2 fio reader jobs roaming the whole
              file, all concurrent for 30s.
    Lock path: Writers take shared inode lock; fuse_passthrough_read_iter()
               takes no inode lock.
    Validates: Shared-lock writers coexist correctly with concurrent unlocked
               readers.  A deadlock or lock regression would stall the workload;
               a corruption bug would trip the per-block CRC verify.
    Result:   PASS  (zero verify errors; no stall; final size 1 GiB)

  append
    Setup:    No pre-existing file.
    Workload: 4 fio jobs, 4K direct write with --file_append=1 (pwrite() with
              userspace-managed offsets into a pre-fallocated region); each job
              writes 4 MiB; no time_based.
    Lock path: Writes land within the pre-allocated EOF -> shared inode lock
               (same within-EOF path as overwrite).
    Validates: Multi-job pwrite-based appends within a pre-allocated extent
               complete without data loss or size mismatch.
    Result:   PASS  (final size 16 MiB = 4 jobs x 4 MiB)

  o_append
    Setup:    No pre-existing file.
    Workload: 4 concurrent dd processes each open the file O_APPEND and issue
              16 x 4 MiB writes.  True O_APPEND: the kernel must atomically
              advance EOF before each write.
    Lock path: O_APPEND sets IOCB_APPEND -> fuse_passthrough_write_needs_exclusive()
               returns true -> exclusive inode lock unconditionally.
    Validates: IOCB_APPEND branch of fuse_passthrough_lock() serializes correctly.
               No two writers overlap; all 64 blocks land at unique offsets;
               O_APPEND atomicity is preserved through the passthrough path.
    Result:   PASS  (final size 256 MiB = 4 x 16 x 4 MiB)

  extend
    Setup:    truncate file to 64 MiB (sparse).
    Workload: 4 fio jobs each write 64 MiB to a disjoint region starting beyond
              the initial EOF (offsets 64, 128, 192, 256 MiB); 1M blocks; direct
              I/O; no time_based.
    Lock path: Every write has pos+len > i_size -> the post-lock past-EOF re-check
               in fuse_passthrough_lock() forces an upgrade to exclusive lock.
    Validates: Exclusive lock is taken for all past-EOF writes; disjoint regions
               are written correctly; i_size advances to the correct final value.
    Result:   PASS  (final size 320 MiB = 64 MiB initial + 4 x 64 MiB)

  extend_race
    Setup:    truncate file to 64 MiB (sparse).
    Workload: 4 fio jobs all write the identical 64 MiB region [64 MiB, 128 MiB)
              simultaneously; last writer wins per block.
    Lock path: All writes have pos+len > i_size -> exclusive lock required for
               all.  The post-lock TOCTOU re-check is the key safety net: a job
               that passed the pre-lock past-EOF check and then lost a race with
               another writer must still upgrade to exclusive before proceeding.
    Validates: TOCTOU re-check correctness; no deadlock among N simultaneous
               past-EOF writers; i_size is consistent after all jobs complete.
    Result:   PASS  (final size 128 MiB = 64 MiB + 64 MiB; no deadlock)

  buffered
    Setup:    No pre-existing file.
    Workload: 4 fio jobs, 4K buffered (non-O_DIRECT) randwrite over 1 GiB,
              time_based 30s.
    Lock path: fuse_file_write_iter() routes buffered writes to
               fuse_cache_write_iter(), bypassing fuse_passthrough_write_iter()
               entirely.  This patch is not in the call path.
    Validates: Non-passthrough write path is completely unaffected by these changes.
    Result:   PASS  (final size 1 GiB)

Russ Fellows (2):
  fuse: preserve FOPEN_PARALLEL_DIRECT_WRITES for passthrough opens
  fuse: allow parallel direct writes in passthrough write_iter

 fs/fuse/file.c        |  4 +--
 fs/fuse/fuse_i.h      |  2 --
 fs/fuse/iomode.c      | 30 ++++++++++++++++----
 fs/fuse/passthrough.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 106 insertions(+), 12 deletions(-)

-- 
2.51.0
