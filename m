Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84D3F0A86
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900630; cv=none; b=B6fnYk8mF3Hbw2GKfaAYNMliObePvDXA3CY50rvBFLPTe48UhsM3kLpER2MyPnXOfOvj6Pgdv8fFvY/UdqVROkmt2mxnyLSX8q2FftTjD0gLZbZk4ssD1oGMlBimJobo3/QYd4MWGn2FtHLhXFO8RFbzRAokWePlHZ4rfMHWRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900630; c=relaxed/simple;
	bh=uf/SHqlJlcID6ZAm/Y6yx6k/jOMu5I8DMyfoFu0rpeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul5F4Jiv+04XicfsLHMxCmxJUu7dt/0XqUNnt2Y0HfyPHZQFjmH1VSTGPeqT33Apd9ro+fAQ3B2gw8xEtBXqR7gDm6f0FOzsqyp/dqvBS6MWvCJQINrkvN/IhhmkVsrvLjDw9kq8CIFaAATcAY4RAnwjALV/dBu8hFmG/1+JVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eF0VUq3i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n1HMPlV8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2XWxz/AL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X7VcNAal; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eF0VUq3i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n1HMPlV8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2XWxz/AL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X7VcNAal"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E1D275EEA;
	Wed,  1 Jul 2026 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQsAuCfULrr4d5at8t7nMnwwroQ/kgrDznQlW2w40cU=;
	b=eF0VUq3iEdH6Plws2llipNAlWFuLBERxIN3ZhQm+1Hl4HDuHZjNZ0NJYD9uIM1buyAe5Br
	GjzJc/sX107NP5R26KfRf9UAv8vM4F7aBmrwGuQ+HOpdP+qQg5sP26Gs5NPWFMJzeBfUMH
	KZmbkHNGrstTAmZ5YJwg1xEuBzEAVOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQsAuCfULrr4d5at8t7nMnwwroQ/kgrDznQlW2w40cU=;
	b=n1HMPlV8S/4I7X7zg/dd0XBOObwzA3KIexr/PwLGVaPoc/SY7eYx/XA34OSclIMNCYma57
	+rO5i1t0LxtJo6DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2XWxz/AL";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=X7VcNAal
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQsAuCfULrr4d5at8t7nMnwwroQ/kgrDznQlW2w40cU=;
	b=2XWxz/ALnEtl+6j7PKKGtsdUxiRHNK3XioT5HtOXIZaOa3pgNG4p+8O6zfGtwXMuV4OZQw
	E3ycLy96KsKlGPm5OPNUwHSZgzPt1aoR3cGQsJ6885Iu9OqVtMCN1z0ccg6zdvBXIkQs8j
	n173zl/F0JLEA1OfZCW0W7mz6vAubIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQsAuCfULrr4d5at8t7nMnwwroQ/kgrDznQlW2w40cU=;
	b=X7VcNAal4Hvhh/rVFxkPpMOKDjLQLavfyqGULrPOidFUeQi+OcUJWEjG/apZZ9Awxv/cN8
	r8C8NVsoSx4Xw1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24853779AA;
	Wed,  1 Jul 2026 10:10:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LtHoCJHnRGr0PQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Jul 2026 10:10:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CA1A1A10B7; Wed, 01 Jul 2026 12:10:24 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:10:24 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/31] ramfs: drop redundant S_IFDIR from mkdir
Message-ID: <wa6eku46yywaw7fkxrb657i3ueeq6eqgue466wute5nhmpeqsg@zggilvdbnpo6>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <20260630105400.68459-26-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105400.68459-26-jkoolstra@xs4all.nl>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,xs4all.nl:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2E1D275EEA
X-Spam-Score: -4.01

On Tue 30-06-26 12:53:54, Jori Koolstra wrote:
> vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
> ->mkdir(), so OR-ing S_IFDIR into the mode again in ramfs_mkdir() is
> redundant. Drop it.
> 
> Assisted-by: Claude Opus 4.8 (1M context)
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ramfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 3987639ed132..e884ebc58a33 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -121,7 +121,7 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  static struct dentry *ramfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  				 struct dentry *dentry, umode_t mode)
>  {
> -	int retval = ramfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
> +	int retval = ramfs_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
>  	if (!retval)
>  		inc_nlink(dir);
>  	return ERR_PTR(retval);
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
