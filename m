Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755A3242BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516183; cv=none; b=NtWbcfRKTDu/SsVB/aBwAli5+nRAuzGDuqI5kPjDBU3E1XM9JhPLrTGNgFSbFqFVhKMqaxIRd3Xi08/h9wP+RVyPb1Bxx7wOXUDE6oxJV1DbMkpYFtMgLUivRpXOHyQZfDBHS5JbHmTdKOtnazR/1eYr8Ma53CBXteCie3MZHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516183; c=relaxed/simple;
	bh=yi6OGTzrZd98bJgrNpzO1XSyR+Nrrcvd8YIHtczikQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGZkKgnzSgSijiV7oa/5BppNfs3YyunH3omDK155pC8ZMgipufEu/1gm6G2P9zqyR5DaSoXAKAn6J2du6IZyAQy8jm5H9/aegJOjQk/HFmprZnH3tm2CSjmT8qEHD2qMlB7befjR5RVami4lyWw/BI517sh36BKSu9I20oAWFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tQOupnWV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iraynHC+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=puJcwBrz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eRrzBNfE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tQOupnWV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iraynHC+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="puJcwBrz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eRrzBNfE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D559768350;
	Mon, 11 May 2026 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778516180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfGp2MVNjH4c2D/pXrHLrfrzodSui9At2y7+spRxHgY=;
	b=tQOupnWVCXNlaKFY4L9u69Rsbm4VOdRxahrdNOH4LeQjt0vo/WKJUZYaQ73Zs5yYtCQyNp
	Ha/bPIvZZXCliG1BkwC8p3HB2IAaAwoSvm0Ad/Y+ABaJSPcnxefmLwWMtbK7pIUDmV6xiy
	GaTgriDd+7qF/0y02Io+Sid4QZKUCGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778516180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfGp2MVNjH4c2D/pXrHLrfrzodSui9At2y7+spRxHgY=;
	b=iraynHC+hpt2ZbHB5Dvw4znMG51LB3w/MZflIjXsCLXrCHOOa+ZiCvNesXCPcDhHU9K349
	Y+rXRmFE8NJYTxAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=puJcwBrz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eRrzBNfE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778516179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfGp2MVNjH4c2D/pXrHLrfrzodSui9At2y7+spRxHgY=;
	b=puJcwBrzqfkg/9yw8lxXwkiUJOmUk4fJb7w9AQ4wM0ms8217WhbxoNBvFk4ZXT+LhnSzYD
	U/2YFheMjtL8moTlYq4Q3Wgw8Xgs6cpnF2n3ljLcT59bxMO7hp5jBf8v5XQH5CE5DT1zbD
	X9CZJQwfv4SBPSaLVjXOS1ZMQHZsJdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778516179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfGp2MVNjH4c2D/pXrHLrfrzodSui9At2y7+spRxHgY=;
	b=eRrzBNfEzIqrc+sFcF6s32BSZV6U38hQCZjBJJvrI7Q5me91yZYEi3gErGiB21wJVhLbvL
	M3ZWbXU6jV3K0MDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C0A4593A3;
	Mon, 11 May 2026 16:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HEEzItMAAmokUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 May 2026 16:16:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B330FA079E; Mon, 11 May 2026 18:16:11 +0200 (CEST)
Date: Mon, 11 May 2026 18:16:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: remove start_removing_user_path_at
Message-ID: <x7xmupqo4xe5ur3b3prmtl5vyvra725oihb7ntppunkwcx3ngh@r44zmkb6zs3i>
References: <20260511072239.2456725-1-hch@lst.de>
 <20260511072239.2456725-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511072239.2456725-3-hch@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -4.01
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,lst.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D559768350
X-Spam-Level: 

On Mon 11-05-26 09:22:29, Christoph Hellwig wrote:
> This function is entirely unused, remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Fair. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/porting.rst | 1 -
>  fs/namei.c                            | 9 ---------
>  include/linux/namei.h                 | 1 -
>  3 files changed, 11 deletions(-)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index fdf074429cd3..f546b1d3897f 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1297,7 +1297,6 @@ Several functions are renamed:
>  -  kern_path_locked -> start_removing_path
>  -  kern_path_create -> start_creating_path
>  -  user_path_create -> start_creating_user_path
> --  user_path_locked_at -> start_removing_user_path_at
>  -  done_path_create -> end_creating_path
>  
>  ---
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..bc641838530f 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3029,15 +3029,6 @@ struct dentry *start_removing_path(const char *name, struct path *path)
>  	return __start_removing_path(AT_FDCWD, filename, path);
>  }
>  
> -struct dentry *start_removing_user_path_at(int dfd,
> -					   const char __user *name,
> -					   struct path *path)
> -{
> -	CLASS(filename, filename)(name);
> -	return __start_removing_path(dfd, filename, path);
> -}
> -EXPORT_SYMBOL(start_removing_user_path_at);
> -
>  int kern_path(const char *name, unsigned int flags, struct path *path)
>  {
>  	CLASS(filename_kernel, filename)(name);
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 2ad6dd9987b9..80488b3de0c9 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -61,7 +61,6 @@ extern struct dentry *start_creating_path(int, const char *, struct path *, unsi
>  extern struct dentry *start_creating_user_path(int, const char __user *, struct path *, unsigned int);
>  extern void end_creating_path(const struct path *, struct dentry *);
>  extern struct dentry *start_removing_path(const char *, struct path *);
> -extern struct dentry *start_removing_user_path_at(int , const char __user *, struct path *);
>  static inline void end_removing_path(const struct path *path , struct dentry *dentry)
>  {
>  	end_creating_path(path, dentry);
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
