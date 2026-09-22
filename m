Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141A53B349;
	Tue, 22 Sep 2026 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076143; cv=none; b=VD21AJYD0THs/0SH59NF1d45ueQjJ59qNYvx0I5YuHijY+3I9PdOKV2Ktnh6O5n3RCJkdEt7FxdeZzIQmazVVtHv5EVN8KJkOrM0OokjoKvR3Vqx2xWmDnvC5zptTA61HFiLXU0WpO1ktS0jktBc5mGpZ+LKQwj9kL+v6hSmAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076143; c=relaxed/simple;
	bh=Tp9PpnWd92PUXrS2cjDF3AfmWr8mKIT7mx6AmresTZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjzjjXvE3bubNACrQ9FKfMvyd5BWDwM7qFpAer9F7VClltrChuBgSfZ4xOnAmF0/v3UHpIK73iarsi+yQdx7Kr87XRHZF1wWFXUw4nqgm9xGlUXe3k0F1NLQiPu9WB3lG44CrP7D6jjtx2HmCr3wJraSJk5Ulpyv1/3Rfo2h7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=saz5H1sG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ltgLdkky; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UGicqMVT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GkodHjKM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="saz5H1sG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ltgLdkky";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UGicqMVT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GkodHjKM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB68A1F747;
	Tue, 22 Sep 2026 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790076135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zu2CHSH9fQhYPZ4Cl4wc+jC2llpz0LPUJUaynlxI8o=;
	b=saz5H1sGWGz2KdH7CJIo5BDTqiIKTPuvMSwfF2tH6aYT/ra0haSF/xUOdkvdcZn/RJmp+i
	aqYDvwj2TGHRTdjD8Ml/jOHML7UI+Snyz4dyg+PR/U4L2+wlofHqDYMiu6d0ZYiN/rzJKe
	YVlUSSC2UqdeQBBfUjUzUT+pCZcuFhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790076135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zu2CHSH9fQhYPZ4Cl4wc+jC2llpz0LPUJUaynlxI8o=;
	b=ltgLdkky4lGZEXhCd+FRuURnPH3eLijDgbWZmswRIKA4S38d0sp7rOy+TUelT2RU9ogfGh
	KL8/Q1xHcRMst1DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UGicqMVT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GkodHjKM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790076131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zu2CHSH9fQhYPZ4Cl4wc+jC2llpz0LPUJUaynlxI8o=;
	b=UGicqMVTtj0PjpNKoSNLlteZLmB2bPxMgQwBFflQr6B+Kep+ragJfhUN3OzISwSx/RHaVd
	47he3AJCnKLtLnKv+FA3PZoKKirz1/ejaALZ9jZilUaKTfAvZQjEdqFh0q3dF5dOEPncrR
	VjOxBPd/Wt6UuiwqHcVKXHs2fhFY17s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790076131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+zu2CHSH9fQhYPZ4Cl4wc+jC2llpz0LPUJUaynlxI8o=;
	b=GkodHjKMQqCd4SfNycae/pnpGF1Ca7jDmXv97IAzVyJvTUbfYk0KUo7luSbERfg080xPBs
	OA+b4lh90fm2q3Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9339813A23;
	Tue, 22 Sep 2026 11:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PP3jHeNksmpUZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Sep 2026 11:22:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2DCDAA13D4; Tue, 22 Sep 2026 13:22:03 +0200 (CEST)
Date: Tue, 22 Sep 2026 13:22:03 +0200
From: Jan Kara <jack@suse.cz>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	Matthew Wilcox <willy@infradead.org>, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/gfs2: prevent premature evict in prune_icache_sb
Message-ID: <rhj2uhowkjekxgi7tkxko5odxw3zikthtnlef5f5owrfjzrt3r@nul7b7ldcb2g>
References: <20260921211712.1563575-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921211712.1563575-1-agruenba@redhat.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: BB68A1F747
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
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Spam-Flag: NO

Hello Andreas!

On Mon 21-09-26 23:17:11, Andreas Gruenbacher wrote:
> Introduce a new I_NOPRUNE i_state flag for preventing prune_icache_sb()
> from pruning specific inodes.
> 
> prune_icache_sb() prunes clean inodes under memory pressure ("direct
> reclaim").  An inode is considered clean when none of the i_state flags
> are set; the assumption is that evicting inodes that don't have any
> i_state flags set will be fairly cheap.
> 
> Unfortunately, on gfs2, inodes can be clean in the sense that they won't
> require writing back to disk, but they may still have outstanding
> revokes (as indicated by the GLF_LFLUSH inode glock flag).  To evict one
> of those inodes, those outstanding revokes need to be written out first.
> 
> This requires flushing the log, which is already an expensive operation.
> When in data=ordered mode, all the ordered data needs to be written out
> before the log can be flushed, which makes things even worse.
> 
> As previously discussed [*], we are currently also running into the
> following warning in iomap_writepages() when flushing ordered data:
> 
>     /*
>      * Writeback from reclaim context should never happen except in the case
>      * of a VM regression so warn about it and refuse to write the data.
>      */
>     if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC | PF_KSWAPD)) ==
>                     PF_MEMALLOC))
>             return -EIO;
> 
> So we need to prevent prune_icache_sb() from evicting inodes that have
> any outstanding revokes.  This patch achieves that by introducing a new
> I_NOPRUNE i_state flag.  When that new flag (or any other flag) is set,
> prune_icache_sb() will skip those inodes.
> 
> In the filesystem code, we set and clear the I_NOPRUNE flag in sync with
> the GLF_LFLUSH inode glock flag.
> 
> An alternative approach might be to allow filesystems to refuse evicting
> inodes that prune_icache_sb() has already selected.  This could be
> achieved by changing the ->evict_inode super operation to return a
> lru_status code or similar.  prune_icache_sb() would then have to
> resurrect inodes that were already marked I_FREEING and put them back
> onto the lru list.  This approach doesn't seem obviously better than
> introducing I_NOPRUNE, so I haven't pursued this any further.

So for situations like this I've written a patch set to allow filesystem
to mark inode for deferred reclaim (from a workqueue) [1]. Would that work
for you? It will definitely solve your problems with warnings in memory
allocator.

I don't want to have two different mechanisms for the same issue so if my
solution doesn't quite work for you, let's discuss how to make it better
:).

								Honza

[1] https://lore.kernel.org/all/20260911081309.14137-1-jack@suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
