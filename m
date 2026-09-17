Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A662430CDD
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648371; cv=none; b=aflcvX/NCbQ2Mtqsl0+Zz29/A3oyr+Pik0fb1QJi/CDbCBKZhfkesH2va4v9auvZ21H1QD+uk6FrO5yavlrOF8gD/DCUAmdaJLuG/deFdDQYA7zrCACXL7nODT1KI2pwvNqVv50lPdrxIfkILk7gwGRIMGESAl9QIZlyayY2s8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648371; c=relaxed/simple;
	bh=Xa1IsGUxXNZyPx56uY6l71cj0MjnLhOAqncuS8+Vjcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3RGCJTye4V5sCytYKLRXBQxqa1L/vlFpYBkEIJqB+ml3bHwnw+03x/Kh6hOSQQMD/pEgvKbZhdIyl2AlmNj+xRpkuvXPNE+RyleqpdthGWjinwFE4aTdU19DryJvo55DGu2B6d32sQ+W6D1Ez/NJztiRDji1DacyPzNjkiYRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjcXjMtD; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjcXjMtD"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d04d740cso497308a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 05:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789648365; x=1790253165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pX0fdZFc2RLefcqbAqYKYTVdyFNxhnyETiiYgD7pF2c=;
        b=hjcXjMtDRnxivV5RUwe4t7f8G1xCyCNdN8hpGAmvHPWJPjzqShBjOQDsYzOMLXbYwR
         xoq4s8fgi0/7l6kzwwbC2PtKx93Znq7uPk3yS9loWfkr9LdBAlnRhtWsLqgRtzAXOV7O
         EZgvXAV8GwFgE/lMd4pSmhwY0eZmJ4fpWvJpEU9u45btB6rjO0E7KKGYzGOsbHqUcWrM
         zVHC9aEc6ArGcsq+juf4DIR0TdOU45VQQy1vokAM+tWnXmtMlSCS7Tz2/Asv3WMj7Mti
         4+VUMkwLrCu1aNMYTbfVJvthg4BRzFey46NItDsgwlkGQyrb5Xx0r/HjumMIEfsBcjCO
         Rqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789648365; x=1790253165;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pX0fdZFc2RLefcqbAqYKYTVdyFNxhnyETiiYgD7pF2c=;
        b=HqOUBMmF3ML1J1HVEABwvlIvjnnDJwh5g4m4a06YMK3HHbGSnuVqN1F6wBr8c16PxC
         oF+1roHEdr7a8N0Y7qnelJTz3hmkQpX3fK240H5Xr3ohS+UDStntooyOU5wg6PDoA7Ou
         IdKaONsRFt5o9+GAchMk1jvzlLU3TkWbNjU7BgbXrRdvnfKqUDFwKq+6OnUQdcsD8Mem
         FETlT2LmcWA5tjOFO/iEZy0WT30GyR9mzbnV/kggt55eJ6WmW0kpHEmYuVoSqUlN+4dE
         nifW1MKspe7TzK1EYStYQELIzqpKLLdwgPrx0oe4SWRr9PC60r7s0S36ZaET+I1sEbtn
         b6Yg==
X-Forwarded-Encrypted: i=1; AKwUvBxrrYsnX22aUCaV45qCPVGaDwL5FSwYQHGro/8sXO8BJtpQPCPKFaUHC3GTfBIQF9QFatei6zOY/BJC2wtn@vger.kernel.org
X-Gm-Message-State: AFuF++nTrT1rQmEKU/NY0Ojgkr1wyxV9BhhldsVd0Vi8zSTpjCntFShP
	Skw8bcSbeebdfehfAYBuZ1JFmfbVouQMbU8lhpPkqJp1oUt8689yqQ7l
X-Gm-Gg: AYBFou2Jl8b72o/QE1MF56J1B0mb6odtRoqXOIkiZvxMg+LyPhU//ISgXy2m7VhTOlK
	prqqjymxDYxYUrblDlPAt8bxsL2T3B2Fl/7Oll3dHT1h2qlJ1SORx1QlGkp5H+BqPa172MxF0k7
	dDrN7aGpxmzEqaW0r+MlXEDd7e+XO04sYT3GsgtO8FXS0V0gBDNHCJc9TOSzGyEqOB0FEjAqK0n
	UBFg3EfshInleqkyfqsfAMhfqeU3hiUx8fGsTdHJEUo8Rid9tCHnAcph5e6AFDEG6Ipcm8vQiKw
	fXWmyqt5Io8NhUPwSW236gAp2BbsfnqpFFAAG35YdMZy+UzS6Ubi3ORyb3pqLQ5RpCbW5SPAs6p
	TGT+eKETw5KRUtO92QTj39sUPT0Ga4WLGgbb6n4YOQSNMe3bwpWdc5d4xrYys68fj27nVyOuU0F
	LxkhQ0fLJea5IKZBq5yorPnLy/phtYWPwjF/azu6vW4mI0XMNtwpnzXTSa0fGIsRh16J3sK8d8h
	ivqA8eLyD9LMPM5Kcw=
