Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740877;
	b=IefwTCWM63s05kORv01mwV8OjfyYG1UWMxk/ihDS2QZ4PDAhc8pW/cohNmLfXPgzhkXT
	 rmo4gligNiwiVo5LtF3QzjIVd5RYCm3QFEGwgNzmIgL5mxOcHKnI4YaBQbABHR7ezvm//
	 rSqe6EZ8Y4v6Pw2dsjgvkAQO0NoFlocHI8WHoWHpYy9nkAYX4QutuR4WTbDtMllHqlF1X
	 bXd4YrrrFnlTP4xJS+4taP5fdnwVnMc0kr11zhp3L5XCSlrlyd3do6WR9nsx6Z94jeV5M
	 DWagV3u8XTeMzKRR8Mnn87C+Sk6hH0TqLlp2s3guRgCaro41SKWtYpFzj4LExo/Euqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740877;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=qOAdMOQY5J9NNt1Z5+wFuHl1BjwJlXA8PuZ3ex4nsL4=;
	b=VttwOyMEBS6H+7U8OOE78Cl2VW64/lXRKCwbxiWacTCgfgtV1SpaBYOeBxdDDwrhulYY
	 OokyqYxPJgJ/fYfrGtlXk5VFBsuJvQs+Wv34JrHmHyff2vlmzhHRosOUqJ+17BuegbWg0
	 6f6buW4sfrzU+O+ckoFTbcienrPE4RrK4ldDzmD/XWk+BKqfSKFutf/9veMPlvnM/M5LV
	 XyJ7S0/2mfLTiz6BTxhw0VxBueT2KTAFiGbR73/v4XB3Nzyc8y+9lxB8sVGoKQYc1k0yW
	 muyxY8Yef7PKM15Wt5UvaCYkoXthGSscScQ2Vvq1YaAcG4Xzb8ZdwcJIpy7HlbKXC5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=e+YncPC0;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=UZTY7ZgP;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D9606A31D;
	Fri, 23 Oct 2026 07:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E4D9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=e+YncPC0;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=UZTY7ZgP
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 0B34B209679B;
	Fri, 23 Oct 2026 16:34:35 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792740875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOAdMOQY5J9NNt1Z5+wFuHl1BjwJlXA8PuZ3ex4nsL4=;
	b=e+YncPC0TrzpWHbqBmRRwEb0a1hn1/1rl6x7AijwDjfqkpBQmB9HVFErtnUsPJBKcE9+Kn
	vlYuSNBud6Y88jGa4xO+voOAWKzN8Jbq7SCTYct5jXpsmTZK0/31d1PaK5uNXp+o5bKs9Z
	FDQLqG1xBhyG/mjXkywJ8I8zytWG02hEJP19UhYEfkJc/aWqbbji3CtHpLS7gf055cqJJO
	7cvtAo7s58lTCzaWJ08QL5Z5M9qzZ0w5J2NIZIyW2T7wv8IymzfkTHj8Pyn1T0DUW/I7lL
	8uBjncuEKx6gMSdkUyDeW6Tpcd2Rgvx4v9YeLB9IoBTPK956j4KSqP2CbrgFZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792740875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOAdMOQY5J9NNt1Z5+wFuHl1BjwJlXA8PuZ3ex4nsL4=;
	b=UZTY7ZgPH0YwwbBomk5NVlBiB4swj+BmyZ0S6upbjLDbLImju45XqRTXKjCF5h5YBY0csE
	eAwp2/zkrgT0XHAQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 8CE06E00107;
	Fri, 23 Oct 2026 16:34:34 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 80A032200179; Fri, 23 Oct 2026 16:34:34 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: hold truncate_lock in fat_write_failed()
In-Reply-To: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
Date: Fri, 23 Oct 2026 16:34:34 +0900
Message-ID: <87se1wj2et.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> The current fat_write_failed() implementation calls into
> fat_truncate_blocks() without holding truncate_lock. Make it so it is
> held exclusive while truncating.
>
> Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
> ---
>  fs/fat/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 141276fcf8db..2a16ed415631 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -216,7 +216,9 @@ static void fat_write_failed(struct address_space *mapping, loff_t to)
>  
>  	if (to > inode->i_size) {
>  		truncate_pagecache(inode, inode->i_size);
> +		down_write(&MSDOS_I(inode)->truncate_lock);
>  		fat_truncate_blocks(inode, inode->i_size);
> +		up_write(&MSDOS_I(inode)->truncate_lock);

Which race this prevent?

Thanks.

>  	}
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
