Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F038E8A8;
	Mon, 31 Aug 2026 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211795; cv=none; b=YNNuluE093A+dx3XleA57AR6C4DcV5B9d2elrNcjJP3zEyNn6hDDmHyUnoqnk9BVf9lgU1x1G1cHAqf6dRYrIWl+C7U/4wu2fE3HtZ6yqTzskF1hsZix1euJKRclWHHmZfzfrFEPDH7FvmMMgVj/yranqzI7lahcHJ/1sW4UyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211795; c=relaxed/simple;
	bh=16hbalVy5uoIF15ObN+g/sIvUi//FZA33LiovHjZBOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sd6XdBqVaDp+/MTVQJXx2ppW2DINOfhmU+sNIpGmDi3RxB3rEuvnGgEZH4hJAJE4UcVvXKxgvjbdYvVZIQEOvKYQ+kt3mI1H9Lu84GOqKGv1LWpzevmSVK7nuGhVn/oPFFT/fGvIkL8SPQww7vzqlLxte1mjcjxc3uSnUTm29ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kJeI+ul1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kJeI+ul1"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 505D6408DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1788211792; bh=rv1SKUb4sWsIeu5cUgNjrE2nPRcoJ2CH6rXxJt+O24U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kJeI+ul1XaGH9zP2YiYS0RJPWVMbxcNrryo7mE/TZlYCgLrOnXq4TvB+r+EinrpuG
	 6H+fvnkg3JZoWVLrTzOnnSFbgWYU99UzZROphDykv9gp5b7jDtCx0Rg9ncHuZisYxv
	 LwkxeXZxu1lobIPZPJjt/XAT67qeUrwlVRb0cr5MXSrSit8kdYV7xRuF5N5TZkxyyZ
	 qcJpi/KDwXwdukxV7XsqcraEg/clZfRRv6+zplc+h/HQ9eO0hu7kWU8+cGV+MQEW2K
	 MuwXr4f4o0/LxaSFGAe9eeWNhbrq1ks+q5Cd6SHPnJoLR6FpVu7c8Rntj6w7rXyuPu
	 8sP8Bra6fZ34g==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 505D6408DB;
	Mon, 31 Aug 2026 21:29:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Christoph Hellwig <hch@lst.de>, willy@infradead.org
Cc: skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] XArray: document that tags persist after storing new
 elements
In-Reply-To: <20260819065714.1358822-1-hch@lst.de>
References: <20260819065714.1358822-1-hch@lst.de>
Date: Mon, 31 Aug 2026 15:29:50 -0600
Message-ID: <87ik4qger5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christoph Hellwig <hch@lst.de> writes:

> This is a very useful feature, document it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/core-api/xarray.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
> index c6c91cbd0c3c..9a0d930a8c79 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -127,6 +127,8 @@ by using xa_set_mark() and remove the mark from an entry by calling
>  xa_clear_mark().  You can ask whether any entry in the XArray has a
>  particular mark set by calling xa_marked().  Erasing an entry from the
>  XArray causes all marks associated with that entry to be cleared.
> +Storing a new entry that replaces an existing entry keeps the marks
> +associated with the index intact.
>  
Applied, thanks.

jon
