Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D15625F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182524; cv=none; b=bN24bc8I9mNmWERcfd7yjK3pVDvoRvffGjT5Gvy9x4BkzhmufCJ3lUeJkLaJExN/60LRky5RJyvSMim3kAB/sYBGA+zYvqAzUJvkfIYuDsMshCxwAfileT7OzYe/nUVfXzVq5bYtR/Rj/6OyuPXf9YTRqntjdFo5fPfI/JHng9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182524; c=relaxed/simple;
	bh=tbWTwbYU2CWh0Y1WgxdFRIpTX6XM+Nl8oNKuqbhVwTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI4x9SckV1piPdRDGyUN4ajGKrhVLTbug0cdMh75JkUu/5tp4DoJOv0W7kI7QClk3EVKK2LUB8B03m4MiFPYsFK33xPhP/Ipiw5uq1oqYM9VTqkzDdZ3waA30lj+MwVDOEb7lxh2GLK0Xak3EtY8rIsFeFw74dt1SDIeS4adzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZEoSY+MK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N5r7gRxQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=an0c1M9C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ny476+ZD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZEoSY+MK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N5r7gRxQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="an0c1M9C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ny476+ZD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67DA71FFAA;
	Wed, 23 Sep 2026 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790182516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9w031hqiZtP/rgI86jSnA2hqiaR0GGC8QKkNB7iHCCI=;
	b=ZEoSY+MKu0pLyzUMOE6i2+5JsuGhZy8IFKWPnrGSjk7XT2yjO58TEq6j6/m/hl0/MVQqfj
	R/xw/oyk7MR/vWM0Ucg54ljsnfR7ofvOcXzamjhc2QiyKTrkqiAdCrqsWlcQPVn5vKlmBN
	GRgqWeL4yeOAdcgFAsDF6jddzeDt/8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790182516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9w031hqiZtP/rgI86jSnA2hqiaR0GGC8QKkNB7iHCCI=;
	b=N5r7gRxQnziVXVPZyX+fD3Gq3YY7Fv6BqXuSkFAZ2uyIZnGp7TwwyBKTAKq3INEJ6Zr3ve
	6GYpbB3hP/yeIsDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790182512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9w031hqiZtP/rgI86jSnA2hqiaR0GGC8QKkNB7iHCCI=;
	b=an0c1M9CRIwcD7h2dAPLnKDe5UHFmH9fraL9c1cxNv8bBSMVDdWZvW8BgOYFGF0AnY4Qee
	zr/zvhfMdhJJStBM7Yl2DuW2dLP222UMhY+SFqV4exx7cOFlzmq8BShApIdMNbxfYhb7N2
	J/dzX6ProMwlsoPRugf6OxSYC69UGaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790182512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9w031hqiZtP/rgI86jSnA2hqiaR0GGC8QKkNB7iHCCI=;
	b=Ny476+ZDNbZPn4pPGJnx9DQxdK/708nCE9fVOfNDvrPlcFQxWU7aYF5mqpTY2KSWJyqqcb
	K96ImEZBA3PDLsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DA1913432;
	Wed, 23 Sep 2026 16:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dFrjBnAEtGoZCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 16:55:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA4F0A13D4; Wed, 23 Sep 2026 18:55:11 +0200 (CEST)
Date: Wed, 23 Sep 2026 18:55:11 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Thomas Schmitt <scdbackup@gmx.net>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] isofs: Always advance to the next block in readdir and
 lookup
Message-ID: <vjb4g4xyuare7b6w6lwtbuijboeqhrzdo4vboi7fgpyeu4prtx@gv2zvtsbae6u>
References: <20260922121912.2258134-2-jack@suse.cz>
 <20260923153134.771632-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923153134.771632-1-matthias.goergens@gmail.com>
X-Spam-Score: -2.30
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
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmx.net,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Wed 23-09-26 23:31:34, Matthias Goergens wrote:
> Commit 3c01d9263683 ("isofs: Fix handling of directories with tight
> blocks") made do_isofs_readdir() and isofs_find_entry() move on to the
> next block with pos = round_up(pos, bufsize) both when a record ends
> exactly at the end of the block and when the next length byte is zero.
> In the second case pos is already block aligned if the zero byte is the
> first byte of a block, so round_up() leaves it unchanged, the same block
> is read again, and the loop never terminates. There is no
> fatal_signal_pending() check in either loop, so the task spins at 100%
> CPU and cannot be killed, and a second lookup of the same name blocks in
> d_alloc_parallel() and trips the hung task detector.
> 
> A block that starts with a zero byte inside a directory is reachable
> with a single-byte change to an image made by xorrisofs, and without
> any corruption when the logical block size is 512 or 1024 bytes:
> ECMA-119 zero-pads a directory only up to the end of the 2048-byte
> logical sector, so the later logical blocks of a sector that is less
> than full start with zero bytes and lie within the directory's size.
> 
> In both walkers pos equals (block << bufbits) + offset, so the next
> block is simply block + 1. Advance to it directly, which is right for
> both cases.
> 
> Fixes: 3c01d9263683 ("isofs: Fix handling of directories with tight blocks")
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
> Jan, this is on top of your for_next; feel free to fold it into
> 3c01d9263683 instead if that is easier before you send it to Linus.

So I agree what you do is easier to understand so I'll fold it into the
previous commit. Just I'm not sure it is a realistic failure case - that
would mean a directory would contain full block of zeros which I don't
think can happen. Plus this infinite loop was there forever AFAICS and
nobody complained...

								Honza

> 
>  fs/isofs/dir.c   | 4 ++--
>  fs/isofs/namei.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index 5e541e765f547..28741251d56e3 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -119,8 +119,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
>  		if (offset >= bufsize || de->length[0] == 0) {
>  			brelse(bh);
>  			bh = NULL;
> -			ctx->pos = round_up(ctx->pos, bufsize);
> -			block = ctx->pos >> bufbits;
> +			block++;
> +			ctx->pos = (loff_t)block << bufbits;
>  			offset = 0;
>  			continue;
>  		}
> diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
> index e1c571478e8f5..4fba1bf7f0167 100644
> --- a/fs/isofs/namei.c
> +++ b/fs/isofs/namei.c
> @@ -82,8 +82,8 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
>  		if (offset >= bufsize || de->length[0] == 0) {
>  			brelse(bh);
>  			bh = NULL;
> -			f_pos = round_up(f_pos, bufsize);
> -			block = f_pos >> bufbits;
> +			block++;
> +			f_pos = block << bufbits;
>  			offset = 0;
>  			continue;
>  		}
> 
> base-commit: c8437ca3d4386af1ae1f2869643e82fdb9c1f0f5
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
