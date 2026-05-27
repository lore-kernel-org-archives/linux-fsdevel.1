Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676A3E4C95
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877492; cv=none; b=kdIjl+u+pHefryDjxeBYZy2vVohKsIpBnJD9B8kq71o0yDLiQ4JSkGOHhTkdMyX009Gd1xxzjYGAsGAHQhQySNtQEul2az4WXGMudFHtEqv3nD+/6k11hc+DTAs20k+8UDTUBC/Cr2/vFvXARFFGHXVQ+UDX9G1IZEVCtSl3wlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877492; c=relaxed/simple;
	bh=p1syOzycesV1ynUipW9ie04zILJGm41MsjfHPWavQZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXIiccBtLzwnGv6kADGqOkesN28e0KzpMvRPjE9MGb12JpR6kFcCC4F7NfTv67s7GyVcaCPaPAHrFbMxoTXEyGfmVkMUaNGN+gVrpt2JvgImyp/SS0SsRddqRzQyENgCgKzR2Fm9QBHFKPaozIyP5MuBb/b3AUOptRJ5whHAsd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NK+x/6BB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M/pRUw57; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K35vMPPZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d+WZekNG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NK+x/6BB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M/pRUw57";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K35vMPPZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d+WZekNG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4BB666E27;
	Wed, 27 May 2026 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6rwjxycTDhxwPBvQmuX7KCereCjaMBwF2m26t7PpdJs=;
	b=NK+x/6BBWYK0WN+UArb7E4N4YYT/sWsisVCmvLe4MkQN6ExlTYPJOAhqjhu8pqCxIsB7lI
	5K1+0zO/RmClsv6Qe7+DV5qp1UFqOYgW5INyRrkzrJoBZnWtfxS9SDq1MSh+V2LLO3SyJe
	lcNRc0e7E9CukPJ55H1LptGZTSKmWSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6rwjxycTDhxwPBvQmuX7KCereCjaMBwF2m26t7PpdJs=;
	b=M/pRUw57rJNOwOPPwVcK6kwB118eitYdjsT1S1ifAzz6MNRN8lApUUa8q06bYwejd6+2F1
	n2gkSELNtY/MXLDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K35vMPPZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d+WZekNG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6rwjxycTDhxwPBvQmuX7KCereCjaMBwF2m26t7PpdJs=;
	b=K35vMPPZdwHgtNogEa7hfdKxVcxCA+TIB9aSUSTq8RTu5anPsnKtwVqvsaghV5ySounmBR
	oh99DPB1V5qVXTVAkrKFYqZr+XRi1w7rv9uu4vXuSWkZA8iynVsHhwDZPCMZOxRlf6t9vV
	Xv7MF9SnX0UtcPb7NalAoq7V6i8HOpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6rwjxycTDhxwPBvQmuX7KCereCjaMBwF2m26t7PpdJs=;
	b=d+WZekNGMVsaIzbRIDjl3VY5iYCkjpe3wdF1jwYHotYGEH7eZmPbARM1Id5TYl94elPbGH
	4lv+0tInXBVUS4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA775A7A4;
	Wed, 27 May 2026 10:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T3T9JXDGFmoGaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 10:24:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 56D7DA0EB5; Wed, 27 May 2026 12:24:48 +0200 (CEST)
Date: Wed, 27 May 2026 12:24:48 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/34] buffer: Convert __sync_dirty_buffer to bh_submit()
Message-ID: <kla6tj4xz6bnayut4aexdsamtab64ib5jgmad3uw4idkzejvql@cstdhlubwxzc>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-8-willy@infradead.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A4BB666E27
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Mon 25-05-26 18:19:00, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call by using bh_submit() instead of
> submit_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 1699be521672..fbbb2febe383 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2850,8 +2850,7 @@ int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
>  		}
>  
>  		get_bh(bh);
> -		bh->b_end_io = end_buffer_write_sync;
> -		submit_bh(REQ_OP_WRITE | op_flags, bh);
> +		bh_submit(bh, REQ_OP_WRITE | op_flags, bh_end_write);
>  		wait_on_buffer(bh);
>  		if (!buffer_uptodate(bh))
>  			return -EIO;
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
