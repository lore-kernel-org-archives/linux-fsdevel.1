Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC593403E3;
	Tue, 22 Sep 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079523; cv=none; b=H5tkgSfG1dT4X8OEovSlX/ObBNlk2i+XJpmXg5LNkttOshmu0fGUshXsWiZXuvPQRpqc983djVa6hP0zFkU1cG/uZK+thfkp2I9Hv/48fWM4bxis2IrcnL4lsSa+sBhLWEpxrdJF2UWNeAgtXE51dNr4fC3yGjEhZnpXn4JMWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079523; c=relaxed/simple;
	bh=h9apuZrWj2lrN/w3EvAP7FFMqf2ytwdn02qHiPbOQnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQdhWBVvi5LkSwIZOB42ShlUMr/OVr9vhdnbS3aukO1HPrG7EJuHcElfWIM01E6uL4Z2RQpb6OYs4ri1NFH08yjbrv86z67I7Abx1Ao1ksTFvrbDSx3ozAiRnrdk224bkXLS8fVQ+BqOz3mViMyVjJngcb2AedrxKjwrmqhN2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=exTlfNlr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NurHdi+v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KdavMFAt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1j6dr31L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="exTlfNlr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NurHdi+v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KdavMFAt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1j6dr31L"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB0321FF20;
	Tue, 22 Sep 2026 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790079515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2Tk4+Pw6RpU7AefGmYvZqxsKo5DjRGYdxiV/DVpLAg=;
	b=exTlfNlrsZx6rUVP90135aynRjgiYrPV5sU+LVmAb3I+gah0VZ3ynJeqtHJCGFLhV3tLHq
	FDsjNsE2d4xX3jUbhXUelVWFMCF6VHvi+51FDa2ux13+BuQUdjIDs9sLMgzGJMJkHoLOX8
	1QPAm/TFusZYzML0WWHh5zk3TvorkfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790079515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2Tk4+Pw6RpU7AefGmYvZqxsKo5DjRGYdxiV/DVpLAg=;
	b=NurHdi+v8YTmU5j2yIDWLME3exqqbUao/HOaEFSEYHEMc0X7XoQMGgvY12+Ajk+Bw/Wzc3
	gFbupaEjoKDxi8DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KdavMFAt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1j6dr31L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790079510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2Tk4+Pw6RpU7AefGmYvZqxsKo5DjRGYdxiV/DVpLAg=;
	b=KdavMFAtqn5buFmG7X1bT4XQN6NbH73HBSH0ebH94TPP7FaC8SbCrbdVFSSuSk9tG5pn2F
	RwljaS1a1iILWXsVs+G9dzWlr0yANy+MdtncKAqs/X/B4d8QDGWEEKjorcRlKid+s8D8Wq
	z5uOB8zxWAfLgIJhxBhz7TZQ9HsnSSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790079510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2Tk4+Pw6RpU7AefGmYvZqxsKo5DjRGYdxiV/DVpLAg=;
	b=1j6dr31LX8lAu9k3pWVtr7O/+IGu/gaJi5+l9IPu1DchDERB2WSIyZDeEsRygnWujYd5oU
	sZI834C3d8J6yYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92483136D9;
	Tue, 22 Sep 2026 12:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 08YfFxZysmptJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Sep 2026 12:18:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 01A2CA13D4; Tue, 22 Sep 2026 14:18:21 +0200 (CEST)
Date: Tue, 22 Sep 2026 14:18:21 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Yichong Chen <chenyichong@uniontech.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: advance to the next block when a record ends at
 the block end
