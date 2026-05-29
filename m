Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A322FFFA5
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024764; cv=none; b=USvd1UvD4iisJvkyOCfoS73hqsXBYdJnDwl9AKfDb+0KaTKUjUCm3fTe8JQ/YkUbnrt4mHyAx2A9DuECBkV6VUf6tufE0feK0CAa9SXZxRJtft9IR29ZMJ9tv4infEtVzLEBhuSrrMxOsiFZtMs7hAw6oyxsXnpEtXqw3nM1PeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024764; c=relaxed/simple;
	bh=/u4f4FgZyBWtjbRRaaWz9qfOmIy3D/4tMW3teTl0wq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tv5ZM9/OXgVhFkDS2PYFr6xfIcPbsDK9z2GD5xUf6Y9ugjyNufs933GvwVxKlJOVwozeVc4sBGIgE6tziAuY2wh+rUQrVtWvULxX9bfYN3svFDkA/QqujfVAvFmO792i3SjJlIymAQARbM0DpitSn6o8I7QpifRxHUxcFld+geo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsYFYcGD; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsYFYcGD"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479d593a0c3so11018912b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 20:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780024762; x=1780629562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9Phfc/ZC4dml+VHPh7TrqnGY9YxNLE5sIFguW0tl3Y=;
        b=qsYFYcGDy7qY9+MxYJcPSef8gXiUoFElHGSUYNTG11rrRK6JTCZq8f1mBX1SOl8gDd
         /YXwvq5//znuxUN5/yUHEAHX5XTk0Pfk9xgj46ODV29NYCfWGEdz2AP+2Of1INa8ptpK
         PQ5tbRUc+5aciyudWMsDabyQy4FBk5uoUu7zGeFsp/c/AbSCamVlO4J/+i4mRg20QzUW
         5mdZm0gdrFftG5/jdR0F8BVih1wuI3Nm9Z6RGB68UGQqO9pFmFA2KPmixz0nLLb87UKw
         4hY/YBjnEKlUADN7t1mpUlq2LmSyhs7FJLPsGYnhZz2nWxxp88EpTcdpljKm/hvWFxAi
         dATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024762; x=1780629562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9Phfc/ZC4dml+VHPh7TrqnGY9YxNLE5sIFguW0tl3Y=;
        b=HJVsAZx+j5sIU/mJMzeSpdrpEG7I+DfhSG9ZTr0UNdT+O3JxohpeW1S9eVSWI0vDDF
         JF0CFBOp69jo2K6u8lHKUY+3i61s3mv1hHLbNXj5/RgRfV7mLN/hUCfCx8pvEytK9lq2
         AyY/+0Iv4FMMm8Xcnp843Fy0+Oj+/0nQ1YxQf2tFjq2T6IkXgyKgadTNlAufvgZ/PGn0
         GEeCfaBU/ZSneWWX0sYi0OE0vpDNhQdPMAvf5cy2LgwKKYA1s98C0CVzxvMR0amA8ZGu
         aIfRsyyGjZ/fIKCEro+z7J8hMs/h5FBEDU1WBo8/qqmNonZ52QjYKPkfGkhoQkF5ksVM
         IdgA==
X-Gm-Message-State: AOJu0YyorfPZb13RXeGAnJpELVOeDkQfD7L0JlvubJCsN+AQtfZU0DJg
	sFp4Do1h/rr9Filuxp5REhrPN1LtqezXQ4k9+XmWcyqx2TP4sLIS44b7SX5Yd+wc
