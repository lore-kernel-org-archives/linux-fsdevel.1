Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023530594E
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384975; cv=none; b=i/wr9+tCrauEzTs7UXYMj/hSUX1GCT8qb+nJHakqpTBq3pqe3s9l3g3GiaZNDzrAtLhecUyFpjo8plSLHK4yoC72x64yeYOnuNO26FPVqShqrZI8IS+1w/4+t02wfsgPHEvu08UVtJrekVe0pNzJT2kTSy7F1z5RT4qvoXLeWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384975; c=relaxed/simple;
	bh=eiCd5uwNN6RH/GFD0Omq0r87XiJMZxbzVZDa48WNDps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeweWNyerkKGaAtva20kwNcLkkh4LcVXCSpZujN6pd+UIHzoqxVl9DyCAc3bo75JN96I+SyM/w//t4FdlP1q+pyi4hI5pZ0V6fn3RhvUfie351eKA1qYW+QYEOpWnd8IsPIOW1OAOYNDMUyVSOAgIeIrVgV2Skyb8a/7n1u6YqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEHKVNXT; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEHKVNXT"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d5303884so761448eec.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790384973; x=1790989773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3gFLrYFckZ5XIkN69t9A3jgRQQGtoPYpO5S0Nj1j4is=;
        b=IEHKVNXTUlGeDIvB4OrUZkQLBveYNv3i/YnJkihmJGEgf5zti8UWtTr8IVfXulpoMD
         aSUOGtZCFfh6Q7FWA6XSKxNRY++ER+Y+/eNriXr6Yaq77OANLVaK4gEF4VJgylvBiDsE
         CPGlRK7f4fYFNQxFQLIlzD3mEu8/Kpcffm4C5uCvqgFI7o7SV/ZwJ88JNFGdk1pcTrEn
         abpYLbX4p4jh791b2S4Mrl+UV7+Ih3bNBDsmJu3g20udo5vP40GY+jlu5j3I2Wb3szHQ
         rYjzcSnliZe9L6sDu1NrI2c6HWj/AlcXW1ZADznZy0DFmLLzV+AwFP76LiJ5fWfij8iG
         JcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790384973; x=1790989773;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3gFLrYFckZ5XIkN69t9A3jgRQQGtoPYpO5S0Nj1j4is=;
        b=UhssLjgK56wGatnadAkKWHQlImF90y7FCzbBsSkH+3qGveKf0p5WmTuiQzPHvwiNjs
         Q8qnuh2PpsrKaZCVV6uiEJ4msFV0bElGhB8Bfagbb4A7SmeGpXLIwqNKSbUMBvtujZKY
         6gVIbSvf1rEO7/7wPO5ET5MB4A5CNlsbFh4n2/NAmgZqAjqLLem7/Ozyzwu7s9uflvm8
         EtyBV1/optiDSNH9ZRGDOrYfoisk1RZD9Q2SI3vklIv+OB69gDK8ZnzOBaXa+roVoQIV
         3f18KR0msMObpZ+eaunMvAeCxuEG+OWuR1dWoD1c0luvamcndydXKUn4iW480fTS43wm
         lCBA==
X-Forwarded-Encrypted: i=1; AKwUvByrEHdzURO0+Z22FacSUx+d3gJWTn+zTxQK7wvOzrt0dp9eDQhlNjlYfVy1S6a2h+PhDfqyPb8aLb2FiPpc@vger.kernel.org
X-Gm-Message-State: AFuF++kJqKHtmv+1i93fhzECh5ZZtoNF8jG+yAeGfR+bUfpFYQoqU0KZ
	ywNd5RMa4So2mc9NwdjFa9BuZakTW5fxG0rjYlSxMjwC/vLY9ETNbqW1
X-Gm-Gg: AYBFou0aeRqSNKvDRmj6mUoy21EdK+oDIj2kQsCfpgNfmjJtxcyS2sY/jJf9DQbHdIN
	o6nVZ4moxMRqJbQUGBJcUM5yuRO11/OyWUxM9womwOQRYOwJphomOKLraU4PWNK4fMD2pcvhVPb
	LEjhwMzXGh7lpD5+NJuefmTtMSG9B3DH6cr2XZSWBjkbIBvkZGtpqhTHdjLqzGDKNO10nDuJyhu
	8UagsJVooUu1VC3foJEeEfwF+1lF2bVrfzSth4+rN4mMGFtyysJfyuLOTwpCXX89aveit9JzWKI
	jlKkw2RBsuSTwf1n6TmRzPXfKGPIUA5FHNLssjDRGNpjqb9TkHWLAnf83za6LM6lOzGejxiQkJN
	52PrnL+bqdgOD2nX+NJRlSAcXD9eFHJEyi8LJl5d51Ju9mfyHZHDmxi1XHml9uM2EYeKh3X9ltz
	pbKUnhaIc8ORJOZ1uTL4aAP0kfi9Pc4d1rbbyb4tMvIusKSoRCKgTki9hFPZ25FZJ7JneMWCuRQ
	w4BN5OB6DBBH4u91EdL3TkRy6wTDIMXr8Fwm8jzFXUdZ0UDsuXFIGe+xAvTJ7DAYyY=
X-Received: by 2002:a05:7022:28a:b0:145:77f:293e with SMTP id a92af1059eb24-146d0497070mr1662276c88.39.1790384972895;
        Fri, 25 Sep 2026 18:09:32 -0700 (PDT)
