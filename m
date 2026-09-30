Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693B35A398
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770680; cv=none; b=OsYOkyJeDKbJjbpnQO/KiB7k9jm/U+yTG5zuzWz4dpezcIMO1MlmOxmUT7QJWTOCCmHXWfnxWSFxdVi9Ga0Em+u5MIZ2I9Ymhweb1nuUaRfWyYf10p3GDPCWYQ2MLWyVLdd8LMU/TbvEXpnQFvrjwru/ZCVLAv9JSgbjvbqeLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770680; c=relaxed/simple;
	bh=TTiZSX+Vu/AzQcsdMRHtCMCwgSLVhXM1cLs3BZe1qwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfFYRXXgUDuBJC3bJKrgf2Wk9jAmBVb5wKaZ3SdF6yD72Z3eMgQ18pVr9PhPr7xzcgXwQb2CIBwNNhl+deHHwMZhZCJJ4KbsNMFpeCfutHEiIg8Fn82RbA13z3EoTKHK6IRphbbXWHatclM9IZB+VsbbCOmAKsuGtehNq9K877M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqlGKeBe; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqlGKeBe"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e0b486d91so153468066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 05:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790770677; x=1791375477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzFGcomGYdeFAjB1WE4iZyT8RWcWRQdQmOu+87EuTuk=;
        b=PqlGKeBeKpvhOVUQfid1XVGRDhUlphJZlIslk/x6XMZspos3oAvU5KwOEJUCGFs5+y
         ZNWcSDWF0xiYxQifTLKbCDhXWL0mIpqAuFMRIgQFc3AN2TgvWkv8wQyWb6O2SfSciD1W
         tu2Wh9jWEcvuR2EfslHc13QDBbqOKAmGFfgCUW0Fg12daK3RMuShZQaXYlsWJoa53NAm
         AIU8cxeQ1F4akJ3fD+ih1cG+qNhny1mHNXvshIsXh5wIhHXID2UDwlqyUukoHXOqpzHE
         9/w79bkEgy6t/RPXXS2g/TNurwabjeG+CA3Ye3hXzpZIRA6KeUOYl9drSF/cSeqmepaQ
         7B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790770677; x=1791375477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PzFGcomGYdeFAjB1WE4iZyT8RWcWRQdQmOu+87EuTuk=;
        b=MOdhqKXJm+1qHISsFlQ+r5RJYrOBKJtmc9wA8TXpXysCFtaofQNWMynv1d/WspPj6z
         rnH80Kbf5MrI/Rjp26bx+iH/sDsodvUld3w0zjKrxBE4SbgtgT42lBQej9J6HesQmGRs
         HqpakTKZz9JMCvs8wUaWLYD1wmEl0kH50bkqjhpqygEfNb5dK2FuGywlsjO341gcM8w0
         U1v9gg4jatzYm39tTJZAVHNPyrIJACResyWhSG+7IF1OmNWNy28bXkqtxI5qojGP1SjN
         FHn2Tq88/lYKYJD1Aw+Vd/qRN4Aiu6pEza6PeNHdaEeJC0d9RqIK9WhAw4suT+vGgttJ
         6/qw==
X-Forwarded-Encrypted: i=1; AKwUvBzzdxLoOiFrumYidHhjOGt+OzjbpiSufr4p7Ic7UEpLFYwD8QvwGS91Mq7YnLdV2Ut34YvUlj+C4hIdNycl@vger.kernel.org
X-Gm-Message-State: AFuF++lEwvAIk0+clr4j9qdR9vc76XfE4kR4yNITXDX4weoDxpBUpxqJ
	fQj13vk6+f0dBNBfd74yTN/DOyIND3es8/g11bVzTi5BSABEsXopoBEg
X-Gm-Gg: AYBFou12s57Q5hv604gykcctUU5cDTH2uBCyzWlaodRDxLI73MLw1CBgGFIQOYZejzD
	KnIagrLLsj5WB+8qmZ9sXtN3172sE3PlrUVgl8gQIYy6mo/S24gITnX5AlSx5EG0nnjptXorYri
	9vQiQ8L0nekF2tS2JCFVVZxryrELyowFtK8oHEWLlIZymukQIVsxOBEKG9fRZInqWd3IW+eZOu3
	OK0iJ2pFFL1NggCNwx2WdC8vMP5hrn8KmmVNwDvPxFZHPwcdoPoEA2zvMsrhEupMRChmEOr/bfM
	CTdEdywckuEMP+Ui1+nCpxnnwvlehwazjfeocw+q+K1TMGRfc4r5fg7zWCvU2N/Y1ZyieUIjKXO
	HIw7UwAB5fT2vg4iOW2KIdVYutv8125LvaQltldhPrYKour4mfvBJoY9cBcZC52AUrTC0GbwzSY
	1G1/7eNFgryf20pCDdVDZKmtS5R6iMQcrNBuQDxp1e1/RlyxCSZ21vTIQvkx7w7gLqiYUAMLFsr
	2lrOyV78gl0yrBuAiES2nxB/XjUJwsBFtY7jRPHjJXv5WAmp1lI7jPxB+2t2i4tQl4vXo2MMy3+
	O7BiTBN35xLu/7fyT2QwyprI3R7Td9hlZ1fKbXVri4vEdHSQpSaWqeevBp0VhE5LyiMVNhqgASo
	JX6FiGqZRzDLjGvO5RQZ2LnpFp6jg8/svaQ==
X-Received: by 2002:a17:907:960f:b0:c26:19de:9ac5 with SMTP id a640c23a62f3a-c2e23d99d05mr103066166b.29.1790770676769;
        Wed, 30 Sep 2026 05:17:56 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e22f7fa5dsm55982266b.43.2026.09.30.05.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 05:17:56 -0700 (PDT)
Message-ID: <9359c431-d21e-471d-a3e1-76711da7aabb@gmail.com>
Date: Wed, 30 Sep 2026 14:17:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fat: validate dotdot buffers in VFAT and MSDOS rename and
 rollback
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
 <20260929090029.742579-1-krystianmkaniewski@gmail.com>
 <87ld8j4161.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <87ld8j4161.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/30/26 10:02, OGAWA Hirofumi wrote:
>> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
>> index 35bdb6294..cee06e635 100644
>> --- a/fs/fat/dir.c
>> +++ b/fs/fat/dir.c
>> @@ -941,6 +941,40 @@ int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
>>  }
>>  EXPORT_SYMBOL_GPL(fat_get_dotdot_entry);
>>  
>> +static int __fat_update_dotdot_de(struct inode *dir, struct inode *inode,
>> +				  struct buffer_head *dotdot_bh,
>> +				  struct msdos_dir_entry *dotdot_de,
>> +				  bool force_sync)
>> +{
>> +	lock_buffer(dotdot_bh);
> 
> This looks like unnecessarily wait the completion of buffer I/O, isn't
> it? I guess, it is ok to give up to revert if surely I/O error, because
> the reverted buffer will be the I/O error again.
> 
> Thanks.
> 
Indeed, lock_buffer() may be a bit of an overkill here. I’ll rework the patch to track the buffer whose synchronous write failed and skip rollback operations that would modify the same buffer, while still rolling back entries stored in other buffers.
Thanks for the suggestion.
-- 
Krystian Kaniewski
