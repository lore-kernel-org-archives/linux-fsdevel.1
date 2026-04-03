Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5234FF76;
	Fri,  3 Apr 2026 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184309; cv=none; b=OvJ9agNLHRY8PmT8SLyfWLSoyNHWsjOodiufHgzTwpT/0kzkWxyNttU61zfhtOeXM81IknyPMg99Rw3KXBCSMZuDyOTPj88lZ1fCDZO9fDjTnHQYHXhEu1CDPgwBZL4T4OVlfF8pJuRzeJuOfMIHhoU2rI568lWMJb8DFsm4AMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184309; c=relaxed/simple;
	bh=bUJnLwF22HHqcco2o3SeZLBdCFNlyQm60y4UNoxaP/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTw9rhW4LChwLZ+NHeFml1x5KDW1vLMeaCgCTIgaL3ZDeQK4cThBL3o4Rc04jPOYg4V8Bn1yKcUZUzuORe6qOp5m3nLpX7Hjm8UuoJNAqqip879nv0l41XSkvmDhuSeWOeIfoEpCfm2rInFKwgvvamhtK4ud7g9PbteTy6RqGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cUze5+tx; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cUze5+tx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ogdZ7aqiHtP/miFgTPX8nII99gRkqIIgvU+I7GxEiJw=;
	b=cUze5+txRHqZ2+wg8svdB8OP1pYvfOSA++61xQlFk2P1PFJHkzkKe3SwgI/SzD
	H5w7LjBabFhrB2kIqeMNaIAfadGwVGjbMAGcrgBnTf3LuuX0sPcZEb4/rdIcHjja
	SDcAPX8vQG6/8aNCM7RjospV6NV+YVC6pJbKOvr0j6+LQ=
Received: from [10.42.0.216] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3SL+aKc9pViDrCw--.28600S2;
	Fri, 03 Apr 2026 10:44:42 +0800 (CST)
Message-ID: <2b3e0290-c2ef-4d55-a7ae-cf5411de911a@163.com>
Date: Fri, 3 Apr 2026 10:44:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] exfat: introduce exfat_fat_walk helper
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260401071138.114836-1-chizhiling@163.com>
 <20260401071138.114836-3-chizhiling@163.com>
 <PUZPR04MB6316BFAD68CF7BCCCAFFD4F5815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB6316BFAD68CF7BCCCAFFD4F5815EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3SL+aKc9pViDrCw--.28600S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF17uFWDuFWxXFy3Zw4rGrg_yoW8ur4DpF
	4UGa15JFWUXa47u3WaqrsYvF1a9ws7KFyDCrWxu34YyrZ0yF1v9ryDKryakFyxAw40g3Wj
	vF1jgr1rurnxGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRT89_UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+Bq+XGnPKZp6LQAA3C

On 4/3/26 10:34 AM, Yuezhang.Mo@sony.com wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> Introduce exfat_fat_walk() to walk the FAT chain by a given step,
>> handling both ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes. Also
>> redefine exfat_get_next_cluster as a thin wrapper around it for
>> backward compatibility.
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   fs/exfat/exfat_fs.h | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>> index 9fed9fb33cae..530459ab9acc 100644
>> --- a/fs/exfat/exfat_fs.h
>> +++ b/fs/exfat/exfat_fs.h
>> @@ -437,7 +437,8 @@ int exfat_set_volume_dirty(struct super_block *sb);
>>   int exfat_clear_volume_dirty(struct super_block *sb);
>>
>>   /* fatent.c */
>> -#define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu, NULL)
>> +#define exfat_get_next_cluster(sb, pclu) \
>> +       exfat_fat_walk(sb, (pclu), 1, ALLOC_FAT_CHAIN)
>>
>>   int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
>>                  struct exfat_chain *p_chain, bool sync_bmap);
>> @@ -456,6 +457,26 @@ int exfat_count_num_clusters(struct super_block *sb,
>>   int exfat_blk_readahead(struct super_block *sb, sector_t sec,
>>                  sector_t *ra, blkcnt_t *ra_cnt, sector_t end);
>>
>> +static inline int
>> +exfat_fat_walk(struct super_block *sb, unsigned int *clu,
>> +               unsigned int step, int flags)
>> +{
>> +       struct buffer_head *bh = NULL;
>> +
>> +       if (flags == ALLOC_NO_FAT_CHAIN) {
>> +               (*clu) += step;
>> +               return 0;
>> +       }
> 
> For ALLOC_NO_FAT_CHAIN, since the FAT region is not accessed, it would be
> better to use a more general function name, such as exfat_cluster_walk.

Okay,

> 
>> +
>> +       while (step--) {
>> +               if (exfat_ent_get(sb, *clu, clu, &bh))
>> +                       return -EIO;
>> +       }
>> +       brelse(bh);
>> +
>> +       return 0;
>> +}
>> +
>>   /* balloc.c */
>>   int exfat_load_bitmap(struct super_block *sb);
>>   void exfat_free_bitmap(struct exfat_sb_info *sbi);
>> --
>> 2.43.0
> 
> 
> 

