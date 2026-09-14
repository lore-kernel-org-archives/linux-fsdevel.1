Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D141A923;
	Mon, 14 Sep 2026 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376497; cv=none; b=aWDoxLeQWDBphBA5ZI8EnBR3EPnW+MpVHiod5Vlc6MI6gwZcFs1OBczhY7KeNM+DJI+H+ML1eLttwpuDkPVljz3tSXjosFjZRyU2yfil0Ol+vBt7gRmL4rfFr4Qq9BsthvRoTh5NpbcZUhFzIDtleBeyuUoc4rI0Dhp7HA7mVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376497; c=relaxed/simple;
	bh=PEzOD6S5CyMByQ2MXcdGumahPXVc7qvnwo7wKWAKbT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZbaVl24yu4YEb70TEpPD00zHTeCCqrKj9bAfjYLfb576b+liM0RAYM7i5OwZGLxNobxOwZ8rCsaaEaq9sovoRnyoAzFfI+QedmjaqSXX/MbqgWe58OnKn3Mxs8p4P6QQMqmbsgJVbss5z5itCWfiTzF/G5nEkTKUnfmGDGnXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oXbHbJ6D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tgeuv6K2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SeSnDu9f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HgMkR57B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oXbHbJ6D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tgeuv6K2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SeSnDu9f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HgMkR57B"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD0D5215D3;
	Mon, 14 Sep 2026 09:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789376484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO2cZ4yvyojqT3bcC/z89RDmjYcG9uAvt6+OditBDxY=;
	b=oXbHbJ6DvzeVLSiMmn1Wxw85Lcci72u+WlWNnC4uAlLmokjIxfg2i9DHMXXhLL0LSg066+
	j4zXWDghgb6xgVERrKm0wPxZRf2v+5OdBkuQwFNbiiNyEVWglUZTzotf9vhD3CGYicLG3E
	ytsN99ryaTDuzPKgW+q5zwwcIsK1+Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789376484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO2cZ4yvyojqT3bcC/z89RDmjYcG9uAvt6+OditBDxY=;
	b=Tgeuv6K2ZNwGxPONsext5ReuzxnDDLaQOFHKpvR5aK/7XA17zc/SLh78l3kQy7VwVSw1fk
	9AhHDNyZGltixUCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789376479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO2cZ4yvyojqT3bcC/z89RDmjYcG9uAvt6+OditBDxY=;
	b=SeSnDu9fZv9tHOYPFA99ICWaLSCStewk+anikdV8z510wtl48IkmvRyEm+aHu8LXom06KK
	jQ4Juo9HNdQ4GelBUnLQ7NMc6QJFVnyNM6E0pa6ZPTBa/7E6iwQl5petRn459v7r99KZUO
	/RCQkzf3/LMTA1lpt6ItNc8dasA5ScU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789376479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uO2cZ4yvyojqT3bcC/z89RDmjYcG9uAvt6+OditBDxY=;
	b=HgMkR57B8pa06/YMV99S95arqQYHHmecp59Vdjplke/3fhmmAqZFa5h3JxAY4g2+Z2gxBn
	xlxuQOA/6+8I+1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B7881368C;
	Mon, 14 Sep 2026 09:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id otzxJd+3p2q7NgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 09:01:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23286A12E4; Mon, 14 Sep 2026 11:01:11 +0200 (CEST)
Date: Mon, 14 Sep 2026 11:01:11 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/10] nfsd: use path_clone()
Message-ID: <z4bixf6gwuwyvckfxoi6337kubqe57sxj2pzcjw6fio3v5em3w@kydo2igkcdss>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
 <20260913144918.1606123-11-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913144918.1606123-11-mjguzik@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO

On Sun 13-09-26 16:49:17, Mateusz Guzik wrote:
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

It would be good to CC NFSD folks on this so they are aware this is
happening (along with at least the cover letter and the patch introducing
the helpers). But the change looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/nfsd/export.c  | 6 ++----
>  fs/nfsd/nfs4xdr.c | 8 ++++----
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index e5a0f1ababe6..84ea833816b5 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -233,8 +233,7 @@ static inline void expkey_update(struct cache_head *cnew,
>  	struct svc_expkey *new = container_of(cnew, struct svc_expkey, h);
>  	struct svc_expkey *item = container_of(citem, struct svc_expkey, h);
>  
> -	new->ek_path = item->ek_path;
> -	path_get(&item->ek_path);
> +	path_clone(&item->ek_path, &new->ek_path);
>  }
>  
>  static struct cache_head *expkey_alloc(void)
> @@ -1533,8 +1532,7 @@ static void svc_export_init(struct cache_head *cnew, struct cache_head *citem)
>  
>  	kref_get(&item->ex_client->ref);
>  	new->ex_client = item->ex_client;
> -	new->ex_path = item->ex_path;
> -	path_get(&item->ex_path);
> +	path_clone(&item->ex_path, &new->ex_path);
>  	new->ex_fslocs.locations = NULL;
>  	new->ex_fslocs.locations_count = 0;
>  	new->ex_fslocs.migrated = 0;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 7d1b2d6f57f2..65a805501b75 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2966,14 +2966,14 @@ static __be32 nfsd4_encode_pathname4(struct xdr_stream *xdr,
>  				     const struct path *root,
>  				     const struct path *path)
>  {
> -	struct path cur = *path;
> +	struct path cur;
>  	struct dentry **components = NULL;
>  	unsigned int ncomponents = 0;
>  	__be32 err = nfserr_jukebox;
>  
>  	dprintk("nfsd4_encode_components(");
>  
> -	path_get(&cur);
> +	path_clone(path, &cur);
>  	/* First walk the path up to the nfsd root, and store the
>  	 * dentries/path components in an array.
>  	 */
> @@ -3216,11 +3216,11 @@ static __be32 fattr_handle_absent_fs(u32 *bmval0, u32 *bmval1, u32 *bmval2, u32
>  
>  static int nfsd4_get_mounted_on_ino(struct svc_export *exp, u64 *pino)
>  {
> -	struct path path = exp->ex_path;
> +	struct path path;
>  	struct kstat stat;
>  	int err;
>  
> -	path_get(&path);
> +	path_clone(&exp->ex_path, &path);
>  	while (follow_up(&path)) {
>  		if (path.dentry != path.mnt->mnt_root)
>  			break;
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
