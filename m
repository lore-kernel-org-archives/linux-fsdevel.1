Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13C3BB109
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166035; cv=none; b=nW3yHHtP4okLFzaODuFhnam+el6lhzUFwSzJSljBLcu8okOWFPzDKyxJJ9lrZTu9BkaKR1xJ+aIWri4nqo5mrKVU1rHXC0+8TKVtlAsnRnPLVsBw4mYV4p/YpI+GvYIHNiKzPmK3UZKdeZmBnMfDxzpvmmlSkksa4lcJTksTJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166035; c=relaxed/simple;
	bh=+vsodl7jqbt8XPX71KOtb7WQopUl1dESdfLcEEXU/AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6h98IcbswmowKJE4J9/uEQkHWIm6MZdYm28rTb6c0hKUAQoX1BFt+l1q16ZlgiitpdxtRDZkpi746X+cAOPk/JvCDrNKrgLOBuoAImNMwsXQhEspuJGdgpTba1WlK+cPTVnEB8C7ZHOY2sJBZhSrkdtOqnUy24pNCYAQOWE5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TAvtYGrb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7bIn+P3b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m71U3MpG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cVnKSTFe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TAvtYGrb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7bIn+P3b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m71U3MpG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cVnKSTFe"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 592311F7EB;
	Mon, 31 Aug 2026 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788166027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ4g5f2UCyiP5+Sq9D+uc5meWtEC0MnpX90k3AI4m0E=;
	b=TAvtYGrbxMH5gN6tGziArah6Qi2T5VN1hBR+G2cpIbF+s+jPx0Vl5+mUV0ePYiCTrPmxQt
	XQGi60nFdAt6RQKiloHv+AZohnFcQ5Yi3Q5LaqJqUTaYttW4LoheH160A++bF5nlY91j8E
	2cwM+jX00fBiNVDtEDE4Zj5OxZL66oI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788166027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ4g5f2UCyiP5+Sq9D+uc5meWtEC0MnpX90k3AI4m0E=;
	b=7bIn+P3bZzZLlzgpeXCvIL7tRTA7kDkgxDwRs8WgLV0QqguSUvzBmHjVXLZq8mlgG+RM9E
	DXtmg6g3CuWhcDBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788166023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ4g5f2UCyiP5+Sq9D+uc5meWtEC0MnpX90k3AI4m0E=;
	b=m71U3MpGptEvXC3QBtDniPWXyWE3M/E+i7ymQVN0NkKIlXBoKAQWABkpupGJeMfRf+Yy5f
	RCiQfTwtLWoY1bXwziXsGm04i/tt9Eoto4puNXbglp26eQica9eOGCOubK5CTZqKt7g67I
	HrCGMgKf35e8ViQIWoc4x60CG7I9adA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788166023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ4g5f2UCyiP5+Sq9D+uc5meWtEC0MnpX90k3AI4m0E=;
	b=cVnKSTFe3FVwkl3c1KmHbu3i/SVkfN9MT/m6dp+Mrgiw/gt1Dqmb4WVXsCsMqmYJq0O+XL
	5IVo9pi+tCjaQFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B163136B2;
	Mon, 31 Aug 2026 08:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4AZsDoc/lWpYKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Aug 2026 08:47:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DF0ADA13B5; Mon, 31 Aug 2026 10:46:58 +0200 (CEST)
Date: Mon, 31 Aug 2026 10:46:58 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] buffer: Document mmb_mark_buffer_dirty()
Message-ID: <gfrycblpc3vwovubp4lsqbpodqvdf5ablqmgenh4uf2j6oxz3r@omhiynx7u5oe>
References: <20260828205429.3678204-1-willy@infradead.org>
 <20260828205429.3678204-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828205429.3678204-5-willy@infradead.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Fri 28-08-26 21:54:24, Matthew Wilcox (Oracle) wrote:
> Add kernel-doc for mmb_mark_buffer_dirty().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index daf851ea9824..96bccff5688c 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -618,6 +618,14 @@ void write_boundary_block(struct block_device *bdev,
>  	}
>  }
>  
> +/**
> + * mmb_mark_buffer_dirty - Mark a metadata buffer dirty.
> + * @bh: The buffer to mark dirty.
> + * @mmb: The list of buffers to add the buffer to.
> + *
> + * Mark the buffer dirty and add it to the list if it is not already on
> + * a list.
> + */
>  void mmb_mark_buffer_dirty(struct buffer_head *bh,
>  			   struct mapping_metadata_bhs *mmb)
>  {
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
