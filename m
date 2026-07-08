Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE489202963;
	Wed,  8 Jul 2026 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551770; cv=none; b=BQz6NJG7Lo9EogkO7wADZd1fTs2dvM8AumDxfqhs4clV/Fvz/rhfDdF27DKn4KUlvFwqzJbsjW+SzWaRJ2926SkR4nEq+ima5adh0upRfdFQmFOirzOEmr191626BGkQnG4h8bF1Ng/Ic4EwTNM3sX8DsY1Xm7fQhwH8e7AWMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551770; c=relaxed/simple;
	bh=vtlU3XMOeZw1eacK51Df4vRRVTwKXfhuHqXvCt98REE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WsaGBKquLof9qeafYw+eM5q5MZe7VHIjCwmOH2ZCat1GCqND2bZXe5YE5yWlM3QVErS3HYsgizCCTFjuv/nL3MvXUyRtzT1kQdga8578DULMX+yGTYMaCnl/fEVl4lriirS3S5OxqODEDFWDEDH2iyYjczVP1yxgbzSRMN/1scQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieJhn6rR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieJhn6rR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81A61F000E9;
	Wed,  8 Jul 2026 23:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783551769;
	bh=8Q52wgdanECt1pEvDdQlUNWDgKwzJIWZIA7aOx7Ke6A=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=ieJhn6rRGR43oEjHDhKiHCBosLfEY5yeTOAhZ9PHWE7nlpwUifK505tSD5++dwbf0
	 XgxMWqfnz62MbgTEIv+9ViNZzANDUvmYCFwpsYXfjMApCOCEsurs9ubUEvvHYKFraq
	 ZDBf6B+l0bkpTLPrgxv0xR97o48zmpPzK6+RbIiuJv4a2IEIDqg67yjrdqFTGfeMjC
	 AnEFBMFPlnWsazxKcwU2y5nvJrh+NCz3gKv00WioFB1Q6JTLj2bSOBnOZ5+i4LcZmJ
	 lD3GyzlW7lm6TlEGkJsAyXaL9FlkeQ3+Q6s3dx5VhMNyIOTZ3Kqb1WzfLFM7P8xohF
	 tg2ZPGga3XCww==
Message-ID: <801587f1-de61-45eb-958e-d998e5dfac04@kernel.org>
Date: Thu, 9 Jul 2026 08:02:47 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: check multiplication overflow in
 zonefs_fname_to_fno()
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260708104617.745781-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260708104617.745781-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 19:46, Guangshuo Li wrote:
> The change referenced by the Fixes tag added overflow checking for the
> addition used while converting a zone file name to a zone number.
> 
> However, the digit value and decimal shift are still computed with
> unchecked signed long multiplications. For sufficiently long numeric
> names, shift or digit can overflow before check_add_overflow() sees the
> value, leaving the parser with an already corrupted intermediate result.
> 
> Check the digit and shift multiplications as well. Only advance the shift
> when another digit remains, so valid boundary values are not rejected due
> to an unused final shift update.
> 
> Fixes: 3a8389d42bdf ("zonefs: handle integer overflow in zonefs_fname_to_fno")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Please check your email setup. This one was in my Junk folder.

The patch looks OK to me.

> ---
>  fs/zonefs/super.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index ff43d6d1ea30..106cf304348b 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -615,10 +615,12 @@ static long zonefs_fname_to_fno(const struct qstr *fname)
>  		c = *rname;
>  		if (!isdigit(c))
>  			return -ENOENT;
> -		digit = (c - '0') * shift;
> +		if (check_mul_overflow((long)(c - '0'), shift, &digit))
> +			return -ENOENT;
>  		if (check_add_overflow(fno, digit, &fno))
>  			return -ENOENT;
> -		shift *= 10;
> +		if (i + 1 < len && check_mul_overflow(shift, 10L, &shift))
> +			return -ENOENT;
>  	}
>  
>  	return fno;


-- 
Damien Le Moal
Western Digital Research
