Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1A4B7A5D
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596664; cv=none; b=TefUoh0qzpiBfzfF4PfRqZKn5lzvy3FANSnISNkhDc50RSVMAPpVy/SdcRkispPBH205guKshdrmKneetJXGw1RD3iQPyALlHrazB5wlO4aU/9R7UEuug9MTVRuM6GqIawQB3KAmlRBXOil3P+6tX7SOPr4M35Dpzbj43Uaxlbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596664; c=relaxed/simple;
	bh=r3puRPhMmBtKKfqB3F2kZ+pMBLHUDRnlSFFiHevX7BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYME836Psuu93WZnC9HYkczx7e6zhORFuYzIUXO6VbfGE5MxqK3hA/YVGjU1ni+wzNrXfUac+fhW99QVwhG03S7VJfTsbG+zMuZ+7Op/eQQWxDREegNd4lvcUNVcpk8h3s+gVZV9mFrxC21rZZTsG4kmRPPTcp2MkR0L7ltU8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJhlIgvm; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJhlIgvm"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e69so720406a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 04:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596662; x=1791201462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uznnGClxpoNxhfkd79ZikolqPxxdalAG+z6oc7/n6sw=;
        b=nJhlIgvmMM6qT8Rn+B/S3jByqrCvylSpJWrbeVoYGvYQL4hXRq5tKVN01FO6SFVOUS
         O6BPMo58k+SA+PJGrOC/2/LUyUt5eXvJpgCJEwgFb0uNPuC7X8zqTq5V0//kMQMNqRKI
         pVOF58DkFPDrPq2uKIPd3AL56DehROE75ACnRU7aPVzXcQAJgHgpdFDW+G5Gm0AvN5hi
         vjjmjPbhtTOuDz6RN/0eCs9NgxWKygYX6QUw9obJzazw4s2EDswQsgKUIJ3WEtGY4b6k
         hoYSaa/uXvGDxgGcL7TYYUQ8bw35NkPAmEc70PENBfePsejaG+SUrTMVMideE1Ed4RNc
         nuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596662; x=1791201462;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uznnGClxpoNxhfkd79ZikolqPxxdalAG+z6oc7/n6sw=;
        b=sQuq516upRvEhd77S80Vd/08+3VK8MFk0BrNe25Ef0Iomgq+G95ScQQY7FQJsznLAg
         A0cwL6RwUtiU4zGC9TOvR/f862jGMQdxqeFRz+nLQ/nYrxzx3ySQvx0iL6euKCEIxIV4
         oeaeSLXafk+9ZI0rT5Z2IYLXCXkMQMWRAMjWAt1cWlotnigOQ/T/bFtmmFVnlM1hbsaH
         KBhiMkhwMrhc+NKiDF5z0RSXTdxuTFCxCQu1XpLksGCXdqd4iFRl1jdUgvboX4VRY46d
         Ua6xlK7VKjFcQHOtn8L/fhvEQ/EOpGL4gP2JklPmaHlIA5YRIm5eTrZ+GwLSgfyV54Om
         Eolw==
X-Forwarded-Encrypted: i=1; AKwUvBwBbNG1+pot/LeYDsL+xLi/hcBvgYPo1yESDxa7VWTahFETk6WwRV/k+VZupLexTR9BtUZk5uls6viOeVD1@vger.kernel.org
X-Gm-Message-State: AFq9FYKg71Pqwv5ITFTUj+ty9LU2UT7imZ3/GY62t2H5R1SExr5G86I1
	Km+mRNF86O1ccx95x9IB3ZXBtQzfqvay8kJwa6GTXbU5o9jeTf8awRZs
