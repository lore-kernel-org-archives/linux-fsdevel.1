Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C553822A5
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509721; cv=none; b=t65IP9maG4yLczVeTy6ZifwwippL3yPwJfzlbi6Bo5ySyE7DeViN1l9eO7sLwz6EuXcU4nUfUHztIauICc/blCxfSl2VURUa6GVmbtAbhyKkceBV2Mb9LRHXzybc73icH0Ota7PNcPd7PNWz08IeNRdWKFIVTGEHvGnnr0rCB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509721; c=relaxed/simple;
	bh=L6smztHc7Zu7OvGd8/tyj4fHgTUBsP8/eRiT/kR8iU0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AarzYZw6LXSAViZUMgCzhGLJpMaT+NbL/ObHpeviI2rYd/aZw/FA3/8oN7ewudt8xZga1eIxpp3SNaI+Q8Z1DL65XMkKRUqQUcaNNgtlM0NSaLTCGNMyMSHaqIEQcrpV2om16dgaUJewN144E9zFl9r1NfEgXUrvf/AQBuj+AK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EablGuLc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EablGuLc"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so9988245ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790509719; x=1791114519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6UgoZARQeqwbtbTZxY5jfWds9R7jptg+w98Z3sju2mM=;
        b=EablGuLcsiWRQKZRAvg4/DoDhNlhmXnejdX129mml8OR0Z56ddMM59KdemyoNhhkXz
         MHJHm36lBIl9lw2rQL/S6leez50E68QkuFulORC+FIiXAYxhOmluSEUuRswaq7MNXLfa
         5JHeE9ASPkR9UI8zo1nXEuPvXO5Sp0Zd6jmwLCgXzu1b4OpahMK0Gh6l+cc2EOimHzEy
         TVNEzBG62GPtAVBupOax4eEWCsqCY8Jnx3swpSf/F1YcxXGIEgHshpG9YJnd1c0bQm7W
         Gel4kUCFxhz+aZJMBfUn0DMqXMTDbSAG9tVPt9AvrlEF2YcVz2DZ+2l5htNzFQOFGtUu
         LrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509719; x=1791114519;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6UgoZARQeqwbtbTZxY5jfWds9R7jptg+w98Z3sju2mM=;
        b=G8D4leVyyPNhGcfikZeSkQIkh1KzxFBWPGcwH0g8ibSYUg1aBUUwgfnxcR7CuhEgrg
         +detxs5yNLeErhNcdcGzStBkeNdHC/ubSna4go0hfvgnc+vPuuwhvIuuXs2UDZUdFFyl
         cnhr5g2RdPAZZNsfwhI/Wsf7TRcVRFbwNgulQZX8vNV5GC/JUy+tfeJ3Xg1zipdxUT+Q
         kcTfhuvGd7WACd6fv07FgFzEJaBCV6qjOxAFbgdp+f8NY6zvghxR5UZDExy+7OnLuxgr
         dBbucoezDkZ8nC8aTnGDkw3LT3Zx+emM2ueqYbKumY6kQNjsvykRlZ+Ty1yqtSY71CSq
         ciXA==
X-Forwarded-Encrypted: i=1; AKwUvBx8VcXY8QD+wuyXPzjtthJpfAzry88Rlsho9QiKyHRoxqknxnSiTfKuQ8R9uVwuzlf+KokMehzy15ZICAJR@vger.kernel.org
X-Gm-Message-State: AFq9FYJn1sKvPLkAeq2WYTBnvjdWDUk6ORX1gre3ABxzK74W4j22mRmy
	VY3Bn8YUSpW6d5yWYWYqQdhKkcyiborX1POZDlJ0UdHP9o9+RLFh1LIkB9hqLZic5tjle9QRfoS
	zh1qz