X-Received: by 2002:a17:90b:2c86:b0:39e:4c80:f67d with SMTP id 98e67ed59e1d1-39e4c80f73cmr236031a91.28.1789648364901;
        Thu, 17 Sep 2026 05:32:44 -0700 (PDT)
Received: from [100.125.248.95] ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35d9869csm5164981a91.4.2026.09.17.05.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:32:44 -0700 (PDT)
Message-ID: <997ebbdf-efc9-4dc2-91ee-254c66176c32@gmail.com>
Date: Thu, 17 Sep 2026 20:32:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mm/truncate: align truncation boundaries to
 mapping minimum folio order
To: Zi Yan <ziy@nvidia.com>, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, hughd@google.com, baolin.wang@linux.alibaba.com,
 willy@infradead.org, jack@suse.cz, bfoster@redhat.com,
 joannelkoong@gmail.com, djwong@kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, chengzhihao1@huawei.com, wangkefeng.wang@huawei.com,
 yukuai@fnnas.com
References: <20260916092450.654408-1-yi.zhang@huaweicloud.com>
 <20260916092450.654408-3-yi.zhang@huaweicloud.com>
 <DLH1V7L6ECGU.3AIRGWUODR779@nvidia.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <DLH1V7L6ECGU.3AIRGWUODR779@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/2026 5:14 AM, Zi Yan wrote:
> On Wed Sep 16, 2026 at 5:24 AM EDT, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When the mapping has a non-zero minimum folio order (min_order),
>> folio_split() stops at min_order instead of order 0, so the sub-folio
>> containing a split point stays aligned to 1 << min_order rather than to
>> a single page. The original boundaries were based on page granularity,
>> so either boundary could land inside the min_order chunk at its edge,
>> and the truncation loop would drop that whole chunk, valid out-of-range
>> tail included.
>>
>> For example, a 64K (order-4) folio with min_order = 2 (16K) punched from
>> offset 0 to 36K:
>>
>>    split @p0 -> [p0-p3, p4-p7, p8-p15]         # non-uniform, min_order
>>    folio2 = p8-p15           # straddles: p8 in range, p9-p15 tail valid
>>    2nd split of folio2 -> [p8-p11, p12-p15]    # success
>>    end(old) = p9                               # BUG: p9 inside [p8-p11]
>>    loop truncates ... p8-p11               # p9-p11's valid tail is lost
>>
>> It has gone unnoticed so far for two reasons. A non-zero min_order is
>> only used by filesystems with a block or sector size larger than the
>> page size, and those either always write back the affected range before
>> punching a hole or truncating, or they carry filesystem private data on
>> dirty folios (e.g. buffer_head), which makes filemap_release_folio()
>> fail and folio_split() abort with -EBUSY, so the folio is never split
>> and the old start/end boundaries remain valid. The bug only becomes
>> reachable on paths that truncate dirty large folios without prior
>> writeback and without filesystem private data, such as the upcoming ext4
>> iomap buffered I/O path.
>>
>> Align both start (rounded up) and end (rounded down) to the mapping
>> minimum folio order so they always fall on a folio boundary.
>>
>> Reported-by: Joanne Koong <joannelkoong@gmail.com>
>> Link: https://lore.kernel.org/linux-mm/CAJnrk1bQYUe6+1ryyJur5EEnZYrC+_5AYsy=OWzVRgD4202y1g@mail.gmail.com/
>> Fixes: e220917fa5077 ("mm: split a folio in minimum folio order chunks")
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>   mm/truncate.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
> 
> This should be the first patch, since Fixes is older than the one in
> patch 1.
> 
> It can adjust start and end in truncate_inode_pages_range() instead,
> since shmem's min_order is always 0.
> 
> Something like below.
> 
> Am I missing anything? Thanks.

Yeah, this makes sense to me, thanks for your suggestion.

Yi.

> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index b58ba940be474..803ee61ebf624 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -374,6 +374,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>   	int		i;
>   	struct folio	*folio;
>   	bool		same_folio;
> +	pgoff_t		min_nrpages = mapping_min_folio_nrpages(mapping);
>   
>   	if (mapping_empty(mapping))
>   		return;
> @@ -395,6 +396,10 @@ void truncate_inode_pages_range(struct address_space *mapping,
>   	else
>   		end = (lend + 1) >> PAGE_SHIFT;
>   
> +	start = round_up(start, min_nrpages);
> +	if (end != (pgoff_t)-1)
> +		end = round_down(end, min_nrpages);
> +
>   	folio_batch_init(&fbatch);
>   	index = start;
>   	while (index < end && find_lock_entries(mapping, &index, end - 1,
> 

