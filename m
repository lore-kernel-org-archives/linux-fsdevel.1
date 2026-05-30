Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5833A2556
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142056; cv=none; b=sIF64C6BlGClx6thhCQnl1tPyhRzIlWD6saN9rYlM3jKEF2C/6MAeolVPlbKN8V1TwHypalFu0f7fQZrVpbCEC+LTS0thxfBs3MW+PfTUieXj70WF5XXxH63AmG29WPYV/WeTzFIp+xd/3Gd+Pq48URTrqsBnj+cStYm3MK6ExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142056; c=relaxed/simple;
	bh=JWb5zzO7QOQl5pErMi+qcQ7kuB5UV9/ThG9HfKqStzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USK5RlNEusG3rVgN6zPbeR0WQzLvrmdxBn/9vYnPvK+/T8vho1tZquDvXHecLO0K+q7Ge+U/CwktMSeoDlg1AnTRDP6Ky32hcps+/TuLR2EiYKEcwa8vrnZ6IanIEy8BecXJw65x0/66ThV5VN994GdSyGyxUaKC6JIweJ2BC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G5t4z8Dd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lb+ZVdN7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kUP/SOsH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iU4hkGLy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G5t4z8Dd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lb+ZVdN7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kUP/SOsH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iU4hkGLy"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D815A6B8C1;
	Sat, 30 May 2026 11:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNhhLJFZpZ4rk5jqFt9Nqq63Lz+FRrfWEN5B02swvOE=;
	b=G5t4z8DdlCamreOl3FF4KXv8k4CrIo50Xbf8aOfGLlhP5/tzvckDsDOExuE9+bva28dOqm
	1eClhsn+Yd/qcJcrVbebQBDf3ohPcljpNYzF1+E7cwc8CU0C0N4rOVBOWSFDMok1z0oDnB
	s65xLgH8l9AnHxWDU5xNYxRfnXqWgDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNhhLJFZpZ4rk5jqFt9Nqq63Lz+FRrfWEN5B02swvOE=;
	b=Lb+ZVdN7wTc5ssX5InMaIqh4/x/GqAqniyfcfHu7DNqOJl3FAXztS2GR2QMyPU3bY/32UW
	e4re6qJsa5wkgoBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="kUP/SOsH";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iU4hkGLy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNhhLJFZpZ4rk5jqFt9Nqq63Lz+FRrfWEN5B02swvOE=;
	b=kUP/SOsHkzQbl/geivg0Aj8th3ZBec8h/Fzfn5DlvS0AW3rONPktRDNGRxT0WMb2l4TPA5
	5xgdPIu8lHPFLo33U20n0jhXkKVZPZ8CdbPEV5zzLN+pdbp4RHMs4CiXDz0/c6Gn6/KmQk
	odH7pc/f56IzBpQfhrpQhS748dveY7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNhhLJFZpZ4rk5jqFt9Nqq63Lz+FRrfWEN5B02swvOE=;
	b=iU4hkGLyR1uyiPv9i8GxRBS6fjZ4eMD6l1Stb20VHj/5leVmrQUD1whXxFtqWt9cGIxMaA
	SIH7AYV8kYwceHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB1EA779A7;
	Sat, 30 May 2026 11:54:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gYsqMeXPGmrFRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:54:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D552A0EBD; Sat, 30 May 2026 13:54:09 +0200 (CEST)
Date: Sat, 30 May 2026 13:54:09 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH v2 25/34] gfs2: Convert gfs2_aspace_write_folio to
 bh_submit()
Message-ID: <mrzgq77pdajkjox5vueplng5xbzc7bn2pvm6fi7ksnpqmim3x5@g22qt2bafgf5>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-26-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-26-willy@infradead.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D815A6B8C1
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.dev:email,suse.com:email,suse.cz:email,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu 28-05-26 18:31:38, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call by using bh_submit() instead of
> submit_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: gfs2@lists.linux.dev

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/gfs2/meta_io.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index df5f05054f6e..4895bb010cfb 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -59,7 +59,7 @@ static void gfs2_aspace_write_folio(struct folio *folio,
>  			continue;
>  		}
>  		if (test_clear_buffer_dirty(bh)) {
> -			mark_buffer_async_write(bh);
> +			set_buffer_async_write(bh);
>  		} else {
>  			unlock_buffer(bh);
>  		}
> @@ -75,7 +75,8 @@ static void gfs2_aspace_write_folio(struct folio *folio,
>  	do {
>  		struct buffer_head *next = bh->b_this_page;
>  		if (buffer_async_write(bh)) {
> -			submit_bh(REQ_OP_WRITE | write_flags, bh);
> +			bh_submit(bh, REQ_OP_WRITE | write_flags,
> +					bh_end_async_write);
>  			nr_underway++;
>  		}
>  		bh = next;
> @@ -221,7 +222,7 @@ static void gfs2_meta_read_endio(struct bio *bio)
>  
>  /*
>   * Submit several consecutive buffer head I/O requests as a single bio I/O
> - * request.  (See submit_bh_wbc.)
> + * request.  (See bh_submit.)
>   */
>  static void gfs2_submit_bhs(blk_opf_t opf, struct buffer_head *bhs[], int num)
>  {
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
