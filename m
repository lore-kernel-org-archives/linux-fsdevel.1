Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617B48A2A9
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461255; cv=none; b=rffxnrBZ6br69cNpXWFpwA3XWwKllH0vrZFZiOXXjL3bqwKiCLJfdL+t1AHbjBMxU+AcdNwpFgPWic8cHJFjcTJI7ywikulSGmh/XTx0EPIOUEY34s+R+ua+GLd3BkR2mc9U54q6clOuGohT9gWitRDfu6Fm1jKuIFKc9KGxlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461255; c=relaxed/simple;
	bh=mMnIRUx9uBCAogbRbbeRXnqqhUuA70DoXdIBREBFHxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lsusStEvDfpjt4QIBTmiT5bo5klPy27KBMxnA8QKcA+XQKHgFHbHD3xIXGFWNHUCCiOdPU7PuyaDFvPpDXcj8Jw21WgjpjW0+QInnrgJpW3ICmQjpcTpDeaurJpkYEi/sz+hRohkwY7fpzmBcdA0hipU61haEjB4FmJVu6XGbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ip5cVX3N; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ip5cVX3N"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334e72so29155565ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789461252; x=1790066052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vwYuAUVTEM1KZY8XIMf3dOzuS7TDv0+6YLYzPNZ/wUM=;
        b=Ip5cVX3N28zPJTWC1Di5w4pkmN0nB5Gto/nBoZ2F5TmhCc3X+QjzbTSx1zVfj1LJa2
         EPDo7sU4SEy0m+Im2nnuMMev124T0D9fBxDAr9btY33qT5929l7HyQS+vOQKRDWOPCos
         PTzr+ziGt4U2maKgE12QLzqZNMDltAeRyOJKlzdB+rikOhfPd0LG89pX5pszsEI1o7WC
         TeP5x79aCxbPMJnln+newI2IAblnQctppRquuroYzzEVnn1RtVvS5IEQw52AvlD6Nzje
         pOXKrzIAWGkrO7OZmM+O+RUX3bNa+4qdVLy97SmJn1r4OmnUCDH/eXUkI4bbAXwIQVxQ
         T2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461252; x=1790066052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwYuAUVTEM1KZY8XIMf3dOzuS7TDv0+6YLYzPNZ/wUM=;
        b=zwevoKgkuTQ/ZeQN2T3/+LmNgCoP9r0vxQGUY52c7NPdXMZofU/9vLbF+X+hS2XdKG
         TCMbzP/bI8mAnFoIdEgZIwL3YjdfH7Ag+tqjYVNlaVqKoJ/VmvvLRVG49BOwNR9FQWVI
         l5h2j3Vqgv4MfJzuN98tJRf7fjEl22rm8lsdNWxgdNOq2IhBbyNDSHUCGWhwVyKCimzP
         BwoKhTdOphZJB/VG308AemfXpILAYQYyfq5BkyQKLvVMJV15R3/LUaqjpZdEmyvlY2Av
         ucdPlWYbddqc7RaNWkaVvpN5TVhod7uzDgEMmayZZzbpoqKrkD72JqOOXjHPKZx/3fcP
         ykMA==
X-Forwarded-Encrypted: i=1; AKwUvBxFTqNz/8XYxUfTUHL1zXeblxqPDhwMGi9VBlnJi5DeDQ5gtaK5DUfaUd+041qOUbAQiOCGMxJFs8dcbVdS@vger.kernel.org
X-Gm-Message-State: AFuF++ngiErJ6YWCWA5U/1LSrTncTdM4zb/QqUYiZ3AdqLMeDwMJsOVJ
	0ch8iyXmetN8+9UhPIxvbga8qL7OS6rLm0wjm8pf3fVkf7ffFFliBzS2CQnobqz193U=
X-Gm-Gg: AYBFou2PINrgDfzxER1HMSqGT9b2ocs4s2FjaBkwo2tCD0vJADLXeDgl/B1saZ64nAI
	edGmndj9WZl/JJzEIrLbZADWomVG0BfwuywX46Q9PciKbUozbNwttMtmIyjtWZ0Q6RcdID4XM3l
	PQPXeLYkt9gm/q7NoLoB9d0wGJ/tlYMOFETu4X/6t9TQ/w5DeubmPA7D+v5EP+Tfr+1nUroW5cx
	srfBgth65QTJYebkuEUpOZtyltz4Up+JukV5TQ5X2+tHSbs3oD56Wb+a8ht7H/1AH43oQm/Vm3J
	xPw5AFM6KhGKztPdxUQyau2Vxw7acYcitD3ir9JAyJ2aAVG1kc2kBSWXHTROp4nZ7/f0RU6azNs
	2fi8umNMOwcyRNi7vu8rvg7JjjV9RJkz5Zq0l8fu/LfDX7pJCWFdCfIRfH5O+vHs2GOKKSBzH9V
	siHYlmrE65quKbf3gq0DUIjdMGEI7CiAPNs3QcAPAUhRUiDpIJTMdZz3LjXTwgB/qhBslxZVhF
