Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399C41A76F;
	Mon, 14 Sep 2026 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376350; cv=none; b=G9rgDSd+AqOOrEwIjZon4cXBLqdV2NF+QWYNHmtaJyaGL2Tv8tgW/KdzU1IYUVrmr9LsdKqNbi+n8lZjpvLpaqrCt/BDnkgHNhgar/cqwvDxytG4RdDEfl5PdC5+Gr42wMsI8n1+KaHw2WWBZdu795lx7ctbnkC/tdHNtMz/JAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376350; c=relaxed/simple;
	bh=fOsDLSxcv8a4gJDBa7QYVILyDaH5Cys2L35ytaFq0HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmOICHZczG/BV0Qy+Dpj7zqjyy4gyu8QlcDkA1ZVqGG68COW+XxZTPt97kVBh/RC6akSZcoI8EXGJHJPyufz7brF1n+IDoqT6QBBFGW9KgIGDgiKSmr3J2Dh3kyeY4/yTxIHcB1hJy6Q+8oyo8R58vweSzQ+n4+89KZVuhWbMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sX5x7Ssb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oY3vPC3Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QPTEyr+I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VOOU+K3H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sX5x7Ssb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oY3vPC3Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QPTEyr+I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VOOU+K3H"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9818121B48;
	Mon, 14 Sep 2026 08:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789376335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv39aLl/6H8PMEvbRcDZQ1JU3/BwVqeD4/GtCaTWzvE=;
	b=sX5x7SsbAl+wfmH1yph6yXQlcS9xzuD7QcnDjCDjl2mPngDBl7bYhPCjoGRoYDZywfDTCP
	g2yyma9jVlxsM0wQCF5t43qK0DSfWwdOJOv/7o/wsZi3LmLyhl4to0xs1PZT4blrglC39w
	Q1ObJWGALZFmWUGyJKiu9A8eVsUpw18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789376335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv39aLl/6H8PMEvbRcDZQ1JU3/BwVqeD4/GtCaTWzvE=;
	b=oY3vPC3QrGxm4pzVZ0rN0AEaRgvk7V28CBfDAwTvsd9eFe+u+NWCDo4/LdtUb2zWkdlW2E
	eWk3U1HGGNWhxKAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789376331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv39aLl/6H8PMEvbRcDZQ1JU3/BwVqeD4/GtCaTWzvE=;
	b=QPTEyr+Im0HDbS4/PhwoWOsvhY2vkbreoCf+cwWAfKvmVGpA5uwErygmjaWxlPa5c73kwQ
	t2THRsQCxq/s12Dz44Me+jHM9lU7JZUTS97kE3cBmdkHrnFiMekUvf++yF9JOregWMnbAb
	g2suzXlu7mIAhkr1V1ZOsJIqX2FoAdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789376331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cv39aLl/6H8PMEvbRcDZQ1JU3/BwVqeD4/GtCaTWzvE=;
	b=VOOU+K3H9PrbVQgCNCVfnfM1/8cuuKifn9PxSIFRfnTQ0u6wNmSv1RUJmeCNy1JsrJx60d
	qfY/AkJ6qbNd3cCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D44F1368C;
	Mon, 14 Sep 2026 08:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mq2pGku3p2pbNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 08:58:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 12CA6A12E4; Mon, 14 Sep 2026 10:58:47 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:58:47 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/10] proc: use path_clone()
Message-ID: <33wbufd3drjilmfkpq2kmwpcaquxxky2idtozyuk6pkc4xbc2t@sxdsapiar4ti>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
 <20260913144918.1606123-10-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913144918.1606123-10-mjguzik@gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]

On Sun 13-09-26 16:49:16, Mateusz Guzik wrote:
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/proc/base.c | 3 +--
>  fs/proc/fd.c   | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 01d8bfe1c410..6b055352eabd 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1766,8 +1766,7 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path,
>  
>  	exe_file = get_task_exe_file(task);
>  	if (exe_file) {
> -		*exe_path = exe_file->f_path;
> -		path_get(&exe_file->f_path);
> +		path_clone(&exe_file->f_path, exe_path);
>  		fput(exe_file);
>  		return 0;
>  	} else
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 0f9a1556f2a3..9ab9bfd6e48d 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -180,8 +180,7 @@ static int proc_fd_link(struct dentry *dentry, struct path *path,
>  
>  	fd_file = fget_task(task, fd);
>  	if (fd_file) {
> -		*path = fd_file->f_path;
> -		path_get(&fd_file->f_path);
> +		path_clone(&fd_file->f_path, path);
>  		ret = 0;
>  		fput(fd_file);
>  	}
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
