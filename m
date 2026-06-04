Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D10285CB3;
	Thu,  4 Jun 2026 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554197; cv=none; b=LszBJ5VilOFi/VFOBDdYgTfRA15Krf5YeVnT+Z4C3m1NtOwpyHsGoDfVOcGGQeJnzouI3ian4uNTkbQrfH4gJRsRhaR4mv3RRqSEzu9xEUPGcd09qYSUnD9brVjsKAuDY76YMZefSb2TdN+wSP1RSOyzciEErwG6JkheHcrH/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554197; c=relaxed/simple;
	bh=KwddaKEhdD86dKjIi6k0PhBR6UU7wp4wjpqFD2plCck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3Vp/Ieo3U+tX7eMtD7HPt0hAIEi7VowjeuM7meVVK9PrtJSsqTUn1grEm/tRHYl2EARP8iFWgQoEvRXe5DNY2yObb87CwfjxAy7uqR2Q/a554+zy/AFgg9p+oAW050WhDCsT8toSBG2SMLXkvFYImh0qK5ZbTmiJcmYJ4VIXzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=pzdmrbjQ; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=0BExxRHn; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="pzdmrbjQ";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="0BExxRHn"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id DD70D26F7658;
	Thu,  4 Jun 2026 15:23:06 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1780554187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msWQ4QwpSFejMoeCrnrFK3WaUEGeaZ2Zo6i8ASz/SC8=;
	b=pzdmrbjQXwgAdMrj/L2Xjfi8woDL6Y29D3ySHmLEusFqF3XWd7DwN+Q+Gq5j5sRbILAsCo
	gru+73uhvpaZPzoEHoNhbZ1vjkqXMBXU8GEYfCC8YLPTkL8bE6zUK4gYBh/gvLcFvGVL1F
	A2/kUGcytrcwQgUVLSgIVFqI23/BfbDfTM/oURqPZlXEjE5T7b45uQ+lVXmUd7tyOf7nK1
	BOqfnshu0WbSDDmoy+HKIBim16I8bsgk+Pc+YPKyiGlae6uy3NOIt2GcxnQ7YOeliMJAjo
	ncUTxQX7vd/cKIX6in1D89g8cQdQwpp3P6Bpp/3h5xgF48shxIFy2neMsGiy3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1780554187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msWQ4QwpSFejMoeCrnrFK3WaUEGeaZ2Zo6i8ASz/SC8=;
	b=0BExxRHnflSuCGNge8yfLE4817DBuRpW0LcJ1Mr4m0HXR23l0A34PoSy5cBlqsIud0OAH/
	+zu+Q45bBbThqmCw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 6BBD5E00094;
	Thu, 04 Jun 2026 15:23:06 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 63E9222000E3; Thu, 04 Jun 2026 15:23:06 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Maxwell Doose <m32285159@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] fs: fat: inode: Replace sprintf() with scnprintf()
In-Reply-To: <20260603145222.59012-1-m32285159@gmail.com>
References: <20260603145222.59012-1-m32285159@gmail.com>
Date: Thu, 04 Jun 2026 15:23:06 +0900
Message-ID: <871pemx1rp.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxwell Doose <m32285159@gmail.com> writes:

> The kernel documentation notes that sprintf() is deprecated and unsafe.
> Replace it with the more preferred scnprintf() to help with hardening.
>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  Test compiled only, as the only functional change is the addition of
>  bounds checking.
>
>  fs/fat/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 28f78df086ef..b032bbc6855c 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1786,7 +1786,7 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>  	 */
>  
>  	error = -EINVAL;
> -	sprintf(buf, "cp%d", sbi->options.codepage);
> +	scnprintf(buf, sizeof(buf), "cp%d", sbi->options.codepage);
>  	sbi->nls_disk = load_nls(buf);
>  	if (!sbi->nls_disk) {
>  		fat_msg(sb, KERN_ERR, "codepage %s not found", buf);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
