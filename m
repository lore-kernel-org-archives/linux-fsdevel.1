Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792869986;
	b=M4yeBXLAMBDIJLK6uGjDpqiJX5vqkH+DiOBVnX8hHWewnhyjOV1nEqOzd9KSpS9jrGlI
	 EXMTnHQgdF8QQlOMKJ2GEL+laugALPq/v5Ie7On1j4LHZjfYXqd/r+bOqnr3nyff//YeG
	 3lroHIqgrijBHf2V3bPww0ANffeoazCp2dyvdoLZjOQabWvtxA2sZPekj6pOpM6sbaGD9
	 +/YKPrgh6LtOzyAfRJqlswRenN2M8ff81zbeHToFHdGrhLemPrSQLSofz6PZC73xJNnAG
	 o1bvCBrDR+KuLx/IzmqXcNyXeGAGf8S2M2TFwZ7ABqATbrSGFOKZXA6Ef95pYKHevNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792869986;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=HbWtKqfEcMXmhglN97SFA30Y04xtFkIiSv8/w3Nngd8=;
	b=Mxh9ZINUcKoILvws+8WFXWxdnIRjo7pbPsOQ/1z6j6W79n9j6TB6igNbQNMrHOh84BPO
	 PjWK6f0QTuXjRHzBaOjxUQlEr8oJCvEbEeZ7jXivK0vhCGuOdI3TMfDMyGAgCV4mvnola
	 ffTbNfsafVk+J2ZiAaA9vIoraMdDzm2mteC/RVyQNkth8unu0QjbP+lkMnNqINZfvEfKm
	 YUs0jTDKmbgnn8LW+qiqvgythLEZqa5yAXc1CrPGaGy9L6YTmuAulFHVbSraDmO+e7GVh
	 ZocJP/rXGOT0pwnpHrL9qiDky5iBlemzorhXM7Ziuw12l6rdmkR3Z2WFtdtJ7RI1XTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=uhcXSF4K;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=xWGeEaxY;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5C606A31A;
	Sat, 24 Oct 2026 19:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B5C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=uhcXSF4K;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=xWGeEaxY
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id B2A5D26F768C;
	Sun, 25 Oct 2026 04:26:15 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792869976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbWtKqfEcMXmhglN97SFA30Y04xtFkIiSv8/w3Nngd8=;
	b=uhcXSF4KzM5hOBQ92vOUApRG0bdFPhT/SMmHbjEQji8z5RCJIK776DF2Kt6QmLSaKjnG2B
	NOnzZ9S/YvJTZvOYM7qeEbpctVQviQQ5ughreoYHCF71sQHb8m2w8sDpt1F5Td/y4OMSue
	SbaLCiSf85u08dDcdj833EP1TcM2aWp0pirReB2H8rttp2uaNpjQ1FZaetaoujTGSLmV3H
	RzD8xhkPnARmn7I98ViAis2BJrXajfECRF0FVG0VRtgNVcOJLdR7xluprY2SrZKMq+fsFy
	IzGm916sMreWWd4URod4FSNilALTopwxRfxyNrZRUdop9xuTAt4WZr0tFVfFFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792869976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbWtKqfEcMXmhglN97SFA30Y04xtFkIiSv8/w3Nngd8=;
	b=xWGeEaxY5LNKc0nT0lk7xacshmKoSVkoorNyU8w2spibF6ghopbWv2T4SwQt6F+9mbUtOu
	JGizgiPmtfuLqcDg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id F41D8E0008F;
	Sun, 25 Oct 2026 04:26:14 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id E5C3522000A4; Sun, 25 Oct 2026 04:26:14 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: hold truncate_lock in fat_write_failed()
In-Reply-To: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
Date: Sun, 25 Oct 2026 04:26:14 +0900
Message-ID: <87a4o2dhnt.fsf@mail.parknet.co.jp>
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

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

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
>  	}
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
