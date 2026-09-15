Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E02E762C
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789450525; cv=none; b=KCCWcCdviiNFGGOwPoLp6+xUInA0ako7qsedLrT7OH1VZU8HxZMXVjFG59X9P2LH+wIsPv9c6+aAizvBVEb2ZZWvLnqA7a2ELIdzplWiQ5VzCYxm1o1VauhSN0QxT6eFvOOE9eZYVIrL71xR1naM6cs2VezSivk6wMSOpbZnbY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789450525; c=relaxed/simple;
	bh=+hyCTRlyc0QNcS65JMtIZEPNo3AVH1S8Ev7UUp3zaQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6/CM0t5AWQwg9j29WUv1xjrGCgaudn2yAFpjHY3BLW7VJHwckEK/Y+DZPlNVZmFno2ybMy64/RGf9ka3igjOmDtReEOQdCm6XWpJyZCPaWNjQnVyk+VyZmhg97BEg+0uGxM2Huz3P9NmoRaIc0eGCbnvf3JHEH0y3XTava4VLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BefiyVU1; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BefiyVU1"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso2879252a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 22:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789450523; x=1790055323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OYhi4NJVlhoOAQ0HdJzU0jvm/8c0ymeQ0nH4iCFec9U=;
        b=BefiyVU1nBmW1ukaWPhAJDI8tdIYX9jnY5fitr+W2fEBXuI3YUNXYkgvyKyDdcGAHx
         6HaHfdok+uy0iLu8CJlaEqZqPXq6wgqXLtBMUSCE6tjAUAbZG75FnRVAi6BFyHRgg++5
         Nem/GUXXAID2e7G9RtP/ozAWLTqRZiJ9ZUfxpceXoWK5hncxn0f+23sZ0xFlg+Xs6XWZ
         Irda5MHZ+ltwdYtQAbi2oYm0tj24PvPgaZuadc93VWT159KNBSjmWL6O58FNRmoQIOGy
         AC1erdfSRxihOb1STVePQmuu0GjA1R3CucLYLUvwfFu/iRLfrfevkc6BJblQvhX2034q
         8M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789450523; x=1790055323;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OYhi4NJVlhoOAQ0HdJzU0jvm/8c0ymeQ0nH4iCFec9U=;
        b=iYjwGetmgXKF8QpZOLUdL4eQHl0Ioggyc6Yy2fxA+4xtSLEQwsW052PmSFtW6jg+bX
         HsAq4kYByZ4RqJGjCLbAAlJUnzyCJ/YLRDopMPuDExqyrEdJ4Wq6w5DNT+p+xs/+oOvO
         pHEhW4HWFNCQ+czzf4FAq6OnTZxXbfMRJ3WVmCvDIzr18ljiuLoZ1VqLvFNmgign+wO9
         CM9LyR5RJOnl3XZpAW7FxzDdWIVYOSQuzWvT1aENH9YmY1wrb/C7VLCwTHw7C9bbpLA7
         R4FH0w2uX3TWRD2zWDvGfftrLL+Bmtx10caGlR5QIJtAl1fn55JboMXOyBhjj0rihTu0
         RfsQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3uPqNAoamuMqb4eAvWGFCk+mzd1FsBnRjtP4a/ougUgLufe0o9+ZaNJWYNb3o9973WbdTXtXiH4NT98ks@vger.kernel.org
X-Gm-Message-State: AFuF++mJVRJm9r24wUtm6zCjZFJi7z+e+wc20WC2kAl9ZRbKLQGHkOvA
	r0Gyh11Ll6FNR0jm2fpFCrwSTAm9oMaiCeEBuQ98HVGPSyx5xX7cZr/RUuXa01z4D68=
X-Gm-Gg: AYBFou1GO6/GsctH0S9hVbcMGC0HPYB9Y1ydtU+HbWUDx99OS000vvydRL0VnpzLKIo
	ac6Z/1Tc3IuXmpCZ1EB669ImUVY4slqlcx5yny4Dx/21twhjdr8q2mLFOid5LSPweMQq4cZrD1n
	V3QkZL5FTPY4EoIrTF4+6Kio2y6izbjk1H7Pl2DtNLM+DU2M6FqZoWgzyuOrvaWAyBypMpZuqNc
	Dw80JpFJgKYZZvNQiVKItMmgxQnB/A3mm+hIFgrSFI9O+wK75fSKTtIgYK3rMqdkYvLHkpuIThg
	uQBMNgOaolN6Hi+65jCDOEyuVCRWfg1A5DUL+CzBR6CmqXTk+sTCqWYqshvtpVloDwVoMspbOeR
	YL4pscRXgpdcjqGjT9t3RqWuGFBBfbb+C1Y6XsXXZw/aicFu/zDG/rUQtOFvXUtgiDvuifJvHb+
	Xuq91wnyXolaTGaS96yZqEc70nVBwl2tywWyQPsSWvYW4eJuHlXUvQq9fsrCaySx9O0DKa9lTUS
	G3QY6L5mbqqytmBPt5dMfPGyD2wEhqSvmGOiVQDXeM=
