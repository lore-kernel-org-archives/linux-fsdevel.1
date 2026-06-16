Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5611332EC8
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613456; cv=none; b=QZSEnrbkSgwxsSRKUKyd9KQDUs9n6XmaGSWyrPiSg6OLxot+9TChKcbRluIcIJb3Rw85w26WrmywDtNlDBmLszmxw9uC0NidAF1nnz/Sm1EM6Omsjs77gbC3sg/WPEzgiJoVg5vFqC3jUR8CASlbez+mIJkbTAfO63BTtBhNLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613456; c=relaxed/simple;
	bh=ZvStrnl0ZAG5yd8GjM4mvSjKnzRn2kfVylbEyeYZg3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suJJWa3HuKPv+chiTJRuLrFp0lblt37kilsMtMVxmI0Y71nWsfEMt26f4T+4IgUFPKL2enSGUtDDHf1UmpoPh+5LcjE9gEMkwz1I8qKmDfo/vqfJ7TbkGRFnWNlCqxdAF94jRbmWu/gz9tnF8Z+LDd2iQXdZ6lYuMblgYXPA9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rK9kC8wJ; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK9kC8wJ"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1370417c01cso5778171c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781613454; x=1782218254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQK5gzMXPgnRV0bTfXyVq3SmcDKPMp6M1AfOZUZQWZU=;
        b=rK9kC8wJmfdPIZ20SQOXxvWiq+BaAndqV5S05RIkPGvDypt/gLQqjWMN7RRYWUMerM
         cHoDZb0vGrfoCmTJAoTlKCVb6DMNDnKYWU+QJVopaIo284MTxttjI4mWXgQzL7yEj4bw
         q6ukewV6SnAG/HfBTLT2aqDHnaENIY38/c/EseMUcKe8iRBI/Y9OdcbCCNj1xwckixHn
         04MXcisKcWKjEJtOoEtyUIO1OcvdmQEV6E3klDbsB4fb/5Nhive60TJqCVfzMIBQqBH4
         dTBLvv+5tCvpp+IMypD2O+M70oAoyNxvQBpUixZf4cKeKJETcGLP7uVqZc1fffax6ZNB
         irCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613454; x=1782218254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQK5gzMXPgnRV0bTfXyVq3SmcDKPMp6M1AfOZUZQWZU=;
        b=hepjJ3qL80FI+QolKwsKpzccR0aNw/69L+vNbMrERhCRbBwpuF2EKUzRxqoBKgxPf5
         BInbf9LaK58VifR943fdOpyKYITKbzjFtZjf9kiZ3ts5sV+YJoDMwdXs5BHuifffcgWx
         waAO8N5+OzQ+rO+vhLOnYsodQgTgnppx3/CJcSKq5XYLTQ1PiU6tqnpXtD4PgyxkG4zK
         KDoKXzZfJlIBcPWGI5c7j4qxMyOEYP4wSSTMCnM5naGPz0bfb9NVIzi+K/Hqj/8Ey9CF
         /A8ENz44ivld9bs6jtIXWfSbzYqie3A3urscwSqoLc5So5Ed9sfaugChpoTIP+y+0pR7
         zoOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DtpDopCLt2aro0VC4TrgDVJVEvwYaYrCOU/bYF7XH7agm9HHDlrXoD61pkHE/u3OfUgYtqIpIKHoaTSYi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Lx+bjUCGzG+yZt3E59krnGOAjTeVjdycWe7L0s/p3I0lRnxw
	fJ76hj+8E+Xum5HJQQ5Uk1hzhXQUEwcBE0UmAauFNc9BpU+fGbPC7e0a
X-Gm-Gg: Acq92OEWnjflMyAhXLAI24oHmC8IwaSyoKKfyxX0yGlSj5yilu+YaudoAc+yB1Huia7
	KCyUnGrKHMuEpZcbuq82s1jomqTRmPGZS0QixFxC3LyOmJFMIourKSVs8kMJovw1RNAITSNgzHX
	2Fv7x4D7Ifadoa4t3LUF2sAuHOuIFliK7P1eGODihTE2d2T7QQZqUAW8qYxKVGyqmXvQX3pWiqP
	6ZC5NvElDFqub0UzIr1zhxGCQKJDf4TtYJ8sqY6kvRVe/4w5S+yyoy+V7cUslsll6R18y9cpAx9
	RbGED0W+PT8Qv1E9tcd6AuFgijtU9QnNfZn1Iw6WAqI6Mp9snXSG15ue6LN5RFA2KzPYGtZe376
	+VIEBA0Edb7wt79sZEz3Yey2TXXKHUlup4k4GoyFts53mYGGD725UVIwMuxABb2C9/TJMQMNhLt
	9dOilMEzP4mObziM1ItPU0vhxQBLN53XZ4YyznDKau4JM=
