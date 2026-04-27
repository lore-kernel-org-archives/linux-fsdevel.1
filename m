Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D876208D0
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281967; cv=none; b=LdhSz+7O8q+vPuLc/XEdYBy0XaKAMrFWHWSgueNy/BarSP+aTeN1IZvOVpKxpih6Te0VFo5P4V9AEr7Z2oROnA0X2TuHYejQmBDyZgV7f7UaAp5Ios73fP8BkG7TK/cMe+kwu3ioLpA2fKkPerHaf6fo31jLJXna2+aer7xRo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281967; c=relaxed/simple;
	bh=5lSUGaBWmFMuTvcVsoJMigopkcwwS29U1h3wTJE/muI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOhY11CJ40Glmy+RBRUoKAF/lcGKvSMnDPJfsB99NP3Zz34gbuyv9D64cbb6x3B/tdLBMxbXUoP0jEK7QW0pZNM/XvBdX3dGGbkkR1lOLgrj5vcuvOirTWvoOkGfXCI4RiSfqdoehpJI22M4YElF796bnrH0SbNbBI+tA7kPzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jMqNYyR5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mv9aCxzS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jMqNYyR5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mv9aCxzS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jMqNYyR5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mv9aCxzS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jMqNYyR5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mv9aCxzS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AEF26A90D;
	Mon, 27 Apr 2026 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777281963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ4YMTYZIJWIRcr7EN3vBcVkNhDEpz+KWfuVnu6zHWE=;
	b=jMqNYyR58QxE1n30rLPbTTpKP4V6UhGrpWGJiLGWsH4sF01xU1yYHrfmvGNKzh0H4lMKC/
	dup8/9g85hIdmsvuqWj+AUD/TR6oKSb1n3OteC/R3fUrE54cs4VhgqgFAsohK70v/0JIR8
	uYR5CVHcEIViVmynNU2NpjMITs2e8Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777281963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ4YMTYZIJWIRcr7EN3vBcVkNhDEpz+KWfuVnu6zHWE=;
	b=mv9aCxzS5/VfvxQBF9V17c8RrDc95rJbkGn+Kcy75kxabfcgJRZqwv6tS6aTBlTJoFn2F1
	PPxqvHowJnytGrAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jMqNYyR5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mv9aCxzS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777281963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ4YMTYZIJWIRcr7EN3vBcVkNhDEpz+KWfuVnu6zHWE=;
	b=jMqNYyR58QxE1n30rLPbTTpKP4V6UhGrpWGJiLGWsH4sF01xU1yYHrfmvGNKzh0H4lMKC/
	dup8/9g85hIdmsvuqWj+AUD/TR6oKSb1n3OteC/R3fUrE54cs4VhgqgFAsohK70v/0JIR8
	uYR5CVHcEIViVmynNU2NpjMITs2e8Vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777281963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ4YMTYZIJWIRcr7EN3vBcVkNhDEpz+KWfuVnu6zHWE=;
	b=mv9aCxzS5/VfvxQBF9V17c8RrDc95rJbkGn+Kcy75kxabfcgJRZqwv6tS6aTBlTJoFn2F1
	PPxqvHowJnytGrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C89D593B1;
	Mon, 27 Apr 2026 09:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id obrWCqsr72ljVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 09:26:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ED38CA0AFF; Mon, 27 Apr 2026 11:25:58 +0200 (CEST)
Date: Mon, 27 Apr 2026 11:25:58 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: retire stale lock ordering annotations from inode
 hash
Message-ID: <yxhd5epc3eat6tcccah2ptvqlgyb2n3wkic3jevurixt7fhbxi@ygg64nrue6zw>
References: <20260423170431.1483370-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423170431.1483370-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3AEF26A90D

On Thu 23-04-26 19:04:31, Mateusz Guzik wrote:
> 1. iunique does not take the hash lock as of:
> 3f19b2ab97a97b41 ("vfs, afs, ext4: Make the inode hash table RCU searchable")
> 2. s_inode_list_lock is no longer taken under the hash lock as of:
> c918f15420e336a9 ("fs: call inode_sb_list_add() outside of inode hash lock")
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 39cb22e63d5b..2ebc3eff64fb 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -53,11 +53,7 @@
>   *   inode->i_lock
>   *
>   * inode_hash_lock
> - *   inode->i_sb->s_inode_list_lock
>   *   inode->i_lock
> - *
> - * iunique_lock
> - *   inode_hash_lock
>   */
>  
>  static unsigned int i_hash_mask __ro_after_init;
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
