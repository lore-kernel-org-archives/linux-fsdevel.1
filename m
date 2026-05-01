Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA923FD15C
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653862; cv=none; b=kWVmtgUEl7NbvDCSY4ipcQO1ZjMc6ZkoyA1ybN8mR0Y8MUMGHo/MZDvlOJ5ECJWeEMDZ3B2HwW16QeMTR+a3Cg5pqVlJsmeeeIEP+MyaMXYddryw8OMPeR4hv8nEP289xOHWVc6i0bbcl4ZWOolkN8LtcQ0Bm2VTV0ZIj7pJRos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653862; c=relaxed/simple;
	bh=BzpvNNe0Y7pWnImNb7utvKGVhDIu4ekSHRzW3u8hMCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p53sKkQFz3PUb1Gch7in+IEPvQXf5lr8jmFGEC+IMQKfOoMY1HnRDAwRrDoyt/3qDPQe3EvWzvPG4RVsQqH5lYnL4MrjKJw0Sx3yzKxhJ72WenFZaNRzs+017VucSZTBAtMGzmyXQid/H60sgNRAX8kUhKxFNUQ2INRJzYoX9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=t/A09e1g; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="t/A09e1g"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479fc1fc048so1542949b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777653854; x=1778258654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=258tSgDmQvsBwqYiudf3HzA2YcVV3/7qcjtUVSy9L94=;
        b=t/A09e1gBKwHej8bFSSsDKaY+HbwtWehYTY6lD/aQAbC6dd7DgC01GYCseKf6U4Drp
         Nbu7cxnKVoOHHYDRK0bMNqX38VmWz9bPLe7lXQjWZhwP8rQ+wBdaOc2TZfNjdTp+fq5n
         J4/yDwZY6l2DpYYyZBBrSJ/aqLOZvzOcbRlBtgtIyA+Ug2IyK8NITuZt1WnAr9tHJZU2
         2aNDB1xK/1sP9de7FFVxjaqR2bVfBbc7w3XUCpg2PuqK+E7TP8Awfn3yzKbmJMP3uTaR
         dqBtWdMDAUQ8PtDgW0rUmoblNP27wev8sG/a2YqsNsQVbkvVAj+TjSvxxHE4pKcUrX8K
         v6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777653854; x=1778258654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=258tSgDmQvsBwqYiudf3HzA2YcVV3/7qcjtUVSy9L94=;
        b=g9GLhWTYx3SR+PMWDJVePm8TcSgjgrxidUgmjl+EmQhXpg5kFdZKp+pBTAzdkq0eml
         EKSrJk8K0cAk/VRZnYXqlKLNWXOjqKRRaT8Hkdp7pDgFNw4pmwRSzSVo5DJoQ+KtgceW
         gmuwy1gqC7AV8ljyyjolITusboBYA2wrrWLkFNne0ZWPWzUmDEkJG/myS4/RkJcoKkNa
         WwnkhKLLcU04NsL4aqvLYqvxvnlh+pYn++D4G5WcyiPDWfAFQrt/qn4QFb1vnKy3yh13
         EBC99IcQoNsQZ53bEwrZ81FHTsPQLexWhJMZHLSnGsaZzxCixR0OCAWk2bTm3utfSC6M
         TZ7w==
X-Gm-Message-State: AOJu0YylYXMfrweVmjPHU2b+9h8msnq/jv1xhG/2u2bgH3GL0r2msZHF
	4STn8o6M/iFsV+sICyuKZ0jTJ7Wid8YbJG29ptVJAVbPJZcMs6NTrAFM1d2g8ERVtOA=
X-Gm-Gg: AeBDietVVzPRoHC5Wzo2eCpGwxHqwoAEYwY9EvpcOlU99YJfY7s/aT7aN5q87GR0dC4
	+0klUo0LIHP9bnnbPU1jhaspSCh/NvUjm9usMs4z3Ps/Y/Vmun2+xOuCHtA+a5f8dQMbky1YOGu
	QKKyo7ssz3uAgLGG/dWrimTAOxKiO8iZyO2TxXcVkZpXU5qmviong4KCqMYwc9vL8mFZgQ/gSUl
	eXU0/v3lTPOu8C3EXQ/vTPgKRjhnqmKFWq9QPYMdBqMZwGHYKUyhMJutNq6rcKT+RoCCnh0vAXi
	DOWNN/5KK/Gg3wIw/1JxQGWWkFtkGK9Q4MuZLr+6Wo8GOkdcvNTL3c1f++SLQCdFoaJRUAUySHC
	fuQNZm1aRP7aDzpXGk7EomHaFiukTqr8kNbF2Y/chD90Qus4nK+93e7BkC0do3VdjxYO1+AZvt5
	hSoHObwXjwr5nWIrc3/+zWSXPMuqZYOtsAaiVoHeydG2hOvGqLfVmBowGBapxqmfEguwrRvJ1cQ
	qxljNbIfB/DUc3wlPA=
