Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377D40EB91;
	Mon, 14 Sep 2026 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376250; cv=none; b=rUqzsNMoM67PxA4HWY2CVq9t1C2GRhsH7XL2mBmtLd6bZmn+0gqHXgK6Ob2SEzn7p+n7rTjPYbr4dF7NqViCo2Zefl4+KVdUHLy8h39YNDtDEBJ9hlqzdBA9Dva4Ala0A31cVhzzdfyBF8VWG19Ue2+mpXp9KR2kiyvL+wrvCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376250; c=relaxed/simple;
	bh=5/flNwIpNLuTfl5WHGyBrRvI2BIy1YwNzFjz8h8sOMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQA0DhdWUHYUkYDvE3JhCm0V1sbOIG+PH/gtHkanJN/qFJBCychO39xnrlRLU4xC8Dxd5gCbFz3haiGNa4CyWe4+Gys8DylrU3RhZrC/6vaTUL7gX6JJBIsr7cJwSi3fNriwu2/pOw0j9vvWe719Pel/O/y+DdjqdywdNFoM1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XGuF7kml; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tvTM/nZE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rxu38TZY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0AUQTdjJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XGuF7kml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tvTM/nZE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rxu38TZY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0AUQTdjJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48C2B1F454;
	Mon, 14 Sep 2026 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789376236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uzOl6uYuv8EEa/h02IHzYX6TZiKRIpgTjd6AWavGiRY=;
	b=XGuF7kmlBV5uoaK5qALNgfkddrwz5/ClQpVGkRY3h8nSKAKts/9hCUizqFRhgWUuC1LunD
	Iwkh5bGD+Iy7oTsi1fH6XLQUacOK+jBjln/zPdE255jfuaRm4rhqrFr3louRq4151QynIZ
	5rWHT/LHcQfflnqfLA8dzS7I1tha7Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789376236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uzOl6uYuv8EEa/h02IHzYX6TZiKRIpgTjd6AWavGiRY=;
	b=tvTM/nZE8oaHB35tJ+Met2WHaPbDVHi6RtCPNplJMy8TfxK9qUuspfDwNWwwceyiLQBZr5
	F4R5XMopSE5+YoBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Rxu38TZY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0AUQTdjJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789376232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uzOl6uYuv8EEa/h02IHzYX6TZiKRIpgTjd6AWavGiRY=;
	b=Rxu38TZYIj3HjlNJEcalZn3emqvGR1Qz3b51d6GkvSpFXF4+x+vUKfa+K5jMcTMyBCe4fZ
	L2zYLpzbSS21Ty9BDIJBqV3Z8ksRZZf72rzE/+sfP0A/SzFvvy2XS6eTlJKuK1aiwZan/d
	LAqNIFJaJIYAZVdaZDPca7twH6fmLh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789376232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uzOl6uYuv8EEa/h02IHzYX6TZiKRIpgTjd6AWavGiRY=;
	b=0AUQTdjJRNBNKs4ri1rtWFetNR/x3rQwmTHxcKA1rB3M7SqvUzOm2fBYtPTAwc005CuBR0
	kMhSwXNbPxe3DYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20BDA1368C;
	Mon, 14 Sep 2026 08:57:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bmH7B+i2p2poMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 08:57:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B8C34A12E4; Mon, 14 Sep 2026 10:57:03 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:57:03 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/10] fs: use path_clone() in
 backing_file_set_user_path()
Message-ID: <5gwjjysxizjvrd6bfpdtx3meuirzcv6wvtvj5qe4rxgvi6abwu@servfc3gk5ul>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
 <20260913144918.1606123-6-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913144918.1606123-6-mjguzik@gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 48C2B1F454
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Flag: NO

On Sun 13-09-26 16:49:12, Mateusz Guzik wrote:
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_table.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index f9d1b5edd6ae..0dca0c6c991f 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -70,8 +70,7 @@ EXPORT_SYMBOL_GPL(backing_file_user_path);
>  
>  void backing_file_set_user_path(struct file *f, const struct path *path)
>  {
> -	backing_file(f)->user_path = *path;
> -	path_get(path);
> +	path_clone(path, &backing_file(f)->user_path);
>  }
>  
>  #ifdef CONFIG_SECURITY
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
