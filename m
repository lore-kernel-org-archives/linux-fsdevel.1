Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB28547074;
	Wed, 30 Sep 2026 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768156; cv=none; b=o4817ahjDDwO9RCbs2Szdy5ExRrfM5Dv4cYw31ADoIZ4oK3NMGynzN1BBOxJ5kvWtAkkXt1bL47vBpOZLhUTlEqBflo90muVzh2XS1TjycOUeDRRGfcFnh6MJ8G4NrTFGgQ9/g6YyZyaiWbqTAdHpPHBqeyntIruD79v+Ro6RQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768156; c=relaxed/simple;
	bh=GQfdl1fD6ETiZvCgZxVhwOOYjJ3r/8URl41sHVMxb3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovFzKYIWyLL31CIlh+EvsL8wlHz4YqE+fF5upbHyffIRuDn1lGfedSwmWP+1ITv2XhTdlasYb+PF9J4QeJimhI7SsDcnX1kseTESFiYIE6L9BTIHGGt54JAEqaGjX2hX3cibdxv5C50me9gCKfiaGJK2OT6sNGQrMLMGe1Yd9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ww5xsU4o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mSjP4dXB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3GA3Uw5K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RbSHjcYH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ww5xsU4o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mSjP4dXB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3GA3Uw5K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RbSHjcYH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A09821D6E;
	Wed, 30 Sep 2026 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790768148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXI58kVKGHKbCjMpYt+Leu/5KRXymy9PQ/dRuuwjnLg=;
	b=ww5xsU4oLekq2MdM6Jah08ODQJb2MtBEKENsVNrwl7qOpXsfWyTafhQYatCUEIHOM3I9YA
	nSOjdXv0/iLdWYjMyg3aUvF9QHC4hhl6hSshrtbDCBNdr+zITq8rKXybauR7NGkYeBQHA3
	6yzPocAHFdYFbSsypivctQgYmUQF13Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790768148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXI58kVKGHKbCjMpYt+Leu/5KRXymy9PQ/dRuuwjnLg=;
	b=mSjP4dXBNFwpl0aXEF7/O45ovdC+ho1/Bmfx1AKmR/I/I1x2ugFgtSQZGel59eClPVU2o8
	8S/nKV6wFBxZ6qDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3GA3Uw5K;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RbSHjcYH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790768144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXI58kVKGHKbCjMpYt+Leu/5KRXymy9PQ/dRuuwjnLg=;
	b=3GA3Uw5KOozg6FMeTUmmVYLUJ9od9VyPtt8SZB6olmFGxXQaTW0w+3eZBYJAZAlcu8mxmB
	e8zvOP/4JhnLThsTSh/4vVmZSE5NzF5dfIsZK/kRi4ihsX9eB2DyQygDc4A5hb9zF4SDMe
	vWwxKmppP9xUfEcsTqL/ApLyzthnzNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790768144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXI58kVKGHKbCjMpYt+Leu/5KRXymy9PQ/dRuuwjnLg=;
	b=RbSHjcYHnKxo1PI8WZEcNWudA7UkpC6PePaNw8/dvNGYVpD8DGjAm/P6QLaU6aul/ctIaN
	iZI+FzY7odf37RBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E533613722;
	Wed, 30 Sep 2026 11:35:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2q0ULw/0vGqiPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Sep 2026 11:35:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 879C5A13AD; Wed, 30 Sep 2026 13:35:39 +0200 (CEST)
Date: Wed, 30 Sep 2026 13:35:39 +0200
From: Jan Kara <jack@suse.cz>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS: d_duplicate: repair comments to avoid kernel-doc
 warnings
Message-ID: <nlqvldcyutesquh6s3ysgxt5ume4m6jvr3k4yqitvmhcmc3tph@hqzpuocxpty2>
References: <20260928211000.1539250-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928211000.1539250-1-rdunlap@infradead.org>
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
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,linux.org.uk:email,brown.name:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1A09821D6E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Mon 28-09-26 14:10:00, Randy Dunlap wrote:
> Use a typical list style for comments to prevent kernel-doc warnings:
> 
> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2029: ERROR: Unexpected indentation. [docutils]
> Documentation/filesystems/api-summary:20: ../fs/dcache.c:2030: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> 
> Also, modify the spelling of "whiteout" to match all other uses in
> the kernel source tree and to be consistent on the same line.
> 
> Fixes: 33d76519f0cc ("VFS: add d_duplicate()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Cc: NeilBrown <neil@brown.name>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> 
>  fs/dcache.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> --- linux-next-20260928.orig/fs/dcache.c
> +++ linux-next-20260928/fs/dcache.c
> @@ -2025,10 +2025,11 @@ EXPORT_SYMBOL(d_alloc);
>   * @dentry: the dentry to duplicate
>   *
>   * Some rename operations need to be combined with another operation
> - * inside the filesystem.
> - * 1/ A cluster filesystem when renaming to an in-use file might need to
> + * inside the filesystem::
> + *
> + * 1. A cluster filesystem when renaming to an in-use file might need to
>   *   first "silly-rename" that target out of the way before the main rename
> - * 2/ A filesystem that supports white-out might want to create a whiteout
> + * 2. A filesystem that supports whiteout might want to create a whiteout
>   *   in place of the file being moved.
>   *
>   * For this they need two dentries which temporarily have the same name,
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
