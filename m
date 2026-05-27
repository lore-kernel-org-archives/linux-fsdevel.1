Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2233D79FE
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877352; cv=none; b=gOAdXNR3AY2AxsZYf3Z5dhjdWBoZpR5tgXBxtZp58DryHZsaYXFQ64SSJd3Zju9dyvie27Pp9NfNCt7bWsYnG9JeiqyyInWKRg4rtP5XpfPuwtdVngAjh21zWton5yTdK6BfM2aGm4TSO+YnOeQRZM111ydqJBfwoA6iBUSgv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877352; c=relaxed/simple;
	bh=jjR4eM8CUHf89YdmTjkUstxFLZj/MuwXq0MtZeQlw1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0lDIsib7igR9oSQAKV2C87swBRBzcwR7zkzzx/nvvus97jDQ/erJ66zp2TwlrjMwRqjgkyVS/yuIecg8fTPq0dT/eOGL/eSUoO4MrC8m41w71ZyfKa4Xqxx2hFuP7dckG1rFpH4x2hbUegcsa4CLvqvhsNGKFT5VffMKkV6KR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OCQX7w58; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HZfR0S3r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lu1nKN1O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VHXoCsbs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OCQX7w58";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HZfR0S3r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lu1nKN1O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VHXoCsbs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14C456AD75;
	Wed, 27 May 2026 10:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jIoncQijZRA5MoVpDihBT0WbhBMqsHwAiDEq/n31UE=;
	b=OCQX7w58GO+zo74Im5CCXkpp4XCsJfIm2CJW5G/tsW2c3sKS5JFN1dYc//Dimc+KmMbcG8
	2hrnx/JTb6LY3ewHZoPE/g8bV2cQKAwzejJ0/MWEDXGNVjiEBlqNghBDT1Fd1nx9TiFhLQ
	ln+gtC6qvKsXoODNDi0Vpng0RueQlsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jIoncQijZRA5MoVpDihBT0WbhBMqsHwAiDEq/n31UE=;
	b=HZfR0S3r85pwtPlCA8DIXYkJZJJQRvOCBJmVbsbPp5r8lAlzxeO8gcq/GeehqIhTs3W1IG
	dBTapsh45BydxgBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Lu1nKN1O;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VHXoCsbs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jIoncQijZRA5MoVpDihBT0WbhBMqsHwAiDEq/n31UE=;
	b=Lu1nKN1Ohc13rEyvqqrO/efPDc7jQBmmdpyJ2abd224LIqgDy5hbo9GE1BdLlg4yw4qKuB
	EKXgyGXklzZwbnRaBJSZtN8AHv5Vtfl/lfC+NWqxh4Ro5S+Qaw0QqqwI7brpYYIRkw136l
	yIKCS0jiljdgpWHXYxHx5xHfr+BFBkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jIoncQijZRA5MoVpDihBT0WbhBMqsHwAiDEq/n31UE=;
	b=VHXoCsbsm/fLKAjuDPiWvqyhq0UBdpBwiG0irX/Jb2LkFPU0x/+vD2gYxEYN0pHHIGp9ye
	KJgo4zKyCBLiKCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B1155A7A1;
	Wed, 27 May 2026 10:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aqOsAuTFFmooZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 10:22:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A6C11A0EB5; Wed, 27 May 2026 12:22:27 +0200 (CEST)
Date: Wed, 27 May 2026 12:22:27 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/34] buffer: Add bh_end_read(), bh_end_write() and
 bh_end_async_write()
Message-ID: <sfdgf57x2oa3f5hn5izgdiomkgzwoiyqunborxtyfvtty2tlfo@oa6lvhzjrqic>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-5-willy@infradead.org>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 14C456AD75
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 25-05-26 18:18:57, Matthew Wilcox (Oracle) wrote:
> These are the bio versions of end_buffer_read_sync(),
> end_buffer_write_sync() and end_buffer_async_write().
> Also add the helper function bio_endio_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/buffer.c                 | 77 ++++++++++++++++++++++++++++++++++---
>  include/linux/buffer_head.h |  6 +++
>  2 files changed, 77 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 4dcce64ef006..84ba0d892267 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -129,6 +129,29 @@ static void buffer_io_error(struct buffer_head *bh, char *msg)
>  			bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
>  }
>  
> +/**
> + * bio_endio_bh - Return the bh for a bio
> + * @bio: The bio
> + *
> + * Call this in your bio_end_io handler to retrieve the buffer_head
> + * submitted in bh_submit().  If you did not call bh_submit(), do not
> + * call this function; it will return garbage.
> + *
> + * This function consumes the bio refcount which will probably free the
> + * bio.  You should retrieve the bi_status before calling this.
> + */
> +struct buffer_head *bio_endio_bh(struct bio *bio)
> +{
> +	struct buffer_head *bh = bio->bi_private;
> +
> +	if (unlikely(bio_flagged(bio, BIO_QUIET)))
> +		set_bit(BH_Quiet, &bh->b_state);
> +	bio_put(bio);
> +
> +	return bh;
> +}
> +EXPORT_SYMBOL(bio_endio_bh);

Frankly, this looks too fragile to me, in particular for an exported
function. I'd prefer this returned the status and have another argument
where to store bh to. 

> @@ -416,6 +469,21 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
>  	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
>  }
>  
> +/**
> + * bh_end_async_write - I/O end handler for async folio writes
> + * @bio: The bio being completed.
> + *
> + * Pass this function to bh_submit() if you're doing the equivalent of
> + * block_write_full_folio().
> + */
> +void bh_end_async_write(struct bio *bio)
> +{
> +	bool success = bio->bi_status == BLK_STS_OK;
> +	struct buffer_head *bh = bio_endio_bh(bio);
> +	end_buffer_async_write(bh, success);
> +}
> +EXPORT_SYMBOL(bh_end_async_write);
> +

Sooo, when going through this rabbit hole I wonder whether we shouldn't
rework how async writes work for fs/buffer.c. They are used only by
__block_write_full_page() (and one place in gfs2 which IMHO could be
massaged to use __block_write_full_page() as well) and the only difference
from "sync" writeout is that async writeout also takes care of the folio
writeback bit. What we could thus do is to chain all the bios that are
writing out buffers in the same folio and then complete all buffers in the
folio and clear folio writeback bit once the parent bio completes. This
would be a bit more elegant solution compared to the logic in
end_buffer_async_write() playing with b_uptodate_lock etc. 

But as I've spelled out the details now, I guess that's for a separate
series so I'm just leaving it here as an idea for future work :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
