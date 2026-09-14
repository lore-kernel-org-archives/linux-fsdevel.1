Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5DD40D576;
	Mon, 14 Sep 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374820; cv=none; b=WrdbDGLM5Sotx3kzi/VOkUrGcmtuKxIrOENF7FAe4cVzNenhSgbWLLycJeOnQrlBlEa2ej5wOfW9jC3vo4rPPXFcIVOnHnV0FYa18NqE4ANeRdeGq3b848wnvLD6DtowvUrXU5c2dy5XRcc6TfhI4qYchx9fzxJsJJXgyaHGHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374820; c=relaxed/simple;
	bh=dhK6N3fr/QbGfJnXGVRufLdFDnO6Gqd++fenRMmnTQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXqJ5IFqgHZpLa2DUDxMldizjg2mUzp96cQku5WPavwFI1YZaOV3V8w1TZN8l2m4f6G4MmJlxMm8dVm0XpUyJSUTssnmD/JlKo1wJ4DFteB1gQBRovEKwPscunk4uFG2DwFi0w8nCaqbEl4UNv5qsKltFzJT+TYEn5H4PvD5TP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oTmb6fYr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fhCzf78s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/a3Eodf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NP1Gqjh8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oTmb6fYr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fhCzf78s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/a3Eodf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NP1Gqjh8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 740D91FF6F;
	Mon, 14 Sep 2026 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789374812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y35rMJ08lTt5j4JTvitFmun2krbb8jYCwDVne66S7tw=;
	b=oTmb6fYr3UfTPY+doZ4EgxtqNEWQfX5/KeEUlCqwsC41aqKANneofYSKGOUOCkFBHyS7/5
	hARMaRIDC8XxXOZr7Dbnp1tDZQ6vICECHPVvhPKLcw2CEaMXcIbGJy+qWyw25Va2e/4Epl
	OfRghBbfFiwZJPUvUxkZUOk1qsowxhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789374812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y35rMJ08lTt5j4JTvitFmun2krbb8jYCwDVne66S7tw=;
	b=fhCzf78sNzIiEHaDxOzgFPCPDCZAcTU/Y8mE2zmK0CxkabDZ4zzol9UwWkkrJGI34lFFPk
	Xpkrh2iDnfAkEWBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="V/a3Eodf";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NP1Gqjh8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789374808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y35rMJ08lTt5j4JTvitFmun2krbb8jYCwDVne66S7tw=;
	b=V/a3Eodf3zYd3ub9odlUQ7XCTzvOJEkqy/Fx54ZVjH+rfIZ9D7MdloB7k4zA50i+RQGXJ5
	yEdwoFPNxqnNf5H/BeEB6RTo0jH6HTAeremWRKh2RSS9rNjjuNxfSW0ZcFw4ORn/tEY2lp
	zeJ44ZldxCunHSLMOr3DtW7FX/LaQx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789374808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y35rMJ08lTt5j4JTvitFmun2krbb8jYCwDVne66S7tw=;
	b=NP1Gqjh8fsek7ez7Fy3mHQbANN6AIE3eIbk1Pn8pjo4eJ6dg++Q198oyPYrl5xg42KAdcH
	HMrAXnW5AteQTvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45A5013515;
	Mon, 14 Sep 2026 08:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wjL7EFixp2q3GQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 08:33:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BFDCCA12E4; Mon, 14 Sep 2026 10:33:19 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:33:19 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] fs: unexport backing_file_set_user_path() and make
 it take the ref on its own
Message-ID: <hbxv45bbdcglj2nagkp6q6fkztwgw7fvuqt4b7hqzj56t7q2rj@ahf4v663akkm>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
 <20260913144918.1606123-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913144918.1606123-2-mjguzik@gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 740D91FF6F
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
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

On Sun 13-09-26 16:49:08, Mateusz Guzik wrote:
> Prep for path_* API changes, which will force the ref change.
> 
> There are likely no users outside of the tree, but should there be some they
> will no longer be caught by surprise.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Nice cleanup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/backing-file.c | 2 --
>  fs/file_table.c   | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index cc101143f921..e92410a27982 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -43,7 +43,6 @@ struct file *backing_file_open(const struct file *user_file, int flags,
>  	if (IS_ERR(f))
>  		return f;
>  
> -	path_get(user_path);
>  	backing_file_set_user_path(f, user_path);
>  	error = vfs_open(real_path, f);
>  	if (error) {
> @@ -68,7 +67,6 @@ struct file *backing_tmpfile_open(const struct file *user_file, int flags,
>  	if (IS_ERR(f))
>  		return f;
>  
> -	path_get(user_path);
>  	backing_file_set_user_path(f, user_path);
>  	error = vfs_tmpfile(real_idmap, real_parentpath, f, mode);
>  	if (error) {
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 8dcd213c0251..f9d1b5edd6ae 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -71,8 +71,8 @@ EXPORT_SYMBOL_GPL(backing_file_user_path);
>  void backing_file_set_user_path(struct file *f, const struct path *path)
>  {
>  	backing_file(f)->user_path = *path;
> +	path_get(path);
>  }
> -EXPORT_SYMBOL_GPL(backing_file_set_user_path);
>  
>  #ifdef CONFIG_SECURITY
>  void *backing_file_security(const struct file *f)
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
