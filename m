Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D95C613;
	Sun, 12 Apr 2026 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775979472; cv=none; b=kqn4vtuakMXVZ/PN9HyjScRh86ju7rs2lgW42IrpL98fLSu6OG5q3WGDLGXpRljUyjp0S1XYkxSU/ZzWeSYSTBweizzUa0+udLscm0wfbcV1vhYRoD1wK19I6lNUdSjF2B+54oFDb6Kx9cS5GA0j1uq2w8TvfL6uqIWSsIY9hds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775979472; c=relaxed/simple;
	bh=SSIUhJU80+447hykQM89Kd0Bd2wiCduRayjO9PAew0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p6p4s2Kw92SPPGJK0F11fyLxfYpgrXEtSbB2cxrYl7yxDyELGB+uTL5Uxem9bQTgnwpserux84h9KE0EPQfYkgMtGw1GlMCZRMjRJk5PsbUQHhK+KAuNL5JRLJTyOjJoChP9VU8/5HNfqxhQNmarTOaIpDakNo7suD+b3u09VEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=ntdgmlez; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=hcqgPiGl; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="ntdgmlez";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="hcqgPiGl"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id DB7CB26F765F;
	Sun, 12 Apr 2026 16:37:48 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1775979469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ezdJFUdQHPMTWeWoJ/LtRWVv2fY4x7jWAP3znNXtYQ=;
	b=ntdgmlezQXcDKUx/0aJGoJhB5V1AUDKSt+gzJzKXClGVS/JCZd6JjXNZldEvySCah3oCKa
	4+RuysSBY/LTAfmtlrzVbC3vNxjnWcAaTK81euWCc0UeRfx+1brZYeTL00koHt6p9sAR4B
	v6yx5D1T0DG+UKfAHu8+HeByrMODkF6Mnk0uFRgvbtbbG+4SIZspcBiiy0g/NypuCn90xl
	wko1SncDLCFB44fxVZV3dwgxzSZ9CkI54Sb832QuQDQquqoZ5phjGr6sLpSZmmZu+V1qV0
	DNKh0lWJdGHKcIOu/NRZ1/0i6pbaJ5zOkmP9OKSSQgvehfKcyX0JC+g9rLnn4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1775979469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ezdJFUdQHPMTWeWoJ/LtRWVv2fY4x7jWAP3znNXtYQ=;
	b=hcqgPiGl57cdm/bBhjxJeq9lB4MXpu+D6ANg5rcO+OQZ2Gbn73ZMO62yZY2hfMNQ5gvIU9
	EQy9+5tvnAKRh+Ag==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 6A5BAE00112;
	Sun, 12 Apr 2026 16:37:48 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 5E30922000D8; Sun, 12 Apr 2026 16:37:48 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Christian Brauner <brauner@kernel.org>
Cc: Ziran Zhang <zhangcoder@yeah.net>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] FAT: Allow 0xE9 near jump in fat_read_static_bpb()
In-Reply-To: <20260412070109.5197-1-zhangcoder@yeah.net>
References: <87wlyclmvr.fsf@mail.parknet.co.jp>
	<20260412070109.5197-1-zhangcoder@yeah.net>
Date: Sun, 12 Apr 2026 16:37:48 +0900
Message-ID: <87se90ljcj.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ziran Zhang <zhangcoder@yeah.net> writes:

> The fat_read_static_bpb() only accepts a short jump as a valid
> bootstrap code signature for DOS 1.x volumes when the dos1xfloppy
> mount option is used.
>
> However, according to the Microsoft fatgen103.doc, the BS_jmpBoot
> field has two allowed forms: 0xEB 0x?? 0x90 (short jump + NOP)
> and 0xE9 0x?? 0x?? (near jump). The specification explicitly states
> that either form is acceptable.
>
> This patch relaxes the check to also accept 0xE9 as the first byte of
> the jump instruction.
>
> Changes in v4:
> - Add original commit log
>
> Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>

Thanks.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>
>> Could you add original commit log, instead of changelog?
>> 
>> Thanks.
>
> Done! Please ignore the earlier erroneous v2 v2 and v3.
>
>  fs/fat/inode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 28f78df08..0e7d106ea 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1479,8 +1479,9 @@ static int fat_read_static_bpb(struct super_block *sb,
>  	int error = -EINVAL;
>  	unsigned i;
>  
> -	/* 16-bit DOS 1.x reliably wrote bootstrap short-jmp code */
> -	if (b->ignored[0] != 0xeb || b->ignored[2] != 0x90) {
> +	/* 16-bit DOS 1.x reliably wrote bootstrap short-jmp or near-jmp code */
> +	if ((b->ignored[0] != 0xeb || b->ignored[2] != 0x90) &&
> +	    (b->ignored[0] != 0xe9)) {
>  		if (!silent)
>  			fat_msg(sb, KERN_ERR,
>  				"%s; no bootstrapping code", notdos1x);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
