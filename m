Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631864B95C1
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597424; cv=none; b=KZkhpeGcl6tkoTS2gPYxHQPRQbx80hVyDROrRib+EWOgYvLTSWAuGaX6VGX/BmYdBIEWGQiR/rScEt9Aob7lEs+8NGkmI/Av3hrqMQWtBaNVdwg9SIYk1WVylbUmft24ts2Y9NFriMovypzPf5qYiiPeCd7C063FwgfE5MV6JKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597424; c=relaxed/simple;
	bh=dRu7Kn49A03hqpkganvlzxpNEYuOOLrk6BWNQL5j5yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jz084FHzp+M5bWYq81loQSg7v1/4Q1n8i9H5EQWqmbZ0W0lNf7rwK7vU/O6dbudvt4IZA+lS1TgrJ6c6ar7lOptuwH1Rixa8v+SLlHPx5u5gTf+qWpb3mhrjioGvWIqpRRYdBj6zV/t7Id02hbwl0O9i1988xe/W3qTCsLODDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyCQClIo; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyCQClIo"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-8807e5b8fa9so1654373b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 05:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790597422; x=1791202222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2gttpqyYU6mN3+vG6WWAdW+b+2S6eD72/pblRbqkM0=;
        b=jyCQClIo3AElUAT17p/0KgHrvYT2Om0M9F60+rFRfvS5uy6jckKuetSU+twm+bXrt6
         8uyyghCQptypfw/PRpca5BDL/I3OhN/7kOAZWtFcZ8HjRtSXHyv/YapZo+Jv38+duMxm
         6s8sCXXqPLJINgxS+Q3H/tz4FRu8Kf5WFksl3Z8P6QFgXdKj0M37QfovK3Auco/jOjMb
         WuSK45TTsnPrRP4EucIhnoLvc+czM6Wia1Eq/QPsv7suTKCvuEZWgeEGU3bfJFeSXySD
         C0f4OoEry1feLkS8kGu+uADBnWPx4mmfWbP7oyQv2qX1sZnvTLFYdkKXMsHqhHXRR1vY
         2Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597422; x=1791202222;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2gttpqyYU6mN3+vG6WWAdW+b+2S6eD72/pblRbqkM0=;
        b=G3k2v3D2ifl0eGbMDaakyCqELpP4HtimFrjCKMSg02QZzm9/z+m0a+6mrv6OAL9aRl
         EkO2U5YeOePUslswLvCarm5KkkscEImgXdpSS58vmy1EA5hRS3wtmqTvd549ad1SE7Wd
         W7iNCcbjKx1r+zi8NrQmCy+6Emug1sZkAioRBh1uo/kbU2lvgsa5UDiDgjkuuPPk4KSX
         EE3BPEY8i39Lrxc6VZ4qoOEF8LaRHZa2zaYzh7EH4ShyH3UQSOQUwzelmJfDPGWrT7EK
         aFfcFjzpgmi0iGVFq+VO4XcIhoyCaHgFaOnSkUtxhkXV0h4qobODHbKnovEK90zSZU2j
         1FJw==
X-Forwarded-Encrypted: i=1; AKwUvBwYmmlH7sg+Nfno2x9+e8tFwpATYdvFfuXcUrAGgCborB/mxDdFjjOztZOvxo0kOBYfMss5Y3qsYUZrkbYe@vger.kernel.org
X-Gm-Message-State: AFuF++mlWib6oyBfyAD+fJmfbwBhomSIUYGaunUsd6k0FmpnDVc60Gc3
	ivk+CVM+KZS2j/nqv1FPIOcpRlFALGgVcczNwO2OmwcRuD2vVUcU2XO5
X-Gm-Gg: AYBFou1eeQaqprqgM2W0b1MR8BPF46yazQlUU/Jf+t9+A3YumuE5m4siIIuzD19fGaX
	DLcZJw3BMsn/OA45HslRExXmccgOkxy8RKeRhPmWvPH+JpbwhihwZMxl2eASZ6fmZ6erHnMUZt1
	cf8cfDOc6GXRfjDMxNZ4nBSFn5roAd4TIp2TkmSFqN+Q0eyYke9j7yUnmdpR+YTPfjaYgxureWY
	a+3zq7L78NaHWOa2uihzXEsLMhzriwqdRLP5Qri8EEO1DyaH06WvRR+4yOw7Ad1gMrLVCD2aRCT
	eWJZ2BqedErjLnRFaemEXTvibW/Cw4Usvli3Kkerk2N/W33EzUknnVUYUAdkxLYfWxb+iIkbCkX
	lGYUWajvAyHBg+58MNz30d12lzPGL0bY5nM9FYcZKyYd/UTRm/hjPJdHku7iU+LE0fkGnZsJfOj
	kjwFioFS2miH1+wj5C/3zurHnfvqdYN3x7eBJjtdsTsjaUYffqXJWk5DQapb/03/0G66uSDmeg1
	mpJwNAaFLbM6imIvOJ5Yz5XXIOanA==
