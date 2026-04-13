Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1238947E
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776061542; cv=none; b=SvZDPUQ9+/Rb1I53PHkqSZ/DvVLAQVPmccHLq4RF/6MCV12srbANz1rRIH9NcW9a2NYA622qzDnOz8kRhbEqoRoQGTHvE0B+uKJK6icKnRkF0PjDYDvxZd+te7VfFGL/SmNXy+AYeG/f5UPzP399AP0o9rTMKmjPQ7WhNDd5UEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776061542; c=relaxed/simple;
	bh=aJt4VQAGHE/DGXXmuCohzjPL5TZ8JVdErns35A0/b04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTtOq70eEMg5YPMDIL5iT4MJ5epaXhNOAc3N4+1b5zy4rB9LExPmm4RA6TVIlJCCkDhkEvi2TFfMT+a3UlxqY+Wa7B93aF1LkhPCUmzXpkMNoUdWBSZr/Eeik57TKdAAIlGb+uVIwEVVMF5Ys6vKK4I53o62qJs3klGiAmlzSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5klmUEI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5klmUEI"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f22f6b0feso606418b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2026 23:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776061541; x=1776666341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSBOAhViOuwEID8TtZg66KhyEdupsaPAGXgm7OuInv0=;
        b=g5klmUEI5bgU9/qtZXpXuq+w5X4vF5p7pAPT91vNHdqeSu4kqK91TkTlbbQHREvxUy
         V136FGFBpLsPmR0lasxUQv+j0tkfqpUwPMkmJJp2XRBmLZYQCLXMScYGgclerEdSj5Ux
         9oafBXIeS2z2iLG6aY/UsmCf1IvfdxrOouJcZkQC2Q8m5Y0lZWB8YOcx8P3V+sh9tkEW
         FpUZStstZsUbCdU2TsXWWAx/yJyWwLxkRUuEokGu91K9vEbh7VzTthOkqvwKQbSIlTkJ
         u6suzLQ+A2Vtt5pdFl0aaHd5gQ1icjjuRsu0YSvX9Q7/dDHH6SRRJx+CUcXQJwRD//0t
         6zGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776061541; x=1776666341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YSBOAhViOuwEID8TtZg66KhyEdupsaPAGXgm7OuInv0=;
        b=mBbFHk9OXmQi/AXJN6wJMZMQb128CsXGGHMNNkbsIJ2X9xzc5qzoed2uOoBjt9uTLW
         /MjljbmXL07P7Ws0wI4+6vi08YmcffPnWe9uvz1F80cFte5APwKe1/xPq4d+2eQCbg+E
         ngRxbPqvDoFF0d1Z0EJywqtY2sTr/gFgCVZIGQCzekMi58pljVfMuuXclJf5+I6F2Dw4
         aFAQLT/yRN7v9ezbmechVKbIBNaPizzPNlZY+ncT0CvCrub/YemDTdrCyKw61KcGWx/u
         nGmvz/cJNsBZziw/XX+yIAmDsEsqNEIvLohReAmChiSCbYbmjKJy1I2LWWEONuwrT7Hg
         5elw==
X-Forwarded-Encrypted: i=1; AFNElJ9FBPHoVzRcie6QVhCU0J30qD3HETwTQTt6U3LWOdv/pglPENSdLTGyiaQYjqGgpEiEzF+Jcr64zEk2bkBT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+G10c7GFXXc4Yw5cSIxP36FZuQQE2izZrqceSG6elagTPXQM+
	W+TOrcwXoa1TXmpJTuqsLgLYpi6NdFUjUnMIdFaKnE1ljV7MsQaaZU6l
X-Gm-Gg: AeBDiethv3RatVDaE7hPvntpFAPeN35C0TtcQRq46bUd16uxPx1soINcRJ5EdffTPT7
	xjYvPik3qk2qIWy6IVwHoBoPaBMLd+B/ANCisJym5EerH61SRys982bPW3gDZnrDOqVhvH7ZNJK
	EMoCxcz8EX5s2Z3nwkTWgaQtAwSJtAwvBaP4hyob+R4ictayszxA27P9OzW7R4/2v5AqPNDnrJ1
	w2O2R8iT+7muyzvj5eRa1/P5HTsioQ4URX6Iw7xKtY8+mTrrtKK/Lw1UBuTgS1Y97A+3C3yRkUc
	TN9PuKH+I93CQmzKZY1DiABCcU6emuNgQ9IU2viOprgBXu9nVALJG2hIPjYAath5tnEWSBvwXyn
	1d1mF33IEhd2xIn/N/w8Z0fKZ+1s5SMtDe/hxQjVmPMbk1+JTwUcSFHKufjJhlQfwsStiCQ9lZy
	RJ1hAnbqE51ukVEFHsjWcKTXnt3y9TQc9I5KzV
X-Received: by 2002:a05:6a00:2388:b0:82c:66f2:1226 with SMTP id d2e1a72fcca58-82f0c25258fmr12342783b3a.38.1776061540812;
        Sun, 12 Apr 2026 23:25:40 -0700 (PDT)
