Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8403D7D9A
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877415; cv=none; b=ogXDZuMRsZzeNl8xVPhQPla9XRW2lBr2JPVrdfeMtGyI8iso1RLHscG2Vw3c6kB5cTmLlWhNA2F0dbh+jdaTP8y5fwZ2mIe9j6A70UoOCoRT/IT4pkKDbTkpVp+SzcPSVSBFt4EVYpIJTFJTxvHeNqQsHJdk+cTOYfSCzHnsrFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877415; c=relaxed/simple;
	bh=pmlX5PtuzblK07BrWZw4nax5+Qh8epoWYahHUEcLfmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4uw/bSt4BLsHNnLLw1RGwOcWRxg+i8aveiWHbkVqH+U2XLkY/EqMTea7cdeoGEZRqBVfTPDVs/TYdGPp43zUa1pHBm64CGXTxcfFc5gMzxOCqOwjP16dWbt0P8cC+not8axwHopHMIyqfh8xDmbpg0l4BpV8Evywa+R6B8Ftjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wILjN8+Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lLk5m6kL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iYHmje9h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Im4h9rsq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wILjN8+Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lLk5m6kL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iYHmje9h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Im4h9rsq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96A806A964;
	Wed, 27 May 2026 10:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY6IN0QyMsHTJkuZlYGPT/baCdGuB99N7cI1mjsbPlc=;
	b=wILjN8+ZArmyqKXTPU4pmnT1vzVLXz69kufoLZwBCUQNRXd2J4/0ABc1INyOLw3hy4kp7E
	N4SVfxS+6yKnszeCrKd0OiK8+ieJbT3yVPOqxPyVagIJjND6GOqY1CdZF+MDiTybkQIyUB
	oKf/lgz/izR7j0z6KzDnkpjqiA6kICY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY6IN0QyMsHTJkuZlYGPT/baCdGuB99N7cI1mjsbPlc=;
	b=lLk5m6kLhVRkbGE0XlLjWYkBTzlLNe2nO38ksNur5O+zz7TIOJWmvE6BaZbgkOW9VZKFWh
	aWavLfyGx/91mWDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iYHmje9h;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Im4h9rsq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY6IN0QyMsHTJkuZlYGPT/baCdGuB99N7cI1mjsbPlc=;
	b=iYHmje9hmDSoMdssXQ85R6DxVBs4XVitugLpuCzAsBjjHXiX0WDLmunS5WCYBOj53rEw0a
	BvBsilBY5AgErG4t9d52ScidNZpjopnif25XtOTKDjU719F6gybrR6OjthgfmeTbOsFCpH
	uUdb52Eth9XiB5tQnQ6kusegNCzsx2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY6IN0QyMsHTJkuZlYGPT/baCdGuB99N7cI1mjsbPlc=;
	b=Im4h9rsqe3ZFqfsInQoSIMIkgrQmGMnIcHurGaaLuA02ilUBlhNzP6/ke4A3hyvEPgdpIq
	btJYnUT3sIEoAwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E0985A7A2;
	Wed, 27 May 2026 10:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UrWpIiPGFmoTZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 10:23:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 44D2DA0EB5; Wed, 27 May 2026 12:23:31 +0200 (CEST)
Date: Wed, 27 May 2026 12:23:31 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/34] buffer: Convert write_dirty_buffer to bh_submit()
Message-ID: <airkoeep3zb5rnqdca4ncl66lphsc5ezzzbxuuhwe66k6z3l3c@dt5sf56dnkor>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-6-willy@infradead.org>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 96A806A964
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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

On Mon 25-05-26 18:18:58, Matthew Wilcox (Oracle) wrote:
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
> index 84ba0d892267..3bad3f4edd54 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2826,9 +2826,8 @@ void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
>  		unlock_buffer(bh);
>  		return;
>  	}
> -	bh->b_end_io = end_buffer_write_sync;
>  	get_bh(bh);
> -	submit_bh(REQ_OP_WRITE | op_flags, bh);
> +	bh_submit(bh, REQ_OP_WRITE | op_flags, bh_end_write);
>  }
>  EXPORT_SYMBOL(write_dirty_buffer);
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
