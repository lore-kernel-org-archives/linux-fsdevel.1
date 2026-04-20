Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277913314C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699613; cv=none; b=qCl4DCyjxLeFNpUNfgMS9EPtGltPVK2qUIz8SNDV2ES4B9AwSfgjokMrGBXCIs7Ny+aK5X5ZhC2W8NHsnQ4GpTLY/XabT+brS7vue7DPTYrzXshXRl4IdCZ+32e6ORrPMPNoJT80oAq9b2xifmqpND+PruPU3ELv5vZpHcBpBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699613; c=relaxed/simple;
	bh=QiXlTinGBxBkdfJ2+6qE/Sah+58tkMz4QxFb+ySkceY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/zx1SznCC9I2iGRkANFJEo2jxcxzNEIq48y/KKEmsPEFiPiFSnw4G0J5TTJrex4LiVNQZSnY0PVxi3cnRV6eU5dmJ7kNFgLKcxY4sFLCJAxOtUaATXzYoPXOt0jR2v9ba3+6csnOz7ImHGS9OVWi6bhb4ET7XtafeHs8mjlmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VMeZVyp4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3kXB+RXx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R7QH2JCb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pXvnrAsQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VMeZVyp4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3kXB+RXx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R7QH2JCb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pXvnrAsQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7487E6A7DC;
	Mon, 20 Apr 2026 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776699610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgy0vQVPxY1Dre6IfmtgmAR74pTXH0nOi9tlCICeDVo=;
	b=VMeZVyp476pTfcKj92YDSRei8o161ncxr7vS8pgAkkf6qRsGqAAaeykecpcvcHrl6xHnqp
	evI7GK9JKyi2g1yy8o1COygJM76KOyXC9eKka5UCuqibY5txNhUGdmRreWew+uzxvkTurK
	AUYdgIR0yiWbd2Obu3AA3BUcHg6SO8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776699610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgy0vQVPxY1Dre6IfmtgmAR74pTXH0nOi9tlCICeDVo=;
	b=3kXB+RXx//wdmyrJ+iylpzhLdiRav/yy0uQASNA5nkm5j3S0WuWZkZgIFm8l8sq3wcsLzP
	mtEXKtYtQ64oc2AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776699609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgy0vQVPxY1Dre6IfmtgmAR74pTXH0nOi9tlCICeDVo=;
	b=R7QH2JCbpjpHvXQRRGI8F4QlIyhOTC2HTn9dIUrEbtS2cyvRzQFQ2q4jIuGIDUqjiN2Fhi
	TqpOf36lqQRcjLGc76ayw8mmrmfbT35WWoGdYRChEfIeMgW2y8VCEe2T8nAmrqVEEMe+kb
	vFC4wJtIux7SuL2lKSFcIAqNbTXPapk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776699609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgy0vQVPxY1Dre6IfmtgmAR74pTXH0nOi9tlCICeDVo=;
	b=pXvnrAsQ4YlTe8rcQi3K1ZTiaXO3D0Sgs0fbvA6xBU7QzY7sWr2Vfpq8XdOT5xjpQfhLWk
	G5QVMwFyx8sSRFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 680A6593AE;
	Mon, 20 Apr 2026 15:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xrFkGdlI5mkbMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 15:40:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 069CDA0AFF; Mon, 20 Apr 2026 17:40:09 +0200 (CEST)
Date: Mon, 20 Apr 2026 17:40:08 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pidfs: return -ENODATA from pidfs_xattr_get() when
 no xattrs exist
Message-ID: <ucaltrwleuersdar2ldd4ueoh7e2xiokwuqc7obj2p7lezn4g6@k5jhcjwga5wy>
References: <20260420-work-pidfs-v1-0-4bd614e1cb33@kernel.org>
 <20260420-work-pidfs-v1-2-4bd614e1cb33@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-work-pidfs-v1-2-4bd614e1cb33@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 20-04-26 15:32:36, Christian Brauner wrote:
> When no xattrs have ever been set on a pidfd (attr->xattrs is NULL),
> pidfs_xattr_get() returns 0. The VFS interprets a return value of 0 as
> "xattr exists with a zero-length value", causing getxattr() to report
> success for non-existent xattrs.
> 
> Return -ENODATA instead which is consistent with what simple_xattr_get()
> returns when an xattr is not found.
> 
> Fixes: 5c1e4b9db95c ("pidfs: support xattrs on pidfds")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Right. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pidfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 11eb53f3e50a..2ab8fd2646f0 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -1023,7 +1023,7 @@ static int pidfs_xattr_get(const struct xattr_handler *handler,
>  
>  	xattrs = READ_ONCE(attr->xattrs);
>  	if (!xattrs)
> -		return 0;
> +		return -ENODATA;
>  
>  	name = xattr_full_name(handler, suffix);
>  	return simple_xattr_get(xattrs, name, value, size);
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
