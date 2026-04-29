Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ECC349B0D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502510; cv=none; b=bf69l1T+8EcKthueDr4t3G7gKC8WVmPIN0P5/l/MKlolWofrJB4vHB78c5jfkorRmtUZ67UPXSBhKZNqQceT4RidbCzjMJuBJ90NzIoVzctlMDEUMlqvrGEC/KnEYgwMsLNhUoUkEp4BHIWrA7Rii9fEBTm6eo9M/1mQ6XppoGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502510; c=relaxed/simple;
	bh=9UnEyqX5cH7uVLI/7Ov5Nz4yWtj9zPfFDh6U7c2+Xqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1jHyCAzS0rGGRwU3awGNOxz0vUOmb/NwGyHXnv1QcmHlsksuVbjVKVziIPu8ti3dxGI+Hny02rLrwItqDLOKi5XcgIaAjkRsSuam+qz2dmzKmHeS7kHB4sNq0dwzDllbfiwKRwcwB5nJW2Cjwj7O9EHJ0hYHDr9PzpJe3uZWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAB6iHpZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAB6iHpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57016C19425;
	Wed, 29 Apr 2026 22:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777502509;
	bh=9UnEyqX5cH7uVLI/7Ov5Nz4yWtj9zPfFDh6U7c2+Xqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KAB6iHpZLl08kKk1yzM/pG7TXGR72W5tFbF2l2n3afSSR+wnqwK/ZnCWf5MiOeXrQ
	 uUdmcA20twCLBYOiMaOnsk65KQbjxX3ufbNkiHdtrxYVK8DXWBIWKIzfva9b1A8QAB
	 kotvkbpUPvKPVhKRnVNXnlRfnqfx6j1CFaj1ttUVcAkogcdZ0eoH4bJKoiiUrGh/v2
	 PHU4r41KbFwSR8vm43I8cG6C7iaoPuK3vGan8lrIQBFdnygSd16JovSNOSzUIN2Op/
	 MrKcw35AaXo7RiLila60ktjytxZozCSwpwPsC2dJpzQBLpwUAInmCFIOdkGjnyBkcZ
	 MoXBYcy5BGiHQ==
Message-ID: <6fde66d3-04a6-421a-b90d-0443f872b722@kernel.org>
Date: Thu, 30 Apr 2026 07:41:47 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: handle integer overflow in zonefs_fname_to_fno
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-fsdevel@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>
References: <20260429205815.810952-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260429205815.810952-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 05:58, Johannes Thumshirn wrote:
> In zonefs the file name in one of the two directories corresponds to the
> zone number.
> 
> Here Alexey reported a possible integer overflow in zonefs_fname_to_fno(),
> where the parsing of the zone number from the file name can overflow the
> 'long' data type.
> 
> Add a check for integer overflows and if the fno 'long' did overflow
> return -ENOENT.
> 
> Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This needs a fixes tag I think.

> ---
>  fs/zonefs/super.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 9b646cb5335d..c3b497707f82 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -610,11 +610,15 @@ static long zonefs_fname_to_fno(const struct qstr *fname)
>  		return c - '0';
>  
>  	for (i = 0, rname = name + len - 1; i < len; i++, rname--) {
> +		long digit;
> +
>  		c = *rname;
>  		if (!isdigit(c))
>  			return -ENOENT;
> -		fno += (c - '0') * shift;
> +		digit = (c - '0') * shift;
>  		shift *= 10;
> +		if (check_add_overflow(fno, digit, &fno))
> +			return -ENOENT;
>  	}
>  
>  	return fno;


-- 
Damien Le Moal
Western Digital Research
