Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB01624C0;
	Fri,  3 Apr 2026 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184476; cv=none; b=Qwk/6u+JuAwluTD4RuzWvmQkVPgsob7EF4J+Va6e3h73cNtk7oov6xeCJk1Gf87mo/z+fwlNd/a/wlJEKFwWmSYngbyzaOLyDX/edS5lGjoh4PBhwnlZdWXtxDRsf1NhFpiGeftaMDsKYUwVI7mEiHWpvZfrObDy2Ue25BDWuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184476; c=relaxed/simple;
	bh=vBBCIBUGLfQ5y38wcwa8Rk29LP34DrFqfsOqy280atM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l00D5jOsX8NNnFI8his4SNYT8KZ3NORhi6g1lj7EaRjkrx7e81C79SUGY+Qi2QPtp6tx9vYE8rVk7ttU9+7+K4tx1Qk5Nj9+qdg9+mi5BD/9iXOLDbUbnz5LwunONGSF7gwx6vSZ4wSBNwr0qPTfH6QQeljNbLbRxCpvAddMRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RgusBZ3I; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RgusBZ3I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=pLOhs/rDl3qfckZVQyhbXk3zCtVltJwT+WXCgYkFAO4=;
	b=RgusBZ3IidRRT3b8j7AxrwD3f/eEbs9UrKZmUKwN7IFnwQRAG3Px27eqf+pfCj
	jWadPxmPTBh+3zU0kQ/YePOBADmwUMR8mHYfS/rVpJX5z3DzNH3vIxSl+HmG/dhH
	unUNlEbx3vnAIU3abCLow+jLAwKbBK5n5Hj+KY18HR9Pk=
Received: from [10.42.0.216] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA3n6wkKs9pbfKmUg--.78S2;
	Fri, 03 Apr 2026 10:47:03 +0800 (CST)
Message-ID: <0f46e0c6-82de-4aee-9d01-e417eb619bff@163.com>
Date: Fri, 3 Apr 2026 10:47:00 +0800
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
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB6316F93B0D34197D68F302CF815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgA3n6wkKs9pbfKmUg--.78S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF17uw15KrWrAw17tFy7Jrb_yoW8Zr4xpF
	48Ga15J3y7Xa4xu3WxtF45XFyY9r4IgFW8GrWxAwn0yrn0qr1kCF95K3429Fyrt3yjkw12
	vF4Yqr1Y9rsxKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRLmR8UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+Afhf2nPKieDmwAA3S

On 4/3/26 10:34 AM, Yuezhang.Mo@sony.com wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> Introduce exfat_chain_advance() to walk a exfat_chain structure by a
>> given step, updating both ->dir and ->size fields atomically. This
>> helper handles both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes with
>> proper boundary checking.
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> Tested-by: syzbot@syzkaller.appspotmail.com
>>
>> ---
>> fs/exfat/exfat_fs.h | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>> index 530459ab9acc..1035d20ba563 100644
>> --- a/fs/exfat/exfat_fs.h
>> +++ b/fs/exfat/exfat_fs.h
>> @@ -552,6 +552,23 @@ int exfat_read_volume_label(struct super_block *sb,
>> int exfat_write_volume_label(struct super_block *sb,
>>                               struct exfat_uni_name *label);
>>
>> +static inline int exfat_chain_advance(struct super_block *sb,
>> +               struct exfat_chain *chain, unsigned int step)
>> +{
>> +       if (chain->size >= step)
>> +               chain->size -= step;
> 
> It would be better to not change *chain if return an error.

Okay,

v3:

static inline int exfat_chain_advance(struct super_block *sb,
                 struct exfat_chain *chain, unsigned int step)
{
         if (chain->size < step)
                 return -EIO;

         chain->size -= step;

         if (exfat_fat_walk(sb, &chain->dir, step, chain->flags))
                 return -EIO;

         if (chain->size == 0 && chain->flags == ALLOC_NO_FAT_CHAIN)
                 chain->dir = EXFAT_EOF_CLUSTER;

         return 0;
}


Thanks,
> 
>> +       else
>> +               return -EIO;
>> +
>> +       if (exfat_fat_walk(sb, &chain->dir, step, chain->flags))
>> +               return -EIO;
>> +
>> +       if (chain->size == 0 && chain->flags == ALLOC_NO_FAT_CHAIN)
>> +               chain->dir = EXFAT_EOF_CLUSTER;
>> +
>> +       return 0;
>> +}
>> +
>>   /* inode.c */
>>   extern const struct inode_operations exfat_file_inode_operations;
>>   void exfat_sync_inode(struct inode *inode);
>> --
>> 2.43.0
> 
> 

