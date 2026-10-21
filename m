Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595538;
	b=0ejGG2EtMzWg86xzJDyc2E5rOAsJObI6Din2IhO3U3NECf36GnKKSgHf05ROit5HpI5h
	 5fweR+cNhJ34dBAUYGSv3ot8ZLkTg6KzF7Uy8stOs6gLoG8Tx1a6SSvhIK+Kf6uYPJLnN
	 VmOjSarRFRASXgS/wtZEtZqYJBpNYuiZVXhuC8sUUk864tElzDZHN+I9/UlpVcjC3Nv/c
	 +kcXqb8lTSjc+vorFHXXWNgM3jm8J1tJ4MRJabYH8n+k616ah8rNjvFO8arBzWElt0eKd
	 BTxLRyHyj5v6Hxh0UW61eSfYihV3K2WrzfucQ7krWucBKNHdLS9MXUAQuGLOG5y+CSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FsHH6aozeXPThpXvJUYVLtQrnQwbfOChlZ8cfIqdctg=;
	b=ApLY8AMFoa9WjC1ilCyWDScyalOv3cS/V+dgq6HNVRlxgKlpZ0gJbevrw+EElNhGmLV3
	 ZfoS8ZSoQUPvFeyM0SgOeVS2UdLrJKWRM4R77dH0YBUd/gUjEOGSapGyRC3wNvoROHn2C
	 88z0S6UH9URWrrhFVK58Hm2x6ThuYto+1OP4VLVEkuedl+6Efk2wjEwHX4AiKjTplWMi3
	 cvJncQEoiCm5M1i/Yl0H/ISLcCWGCQ5Yh8lugzvM5RoqHChqk2fvsfvgqfDPRUmrNk7dF
	 wMxMlv3N9p1FNE1k/ZQfANJ9OxD3goA7PUfIXv3Ck8dLqXhg58TCRecKtB/9Thwo7IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fRtNArbA;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B91606A31A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 15:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fRtNArbA
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df8fe8513so823074f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792595536; x=1793200336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FsHH6aozeXPThpXvJUYVLtQrnQwbfOChlZ8cfIqdctg=;
        b=fRtNArbAsjB87bQ7Egtqi1qkoryq/3OpgC+NpIKVcrOe3+zlMXYMwOlAI8wBFiWNqz
         /vwIrs8UcevppcI4bM3g8DBDAAPymD3sBjBVJZkceWgpJVAoP88Fri5Aq/xfZc77SNg3
         heAxZ+4juOcdoVkAt/XGapWWe7ioX6XUStxAlzmwxpDhGFXB3ERcql5/GqsTfS0H/qYU
         GbXxFn405gpDNlr5sBH6IWrq7iarI3go7WnfA0KVbRX/9NmUYIhzyNwuyUkllOfxIm1f
         VKxKclYr9bO065thJe8DJ9E9Vckk3PDMFluqv9yYpZUIrjYUjQXqMqXt92ZWv6Np+iS9
         u+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595536; x=1793200336;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FsHH6aozeXPThpXvJUYVLtQrnQwbfOChlZ8cfIqdctg=;
        b=k6dJDlFidX8F22Io+Lnn8Aub080RjEB11yqiR5YgMlwGyKswVy5vkk7J+5Y2aZe92f
         rH2QCqiQafd+2yOjeFEvhs/YZ0lNN/s+XB5q838lTqqrrWCMRV0EgWRaz3J1J/Gw/sJs
         lOiveUPlEqpyoSVOqquRFfNqHboMeLSH0lWsTLWn2U1TijuacTmbK7xshclxuzMqoeEU
         BkBAlQp+P1q+asPuoYYTCrlCqds/oXsDEuDzNLxrzZCv7musHstoj1LrlEDkfUb5XbeI
         NazjZrhjll/k4tNS1Nhkw2rV+I4oPikEG4bbXw0W3zNibk+XIYzqtzIoZ+UrJ0YkWTH3
         TNlA==
X-Forwarded-Encrypted: i=1; AKwUvBzMGCLWvtiYiHnohqSqL4OBxNGiDoBQ+igJZNr+MV6bQ8/AWq2+v+7L4IHDK97gbBaydy1Z55BztO2oZ2JP@vger.kernel.org
X-Gm-Message-State: AFq9FYIQgSP0NEa6bZlABCoYSkJ48eluBLxNxgBbeFJyaozmu1uG88l3
	SSMbN/GlBb3z8heueci+bfTKXNYUx+l6tPmGUQYYZIykkH95uWT4VGFq
