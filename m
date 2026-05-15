Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3E3644C6;
	Fri, 15 May 2026 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855083; cv=none; b=jGJzc/HRfq16PrD2+2cXd8PRJlaWsNN2nhq7C3ZvmYVKiiQzZ125xYQjKWJBrHD5N6b+U3LQSxsyvoGBMS56Fa5njk/fcCjbVVAlkciZ979heLG8zlHl3TL+qNj9TcfopK76xxl25lGbBlNvXveKftc1utrK8psR9/S6X4Uox7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855083; c=relaxed/simple;
	bh=3DiJgyfPq3xnTtCKRtiC8wm23wJPX8GfQvZtRbZcz3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i2Th3JAWfkG9Ofn84iFZ+DAiy46lwfRE0G7THNoJ2KZ6RVSeok3NLiv0YUCa3u4IvKbES/4vvVfOq94sUplpGCzCvgKZyV6zOMySVm1RHwZwUP5AUvXAA4T7RvLeyt5tQtAehqaF0id4qh8nNx8ftltGtrVLPZ5T1lv9zVpO+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bJbAwpj0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bJbAwpj0"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4A83D410B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1778855075; bh=ohNchLk5gAAU6hAND7s6bUUwHtS10xJjW5wCO8yXh0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bJbAwpj0ZYDzZ6JvkHJobOVegOR8y+qm5UhbcAjc71P6KtqspF3o3iI3TsipuGwPU
	 jhqmjbr1oJgaIBkttPXP01sjz/SvMPAOOcvpi7G+35iX3pNRN/fyt95F+CLgRmH1+F
	 3vnvcB16pBbUabzp4MGoSAjqh6NJPIl6H/xyQGp1I2q1jffZOyRQ1NF/TmY+eC+SCA
	 Vqow3sy+wj6jZQxxCboIq7uSf7MAWJvOoNgxemzL143IhUGT4ePXQIrUS45vnJisuv
	 YYxI0/x8OmtshLAoZrScFow/p/fhl99AUbcZ0Hz+08P5agF5BlU4/jMLDfJhx6c7w/
	 HHH+rK/Ggjc+A==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4A83D410B5;
	Fri, 15 May 2026 14:24:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Costa Shulyupin <costa.shul@redhat.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH v1] docs: locking: Fix stale dquot.c path
In-Reply-To: <20260503160221.1594319-2-costa.shul@redhat.com>
References: <20260503160221.1594319-2-costa.shul@redhat.com>
Date: Fri, 15 May 2026 08:24:34 -0600
Message-ID: <87a4u0rbrx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Costa Shulyupin <costa.shul@redhat.com> writes:

> The quota code was moved from fs/dquot.c to fs/quota/dquot.c
> in commit 884d179dff3a ("quota: Move quota files into separate
> directory"). Update the reference.
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/filesystems/locking.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 8421ea21bd35..277e49314d32 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -584,7 +584,7 @@ write_info:	yes		dqonoff_sem
>  FS recursion means calling ->quota_read() and ->quota_write() from superblock
>  operations.
>  
> -More details about quota locking can be found in fs/dquot.c.
> +More details about quota locking can be found in fs/quota/dquot.c.
>  
Applied, thanks.

jon
