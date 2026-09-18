Received: from mail-pz2-f18.google.com (mail-pz2-f18.google.com [74.125.228.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2B41CB56
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707435; cv=none; b=KZdJZh9MCMLqviXw1Sw6m9787WHghm9KWptbwJK4O/2z8o08dJypj2fqURtqQiQpi6RtDcaM8Nnfwi8EqMFdP5JfeDMidOTKcphdqv6jDjGZIP17lVdz9JHRgIk44TcGeLl1vLJ8Vh/IfbIPWepX2jWJihpqJALmyGmt4dlVRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707435; c=relaxed/simple;
	bh=TFzzOp0Z45QYFc//FtBFfyXHOBCbHRc8WvTkq51K8Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKNgPYbbjE9YMw9ThRwAEs0sumljPW/eMUHFk8nHBEaeP5VPS8f8qchRpY/7HE/jzMSOdjtZKpt7s/HmAqlCxUANRGBhhYTUZUTXXkkZ4e6LrzVmxlcZ+INxzJxrp1hWM8jGXe848s3CoDfHpzOOh0wE9D0mStD+HVxQrc/Br4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ob9jhD4k; arc=none smtp.client-ip=74.125.228.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ob9jhD4k"
Received: by mail-pz2-f18.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso199007a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 21:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789707431; x=1790312231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BINWNM6rAXczaz/wqYMANaQxaxCeH43keYl+j5zAlsg=;
        b=Ob9jhD4kH337CR6E+PYmdkGd/NogIsCLwvD3AIrnZA7vVaJwbyfpNNsfa1GNMyFOlr
         E45h+7iotnuCvWnJvyIYrKj31Zw69CWF0hU4Pzm6GdoA8Q9XTJvUj78VuVQlGXauGDjs
         bxmp90bmmhyrkjZh4shEwJJQGTxfz0ImLeJr1iegUkWroLuCHNBDxkhACDs+IYJZZSAs
         mpwuldWBteVuwMEf0bCioneMdKFAO6XKxXnQ55eCmx1TjRDWhzRvFWC2RNqJzBttoA7M
         pd4H5EritUQqn9ODaZ2/KAuWdADz4gJt6vIwQWicIEtQ+J+l3XUfc8izmxjOr2i8smof
         NKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789707431; x=1790312231;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BINWNM6rAXczaz/wqYMANaQxaxCeH43keYl+j5zAlsg=;
        b=XQER9Mvog3n5DRJ+gt4EnU9ZqQOoxr4VQCAF4roimQUQ0Zke3boLQiamowjHKqv54i
         vaimhcuxgwYd5xs5mSHKF6pmBqIGeGrkQxLaCeBtf0s86dDO9khWJ3PG0JeYyBZj0zwH
         w4wyLGLFnWx/ov4hYTt2zTmGYFN4pJVRnmUQ6A7ExdXPOBd65Hc2rR0XX66v+XtfWJ/m
         haqCygXSgQOORDY73lgvIleqeNhGeClfu4xj275NVBntRmMkcASmt/Ewu0lww5SFy0fG
         2O2Pzru4lSaAeBLPOE55z132ajf7FrmVHRx74O9Z6gYrdhMFV4NfjHaMKI4erIxHA/A8
         uNaA==
X-Forwarded-Encrypted: i=1; AKwUvBz4IzRHd1DuNqZvxXNk0Vc8X6rvZpeUnijCzOc+WeAhOI4JmZhsCqFts+NtPXfoFVucROKNIqPa9Iu9xkH+@vger.kernel.org
X-Gm-Message-State: AFuF++nyIy62ybACkQ/cqWW+5Vlk0cLXO6ruenCNkLbJDadBS6FMYPRx
	ADJ1XByleZuSe9NEQbmYl3iaTe389I1s3YOHU2d9u1VHcmxNkan4yyjqUO4hvetloEw=
X-Gm-Gg: AYBFou1pvMS/UUOVl/qBQSXuSncZB3GoNhQty2P5zw3sy6dukIzFS9AX/092KiGBozh
	uAR0bm4adMxzmJJrXEC6bleGUbjbkeshPyOhvigr8aJj3LAFqxcCwCSCDM7Z1tZYhdACjCeepFm
	AWNCceBNEPQGQFtKSeOliwuYtkiHQpCpyuCgRstAMfpmdeHOgtM/Bjm1bSFH6aJLS8E6BgYzvFH
	92bMh2VI260qk+MDfKZaZx/utHK/KesdVQ0GcBWeVEZfboRUiuk6sXJeX2rOiikLgrWkKCIBY3q
	G3eBUYmoi5XcuXC5o9KyRw1A4jd4WDhr//Bo3osI+LsZ2lV4qYFPeBcX64ZtSQLcoKTS0TxvQgm
	D/EWsLbyivHThxDwpHA09B6a33u3WmKE7IzAvNOokTFu9mUEqRdxW24A7lYz/v839JOVxdb3Cke
	CUpA4ezEjcvsRLrtg/rym9jOu5W9MGlkXBYFef4853/VTO++0G1e/EY8NyCDjs3upHvM7qEWecM
	jXe0dYAUwU31QVMSAP0nG22VujuzQ==
X-Received: by 2002:a05:6a20:ce43:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3dd8c44e218mr2662348637.18.1789707431275;
        Thu, 17 Sep 2026 21:57:11 -0700 (PDT)
Received: from [10.71.180.110] ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b0293sm1111628eec.24.2026.09.17.21.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 21:57:10 -0700 (PDT)
Message-ID: <836b5192-ef11-4f16-8c90-049d570959a2@bytedance.com>
Date: Fri, 18 Sep 2026 12:57:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] memcg,writeback: flush foreign bdev mappings
 separately
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, willy@infradead.org, jack@suse.cz, tj@kernel.org
References: <20260917065759.2643940-1-sunjunchao@bytedance.com>
 <20260917155305.7a63e01ba3ed34ed0aea537f@linux-foundation.org>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20260917155305.7a63e01ba3ed34ed0aea537f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/26 6:53 AM, Andrew Morton wrote:
> On Thu, 17 Sep 2026 14:57:56 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:
> 
>> Hi,
>>
>>
>> Measured impact
>> ===============
>>
>> The synthetic test used a VM with 4 vCPUs, 8 GiB RAM, ext4 and cgroup
>> v2, with device write bandwidth capped at 200 MiB/s. Background fio
>> repeatedly overwrote a 256 MiB file using buffered I/O, while
>> foreground fio performed sequential direct writes. Four memcgs
>> generated metadata and buffered writes to trigger foreign flushes.
>>
>> We measured completed block writes to the background fio file,
>> including final sync, and foreground fio bandwidth, latency and
>> completion time.
>>
>> Across three runs per kernel, mean background file write I/O decreased
>> by 72.7%, foreground bandwidth increased by 23.0%, and completion time
>> decreased by 18.8%.
>>
>> Metric                         Baseline    Patched     Change
>> Background file write I/O (GiB)    6.154      1.680     -72.7%
>> Foreground bandwidth (MiB/s)      150.29     184.81     +23.0%
>> Foreground completion time (s)   109.203     88.652     -18.8%
>> Foreground mean latency (ms)      212.84     172.74     -18.8%
> 
> Thanks.
> 
> As I understand it, this is basically ext4-specific.
> 
> I don't think btrfs or xfs mess with the bdev address_space at all? 
> But google tells me that "roughly 70% to 80% of all Linux machines use
> ext4 as their primary or root file system", so there is that.

Yes, most of our systems still use ext4.
> 
>> Approach
>> ========
>>
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
> 
> This part looks plain nasty.  Why are we messing with dev_t's and
> risking these races?
> 
> At the very least, this description should explain the reasoning behind
> this decision at some length.
> 
> Surely it's cleaner and safer to grab a ref on something (the bdev
> inode?) and hang onto that object.  Use it for these operations, let it
> go at the appropriate time.  Clearly there's something wrong with that
> approach, but what?

