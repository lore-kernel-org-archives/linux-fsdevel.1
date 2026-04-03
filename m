Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0056C30BBB6;
	Fri,  3 Apr 2026 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190577; cv=none; b=rC89k0c+Iu6Fe9wR/jkMRTkRPkW3N9bEtrb3sR5i1au+42YHhj3N+6I/zvYjva9umDMteBNuPdG2R16kLU7UYvKQ4LLYnqdk0Bdx86n8ewVSnn7Rq3W3CSOqHfbuFoBy7O59RZfWZfkENtUs/HDIx5n+jKLKsptCSxahxfzh1dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190577; c=relaxed/simple;
	bh=kmGbF94+IUNEaXUu/UJmWfNfsk5PVdY6dluOnRmvdSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYZSaERjPbHrwF+nKWv8+xRjL306sPkloaQLqmUO1koC7wjJbE0qvkRkfMyD7HlWIa8uy70ue5hBNs9km42fZV12yPDgq5kgBsVgUvSpmJu6VJGNpm8q4d3uHI/8ihze6JE/K2iOCE1hI+hO/Jris49UHpDCuOzlYjjq/cCX8Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K9g340AF; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K9g340AF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=tX8F1JPMvQO6lQpaatlFR3CwLwp153g7dKBJ7RJI+SI=;
	b=K9g340AFIU5YXhJffwGXfAaioocm9dw6c3vijBrJKNWGQjy+4DeSs+OhV8zuOV
	SvXiic+6AtMlBfcOUNxMfEsJjdG1bl1/77VUkampWCH9Jg/Z3Ml3vGz4cBhV5iRi
	yiUAusuJz2CKv0Xm9kqadqcb2/79rW4ZZ7TtGS3pa5hhI=
Received: from [10.42.0.216] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCXa879Qc9plIj7Cw--.11462S2;
	Fri, 03 Apr 2026 12:28:46 +0800 (CST)
Message-ID: <df79035d-7cea-462e-9003-2236e66e0b52@163.com>
Date: Fri, 3 Apr 2026 12:28:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] exfat: introduce exfat_chain_advance helper
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Chi Zhiling <chizhiling@kylinos.cn>,
 "syzbot@syzkaller.appspotmail.com" <syzbot@syzkaller.appspotmail.com>
References: <20260401071138.114836-1-chizhiling@163.com>
 <20260401071138.114836-6-chizhiling@163.com>
 <PUZPR04MB6316F93B0D34197D68F302CF815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <0f46e0c6-82de-4aee-9d01-e417eb619bff@163.com>
 <PUZPR04MB6316FA116436AAB12EA72F18815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB6316FA116436AAB12EA72F18815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXa879Qc9plIj7Cw--.11462S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryDCFyUKF4kAF4xtw1kKrg_yoW5XF48pr
	48Ga15J3y0qa4xu3WIqa13JF9Ivw1IgFWkXr4UCw1Yyrn0qFn7CFykG34a9FyfJw40kr1j
	vF1Yqr4a9rnxKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRLXoxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3B-de2nPQf92fQAA32

On 4/3/26 11:33 AM, Yuezhang.Mo@sony.com wrote:
>> On 4/3/26 10:34 AM, Yuezhang.Mo@sony.com wrote:
>>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>>
>>>> Introduce exfat_chain_advance() to walk a exfat_chain structure by a
>>>> given step, updating both ->dir and ->size fields atomically. This
>>>> helper handles both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes with
>>>> proper boundary checking.
>>>>
>>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>>> Tested-by: syzbot@syzkaller.appspotmail.com
>>>>
>>>> ---
>>>> fs/exfat/exfat_fs.h | 17 +++++++++++++++++
>>>>    1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>>>> index 530459ab9acc..1035d20ba563 100644
>>>> --- a/fs/exfat/exfat_fs.h
>>>> +++ b/fs/exfat/exfat_fs.h
>>>> @@ -552,6 +552,23 @@ int exfat_read_volume_label(struct super_block *sb,
>>>> int exfat_write_volume_label(struct super_block *sb,
>>>>                                struct exfat_uni_name *label);
>>>>
>>>> +static inline int exfat_chain_advance(struct super_block *sb,
>>>> +               struct exfat_chain *chain, unsigned int step)
>>>> +{
>>>> +       if (chain->size >= step)
>>>> +               chain->size -= step;
>>>
>>> It would be better to not change *chain if return an error.
>>
>> Okay,
>>
>> v3:
>>
>> static inline int exfat_chain_advance(struct super_block *sb,
>>                   struct exfat_chain *chain, unsigned int step)
>> {
>>           if (chain->size < step)
>>                   return -EIO;
>>
>>           chain->size -= step;
>>
>>           if (exfat_fat_walk(sb, &chain->dir, step, chain->flags))
>>                   return -EIO;
>>
>>           if (chain->size == 0 && chain->flags == ALLOC_NO_FAT_CHAIN)
>>                   chain->dir = EXFAT_EOF_CLUSTER;
>>
>>           return 0;
>> }
>>
> 
> chain->dir should also not be changed.
> 
> static inline int exfat_chain_advance(struct super_block *sb,
>                   struct exfat_chain *chain, unsigned int step)
> {
>           unsigned int clu = chain->dir;
> 
>           if (chain->size < step)
>                   return -EIO;
> 
>           if (exfat_fat_walk(sb, &clu, step, chain->flags))
>                   return -EIO;
> 
>           chain->size -= step;
> 
>           if (chain->size == 0 && chain->flags == ALLOC_NO_FAT_CHAIN)
>                   chain->dir = EXFAT_EOF_CLUSTER;
>           else
>                   chain->dir = clu;
> 
>           return 0;
> }

Alright, I got it, this is great.

I’ll update it in v3.


Thanks,

> 
>>
>> Thanks,
>>>
>>>> +       else
>>>> +               return -EIO;
>>>> +
>>>> +       if (exfat_fat_walk(sb, &chain->dir, step, chain->flags))
>>>> +               return -EIO;
>>>> +
>>>> +       if (chain->size == 0 && chain->flags == ALLOC_NO_FAT_CHAIN)
>>>> +               chain->dir = EXFAT_EOF_CLUSTER;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>    /* inode.c */
>>>>    extern const struct inode_operations exfat_file_inode_operations;
>>>>    void exfat_sync_inode(struct inode *inode);
>>>> --
>>>> 2.43.0
>>>
>>>