X-Received: by 2002:a17:90b:4d07:b0:39d:f6a6:60d8 with SMTP id 98e67ed59e1d1-39df6a66122mr7696866a91.3.1789450523152;
        Mon, 14 Sep 2026 22:35:23 -0700 (PDT)
Received: from [100.81.12.150] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm2912867a91.10.2026.09.14.22.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 22:35:22 -0700 (PDT)
Message-ID: <eba0295b-268a-4573-aeeb-de79b9ca6063@bytedance.com>
Date: Tue, 15 Sep 2026 13:35:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] memcg,writeback: flush foreign bdev mappings
 separately
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 willy@infradead.org, jack@suse.cz, rostedt@goodmis.org, tj@kernel.org,
 linux-mm@kvack.org
References: <20260914103119.1708452-1-sunjunchao@bytedance.com>
 <20260914205947.5aab9d7261ef0f26ec8f3213@linux-foundation.org>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20260914205947.5aab9d7261ef0f26ec8f3213@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/26 11:59 AM, Andrew Morton wrote:
> On Mon, 14 Sep 2026 18:31:16 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:
> 
>> Bdev inodes are routinely shared by multiple memcgs. Recording their
>> owner wb as foreign can cause dirty throttling in one memcg to trigger
>> writeback of unrelated file data belonging to that wb.
>>
>> On one production machine, bdev mapping snapshots showed as little
>> as about 10 MiB of dirty data. A queue snapshot of its owner wb showed
>> 599 foreign-flush works, with an average requested writeback budget of
>> 43 GiB per work.
>>
>> In other words, a small amount of foreign dirtying in the bdev mapping
>> can trigger owner-wide writeback requests, whose budgets averaged
>> 43 GiB in this queue snapshot.
> 
> What is the overall runtime effect of this?  IOW, can we see some
> before-and-after numbers?

I tested this series using a QEMU/KVM VM with 4 vCPUs, 8 GiB RAM,
cgroup v2 and ext4. Virtual NVMe write bandwidth was capped at
200 MiB/s.

A fio job repeatedly overwrote a preinitialized 256 MiB file using
64 KiB buffered writes, at 64 MiB/s, for 9 GiB of logical writes.
Four memcgs, each with memory.high=32 MiB and io.max=2 MiB/s, generated
metadata and buffered writes to trigger dirty throttling and foreign
flushes. Concurrently, foreground fio performed 16 GiB of sequential
direct writes using 1 MiB requests and queue depth 32. Normal periodic
writeback remained enabled.

Three comparison pairs, with alternating execution order, produced:

Run  Kernel   File I/O (GiB)  Time (s)  BW (MiB/s)  p99 (ms)
1    base              7.19    114.74      142.79      1434
1    patched           1.57     88.62      184.87       480
      change         -78.22%   -22.76%     +29.47%   -66.52%

2    base              5.13    103.59      158.16      1434
2    patched           1.74     88.65      184.81       497
      change         -66.06%   -14.42%     +16.85%   -65.35%

3    base              6.14    109.27      149.94      1434
3    patched           1.73     88.68      184.75       480
      change         -71.77%   -18.85%     +23.22%   -66.52%

File I/O is completed block I/O matching the overwritten file's extents,
including final sync, not requested writeback budgets. The other metrics
are for the foreground workload.

Across these runs, mean file write I/O decreased by 72.7%, foreground
bandwidth increased by 23.0%, and completion time decreased by 18.8%.

The baseline varied noticeably: runs with more writes to the overwritten
file also took longer to complete the foreground workload. With this
series, foreground completion time stayed within 88.62-88.68 seconds.
This is consistent with preserving overwrite coalescing and leaving more
device bandwidth available for the foreground workload.

> 
>> Following Jan's suggestion, this series records foreign bdev targets
>> separately and flushes their mappings instead of their owner wbs. This
>> preserves a way for dirty throttling to initiate bdev writeback while
>> avoiding owner-wide writeback triggered by these records. The existing
>> foreign-wb mechanism remains unchanged for other inodes.
>>
>> Tracking is best effort: each memcg keeps a bounded set of device
>> numbers without persistent device or inode references. Closed devices
>> and devices with a busy open_mutex are skipped. Device removal and
>> device-number reuse may race with lookup.
>>
>> Flushes run asynchronously on a dedicated workqueue to isolate these
>> frequently triggered tasks from existing workqueue users. If workqueue
>> allocation fails, the existing foreign-wb mechanism remains in use.
>>
>> Julian Sun (3):
>>    block: introduce bdev_flush_by_dev()
>>    memcg,writeback: flush foreign bdev mappings separately from owner wbs
>>    writeback: record bdev targets in foreign writeback tracepoints
>>
>>   block/bdev.c                     |  24 +++++++
>>   include/linux/blkdev.h           |   1 +
>>   include/linux/memcontrol.h       |  15 ++++
>>   include/trace/events/writeback.h |  22 +++---
>>   mm/memcontrol.c                  | 113 ++++++++++++++++++++++++++++---
> 
> I'd consider this a memcg patch, and not only due to the line counts.
> 
> Please cc linux-mm on memcg patchsets.
Sure, will do.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
