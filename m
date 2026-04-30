Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B54213E89
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569662; cv=none; b=R3HZ4IBpz7PZVb1FU4ha3AsO08npQCT0VuxJwYl+9Jzg7wrAT65GGDBYn1rFLwLPQxya2VuhC4UmAZS83lySUQoTNRyFYpPiBaPmgTscUSlGp6o9Hz7hOmg0tTHpmxd5RdGA7tQdCcy5kUNGznF+A1n3IAw/C0MgdQCyFxup9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569662; c=relaxed/simple;
	bh=aIh0QUpJkXYDL0vJikLQt9/WdAnbtCXSWQwWjZ1WYM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHQpsg1M3TcBhKtgxVVaHqDdIQqDK33pGzPWYpj5IfjJCWHFj4rBhRnjDKFT9SpV6wQab9BIA4F2Oxb6IrMwTek9eRpa5ejsA5023HqiW0YkFRFy2mNFlLlKGvfUXC4qrcyGZiV7oIiyo8KxqHCcljViL1AZ8w0TmTEtvLCp+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIdTntFD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIdTntFD"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76afacbb0bso19437a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777569660; x=1778174460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMG+GSPU97B8lZo79fMBQKJT7K6QYtkwtmIjYs0oLkA=;
        b=iIdTntFD2G4Y0Xh2aRS8m78uVv089fPwQUfIuKVhrFFcc8VM7NR+73zkXJhHvkzMt5
         kHlLaK7H1YFjWuo+cNnmAxzI2Rw0Uk1qfHH6xTZFRb/Znrl4a1qipynSN0F5zeOLvIG6
         /1ZpbP1UZ9D3JSEh0OqxmJTirnSOOmVrABZOCS5teRSWicrNYTEuQ5NrY6BsaQ+8C9e2
         aQtHxgEh+cHaFw6kl71nm12Kac9D0f8U5PGcewEIevK5iu7x/MrMDd0WdXLz6zeY+Htr
         wR+n7MqGR0p2auxqt7+DqB7zFTE8Wv9hf+2iQ9Muh3ZtAjsOJL1ow1ldGaJ6E2jVLZ/0
         EUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569660; x=1778174460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMG+GSPU97B8lZo79fMBQKJT7K6QYtkwtmIjYs0oLkA=;
        b=j96ZNgvClEC7eIfM28i3RlRHilRB0ceaI1/Ug4QbKC7oYRK8n16ZeEgA/aUDelwCfY
         ct9y4b5dYs6UlmOrQ2ZQr/RrX8t6H11VQygnmDSmCSoSkXdpS8LIPhu6z92/i/pt9ZD1
         KjtdvdO0wplg/bcaZsjjKHBonDSSe3zeJIhzluG/7DvIiEnzccZ58kKaWiHQYseAd1XE
         emJtdFomjiK+lzLRajmgGhbj4vonrg4Az66lGfgMvvaaf0wikXd+hHS75QNiSk9xpiN7
         T/Cf3LFB6Rd74HeX1MIzWKcW9+mXaILGzQZiMAJPxK2mzx/9ETZv5zzYfI+bV+TOUK2n
         Ew6w==
X-Forwarded-Encrypted: i=1; AFNElJ+OTbcbPXl4hT1JgNkmfr6vopUOfcejBvk7H1GO3/d7H3F+9pqiqBMfYXT45CGrTZthACEpmvu6Wu6p/A0y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ri0eHOaQWyOHd/WjFpNSJAPG+sUZzod+fKopVmojXB5MbM+H
	6F4e9LcDOjLX5VvpWoYo0XH8oBo196j/Z+d3TC5Zb+o1ONcD+QlPju68
X-Gm-Gg: AeBDieuVHPIckeemnlhJlR+40uRC/xeZbw5+UsMI//cgbmzAkOJkqtrIKkXj63nBgRE
	4EMo5/1odGGqu072Q3eyFsv5hiYasRsLnq4jiC+BLdS1YP9EBnn+Hi1JVS6ICYa5/zcmdHVpWkb
	VlWUWI6cuACMXiQU4VqaFmRM2I6hFqzHN48pUai352Fr5C8ZDLWx6su0Lnw93zIupCGf6YQh7fl
	rT4+C3Wtsiokqml6x05wPCsHvyGzRY5xXnRZo0f0pHKGk5EtPd5oKdx7NNpf++RCPLcBtre6gA9
	22D0NsYweeob03o8OGQSZqC8i8xi+Nd41iS4wbCL2fGBe/Ws19mi6fmHHocmwFRebzqsA00LhW7
	ANN9x8A2QgBZv5TBrRLUGJfg2zSewbycAKWIFKHXG0R+rq/FNYTFC7uBrQ8k/Ccu9WEkXTjrA3e
	nOp8U/b1TrUDSRvkXPI9L/D6CxLW8=
