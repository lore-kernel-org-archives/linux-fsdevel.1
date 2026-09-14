Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230636606A;
	Mon, 14 Sep 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376228; cv=none; b=ZnuNgGxVz++O3NrUFxrIi6+apXABNCunUSVSDpX6KVTXS1Wf38Raz2kJdQBo14kIFeMwQCdlId4TPbfODYN72zv+zhZYZUpaYGnVn55CocTMgKZ1xod7QCenalRFN3T0dAVh0/ZgPhSnWPbJORAz0Tthb09fV09WKo/KOX17IuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376228; c=relaxed/simple;
	bh=J4WSmnOksRwBCmfc6I0bWG6/1EEqrqO0K+BBI+cCwp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZluRwGjtoUl01YcHNP6bVI8+4mTa3BUvuIimArvX0sn+tra2iXX2CkjcYuBMWG+rLjPbXJcEiwZDKkFzW2WHi/61Yuw2Jdqg6LroMU1OS1ZyUZt/3RqmvhFhHnlK0i0XbNXwIHWe5ourIfTQ9MCwPjPf5leabZ5ahkg4ySUsZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wKtqzwRI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CUnZTxSq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vC0ieGZQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EzpCZ3Ld; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wKtqzwRI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CUnZTxSq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vC0ieGZQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EzpCZ3Ld"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C2CC1F38D;
	Mon, 14 Sep 2026 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789376215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YGrsKBDCYygO26F0zTaCL4mzIKYcG4BnzRtitvCGKeg=;
	b=wKtqzwRIDPiPtwlZG642cvH79huuYOaE6eTlnzc/IBOf+ZbKBDG69zpPyPqs88lwVN/S/N
	IQNqxjoX9Ecsjw0YzBRWLhpVzlZHDXuoVuJTno3W9MvbbOPb/8GC5wlXmHTgQnutPzjdgr
	ugoAbmc843WGnnsY34e7Jhrce+1hXdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789376215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YGrsKBDCYygO26F0zTaCL4mzIKYcG4BnzRtitvCGKeg=;
	b=CUnZTxSq/fFV/56cZTrtrJuMwo2EpugZNlj1TFxriNL3fKE4AD7b6ZGnp//ra1Z+D/CeDQ
	ZPkpAnZ6eD+InBCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vC0ieGZQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EzpCZ3Ld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789376211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YGrsKBDCYygO26F0zTaCL4mzIKYcG4BnzRtitvCGKeg=;
	b=vC0ieGZQAGGnyO7iBv4JeFpYBTjECmzn3EzuXcmpNimYQSdtIDNLxHRDXugdEhm6egKFqm
	uMSdP2aBtYOMasjHtenahTkvmfbYlqS/zaxp6HgyuafdUEYeTcNwh/vWK9DX9JffKWMQZT
	t+IrL69bYmhul1cidYacAGvpZn7aecE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789376211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YGrsKBDCYygO26F0zTaCL4mzIKYcG4BnzRtitvCGKeg=;
	b=EzpCZ3Ld5XjdQlfjbX67tq1cV7MnPiH1+Z99i2HjvluNIsxk4tqqlzNIN0beHBifzGmXNf
	FZYh2/Cfm0lB9XDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 354481368C;
	Mon, 14 Sep 2026 08:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BA3/DNK2p2pWMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 08:56:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B5DD7A12E4; Mon, 14 Sep 2026 10:56:49 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:56:49 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/10] fs: use path_clone() and path_move() in vfs_open*
Message-ID: <nyrvahdkedtar25wx4kc4tekn4ywj2tzrbyzpyc5iauuxw2n4x@47mgvg6guhf5>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
 <20260913144918.1606123-5-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913144918.1606123-5-mjguzik@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5C2CC1F38D
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Sun 13-09-26 16:49:11, Mateusz Guzik wrote:
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/open.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index a84b55301719..e11d1342ff74 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1102,8 +1102,7 @@ int vfs_open(const struct path *path, struct file *file)
>  {
>  	int ret;
>  
> -	file->__f_path = *path;
> -	path_get(&file->f_path);
> +	path_clone(path, &file->__f_path);
>  	ret = do_dentry_open(file, NULL);
>  	if (!ret) {
>  		/*
> @@ -1125,9 +1124,7 @@ int vfs_open_consume(struct path *path, struct file *file)
>  {
>  	int ret;
>  
> -	file->__f_path = *path;
> -	path->mnt = NULL;
> -	path->dentry = NULL;
> +	path_move(path, &file->__f_path);
>  	ret = do_dentry_open(file, NULL);
>  	if (!ret) {
>  		fsnotify_open(file);
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