Message-ID: <h532mtcbip4jyfr4cgqqs5jydwzhrvzuniex5zdrqz3nppweho@t5ivq66e5n2l>
References: <20260922054853.469681-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922054853.469681-1-matthias.goergens@gmail.com>
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: CB0321FF20
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[archive.org:url,suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO

On Tue 22-09-26 13:48:53, Matthias Goergens wrote:
> Since commit b2eb2e288604 ("isofs: Drop support of directory entries
> straddling blocks") some ISO 9660 images list incomplete directories:
> find returns fewer entries than before, and some of the names readdir
> does return cannot be looked up.  The log fills with
> 
>   iso9660: Corrupted directory entry in block 0 of inode 55232
> 
> and on some images the walk reads a byte past the end of a buffer:
> 
>   BUG: KASAN: use-after-free in isofs_readdir+0x93b/0xc40
> 
> Affected are images with a directory record ending exactly at the end of
> a logical block, which ECMA-119 allows and current tools produce.  On
> the Debian 13.7.0 amd64 DVD-1, which has three, find returns 9163
> entries instead of 9461:
> 
>   https://cdimage.debian.org/debian-cd/13.7.0/amd64/iso-dvd/debian-13.7.0-amd64-DVD-1.iso
> 
> The KASAN report is from a shareware CD with one in its root directory:
> 
>   https://archive.org/download/simtel-1-0295/SIMTEL1_0295.ISO
> 
> A local one, which lists 46 of its 65 files:
> 
>   mkdir tree
>   for i in $(seq -f '%04g' 1 65); do echo hi > tree/FILE$i.TXT; done
>   xorrisofs -iso-level 1 -o boundary.iso tree/
> 
> genisoimage pads the tail of a block instead of filling it exactly, so
> its images have no such records.
> 
> That commit removed the reassembly of records crossing a block boundary.
> Its condition was "offset >= bufsize", so it also handled a record
> ending exactly at the end (offset == bufsize): drop the buffer,
> increment the block, reset the offset.  Nothing does that now, so
> do_isofs_readdir() and isofs_find_entry() read the next record's length
> byte from bh->b_data + bufsize, one past the buffer.  Depending on that
> byte the walk either treats the rest of the block as padding and skips
> the next block of entries, or fails the record as corrupt and stops.
> 
> Straddling records stay rejected: isofs_dir_record_valid() fails them
> because their length exceeds the remaining space, which is what that
> commit relied on.  One ending exactly at the end fits in its block and
> is accepted, so it is the advance, not the reassembly, that has to come
> back.
> 
> Do it at the top of the loop: do_isofs_readdir() reaches the next
> iteration from the multi-extent branch, "." and "..", the
> hidden/associated skip (showassoc is off by default, so no mount option
> is needed) and the fall-through, and all of them need covering.  The
> record was validated to end within the block, so offset never exceeds
> bufsize.
> 
> Fixes: b2eb2e288604 ("isofs: Drop support of directory entries straddling blocks")
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Thanks for the analysis and the fix! In fact I got notified about the
problem last week and fixed it (sligthly differently) [1]. I've now added
you as a reporter at least to give you some credit.

BTW, it is a good observation that there's yet another instance of
directory reading code in isofs_read_level3_size(). That deserves a similar
simplification as what commit b2eb2e288604 did (just without introducing
the bug this time :)).

								Honza

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git/commit/?id=bda8d8d49ca14e7f3bdc39fdc4330a48b32d6b6f


> ---
> Not tagged for stable: b2eb2e288604 is in 7.3-rc1..rc3 and has not
> appeared in a released kernel.
> 
> Validated under qemu with KASAN and UBSAN against the images above,
> using a kernel built from the commit before b2eb2e288604 as the
> reference for correct behaviour.
> 
> do_isofs_readdir(), isofs_find_entry() and isofs_read_level3_size() all
> open-code this same block-end transition.  Happy to follow up with a
> helper that shares it, kept out of here to keep the regression fix
> minimal.
> 
>  fs/isofs/dir.c   | 12 ++++++++++++
>  fs/isofs/namei.c | 12 ++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index c7ca7603e97a..00a609c901dd 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -104,6 +104,18 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
>  	while (ctx->pos < inode->i_size) {
>  		int de_len;
>  
> +		/*
> +		 * The previous record was validated to end within its
> +		 * block; if it ended exactly at the end, the next record
> +		 * starts at the beginning of the next block.
> +		 */
> +		if (offset == bufsize) {
> +			brelse(bh);
> +			bh = NULL;
> +			block++;
> +			offset = 0;
> +		}
> +
>  		if (!bh) {
>  			bh = isofs_bread(inode, block);
>  			if (!bh)
> diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
> index 010682f5901a..5f5ed36d12e3 100644
> --- a/fs/isofs/namei.c
> +++ b/fs/isofs/namei.c
> @@ -68,6 +68,18 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
>  		int de_len, match, i, dlen;
>  		char *dpnt;
>  
> +		/*
> +		 * The previous record was validated to end within its
> +		 * block; if it ended exactly at the end, the next record
> +		 * starts at the beginning of the next block.
> +		 */
> +		if (offset == bufsize) {
> +			brelse(bh);
> +			bh = NULL;
> +			block++;
> +			offset = 0;
> +		}
> +
>  		if (!bh) {
>  			bh = isofs_bread(dir, block);
>  			if (!bh)
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
