Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061E1AE877
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012897; cv=none; b=L8kfUau5aP7er98tHtr/EbMA0YhHcyaT0Xy1omCAcr9ErgvM+huxZCOHJChS4JGDumKmVSomOrWjCQ+J28mFDICKzHS6RL41v03VmRZ9Oy7MQapixcvlKJXDCtTAChcWjkmXXpFNVZLVLzR2Z9OsXbn5Vt4rnhgONF0Ddb6YntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012897; c=relaxed/simple;
	bh=cJM00lthPcp2OUv1UkrPRTKs4RqlLRpj0Nsdai8BvcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4BQyyGeuBPNORJgA6obKSJeIm5EmJE3qiV+b7v+qkZFpO/oPX9YY7/9NntjwWHkRwUL0mFbLuVldXiRdzgJR7sERgPcJx/2VeMyGnJjydrof8vjwO4ytR/bakUqNMFNNX5gp3uvf5xeK6pbHmmx7ikGQfAJR6zjC5R0BZTMeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cAc73FWr; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cAc73FWr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=pHSwItXIGrwRDn7r9xO8o4pEowsbAeNuKWmfiA+X4PQ=;
	b=cAc73FWr66z/0W4OHohImmvYmwAKeqdU35kbdyUyIeiMJq2evC3k33mtHXoUTs
	lMzfAo8sFZFcFNq9b1J1TDkCsDgkzNYjOekkzCt3zuxtk5WMYjXReIGxfSIaomol
	EDH/csj6tY33vJANpG+jHII1J0cuatGVfHCaIGIbHFXdQ=
Received: from [10.42.0.216] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBn6g7ui8xpeERqCg--.1336S2;
	Wed, 01 Apr 2026 11:07:27 +0800 (CST)
Message-ID: <6aec73a0-3592-4cb0-969a-fa9b71802a81@163.com>
Date: Wed, 1 Apr 2026 11:07:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] exfat: add iomap support
To: Namjae Jeon <linkinjeon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com,
 linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me,
 chizhiling@kylinos.cn
References: <20260326115045.9525-1-linkinjeon@kernel.org>
 <20260326115045.9525-2-linkinjeon@kernel.org> <20260330063059.GA5897@lst.de>
 <CAKYAXd_uzuyfz6BBNPxDDiN9GRSoqOWPe__kKx=UbZNxVG70QQ@mail.gmail.com>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <CAKYAXd_uzuyfz6BBNPxDDiN9GRSoqOWPe__kKx=UbZNxVG70QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn6g7ui8xpeERqCg--.1336S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFyrJF1rAw1xXFyUXF1kZrb_yoW5tw48pF
	W0ga15KrWkJw4I9ryvqr4rX3WS9ryfJF1fXr13Gr9xAF90qrnagF12gFyFkFy3Gwn5K3Wj
	q3WDKw1fGasxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRBT5LUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+A+rSWnMi+-lAQAA3w

On 3/31/26 1:26 PM, Namjae Jeon wrote:
> On Mon, Mar 30, 2026 at 3:31 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>>>
>>> -static int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
>>> +int exfat_extend_valid_size(struct inode *inode, loff_t off, bool bsync)
>>
>> This looks like at least partially unrelated refactoring.  Can you
>> split this out into a separate well-documented patch, or maybe even
>> two where one has the bulk reformatting changes, and one adds the
>> new bsync option?  Also it might help to document the bsync option.
>> Often it might be more readable to add a flags parameter with a named
>> flag to make things easier to follow.
> Okay. I'll split it out into a separate patch and add a flags
> parameter with documentation.
>>
>>> -static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>>> -             unsigned int *clu, unsigned int *count, int create)
>>> +int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>>> +             unsigned int *clu, unsigned int *count, int create,
>>> +             bool *balloc)
>>
>> Similarly, this would be a good prep patch.
> Okay.
>>
>>> diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
>>> new file mode 100644
>>> index 000000000000..e4135a13454f
>>> --- /dev/null
>>> +++ b/fs/exfat/iomap.c
>>> @@ -0,0 +1,305 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * iomap callack functions
>>> + *
>>> + * Copyright (C) 2026 Namjae Jeon <linkinjeon@kernel.org>
>>> + */
>>
>> Also normally new infrastructure would get added with the users.
>> I.e. the bits you're using in the first iomap conversion would go
>> with that and so on.  But that's not a strict rule.
> I'll try to split the introduction of the iomap infrastructure so that
> only the parts actually used in each conversion step are added
> together with the users.
>>
>>> +/*
>>> + * exfat_iomap_put_folio - Put folio after iomap operation
>>> + *
>>> + * Called when iomap is finished with a folio zero-fills portions of
>>> + * the folio beyond ->valid_size to prevent exposing uninitialized data.
>>> + */
>>> +static void exfat_iomap_put_folio(struct inode *inode, loff_t pos,
>>> +             unsigned int len, struct folio *folio)
>>
>> Can you explain the logic here?  Shouldn't the iomap buffered I/O
>> code do all the needed zeroing for you based on the map type?  If not
>> how could we enhance the core iomap code so that we don't need this
>> in the file system, which feels like a bit of break of abstraction
>> barriers?
> The reason we have exfat_iomap_put_folio() is because of exFAT's
> VDL(->valid_size). When we map a range beyond ->valid_size, if we set
> the map type to IOMAP_UNWRITTEN, iomap_zero_range() does not perform
> zeroing.> However, if we set it to IOMAP_MAPPED, then iomap_zero_range() treats
> the area beyond ->valid_size as valid data and could expose
> uninitialized garbage data from disk. So it explicitly zero out the
> portion beyond ->valid_size in exfat_iomap_put_folio().
> I agree that it would be better if core iomap could handle this case by itself.
> I'll check whether we can improve the core iomap layer to avoid
> filesystem-specific put_folio handling for ->valid_size.

Perhaps all we need is to use a new iomap_ops in exfat_extend_valid_size 
that treats regions beyond ->valid_size as mapped.

And call exfat_extend_valid_size in advance to extend valid_size so that 
it is aligned to the block size before reads and writes.

Just for what it's worth


Thanks,

