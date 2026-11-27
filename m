Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788923;
	b=Ca6JXsLQRMYLomRSjJBE7EqGpU70fBP1YCEfWW5dz69uOX9NsZHrfcHHBb8VBpQSvizl
	 RRYQVDfgoxizKEFdvn/r5PF8u212gqYQ1Nkevh1wxpVw56DNKgUYaFV2iEJDnlRp1QKT+
	 0rNaG32xBljuidDZwRNchRgSRcAQECi1Wf3nAIBeNWdme2OLXa9cOHgfoLGr3r6kv6BQu
	 NWgxxGoJuRTCiIkhTlz/JruK7ytCEKaLtqXRyRYGjlTY715nZW4reDylipnN4ipY4aKa6
	 lWDgtO049j988rgbvI666h190nQaRvRvzhw3fSL12HstLNGlVEBL3rqK66/7MiWye7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788923;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=zm5HgLexkIzO9o88jjOFrQoNm8RyPdC5z8G3Ky1lEW0=;
	b=dFI+U2oLoCoJmm51zypL+JJ4gBgEVYzaKOjNpORSdIx81+btDV15OyvsJ5N/kuFjFPGg
	 mrjRuuKTDRR0QdPj0kdFzy5Q42xTykSwMhgtVcU1ALvq6YxQbx3OQB91E+VCmRvgF0m7p
	 /WGh5ia3DO3qS41DZCPAJNCfmDjhfcGHId1RKPjoy1KNucUcDIowWZcMK56miBPWymVLQ
	 1U2KZcRC9zUGmEzLcRNjaa52pyuOWnWIdxaamEQWJYPGlp/CBzAzjmT7kjRL7Y0l8z6kk
	 i7vk4W5lKX/5v8u18mYqqdFH4acqZxFvGSA9+BdbHQATsufB9di/R5gsYjG9paHQLWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="dDiKtPw/";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tFABnZzj;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zKLmsAoX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/LSE7vgG";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1681606A31C;
	Fri, 27 Nov 2026 14:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1681606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dDiKtPw/;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tFABnZzj;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zKLmsAoX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/LSE7vgG
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A29A21C38;
	Fri, 27 Nov 2026 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795788921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zm5HgLexkIzO9o88jjOFrQoNm8RyPdC5z8G3Ky1lEW0=;
	b=dDiKtPw/nC+D9cUqXY1TRKPGmeGmCDtrvrKXDHE1epD6+eAAmdoNoHcoChzEuMqzNtlAde
	LsXi2sjkYvIbL1+riQpH8hv1Gfx/vJKyriY+wW2IGmwj07UO7VLM+zJ+bpJdlEv6vRh+5G
	XNpStAJtrl1noal4l+u4WOndZfrNmks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795788921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zm5HgLexkIzO9o88jjOFrQoNm8RyPdC5z8G3Ky1lEW0=;
	b=tFABnZzjM3bw85wYLsEuNX0aDMVLVbPQeyuaZdggSWYisHEPALZo1O1pZY1RVF9aLRaqQl
	swaTXa79s0BBf7AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795788919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zm5HgLexkIzO9o88jjOFrQoNm8RyPdC5z8G3Ky1lEW0=;
	b=zKLmsAoXlrklj5qlixQNUNQiUhy2jLg5c8laCoztk2WZrjsE5MYOB85WOhAybLZQmmFyZH
	WRIg8pXMstld6jPLR5hYai7g3qVob/Z0Yb0Ks8g+HgxkhjgBdUhM0hixHgZuHpV3DAUElC
	3+lAvMcffYWn+S1joF69VWTsXHCsGAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795788919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zm5HgLexkIzO9o88jjOFrQoNm8RyPdC5z8G3Ky1lEW0=;
	b=/LSE7vgGMw2cbLNHKJBGY5dqEYlrC/nIgoBpFXMsyhqyGQRPPH4MlEZXJUSkR9dDyBXzMF
	Tyggd6SHKXGiDUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2660A13432;
	Fri, 27 Nov 2026 14:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9YUGN3aQCWtuRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Nov 2026 14:15:19 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 703AF51044; Fri, 27 Nov 2026 15:15:18 +0100 (CET)
Date: Fri, 27 Nov 2026 15:15:18 +0100
From: Jan Kara <jack@suse.cz>
To: Arav Verma <svav2021@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ramfs: drop unused includes from inode.c
Message-ID: <fbih3mrqnvkhwq4gnelh26lfnqnilns22ndlcwctiviwqheboz@5as4xwg44ls2>
References: <20261126175429.1035841-1-svav2021@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126175429.1035841-1-svav2021@gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 26-11-26 11:54:29, Arav Verma wrote:
> inode.c includes <linux/highmem.h>, <linux/time.h>,
> <linux/backing-dev.h>, <linux/sched.h>, <linux/parser.h> and
> <linux/uaccess.h>, but it does not directly use any of the symbols
> they provide. Drop them.
> 
> Signed-off-by: Arav Verma <svav2021@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ramfs/inode.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index ef91b933d4e61..a8c14fca06561 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -25,17 +25,11 @@
>  
>  #include <linux/fs.h>
>  #include <linux/pagemap.h>
> -#include <linux/highmem.h>
> -#include <linux/time.h>
>  #include <linux/init.h>
>  #include <linux/string.h>
> -#include <linux/backing-dev.h>
>  #include <linux/ramfs.h>
> -#include <linux/sched.h>
> -#include <linux/parser.h>
>  #include <linux/magic.h>
>  #include <linux/slab.h>
> -#include <linux/uaccess.h>
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
>  #include <linux/seq_file.h>
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
