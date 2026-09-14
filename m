Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF63EDE57;
	Mon, 14 Sep 2026 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376314; cv=none; b=pP12UncF6Nq0vGnKt7ZgB/50KBHjfbYRjjCGg0o7/q1dFq9f/KeIk/ZfQUQWELIpuA3IAgPxULurtgII6WH+jut2uy8aI/wH2TwWSPGSiovJwpUjYniIn8s7vNuJ1/rz+nttbMz2Z31VMpryvKTphZGC4Bhla08jyOhoKKCFd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376314; c=relaxed/simple;
	bh=URW+D55Zaj1H+1e8Wc47SZAZ3Zjfnv7jZB/hTCscd58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HESJS3a4rAkW7+55l+JgKlz0YaZ2Jznp+5HTi73SA63ivCcFJ55ubdJuzxAUOmSDC/L7A1uQCH4es51c84/5HSgFS6DYHzSZI7NkUi7rEQ/qeTp2BXlPQxnj+ArLZBXC82kEqOplgXaciKMtYlfIG4VP28thhwMiIwR/mnnFBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g/REWvkG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=it+OpSDU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pTIurPMn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nPlLE99o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g/REWvkG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="it+OpSDU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pTIurPMn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nPlLE99o"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 438CB1F78C;
	Mon, 14 Sep 2026 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789376302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QsYSzC/D2p1a10rGYi8Ge9udgVfP7eo/Qash7KKI/ZA=;
	b=g/REWvkGjzPnPCmAaGubKriSoQo/nK+QJhaUitdmikIYf0tP60nrb48XziZ/waDbkfsK0t
	JccynHJ6nQ3q5R/xZ2Kl7cV08xkgBekve50UYMQY0MpmWVVHXONy2lXcAWL5/ic50QSiLv
	4/Y7uiGZTxnFWzR25kQYg4crSMwysgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789376302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QsYSzC/D2p1a10rGYi8Ge9udgVfP7eo/Qash7KKI/ZA=;
	b=it+OpSDUhTObqpTj1q16v9tV19CfFYQebC5uRZhCooFRdyKqtqiel2h2306CTKkpntii6J
	Sb3F/5HbOigxhnAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pTIurPMn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nPlLE99o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789376298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QsYSzC/D2p1a10rGYi8Ge9udgVfP7eo/Qash7KKI/ZA=;
	b=pTIurPMn1/ZoeWcCgDrztLM7y//76Y3EORn9OAWURzNP2TCPqsDL7z/1RqEe67CW7Ez33V
	t+s+XNdq6L18l2VlJv5p73gKjprwCPV3ZtfGr+8ze9qVN6TO8h8QLX3K0d24guwaeSIX2S
	fMeRzPga0xptiLNoWcLKxt2oHWEtQho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789376298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QsYSzC/D2p1a10rGYi8Ge9udgVfP7eo/Qash7KKI/ZA=;
	b=nPlLE99omms4idY+yshlNBTFYSZ45q8u6Uj1kvw171Q7ImNk/otNC8RLCGIg2TcFuXswpv
	AOjuRFt+i9x0jRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D3421368C;
	Mon, 14 Sep 2026 08:58:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZgwbByq3p2qoMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 08:58:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B426FA12E4; Mon, 14 Sep 2026 10:58:17 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:58:17 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/10] autofs: use path_create()
Message-ID: <sp24d3pr4yxzcurtd2otdt6xmm5zbbh6gvzjcwybxmj5ilrb7m@jiq23l4zyvm2>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
 <20260913144918.1606123-8-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913144918.1606123-8-mjguzik@gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 438CB1F78C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

On Sun 13-09-26 16:49:14, Mateusz Guzik wrote:
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/autofs/expire.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
> index 5c2d459e1e48..9d19c47dc3cc 100644
> --- a/fs/autofs/expire.c
> +++ b/fs/autofs/expire.c
> @@ -30,12 +30,12 @@ static int autofs_mount_busy(struct vfsmount *mnt,
>  			     struct dentry *dentry, unsigned int how)
>  {
>  	struct dentry *top = dentry;
> -	struct path path = {.mnt = mnt, .dentry = dentry};
> +	struct path path;
>  	int status = 1;
>  
>  	pr_debug("dentry %p %pd\n", dentry, dentry);
>  
> -	path_get(&path);
> +	path_create(&path, mnt, dentry);
>  
>  	if (!follow_down_one(&path))
>  		goto done;
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
