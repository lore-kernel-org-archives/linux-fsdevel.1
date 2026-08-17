Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB92F8E8B
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964853; cv=none; b=LS7AurC3Xsoqrt8Dw1Wd1v8UPziWOSyj3+LjDvbFfLd7QQ74zTMPrYBSFwm8xSnnUpxraIKnHdy8g7AlYjoY/Uh628ueDt5MEEyiiwk4z8ixZeqBIWOl7BGb3QG4qiIbhULdGToY91I6AsnvJyesLNq5a4PqWK8GRxlaTkS+kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964853; c=relaxed/simple;
	bh=e73NdorI6LGinThzPMM9qlaq4WdI7II1OvIcIKTKM4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8vbjxU3TS0zN8GWiIUI/DOIVsVo37m0g3v67bMXWJKQ0bJUc7O087+xczD6E8wwdc3SS0prtnK3Ce575xPI2vA0hsEQwvhhvX23BUsJtwVNgGUeaULbFR5xXl1LsrQrQvdbRRqgIILOqaFzs162sEnfwYEK2ilzYeZv2qoYPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcRtptqZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcRtptqZ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8486672f03cso3160769b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 04:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786964851; x=1787569651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPDbOKwzDa8vtpfSUiBNZ/5Xwtz6TiDkuOOU4awK/CA=;
        b=TcRtptqZcXCWf0QyvE9/JxmnpX9lXkmO43/YsTjuv08JoeeziXs61TaYH5WmqisB5C
         IZvNLzADmZ4NsIYVJTJ+8zWXkj4DzBoyjKiHpfwX07fL4CTBpvOuh14BrKd+LuzDHalv
         O4PKHCMGcuGLouMvz3u+AvIaOt/LDGeRcuyVwHDAaTLc2jCv55MKstgR8ba0PuXYd/Rt
         SgyvUggo9nnuCIrLd0yIJFk80t+ySqf3kd5uieXqqV2rstU0EWeccWFfTb2Cop+mV3nK
         xiLdyx6tjCtpmm/su41fN1G13iqRTeX96ScBoVRk8apngzP3dgsDQ8UnGFYF3IswQrZ7
         yTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786964851; x=1787569651;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPDbOKwzDa8vtpfSUiBNZ/5Xwtz6TiDkuOOU4awK/CA=;
        b=BcjLBVIeYijwaCwFsN+hBtWXf68k+Tw7A6tn0bN4ItUVLEbr8Wt00/63JnWH4N9jdC
         /DIEZ4wZTq8VJpJL8eOH3tVfAiggfRnm+jM+12FOOg3MMcfW8I+527rVReEp3u5Ei5jc
         +CW5FWZr3/RxlP18+tWijIi3stJshe6LMVLYIpdzJHHRT2FsZ2Rnh7MwnOvUc4yqawcf
         RksJCfeaSqSGEo+cZ1ju6TXpsqJ/1PLErgTGWLrsmRaYJ6Uj1tc3BqQemjQ4642LLtzv
         1xN2ZHuMsWIIftAkyKxOTGCnRjj3YJRRvKsVTgDrf+KcGTxa6s1IZMIRgvdKOz0+3FnE
         MyRA==
X-Forwarded-Encrypted: i=1; AHgh+RpR77Dhk4D+Nm2Tof2dWHDcwBa+76+az+y9eKIIUFvmblNtdoNRREpz/j0fyLq+j8ZNvZG810gca0/xZIUZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/amMGcUJOdq6E5e6qgMOU5zJrpsvmD9ZKOzh7yJQVNo/2M7O
	RaS48r0pg3IOmZc3JAFdhUqFkIlslNIhgYP39J8NQWWwcWZfQqPUEhcd
X-Gm-Gg: AR+sD11bhcTEbSkOp3pYRuzLhmvtsbjyXDhZzoyL/9CDaIgWbqilCY0EuCCGdyApen8
	6Qz+FhxiXov+QfrlihTWDDnHAm4nmycCW9JE7aB+FEdzzelrZWDJ6UDbuuac4hxfgm0FyuThOK5
	WZr/+HcTvhUxbccS3d3JbuXms7JMXzP7jYU2nwieV8gvEhl/ChJOhe+fGWvb6lskjYhGtXm01ib
	dRcETF9EIN66GZMhdmgP+2bQFfWSX6HJZGSfFnajOO91RO5T04h+bccC7snH26gtCe38m7TEhm1
	iro2H9QI3m3bA1CAj9E91VYzHdfRir6GAUVrrCEAalMJGZPJh47pKQM3HyYGHf2vv9Z0GUfh6kb
	DXHPEaMFBH6rgecJ9EFAhaEAXEMLPbH4VEBP40lWVqY4uytJG6r3V9NYCMNf89PzolPLYOp35mS
	iSeOAZjHc2r3/AZ+vyikIZo/pXl057cKp3QlG1Cw68wvrlgqnatEqa7T2ScFHpQL5Mi3TuOM+lu
	+Cb9lE8ZDxyvoBxy00=
