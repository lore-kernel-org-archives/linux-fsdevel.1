Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038EB4FE2C4;
	Tue, 29 Sep 2026 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679488; cv=none; b=JORXCtlkE1l7sXr6A8RORK6bRKTwq9nNNi1SAlIECVNwfJbhLDiCCmA4jSX+sxTs+V4cR6vzZBV34Gzv4pdred/a6UXb7eEJbyXXG00vbTehuWXVNHWQysoN/1n9wzsIK5SqgF2OBwHwlBZ88bDE3aT52OsuTixLV5WmVjG0njk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679488; c=relaxed/simple;
	bh=Qa7OBGpxl+kQdR4zeETbPJkdXlexsIGL9/D/7cSJMOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9BFZ8M4j9wrhjjFaGvwFvPQviQO3B0+NVzlOWcPwhKqLcD6lEHulniNs4mwTBQDFOzhFGtJ5BsRsoJvIgJ6du1nFLjJ+3MHBd7SjroETpIFSgfNw5cc4kOS91CgKWY3FW5j3JKDhu4FCLB74r9KxM0l8V6qW/y3WK3/XqAZZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9nKF+cw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SQd4oAST; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4zqbyCj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eonhaonq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9nKF+cw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SQd4oAST";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4zqbyCj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eonhaonq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6B841F7D9;
	Tue, 29 Sep 2026 10:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790679472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/gMs4OvWesls8mrP38XACVxq+iHXgQgPEhCSwmqIvY=;
	b=i9nKF+cwQxGhhWjTQdOGMXFOd/OF5JPE1DmBgZ9X7REMsnZQne1VMAN8TExtzB3dEQ+qmE
	K487QBQHnyMOtmV94Pgfz+3Y7jiUeVHlwvyOPpwQ84KKSDayMwovQYGHj5jVjj6DrNJaDA
	P3XnJXLaE/8TSk01XddaP2/hnAaujAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790679472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/gMs4OvWesls8mrP38XACVxq+iHXgQgPEhCSwmqIvY=;
	b=SQd4oAST4RTwRx1DttxouDhk/f0ps1NjAAwN/NCqPE/lhA7/q/CXnizlCFGTjD2f32vW/u
	bi6cKSQ92c7YNkAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790679467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/gMs4OvWesls8mrP38XACVxq+iHXgQgPEhCSwmqIvY=;
	b=x4zqbyCjFcpZM/1Aq8fatSXsnIILny35LISlZLy4k3V1IAl2FH1cxOMYie+fgii/1zhLKi
	qC5u2CK5R+jEq5f/BkPfNeGw3yyl/rs9IouwEnm/V/I/pf5jzrWNIDGZVMfSosRNnlXBPV
	TpgUSCW0WvFzd6KaXAn6PqldMpW/TuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790679467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/gMs4OvWesls8mrP38XACVxq+iHXgQgPEhCSwmqIvY=;
	b=Eonhaonq7/xRW2BMy2QvJeslU2/7AVvxxbmAXH7HnediQK7s7wbuDVKrIxk+ibWI+UrlVj
	YK+FxfItvIqEwyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA8E2136D1;
	Tue, 29 Sep 2026 10:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id it/PIKuZu2oXdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Sep 2026 10:57:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 38FCFA132A; Tue, 29 Sep 2026 12:57:47 +0200 (CEST)
Date: Tue, 29 Sep 2026 12:57:47 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Hui Peng <benquike@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: bound empty directory blocks in
 isofs_read_level3_size()
Message-ID: <cm3n7vjwbdnafttuz5ftkzz5wdbalgews4dfs5zlwvkyuzotuq@jo2nhsplhstc>
References: <20260919222553.3792320-1-benquike@gmail.com>
 <20260923175215.1577791-1-matthias.goergens@gmail.com>
 <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf>
 <20260924151356.3287733-1-matthias.goergens@gmail.com>
 <20260925043804.2091174-1-matthias.goergens@gmail.com>
 <cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n>
 <20260926083517.556576-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926083517.556576-1-matthias.goergens@gmail.com>
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,zeniv.linux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

On Sat 26-09-26 16:35:17, Matthias Goergens wrote:
> isofs_read_level3_size() walks the sections of a level-3 (multi-extent)
> directory record and, on a zero length byte, moves on to the next
> block with no limit.  A crafted image can put a long run of empty
> blocks between two sections of a multi-extent file, and the walk reads
> every one of them before it gives up, all the way to the end of the
> device if it has to.
> 
> Real discs do have trailing empty directory blocks, written by tools
> such as Easy CD Creator and Nero, but always at the end of the
> directory, never between two sections of a multi-extent record, so
> they do not exercise this path [1].
> 
> Jan Kara suggested treating an empty block like a section: count it
> towards the existing 100-section limit rather than adding a separate
> one [2].  Do that: both the section count and the empty-block count
> are checked against their combined total, so neither one alone can
> reach 100 while the other keeps growing.  Only a zero length byte at
> the start of a block counts as an empty block; the same byte later in
> a block still just ends that block's records, as it does today, and
> is not counted.
> 
> Hui Peng's earlier patch for this function added its own, separate
> limit on the number of empty blocks [3]; this uses the combined limit
> Jan suggested instead.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> 
> [1] https://lore.kernel.org/all/20260925043804.2091174-1-matthias.goergens@gmail.com/
> [2] https://lore.kernel.org/all/cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n/
> [3] https://lore.kernel.org/all/20260919222553.3792320-1-benquike@gmail.com/
> ---
> Tested with fs/isofs built as a userspace program under ASan and UBSan,
> and in a KASAN VM on Jan's for_next:
> 
> - The real discs from [1] (DM_BXL2, Comdex_05, ITSOFTCD_39, each with
>   trailing empty directory blocks) and the level-3 images from the
>   earlier patches list and read the same with and without this patch.
> - A crafted multi-extent file with 150 empty blocks between two sections
>   now stops with "More than 100 file sections/empty blocks ?!?" instead
>   of reading all of them.
> - A crafted file with 60 sections and 50 empty blocks interleaved (110
>   in all) is rejected; without this patch it is accepted.
> 
> The image generators are at
> https://github.com/matthiasgoergens/linux/tree/reproducer/2026-09-26-isofs-empty-blocks

Thanks for the patch and the generator. Just one question below:

> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 184350d2e6ad..e884618c0c53 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -1175,6 +1175,7 @@ static int isofs_read_level3_size(struct inode *inode)
>  	struct buffer_head *bh = NULL;
>  	unsigned long block, offset, block_saved, offset_saved;
>  	int i = 0;
> +	int empty_blocks = 0;
>  	int more_entries = 0;
>  	struct iso_inode_info *ei = ISOFS_I(inode);
>  
> @@ -1202,9 +1203,14 @@ static int isofs_read_level3_size(struct inode *inode)
>  
>  		/*
>  		 * If we are at the end of a block (or at its zero-padded
> -		 * tail), move on to the next block.
> +		 * tail), move on to the next block.  A zero length byte at
> +		 * the start of a block means the whole block is empty;
> +		 * count that towards the same limit as sections below, or a
> +		 * chain of empty blocks could be walked without bound.
>  		 */
>  		if (offset >= bufsize || de->length[0] == 0) {
> +			if (offset == 0 && ++empty_blocks + i > 100)
> +				goto out_toomany;

Any reason why don't you do just "++i > 100" here and completely remove the
empty_blocks variable?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
