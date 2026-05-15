Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCA341AC7
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862328; cv=none; b=b9koK7Pwbkr+ZLWn9wvPayrwBml9HJy1Q9SOaE++QPCd6mXvr2ogvJokDOX8DjMEP5mrvYzdzeHnj6asaRSI0AN9dPlYTW8zWJEAQCGmhkopnpSPdt0C9f8ts/Yak73rnA3tJfwb1tM7QPdfDJW3lpSIkb/PslCRnnbiGMvAkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862328; c=relaxed/simple;
	bh=TKfH5O4zeMddCu6EkUZoHeVuImIP6rNSUOefEz/cPko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCXvRi1hRIbhB3EUdD/0/jo/DMe/eT1ZN7ZcQYjo5Za+QiqRUYTa/YGWtUQy1P9ALvnQBz+IXS/dNQcpMz9PJSxc2IqjCkwSK9vj8a6jdQQArkWJvI/cappnCQvL8xF7DoQxxooTvIpc8IAAOXDIloRmF7iXvZ19qkAo80iPa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zfcjXep9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qr2Y77hv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zfcjXep9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qr2Y77hv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zfcjXep9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qr2Y77hv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zfcjXep9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qr2Y77hv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D24567165;
	Fri, 15 May 2026 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778862325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxJg0iXRLKXRu5qZOxApH+b9ZrfPfD6YiMD+Y9OuO68=;
	b=zfcjXep9XPWEKpJu1x8fn2SGAVPz07J8ftGtztJPePHq+uzr3bXky09VG7ITC0WJvgzBTM
	f3DMMxCVSGHor/CvQTm+3AqUhlfzyPCMOCZrpdWpLiM8jrwYXtx6ujmn/4L2kMbiDmiwVS
	4PoR8IIY2IWdwDq9F+JNIKUD8SqUhmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778862325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxJg0iXRLKXRu5qZOxApH+b9ZrfPfD6YiMD+Y9OuO68=;
	b=Qr2Y77hvPMbzO9ivscUDcglVVt03Zm4Uo8LUpLbcQh0mfuHfCnWwg0OsPTl7v+VTKJX1fb
	ateBRlGCD1yMB0Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zfcjXep9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Qr2Y77hv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778862325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxJg0iXRLKXRu5qZOxApH+b9ZrfPfD6YiMD+Y9OuO68=;
	b=zfcjXep9XPWEKpJu1x8fn2SGAVPz07J8ftGtztJPePHq+uzr3bXky09VG7ITC0WJvgzBTM
	f3DMMxCVSGHor/CvQTm+3AqUhlfzyPCMOCZrpdWpLiM8jrwYXtx6ujmn/4L2kMbiDmiwVS
	4PoR8IIY2IWdwDq9F+JNIKUD8SqUhmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778862325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxJg0iXRLKXRu5qZOxApH+b9ZrfPfD6YiMD+Y9OuO68=;
	b=Qr2Y77hvPMbzO9ivscUDcglVVt03Zm4Uo8LUpLbcQh0mfuHfCnWwg0OsPTl7v+VTKJX1fb
	ateBRlGCD1yMB0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E8FB593A9;
	Fri, 15 May 2026 16:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wQ8FA/VIB2pEHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 May 2026 16:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 898C0A080D; Fri, 15 May 2026 18:25:20 +0200 (CEST)
Date: Fri, 15 May 2026 18:25:20 +0200
From: Jan Kara <jack@suse.cz>
To: Ingyu Jang <ingyujang25@korea.ac.kr>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ufs: Handle NULL return from ufs_get_locked_folio()
Message-ID: <o3ywsvtbj5tq4a3zonsmngp5eqxlkefnmus6dg5a7i6f3jz2ws@v6vpnnhqumjg>
References: <20260514193256.2556905-1-ingyujang25@korea.ac.kr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514193256.2556905-1-ingyujang25@korea.ac.kr>
X-Spam-Flag: NO
X-Spam-Score: -4.01
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1D24567165
X-Spam-Level: 

On Fri 15-05-26 04:32:56, Ingyu Jang wrote:
> ufs_get_locked_folio() may return either an error pointer (when
> read_mapping_folio() fails) or NULL (when a concurrent truncate has
> detached the folio from its mapping). The current IS_ERR() check in
> ufs_alloc_lastblock() only handles the error-pointer case; a NULL
> return falls through to folio_buffers(folio), causing a NULL pointer
> dereference under the truncate race.
> 
> Use IS_ERR_OR_NULL() to cover both failure modes.
> 
> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>

Well, but this shouldn't really happen because ufs_alloc_lastblock() is
called only from ufs_truncate() where it is protected from folio being
detached by i_rwsem. Still probably makes sense from code robustness POV
though so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

but please update changelog to reflect this.

								Honza

> ---
>  fs/ufs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
> index 440d014cc5ed5..989ff3d3ad179 100644
> --- a/fs/ufs/inode.c
> +++ b/fs/ufs/inode.c
> @@ -1051,7 +1051,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
>  
>  	folio = ufs_get_locked_folio(mapping, lastfrag >>
>  				       (PAGE_SHIFT - inode->i_blkbits));
> -	if (IS_ERR(folio)) {
> +	if (IS_ERR_OR_NULL(folio)) {
>  		err = -EIO;
>  		goto out;
>  	}
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
