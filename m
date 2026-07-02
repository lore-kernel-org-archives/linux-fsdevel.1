Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F8433E7C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003921; cv=none; b=LOo66kqLkNPHXBdeH1hDE+dJGxrZ4ihKMGlRp+H+ZOXZaa0+fdzQ8aYL8F7cckMCKDCKSMz33tdmZI8Z+Gxo4/XNtLroil2YAYnQsDy8LXo8tyGl9bZskPjM9V5WX91dwayWM8/Et+6LS+p3Hg5X1NxmRW1sQ+2i4OFrnu7DNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003921; c=relaxed/simple;
	bh=NzdDlTDtaGZcoAJ9/MP8h4qe1GlpMNLTmaatim477dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J32nV3pnTBbXUiq+SQMN86Y0MpnykrPgZcVre5oQFy9YcLN8jvFTWMfa9kfL4VyM7kRAYXpzRIju7FcIxdmJkYXmVpviAIocDMMfyX2KGm/EqLrfmOagIfu0ThLLjCyNNB84njKtcr1e+bOmDJgqDqbEZVbCPICJb0k0jsFAe0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXscY5Ja; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXscY5Ja"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso18095265ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783003918; x=1783608718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryZRiX8UMkJ03DIEk3V2Skg/TXE/FZOpB+Y8RQGEeeU=;
        b=gXscY5Ja7coF3tcTzz7cb7W/KUI+032/WloJ2+QNMo6SPruLIukqyfY3dnUVyKmrDd
         V7n6jC/z483kuDxfW7au2aiLuZ1U67amxmY0ltk4uRlmlTLVuVv9lyr066GjM5ym4hyK
         bRkfpUElJQYDshqS4+M0UFfUyAB0TYGMTB/BW7EC5MBRsM4fsuDSwaG0Vhzcxkjm5PIn
         SLohuhDL/X0hRI6vfNpgPXb/FLLXoLL3rfC6LVJZ1jgd9D6kYNScV6b8YP+4ppEvRpc2
         Gz4y5aAUf+qr4gfoKnIh6FtaYzz/aM5jKDJMHRrgKeDcwlmDaiEQXZmECDqJ0gudoKSm
         nezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003918; x=1783608718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryZRiX8UMkJ03DIEk3V2Skg/TXE/FZOpB+Y8RQGEeeU=;
        b=dzb9ZqGWlSuSQQYzlK4LlG1os52Wl4v/hFdwnNlzbAyJhW8DByAI+JGHQy256M+58K
         WD/O9eDwxh1soZv8wT/Wj4RdUT7iByuFpUI68snvyCOfr6JkwxgBNFpOnwS5EKZVoN/y
         rubBtf/eESCV3HAkF8uyAhgKGguT8hFF8S/yxfK/DpxgbhtAMUeqAIi9Pju9xcu+5PLL
         0Oc/LlUNNSQDPDNUeSwseqljVNnLdmaUFYzCWxumL4A6MGwIW6x16jCaButw1mbTTeT/
         Z/ATiThw9ivozGLiOgWTU9+O45fNpW91PARaoIzoDo/uGbm0SOEL/32ag/51lQmFrvS5
         tsbg==
X-Forwarded-Encrypted: i=1; AHgh+RqD3nMguY7hyNrBpQDadzR1oypr2czki7HmVoDPxgGU2nMx9VxiLALTMsnpjv7LaIC3AxHKl0sPpIq27+yC@vger.kernel.org
X-Gm-Message-State: AOJu0YyVi+3ElP+X4boxz/IexiNns1OVQIArMAIytpbiocblVvZ3HEVM
	QQh5SVPaaQB05CGuY5apJ9CuJ+9puKinRqS2dWhL8SM48w3ZXvpZL1MG