X-Received: by 2002:a05:7022:2385:b0:133:3bb1:8d40 with SMTP id a92af1059eb24-13985ebce30mr1504395c88.15.1781613453900;
        Tue, 16 Jun 2026 05:37:33 -0700 (PDT)
Received: from [100.125.248.95] ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b910c51sm13245906c88.4.2026.06.16.05.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 05:37:33 -0700 (PDT)
Message-ID: <58ee3009-8a0e-4657-a473-475ea998316e@gmail.com>
Date: Tue, 16 Jun 2026 20:37:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/23] ext4: pass out extent seq counter when mapping
 da blocks
To: Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 libaokun@linux.alibaba.com, ojaswin@linux.ibm.com, ritesh.list@gmail.com,
 djwong@kernel.org, hch@infradead.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, yukuai@fnnas.com
References: <20260511072344.191271-1-yi.zhang@huaweicloud.com>
 <20260511072344.191271-7-yi.zhang@huaweicloud.com>
 <ghe4izo4od2b4fcgmiayopkaombyjjopao266sseuqim72t5sj@h2meez5lalsl>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <ghe4izo4od2b4fcgmiayopkaombyjjopao266sseuqim72t5sj@h2meez5lalsl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/16/2026 6:04 PM, Jan Kara wrote:
> On Mon 11-05-26 15:23:26, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The iomap buffered write path does not hold any locks between querying
>> inode extent mapping information and performing buffered writes. It
>> relies on the sequence counter saved in the inode to detect stale
>> mappings.
> 
> Now that I'm looking at it again, I've got a bit confused here. Buffered
> write path is holding i_rwsem between mapping blocks and using them so
> there shouldn't be races.  Perhaps you mean buffered *writeback* path? But
> then ext4_da_map_blocks() should not ever get called in the writeback path
> because it is allocating delayed blocks... So this change looks unnecessary
> to me now. Am I missing something?
> 
> 								Honza
> 

Hi Jan,

Thanks for coming back to this series. Sorry for the inaccurate
description in the commit message. However, this change is still needed.

As mentioned in the comment before the ->iomap_valid() callback in
iomap_write_begin(), consider the following scenario — a buffered write
to a dirty unwritten extent, with this concurrent race:

   Buffer write (holds i_rwsem)    Writeback (no i_rwsem)
   ext4_da_map_blocks()
     // ext4_es_lookup_extent()
     // finds UNWRITTEN extent
   ext4_set_iomap()
     // type = IOMAP_UNWRITTEN
     // validity_cookie = m_seq
                                   ext4_iomap_writepages()
                                     // writeback for unwritten extent
                                     // ext4_convert_unwritten_extents()
                                     // extent tree: UNWRITTEN → WRITTEN
                                     // advancing i_es_seq
   __iomap_write_begin()
     // ext4_iomap_valid(): cookie != i_es_seq
     // iomap invalidated, re-maps
     // gets type = IOMAP_MAPPED (WRITTEN)
     // iomap_block_needs_zeroing(): FALSE

Without passing out m_seq, the stale IOMAP_UNWRITTEN type from the iomap
would cause __iomap_write_begin()->iomap_block_needs_zeroing() to zero
out blocks that have already been written, corrupting data on partial
writes.

Thanks,
Yi

>>
>> Commit 07c440e8da8f ("ext4: pass out extent seq counter when mapping
>> blocks") added the m_seq field to ext4_map_blocks to pass out extent
>> sequence numbers, but it missed two callsites within
>> ext4_da_map_blocks(). These callsites are on the delayed allocation
>> path, which is also used in the iomap buffered write path. Pass out the
>> sequence counter to ensure stale mappings can be detected.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> ---
>>   fs/ext4/inode.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 6c4d9137b279..39577a6b65b9 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1929,7 +1929,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
>>   	ext4_check_map_extents_env(inode);
>>   
>>   	/* Lookup extent status tree firstly */
>> -	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
>> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
>>   		map->m_len = min_t(unsigned int, map->m_len,
>>   				   es.es_len - (map->m_lblk - es.es_lblk));
>>   
>> @@ -1982,7 +1982,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
>>   	 * is held in write mode, before inserting a new da entry in
>>   	 * the extent status tree.
>>   	 */
>> -	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
>> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
>>   		map->m_len = min_t(unsigned int, map->m_len,
>>   				   es.es_len - (map->m_lblk - es.es_lblk));
>>   
>> -- 
>> 2.52.0
>>

