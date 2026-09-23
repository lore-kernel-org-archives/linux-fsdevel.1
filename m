Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210844C518;
	Wed, 23 Sep 2026 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159924; cv=none; b=RXhFZBS0hSyBirKUaGtus9rEovcGq6Ypk1Gdf2vCQcD+qK4vUC9UVY68uXNw9swIH7eFDN8d0qCWvOQ7CyH+tDauKDdCs784ITiWMJmVVj+1a7z92XHZ2I4tiWGszVecfqSXaF8C2mV6re57+QikeiyB7oQasS+SHCg7WyGzrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159924; c=relaxed/simple;
	bh=jVXvRTRMGnrSCLbg9RQPCXRZ4/YcFTpqyh0j1YYvpzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh2eBfgL1GC0mHNgX8lsqLuHYHtyNPft+yxH5JkH2MaTdT/gz288hKCsFkyTu8Re6eOdnS6zma9SBPCraDU3L3nk54P6+L9n2jjtzoLHU91Lik5pJwsr3DyfzbsIzrl/FYB+mFx6Imnw3Wi0Tb9nvecQTRBt/AOTkgVIbu+Vy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XVMGS1o8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1cvKRZqQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wuaQx7r3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EUz1eHJe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XVMGS1o8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1cvKRZqQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wuaQx7r3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EUz1eHJe"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9AF751FAB7;
	Wed, 23 Sep 2026 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790159906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VgSltmef7rkR6OH+kojhS5odGZyWMU8aPX554ZF+1o=;
	b=XVMGS1o8pI0wbNIoS5v9VcNVPIuVRh3N4/neO/eNdjvOblVFkCEXhO8gcP7aKusbfKoPBA
	Kra0ZiQtXvULqOkdEuCqO9jKhPSyZQzNoqItf2EWRdxmvM4P+Hufuq3AEGlVJevZN74cDo
	1uKfTfF+L5qW59jg6QjWTZXlVZ1Js6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790159906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VgSltmef7rkR6OH+kojhS5odGZyWMU8aPX554ZF+1o=;
	b=1cvKRZqQ1CKmNz1QnD2Ds5kgjxrjxKbhNyuMsfCdRLvd2LuIeyxp1bki+AZGOEUgTGsd6S
	VJ0uexBeBvg1nbCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wuaQx7r3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EUz1eHJe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790159902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VgSltmef7rkR6OH+kojhS5odGZyWMU8aPX554ZF+1o=;
	b=wuaQx7r3tzaladotjBiIsSZT8T8/WviFYUp8vkD/SJO1YPVelkPYLsKEFP2fGuaD/tHf1+
	GbASOe9M6WM3j5pzMg6e081Nm9E/Koaf8NeSy4nVdYkmmjJroLrySJewa1jKDEeepf65WA
	WZGCJGemy+4KDwPQ/mVWzfvFPdkSItU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790159902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VgSltmef7rkR6OH+kojhS5odGZyWMU8aPX554ZF+1o=;
	b=EUz1eHJe9fG1DauYgxxg32dAXYUCKFcRV9/4lH5zn8HqEPuUP24SoN/wj2f3Xh0kSqPkEa
	2DjTdDh+cf9wUxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 743D113A6B;
	Wed, 23 Sep 2026 10:38:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K+j0Ex6ss2otZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 10:38:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0517BA13D4; Wed, 23 Sep 2026 12:38:18 +0200 (CEST)
Date: Wed, 23 Sep 2026 12:38:17 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <blum@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: Reduce hardlink hash allocation sizes
Message-ID: <5wbcm3ush6vtsboyy7c45ny2v546wceolwe32k5n3fufasbazo@fqtzdt4f527z>
References: <20260919213859.24667-3-blum@kernel.org>
 <cbvwd3loa6edt7tjnd24vuv4dqnu6gul2ysbaooftx7d7o7zlo@xwg2ixm5ac37>
 <arJTq4TiVgyVLGA3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arJTq4TiVgyVLGA3@kernel.org>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 9AF751FAB7
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
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

On Tue 22-09-26 12:08:43, Thorsten Blum wrote:
> On Tue, Sep 22, 2026 at 11:45:37AM +0200, Jan Kara wrote:
> > On Sat 19-09-26 23:39:00, Thorsten Blum wrote:
> > > Each hardlink hash entry reserves N_ALIGN(PATH_MAX) bytes for its name.
> > > This makes every allocation larger than 4 KiB, placing it in the
> > > kmalloc-8k bucket even for short names.
> > > 
> > > Use a flexible array with the already validated cpio name_len to reduce
> > > allocation sizes.
> > > 
> > > Also use const for the read-only name parameter.
> > > 
> > > Signed-off-by: Thorsten Blum <blum@kernel.org>
> > 
> > ...
> > 
> > > @@ -106,14 +106,15 @@ static char __init *find_link(int major, int minor, int ino,
> > >  			continue;
> > >  		return (*p)->name;
> > >  	}
> > > -	q = kmalloc_obj(struct hash);
> > > +
> > > +	q = kmalloc_flex(struct hash, name, nlen);
> > >  	if (!q)
> > >  		panic_show_mem("can't allocate link hash entry");
> > >  	q->major = major;
> > >  	q->minor = minor;
> > >  	q->ino = ino;
> > >  	q->mode = mode;
> > > -	strscpy(q->name, name);
> > > +	strscpy(q->name, name, nlen);
> > >  	q->next = NULL;
> > >  	*p = q;
> > >  	hardlink_seen = true;
> > 
> > What about the space for terminating \0 ? This way the stored 'name' will
> > be actually one character shorter because strscpy() will overwrite the last
> > character by \0. Or do I miss something?
> 
> do_name() guarantees that collected[name_len - 1] == '\0' before calling
> maybe_link(), so name_len already includes the NUL terminator and no
> character is overwritten.

Ah, indeed. Thanks for explanation. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
