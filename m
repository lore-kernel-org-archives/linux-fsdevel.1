Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F39496D59;
	Wed, 23 Sep 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170655; cv=none; b=K9DHl+CZ3e0MnTh3tMPfLuP4DCaZfr9XjMCDkMkZWVwS5z+U8YifdSH+x/tnCiIYEu/5kYusU/QmF+F6OKwsVxKnRdA48D27cDcD/LRDggFBwoMcauqWB9kInH/ycRmlr55OzcOrTjavLo5y1QaV5fNNpl5Gwp5NrDgzVLZJb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170655; c=relaxed/simple;
	bh=Fcb7nKeecyRZtG9CqtBUkYjdlxcmT3QYwgba2BJ4cKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+dPJ+QzJePWd1jZqCZ6ERGD9M6EVshyB4HWHWHt1gupv+LTo3XpCeZNj1wldqLtsV72DwsFZ2UB6cPaAdAQJL8Nqb9yrN6j+MInF+PqhstvJD7Pz/b7hR4qlOwX6K5JlF+btXxLjgfY8yA/o0vJMo0Jy6n/OI9ka+vpDjohlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m5226VQs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CHsZ3VTJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J+1YfswV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ox++wCKf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m5226VQs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CHsZ3VTJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J+1YfswV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ox++wCKf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A12AF21D9A;
	Wed, 23 Sep 2026 13:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790170647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHNLwAJ2kCo7ASstkU5km7Ae8sD8Fph69aMuKEuvoI4=;
	b=m5226VQsBJNgHXPcCuD73VWmCcSAf2mRcNzuHheopjsau2q17JcTi5aJ6RFwqxRaXIJn4T
	h8DgW9ojmgI/surO8zT/A59GVv4t1/ZDe1KvcqShu/y0CY04BcM/Sf+Q2G3OuSEI6sGOOr
	52mMgFFvNb647dXxUUc1hD5lCRdrftE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790170647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHNLwAJ2kCo7ASstkU5km7Ae8sD8Fph69aMuKEuvoI4=;
	b=CHsZ3VTJMCoHQT6t8VSiGfgGk9yWbfEJfg/ZyrxTjDwkVjgvSzh3BKOOwpZsCtPUJ0vt4K
	LKt1iwj7rZTYqfDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J+1YfswV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ox++wCKf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790170643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHNLwAJ2kCo7ASstkU5km7Ae8sD8Fph69aMuKEuvoI4=;
	b=J+1YfswV8WM0t3tZkr18ZX5NVpwBA10qcMs5OIPnTjJcJYAEX8DXO1tPwDGzKZJhoRwmpa
	NcOcFJ8+Cb85Dz5qPQGnbUSo5y12npgj2XHJ2ATaQT6jB/uD56oEhd0ncXwo5cnvtMTcN2
	Sv5ARWkOEXQbR6VJ90P1YsDZux3JncA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790170643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHNLwAJ2kCo7ASstkU5km7Ae8sD8Fph69aMuKEuvoI4=;
	b=ox++wCKfQ4hUfWiKXUxyyaL4QBJa97WqVBTAeNuBvTcW/0HDd2JXXlAUTGVCoPjYeSkBjd
	xhxI9NPK1kd7UTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74A5013432;
	Wed, 23 Sep 2026 13:37:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bHk9FBPWs2rSMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 13:37:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00E84A13D4; Wed, 23 Sep 2026 15:37:22 +0200 (CEST)
Date: Wed, 23 Sep 2026 15:37:22 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Yichong Chen <chenyichong@uniontech.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] isofs: validate directory records in
 isofs_read_level3_size()
Message-ID: <cpadce3biub2f3lv5mnuegqpd5wwip3n67oe4xy3jujserdzfk@ynipz43pmoul>
References: <20260922140137.1768064-1-matthias.goergens@gmail.com>
 <20260922140137.1768064-2-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922140137.1768064-2-matthias.goergens@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A12AF21D9A
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Tue 22-09-26 22:01:36, Matthias Goergens wrote:
> isofs_read_level3_size() walks the multi-extent directory records of a
> file and dereferences de->size and de->flags for each one without ever
> checking the record's length byte.  A record with a short length placed
> near the end of a block makes those fixed-field reads run past the
> record, and for a record at the end of the last block of a page, past
> the buffer.
> 
> readdir, lookup and the NFS get_parent path have validated every record
> with isofs_dir_record_valid() since commit e2ee4078ec58 ("isofs:
> validate directory records consistently").  Use the same helper here.
> It rejects records shorter than the fixed part, records whose name
> would not fit, and records that would run past the block, so the
> straddling-record copy below can no longer be reached with a bad
> length.
> 
> Found by fuzzing fs/isofs in a userspace harness with ASan
> (heap-buffer-overflow reads in isonum_733(de->size)).
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
>  fs/isofs/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 337836a0a170..c9bc1f479161 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -1208,6 +1208,14 @@ static int isofs_read_level3_size(struct inode *inode)
>  			continue;
>  		}
>  
> +		if (!isofs_dir_record_valid(de, offset, bufsize)) {

This is going to trigger when the block is fully packed, won't it? I think
the check belongs to a moment after we've handled transition to the next
block...

								Honza

> +			printk(KERN_NOTICE "iso9660: Corrupted directory entry in block %lu of inode %llu\n",
> +			       block, inode->i_ino);
> +			brelse(bh);
> +			kfree(tmpde);
> +			return -EIO;
> +		}
> +
>  		block_saved = block;
>  		offset_saved = offset;
>  		offset += de_len;
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
