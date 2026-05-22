Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB8246788;
	Fri, 22 May 2026 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779413907; cv=none; b=cwTZIk5yZcg8GlRw5j77sq3ecrSmx65E5I3nNvIkOm6CiNdPQk0euNBquT/EKDZnPBn2nF0AXOcXgFOGkeHgeoSwYeQ1OHVDzIr3YsOGQs10XLk/S9OhqUVqLMwsMjQ4czW/Bxhu+ncFHW7mvYHe7rj2wIrp66Juji8iaSZjKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779413907; c=relaxed/simple;
	bh=hVFowz43V7+Za1j/MsbEgZkbPdgZy1dJ4ZPvHUK8hyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C31G6s2GWQWlLhgdGw+3AXZ+WOQEcIG0MffK43sIZWS/iNhsXzWWJt6cF3xFmyKOX0upFNuXQHNrXtuOSVo9zj3Tgm0vYspy7jeCXhYXallMwbVaoKLtOT+we1UqXNXZkQYLQnBlspFQHzDtDB0Dcrx+IJDELUAKdhzO6xga9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BEzZ4sXf; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BEzZ4sXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=fvA2acxT+PUWoFnhiyQnKqpADcf34Gxxo2YPPgOhPzY=;
	b=BEzZ4sXfJTbJc8wV5opq/0kxCCuhgFfztRK+kjCmsogsHHPFoBaITAxHXFEihd
	q63CWIPKpgxrlgD2X0+LmfDpoAvyiY5DG/qsoI5GyMMlvwV1/WA6s5ejIkJK9oA3
	qDhf9r/tlDaYp04ycnTXNLhBKvNyzMaUGxAi+aCTO8lgI=
Received: from [192.168.3.148] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAn09g3sw9qVK6RCg--.8337S2;
	Fri, 22 May 2026 09:36:57 +0800 (CST)
Message-ID: <ecf092ec-80d6-4851-b0bd-e05ba11074f7@163.com>
Date: Fri, 22 May 2026 09:36:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] mm/shmem: optimize read with reduced xarray
 lookups and folio batching
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20260520101538.58745-1-chizhiling@163.com>
 <20260521171454.02e35e71f999672518087037@linux-foundation.org>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <20260521171454.02e35e71f999672518087037@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAn09g3sw9qVK6RCg--.8337S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar45Gw13CrWDtw4xZFy5Jwb_yoW8Aw1kpa
	43GFyfAr4xG3y3G3s7trWjqr1xtrn7tr18XFn5JFs2qw1FyF1UtFyxXrW8X39FkryDAr1U
	JrW7Jwn2yr1UKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZJ5wUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xtZ9moPszsYUQAA3n

On 5/22/26 08:14, Andrew Morton wrote:
> On Wed, 20 May 2026 18:15:33 +0800 Chi Zhiling <chizhiling@163.com> wrote:
> 
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> This series improves shmem read performance by implementing folio
>> batching in the read path and reducing unnecessary xarray lookups.
>>
> 
> Thanks.
> 
>> Performance Results
>> ===================
>>
>> Testing was performed with fio sequential read workloads:
>>
>>    fio --ioengine=sync --rw=read --size=1G --runtime=180
>>
>>
>> ### THP Disabled - Normal Files ###
>>
>> | Block Size | Baseline  | v1        | Improvement |
>> | ---------- | --------- | --------- | ----------- |
>> | 1M         | 11.4GiB/s | 12.7GiB/s | +11.4%      |
>> | 64k        | 11.2GiB/s | 12.2GiB/s | +8.9%       |
>> | 4k         | 3809MiB/s | 3838MiB/s | +0.8%       |
>>
>> ### THP Disabled - Fallocated Files ###
>>
>> | Block Size | Baseline  | v1        | Improvement |
>> | ---------- | --------- | --------- | ----------- |
>> | 1M         | 23.7GiB/s | 28.7GiB/s | +21.1%      |
>> | 64k        | 22.6GiB/s | 27.0GiB/s | +19.5%      |
>> | 4k         | 4668MiB/s | 4678MiB/s | +0.2%       |
>>
>> ### THP Enabled - Normal Files ###
>>
>> | Block Size | Baseline  | v1        | Improvement |
>> | ---------- | --------- | --------- | ----------- |
>> | 1M         | 13.9GiB/s | 13.9GiB/s | 0%          |
>> | 64k        | 13.4GiB/s | 13.4GiB/s | 0%          |
>> | 4k         | 3818MiB/s | 3836MiB/s | +0.5%       |
>>
>> ### THP Enabled - Fallocated Files ###
>>
>> | Block Size | Baseline  | v1        | Improvement |
>> | ---------- | --------- | --------- | ----------- |
>> | 1M         | 24.1GiB/s | 34.9GiB/s | +44.8%      |
>> | 64k        | 22.9GiB/s | 31.3GiB/s | +36.7%      |
>> | 4k         | 4721MiB/s | 4708MiB/s | -0.3%       |
> 
> That looks nice.
> 
> AI review might have found a few things:
> 	https://sashiko.dev/#/patchset/20260520101538.58745-1-chizhiling@163.com
> 
> I'll skip the patchset for now (unreviewed v1!).

Okay, I will fix those issues in v2.

Thanks!

