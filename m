Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C240F756;
	Mon, 14 Sep 2026 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375019; cv=none; b=eWOxNXrE1ngdjsyMlRkepaJIl0/suVgWexVMgLWAckTRFtOGJiSel2PdmegieVJgYGS9Tck/E6VtJf1tXQWwgTntprpXwn44oRY9mNonFfD2615fsx0KjrroEOA5+q8DOwfTuUuCbDvz1Bo8cjjxUvgYFV9NwdNBbM1CU6aMUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375019; c=relaxed/simple;
	bh=JME5BQjtec124eb9yanhj/n3yCrhsMGSgGJHJNE2RAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXZE9l6/KhZn1eXkrQ9eru8QMV9GH74oK9kat6oU4Kgegcj/vJgalQRNFGjkcZIIHzqVtV92G8zN2+9W919Ng+z32f5rxsxl+T4IBPp4tKR7CcBDk3M++FTZxbeUObiZ/D7tI07RlKPXa4LZLVq854Sm/RltzzQ7qN9h4OvJdjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mS1XrmjZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ovaJa3wt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UjAiVTDm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jr0jyM58; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mS1XrmjZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ovaJa3wt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UjAiVTDm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jr0jyM58"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D8201F388;
	Mon, 14 Sep 2026 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789375011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87c11ra7wF1rwaxwnuycKYlooj+/5mNGob7/rCviIEA=;
	b=mS1XrmjZD0fj1qlmmLL+R/hUB4qRrgRMS0iQzmkq8GShzWotL0dO4tSDxJWH7XtC+x5KwM
	WXtLtUPfjz3G/km6K4+J5KPu1Udj/pxsU5D5xGmuTakSOwDf2RBd3ycYlRF65zCUb0iwbV
	9zFNxe5HGgFmCOJ4oxYB4CY37X1l45k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789375011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87c11ra7wF1rwaxwnuycKYlooj+/5mNGob7/rCviIEA=;
	b=ovaJa3wtedCFrR2kLhKWCdxS8d1FMiELUE9FFRaXDiNw6tzmbthSwBGBpE1Ti/tDiob2ca
	Nd1WxFYC+0O0i5CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789375007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87c11ra7wF1rwaxwnuycKYlooj+/5mNGob7/rCviIEA=;
	b=UjAiVTDmmHRP7OudCoVoluQiIdavqlSlFrViy0zngRgiNL77OwzfEFSB9UVYuaF1C+t+Zf
	gytgTpG3bLe/JSIABDqUoLVlyEaX61xyKDAxTLnPOgomeOF07GG21aoRnn1jSQgUzwhtXA
	nqHYoAdhQrHijGi8j9X0iy2iYUZ4K30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789375007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87c11ra7wF1rwaxwnuycKYlooj+/5mNGob7/rCviIEA=;
	b=jr0jyM58QTn10i09CQAJ0ed0gPjF7T0WPPrmLpM5of6ZabyJjo/Ngt7TuxZpXBa85oKdWK
	DKPDW0E88nkDhlCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4793313515;
	Mon, 14 Sep 2026 08:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uNR3ER+yp2ojHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 08:36:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3129A12E4; Mon, 14 Sep 2026 10:36:42 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:36:42 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/10] fsnotify: use path_clone()
Message-ID: <og5vraj76bhfzbidkgujd5exdlh4ckutulmm7rcln4xbjjvl53@6z3cewyb3k4v>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
 <20260913144918.1606123-9-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913144918.1606123-9-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Sun 13-09-26 16:49:15, Mateusz Guzik wrote:
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

This looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index a208a7ec1692..84b4c505dbe3 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -559,9 +559,8 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
>  		return NULL;
>  
>  	pevent->fae.type = FANOTIFY_EVENT_TYPE_PATH;
> -	pevent->path = *path;
>  	*hash ^= fanotify_hash_path(path);
> -	path_get(path);
> +	path_clone(path, &pevent->path);
>  
>  	return &pevent->fae;
>  }
> @@ -600,10 +599,9 @@ static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
>  	pevent->hdr.len = 0;
>  	pevent->state = FAN_EVENT_INIT;
>  	pevent->watchdog_cnt = 0;
> -	pevent->path = *path;
>  	pevent->pos = range ? range->pos : FANOTIFY_NO_RANGE;
>  	pevent->count = range ? range->count : 0;
> -	path_get(path);
> +	path_clone(path, &pevent->path);
>  
>  	return &pevent->fae;
>  }
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
