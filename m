Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8B2248B4;
	Tue,  2 Jun 2026 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368346; cv=none; b=EXwta0fSm9ayNBN0mkMTfDBnX/GznpH6JgAKkSwcWCESVGDC1EWEEy6I9OqQrXuIR/sSeXIdrS/Uv5JvORGYmBY7T1fjBceL7RFF0YAuyj41hKjOBWl9rurZ4CEIEi2i5gUsUJUCTyMCHrNs3quHti3BucM3XZj0oyLDTedm/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368346; c=relaxed/simple;
	bh=3VPcySYpSPRTaRCq1ZoBNVXysIcU9P0QbKGfs4CmFI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCQkLZQdtssn+14au4GIE3VjJZAsiVdMgWmzElumd6ZUj5mUlUlqQFfxFZTdeO8Hs6ZdxiFYR+P+Kw05Yyj8Rd8bG8b8lsAGeQmUD/iltFi+UlxLl2A2PuSBZh2v6/qAT/tJIo5H5UbxOhc3vzJgQwOyGdok45wcMg3jNzoiHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FbloPyae; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FbloPyae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=4l3sxPyNqy0QPpGCpRZyDuuve5DBS6sEz0m5Ij5f8yo=;
	b=FbloPyaeuuIf5ZJsXIXWGwWb2a0IrsO3Zo4jtoxeHrdijrXA1yIS3pLxP6akBO
	2JL6u8BoG5VDVwNeF0fZrCh/27sIiudeLkN7WX/wPMmN9tE+Ek/xTlHDj1LcOZcl
	2KLZopY/c3ANFqutM1TxbuC7wN2JitJBvInYD4dJ0xsEw=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3v6uqQx5qSumtAw--.4601S2;
	Tue, 02 Jun 2026 10:45:00 +0800 (CST)
Message-ID: <e9ceb5fb-f052-4433-8124-2625bfc393a0@163.com>
Date: Tue, 2 Jun 2026 10:44:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm/shmem: optimize read with reduced xarray
 lookups and folio batching
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601174349.e521b96acac805ac3d9bfbbb@linux-foundation.org>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <20260601174349.e521b96acac805ac3d9bfbbb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3v6uqQx5qSumtAw--.4601S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4DCF15tFyDtr1fAF4ktFb_yoW5GFWkpr
	yfWF1ftrW3J3yfAr92kw18KF1xtr95JF1UXFn5trZ7XF1FywnIg3WfGr48GrZrCFyDuw1U
	XFyUJ3s2yr45t37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6E_iUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wweu2oeQ6wMHQAA3U

On 6/2/26 08:43, Andrew Morton wrote:
> On Mon,  1 Jun 2026 13:56:59 +0800 Chi Zhiling <chizhiling@163.com> wrote:
> 
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> This series improves shmem read performance by implementing folio
>> batching in the read path and reducing unnecessary xarray lookups.
>>
>> Performance Results:
>>
>> fio --ioengine=sync --rw=read --bs=$1 --size=1G --runtime=180 --time_based --group_reporting --name=seq_read_test --filename=testfile
>>
>> | THP disabled in tmpfs  | v7.1-rc5     | v7.1-rc5 + fbatch | Improvement |
>> | ---------------------- | ------------ | ----------------- | ----------- |
>> | 1M + normal file       | bw=11.5GiB/s | bw=12.7GiB/s      | +10.4%      |
>> | 64k + normal file      | bw=11.0GiB/s | bw=12.3GiB/s      | +11.8%      |
>> | 4k + normal file       | bw=3826MiB/s | bw=3849MiB/s      | +0.6%       |
>> | 1M + fallocated file   | bw=23.8GiB/s | bw=28.6GiB/s      | +20.2%      |
>> | 64k + fallocated file  | bw=22.5GiB/s | bw=27.3GiB/s      | +21.3%      |
>> | 4k + fallocated file   | bw=4655MiB/s | bw=4680MiB/s      | +0.5%       |
>> | 1M + hole              | bw=24.2GiB/s | bw=28.6GiB/s      | +18.2%      |
>> | 64k + hole             | bw=22.6GiB/s | bw=27.6GiB/s      | +22.1%      |
>> | 4k + hole              | bw=4652MiB/s | bw=4489MiB/s      | -3.5%       |
>>
>>
>> | THP enabled in tmpfs  | v7.1-rc5     | v7.1-rc5 + fbatch | Improvement |
>> | --------------------- | ------------ | ----------------- | ----------- |
>> | 1M + normal file      | bw=13.7GiB/s | bw=13.9GiB/s      | +1.4%       |
>> | 64k + normal file     | bw=13.5GiB/s | bw=13.5GiB/s      | +0.0%       |
>> | 4k + normal file      | bw=3833MiB/s | bw=3859MiB/s      | +0.7%       |
>> | 1M + fallocated file  | bw=24.9GiB/s | bw=34.2GiB/s      | +37.3%      |
>> | 64k + fallocated file | bw=23.0GiB/s | bw=31.4GiB/s      | +36.5%      |
>> | 4k + fallocated file  | bw=4710MiB/s | bw=4655MiB/s      | -1.2%       |
>> | 1M + hole             | bw=24.3GiB/s | bw=34.5GiB/s      | +42.0%      |
>> | 64k + hole            | bw=23.5GiB/s | bw=31.1GiB/s      | +32.3%      |
>> | 4k + hole             | bw=4690MiB/s | bw=4647MiB/s      | -0.9%       |
>>
> 
> That looks nice.
> 
> Microbenchmarks are useful, but are you able to help us understand how
> much benefit our users might see in real-world workloads?

Hi, Andrew

I don't have real-world performance data yet. I'm working on this simply 
because the patch shows decent gains in microbenchmarks. Even with THP 
enabled, it can still reduce some unnecessary overhead.

> 
> I'll take no action at this time - it's late in the cycle and reviewers
> have yet to participate.

Yes, it's unlikely to land in 7.2, and I still need to resolve some 
performance regressions.

> 
> AI review flagged a few possible issues, so please take a look:
> 	https://sashiko.dev/#/patchset/20260601055704.167436-1-chizhiling@163.com

Okay, I will take a close look.


Thanks!

