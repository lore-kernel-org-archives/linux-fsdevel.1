Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161271624D5;
	Mon, 11 May 2026 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778460401; cv=none; b=s4z3yGHXVIednzTgHUC/65mZU7c0zgEC29f27Vek9wimxUM1zMTP9QLZ7lgEAmcxz1E7VisMe3N3wiFcliPzz2JyD4OCATqL1Dp1j2ou5Be3Zz8QT/fo2KATWyb9Q0wRwol/3+IAFtK14DthvuIfukgUVcwfY8YaM6C2lPgD/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778460401; c=relaxed/simple;
	bh=0w9tI9R4xwknXRsc7IRCwuf0HcEU8i/4XIdk9jTDqPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idOaX9ERhHs8424GdZICyD8UX5xB4G2Wz7Fcjipl9WpMtOTGlyJMWHudTzO9zICajUUt9jJe/YNYktoWHHgiRqFGZqyKusP0/4syyaYRdmgiMhtPFPDM/FZlM4dOiotv83J0kPAPk3K1x2j5NEKwtXuqGS9T9QdX+LYdC3WwyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gn9nmApY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gn9nmApY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=5s2OUIUvGbza0/yzgQs3Y3o4djvX7bFaSgbslqDOieQ=;
	b=Gn9nmApY/oJne+J9aRHnQpETIEV6WXWukWd8I4wE/19B75Ts2dZVQc8TIIhf4j
	fdVp7D+HcGb84VxKG8vC9uBW4pJWErJqo/0loeCQadlpjaNbgmPGxMaPU4CbTUG0
	Q7REwKctHKFhYFrZMRMRLRDsR9yX2lmcY1lfl0Kv6vENA=
Received: from [192.168.3.148] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wA3F+O_JgFqxPSsAg--.54895S2;
	Mon, 11 May 2026 08:45:53 +0800 (CST)
Message-ID: <3919c924-3129-4e61-9355-992892915f24@163.com>
Date: Mon, 11 May 2026 08:45:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] exfat: add support for multi-cluster allocation
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org,
 djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
 anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn,
 linux-kernel@vger.kernel.org
References: <20260507124238.7313-1-linkinjeon@kernel.org>
 <20260507124238.7313-5-linkinjeon@kernel.org>
 <ef3f055d-1d3e-4467-a835-37c52585fcad@163.com>
 <CAKYAXd8fSPP3w=Ec-ffXf6uiJkFQsfA9OhAQsjz-QZCZXSd7VA@mail.gmail.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <CAKYAXd8fSPP3w=Ec-ffXf6uiJkFQsfA9OhAQsjz-QZCZXSd7VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3F+O_JgFqxPSsAg--.54895S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw13AFy8Gr1DAr47Kry7trb_yoWkCrX_G3
	WUZFW8Aa1Yv3WrGrZ8Kwn5trW8t3ySkr1jyr4DZr1Du3sxArZ8A3Z5X34I9w4xKrW5XrnI
	vryftF1fWa4jvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUD5r3UUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2wGUMmoBJsHAaQAA3Z

On 5/11/26 08:20, Namjae Jeon wrote:
>>> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
>>> index 1246713567a5..7b09d94ac464 100644
>>> --- a/fs/exfat/inode.c
>>> +++ b/fs/exfat/inode.c
>>> @@ -137,9 +137,9 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>>>        unsigned int num_to_be_allocated = 0, num_clusters;
>>>
>>>        num_clusters = exfat_bytes_to_cluster(sbi, exfat_ondisk_size(inode));
>>> -
>>> -     if (clu_offset >= num_clusters)
>>> -             num_to_be_allocated = clu_offset - num_clusters + 1;
>>> +     if (clu_offset > num_clusters ||
>>> +         *count > num_clusters - clu_offset)
>>> +             num_to_be_allocated = clu_offset + *count - num_clusters;
>>
>> We need to truncate *count for read operations so that it does not
>> extend beyond EOF. Otherwise, xfstests generic/003 will fail.
> I'm not seeing this failure... Can you elaborate more why it was
> failing on your side ?

In my vm with 6G ram and 40G test disk, when the cluster size is 512 
bytes, reading a 512-byte file (which consists of one cluster) fails 
because iomap attempts to fetch a map for the 0–4K range, which exceeds 
the file's EOF.