Received: from [192.168.1.23] ([138.122.221.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm900c88.17.2026.09.25.18.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 18:09:32 -0700 (PDT)
Message-ID: <2f83be7e-f37c-4e52-8974-0c37d94a42ea@gmail.com>
Date: Fri, 25 Sep 2026 22:09:28 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hfs: handle extent B-tree write errors
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c569d5f8ee542e5c86a7e4dee23df99f4ec0becd.camel@dubeyko.com>
 <20260924001623.1765392-1-davyfelipe34@gmail.com>
 <9c9fe0c7660ff1cf4fe81bb3b2c907555d8add4e.camel@dubeyko.com>
Content-Language: en-US
From: Davy Felipe <davyfelipe34@gmail.com>
In-Reply-To: <9c9fe0c7660ff1cf4fe81bb3b2c907555d8add4e.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,
Thanks for the review.
Your suggested changes look reasonable to me. Please feel free to make
these adjustments to the patch if you prefer.
I am fine with renaming the helper and using size_t for expected_len.
Regarding the error code, I am also fine with using -ERANGE if you think
it better represents this condition.
Thanks,
Davy Felipe

Em 24/09/2026 16:23, Viacheslav Dubeyko escreveu:
> On Wed, 2026-09-23 at 21:16 -0300, Davy Felipe wrote:
>> hfs_brec_insert() may fail while inserting a new extent record, but
>> __hfs_ext_write_extent() currently ignores its return value and
>> clears
>> HFS_FLG_EXT_DIRTY and HFS_FLG_EXT_NEW as if the insertion had
>> succeeded.
>>
>> Propagate errors returned by hfs_brec_insert() and only clear the
>> extent flags after a successful insertion.
>>
>> When updating an existing extent record, hfs_bnode_write() returns
>> void. Validate the extent record size and use a reusable B-tree node
>> range helper to reject invalid write parameters before calling
>> hfs_bnode_write(). This prevents an invalid update from being treated
>> as successful and avoids clearing HFS_FLG_EXT_DIRTY in that case.
>>
>> Negative-path testing in QEMU confirmed that an insertion error is
>> propagated to the caller. Testing the existing-record path also
>> confirmed that invalid write parameters are rejected before
>> HFS_FLG_EXT_DIRTY is cleared.
>>
>> Signed-off-by: Davy Felipe <davyfelipe34@gmail.com>
>>
>> Sorry, I missed your suggestion about factoring the validation into a
>> reusable helper in v3. This revision addresses it.
>>
>> Changes in v4:
>> - Factor B-tree node range validation into a reusable helper, as
>>   suggested by Viacheslav Dubeyko.
>> - Keep the extent-record size check local to the extent write path.
>> - Preserve the error propagation and validation behavior from v3.
>>
>> ---
>>  fs/hfs/btree.h  |  7 +++++++
>>  fs/hfs/extent.c | 12 ++++++++++--
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
>> index b4c3f2a31471..576412e6901e 100644
>> --- a/fs/hfs/btree.h
>> +++ b/fs/hfs/btree.h
>> @@ -84,6 +84,13 @@ struct hfs_find_data {
>>  	int entryoffset, entrylength;
>>  };
>>  
>> +static inline bool hfs_bnode_is_valid_range(struct hfs_bnode *node,
>> +					    int off, int len)
> 
> You can use struct hfs_find_data *fd. It can make argument list
> shorter. We need to find the node before read/write. So, I think we
> should have hfs_find_data available.
> 
>> +{
>> +	return off >= 0 && len > 0 &&
>> +	       (u64)off + len <= node->tree->node_size;
> 
> Maybe, it makes sense to check that node->tree pointers are valid?
> 
>> +}
>> +
>>  
>>  /* btree.c */
>>  extern struct hfs_btree *hfs_btree_open(struct super_block *sb, u32
>> id,
>> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
>> index f066a99a863b..ece782205b47 100644
>> --- a/fs/hfs/extent.c
>> +++ b/fs/hfs/extent.c
>> @@ -121,12 +121,20 @@ static int __hfs_ext_write_extent(struct inode
>> *inode, struct hfs_find_data *fd)
>>  		res = hfs_bmap_reserve(fd->tree, fd->tree->depth +
>> 1);
>>  		if (res)
>>  			return res;
>> -		hfs_brec_insert(fd, HFS_I(inode)->cached_extents,
>> sizeof(hfs_extent_rec));
>> +		res = hfs_brec_insert(fd, HFS_I(inode)-
>>> cached_extents,
>> +				      sizeof(hfs_extent_rec));
>> +		if (res)
>> +			return res;
>>  		HFS_I(inode)->flags &=
>> ~(HFS_FLG_EXT_DIRTY|HFS_FLG_EXT_NEW);
>>  	} else {
>>  		if (res)
>>  			return res;
>> -		hfs_bnode_write(fd->bnode, HFS_I(inode)-
>>> cached_extents, fd->entryoffset, fd->entrylength);
>> +		if (fd->entrylength != sizeof(hfs_extent_rec) ||
>> +		    !hfs_bnode_is_valid_range(fd->bnode, fd-
>>> entryoffset,
>> +					      fd->entrylength))
> 
> I think we can share with hfs_bnode_is_valid_range() expected size
> sizeof(hfs_extent_rec) and hfs_bnode_is_valid_range() will be able to
> check the fd->entrylength. What do you think?
> 
> Thanks,
> Slava.
> 
>> +			return -EIO;
>> +		hfs_bnode_write(fd->bnode, HFS_I(inode)-
>>> cached_extents,
>> +				fd->entryoffset, fd->entrylength);
>>  		HFS_I(inode)->flags &= ~HFS_FLG_EXT_DIRTY;
>>  	}
>>  	return 0;

