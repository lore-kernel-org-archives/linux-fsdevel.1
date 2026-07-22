Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BEF27F017;
	Wed, 22 Jul 2026 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737031; cv=none; b=Ysi5i6KprX6GZBnSm6j+75bQnFTfhPsPzO6L8g/eomib1DJSlZ1I/PxxHQIWskBNfL63PRueZ8bbjxtzeD3Gjh4Z1ohouFSl0GO+9J3OnderoCgauK5Dcz3n5tckmKtjrmEid8UQfKbIyp9f5e1F0iP4I/Osw40jdX5ypb9iOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737031; c=relaxed/simple;
	bh=ZkUR2/lrE1+NGNslP/RvXuHv6R8c1mVO0x17JOkQVZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uqZRE0ctkKJPf2DrZ+aallwvk8rqIJHbuk5KwZESf4ouGbadxxdf7e9ilNXYJr4m4S3yWwUPcy2EjyrpalR+eClOyUPaBAxCFMhrCcrP8YWInYAkgaxoaa3DXMyVjOJ7rnduMZ3CSmvDDxHz88DMgrmGVUME5wFIS4xRBrB84qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BRtGFj0N; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BRtGFj0N"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F2145408B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1784737029; bh=fFd0MZZ4RASB/FXpamv5r4UwbVLj3uli8OWMg4Ec4mM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BRtGFj0N5YOuZHWIlS0Ncm35gkHPY/Wh2EgaVFfZc+vR6Khgh/d/2UNiP9uJdT7z1
	 nyrO2hlD5W3U8M/9+/x0Wj1dGbZRp7UASLFU9YOMClfJLxRwj3J4iajf3ZXLr+7E1r
	 zs88dHQ9LK6LBPRB9slH3zvMOJAP1G9Mn0WdaufbSEw3jFvSuTUS4xpNiHI4NfGwnx
	 1Y8a9WVnY752UAke+Yv/I72FyGL1lG5e8RfWST8CcCXkxfWvISp0fMMqzMNMgq6kJ0
	 Wa7a72av1B40QrdD98xFlMMKMskfrMJV1vOi9Olda4PMG5wkIYY84HYQZoinhU1ttf
	 63QS63lbTXfFQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F2145408B4;
	Wed, 22 Jul 2026 16:17:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yahya Toubali <yahya@yahyatoubali.me>, Shuah Khan
 <skhan@linuxfoundation.org>, "open list:PROC FILESYSTEM"
 <linux-kernel@vger.kernel.org>, "open list:PROC FILESYSTEM"
 <linux-fsdevel@vger.kernel.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>
Cc: Yahya Toubali <yahya@yahyatoubali.me>
Subject: Re: [PATCH v3] Documentation: proc: fix repeated word 'page'
In-Reply-To: <20260718165613.1923550-1-yahya@yahyatoubali.me>
References: <20260718165613.1923550-1-yahya@yahyatoubali.me>
Date: Wed, 22 Jul 2026 10:17:08 -0600
Message-ID: <87fr1bc83f.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yahya Toubali <yahya@yahyatoubali.me> writes:

> Remove the duplicate 'page' in the sentence describing large page
> allocation accounting. The extra word makes the description confusing.
>
> Signed-off-by: Yahya Toubali <yahya@yahyatoubali.me>
> ---
>  Documentation/filesystems/proc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2ccd5b2dfdd3..d22ac0addd42 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -513,7 +513,7 @@ In some kernel configurations, the semantics of pages part of a larger
>  allocation (e.g., THP) can differ: a page is accounted as "private" if all
>  pages part of the corresponding large allocation are *certainly* mapped in the
>  same process, even if the page is mapped multiple times in that process. A
> -page is accounted as "shared" if any page page of the larger allocation
> +page is accounted as "shared" if any page of the larger allocation
>  is *maybe* mapped in a different process. In some cases, a large allocation

Applied, thanks.

jon