Received: from n37-098-250.byted.org ([115.190.40.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c20aed6sm10035640b3a.0.2026.04.12.23.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:25:40 -0700 (PDT)
From: Diangang Li <diangangli@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	changfengnan@bytedance.com,
	yizhang089@gmail.com,
	willy@infradead.org,
	Diangang Li <lidiangang@bytedance.com>
Subject: [RFC v2 0/1] ext4: fail fast on repeated buffer_head reads after IO failure
Date: Mon, 13 Apr 2026 14:24:59 +0800
Message-Id: <20260413062500.1380307-1-diangangli@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260325093349.630193-1-diangangli@gmail.com>
References: <20260325093349.630193-1-diangangli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diangang Li <lidiangang@bytedance.com>

A production system reported hung tasks blocked for 300s+ in ext4 buffer_head
paths. Hung task reports were accompanied by disk IO errors, but profiling
showed that most individual reads completed (or failed) within 10s, with
the worst case around 60s.

At the same time, we observed a high repeat rate to the same disk LBAs.
The repeated reads frequently showed seconds-level latency and ended with
IO errors, e.g.:

  [Tue Mar 24 14:16:24 2026] blk_update_request: I/O error, dev sdi,
      sector 10704150288 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
  [Tue Mar 24 14:16:25 2026] blk_update_request: I/O error, dev sdi,
      sector 10704488160 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
  [Tue Mar 24 14:16:26 2026] blk_update_request: I/O error, dev sdi,
      sector 10704382912 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0

We also sampled repeated-LBA latency histograms on /dev/sdi and saw that
the same error-prone LBAs were re-submitted many times with ~1-4s latency:

  LBA 10704488160 (count=22): 1-2s: 20, 2-4s: 2
  LBA 10704382912 (count=21): 1-2s: 20, 2-4s: 1
  LBA 10704150288 (count=21): 1-2s: 19, 2-4s: 2

Root cause
==========

ext4 buffer_head reads serialize IO via BH_Lock. When one read fails, the
buffer remains !Uptodate. With multiple threads concurrently accessing
the same buffer_head, each waiter wakes up after the previous owner drops
BH_Lock, then submits the same read again and waits again. This makes the
latency grow linearly with the number of contending threads, leading to
300s+ hung tasks.

The failing IOs are repeatedly issued to the same LBA. The observed 1s+
per-IO latency is likely from device-side retry/error recovery. On SCSI the
driver typically retries reads several times (e.g. 5 retries in our
environment), so a single filesystem submission can easily accumulate 5s+
delay before failing. When multiple threads then re-submit the same failing
read and serialize on BH_Lock, the delay is amplified into 300s+ hung tasks.

Similar behavior exists for other devices (e.g. NVMe with multiple internal
retries).

Example hung stacks:

  INFO: task toutiao.infra.t:3760933 blocked for more than 327 seconds.
  Call Trace:
   __schedule
   io_schedule
   __wait_on_bit_lock
   bh_uptodate_or_lock
   __read_extent_tree_block
   ext4_find_extent
   ext4_ext_map_blocks
   ext4_map_blocks
   ext4_getblk
   ext4_bread
   __ext4_read_dirblock
   dx_probe
   ext4_htree_fill_tree
   ext4_readdir
   iterate_dir
   ksys_getdents64

  INFO: task toutiao.infra.t:2724456 blocked for more than 327 seconds.
  Call Trace:
   __schedule
   io_schedule
   __wait_on_bit_lock
   ext4_read_bh_lock
   ext4_bread
   __ext4_read_dirblock
   htree_dirblock_to_tree
   ext4_htree_fill_tree
   ext4_readdir
   iterate_dir
   ksys_getdents64

Approach
========

Record read failures on buffer_head (BH_Read_EIO + b_err_timestamp). When a
retry window is configured (sysfs: err_retry_sec), ext4 will skip submitting
another read for the buffer_head that already failed within the window and
return/unlock immediately. Clear the state on successful completion so the
buffer can recover if the error is transient.

err_retry_sec defaults to 0, which keeps the current behavior: after a read
error, callers may keep retrying the same read. Set it to a non-zero value
to throttle repeated reads within the window.

Patch summary
=============

  1) Add BH_Read_EIO, b_err_timestamp and a small helper for tracking read
     failures on buffer_head.
  2) Update end_buffer_read_sync() and end_buffer_write_sync() (success path)
     to maintain that state.
  3) Add ext4 sysfs knob err_retry_sec and throttle ext4 buffer_head reads
     within the configured window.
  4) Pass sb into ext4_read_bh_nowait(), ext4_read_bh() and ext4_read_bh_lock()
     so __ext4_read_bh() can apply the per-sb retry window check.

Diangang Li (1):
  ext4: fail fast on repeated buffer_head reads after IO failure

 fs/buffer.c                 |  2 ++
 fs/ext4/balloc.c            |  2 +-
 fs/ext4/ext4.h              | 13 ++++++----
 fs/ext4/extents.c           |  2 +-
 fs/ext4/ialloc.c            |  3 ++-
 fs/ext4/indirect.c          |  2 +-
 fs/ext4/inode.c             | 10 ++++----
 fs/ext4/mmp.c               |  2 +-
 fs/ext4/move_extent.c       |  2 +-
 fs/ext4/resize.c            |  2 +-
 fs/ext4/super.c             | 51 +++++++++++++++++++++++++++----------
 fs/ext4/sysfs.c             |  2 ++
 include/linux/buffer_head.h | 16 ++++++++++++
 13 files changed, 79 insertions(+), 30 deletions(-)

-- 
2.39.5

