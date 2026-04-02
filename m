Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AB3346A8
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147390; cv=none; b=Q+iwVjh7h1zwuHqSOPmJ5qXhKIqd+fdfN61Qh1zFVGZVDZsUrWTcsx5lRF6nJ1QRKAsLbYkg6/91kgAVdfzrFbXlXE4jxRVaDuUZUmYez0gvTp/6/tGYhXSCNvHc951oDwe6fo4jPNcQOJX1Yhk73L0GNM+yPDPBblSuWZA6O8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147390; c=relaxed/simple;
	bh=cQPPqbLS7/BvTDhlA3upFoNt/pZHAgatL7GrY+xsgNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lg7ekcsSvqXt6lVILLd2Hnj1JXXYVvuMxV9EMr6WTzi8KSZC3t99q/M9PbN122rB/ig+EEB0S55IBtbv4y+Ahu4gVTqKQZSFb6ZE80Dht8/Az4AmWNYUpuXeU8e9FMhaW1IbH2NqV5X6J7FaKFsz7IWXcJSNUKppx7Pbv784SqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMvywSlx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMvywSlx"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so931371a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147389; x=1775752189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DP706g7bborjcczloSD7fj6sNou9Unhxbf5dHkzzA/8=;
        b=KMvywSlxeWNkYf+zMnVdXldWHyM4UeCARZ4sgiFCvotddUXpA3Ki80KGd4VNg5QDlB
         ghVYxLfyXgqPw6AhDq0jR3FKxWpqgDZc0ImRzDI8ODnITraOutArjiCywMq0uaTi9IJ5
         nco/hNEoitum5QX2H2eXlzxjRYnrEJ89bcQUDaEYPOLJ+URsLBFnoCT1KFEXNORUMRU9
         YRdyCvtSDEi39F7y9Jeo+J9pyRFxIuzYyiWJ1SgW+TGc1iaqrO/V2qEtC7RM4Lom9Mh4
         9KxvbdhyW5BwoayLtY+2MyQu7fVanb83/IaYteZPvSrpNEeazElKVFDZ9ttCbtvm8HLr
         hN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147389; x=1775752189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP706g7bborjcczloSD7fj6sNou9Unhxbf5dHkzzA/8=;
        b=QlnIqidROvF3VWAVC35p4SBReC2C9mSmltRXtPBIrS3kbs/UC/el0cvRX0dtuGfi7h
         i7Lxy2OZvUvpwAYNI4eqh2NbW0EsxtFe2ej7DpDh/M86+uZE75NZFDM4nCM3gR1iUShT
         VzSeId1RAWVw264/F7d2t7CcfrWCiGG+k82EmlQy59NDV5H9xjQrdkeK8IvmaClu9yuo
         klWeh679gzNybCJ06W/N1UbOv7aCwxiKim2LtVqYaInUnF+RpjT9OaN5R0qEmRDKT8NO
         5c7vsicBuO2g4QRfPJwU7bFxng8M2Np28YvmSC2RG17E+wOc/i4d7lMBBJdMoKuM61O+
         jejg==
X-Forwarded-Encrypted: i=1; AJvYcCVqO0tbpk34l/hLUgMyGygYHlkhbbPwvaNRM5ocqtQkAa657l3Spts9BTMHf0MF2BglR34gNLHbDYEEGOad@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3+CXDQWN1P3DRk7VoY/FtuOSR/E+z3hDj1q7Jr3BySokqKP/
	JoRfp0x0MAzlqEOkQ4a9uCe1FfrRsZyXGQjGyys+pBg+Eu55zhUh/Vl/
X-Gm-Gg: AeBDieszeg6FXSPRq997PUmeLXX5EfQhxliVKArHugJWvZj5N7l5yyocUt3vAMDe/Bn
	e2WfCIWSYH5N7XFt1MmQolYtaDYcusMW/JQ9fk/sDIsYSx9qCd+3RppVZ1nFJlgbvTm3Ogsz6lu
	1p1yBuOUKJBjNAWa0UY7v7GYzhdQlAW1zubvxJXlPXw+RKd92q8rkGG2CZvZbL1G4tkk6/83GtW
	scnO9gWsTbVk4yLEXIl/sPxzWfd8AqymIRTlJ/xSJcRSMOTJcYz79r2zYy4hqI7DPxwJzyMzHId
	nrju3qeG8xp6qRVxXac/+zT7TNlO7EMzZVzpsC8YEYADTkByWg3pDrE6jqefOxdYqXQame4gk9T
	4rYD4hgX4YaixSxJ0WR1dg96UEIW0h1u2Nijk3E/6O2MdlXJ8Rnn88hACqcC4PY5lGhzTM4Fc5O
	wo1DGgUO6C+y1RC0ueww==
X-Received: by 2002:a17:90b:37cf:b0:35c:936:d4cc with SMTP id 98e67ed59e1d1-35dc6f5fe64mr7458193a91.14.1775147388892;
        Thu, 02 Apr 2026 09:29:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd367bfb1sm3351805a91.10.2026.04.02.09.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:29:48 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/14] fuse: add io-uring buffer rings and zero-copy
Date: Thu,  2 Apr 2026 09:28:26 -0700
Message-ID: <20260402162840.2989717-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds buffer ring and zero-copy capabilities to fuse over io-uring.

Using buffer rings has advantages over the non-buffer-ring (iovec) path:
- Reduced memory usage: in the iovec path, each entry has its own
  dedicated payload buffer, requiring N buffers for N entries where each
  buffer must be large enough to accommodate the maximum possible
  payload size. With buffer rings, payload buffers are pooled and
  selected on demand. Entries only hold a buffer while actively
  processing a request with payload data. When incremental buffer
  consumption is added, this will allow non-overlapping regions of a
  single buffer to be used simultaneously across multiple requests,
  further reducing memory requirements.
