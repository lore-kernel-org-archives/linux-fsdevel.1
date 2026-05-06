Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD623D2AB
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059003; cv=none; b=EAK3rp84hymKSe/YYhyyy7IBSUA/4hQlZ0gi7ugm+IW2MZ8tnNyn3JZSIBsjHusXVHo11O+TW+DAZwphWmf7y+AhbPiN7z2wJDPuKof0EOCUvy9fZJUsa45Vs4H2s2s6em6kDUngQ28jAD4zAtySSx6YAF2JMAfmaI+WtTrHvXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059003; c=relaxed/simple;
	bh=xD1k9WF7Dxfz+Stmxdlpr0gowqUIsb2AH5G6sJHBXP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg83qMZ8q5ols/lzdHWuQgocd3ENQv4/THDp3CUyI1w3Mx5PdJIiLOyXysW36/5dKqb/dqrdGAs+B5pdvivWN0S+2ExxcI25FLN3BRAHES+Eue2g0lbXqAfZNnNV4wNWnjTWJgdW0gLa1fjII6RCg3Y9gryZJbLU9laLzsgeIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=suNvDOHg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dQlzgI/x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DFZQPSYI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u4gzh1OO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="suNvDOHg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dQlzgI/x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DFZQPSYI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u4gzh1OO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C3705C12D;
	Wed,  6 May 2026 09:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778058999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1VPFia6hiDAQQhgQpLG0ei8yQjDCguEt6cJAO5vMAg=;
	b=suNvDOHgYDRWz7rIvyIwHinyLp3Oc52TNUsKLPJ2DX+OFN7LAnBIncbobems1q2RdEIsef
	OTb3of4RevCLkonLHhrbglWvS0vpEZS3okWvp/KQz8nk7YMxu8CG1oeW+22qraokOYezRS
	Z2LvYf3dkxZ3v/LlLj8BQ0uxBj3f75E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778058999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1VPFia6hiDAQQhgQpLG0ei8yQjDCguEt6cJAO5vMAg=;
	b=dQlzgI/xAUwQKzh9eAzLv6qJJeycxkpTat+k6HjlC9dCz/AK38TxezEc7DSkoeBcAshO06
	kCBf8OsZ7mkrL4CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DFZQPSYI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u4gzh1OO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778058998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1VPFia6hiDAQQhgQpLG0ei8yQjDCguEt6cJAO5vMAg=;
	b=DFZQPSYI+UgtwY/h2FYKPiNVrHOWXJ/LzTGE1uBx6tgC8Ip8nYLOFboi7yyL5pfg453Niv
	QaARUWuELuYld4yOJXoeLITzuhvNddDdGHRm7jzYHO5n2tdWlA9fJbi+qJH2q50hw3MfF2
	+4DCT16d4M7GnsNkv+aj6t6eK/+4pz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778058998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1VPFia6hiDAQQhgQpLG0ei8yQjDCguEt6cJAO5vMAg=;
	b=u4gzh1OOXZkxZVtitRFT3AbTLMwPF0P5kybOEWUjeWgrwuu536Au99qcRAbfF2yoR9bJQ0
	x2zlGFTOG7728RDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82305593A3;
	Wed,  6 May 2026 09:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vAfGH/YG+2nIcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 06 May 2026 09:16:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47C01A0790; Wed, 06 May 2026 11:16:33 +0200 (CEST)
Date: Wed, 6 May 2026 11:16:33 +0200
From: Jan Kara <jack@suse.cz>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sync_file_range: delete dead S_ISLNK code
Message-ID: <leia3l5jr6evrllxbz2o6kp5wf6lofpnlzxlg5ozh7is5t2nli@avxnsedur6d2>
References: <295235c7-7f68-4554-bb6f-85398beca350@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295235c7-7f68-4554-bb6f-85398beca350@p183>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8C3705C12D
X-Spam-Level: 

On Tue 05-05-26 21:55:29, Alexey Dobriyan wrote:
> Symlinks can't appear as opened file.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
>  fs/sync.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -266,8 +266,7 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
>  
>  	i_mode = file_inode(file)->i_mode;
>  	ret = -ESPIPE;
> -	if (!S_ISREG(i_mode) && !S_ISBLK(i_mode) && !S_ISDIR(i_mode) &&
> -			!S_ISLNK(i_mode))
> +	if (!S_ISREG(i_mode) && !S_ISBLK(i_mode) && !S_ISDIR(i_mode))
>  		goto out;
>  
>  	mapping = file->f_mapping;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
