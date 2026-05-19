Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719253D3D06
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184660; cv=none; b=BtMwvpobWi7PmBPWkRsCjSvLUAS8wNKO6MgZFzobdF3WdXJC/VISmUKAeSQjz13sS9iE3btQ4NGV1/DJCce0tveGKDPeYCAXyR8db/dBBQQZt7k7Xt3RuKl11tbMc094C8VdylWbfgpqHVpb05T4mJWKfh3alC1jpna2mexYIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184660; c=relaxed/simple;
	bh=Bp1WDnDSWY/gMr1G0ULzhs1u3Y2vpC8H4yzJMBMNUjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOg+jJWWLuzTB2ET0X5W/uLPARlWwFKTMdXgWflAh/kvgTdefGG5iz6wG6/KH0zJ16NdrA6za+ORX5lnbRReH1eZ1YTssPCrlxy7D7/ROJ2SfY2oNaLvbsZm8MPvviXe2tmF6u1kfv1MsL9dUDbaHTKHiDQ4xk1QEbISc0SZwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NH/57F/a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PEvqXPfh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NH/57F/a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PEvqXPfh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NH/57F/a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PEvqXPfh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NH/57F/a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PEvqXPfh"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94BB367F93;
	Tue, 19 May 2026 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779184656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UE8DXlk4lq+cg4H9QaA33AaA2uxtpYpiWAT+mHKTZio=;
	b=NH/57F/ax4gEZA6WHG5Qdyo2VLOd222cRIUSIQwekfswNrFIkEYiTi50K0eZXH+Tlus1ir
	3fERvLSaRIywqp8FnKixCB0K41soxtYySnWJ2ynuLkeBwcWkGwzVQSdHfSioTDjz1k7GlE
	hXjG/RuKFug9Ml0jubNH1Y5szZ8d5rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779184656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UE8DXlk4lq+cg4H9QaA33AaA2uxtpYpiWAT+mHKTZio=;
	b=PEvqXPfhJktpQi27/EQ5a0a3qGSC9E2Bpa+2wj0mgMAjyWCD4lZw2u48d5sPhCogspd+s4
	6GQTbURv9GoCYECw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779184656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UE8DXlk4lq+cg4H9QaA33AaA2uxtpYpiWAT+mHKTZio=;
	b=NH/57F/ax4gEZA6WHG5Qdyo2VLOd222cRIUSIQwekfswNrFIkEYiTi50K0eZXH+Tlus1ir
	3fERvLSaRIywqp8FnKixCB0K41soxtYySnWJ2ynuLkeBwcWkGwzVQSdHfSioTDjz1k7GlE
	hXjG/RuKFug9Ml0jubNH1Y5szZ8d5rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779184656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UE8DXlk4lq+cg4H9QaA33AaA2uxtpYpiWAT+mHKTZio=;
	b=PEvqXPfhJktpQi27/EQ5a0a3qGSC9E2Bpa+2wj0mgMAjyWCD4lZw2u48d5sPhCogspd+s4
	6GQTbURv9GoCYECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D487593AA;
	Tue, 19 May 2026 09:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3kJ6IhA0DGqzZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 09:57:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D4268A0ADE; Tue, 19 May 2026 11:57:31 +0200 (CEST)
Date: Tue, 19 May 2026 11:57:31 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 01/14] configfs_lookup(): don't leave ->s_dentry
 dangling on failure
Message-ID: <qb74bxgjgjl5gxdaaucvgn77s2jfr4vyoi675qs3zvip524kjy@m4uktzzd54df>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-2-viro@zeniv.linux.org.uk>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

On Tue 19-05-26 08:06:20, Al Viro wrote:
> Normally ->s_dentry is cleared when dentry it's pointing to becomes
> negative (on eviction, realistically).  However, that only happens
> if dentry gets to be positive in the first place; in case of inode
> allocation failure dentry never becomes positive, so ->d_iput()
> is not called at all.
> 
> We do part of what normally would've been done by configfs_d_iput()
> (dropping the reference to configfs_dirent) manually, but we do
> not clear ->s_dentry there.  Sloppy as it is, it does not matter in
> case of configfs_create_{dir,link}() - there configfs_dirent does
> not survive dropping the sole reference to it.
> 
> However, for configfs_lookup() it *does* survive, with a dangling
> pointer to soon to be freed dentry sitting it its ->s_dentry.
> 
> Subsequent getdents(2) in that directory will end up dereferencing
> that pointer in order to pick the inode number.  Use after free...
> 
> This is the minimal fix; the right approach is to set the linkage
> between dentry and configfs_dirent only after we know that we have
> an inode, but that takes more surgery and the bug had been there
> since 2006, so...
> 
> Fixes: 3d0f89bb1694 ("configfs: Add permission and ownership to configfs objects") # 2.6.16-rc3
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 362b6ff9b908..e84483a0836d 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -486,6 +486,9 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  
>  			inode = configfs_create(dentry, mode);
>  			if (IS_ERR(inode)) {
> +				spin_lock(&configfs_dirent_lock);
> +				sd->s_dentry = NULL;
> +				spin_unlock(&configfs_dirent_lock);
>  				configfs_put(sd);
>  				return ERR_CAST(inode);
>  			}
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
