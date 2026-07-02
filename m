Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879D1FB1;
	Thu,  2 Jul 2026 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782953149; cv=none; b=q3Pueodw9efMjhOQo4hEoLqc0rJuWsvm0oO/sFtxtGdMUA/mjrnRLiOc6F106tt043DPm6WyDmYfwXlKvsMAXRraYiXT4XMjb6AlXvkT3HwKP8kNi0bHqV+5IY12W5AnQNs13+huxN9iIvFwoISr3Nf0TWKlgyhnFsZ+r7G2UdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782953149; c=relaxed/simple;
	bh=UpgMyaHxa5jlsIdGK5KBROv+rFGMQ8FVxufW/ZpWSr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sb1ws71EuBhublOCC/wxTgiBpKrFy+P4ACt7456pl3DxbOWmMokThk70z32uuE7B7silu4B27By3FA+VQAFaE+d59D/YyW/us4Ap5k6VvIFpFt+aJvEm+NHZhWYkxilhHaLI78xA2Keddwrq2G4GSuYK5PRcwHpIyELzYkL49eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VTJ6Wz6r; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VTJ6Wz6r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=GRilIp0r+pJh0WJLABGBNMo9FEFon1CjT8xRdyO99uw=;
	b=VTJ6Wz6rDMSFm5zVrAzGRehfdWoOko77cSQd4+81Pcgt8xwUZ6Yoxo5MR1/hJ6
	B1+33uXBDJJCU4UJKHhlWswkZx0z3qJXhrzTeTVRyK4aHsAbnSKn9rSdfinKahJA
	sa/yFV4BjDTutoOWyWNgWxFscDy3Az9Vse7Po76hLEnyA=
Received: from [192.168.3.124] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBnJ_6atEVqwKEVFg--.29971S2;
	Thu, 02 Jul 2026 08:45:16 +0800 (CST)
Message-ID: <7a57723c-b931-410e-b8c4-8f5c7881c846@163.com>
Date: Thu, 2 Jul 2026 08:45:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exfat: validate cached iomaps during buffered writes and
 writeback
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260701005418.735715-1-chizhiling@163.com>
 <CAKYAXd9SxmntoutaKdCC0T4vDoKEJBgiQiJ=bcTnmgNaa+f-AQ@mail.gmail.com>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <CAKYAXd9SxmntoutaKdCC0T4vDoKEJBgiQiJ=bcTnmgNaa+f-AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgBnJ_6atEVqwKEVFg--.29971S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF15WFykCryUWr4fZw1UZFb_yoW8JF17pF
	ZrG3W5tas3Xa4Uua4xXr4DZa1Fkr9rKa1xXwn3Kw4jk34ak34UKFWjqFyjkr15X34rGr42
	yF4Y9r4jkr43urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U20PhUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2xxA3WpFtJwhDQAA3x

On 7/1/26 8:02 PM, Namjae Jeon wrote:
>> diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
>> index 7c8b4182f5de..71631bab182c 100644
>> --- a/fs/exfat/cache.c
>> +++ b/fs/exfat/cache.c
>> @@ -228,9 +228,10 @@ static void __exfat_cache_inval_inode(struct inode *inode)
>>                  exfat_cache_free(cache);
>>          }
>>          /* Update. The copy of caches before this id is discarded. */
>> -       ei->cache_valid_id++;
>> -       if (ei->cache_valid_id == EXFAT_CACHE_VALID)
>> -               ei->cache_valid_id++;
>> +       if (ei->cache_valid_id + 1 == EXFAT_CACHE_VALID)
>> +               ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
>> +       else
>> +               ei->cache_valid_id = ei->cache_valid_id + 1;
> This looks equivalent to the original one. What does this rewrite change?

This changes the number of writes, but it doesn't make much sense. I'll 
revert this change in the next version.

> 
>> @@ -133,7 +134,7 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
>>                  }
>>          }
>>
>> -       iomap->flags |= IOMAP_F_MERGED;
> Is dropping the IOMAP_F_MERGED flag intentional? If yes, Why ?

Because IOMAP_F_MERGED is set twice in __exfat_iomap_begin(), this patch 
also drops the redundant assignment.


Thanks,

>> +       iomap->validity_cookie = ei->cache_valid_id;
> 
> Thanks.

