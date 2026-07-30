Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8223A1687
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400587; cv=none; b=dvX1R/j4qf9bq+KmDTTHe3+kcrwvGz4o5tGP5ZqInQtGXbu7IrrKaD5zSd2kgE3m/KQFvqyCN86qW3BozObX2gn0Rkl3IM+Xj05NtAglKaVNnxyxqmGvK4hJSRFzYj/dO1H5kR6o1uApuRQjTGyJC3w4abU6dW3Iu35uFPqLpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400587; c=relaxed/simple;
	bh=JjDIr/c5fC4klzNh2Bgb1Ge7WTmvkeGXbZvpz+QHk94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJu93cgHpNeP9FBDJiKPVr6xzq57bcNNzQxa6Z3kglqqCuFdVs4PKE3UEZaxNVMKRwqGOsBe9Jzh9PPrBJi5PlfPbMz8TbLZOAQ0w9hnQOi6qXAN7mIYxTFYPJF4Faw72mFXk0cmsOCAa1N6UUjYt6W2Rf5KwQRKHPBuQajMG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MR7+63bE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MR7+63bE"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15e592da74so224101866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785400584; x=1786005384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AWNW9gGcp9mMQeLn4SF9boYQbOO04eHEN/wZUU4pOFc=;
        b=MR7+63bEe6AHX3mhAEygdgdcTe3uWFUGaIgxa/olxIfHhhg3VvSSdcE4Z3kXlrX+fF
         XQM17NWcqNAoZg5F9x0Dg6QVnvJyoY6yd4eQX0XSC8WR0tkuAw4rr+BQEon/dOTnuqtq
         T+YOo5D1XuQzwlSgJgvA8Ix+drUNpms4wwI1D4A+jEisRhtd8svHaPqvviq5cizlSrgy
         T8JWXBX9D5cViCQCqhuVuntz9a/BbYO8nkxRBoZ5EfO4Ux6MqlAsMoWgMUN101wd+Zwo
         S7D+ElEx2wMn41bjBZ+13qhAHUxV+QhP/3wPLjYTOQR01N6HwVijhF0O3jlb/7WndOqB
         u8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400584; x=1786005384;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AWNW9gGcp9mMQeLn4SF9boYQbOO04eHEN/wZUU4pOFc=;
        b=FJf5KlJMLorbNjsi4l8DTZs3iC1JsNNmnt4aDIjMgJwiYVRghGlRyqCydhjOYlj7RF
         QqBaekjAWUL+8FL7vMH+bEGVBw6wVcpmCwLt0i33LcqEes7H0zwZLFPmMXSSdHTS1czY
         lpShVNbPjivJI+yQsumRzFIWyNvPk/DsVC8A0sbEnpKAURMYZXmMDGevT3hqWXWWHK8R
         s/L5g8QJgaa4K4YOPWIfMsuR7cN3jDJmS25o9GAXw08Fnz7wVO7yMX8IrqZZeqZWV+Us
         RJkf1ZuZSOjs20PAbl6pe9rXyERAZDZj+t2ZzrzqqjkbCw6EJRV4zW0C4vJ14LgXC+tH
         4ESg==
X-Forwarded-Encrypted: i=1; AHgh+RoO7JOHEM3BzfubYZGrM66qVFSTmuFJwdQ9u6ot6RJWrMpPZI4zibXmgI7gdEdFGKJuWXLhZmgod9wpKc5y@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYt4CIBz0JSUHFWxViglC+nbmwfZnWopADdsSuhIkIBbEhBph
	bjQqU3177NF+evTZM/nK45PYpIMMtJY6nyjq+vBmWRuObWv3OZ9R9LFeKw6vLmqdZt6sXHn6EQd
	GG7/w/Kk=