X-Received: by 2002:a05:6a20:2d2a:b0:3dd:a196:69df with SMTP id adf61e73a8af0-3de26f28bffmr7894235637.58.1790597421493;
        Mon, 28 Sep 2026 05:10:21 -0700 (PDT)
Received: from [100.125.248.95] ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feaf85551sm4001370b3a.40.2026.09.28.05.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 05:10:21 -0700 (PDT)
Message-ID: <e3b38169-dc4a-4a42-8a42-b017ecff73d4@gmail.com>
Date: Mon, 28 Sep 2026 20:10:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/31] ext4: skip block allocation for holes in the
 data submission path
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 libaokun@linux.alibaba.com, jack@suse.cz, ritesh.list@gmail.com,
 djwong@kernel.org, hch@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yangerkun@huawei.com, wangkefeng.wang@huawei.com,
 yukuai@fnnas.com
References: <20260903123543.2302999-1-yi.zhang@huaweicloud.com>
 <20260903123543.2302999-10-yi.zhang@huaweicloud.com>
 <arpDP43MIAGjaWYx@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <arpDP43MIAGjaWYx@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/2026 6:36 PM, Ojaswin Mujoo wrote:
> On Thu, Sep 03, 2026 at 08:35:21PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When ext4_map_blocks() is called from the data submission path and I/O
>> end extent conversion path (EXT4_GET_BLOCKS_IO_SUBMIT), it should not
>> allocate blocks if the lookup returns a hole.
>>
>> The writeback path can legitimately encounter dirty ranges that map to
>> holes. For example, when a folio straddles i_size and the tail beyond
>> i_size is dirtied via a mmap write. Allocating blocks for such ranges is
>> wrong because there is no data to write back, the dirty bits should
>> simply be discarded without submitting I/O. This prepares for the
>> buffered iomap writeback conversion, mirrors the existing buffer_head
>> writeback path, where mpage_add_bh_to_extent() skip unmapped buffers and
>> ext4_bio_write_folio() clears their dirty bits.
> 
> Looks good, checking the iomap vs bh head logic. If we consider
> a 1k bs FS with 4k page size, with hte following ops:
> 
>    ftruncate(fd, 0);
>    pwrite(fd, buf, 1024, 0);
>    map = mmap(NULL, 1024, PROT_WRITE, MAP_SHARED, fd, 0);
>    map[0] = 'a';  ---->  mkwrite allocates 1 block and dirties the whole
>                          page
>    ftruncate(fd, 10000);
> 
> Here both non-iomap path (ext4) and iomap path (xfs) will allocate a
> single block but both will mark the whole page range dirty in bh/ifs.
> 
> In both iomap and ext4, while writeback, we skip bhs which are holes,
> and we clear dirty on them as well.. The only difference is that in
> iomap xfs_map_blocks() shall detect a hole and inform about the hole but
> in ext4, we filter holes out before the map block call.

Yeah. In the writeback path, almost all of the work is done by a single
call to ext4_map_blocks() now. This makes the writeback code look very
simple and clear. :)

> 
> So with this change we will be closer to iomap's behavior. Looks good
> althought it's unfortunate that IO_SUBMIT has yet another implicit
> behavior added to it's scope :)
> 
> Feel free to add:
> 
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
>>
>> In the ioend extent conversion path, holes are also not expected because
>> we should wait for folio writeback before punching hole. If one is
>> encountered, it likely indicates a failure in the concurrency
>> protection, so ext4_map_blocks() returns zero, and we keep warning and
>> bail out with -EINVAL to surface the failure rather than continuing
>> conversion on torn data. Atomic writes in
>> ext4_convert_unwritten_extents_atomic() already bail out similarly.
> 
> Ahh that's right we do bail out but we don't seem to be returning an
> error in the atomic write path. I think ideally that would be the right
> thing to do. I'll fix it, thanks!

Indeed, thanks for fixing this.

Yi.

> 
> Regards,
> ojaswin
> 
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>   fs/ext4/inode.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 7a5c74af8ff3..2881596bff8b 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -825,6 +825,13 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>   			map->m_flags |= EXT4_MAP_MAPPED;
>>   			goto out_handle;
>>   		}
>> +	} else if (retval == 0) {
>> +		/*
>> +		 * Do not allocate blocks for holes in the context of
>> +		 * data submission path.
>> +		 */
>> +		if (!map->m_flags && (flags & EXT4_GET_BLOCKS_IO_SUBMIT))
>> +			goto out_handle;
>>   	}
>>   
>>   	if (!handle) {
>> -- 
>> 2.52.0
>>