- Foundation for pinned buffers: the buffer ring headers and payloads
  are now each passed in as a contiguous memory allocation, which allows
  fuse to easily pin and vmap the entire region in one operation during
  queue setup. This will eliminate the per-request overhead of having to
  pin/unpin user pages and translate virtual addresses and is a
  prerequisite for future optimizations like performing data copies
  outside of the server's task context.

This series adds the capability to pin the underlying header and payload
buffers by setting init flags at registration time, depending on the user's
mlock limit.

Zero-copy (only for privileged servers) is also opt-in by setting an init flag
at registration time. Zero-copy eliminates the memory copies between kernel and
userspace for read/write/payload-heavy operations by allowing the server to
directly operate on the client's underlying pages.

This series has a dependency on io-uring registered bvec buffers changes
in [1].

The throughput improvements from pinned buffers and zero-copy depends on how
much of the server's per-request latency is spent on data copying vs backing
I/O. When backing I/O dominates, the saved memcpy is a negligible fraction of
overall latency. Please also note that for the server to read/write
into the zero-copied pages, the read/write must go through io-uring
as an IORING_OP_READ_FIXED / IORING_OP_WRITE_FIXED operation. If the
server's backing I/O is instantaneous (eg served from cache), the
overhead of the additional io_uring operation may negate the savings
from eliminating the memcpy.

In benchmarks using passthrough_hp on a high-performance NVMe-backed
system, pinned headers and pinned payload buffers showed around a 10%
throughput improvement for direct randreads (~2150 MiB/s to ~2400
MiB/s), a 4% improvement for direct sequential reads (~2510 MiB/s to
~2620 MiB/s), a 8% improvement for buffered randreads (~2100 MiB/s to
~2280 MiB/s), and a 6% improvement for buffered sequential reads (~2500
MiB/s to ~2670 MiB/s).

Zero-copy showed around a 35% throughput improvement for direct
randreads (~2150 MiB/s to ~2900 MiB/s), a 15% improvement for direct
sequential reads (~2510 MiB/s to ~2900 MiB/s), a 15% improvement for
buffered randreads (~2100 MiB/s to ~2470 MiB/s), and a 10% improvement
for buffered sequential reads (~2500 MiB/s to ~2750 MiB/s). I didn't see
enough of a clear improvement for writes due to write latency being I/O
dominated.

The benchmarks were run using:
  fio --name=test_run --ioengine=sync --rw=rand{read,write} --bs=1M
  --size=1G --numjobs=2 --ramp_time=30 --group_reporting=1

To run the benchmark, please also add this patch [2].

The libfuse changes can be found in [3]. To test the server, run:
sudo ~/libfuse/build/example/passthrough_hp ~/src ~/mounts/tmp
--nopassthrough -o io_uring_zero_copy -o io_uring_q_depth=8
Once this series is merged, the libfuse changes will be tidied up and
submitted upstream.

Further optimizations for incremental buffer consumption, request
dispatching in current task context, and backing buffer integration with
IORING_OP_READ/IORING_OP_WRITE operations will be submitted as part of a
separate series.

Thanks,
Joanne 

[1] https://lore.kernel.org/io-uring/20260402160929.2749744-1-joannelkoong@gmail.com/T/#t
[2] https://lore.kernel.org/linux-fsdevel/20260326215127.3857682-2-joannelkoong@gmail.com/
[3] https://github.com/joannekoong/libfuse/commits/zero_copy_v2/

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20260324224532.3733468-1-joannelkoong@gmail.com/
v1 -> v2:
* Drop kernel managed buffers from io-uring infrastructure and instead move
  logic into fuse. To later use buffers with io-uring requests natively will
  require fuse to place the backing buffer as a fixed buffer in a sparse slot
  for the server, but that will be added as an optimization in a separate
  series. This makes the io-uring code cleaner and accomodates for more flexible
  fuse user configurations (eg mlock limits) and easier setup (me)
* Run more benchmarks and get more numbers (me)
* Add visual diagrams and more documentatoin to commit messages and
  documentation patch (Bernd)

Joanne Koong (14):
  fuse: separate next request fetching from sending logic
  fuse: refactor io-uring header copying to ring
  fuse: refactor io-uring header copying from ring
  fuse: use enum types for header copying
  fuse: refactor setting up copy state for payload copying
  fuse: support buffer copying for kernel addresses
  fuse: use named constants for io-uring iovec indices
  fuse: move fuse_uring_abort() from header to dev_uring.c
  fuse: rearrange io-uring iovec and ent allocation logic
  fuse: add io-uring buffer rings
  fuse: add pinned headers capability for io-uring buffer rings
  fuse: add pinned payload buffers capability for io-uring buffer rings
  fuse: add zero-copy over io-uring
  docs: fuse: add io-uring bufring and zero-copy documentation

 .../filesystems/fuse/fuse-io-uring.rst        |  189 +++
 fs/fuse/dev.c                                 |   30 +-
 fs/fuse/dev_uring.c                           | 1042 ++++++++++++++---
 fs/fuse/dev_uring_i.h                         |   86 +-
 fs/fuse/fuse_dev_i.h                          |    8 +-
 include/uapi/linux/fuse.h                     |   36 +-
 6 files changed, 1194 insertions(+), 197 deletions(-)


base-commit: 619fa72e875483dabf7683001496cc0ca4480aa6
-- 
2.52.0

