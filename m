Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09E4266B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515821; cv=none; b=H61qwxW0lN4V9rdQvpO/Mv3NJLm621eJtAx+uUbJVvnxok7Wo83hGcQs4tiM0GBa3U3S/kShgoBcSf1czjSJzKN0Pzw9o9gd0BwNNrApf3QwGgTfSbAHXBLJeDXv9CnbrWlxMsIrBPelE0TaqGIvwesj2iNBsVNq+yy6CE49uRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515821; c=relaxed/simple;
	bh=7LH+pgRoQFi27c4/tceM8UZB1X9O8CmQe30+JAm//3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulTspoV29O1uAr9aUUr2pBfP8he0OTPT5GVX1jorf0AFUt8j3qV9AhsNHskOSK53iYCOJWeej6yCYMN1tnNovcfbrYdTU6DInfk04Kf9zLXnA8Gumcor88uso+0PM7a1I0LW56esoONKtpjn48bwjbtQDuZ7SwqK9e7eAgPcj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHGKZvAH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y4FFlxx1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHGKZvAH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y4FFlxx1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHGKZvAH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y4FFlxx1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHGKZvAH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y4FFlxx1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 185C368319;
	Mon, 11 May 2026 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778515812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dK/mcnqOQPjjfs4jNJLMOxdPWNg+Q8/JyYyZTeFUy5U=;
	b=rHGKZvAHyi2u/zAdhVKkoqOX2qNdSjx02+q6VlSo4L1VwoJcmsyWMm/JnqBI/5A6uC89Nf
	PblR124S1P22ofbioHua3ItmLdYrSMnXrG7bnBCbmWLCaFGBkmrNaXZesQAfQrBOdKCb0N
	+LAYU8q8r80CJ+gVF85vYwBE5w5d2VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778515812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dK/mcnqOQPjjfs4jNJLMOxdPWNg+Q8/JyYyZTeFUy5U=;
	b=Y4FFlxx1Km71I+07oyxXizWLv9KF6sjo6Uers6gARaHvcKOXAfYTp3SJ7yBIC5GDJKib88
	nhi0FfWWNkz47WCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778515812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dK/mcnqOQPjjfs4jNJLMOxdPWNg+Q8/JyYyZTeFUy5U=;
	b=rHGKZvAHyi2u/zAdhVKkoqOX2qNdSjx02+q6VlSo4L1VwoJcmsyWMm/JnqBI/5A6uC89Nf
	PblR124S1P22ofbioHua3ItmLdYrSMnXrG7bnBCbmWLCaFGBkmrNaXZesQAfQrBOdKCb0N
	+LAYU8q8r80CJ+gVF85vYwBE5w5d2VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778515812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dK/mcnqOQPjjfs4jNJLMOxdPWNg+Q8/JyYyZTeFUy5U=;
	b=Y4FFlxx1Km71I+07oyxXizWLv9KF6sjo6Uers6gARaHvcKOXAfYTp3SJ7yBIC5GDJKib88
	nhi0FfWWNkz47WCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E2D6593A3;
	Mon, 11 May 2026 16:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tUlzA2T/AWoASwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 May 2026 16:10:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AA7BFA079E; Mon, 11 May 2026 18:10:11 +0200 (CEST)
Date: Mon, 11 May 2026 18:10:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Dave Kleikamp <shaggy@kernel.org>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Bob Copeland <me@bobcopeland.com>, Anders Larsen <al@alarsen.net>, linux-fsdevel@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 07/10] isofs: handle set_blocksize failures
Message-ID: <35a4jp5euneamhh6vlpppjthrfglp65m24bwmxv4hxjh6nf336@qpg7ch4i6dgf>
References: <20260511071701.2456211-1-hch@lst.de>
 <20260511071701.2456211-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511071701.2456211-8-hch@lst.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,suse.com,gmail.com,artax.karlin.mff.cuni.cz,paragon-software.com,bobcopeland.com,alarsen.net,vger.kernel.org,lists.sourceforge.net,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Mon 11-05-26 09:16:52, Christoph Hellwig wrote:
> isofs uses buffer_heads, which don't handle block size > PAGE_SIZE well.
> Without this, mounting we will hit the
> 
>         BUG_ON(offset >= folio_size(folio));
> 
> in folio_set_bh on the first __bread_gfp call.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/isofs/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index efee53717f1c..337836a0a170 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -818,7 +818,8 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
>  	 * entries.  By forcing the blocksize in this way, we ensure
>  	 * that we will never be required to do this.
>  	 */
> -	sb_set_blocksize(s, orig_zonesize);
> +	if (!sb_set_blocksize(s, orig_zonesize))
> +		goto out_freesbi;
>  
>  	sbi->s_nls_iocharset = NULL;
>  
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