X-Received: by 2002:a17:902:fc4c:b0:2d9:123c:8c49 with SMTP id d9443c01a7336-2dd6c6db8b7mr146833195ad.14.1789461251905;
        Tue, 15 Sep 2026 01:34:11 -0700 (PDT)
Received: from localhost ([106.38.226.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca268csm62498695ad.1.2026.09.15.01.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:34:11 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v5 0/3] memcg,writeback: flush foreign bdev mappings separately
Date: Tue, 15 Sep 2026 16:34:03 +0800
Message-Id: <20260915083406.3471036-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series avoids owner-wide foreign writeback triggered by dirtying
shared bdev inodes. Instead, it tracks bdev targets separately and
schedules writeback of their mappings.

Problem
=======

Bdev inodes are commonly shared by many memcgs. Dirtying their pages
can cause the owner wb to be tracked as foreign, triggering writeback
of the entire wb rather than just the bdev mapping.

In production, almost all the foreign dirtying we traced came from bdev
inodes. Across our observations, a bdev mapping had as little as about
10 MiB of dirty pages, yet foreign flushes targeted the entire owner
wb. On one machine, we observed 599 such works queued on one wb, with
an average request budget of about 43 GiB per work.

Measured impact
===============

The synthetic test used a VM with 4 vCPUs, 8 GiB RAM, ext4 and cgroup
v2, with device write bandwidth capped at 200 MiB/s. Background fio
repeatedly overwrote a 256 MiB file using buffered I/O, while
foreground fio performed sequential direct writes. Four memcgs
generated metadata and buffered writes to trigger foreign flushes.

We measured completed block writes to the background fio file,
including final sync, and foreground fio bandwidth, latency and
completion time.

Across three runs per kernel, mean background file write I/O decreased
by 72.7%, foreground bandwidth increased by 23.0%, and completion time
decreased by 18.8%.

Metric                         Baseline    Patched     Change
Background file write I/O (GiB)    6.154      1.680     -72.7%
Foreground bandwidth (MiB/s)      150.29     184.81     +23.0%
Foreground completion time (s)   109.203     88.652     -18.8%
Foreground mean latency (ms)      212.84     172.74     -18.8%

How it helps
============

Frequent writeback of the file overwritten by background fio reduces
the opportunity to coalesce buffered writes in the page cache.
Several overwrites of the same page can otherwise result in a single
write of its latest contents. Flushing between updates instead writes
the same page repeatedly, generating more device I/O for the same
application writes.

This additional I/O makes the device reach its performance limit
more easily and competes with foreground I/O for device bandwidth.

The benefit is expected to be most pronounced when these conditions
occur together on the same device:

1. Limited device bandwidth, as with an HDD, makes the additional
   writeback I/O more likely to saturate the device.
2. Multiple cgroups perform buffered overwrites. Frequent foreign
   writeback reduces write coalescing and increases device I/O.
3. Concurrent direct I/O bypasses the page cache and competes directly
   with writeback I/O for device bandwidth.

Approach
========

Following Jan's suggestion, this series records foreign bdev targets
separately and flushes their mappings instead of their owner wbs. This
preserves a way for dirty throttling to initiate bdev writeback while
avoiding owner-wide writeback triggered by these records. The existing
foreign-wb mechanism remains unchanged for other inodes.

Tracking is best effort: each memcg keeps a bounded set of device
numbers without persistent device or inode references. Closed devices
and devices with a busy open_mutex are skipped. Device removal and
device-number reuse may race with lookup.

Flushes run asynchronously on a dedicated workqueue to isolate these
frequently triggered tasks from existing workqueue users. If workqueue
allocation fails, the existing foreign-wb mechanism remains in use.

Thanks.

Julian Sun (3):
  block: introduce bdev_flush_by_dev()
  memcg,writeback: flush foreign bdev mappings separately from owner wbs
  writeback: record bdev targets in foreign writeback tracepoints

 block/bdev.c                     |  24 +++++++
 include/linux/blkdev.h           |   1 +
 include/linux/memcontrol.h       |  15 ++++
 include/trace/events/writeback.h |  22 +++---
 mm/memcontrol.c                  | 113 ++++++++++++++++++++++++++++---
 5 files changed, 157 insertions(+), 18 deletions(-)

-- 
2.39.5
