Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183747535E
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158972; cv=none; b=uk4YHVGiz6gT5KpOCNZETvZMRS9AygxFD9drW/Vqy6WIX5Bv3eNVKBdjsTTLlnaIre9DCYCR2pijbtzfFY6OMBOsyQeefCzxgoJCLVgsVuzcLSUbNxGmWzAk0Bu99SkaofLRPSWUvSI27hWDURLBPr06eQT2hihgU6uZOyJVEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158972; c=relaxed/simple;
	bh=/ZseX+NbgEXKa/5/PnN2Dwai87fHfoR1HubULbkd3ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCaiU15TulZWNrCu3F2qEfbjQ7Ky0wiR5+UIGR3tS1eLW+gh5y5iGbV9ce4P+ApSNyca9GkBgMClOOlm2iEP8k7LjBmPt9+9Cu49Kl34ZPp2jrhYGgwVEat6KyI1bgdEKQ/I7aaE/9FlC7ldLX7OCTCyTVWffbkGx5erJ9Y6BbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q90HXfgY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YB74jIdV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OftuwzgW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cgrLGruF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q90HXfgY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YB74jIdV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OftuwzgW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cgrLGruF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65BC021CAC;
	Wed, 23 Sep 2026 10:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790158958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KP+pYgMgrj+DWhjzqs5pxXQoj7wUF401GN0IxHktIWo=;
	b=q90HXfgYorPPBdvjQ0np+fz0By72YHb90tUa6OWZ4DvKp4IP5XhMO+KV/4Zqix98HL5LzU
	0ciQjpiN60ENzIppfW0O+1KeNI9LReX3ZSMiUcn8F1NTsM5tQYfvvB1uF5mTsgxrPUYurf
	WOyJIRaTRQ9dANFsIQ0fs1p7p7mpQjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790158958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KP+pYgMgrj+DWhjzqs5pxXQoj7wUF401GN0IxHktIWo=;
	b=YB74jIdV1Q33Zi3LvKOuKVC/qUgZAeh8P4MUOI3kmK/KNJhq52EzHw6THt6bS54I7KkSsc
	rxCk8tPbtIZLITCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OftuwzgW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cgrLGruF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790158953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KP+pYgMgrj+DWhjzqs5pxXQoj7wUF401GN0IxHktIWo=;
	b=OftuwzgWw4q4EhEsMkc3x8j4h7JHWWR0yrtQ4KIt2RtReo4IKAk2Nf00IlRM8OVCCW9OOd
	zxuPAXFikwl093STcOOM6WOAaPxPQo0QGk2JRwUOS9Fcrmo2/HbEkDECPiZmMeMbc/z/mf
	vF/YpYqM8YrJ0uIPF32AdHvKCnjGGnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790158953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KP+pYgMgrj+DWhjzqs5pxXQoj7wUF401GN0IxHktIWo=;
	b=cgrLGruFpH+tvpr+F2Y9CMkIYhZd+u1pNZ650VXUfhku9+jN+PhAHkVAGXkAXNDMuZYFog
	NBY1YYOS3eO03zDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC504134E8;
	Wed, 23 Sep 2026 10:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zEaNKWWos2pbVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 10:22:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 550EDA13D4; Wed, 23 Sep 2026 12:22:29 +0200 (CEST)
Date: Wed, 23 Sep 2026 12:22:29 +0200
From: Jan Kara <jack@suse.cz>
To: Thomas Schmitt <scdbackup@gmx.net>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	matthias.goergens@gmail.com
Subject: Re: [PATCH] isofs: Fix handling of directories with tight blocks
Message-ID: <qgcsmycovncsffjqgvbywgagh44svitgvw5glgi7yfgtbhpez7@rfmjae6nrixq>
References: <20260922121912.2258134-2-jack@suse.cz>
 <13424504872184120250@scdbackup.webframe.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13424504872184120250@scdbackup.webframe.org>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 65BC021CAC
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmx.net];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Tue 22-09-26 16:59:16, Thomas Schmitt wrote:
> Hi,
> 
> nitpicking about a comment in isofs_find_entry():
> 
> > +                * If we are at the end of the block or at its zero-padded
> > +                * length, move to the next block.
> 
> s/length/tail/
> 
> As unprepared reader i would wonder what "zero-padded length" is.
> The comment in do_isofs_readdir() says "zero-padded tail", which i
> deem more understandable.

Good point. Comment fixed.

> As far as the program code is concerned:
> Reviewed-by: Thomas Schmitt <scdbackup@gmx.net>

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
