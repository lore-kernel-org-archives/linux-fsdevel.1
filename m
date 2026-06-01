Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AEC33B6F8;
	Mon,  1 Jun 2026 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298241; cv=none; b=rAKMTEJ9kRljV4sZviknBcL3JJYvLMFbAxnu2R+b0KdXMASugxVHV/XsoUmVNVvqxneDFSVYyTZJL3KSqRCq4Adv+759mjaiqsHArMaoAzqN7y5h1L46RX5uQJEOV6y4ioc9VKEL2LrJ/841mumydBmZ+qiJJwIQrcVMk1CqwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298241; c=relaxed/simple;
	bh=O15qp62lnGg8h0D3Jf+GQQEexYXhwR92s4TvaE9Wd7s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ftUaf5vul6eD+ZAyLBobVp7C7U9+bQi9WNiONZm/I9x2TZLoezQVVwUMXy54uqhgZZ9BvJu6yKL5mrdxOEkiMV8P6GAm9ElhUu9XfxP5J75FzLt+H/YVJe4JdH0b1ZoCc+ArSPrn3gaD1N3CSFeSTioCOxwjqdmKCxW6bimt7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NrCjURBa; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NrCjURBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=eMVFGeQet2q9i38H6nc5ggraVuL3XTIUP1O16KEY7o0=;
	b=NrCjURBabv0q9bQWSd7LBR68SUEtmSmqT8Auy7wVdxNSy0Utfnfw9ANFWepPja
	yNFd1GkcL8+a4Fr/LS26WIX8p92ysQr1dDx9TpicPuoZC/Lvt1wCeBOuk780El7a
	eun+91E0ynhrvh5aI5Jv+CbBOwqyPOA4MyYH9WsUmlcfk=
Received: from [192.168.3.148] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXW5KxMR1q+JGXFQ--.4S2;
	Mon, 01 Jun 2026 15:16:07 +0800 (CST)
Message-ID: <0c52fc64-3546-4008-af98-6d589ef00c99@163.com>
Date: Mon, 1 Jun 2026 15:16:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm/shmem: optimize read with reduced xarray
 lookups and folio batching
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260601055704.167436-1-chizhiling@163.com>
Content-Language: en-US
In-Reply-To: <20260601055704.167436-1-chizhiling@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgBXW5KxMR1q+JGXFQ--.4S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4DWrWxKF4UAryrAF17Awb_yoW5JrWxpr
	ySgr1ftry7J3yfArn7Gw1rKFyxJrZ5tF1DWF18KFs3XF1Fyw43t3W8Gr48GrWDCa47Zw1U
	Jry7Jwnrtr15K37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6KZAUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2xdb+GodMbcZaAAA3v

On 6/1/26 13:56, Chi Zhiling wrote:
> Performance Results:
> 
> fio --ioengine=sync --rw=read --bs=$1 --size=1G --runtime=180 --time_based --group_reporting --name=seq_read_test --filename=testfile
> 
> | THP disabled in tmpfs  | v7.1-rc5     | v7.1-rc5 + fbatch | Improvement |
> | ---------------------- | ------------ | ----------------- | ----------- |
> | 1M + normal file       | bw=11.5GiB/s | bw=12.7GiB/s      | +10.4%      |
> | 64k + normal file      | bw=11.0GiB/s | bw=12.3GiB/s      | +11.8%      |
> | 4k + normal file       | bw=3826MiB/s | bw=3849MiB/s      | +0.6%       |
> | 1M + fallocated file   | bw=23.8GiB/s | bw=28.6GiB/s      | +20.2%      |
> | 64k + fallocated file  | bw=22.5GiB/s | bw=27.3GiB/s      | +21.3%      |
> | 4k + fallocated file   | bw=4655MiB/s | bw=4680MiB/s      | +0.5%       |
> | 1M + hole              | bw=24.2GiB/s | bw=28.6GiB/s      | +18.2%      |
> | 64k + hole             | bw=22.6GiB/s | bw=27.6GiB/s      | +22.1%      |
> | 4k + hole              | bw=4652MiB/s | bw=4489MiB/s      | -3.5%       |
> 
> 
> | THP enabled in tmpfs  | v7.1-rc5     | v7.1-rc5 + fbatch | Improvement |
> | --------------------- | ------------ | ----------------- | ----------- |
> | 1M + normal file      | bw=13.7GiB/s | bw=13.9GiB/s      | +1.4%       |
> | 64k + normal file     | bw=13.5GiB/s | bw=13.5GiB/s      | +0.0%       |
> | 4k + normal file      | bw=3833MiB/s | bw=3859MiB/s      | +0.7%       |
> | 1M + fallocated file  | bw=24.9GiB/s | bw=34.2GiB/s      | +37.3%      |
> | 64k + fallocated file | bw=23.0GiB/s | bw=31.4GiB/s      | +36.5%      |
> | 4k + fallocated file  | bw=4710MiB/s | bw=4655MiB/s      | -1.2%       |
> | 1M + hole             | bw=24.3GiB/s | bw=34.5GiB/s      | +42.0%      |
> | 64k + hole            | bw=23.5GiB/s | bw=31.1GiB/s      | +32.3%      |
> | 4k + hole             | bw=4690MiB/s | bw=4647MiB/s      | -0.9%       |
> 
Apologies, due to my oversight, the tests involving hole were incorrect, 
the holes were not successfully created in the files during testing.

Below are the corrected results from a retest:

| THP disabled | v7.1-rc5     | v7.1-rc5 + fbatch | Improvement |
| ------------ | ------------ | ----------------- | ----------- |
| 1M + hole    | bw=27.3GiB/s | bw=23.4GiB/s      | -14.3%      |
| 64k + hole   | bw=27.3GiB/s | bw=23.3GiB/s      | -14.7%      |
| 4k + hole    | bw=4825MiB/s | bw=4624MiB/s      | -4.2%       |


| THP enabled | v7.1-rc5     | v7.1-rc5 + fbatch | Improvement |
| ----------- | ------------ | ----------------- | ----------- |
| 1M + hole   | bw=27.0GiB/s | bw=23.1GiB/s      | -14.4%      |
| 64k + hole  | bw=27.5GiB/s | bw=23.3GiB/s      | -15.3%      |
| 4k + hole   | bw=4777MiB/s | bw=4640MiB/s      | -2.9%       |


There is a noticeable performance drop when accessing holes, as every 
read triggers a fallback. I will address this in the next version.

