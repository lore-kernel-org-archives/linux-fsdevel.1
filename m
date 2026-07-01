Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34DB31A81C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900574; cv=none; b=FnlVziNMC226f8+RzpayH4cSDsI1sTHoO5niMCugq+SFt//iQzInLj2N9W+YV2Ojpski4jF6Yre4ax9WiPoVv22iHM/xIq2WTRgabbDKm6/Efy1mlZdCvmC8kfWz29qeZqUqzj+ST7Bd+sdYVl4zwyWGsc1rBj9nzyNHKlxCFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900574; c=relaxed/simple;
	bh=Q6jeOXfdz0LYxKE+iYxt6o0gJtI2MwndsIoVnvkcSrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh770Wh7mc4KNwanReHE9+vWd5fcK4/Qvvlkh8KkvSXGaHtDg1OrsKFOm0iSFYyj4DSrIXxBT0Ot1c4npS8qiTVZXhYyY8iBoKbIM17IgfGND71I5vnjKrB7gA6mdkZpa9ji5MzFzr5Yd42LeFAtrKtIpHm3HGnczNrr2txhDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YIYCLGUf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qDryHgrG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xh42Ory4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fmI0lNr8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YIYCLGUf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qDryHgrG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xh42Ory4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fmI0lNr8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2E0F75F1F;
	Wed,  1 Jul 2026 10:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+rZww8AFz1oGza0weZ4GAclPp0IY3K7WGQoSVeP2kU=;
	b=YIYCLGUfNx+QATeqO+a/EdjJYe7fjtp4ZFv3/as1bCYDRpZyfc3QGDP3hTAvbLeEIpSisq
	jQqmP9Ov6gak3jcftrt67KbP4YZgXujEH3k0dupAAR2WHSuzt6PaQp0DW4DHYdr6/hZhyH
	ZCZ+qNHi4/4VkeaBZP70et998Bh+LIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+rZww8AFz1oGza0weZ4GAclPp0IY3K7WGQoSVeP2kU=;
	b=qDryHgrG/LcZRA6+rzopTC1nvZb4/rjHDAIQDBpRsd85j3HkqcXN2RF0l0r7l2IM8rGTMZ
	zWS78cJYTLWKbtDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xh42Ory4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fmI0lNr8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+rZww8AFz1oGza0weZ4GAclPp0IY3K7WGQoSVeP2kU=;
	b=xh42Ory4FqVV5dvEgQG9hBNKSsEN3NGMuooYhtZXb2qYpzWa4jp86Lp9Tqv3+XHhTf0cf4
	BpAoxI15e2ynQxlhiPBo2dW6ATAC911+UEOJ+bsss3CgR7QETCxCsP9WTKDd488oRt/plK
	PofN1KpdDaCjQ/4eblrCxiwZIPDVwoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+rZww8AFz1oGza0weZ4GAclPp0IY3K7WGQoSVeP2kU=;
	b=fmI0lNr89QjHW5uNZj9x8p3/4IX77Uuo2t2SU0Ii2Wyvgsf310GoXlDnpCamTtiNyrHeBU
	VVp5vhmjmPRvzRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4E90779AA;
	Wed,  1 Jul 2026 10:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ANMQMFnnRGq7PAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Jul 2026 10:09:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 74003A10B7; Wed, 01 Jul 2026 12:09:29 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:09:29 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/31] ext4: drop redundant S_IFDIR from mkdir
Message-ID: <t35pjtfmlfgo6pnpjxt27mfja2gwc3myveumlmvoxngqrnfqie@h6f5dggm5o3i>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <20260630105400.68459-10-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105400.68459-10-jkoolstra@xs4all.nl>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D2E0F75F1F
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim,xs4all.nl:email];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,xs4all.nl:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 30-06-26 12:53:38, Jori Koolstra wrote:
> vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
> ->mkdir(), so OR-ing S_IFDIR into the mode again in ext4_mkdir() is
> redundant. Drop it.
> 
> Assisted-by: Claude Opus 4.8 (1M context)
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index cc49ae04a6f6..0992fe21b261 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3009,7 +3009,7 @@ static struct dentry *ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
>  		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
>  retry:
> -	inode = ext4_new_inode_start_handle(idmap, dir, S_IFDIR | mode,
> +	inode = ext4_new_inode_start_handle(idmap, dir, mode,
>  					    &dentry->d_name,
>  					    0, NULL, EXT4_HT_DIR, credits);
>  	handle = ext4_journal_current_handle();
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