X-Gm-Gg: AYBFou1ESkDSsyGiBgHzbAK8gyqt51GACWMQBDLSzGvl4hFWAqfZImOH7K2gvmXeP3w
	mp9iJq/tb4AqkKiMw26L8G+dtzBaVQDeGb5s4ZKPy7t4TKrCg9BYGw5uIhUqMlN78tqLqhWigPk
	eG5lTkl87g84y7pPQU6gs4mQXEVSatZXbOS0hA/QQw2QJuu1cKDKS6DmEnMaamLRLFdOZlU8r72
	AqmzmK+RzQvRtQFigYSpmhWmv0xeRSJskijF5rRx8fteBRKFRvdLmbE0ApsyGKo1bhUbFicUbSZ
	H9lgLxKvV0e7mctWQfQ34xp7tMbOjsitohgL8U1OYhDRzlI6NVYIwzjCwZYTebtn/IejNjVC58F
	fnjaYtw4fYIlYGjkaEDG5QDifQNLZcpJ/B2tfgMw+5O/VnDCRaqVdc1vbzb2c02JY95iY/e7yRt
	My3hlpvWIZmVjtMreT1tZ+tqBFDkzpmiLAlJqx7hQnlhakY1CxtTJhXvhol/kJAbnuhUo45b/Yc
	174U9ZcbXFolXPV/kPonRgTU98H8EfFL/Ota0amN8R/Pb7ljkaOvmS9b/xbwysBrScSULkYVQH5
	O9Vimw==
X-Received: by 2002:a17:903:144e:b0:2d7:1cbd:9ceb with SMTP id d9443c01a7336-2df7dfc2e54mr63334925ad.12.1790509718121;
        Sun, 27 Sep 2026 04:48:38 -0700 (PDT)
Received: from ?IPV6:2409:8a04:3024:f231:884:d8f1:aab5:6785? ([2409:8a04:3024:f231:884:d8f1:aab5:6785])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9146ed7csm28018285ad.80.2026.09.27.04.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 04:48:37 -0700 (PDT)
Message-ID: <b5da5c30-7c8b-4c60-aa3b-d2e3603e82c1@bytedance.com>
Date: Sun, 27 Sep 2026 19:48:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] memcg,writeback: flush foreign bdev mappings
 separately
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 willy@infradead.org, jack@suse.cz, tj@kernel.org, akpm@linux-foundation.org
References: <20260922125015.3435215-1-sunjunchao@bytedance.com>
In-Reply-To: <20260922125015.3435215-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 8:50 PM, Julian Sun wrote:

Hi,

Do you have any further thoughts on this series?
Should I rename bdev_flush_by_dev() to bdev_writeback_by_dev()
and send the next revision?

