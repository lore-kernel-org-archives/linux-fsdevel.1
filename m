Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75180339383;
	Sat, 22 Aug 2026 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787419848; cv=none; b=EfPuyO4LTxc/OQyaiak9VUIZcYXh/KKFUBvfQue1H08JDtd2di+DISveP7aSpi/3ExAksktpxkhqP3kVpjeqovswFJdBeZlbuTUuY0hic7lEEd/TGvrcB5laznGPwireMXlwEnYWRgI+SXflaDs3y/R3J9ErBWkn57ok1pZKUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787419848; c=relaxed/simple;
	bh=/EqpCCrwog1RSXWiMyz9HRj+amspp08bBvMDXcem97M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3keBlPWrlLWG+uDtOyw/7OtwjY7dylaze6Joy2P4V8porROg+rgnYWeMnoSr9XrKmHKRKqPag9xE+MDpmiiH4imumuXSVGUlRxpzp3xYo9YPxv4Fpw933W1uEI67sa1G4bVU/IwC9PcMY5pFZvqxQuWMeymQ1LKMOjs0c0ZKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GbbejwmR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GbbejwmR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cOewuHhYijHg680wHZMfLhmFaLHTLM5/CGaRUwoaHXw=; b=GbbejwmRT/Y9YCxZ5dFbYZGMG/
	4mhTcJj02Rb+ynspC7Gd7T+p0BhxZWbFBjrdzuzpF5lT7YFlk9ge++4aemWplVqm62iGsrY7IoTxM
	HkpIP6//e8SeHa0L34uU9ZsGlW9lsSFv+mVGE1s94VOfU5PxUKaggXPErWD9Bc8WarRkIEOomPz3W
	nERR2GMVPWhe9CJVVoHnIpHxH2Rxl6tm4RIQy9VN/5Ea1qfR2uqgDV8w68RYjLekK6VlwPYQd0pp+
	s6tGALbp0TjdT8YQOg24Qo4PXeQMnG7cKaX8R7pk/4XEAIImjTSiXmgb3sCzPYnXDyuBrhA8aovnA
	U2H7LffQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxpYG-0000000Egoh-23eY;
	Sat, 22 Aug 2026 17:30:40 +0000
Message-ID: <23c3480c-2779-4618-8f8e-57a60d26cb3b@infradead.org>
Date: Sat, 22 Aug 2026 10:30:39 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] docs: xarray: Fix xas_try_split() name
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox <willy@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260822121651.1559-1-kmehltretter@gmail.com>
 <20260822121651.1559-7-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260822121651.1559-7-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/22/26 5:16 AM, Karl Mehltretter wrote:
> The iterative split helper is xas_try_split(), not
> xas_try_alloc().
> 
> Fixes: 3fec86f8aa8c ("xarray: add xas_try_split() to split a multi-index entry")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/core-api/xarray.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
> index c6c91cbd0c3ce..3d2b20c05a937 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -490,7 +490,7 @@ entry at every index to ``NULL`` and dissolve the tie.  A multi-index
>  entry can be split into entries occupying smaller ranges by calling
>  xas_split_alloc() without the xa_lock held, followed by taking the lock
>  and calling xas_split() or calling xas_try_split() with xa_lock. The
> -difference between xas_split_alloc()+xas_split() and xas_try_alloc() is
> +difference between xas_split_alloc()+xas_split() and xas_try_split() is
>  that xas_split_alloc() + xas_split() split the entry from the original
>  order to the new order in one shot uniformly, whereas xas_try_split()
>  iteratively splits the entry containing the index non-uniformly.

-- 
~Randy
