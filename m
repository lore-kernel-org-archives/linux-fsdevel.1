Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03B3EAC74
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900603; cv=none; b=CJoTn5hztYSeK2uc5wZtUVavfjCsTgy2if5nBMkgD8BSh0FIhoXjZPdYTjwAySM6uJ+a6pZMe4yX+x0db6z/2cK+mClGy6nExeGvHjINfypxiNpsl+ReZ0qednqQrFKJvB3uxowqE8SV4loAQR0g5PpcEpu9cQRLvdq2uB58nzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900603; c=relaxed/simple;
	bh=9AGCWj9yEiZb7AqZlXGvgn/z/ubcTkyqzUxgdC9/Xks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu07er9Kg0XcxO85uMCSkzGRMI6jmBOTU4ClSkEgho1bRgsMhr5OyWrs4foYsEJYNfZTt8g9M+sHDhv5wbxhd8Gs4sTV3y8QjTUuM5q2mJVgRcxrE0iii/6dRs/bTedGfh0CaD7NI4/KmVyEkjcLusAYEO9R2MAiSuZHFaJ/KFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bn2LbrA9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=quTxt17S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KnWCrdSj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7zaHOWIw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bn2LbrA9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="quTxt17S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KnWCrdSj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zaHOWIw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68CA471AFC;
	Wed,  1 Jul 2026 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYst2nRR2UmxJ/X+CMuFRprM0QVn/5EVI2NX6JEPhVM=;
	b=Bn2LbrA9X1oHdAnSEjaDTXWyx2CCY3Bw3WPrgM6wpLqK3w4zrynOKzFLC6vm40PqL31WJr
	G0uqR8vfmVA5taG6fnbs1cS/6SZ8zdcVoEYZXvsWZs4Ma92+4XBL90Ne7w/pL4kkvjCXnr
	taPHR5G22+eXuHkI/5v4kj3vUSZ0f/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYst2nRR2UmxJ/X+CMuFRprM0QVn/5EVI2NX6JEPhVM=;
	b=quTxt17S5F4VVVt9efUJtMd+sTpxj42DicnQtIIyafnVI7TG9ZfJVC/tFiO55Wt2IOhYuw
	Ca+XkO9NfaWNA5Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KnWCrdSj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7zaHOWIw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYst2nRR2UmxJ/X+CMuFRprM0QVn/5EVI2NX6JEPhVM=;
	b=KnWCrdSjiC9VpwWiqODenw0Exdtdt2V/gW942mhnSIpqc9FGMMCt8J0xRxkX78uHSxYq55
	wQQBQIjGE4Zog0yYiOcRfGLNPhtNzImIBuTH1+hYuZ5I8CZcWEZDx2+K1EPc7K9VLK6H/p
	M7bddN5RuQpwhcEoQjnmG8jI2fBk5W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYst2nRR2UmxJ/X+CMuFRprM0QVn/5EVI2NX6JEPhVM=;
	b=7zaHOWIw62fic2RpXviqu4owEa1Q/Ppe7udvz0lQE7F6hc7dxGAsGKHUAr2PwL3WsKwEfY
	Vv+M5uC7P/ysPkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C5D5779AA;
	Wed,  1 Jul 2026 10:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QzNaHnXnRGrKPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Jul 2026 10:09:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 24555A10B7; Wed, 01 Jul 2026 12:09:53 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:09:53 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/31] minix: drop redundant S_IFDIR from mkdir
Message-ID: <kaldjdxf4jnq6hb6i7vuldh6samp5mdarpqna6lyld3fincmy6@svxvcubhvcvp>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <20260630105400.68459-19-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105400.68459-19-jkoolstra@xs4all.nl>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 68CA471AFC
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[xs4all.nl:email,suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:email,suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 30-06-26 12:53:47, Jori Koolstra wrote:
> vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
> ->mkdir(), so OR-ing S_IFDIR into the mode again in minix_mkdir() is
> redundant. Drop it.
> 
> Assisted-by: Claude Opus 4.8 (1M context)
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/minix/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/minix/namei.c b/fs/minix/namei.c
> index 263e4ba8b1c8..19b03ee15c28 100644
> --- a/fs/minix/namei.c
> +++ b/fs/minix/namei.c
> @@ -110,7 +110,7 @@ static struct dentry *minix_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	struct inode * inode;
>  	int err;
>  
> -	inode = minix_new_inode(dir, S_IFDIR | mode);
> +	inode = minix_new_inode(dir, mode);
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
>  
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