X-Gm-Gg: AfdE7clLF+ujecQtYdsa7STRiZUgpk/KZFHTfCcpA4XHbBDgFnUjAA4/Wzqmpti5dTS
	zKNJpO1V8W9WxNDXjPD5+mXtOidgJ7ILcweKbm7vfKOPelnJnksMMcaifKaIP/hKuV5kbWaS009
	/zrK4KWPyyrDe5HIGffeSdczibzvq0ZaE/aVMHMDshfun4FHlF6gomWIW+ac84lpE8M26MIX3vr
	zUjwFLKu+kQw5Dp40arK3taWc8hSQ3TcbjzyV/hpDOdPKBmi11+7WrEcdE7yK6f+8aMzwx3TP56
	K3JDQBJb1pFDxFqHmEeO1aRe9JLBr4ekTUsSbGg9Wj+JtkPYkr6yPzGcmS1J9M8844CQ3Q7tOQf
	IYoTU8Vl8tG9FLHOZq8AiX3cJwpGvfj7q94WrE33XffXG2NK1wWUw2cTX2P1wqeAEc/YyXcTPF1
	3Gs7aEnpzmDFqTtWoI2Hfq9L29z0julXGBrpRu5ESWqpb7QvZNHO9/r4inLJIl
X-Received: by 2002:a17:903:4b27:b0:2c9:fee9:543c with SMTP id d9443c01a7336-2ca7e75cee2mr67290825ad.30.1783003918144;
        Thu, 02 Jul 2026 07:51:58 -0700 (PDT)
Received: from ?IPV6:240e:390:e4a:af91:e858:9955:9be:dcd0? ([240e:390:e4a:af91:e858:9955:9be:dcd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9cd35esm14519065ad.41.2026.07.02.07.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 07:51:57 -0700 (PDT)
Message-ID: <b6d2b697-07e6-4ea7-b8d2-85491a0e63df@gmail.com>
Date: Thu, 2 Jul 2026 22:51:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] ext4: skip ext4_update_disksize_before_punch() in
 WRITE_ZEROES
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 libaokun@linux.alibaba.com, ojaswin@linux.ibm.com, ritesh.list@gmail.com,
 yi.zhang@huawei.com, yi.zhang@huaweicloud.com, chengzhihao1@huawei.com,
 yangerkun@huawei.com
References: <20260701142009.1510104-1-yizhang089@gmail.com>
 <20260701142009.1510104-7-yizhang089@gmail.com>
 <3f6ao5amv7glbgigndtegcucgo3n34ij3lau6l3da3hgdxgn3v@ev66wv3r5umt>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <3f6ao5amv7glbgigndtegcucgo3n34ij3lau6l3da3hgdxgn3v@ev66wv3r5umt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/2026 6:19 PM, Jan Kara wrote:
> On Wed 01-07-26 22:20:09, yizhang089@gmail.com wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> FALLOC_FL_WRITE_ZEROES is mutually exclusive with FALLOC_FL_KEEP_SIZE.
>> In ext4_zero_range(), when end > i_disksize, new_size is always set to
>> end for WRITE_ZEROES, so the i_disksize update should not be lost.
>>
>> The ext4_update_disksize_before_punch() call is only needed for the
>> ZERO_RANGE path in ext4_zero_range(), as it handles the case where
>> KEEP_SIZE may preserve the original disk size. Skip it for WRITE_ZEROES
>> to avoid unnecessary work and potential confusion.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Hum, but suppose i_disksize is before the start of our zeroed range, i_size
> is beyond the end of the zeroed range. Now
> ext4_alloc_file_blocks(EXT4_GET_BLOCKS_CREATE_ZERO) will create some zeroed
> written extents beyond i_disksize and if we crash before
> ext4_update_inode_size() runs, we have inconsistent filesystem with
> written extents beyond i_disksize... Hum, actually that could have been the
> case even before, just now there are more cases where this can happen. So I
> think FALLOC_FL_WRITE_ZEROES mode needs to add the inode to the orphan list
> to truncate the inode properly in case of crash.
> 
> 								Honza

Yes, indeed. I overlooked this case previously. I will address it in the
next version.

Thanks,
Yi.

> 
>> ---
>>   fs/ext4/extents.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index c083703bf704..38753c2ef910 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -4748,9 +4748,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>>   			return ret;
>>   	}
>>   
>> -	ret = ext4_update_disksize_before_punch(inode, offset, len);
>> -	if (ret)
>> -		return ret;
>> +	if (mode & FALLOC_FL_ZERO_RANGE) {
>> +		ret = ext4_update_disksize_before_punch(inode, offset, len);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	/* Now release the pages and zero block aligned part of pages */
>>   	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
>> -- 
>> 2.53.0
>>