> Hi,
> 
> This series avoids owner-wide foreign writeback triggered by dirtying
> shared bdev inodes. Instead, it tracks bdev targets separately and
> schedules writeback of their mappings.
> 
> Problem
> =======
> 
> Bdev inodes are commonly shared by many memcgs. Dirtying their pages
> can cause the owner wb to be tracked as foreign, triggering writeback
> of the entire wb rather than just the bdev mapping.
> 
> In production, almost all the foreign dirtying we traced came from bdev
> inodes. Across our observations, a bdev mapping had as little as about
> 10 MiB of dirty pages, yet foreign flushes targeted the entire owner
> wb. On one machine, we observed 599 such works queued on one wb, with
> an average request budget of about 43 GiB per work.
> 
> Measured impact
> ===============
> 
> The synthetic test used a VM with 4 vCPUs, 8 GiB RAM, ext4 and cgroup
> v2, with device write bandwidth capped at 200 MiB/s. Background fio
> repeatedly overwrote a 256 MiB file using buffered I/O, while
> foreground fio performed sequential direct writes. Four memcgs
> generated metadata and buffered writes to trigger foreign flushes.
> 
> We measured completed block writes to the background fio file,
> including final sync, and foreground fio bandwidth, latency and
> completion time.
> 
> Across three runs per kernel, mean background file write I/O decreased
> by 72.7%, foreground bandwidth increased by 23.0%, and completion time
> decreased by 18.8%.
> 
> Metric                         Baseline    Patched     Change
> Background file write I/O (GiB)    6.154      1.680     -72.7%
> Foreground bandwidth (MiB/s)      150.29     184.81     +23.0%
> Foreground completion time (s)   109.203     88.652     -18.8%
> Foreground mean latency (ms)      212.84     172.74     -18.8%
> 
> How it helps
> ============
> 
> Frequent writeback of the file overwritten by background fio reduces
> the opportunity to coalesce buffered writes in the page cache.
> Several overwrites of the same page can otherwise result in a single
> write of its latest contents. Flushing between updates instead writes
> the same page repeatedly, generating more device I/O for the same
> application writes.
> 
> This additional I/O makes the device reach its performance limit
> more easily and competes with foreground I/O for device bandwidth.
> 
> The benefit is expected to be most pronounced when these conditions
> occur together on the same device:
> 
> 1. Limited device bandwidth, as with an HDD, makes the additional
>    writeback I/O more likely to saturate the device.
> 2. Multiple cgroups perform buffered overwrites. Frequent foreign
>    writeback reduces write coalescing and increases device I/O.
> 3. Concurrent direct I/O bypasses the page cache and competes directly
>    with writeback I/O for device bandwidth.
> 
> Approach
> ========
> 
> Following Jan's suggestion, this series records foreign bdev targets
> separately and flushes their mappings instead of their owner wbs. This
> preserves a way for dirty throttling to initiate bdev writeback while
> avoiding owner-wide writeback triggered by these records. The existing
> foreign-wb mechanism remains unchanged for other inodes.
> 
> Tracking uses oldest-first replacement and expiry after
> dirty_expire_interval. Further dirtying during an ongoing flush can
> trigger another flush after it finishes.
> 
> Tracking is best effort: each memcg keeps a bounded set of device
> numbers without persistent device or inode references. Recording runs
> under mapping->i_pages with IRQs disabled, while dropping a device
> reference can sleep. A memcg that never enters dirty throttling could
> also retain an unused record and pin the device object indefinitely.
> Recording only dev_t avoids these lifetime constraints. Device removal
> and device-number reuse may cause an unintended best-effort flush,
> which is an accepted trade-off.
> 
> Writeback submission may block for a long time, with up to four work
> items outstanding per memcg. A dedicated unbound workqueue provides
> a separate max_active budget so these flushes do not exhaust active
> slots on a shared workqueue and delay unrelated work. If the workqueue
> cannot be allocated at boot, bdev inodes continue to use the existing
> foreign-wb path.
> 
> This primarily affects filesystems that keep metadata in the bdev page
> cache, such as ext4 and other buffer_head users, rather than the usual
> metadata writeback paths of XFS and Btrfs. This also covers buffered
> writes to raw block devices. The decision still does not account for
> how much of the memcg's dirty memory belongs to the bdev: even a single
> dirty bitmap block can trigger writeback of the entire bdev mapping
> when the memcg enters dirty throttling.
> 
> Changes since v7:
> - Update comments and commit messages as suggested by Tejun Heo.
> 
> Changes since v6:
> - Drop open_mutex and the openers check from bdev_flush_by_dev(), and
>   add a !CONFIG_BLOCK stub.
> - Follow the existing foreign-wb tracking policy: use timestamps for
>   oldest-first replacement and expiry, and allow dirtying during an
>   in-flight flush to re-arm the record.
> - Replace frn_lock with an atomic in-flight flag.
> - Drop WQ_MEM_RECLAIM and explain the separate max_active budget.
> - Expand the dev_t lifetime rationale and filesystem scope, update
>   the foreign-dirty overview, and drop the Fixes tag.
> 
> Changes since v5:
> - Fix repeated overwriting of slot 0 in patch 2 and add comments.
> 
> Changes since v4:
> - Add before-and-after performance comparisons to the cover letter.
> 
> Changes since v3:
> - Flush foreign-dirtied bdev inode mappings separately, as suggested
>   by Jan.
> 
> Thanks.
> 
> Julian Sun (3):
>   block: introduce bdev_flush_by_dev()
>   memcg,writeback: flush foreign bdev mappings separately from owner wbs
>   writeback: record bdev targets in foreign writeback tracepoints
> 
>  block/bdev.c                     |  18 ++++++
>  include/linux/blkdev.h           |   4 ++
>  include/linux/memcontrol.h       |  12 ++++
>  include/trace/events/writeback.h |  22 ++++---
>  mm/memcontrol.c                  | 123 +++++++++++++++++++++++++++++++++++----
>  5 files changed, 160 insertions(+), 19 deletions(-)
> 

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