This follows the existing foreign-writeback mechanism's best-effort design:
it records IDs without holding any references and tolerates occasional
stale hints. I followed the same approach for bdev tracking by recording
dev_t.

Taking a device reference would introduce additional lifetime management.
If we acquire a reference during foreign tracking but the memcg does not
enter dirty throttling for a long time, no foreign flush would consume
the record and release the reference, then delaying final device-object
release. A timeout mechanism would only limit this delay, not eliminate it.

There is also a locking issue: dropping a record happens under mapping->i_pages,
but dropping the last reference may sleep. We would therefore need to restructure
the release path, adding concurrency and lifetime-management complexity.

Recording only dev_t follows the existing mechanism's best-effort design.
Device-number reuse may cause a stale record to trigger writeback of the new device's
own mapping. In my view, this occasional unnecessary writeback is an acceptable
trade-off for avoiding the complexity above.
> 
>> Flushes run asynchronously on a dedicated workqueue to isolate these
>> frequently triggered tasks from existing workqueue users. If workqueue
>> allocation fails, the existing foreign-wb mechanism remains in use.
> 
> Unclear what this means.  If a kmalloc/etc fails then we fall back to
> the current (mainline) behavior?  Fair enough, failure of small
> kmallocs are so rare.  The main problem is testing the failure-path
> code!

Yes, if allocation of memcg_bdev_frn_wq in mem_cgroup_init() fails,
foreign writeback falls back to the existing mechanism. The workqueue is 
allocated once during initialization. The new tracking and work-
queueing paths use preallocated per-memcg slots and perform no dynamic
allocation at runtime. please see patch 2 for more details.

I tested this failure path by forcing the workqueue pointer to NULL
and the results were as expected.> 
> 
> Also, and most importantly, what the heck is "frn"?  Would the world
> end if you did s/frn/foreign/g?

Emmm, the naming follows the existing code. I'll rename the new uses
of "frn" to "foreign" in the next version. Renaming the existing code
would be a separate cleanup patch; I'd prefer not to mix that into this
fix series.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