X-Gm-Gg: Acq92OHk1HA6X9tUKzj7lLx+/2xdzoywt3BUtXX5uxu3GRTe1WKn9A8pF7BSaWYctU1
	aw1Dvsr1JT/BhfufiK8Mper+0kxCvh0AjPnDaECG1bVmyHeVsv/z2pkaYxIEMX9O6u1HVul/1CB
	S5Di+UdQx4YWXTZbBf1ftE0R9zYneZP3r750MfeSZr8ZwEYVbef4fadf/mvwAw2+Q9vfut/AokM
	BBTCh9D2ddqagjBs1J1AWZmJi4e/c2l1QgcRm7B/iD6AQtzaXH26FNgvI3m6caCsLvK36BRWcYs
	462YeDUah0fxl86B3Em6INUmBd4HpdCpHyUbnsoNT9yE/vDC/QuoFFFi6Gx6EDH8IS5+gGj/me4
	Y3HA/+zfgH2RewuFnCmcRye6iorwv3+MZ9D6fy6vtfFf+7TvHBYWX+ZcRu2YyGRA0l6GmB6n8wj
	6qCReNJ1ghAI+MD/J8lfvddlwkaZ4/jP09eqr9czNrz2aU4ZXQHIu/6jK/ZC3rMIucJHodABrAi
	5vUtJsw8vq9m1Sv+ofmAp2hi6TVZy7IE2L379VUcQALWeBJkgMKBqkCEUleS23sDA==
X-Received: by 2002:a05:6808:1b26:b0:485:43af:5de0 with SMTP id 5614622812f47-485e73626eemr656910b6e.22.1780024761918;
        Thu, 28 May 2026 20:19:21 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695bb393bsm556788a34.7.2026.05.28.20.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:19:21 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu,
	linux-kernel@vger.kernel.org,
	Russ Fellows <russ.fellows@gmail.com>
Subject: [PATCH 0/2] fuse: fix and optimize parallel writes on passthrough mounts
Date: Fri, 29 May 2026 03:19:14 +0000
Message-ID: <20260529031918.7361-1-russ.fellows@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches fix a bug that causes FOPEN_PARALLEL_DIRECT_WRITES to have
no effect on FUSE passthrough mounts, preventing write IOPS from scaling with
concurrency.

The bug has two sides that must be fixed together (patch 1/2):

  (a) fuse_passthrough_write_iter() calls inode_lock() directly, bypassing
      the fuse_dio_lock() function that checks FOPEN_PARALLEL_DIRECT_WRITES.

  (b) fuse_file_io_open() strips FOPEN_PARALLEL_DIRECT_WRITES from any open
      that lacks FOPEN_DIRECT_IO, including passthrough opens where the flag
      is redundant and should not be required.

Either bug alone is sufficient to serialize all writers.  Together they ensure
the flag can never take effect on a passthrough-backed file.

Patch 2/2 is an independent performance follow-on: once parallel writes are
unblocked, the per-inode spinlock (fi->lock) becomes the next measurable cost.
This patch converts iocachectr to atomic_t and adds lockless fast paths to
fuse_inode_uncached_io_start/end and fuse_write_update_attr.

Tested with fio randwrite 4K direct, numjobs=1/2/4/8, iodepth=64, on a FUSE
passthrough mount backed by XFS on a RAM-backed null_blk device (kernel 6.17.13,
AMD EPYC 9B45, 16 threads):

  numjobs | Before (IOPS) | After patch 1 | After patch 2
  --------|---------------|---------------|---------------
        1 |        ~470K  |        ~470K  |        ~470K
        2 |        ~650K  |        ~930K  |        ~930K
        4 |        ~640K  |      ~1,530K  |      ~1,530K
        8 |        ~635K  |      ~1,707K  |      ~1,707K

Raw XFS throughput on the same device at numjobs=8: ~1,702K IOPS.

Russ Fellows (2):
  fuse: fix FOPEN_PARALLEL_DIRECT_WRITES being ignored for passthrough writes
  fuse: reduce fi->lock contention on parallel direct I/O

 fs/fuse/file.c        |  49 ++++++++++++++++++++++-----
 fs/fuse/fuse_i.h      |  11 +++++-
 fs/fuse/inode.c       |   2 +-
 fs/fuse/iomode.c      |  61 +++++++++++++++++++++++++++------
 fs/fuse/passthrough.c |   6 ++--
 5 files changed, 104 insertions(+), 25 deletions(-)

-- 
2.51.0