X-Gm-Gg: AYBFou3gm4zRwOBwtGkOkhc6yQMmNgoWsj4sHQYJtnc4vPTquXYTfM0X3ZkyHG014qK
	RXMVTjkmTRlbQvajo2y5CVTrV7Tau3q0TLWVjYA2jyY+9xDxZBJlo4o35+1B1fn+9ipHnMoRPB2
	K66hEnbH1++0QjFQNKI9H3QPQgmIlANq+D9t5t+8nhThHt9nxiks8dpeKoZwTjHfXdo7RLv6z+d
	d/LfgvLKT2ILHuCVyYy0ZqcaV2+x8Vjjr+cj1wiSSHfvrLWxPRYQQ8WamzmAv/+F+uZzsduQ/eM
	F74o8BV13HVlfyAiGux7ycmMuG09vTeUf1ESdqmMkEXbVPbN9co4lcQ71MfNT6wApOzuBwYMw4h
	ZQBSzqklgdP07KwfKR638jt4jy6sbKz9pug+oNxpbQyXfhEujCRFnzy7zO/M4kHNep91CpzyIes
	iG60dtGvlQ/glPuC5wJkpIa4GKJJv43ZZWHa2PXnLEHOdGZKrb5PhafmHClCwVErPifYuqVuC1c
	7qPjcoMcai3gj/Hw23w7a3HEhpLPx9zNJBAIrJ0bE3wpjqmSBDX2e4YTlTKSFfGphmpdNlQw3WM
	lLlAc1hp4OBCh00tqriuE0Pi1CUS3O/R4ckb4zRztgV6adTEJ5sa3GcTbmC5VZ3tkjFM5v25YRZ
	/SAKj8ew=
X-Received: by 2002:a05:6000:46d6:b0:48d:f831:2681 with SMTP id ffacd0b85a97d-48e264ce32cmr3497388f8f.38.1792595536092;
        Wed, 21 Oct 2026 08:12:16 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-19.dab.02.net. [82.132.213.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f02f1sm6396517f8f.3.2026.10.21.08.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:12:15 -0700 (PDT)
Message-ID: <5f542a8d-c6c1-4c5d-b0c6-f761af2e126a@gmail.com>
Date: Wed, 21 Oct 2026 16:12:15 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/4] block: refuse a dma-buf bio for a disk the buffer was
 not registered on
To: Anuj Gupta <anuj1072538@gmail.com>, hch@lst.de, djwong@kernel.org,
 cem@kernel.org, brauner@kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, anuj20.g@samsung.com,
 nj.shetty@samsung.com
References: <20261016091919.971295-1-anuj1072538@gmail.com>
 <20261016091919.971295-3-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261016091919.971295-3-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 10:19, Anuj Gupta wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
...> +static bool bio_dmabuf_map_valid(const struct bio *bio,
> +				 const struct iov_iter *iter)
> +{
> +	return iter->dmabuf_map->ctx->registered_devt ==
> +		disk_devt(bio->bi_bdev->bd_disk);
> +}
> +
>   /**
>    * bio_iov_iter_get_pages - add user or kernel pages to a bio
>    * @bio: bio to add pages to
> @@ -1300,6 +1312,9 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>   	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>   		return -EIO;
>   
> +	if (iov_iter_is_dmabuf_map(iter) && !bio_dmabuf_map_valid(bio, iter))
> +		return -EXDEV;
> +
>   	if (bio_iov_iter_set(bio, iter)) {
>   		if (iov_iter_is_bvec(iter) &&
>   		    !bio_iov_bvec_aligned(bio, mem_align_mask))
> diff --git a/block/fops.c b/block/fops.c
> index 18a755f6e0b0..b36dde10a4ac 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -19,6 +19,7 @@
>   #include <linux/iomap.h>
>   #include <linux/module.h>
>   #include <linux/io_uring/cmd.h>
> +#include <linux/dma-buf-io.h>
>   #include "blk.h"
>   
>   static inline struct inode *bdev_file_inode(struct file *file)
> @@ -938,6 +939,7 @@ int bdev_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
>   			     struct dma_buf_io_ctx *ctx)
>   {
>   	struct gendisk *disk = bdev->bd_disk;
> +	int ret;
>   
>   	if (!(file->f_flags & O_DIRECT))
>   		return -EINVAL;
> @@ -945,7 +947,10 @@ int bdev_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
>   		return -EOPNOTSUPP;
>   	if (bdev_has_integrity_csum(bdev))
>   		return -EOPNOTSUPP;
> -	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
> +	ret = disk->fops->init_dma_buf_io_ctx(bdev, ctx);
> +	if (!ret)
> +		ctx->registered_devt = disk_devt(disk);
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(bdev_init_dma_buf_io_ctx);
>   
> diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
> index b9bbeca1744f..d42a79f2ac9b 100644
> --- a/include/linux/dma-buf-io.h
> +++ b/include/linux/dma-buf-io.h
> @@ -50,6 +50,8 @@ struct dma_buf_io_ctx {
>   
>   	void					*dev_priv;
>   	const struct dma_buf_io_ops		*dev_ops;
> +
> +	dev_t					registered_devt;

That wouldn't work well with multiple devices. Maybe reject it in
xfs / iomap for now?

FWIW, a generic solution is for xfs to own the ctx passed on
registration instead of forwarding it to block, allocate an array
of new ctxs for each device and register them separately. This
should even be able to support dynamic device registration.

-- 
Pavel Begunkov

