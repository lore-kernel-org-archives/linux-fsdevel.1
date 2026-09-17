Received: from mail-pz2-f31.google.com (mail-pz2-f31.google.com [74.125.228.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1043CE71
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628286; cv=none; b=bxFV3IxBuj8arGaQ9VT1tS9bMlkohNF4vxktoPMeNUKpyDOkq3+Cqwf3EgF5br+BFQwkbLtRV+sDvErftjfD0W8XnGSqbSBAJq5DYKxDNXuFLM2eK+yQ0d1Ge1UJEaXxkwS0ihYoH++Mqk4BMC/YOXLUYIop82RquYZzvWUsPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628286; c=relaxed/simple;
	bh=EdkFAZRsmiYJE6DaAOCziXE4wBB/YD3JhZLeLQWTIRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lNhmb/6Ia68bxAiqrZYn/r5AIDWaZb0nQ4/QrGzUuGS8CbXqhvXMv5h62IVXumUU2WwuNvWI0XSYXVTeRK4PwNmXygevLI2zKns7Vn9kq3k1tr+kgz1rGe4fx0MZsle3iWSMBYlz2Y3SJXUCU2kt1x1uURiMMNHb+GK4wXBwLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Qm7PRaJr; arc=none smtp.client-ip=74.125.228.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Qm7PRaJr"
Received: by mail-pz2-f31.google.com with SMTP id 41be03b00d2f7-cc1ceb47d55so73683a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 23:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789628284; x=1790233084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNKAWCInS3ncgYsrptjrEkqpgHAtyYq0bBCMZxfKpWo=;
        b=Qm7PRaJr9i+DQv4HPSSr/O26ByUThApgh+lS5YR67UEPRwGDhFKUGdpoftF9boGMOs
         7IQdBmrL0XMifDR4ZeXuYaoX0+0K4PmXWdjkZuwGROs8/LdPK+L6jTzry+l98SX1Ua2A
         e6mu+GqealqQu8TNhzamGA54fUtR9mEgcWEIcSnycJFNCYBi2CIvIzoKPnTYlCAbjOoT
         VdHt1AVR8oVLaZSbasqVzb7kCPQG2Ae5lvHzIUTPiMsjwzL6arpJUvQ746A7CZLGgjEP
         Bq6x4TUUfVZrN7W75Nqh3oQbsIp+zT1Y/7H5DWDQN8QofJxC5s38I92TSyDmI6IAMiiq
         mtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628284; x=1790233084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNKAWCInS3ncgYsrptjrEkqpgHAtyYq0bBCMZxfKpWo=;
        b=ywx0r4zB6DWQHbu8GgefRPwX/9aOkQ+Zl1rFngikMZItMMLF5j0CqeLmxoIXrzrWQ1
         uLVFHCtkXO0MgXn4oKbQTibKSjyVQmTmoOuiAjvGHZZ0XRZf20DXQ3si/SVWJ29zJvlm
         BECUzC67kQO7jVjfgosMgGZaMA0KuJzy+IOb/nmUfK/aQIBUgYXJ8g+Mi/y+W2f/GAT2
         2K8hLUTGOMzbxLjZC3N4cYsOt6s0MF7UdjEySTLKrzfqcXInDjNq4i820se0xFvzKPqI
         CNEMku0Iwtb7L1f8EYqBavsno/jWtrYFdfs9wsyYUak+uUQ2rQypWjYgmlZfLH8GmjGP
         QRTw==
X-Forwarded-Encrypted: i=1; AKwUvBzH7IGPuflHU6dDN7CYd2Gu88wDR4/WNFJAwPV1AaOAsgfFh2S0AfNpo/M1D7O+470QaxUcz2rxKR+N8ac1@vger.kernel.org
X-Gm-Message-State: AFuF++m7bidN53tBzVcLNXuqtQtK7uX5yXSncURy065xBX0VTG4x71/v
	cJBIf4KNtJFlbKiHRXsgXShIg28hSrWjy5hk8bym6w0PeQqfq2MYAQYkEKNBCXWM0Tk=
X-Gm-Gg: AYBFou1wV1XvBRT78C9NMLW6foIYM75I+yU7m8aNhtI4ACoc6MU5ZregvoCRWJ92tVd
	q/ooKYcO/MpZYAJew2czUh/5EPDeJKNwdM00MTQAtfG243a+KLHBLX61CUcazkkbXAf9940QkN1
	aj1Aax5CHJvniNf9EVkcgg1osGZt3qcIwQPTq02vaO0Q5w2aC6TaCcOXzQNu05yUkePRsO6q/EY
	exnazcCDpNj4hTeuzwDd7NAUelaB6VHcUJXk2U1RGE7HpxxodrqEm37yuUodZJLVUOozvTKddVo
	fT4M2aGGFmGsCFWesy0CF/hTm3k8oPI3jsdVobQjL0ej/devyQLkeISCT8kIXp5woxfyLuaiDsX
	9Lxq5hXt9sFo/l8JPwuNp5Psxt09L8qGqqxqhVkm/UgCNKpnbsSsmzOPpe5dBGvZFRXEbVKPH/g
	X1R/E7FI3A7f9tp6q/I2KfXv8ytGHwSwICn9+KSBGgiG1UYnppN7vdIlOeAu8ThG+b3g/BpruM
X-Received: by 2002:a17:90b:1b06:b0:39e:429b:1e2c with SMTP id 98e67ed59e1d1-39e429b2135mr542709a91.15.1789628283519;
        Wed, 16 Sep 2026 23:58:03 -0700 (PDT)
Received: from localhost ([106.38.226.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35e4e0c6sm3888175a91.8.2026.09.16.23.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:58:02 -0700 (PDT)
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
Subject: [PATCH v6 0/3] memcg,writeback: flush foreign bdev mappings separately
Date: Thu, 17 Sep 2026 14:57:56 +0800
Message-Id: <20260917065759.2643940-1-sunjunchao@bytedance.com>
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

Changes since v5:
- Fix repeated overwriting of slot 0 in patch 2 and add comments.

Changes since v4:
- Add before-and-after performance comparisons to the cover letter.

Changes since v3:
- Flush foreign-dirtied bdev inode mappings separately, as suggested
  by Jan.

Thanks.

Julian Sun (3):
  block: introduce bdev_flush_by_dev()
  memcg,writeback: flush foreign bdev mappings separately from owner wbs
  writeback: record bdev targets in foreign writeback tracepoints

 block/bdev.c                     |  24 ++++++
 include/linux/blkdev.h           |   1 +
 include/linux/memcontrol.h       |  15 ++++
 include/trace/events/writeback.h |  22 ++++--
 mm/memcontrol.c                  | 124 ++++++++++++++++++++++++++++---
 5 files changed, 168 insertions(+), 18 deletions(-)

-- 
2.39.5
