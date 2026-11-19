Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082691;
	b=Ubudxbjyszmh9waj9+KKgtmucwkWcbdJLpCSpTZ8qrvRZrL8AbBsmjlTaXyycPHsO1Vm
	 PleKkG32zsXBDW8H7VTKhoWbHdCcn/GGsvL38VnHNR74M3JBZT6waexWsj+Dw4rfRZHcJ
	 CURiaCPis/fq6zoOYclUgKR7VOwktPRa3BCYsG1/PzBFJ0AHw0OVN/Kd/uElHOSPKWMa2
	 taKmueqD0ZAjnVE55k+xt8uLCRM3y/aOIpc+/H3An8R462OJqWjO/GcZ1t1ZVo7+lMLy8
	 jELswxG3c5LEopOR2fGBkMgnXojeNvAf+8xXDCS5pzJgC66REdbRJ9fFwPZ5bBd3xOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082691;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=rr5ZFT5ZcgDyOCKRYwikwt5oVr+KWAPOlhB6uIOoL0U=;
	b=GbEvzN4Dr6h+xQ+Vm75/DXoMoEpsaHPRoJ/hM9weFi4jnZhXV0SlxUKcX6JUfZWTfdFQ
	 HtSchp88G4cFdxebXlO3pM91n5Ysy/9xRAkUYtl61Sm/ouQ7yA118zbNHo/bJyvjEF4P3
	 rv7J8CpLLfDg15kuiG97iqQbHO1oSfnEj6mK7X0Wtx4WqlHpGrf+WXDP0NShEPP9akvW1
	 ktt1moAjB+FLLgJtW2eZ+WEmQ6RCrGd9J/IB7vrkG7yrsC3ELY+xr1gBlSK4CEeN/5Jyg
	 S8DK/diZQeQGDL4RUc24hOnEcwLv2EaoQC1MbIjZ1hvbi+vC4sBAP3JlDK/HDZ02YNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mOZ75kp+;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="C/T7BPSH";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mOZ75kp+;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="C/T7BPSH";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CED606A320;
	Thu, 19 Nov 2026 10:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55CED606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mOZ75kp+;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=C/T7BPSH;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mOZ75kp+;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=C/T7BPSH
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CB451F7D2;
	Thu, 19 Nov 2026 10:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795082689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rr5ZFT5ZcgDyOCKRYwikwt5oVr+KWAPOlhB6uIOoL0U=;
	b=mOZ75kp+8euuYZElFoQETC2Bu4+ZygBPKU799/sASUntaGV/0c0vBhhgOvLqeeXAVFuI5n
	IUnCRRon+g4/ZoTLE+83LgR+3LcKlPJKO30teTuww8GPVqTE0xuFQQsuzOrkU/4gVzF8qC
	kTixyN3JsW8YyDXO8/3H/sWXC/3tJh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795082689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rr5ZFT5ZcgDyOCKRYwikwt5oVr+KWAPOlhB6uIOoL0U=;
	b=C/T7BPSH0M+vvqcalxvzTU+PhfqDMVIVA9kJdLr6+PaC8qaHFEk6WmO+5W3FZ3y7yiYlA5
	KvfPPBG4TtttJYAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795082689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rr5ZFT5ZcgDyOCKRYwikwt5oVr+KWAPOlhB6uIOoL0U=;
	b=mOZ75kp+8euuYZElFoQETC2Bu4+ZygBPKU799/sASUntaGV/0c0vBhhgOvLqeeXAVFuI5n
	IUnCRRon+g4/ZoTLE+83LgR+3LcKlPJKO30teTuww8GPVqTE0xuFQQsuzOrkU/4gVzF8qC
	kTixyN3JsW8YyDXO8/3H/sWXC/3tJh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795082689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rr5ZFT5ZcgDyOCKRYwikwt5oVr+KWAPOlhB6uIOoL0U=;
	b=C/T7BPSH0M+vvqcalxvzTU+PhfqDMVIVA9kJdLr6+PaC8qaHFEk6WmO+5W3FZ3y7yiYlA5
	KvfPPBG4TtttJYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46A381334C;
	Thu, 19 Nov 2026 10:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K9YNCcHJ/mo9dgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Nov 2026 10:04:49 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id CB4BF25192; Thu, 19 Nov 2026 11:04:48 +0100 (CET)
Date: Thu, 19 Nov 2026 11:04:48 +0100
From: Jan Kara <jack@suse.cz>
To: mdshahid03@gmail.com
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: sync: fix overflow check in sync_file_range()
Message-ID: <zwxt7yvljy7znovloyduos7zkkz7eelu7xd6qzkrl6io36bkq7@ecppjcso6uao>
References: <20261119053827.69933-1-mdshahid03@gmail.com>
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
In-Reply-To: <20261119053827.69933-1-mdshahid03@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80

On Thu 19-11-26 11:08:27, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Use check_add_overflow() to detect overflow when calculating
> the end byte of the requested range.
> 
> Reject negative offsets and lengths before performing the
> addition.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

> ---
>  fs/sync.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/sync.c b/fs/sync.c
> index 4a84dd837b86..a1ef2b619cfc 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -10,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/namei.h>
> +#include <linux/overflow.h>
>  #include <linux/sched.h>
>  #include <linux/writeback.h>
>  #include <linux/syscalls.h>
> @@ -233,13 +234,10 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
>  	if (flags & ~VALID_FLAGS)
>  		goto out;
>  
> -	endbyte = offset + nbytes;
> -
> -	if ((s64)offset < 0)
> -		goto out;
> -	if ((s64)endbyte < 0)
> +	if (offset < 0 || nbytes < 0)
>  		goto out;
> -	if (endbyte < offset)
> +
> +	if (check_add_overflow(offset, nbytes, &endbyte))
>  		goto out;
>  
>  	if (sizeof(pgoff_t) == 4) {
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
