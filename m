Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13113EC2DD
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516339; cv=none; b=GZrX8mocpUWlz4aELyrzyU7twzO4nZepE33sCKhOd0h+ZJ+5DMXgg4/BuIo1EG2nVjmzLeGD1tNeOY309awMmGhswyKc713Bf7dE6+JFV18E8+RXoB5hXv2zyRIfr4k13jtIqDXJZka5iWlwnBmVgVOAIZ264nDqeo7oCp8iYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516339; c=relaxed/simple;
	bh=UOvWgWzzTvyua7y5GXslYuZuIGVGynqp0+9VvOUzB90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyEGqpY6miZpVM7oeW0ZWQVSSpTrQsOc/Wl8n4Qat9+599tsWhjLUaHu+arjqnQjz1a/9gREm4G2P3yZlvsHxWETotRW0tKfLCL/MlNdN5EwiSWkf3/x2DPwmOTOel6/gYC6Vdxg2ZtqLcRmrU+0Q47rdZnZeowX+g6MoIsE/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=siFPerAT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Crf5buLZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=siFPerAT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Crf5buLZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="siFPerAT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Crf5buLZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="siFPerAT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Crf5buLZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 12DF968328;
	Mon, 11 May 2026 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778516336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/nP9E6asF6AGOa4n4/RXYH8TS9je/msBLAfIloGanU=;
	b=siFPerAT5CCXCEG+tm/l0bdp+MSPWNZ8pYJvkXuWCTnkWGsLX//4GsiFkV5pGa7yuVrhMT
	W+X+Bi7YBgSUXoa+xoWUeOL5IH1wG9qrgQBiuH8OENz1H7gVcRo8u5p5+lFolx4aUXSH2g
	iRXMlk98iMshdkoYJbalgacB2NtENTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778516336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/nP9E6asF6AGOa4n4/RXYH8TS9je/msBLAfIloGanU=;
	b=Crf5buLZ6faChQOv832BajRQl6gv/Qax3xc+Y4RRge7cFwrWvDt2sIKeh7gUoEvRdJgiLo
	HQ1xVyUtx84/SNDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=siFPerAT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Crf5buLZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778516336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/nP9E6asF6AGOa4n4/RXYH8TS9je/msBLAfIloGanU=;
	b=siFPerAT5CCXCEG+tm/l0bdp+MSPWNZ8pYJvkXuWCTnkWGsLX//4GsiFkV5pGa7yuVrhMT
	W+X+Bi7YBgSUXoa+xoWUeOL5IH1wG9qrgQBiuH8OENz1H7gVcRo8u5p5+lFolx4aUXSH2g
	iRXMlk98iMshdkoYJbalgacB2NtENTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778516336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/nP9E6asF6AGOa4n4/RXYH8TS9je/msBLAfIloGanU=;
	b=Crf5buLZ6faChQOv832BajRQl6gv/Qax3xc+Y4RRge7cFwrWvDt2sIKeh7gUoEvRdJgiLo
	HQ1xVyUtx84/SNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04EFF593A3;
	Mon, 11 May 2026 16:18:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UU0uAXABAmoCVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 May 2026 16:18:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE559A079E; Mon, 11 May 2026 18:18:50 +0200 (CEST)
Date: Mon, 11 May 2026 18:18:50 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	NeilBrown <neil@brown.name>
Subject: Re: [PATCH 3/3] fs: fold __start_removing_path into
 start_removing_path
Message-ID: <ctmsec34gzs4cy64o6tchtge4ho3yczztuayzbebjubsnxdflg@hiof5cer2fnq>
References: <20260511072239.2456725-1-hch@lst.de>
 <20260511072239.2456725-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511072239.2456725-4-hch@lst.de>
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email,lst.de:email];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email]
X-Rspamd-Queue-Id: 12DF968328
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 11-05-26 09:22:30, Christoph Hellwig wrote:
> Only one caller left, and simplified this way.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Seems like it's like this for 8 months so we're hopefully not
breaking Neil in the middle of some of his vfs series. In the worst case he
can reintroduce this once it is really needed. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index bc641838530f..4852ca208bd4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2955,15 +2955,16 @@ void end_dirop(struct dentry *de)
>  EXPORT_SYMBOL(end_dirop);
>  
>  /* does lookup, returns the object with parent locked */
> -static struct dentry *__start_removing_path(int dfd, struct filename *name,
> -					   struct path *path)
> +struct dentry *start_removing_path(const char *name, struct path *path)
>  {
> +	CLASS(filename_kernel, filename)(name);
>  	struct path parent_path __free(path_put) = {};
>  	struct dentry *d;
>  	struct qstr last;
>  	int type, error;
>  
> -	error = filename_parentat(dfd, name, 0, &parent_path, &last, &type);
> +	error = filename_parentat(AT_FDCWD, filename, 0, &parent_path, &last,
> +			&type);
>  	if (error)
>  		return ERR_PTR(error);
>  	if (unlikely(type != LAST_NORM))
> @@ -3023,12 +3024,6 @@ struct dentry *kern_path_parent(const char *name, struct path *path)
>  	return d;
>  }
>  
> -struct dentry *start_removing_path(const char *name, struct path *path)
> -{
> -	CLASS(filename_kernel, filename)(name);
> -	return __start_removing_path(AT_FDCWD, filename, path);
> -}
> -
>  int kern_path(const char *name, unsigned int flags, struct path *path)
>  {
>  	CLASS(filename_kernel, filename)(name);
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
