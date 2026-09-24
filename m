Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9342252A
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283220; cv=none; b=OSxohgMfcxXb2BG/T86D621F1ZkDfT4LVvZzfu9tWlDaYeJt5gJxFOdvkmQ8sQnL3Y2iZpgMwA95m9JtDPPZjsoa27dfrgPlI7fZKaJqN6EAA70+nHbA09M23FHks0aDjQxwmHoQUQ7DngrEvrz1vOS0VduhJUhPdYxsySU8NRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283220; c=relaxed/simple;
	bh=snibvCpdyLK47vJrQTZF6lHl0KzyTNPWkHV3xq/eSbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4xvsyIk42Gwsy1EvNHn2ZVFdrIP74ZkJf1mfsfKRYycpCoo0lxYX2plgtIRDbTg0KEqolpOduiAQ0cSCZTIeOGNJL14yOYGuyMFI14usXbebGaVadWro2JUhqT4ymImzPrVsP6Luhs898hfop6tTO96xG0zThnl94EkXXGs5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJS73yWH; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJS73yWH"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e33b917so146343e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790283217; x=1790888017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2OL9DBw0DPlzOjqc4PYZYVQ5oXPU82nMigXCHy4HrZU=;
        b=mJS73yWHXVZsYkmZDzgkgXGDgXKn9wHQb/qb8Yju8CP7ZH1Cg8ZcErenhEZhiprMT1
         mt/dAJc7cXpXxNcpOQdH1TXplW8WPlSf0qGJgpG6qD3oFlLPsyDZKk1estJuJLeJ3y0B
         BuxG8CXllq/L/ry4GrdjPDJ4dBp1U6asn8M/DKCAWDn7Gb7IuZRnasmErTR3pGoJC+H/
         ZwF4TmCk4ZHvXzyaX+fkw9SOkRsAaNvEU767R9pHrt4i6VTligo+ME/P2/Fn97IRIPv7
         mCxLhnBnxcCE3afKfCkLPz0P9afDwkIp2jdwgu9LGOY/rQ0IK4kzF/lFu2CBhkFFZ7cb
         Rrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790283217; x=1790888017;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2OL9DBw0DPlzOjqc4PYZYVQ5oXPU82nMigXCHy4HrZU=;
        b=sBmuB4bRG3PX0lu43JxmNTKeDSHndyP4u4p1AWueTb8RoicQICVrGEe9wpvRPJ7ITd
         7ldnoKglnppOkOATcNmneRDy3fv/qAPHvF0J+uKKMyNjv/lbxmEfLhcenpCCNudF5Iza
         uIUZcM63Xt90ucO9dvEh6FUIPcAzzMwq+fh5O7lcYEsgtq5W87E3kz95bPbZgxL1e6Id
         dPrDlfck/ZL8Y5fLB3rnMqtWExIIdW4Fkxrm7KmNsdr7EvpUMHyZoPK9xszOvsZY1bvO
         qRtYmDfo1BrK84olOboRRoPIC2SysdSvwqhuEEvipZ4hIsEcGKveuqSFFlvQ7zkxOBoQ
         Jg1g==
X-Forwarded-Encrypted: i=1; AKwUvBy/XT6ywlnSGRM3Sm/Dix6Msl+gXNMKn8hOOMUUTy0OpXrDNZzNxss/yJne5t8d85AQZzI9OkzIv4a3GV81@vger.kernel.org
X-Gm-Message-State: AFuF++mVyx+nsoBogePpF9hgomPMPMmxtgpJndJlnkXHm/45nrzekq7d
	/u3aUMvV+BQXshgWAY/Sfrmf0NUV58OjkxNqSkcFjMltDkDx9tBcI4qi
X-Gm-Gg: AYBFou1EGIPN3F9Rai5BU5bMEoiIjQWF2MPqKJnaWgoMaaE9W7htcFlNnBmS/2fDvMg
	XYkyBwq76TKRWNrkDb/IIfbqANHqXazFnTUY0n9pLoglUsUknqSFdsEI2ZfAqvXbyecwduWwFqm
	WhkH27VdCalhCsGOaElkSErDksEj8/it9aw6ciya4MltZ68+g9KSp4snAxylBslqadrc0XKkTVg
	7Pc0sKrmrld0yopmSEK7Fm2MTX1KE2hXZBFQdbR1BGh8nRgGn+To7YQVC233tyWVj6mZ9tdoKIs
	Lvcv2a1Um86od86gpKZPOhvrY8HsRhLLcdoPo+wctFFDm66AdEe0s/TTnaM6deEkU5syfSc8oh0
	ySgEqbDZAqTjVgnxteDjWid8eXtlj/Mu5GIpiHol7AhPX5o7DjZ1uQZO9r1QlJhe7Xe14iZnI0y
	cjrGptXChsV9gzNabewHoToyPf3k00Cm6vJYONTGuOhuhua6XLX5S/IMfwPca9LjtWRoIIZuc5q
	Go39NxXzH7BHJ3TzFq9TJL4Sdtoeq8bflC9ZMFy2DzS64Z+FLOv+0WrIoYUrbtz444=
X-Received: by 2002:a05:6122:338c:b0:5c8:46f3:8d26 with SMTP id 71dfb90a1353d-5cb09affa37mr2266475e0c.8.1790283216931;
        Thu, 24 Sep 2026 13:53:36 -0700 (PDT)
Received: from [192.168.1.23] ([138.122.221.5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc65d665c4sm605001e0c.16.2026.09.24.13.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 13:53:36 -0700 (PDT)
Message-ID: <c183f03c-86c7-4302-8390-9a75a7cbe0da@gmail.com>
Date: Thu, 24 Sep 2026 17:53:32 -0300
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

Thanks, that makes sense. Sorry, I missed that point in the previous
revision.

Using struct hfs_find_data *fd will make the helper interface shorter
and also allow the validation to stay in one place.

I’ll update the helper to validate the bnode/tree pointers, the entry
offset and length, and compare fd->entrylength against the expected size
passed by the caller. Then the extent path can simply call it with
sizeof(hfs_extent_rec).

I’ll send an updated revision.

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

