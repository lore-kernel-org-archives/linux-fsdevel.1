Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CED28003A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014430; cv=none; b=EbP4oNd8JFxOgJQM3Xu+ScI3499wyF+lt6NOg10Ub8NHtTHqqlipVmrIOh32lyi64OHj4EKN4ZEr2/zexhjI00InS3bZ9cSsERzYu/16Av8szwlThcyyWOjqrLKJV5qGqfit9obcOwjtDoyaUU0xbv39VBB6nCH3ICp9XGu2Qc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014430; c=relaxed/simple;
	bh=pVERjWs96rSgwkx7DTx4lvrMNHsxloAoqWeizGr5sg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeS/vy3Ry3bvT9txV6oLPvQND5ENMkIhPnH/2z0/ZNDSP5HYoxwIWz+q0gE0vy1kD3R9vj1USi4+D5WOHf9e9UhYJdeTV2pBvL/kk49BHzanwa3yqz6D0vSG5CNwJNnN1Wzz4gStRT7rgBiFRwuoMWfIaCACYCvyTWnZwY1WW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XiYPAIme; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Riv3r3U4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XiYPAIme; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Riv3r3U4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XiYPAIme";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Riv3r3U4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XiYPAIme";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Riv3r3U4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B9435BE0C;
	Fri, 20 Mar 2026 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774014427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FB2fiQ0cjoEpu/qGNrEctnM3RzKFuHSEIyrtHJjfqQg=;
	b=XiYPAIme+m5drjp6bc9TampjpCODhLtv189M2HnxC2VSU7MNKwYbr89GgfDiCEirlNADUH
	HwtvtpplJPx54drs3R9knpyZvFv9ZTjVdrhpBK5JtJjgO6OrCaA5ljtrjG3wdW82YR+t5P
	idg2N6f6kB6KlRdRl7ci28d7/rjKEjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774014427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FB2fiQ0cjoEpu/qGNrEctnM3RzKFuHSEIyrtHJjfqQg=;
	b=Riv3r3U49zeI7XfRexHJeOwQ4M9Iw6pd6Q0VUPoaYZewwRHh6CD/59QMwrt2MOPwMxnHTo
	sY2z2zy1LIgy+aAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XiYPAIme;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Riv3r3U4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774014427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FB2fiQ0cjoEpu/qGNrEctnM3RzKFuHSEIyrtHJjfqQg=;
	b=XiYPAIme+m5drjp6bc9TampjpCODhLtv189M2HnxC2VSU7MNKwYbr89GgfDiCEirlNADUH
	HwtvtpplJPx54drs3R9knpyZvFv9ZTjVdrhpBK5JtJjgO6OrCaA5ljtrjG3wdW82YR+t5P
	idg2N6f6kB6KlRdRl7ci28d7/rjKEjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774014427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FB2fiQ0cjoEpu/qGNrEctnM3RzKFuHSEIyrtHJjfqQg=;
	b=Riv3r3U49zeI7XfRexHJeOwQ4M9Iw6pd6Q0VUPoaYZewwRHh6CD/59QMwrt2MOPwMxnHTo
	sY2z2zy1LIgy+aAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D3794281C;
	Fri, 20 Mar 2026 13:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1UMeB9tPvWksDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Mar 2026 13:47:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D1B0FA0A81; Fri, 20 Mar 2026 14:47:06 +0100 (CET)
Date: Fri, 20 Mar 2026 14:47:06 +0100
From: Jan Kara <jack@suse.cz>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	rppt@kernel.org, pratyush@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [RFC] liveupdate: prevent double preservation
Message-ID: <gdu6kqpymqgkzbw2yrvvsrububimn2ocuyi533d6llofqu32kd@sqc6d6hsuzic>
References: <20260317023834.487682-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317023834.487682-1-pasha.tatashin@soleen.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2B9435BE0C

On Mon 16-03-26 22:38:34, Pasha Tatashin wrote:
> Currently, LUO does not prevent the same file from being preserved twice
> across different active sessions.
> 
> Add a new i_state flag I_LUO_PRESERVED and update luo_preserve_file()
> to check and set this flag when a file is preserved, and clear it in
> luo_file_unpreserve_files() when it is released. This ensures that the
> same file (inode) cannot be preserved by multiple sessions. If another
> session attempts to preserve an already preserved file, it will now
> fail with -EBUSY.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
> 
> Background:
> Because LUO preserves files of absolutely different types: memfd, and
> upcoming  vfiofd [1], iommufd [2], guestmefd (and possible kvmfd/cpufd).
> There is no common private data or guarantee on how to prevent that the
> same file is not preserved twice beside using inode or some slower and
> expensive method like hashtables.

OK, I guess since this is a single bit, we can live with that although it
seems a bit wrong that LUO needs this in generic struct inode. But all
other "cleaner" variants I could think of were just an overkill. So feel
free to add:

Acked-by: Jan Kara <jack@suse.cz>

Just one nit below:

> [1] https://lore.kernel.org/all/20260129212510.967611-1-dmatlack@google.com
> [2] https://lore.kernel.org/all/20260203220948.2176157-1-skhawaja@google.com
> 
> @@ -744,7 +746,8 @@ enum inode_state_flags_enum {
>  	I_CREATING		= (1U << 15),
>  	I_DONTCACHE		= (1U << 16),
>  	I_SYNC_QUEUED		= (1U << 17),
> -	I_PINNING_NETFS_WB	= (1U << 18)
> +	I_PINNING_NETFS_WB	= (1U << 18),
> +	I_LUO_PRESERVED		= (1U << 19)

Add comma at the end of line here please so that we don't have to modify
the last line again.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
