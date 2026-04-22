Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA293DA5BE;
	Wed, 22 Apr 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861855; cv=none; b=IqltHPGAMq6UzfWXMJrcztYhSXDOcvddYNDHDl+4KgiGOkDcA0wdFYeHBlpkaJxd81Was25vvtjjY/Jt2AD3pQ+rZ+tnwc2948Fko3p+LmB8MTY096XIvQlc69gW/75Dkc7KYP0XcBxLWta98azaBM9J7NagcdwvD3GqgoUAhDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861855; c=relaxed/simple;
	bh=9cHl0diwcKEB3vKav7ioffl/oS3DH9T9PGGKHFP4t2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQEKDyMCDpgwLpmveDosFtKwNPbJ/Ufs4/mDQrnqH4dMa/Zy+JjhYMrl7IN4hiE5nLOv8kAzBgL4y6TEVuUInxGUMm5ZmdbfBGhAZ/l2z8+HIhkx0fUD7XOwWsLd6YJHPxLjS+T0dY9LHfPSHDMsIeJL0eUxQL6L4Kd1eHFQcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAd4B67E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAd4B67E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DEBC2BCAF;
	Wed, 22 Apr 2026 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776861855;
	bh=9cHl0diwcKEB3vKav7ioffl/oS3DH9T9PGGKHFP4t2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAd4B67Em+JJDgKcyZfqfbJsIn6GwDz4NX21pCWwKw3XPI1UNx1sxeWE+UXws8/Xi
	 4pH67x6cv7ZhXGsqXFdDIThIyN7gLW6dx3XFjTsl4BKllpD2ONXKnwK/iz4W7eTX+n
	 FrfB8aDnaetxKdZ/XtrEFyq0CbTazRLtuvXcfeqf0UyIzrPLoFpzku3cQdqIjHNOUN
	 HJpBv2aKjMVSRy4hgojh5oZ1aOGvXWZmOevAe4iphMxM/JtwYhf2sj4LmlqbMdC74F
	 nOrfURh7iKZOIne/h1YuMxfmN5ePHGckgEOWNU+GFrxf4UkuBQxScgd0cVzdNyx8lU
	 V4wOOn7KexChg==
Date: Wed, 22 Apr 2026 14:44:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] fs/coredump: reduce redundant log noise in
 validate_coredump_safety
Message-ID: <20260422-naschen-einbog-ed4f52ea472a@brauner>
References: <20260410080918.2319-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260410080918.2319-1-lirongqing@baidu.com>

On Fri, Apr 10, 2026 at 04:09:18AM -0400, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, writing to 'core_pattern' or 'suid_dumpable' sysctl nodes
> always triggers validate_coredump_safety(), even if the values have
> not changed. This results in redundant warning messages in dmesg:
> 
> "Unsafe core_pattern used with fs.suid_dumpable=2..."
> 
> This patch optimizes the procfs handlers to only invoke the safety
> validation when an actual change in the configuration is detected:
> 
> 1. In proc_dostring_coredump(), compare the new core_pattern string
>    with the existing one using strncmp().
> 2. In proc_dointvec_minmax_coredump(), check if the new suid_dumpable
>    value differs from the previous one.
> 
> This keeps the kernel log clean from repetitive warnings when
> re-applying the same sysctl settings.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---

That warning should very much serve as a reminder to not use that
completely unsafe pattern. So no, move to newer coredump infra or use
absolute paths, please.
