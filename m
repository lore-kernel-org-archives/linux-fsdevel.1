Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFAC30F932
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540138; cv=none; b=shsKGuF854kbW3HdgZJLDzOpBrfsVGJUUVhgOUFebLWh70a/WW9/LcrxVbI1+utliD+OfZS5E7qTzA2UsPwQyh36G3yDqo07ezl8URDWXhgE6jlZ3/mVWYsXgKXhRk+mFRGRnNss/8xFvdM+0YHRPouCoPKmJUB8UQ9xyH2EqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540138; c=relaxed/simple;
	bh=k7+huYN+Isl3+3XaOrqHg4PkHeBCg5Za5yKe2jhgWR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfSE/TLWblrX7Y1JFwSrbAZ+GqEkEfnwSWIkDT7XaQ1d9lfSmRX3Tqdsoeggv7dlMc1ALNdvbqPwB7h23oc6WRNEr8ImOI57Jb+bzwCd3Wjw7lLmg4ytbtB1Yn1SpbeYx2QATWSXIKWHfsJpp+umcLpZkCEgPqefg3Dde0qjofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPJl/XD9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPJl/XD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371FEC2BCB0;
	Mon, 11 May 2026 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778540137;
	bh=k7+huYN+Isl3+3XaOrqHg4PkHeBCg5Za5yKe2jhgWR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FPJl/XD9YNgm4poMduNbp994nTzlddq22RiO3DhcMOESD5SAMU4BK7+V5ia7oOyh1
	 MnnUAOPqijR6MnlEdAJVdAXoO7KMWNUs/4bBZf++nOjBivBgD59k3/gj37SXoXb7LO
	 ZJdEaLRL63rxWvc41v55dufvfMdiZtCZ5ZuFNSH3EgWzw5q9WK5Z7Aq3P0Qo5BKRPd
	 H8t74Imi2BA8mjTvPAinYHzPBdhcZ02M96lMlM9w455c5aXqm394E7g0pY3eIDu937
	 LMM+DOPjGD6HPZvk35jYnIMeFnbZhiQkk49Zmyp7qo8CxybNNe8wZpeydWaXFSOAFr
	 643MdcvjHJV1w==
Message-ID: <7ee40e26-252c-4199-8dfc-69746bd43746@kernel.org>
Date: Tue, 12 May 2026 07:55:35 +0900
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

Applied to for-7.1-fixes, with the Fixes tag added.

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

Note: I moved this hunk one line up, keeping "shift *= 10;" as the last line of
the loop.

>  	}
>  
>  	return fno;


-- 
Damien Le Moal
Western Digital Research
