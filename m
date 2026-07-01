Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B02A3F483E
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900644; cv=none; b=ua108E68P3pz1ERweTjjZ/pJbhRTU2nGf6SqfFV1NSDaFlAQE6jhH1JyyXoPDy4LNxKEUyWmnlk7GzWQV0XCooNP6mYgbQbBszMjgT/ws1r9sNYKbc0JZIZTL0sg/hlcvdg8ot8VBi/CeoD+CTyGHJEcqgOAuBBhMs8gF6UYtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900644; c=relaxed/simple;
	bh=flNBnDJHKHl2Y4Dw8Yntu2rnXaDDDC39suYN+ge59QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVgJvO6H1Gxd+z/a7Xs+XwcqYfpLed0UiLPMHbpkkKVu2drbUWUs9SxnYa8c5iq+yIky7RfsbC+oMaAJJ9cgICAHkk2zehv2Qh8DtnJIX4zvt2S/e0irknNz1L9/0FJNZlAhQaHxJWdC2wJWA4u7MHzvTwkTd+bNJfw4QribcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2uTk2n7o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lc4DXSld; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2uTk2n7o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lc4DXSld; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2uTk2n7o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lc4DXSld";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2uTk2n7o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lc4DXSld"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72DB075F57;
	Wed,  1 Jul 2026 10:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wB5OUKZRkpRk5YRUDjrIqjDJBm7K2vRo+L50onlHCVM=;
	b=2uTk2n7o1gkUdoLNehQlfS2TuiBtKTI6XiiY6xbFCWVqQHD0ABFvmWhz8lcr0cpB/IGQCA
	q2EGu2EOdVzAjXB0urAc0ij23JcsW5uQKJhTOz2lY1kdk8heLPcfOxfO/gpJBHJN0yaQP5
	gXv/qkTIJjz05dmCCpzidYMOIRcwAZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wB5OUKZRkpRk5YRUDjrIqjDJBm7K2vRo+L50onlHCVM=;
	b=lc4DXSldVQl+m9N0/Jq10v0nUOMowOwovXH1ZYWzg2lmSOeqIUbHJmDv7OVwAOBy7WIRdl
	Yu582GnioL/83UDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2uTk2n7o;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lc4DXSld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wB5OUKZRkpRk5YRUDjrIqjDJBm7K2vRo+L50onlHCVM=;
	b=2uTk2n7o1gkUdoLNehQlfS2TuiBtKTI6XiiY6xbFCWVqQHD0ABFvmWhz8lcr0cpB/IGQCA
	q2EGu2EOdVzAjXB0urAc0ij23JcsW5uQKJhTOz2lY1kdk8heLPcfOxfO/gpJBHJN0yaQP5
	gXv/qkTIJjz05dmCCpzidYMOIRcwAZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wB5OUKZRkpRk5YRUDjrIqjDJBm7K2vRo+L50onlHCVM=;
	b=lc4DXSldVQl+m9N0/Jq10v0nUOMowOwovXH1ZYWzg2lmSOeqIUbHJmDv7OVwAOBy7WIRdl
	Yu582GnioL/83UDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68B40779AA;
	Wed,  1 Jul 2026 10:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dpSNGaHnRGojPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Jul 2026 10:10:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23F32A10B7; Wed, 01 Jul 2026 12:10:41 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:10:41 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 26/31] udf: drop redundant S_IFDIR from mkdir
Message-ID: <7xtkiznvwp4k27jsas7fhiugfstnnldwukxhyu4uappjhjp5ln@55feaquyekce>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <20260630105400.68459-27-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105400.68459-27-jkoolstra@xs4all.nl>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:email,suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 72DB075F57
X-Spam-Score: -4.01

On Tue 30-06-26 12:53:55, Jori Koolstra wrote:
> vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
> ->mkdir(), so OR-ing S_IFDIR into the mode again in udf_mkdir() is
> redundant. Drop it.
> 
> Assisted-by: Claude Opus 4.8 (1M context)
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index 9a3b7cef3606..849762a7d14e 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -428,7 +428,7 @@ static struct dentry *udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	struct udf_inode_info *dinfo = UDF_I(dir);
>  	struct udf_inode_info *iinfo;
>  
> -	inode = udf_new_inode(dir, S_IFDIR | mode);
> +	inode = udf_new_inode(dir, mode);
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
>  
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