X-Received: by 2002:a05:6a20:4305:b0:3bf:6222:2e7e with SMTP id adf61e73a8af0-3cc71c1b20dmr25115013637.4.1786964851226;
        Mon, 17 Aug 2026 04:07:31 -0700 (PDT)
Received: from [100.125.248.95] ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c00d84asm531019a12.19.2026.08.17.04.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 04:07:30 -0700 (PDT)
Message-ID: <f3678818-676e-4c0a-b321-84abead100c8@gmail.com>
Date: Mon, 17 Aug 2026 19:06:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v5 10/32] ext4: skip block allocation for holes in
 the data submission path
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 libaokun@linux.alibaba.com, jack@suse.cz, ojaswin@linux.ibm.com,
 ritesh.list@gmail.com, djwong@kernel.org, hch@infradead.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com
References: <20260814093331.1703882-1-yi.zhang@huaweicloud.com>
 <20260814093331.1703882-11-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260814093331.1703882-11-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/2026 5:33 PM, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When ext4_map_blocks() is called from the data submission path and I/O
> end extent conversion path (EXT4_GET_BLOCKS_IO_SUBMIT), it should not
> allocate blocks if the lookup returns a hole.
> 
> The writeback path can legitimately encounter dirty ranges that map to
> holes. For example, when a folio straddles i_size and the tail beyond
> i_size is dirtied via a mmap write. Allocating blocks for such ranges is
> wrong because there is no data to write back, the dirty bits should
> simply be discarded without submitting I/O. This mirrors the existing
> buffer_head writeback path, where mpage_add_bh_to_extent() skips
> unmapped buffers and ext4_bio_write_folio() clears their dirty bits.
> 
> In the ioend extent conversion path, holes are also not expected because
> we should wait for folio writeback before punching hole. If one is
> encountered, it likely indicates a failure in the concurrency
> protection. In this case, to avoid losing data beyond the hole, do not
> stop conversion, continue on the remaining ranges. This prepares for the
> buffered iomap writeback conversion.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>   fs/ext4/extents.c | 8 ++++++--
>   fs/ext4/inode.c   | 7 +++++++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 76038b6c3655..0d62d9312284 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5167,11 +5167,15 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
>   				      EXT4_GET_BLOCKS_IO_CONVERT_EXT |
>   				      EXT4_EX_NOCACHE);
>   		if (ret <= 0) {
> +			/*
> +			 * If the ret is zero, an unexpected hole may cause
> +			 * conversion to fail.  To avoid data loss during I/O
> +			 * end conversion, skip the hole and continue
> +			 * converting subsequent blocks.
> +			 */
>   			ext4_warning(inode->i_sb,
>   				     "inode #%llu: block %u: len %u: ext4_map_blocks returned %d",
>   				     inode->i_ino, map.m_lblk, map.m_len, ret);
> -			if (unlikely(ret == 0))
> -				ret = -EINVAL;

Hmm, we'd lose the error code here. Sashiko also mentioned in the
review of patch 19 that hitting a hole during conversion could
corrupt other files. That's a serious bug, so continuing the
conversion doesn't make much sense. I think we should drop this
change and just return the error early.

Yi.

>   		} else {
>   			conv_blocks += map.m_len;
>   		}
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5dcc3f7b2ffd..d8c3e5e13b8a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -823,6 +823,13 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>   			map->m_flags |= EXT4_MAP_MAPPED;
>   			goto out_handle;
>   		}
> +	} else if (retval == 0) {
> +		/*
> +		 * Do not allocate blocks for holes in the context of
> +		 * data submission path.
> +		 */
> +		if (!map->m_flags && (flags & EXT4_GET_BLOCKS_IO_SUBMIT))
> +			goto out_handle;
>   	}
>   
>   	if (!handle) {