X-Received: by 2002:a17:903:3c6c:b0:2b2:527d:fd with SMTP id d9443c01a7336-2b9a2885feemr21009675ad.8.1777569659787;
        Thu, 30 Apr 2026 10:20:59 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e7besm2043795ad.12.2026.04.30.10.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:20:59 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 0/3] ntfs: error/durability fixes for mft writepage paths
Date: Fri,  1 May 2026 02:20:52 +0900
Message-ID: <cover.1777568957.git.charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three independent issues in the ntfs mft writepage
paths in linux-next.

Patch 1 restores the documented synchronous semantics of the @sync
path of write_mft_record_nolock() and of ntfs_sync_mft_mirror().
Both functions claim to wait for I/O completion, but in the converted
bio code they only call submit_bio() and return; bi_status is never
inspected.  As a result write_inode() can report success while dirty
bytes are still in flight and bio errors are silently dropped.
Introduced by commit 115380f9a2f9 ("ntfs: update mft operations").

Patch 2 fixes ntfs_write_mft_block().  When the per-call allocations
for @locked_nis or @ref_inos fail, the function returns -ENOMEM with
the folio still locked, which stalls any later task that needs the
folio's lock and drops the dirty state from the writeback iterator's
point of view.  Use folio_redirty_for_writepage() and folio_unlock()
before returning.  Introduced when those buffers were moved off the
stack by commit f462fdf3d6a4 ("ntfs: reduce stack usage in
ntfs_write_mft_block()").

Patch 3 captures the return value of ntfs_sync_mft_mirror() inside
ntfs_write_mft_block() so a $MFTMirr write failure during writepages
is propagated and surfaces via NVolErrors.  Patch 3 is what makes
ntfs_sync_mft_mirror()'s newly-meaningful return value (from patch 1)
visible on this code path.  Also introduced by commit
115380f9a2f9 ("ntfs: update mft operations").

Note: this series does not yet wait for the main $MFT bios submitted
inside ntfs_write_mft_block() to complete, nor does it propagate
their bi_status, nor does it redirty folios when records are skipped
by ntfs_may_write_mft_record().  Those issues require a per-folio
writeback completion context and are the subject of a follow-up
patch I am preparing separately.

The patches apply on top of linkinjeon/ntfs-next.  Build-tested on
x86_64 with CONFIG_NTFS_FS=m and pass scripts/checkpatch.pl with no
warnings.

Runtime testing was done in QEMU with a small initramfs, ntfs.ko and
dm-flakey.  The test kernel used CONFIG_NTFS_FS=m, CONFIG_FAILSLAB=y,
CONFIG_FAULT_INJECTION=y, and
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y.  KVM was not available in
the test environment, so these runs used TCG acceleration.

On the unpatched baseline (the commit immediately before this series,
9e9354075d5a), the QEMU tests reproduced the fixed failures:

  - With dm-flakey erroring writes during a metadata fsync,
    utime_fsync returned success:

      QEMU-NTFS-ORIG: TEST patch1-original: BUG reproduced
      fsync returned success under write I/O failure

  - With failslab injected from the ntfs_mft_writepages() stack,
    sync stayed blocked after the injected allocation failure and the
    guest later emitted hung-task diagnostics:

      QEMU-NTFS-ORIG: TEST patch2-original: BUG reproduced
      sync still blocked after injected allocation failure

With this series applied, the same QEMU test setup completed:

  - The metadata fsync path returned EIO under dm-flakey write errors:

      QEMU-NTFS-BATCH1: TEST patch1: PASS fsync failed as expected rc=1

  - failslab injection from ntfs_mft_writepages() was observed and sync
    completed without hanging:

      QEMU-NTFS-BATCH1: TEST patch2: observed injected
      ntfs_mft_writepages allocation failure
      QEMU-NTFS-BATCH1: TEST patch2: PASS no hang after
      injected allocation failure rc=0

  - The writepages path observed and propagated an $MFTMirr write
    failure:

      QEMU-NTFS-BATCH1: TEST patch3: observed MFT mirror sync failure
      QEMU-NTFS-BATCH1: TEST patch3: PASS syncfs failed as expected rc=1

  - Final result:

      QEMU-NTFS-BATCH1: PASS all qemu ntfs batch1 checks completed

The whole-device dm-flakey run is not a clean negative control for
patch 3 alone because syncfs can also see main $MFT writeback errors in
the unpatched tree.  It nevertheless covers the patched $MFTMirr error
path and verifies that the error is propagated.

DaeMyung Kang (3):
  ntfs: wait for sync mft writes to complete
  ntfs: redirty folio when ntfs_write_mft_block() runs out of memory
  ntfs: capture mft mirror sync errors in ntfs_write_mft_block()

 fs/ntfs/mft.c | 76 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 25 deletions(-)

-- 
2.43.0

