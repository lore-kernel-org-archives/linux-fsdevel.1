Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB83D903E
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362541; cv=none; b=gOYm/6oLA2Vuey0M3zYNK0ZTsFw8KYn6UZBJvXIcqYJsrkEI5ZA81tZf20wuyBUoqveXibylzGeZuCZv59gtV74yFLTFgGyrsN9KwSJlSGrZ5yWXUnPxzq732G6+6Hgi2sQyMysmqmLBH7Y36MTyUeVtVNg4fumxDH6pmzm+1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362541; c=relaxed/simple;
	bh=DfupwPSZCin6aC6UoR/hMPVmIOg1Ka92Z2blxUP6B8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ys/RuYS/WHYNue67BX3Bn+rslV/Z3T2trWJRBsYqq2Qvd/DZi2OFXudcftnN1tPvQJqvKEzR9SAEwgnk1eAfuWqAllbiFTelSWSa5EBMmxHqhNAdB0jj1jWKXEulD09NYp9M6f8UFwGOUiZBBQfQ5Fe51GSTv9N/Rj2hMnJIkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0cibDtL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0cibDtL"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1198449f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792362537; x=1792967337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YuPuYj2KyJGah9hmABQQctga1s9wEhiM9oVruD5npRo=;
        b=j0cibDtLxh/izLswrWPSsQZxFjb5L4EMPQBgcSnjGDit42gu1Pm5oWUsCrfuFTx8nd
         wYdyunGN9El/oKYgG2w3WAYm0sk7eApe6170A44Hd9mgeJuNdh1e/KU4iIOUMEAXzaU3
         VNCxgmRqbBuQMK1tFC8Ss7wwT5CXv6gb+uHeepZrZvqLULJeGZbe416AFBo2XlQDlYK4
         43A+vKFjj7e/2eSEWeetWdnbn+6n4rO33x0NXv3tPPTW37QdsurVr5v5j7d0s55IMXhA
         W9bE69ocS128IIfUjS4jY1tNP2zNYItTsbpAaNtwkQR1T27hfeK4TocFTYZc22mWLe1T
         cdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792362537; x=1792967337;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YuPuYj2KyJGah9hmABQQctga1s9wEhiM9oVruD5npRo=;
        b=rYwxs+8ywh2Ay26MYyGy6xiAvXYMYhBfqVmtlcL4onpDz5WD14rYk8TdjVFsUYu/sm
         ABpPkPM0c7Ff6bhiAe3wYkUR/FelCKGTcOALIytG0r9/TauSN4mIGfPQ6VunT0MWf+04
         rMfegl7lzL5FaVDsX9n4ZjYnXsBlaiWb2QsHka7jnUB5TSwkiB0bIkeejbf23VMQccU2
         y9ymIjt6WpIINYbe+1D7uHTKiPb9DU8uWIsHgvekw1jFzWKYj4XKFf8GwLU4nxuBfHjP
         FvHLDxkeVhGgNbbNkCVGxqOm072EbssM5uE9Jiryj6fmnYH7cfhguhYaTAeP/7uX678i
         /rJA==
X-Forwarded-Encrypted: i=1; AKwUvBz+dDwH4mmA2ECQuHCIY/JGaJnCr/2ffQg+MHGHGd9ZVtuxZzKBZT2Vp0VS4QvRwV9UCk3GVGsP6fHjR/24@vger.kernel.org
X-Gm-Message-State: AFq9FYIIIS4lkSSe73+smAInl8zcZ/5pGUnylpAu8K7ADw+m21FpCk3h
	ghOs8x6ecTtU00ryUK676eJ39/XRovEOm5zwyLfwrIH3h5JdaKpQpSo8