X-Received: by 2002:a05:6820:a04:b0:694:8c67:5cb6 with SMTP id 006d021491bc7-6967a5dbd54mr3873019eaf.41.1777653853660;
        Fri, 01 May 2026 09:44:13 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d8ed0dsm2836466fac.17.2026.05.01.09.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 09:44:13 -0700 (PDT)
Message-ID: <ec07180c-665a-4e78-94a4-1670a8bf8efd@kernel.dk>
Date: Fri, 1 May 2026 10:44:11 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] mm: kick writeback flusher for IOCB_DONTCACHE with
 targeted dirty tracking
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Mike Snitzer <snitzer@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org
References: <20260501-dontcache-v4-0-5d5e6dc71cb3@kernel.org>
 <20260501-dontcache-v4-2-5d5e6dc71cb3@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260501-dontcache-v4-2-5d5e6dc71cb3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/1/26 3:49 AM, Jeff Layton wrote:
> The IOCB_DONTCACHE writeback path in generic_write_sync() calls
> filemap_flush_range() on every write, submitting writeback inline in
> the writer's context.  Perf lock contention profiling shows the
> performance problem is not lock contention but the writeback submission
> work itself — walking the page tree and submitting I/O blocks the writer
> for milliseconds, inflating p99.9 latency from 23ms (buffered) to 93ms
> (dontcache).
> 
> Replace the inline filemap_flush_range() call with a flusher kick that
> drains dirty pages in the background.  This moves writeback submission
> completely off the writer's hot path.
> 
> To avoid flushing unrelated buffered dirty data, add a dedicated
> WB_start_dontcache bit and wb_check_start_dontcache() handler that uses
> the per-wb WB_DONTCACHE_DIRTY counter to determine how many pages to
> write back.  The flusher writes back that many pages from the oldest dirty
> inodes (not restricted to dontcache-specific inodes). This helps
> preserve I/O batching while limiting the scope of expedited writeback.
> 
> Like WB_start_all, the WB_start_dontcache bit coalesces multiple
> DONTCACHE writes into a single flusher wakeup without per-write
> allocations.
> 
> Also add WB_REASON_DONTCACHE as a new writeback reason for tracing
> visibility, and target the correct cgroup writeback domain via
> unlocked_inode_to_wb_begin().
> 
> dontcache-bench results (same host, T6F_SKL_1920GBF, 251 GiB RAM,
> xfs on NVMe, fio io_uring):
> 
> Buffered and direct I/O paths are unaffected by this patchset. All
> improvements are confined to the dontcache path:
> 
> Single-stream throughput (MB/s):
>                         Before    After    Change
>   seq-write/dontcache      298      897    +201%
>   rand-write/dontcache     131      236     +80%
> 
> Tail latency improvements (seq-write/dontcache):
>   p99:    135,266 us  ->  23,986 us   (-82%)
>   p99.9: 8,925,479 us ->  28,443 us   (-99.7%)
> 
> Multi-writer (4 jobs, sequential write):
>                                 Before    After    Change
>   dontcache aggregate (MB/s)     2,529    4,532     +79%
>   dontcache p99 (us)             8,553    1,002     -88%
>   dontcache p99.9 (us)         109,314    1,057     -99%
> 
>   Dontcache multi-writer throughput now matches buffered (4,532 vs
>   4,616 MB/s).
> 
> 32-file write (Axboe test):
>                                 Before    After    Change
>   dontcache aggregate (MB/s)     1,548    3,499    +126%
>   dontcache p99 (us)            10,170      602     -94%
>   Peak dirty pages (MB)          1,837      213     -88%
> 
>   Dontcache now reaches 81% of buffered throughput (was 35%).
> 
> Competing writers (dontcache vs buffered, separate files):
>                                 Before    After
>   buffered writer                  868      433 MB/s
>   dontcache writer                 415      433 MB/s
>   Aggregate                      1,284      866 MB/s
> 
>   Previously the buffered writer starved the dontcache writer 2:1.
>   With per-bdi_writeback tracking, both writers now receive equal
>   bandwidth. The aggregate matches the buffered-vs-buffered baseline
>   (863 MB/s), indicating fair sharing regardless of I/O mode.
> 
>   The dontcache writer's p99.9 latency collapsed from 119 ms to
>   33 ms (-73%), eliminating the severe periodic stalls seen in the
>   baseline. Both writers now share identical latency profiles,
>   matching the buffered-vs-buffered pattern.
> 
> The per-bdi_writeback dirty tracking dramatically reduces peak dirty
> pages in dontcache workloads, with the 32-file test dropping from
> 1.8 GB to 213 MB. Dontcache sequential write throughput triples and
> multi-writer throughput reaches parity with buffered I/O, with tail
> latencies collapsing by 1-2 orders of magnitude.

I like this, this is the better way to kick off the writeback.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