X-Gm-Gg: AYBFou38FScoB9jP7+WNyhSJMcfjpnQ5efJjFjLymVjzcY9p7HS716qPNvEfs6ktHxT
	I4fNY4bQFN27VANtsP82dP20tifvYiQc55nYESyiin4X1QcZOnM385xxqTAeAq5NOaVYImGHkU6
	Eu/xKoUZy3RCALKHtG88Mam9mEbppcOhwIVXFu5rAMLoxJJo/ktmlHt90cSamz5gReKVu01iyb+
	IT4RXGLK+zoYyMZApvwxpJnDhzJW0udnc3f+YNsiSMlQWc0LdtahvAS+bDJO99XcDLy6Zrxb0Or
	la1WZj46mUsCYiT11gsGY+5hDWZAqrsR5Hens+l4LLrL8eUVcsAyeOqy+3kpzJTX+OAfaPRriIc
	EZIpwEYzrnvSM1eG5iwfwJEmztmQ7yCIh8NJDwgd5AcRx/LVq1D+0/8Gp+0ahMLhOUQ08z/qRVd
	JfcFYZUxOBiEjO0O7yhomEeJgGlQY+QS3TbZCDPhg+2i5GrVGLo7B4+PRUH1fbTrCust0Zx6K9Z
	nEfpmrW9aH5uFx2X0U=
X-Received: by 2002:a17:90b:53cc:b0:39e:6c6a:2096 with SMTP id 98e67ed59e1d1-3a098970bd7mr10676652a91.55.1790596662346;
        Mon, 28 Sep 2026 04:57:42 -0700 (PDT)
Received: from [100.125.248.95] ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b99e5711sm19979522a91.17.2026.09.28.04.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 04:57:42 -0700 (PDT)
Message-ID: <214177f4-11d1-47f9-94fc-2fc679911b13@gmail.com>
Date: Mon, 28 Sep 2026 19:57:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/31] ext4: avoid unnecessary transaction in
 ext4_map_blocks() for unwritten extents
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 libaokun@linux.alibaba.com, jack@suse.cz, ritesh.list@gmail.com,
 djwong@kernel.org, hch@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yangerkun@huawei.com, wangkefeng.wang@huawei.com,
 yukuai@fnnas.com
References: <20260903123543.2302999-1-yi.zhang@huaweicloud.com>
 <20260903123543.2302999-9-yi.zhang@huaweicloud.com>
 <aro_npJ95b4Nf978@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <aro_npJ95b4Nf978@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/2026 6:21 PM, Ojaswin Mujoo wrote:
> On Thu, Sep 03, 2026 at 08:35:20PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When ext4_map_blocks() finds an unwritten extent in the extent cache and
>> the caller is willing to accept unwritten extents without conversion,
>> there is no need to start a journal transaction since no metadata update
>> is required. This avoids unnecessary transaction overhead in the
>> upcoming iomap writeback path when overwriting already-allocated
>> unwritten extents.
>>
>> One thing to be careful about, as the comment in ext4_map_blocks()
>> states, if the flags contain EXT4_GET_BLOCKS_CREATE, the function will
>> mark @map as mapped.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Yeahh, I had something similar in one of my WIP branches :)
> 
> Thanks for taking care of this. Feel free to add:
> 
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Regards,
> ojaswin

Hi ojaswin,

Thank you for the review! The fast path implemented in the current
version is missing check_block_validity(), I'll add it in the next
iteration.

Thanks,
Yi.

> 
>> ---
>>   fs/ext4/inode.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index c9dea4ca5caf..7a5c74af8ff3 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -809,14 +809,23 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>   	 * Note that if blocks have been preallocated
>>   	 * ext4_ext_map_blocks() returns with buffer head unmapped
>>   	 */
>> -	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED)
>> +	if (retval > 0) {
>>   		/*
>> -		 * If we need to convert extent to unwritten
>> -		 * we continue and do the actual work in
>> -		 * ext4_ext_map_blocks()
>> +		 * If we need to convert written extent to unwritten or
>> +		 * convert unwritten extent to written, continue and do
>> +		 * the actual work in ext4_ext_map_blocks().
>>   		 */
>> -		if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
>> +		if (map->m_flags & EXT4_MAP_MAPPED &&
>> +		    !(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
>>   			goto out_handle;
>> +		if (map->m_flags & EXT4_MAP_UNWRITTEN &&
>> +		    (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) &&
>> +		    !(flags & EXT4_GET_BLOCKS_CONVERT)) {
>> +			/* Contains EXT4_GET_BLOCKS_CREATE - mark mapped. */
>> +			map->m_flags |= EXT4_MAP_MAPPED;
>> +			goto out_handle;
>> +		}
>> +	}
>>   
>>   	if (!handle) {
>>   		handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
>> -- 
>> 2.52.0
>>