X-Gm-Gg: AR+sD12wl4dBQ35fAMSgJnYQGCJgJo36glbYhElJ+nJwkqa1Tu/lJK3n2u9O+5LpNaJ
	80qSzKMMSEiIBJRMbakK5YB46jVHXmj0Q25SitdPJFUSTT8FZ2y7Layxd+Tob/2JAowEDeyIn2J
	BtrGR5lU219EQUUqtf6hZxWB8HPvEzag5dETBqVwa4gPGA0CzlEM2Qojlu26gNc/l5RMKnB4XfD
	o6dK9hV5LZJCKX9muJXau2QwrUyhvMrnHrGosSUHw+BLHfS36BN2afr2x3RnZECDj+IBp7DVCma
	P24l93LmP6AHqX9nQkM7Omc2zn0FhWfspetw2xTm+M9NcgtEW0k/EURNqd/XpMXW2JN4dV4jHqp
	Oz/p76hor/Ct8G7jqluSXE9fTI6Y0PVbM3epQtlqugJycUES8JuFq5ny59UiTmMiVQBuDhdb1S/
	EdphgwsoMTFUG1yAyNtTIj+4VK6KVh/FUcMP6kKimbAo3/hyr0nqeQ4gfdZDYFGAZ6mg==
X-Received: by 2002:a17:907:1b09:b0:bec:64d4:3872 with SMTP id a640c23a62f3a-c1fa54be7b7mr86420666b.24.1785400583966;
        Thu, 30 Jul 2026 01:36:23 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a16558sm22653955ad.6.2026.07.30.01.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 01:36:22 -0700 (PDT)
Message-ID: <30f0bdfb-c8ee-4459-8137-773020960f7b@suse.com>
Date: Thu, 30 Jul 2026 18:06:17 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: follow the alignment requirement for
 iomap_dio_hole_iter()
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <e69cc8a4a9c3f641b97872b50f04c397880077cd.1785374485.git.wqu@suse.com>
 <amsBEVNnsYJjKGpK@infradead.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <amsBEVNnsYJjKGpK@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/7/30 17:15, Christoph Hellwig 写道:
> On Thu, Jul 30, 2026 at 10:52:10AM +0930, Qu Wenruo wrote:
>> [BUG]
>> On the latest development branch, btrfs with 8K block size on 4K page
>> sized systems will fail the following fsstress workload:
>>
>>   # $fsstress -n 4 -d $mnt -s 1785675805 -v
> 
> Please add this to xfstests.

In that case I'll create a more dedicated reproducer.
> 
>> +/*
>> + * File systems that write out of place and always allocate new blocks
>> + * need each bio to be block aligned as that's the unit of allocation.
>> + */
>> +static unsigned int iomap_dio_alignment(const struct iomap_iter *iter,
>> +					const struct iomap_dio *dio)
>> +{
>> +	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
>> +		return i_blocksize(iter->inode);
>> +	return bdev_logical_block_size(iter->iomap.bdev);
>> +}
> 
> This already exists in the VFS iomap tree (with a slightly different
> prototype).
> 
>>   static int iomap_dio_hole_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>>   {
>> -	loff_t length = iov_iter_zero(iomap_length(iter), dio->submit.iter);
>> +	loff_t copied = iov_iter_zero(iomap_length(iter), dio->submit.iter);
>> +	const unsigned int alignment = iomap_dio_alignment(iter, dio);
>> +	const loff_t aligned_copied = round_down(copied, alignment);
>>   
>> -	dio->size += length;
>> -	if (!length)
>> +	iov_iter_revert(dio->submit.iter, copied - aligned_copied);
>> +	dio->size += aligned_copied;
>> +	if (!aligned_copied)
>>   		return -EFAULT;
>> -	return iomap_iter_advance(iter, length);
>> +	return iomap_iter_advance(iter, aligned_copied);
>>   }
> 
> iomap generall expects extents to be block aligned, how do you end up
> with non-aligned reporting here?

The dio read buffer is 2 pages (matching the 8K alignment), but only the 
first page is faulted in.

Furthermore btrfs has disabled page fault during dio read, so the 2nd 
page will not be faulted in.

Thus iov_iter_zero() only got to zero the first page.

Btrfs always returned a hole that is properly aligned, but as long as bs 
 > ps, the page fault can always break in the middle, causing unaligned 
range.

Thanks,
Qu