X-Gm-Gg: AYBFou1sbJYrQ8osBgVmrjS8H1+Y+OWANGjU5EX9hp6R516kC9NKuzNfcxF1b9yolq7
	GL+gFgbJ6FsI9QYwPLc2vwGWri3ETUK05Z6kpWCuPuOL7Cunhn5Emr3SLgSuG1in7nDawmGHd6k
	fLoZhRIFG0gkdk4IiTmMPNQCeMIPkIK3kl5VLknpk1KUyjUfnf6w9o9yJYy5q/qyuYyZKd11s8R
	n++KqdWZ/TrQqWZbmRJ0RrAddNHsBBrKEfttyllYbV61TEPEfgLYMjY00yRINpmngwq0qbVmMZ8
	HmI5wkzuKowyvFqidT6PJpOm75YIHoCuKYg1UUiQuaQ+6u5+FG0LEFt+USsYnkH2QYL+hLCZrHE
	hheUf72LlRRhZAmvd6Apo3aTXYslJxQmTcwdhT7dvRFKA6CVJuqYyKbqNnP+7G8/Ai3Purzddww
	73mLP4d6i3Bj9C5HVSo6yGT2xtakLMxPJePRoSiXbp52Yyunl93kt3Hlpz9ClF1FZ/I2osqm0a6
	n8CWxWiIKUeIjosejmLuUsPkpz62mPp/yFqcqqop9qJRMMxSP8KmdEqFZW43Aah54m1LjdE30ND
	3LST7cErRMorxJF/fGMR/Uuy3UMpqaRV4RLiAs8ayipb1+O1
X-Received: by 2002:a05:6000:2f86:b0:48d:fd0e:a117 with SMTP id ffacd0b85a97d-48e079759c0mr14316716f8f.5.1792362537508;
        Sun, 18 Oct 2026 15:28:57 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5b2dsm20677990f8f.31.2026.10.18.15.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 15:28:56 -0700 (PDT)
Message-ID: <0fe67d0f-54cf-4076-9e4d-ad23d05e7099@gmail.com>
Date: Sun, 18 Oct 2026 23:28:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] xfs: support dma-buf registered buffers for direct I/O
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj1072538@gmail.com>
Cc: djwong@kernel.org, cem@kernel.org, brauner@kernel.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, anuj20.g@samsung.com,
 nj.shetty@samsung.com
References: <20261016091919.971295-1-anuj1072538@gmail.com>
 <20261016091919.971295-5-anuj1072538@gmail.com>
 <20261016092855.GD23141@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261016092855.GD23141@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 10:28, Christoph Hellwig wrote:
> On Fri, Oct 16, 2026 at 02:49:14PM +0530, Anuj Gupta wrote:
>> From: Nitesh Shetty <nj.shetty@samsung.com>
>>
>> Add the init_dma_buf_io_ctx fop for XFS files.
>> XFS picks the device and calls the iomap layer with
>> the relevant device.
>>
>> Refuse the iterator from every CPU-copy path: DAX, buffered
>> fallback from a -ENOTBLK direct write, and read/writes
>> without O_DIRECT.
>>
>> If a file is switched between the data and realtime devices
>> after registration, the block layer cross-device check refuses
>> the I/O.
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>   fs/xfs/xfs_file.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index 426a67b813a7..f97d5acfaf68 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -340,6 +340,11 @@ xfs_file_read_iter(
>>   	if (xfs_is_shutdown(mp))
>>   		return -EIO;
>>   
>> +	/* a device mapping can only be read by a direct I/O bio */
>> +	if (iov_iter_is_dmabuf_map(to) &&
>> +	    (IS_DAX(inode) || !(iocb->ki_flags & IOCB_DIRECT)))
>> +		return -EOPNOTSUPP;
> 
> Maybe move this into the actual methods for dax/buffered instead
> to avoid extra conditionals?  Same for the write side.
> 
>>   
>> @@ -1209,6 +1219,9 @@ xfs_file_write_iter(
>>   		ret = xfs_file_dio_write(iocb, from);
>>   		if (ret != -ENOTBLK)
>>   			return ret;
>> +		/* the page cache cannot copy from a device mapping */
>> +		if (iov_iter_is_dmabuf_map(from))
>> +			return -EOPNOTSUPP;
> 
> I suspect these random fallbacks are going to cause trouble, but
> I'm not really sure what to do about it either.

Folks did mention it to me before. For a slow path we can try
do something like amdxdna_cbuf_clear() does:

dma_buf_vmap(dbuf, &vmap);
if (!vmap.vaddr)
	return -EFAULT;
memset(vmap.vaddr, 0, dbuf->size);
dma_buf_vunmap(dbuf, &vmap);

But I can already imagine it triggering some interesting
behaviour like buffer migration, which will be too penalising
for things like clear on a hole. And we'll need to be careful
about deadlocking here.

-- 
Pavel Begunkov

