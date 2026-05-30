Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB473AB293
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141705; cv=none; b=WMtkRr2Va2BEY5+zkIgRdyk18EWDUK3ElVRPplqalHTy1Pq/DXBEIl8+aK75O0X7cHFQn+4EpI7zEoCMxTYbsuXA42ZIm0YfkG1GIgNQMIJrz2/kGijzqHKXZ9Te1zcU8sWOrJKWL+gi+jKTYb63w+4AXmaFNDN97kvLJYoEgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141705; c=relaxed/simple;
	bh=FjxBNl2xkptGqrMJszfLJiZjFxcBPEr8gub2rJsmQow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhuK7lE52HelQA4ewgmYLOaVQZ9uMszvXpedu+U6q8ydSqAai/kePgjiTtHnRR5q+BqFiulEZnvYHElsxAyTGOReqqM4b8QJiJ8oIO2GD4aIOrhLE6EDbTx3yMb5aHGl1L0uMdmCwPWnlObiTNmQmdGwTjziLJvIGUDQxKKkodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=izaOIBTP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/lo38H2z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=izaOIBTP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/lo38H2z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="izaOIBTP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/lo38H2z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="izaOIBTP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/lo38H2z"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E1146B882;
	Sat, 30 May 2026 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/v3yYmt7UmxyVhW2DlTy4iw3l/qGlYFUIClMSiQ2o5Y=;
	b=izaOIBTPeVIZr3kZKUz/ki/AX9C0hYT1l0qgyuPN3JFZvjdljOtQ2vwB6olYWceDK3RkYM
	OaZIYPQQ9Ss9h364VU46ZyFPkDgBLO7/qCZ7idXuYClFRtQQZ0WgdP4qSJieomVn7Z7SlH
	sRCr+CyPRCwaG/W7Iozbyfo+SIMsvew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/v3yYmt7UmxyVhW2DlTy4iw3l/qGlYFUIClMSiQ2o5Y=;
	b=/lo38H2zZdmPaNkUFR4ibzbvROPIfMDw/N659jdV7AUnTk5GhxZ5a/AuITaLqzQMtvoWh7
	6k7LzWMFBXEIKBCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/v3yYmt7UmxyVhW2DlTy4iw3l/qGlYFUIClMSiQ2o5Y=;
	b=izaOIBTPeVIZr3kZKUz/ki/AX9C0hYT1l0qgyuPN3JFZvjdljOtQ2vwB6olYWceDK3RkYM
	OaZIYPQQ9Ss9h364VU46ZyFPkDgBLO7/qCZ7idXuYClFRtQQZ0WgdP4qSJieomVn7Z7SlH
	sRCr+CyPRCwaG/W7Iozbyfo+SIMsvew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/v3yYmt7UmxyVhW2DlTy4iw3l/qGlYFUIClMSiQ2o5Y=;
	b=/lo38H2zZdmPaNkUFR4ibzbvROPIfMDw/N659jdV7AUnTk5GhxZ5a/AuITaLqzQMtvoWh7
	6k7LzWMFBXEIKBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06152779A7;
	Sat, 30 May 2026 11:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pQB7AYbOGmpDQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:48:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B5F75A0EBD; Sat, 30 May 2026 13:48:21 +0200 (CEST)
Date: Sat, 30 May 2026 13:48:21 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v2 18/34] ocfs2: Convert ocfs2_write_block to bh_submit()
Message-ID: <kcvfunuvb3wktycww7q6overcbox5rsikb33up2t6qwsycrmw2@zvnvimdl6rgh>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-19-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-19-willy@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,alibaba.com:email,linux.dev:email,suse.cz:email]

On Thu 28-05-26 18:31:31, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call and changing the buffer
> refcount by using bh_submit() instead of submit_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@lists.linux.dev

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/buffer_head_io.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index 701d27d908d4..714daa4bbda2 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -62,9 +62,7 @@ int ocfs2_write_block(struct ocfs2_super *osb, struct buffer_head *bh,
>  	/* remove from dirty list before I/O. */
>  	clear_buffer_dirty(bh);
>  
> -	get_bh(bh); /* for end_buffer_write_sync() */
> -	bh->b_end_io = end_buffer_write_sync;
> -	submit_bh(REQ_OP_WRITE, bh);
> +	bh_submit(bh, REQ_OP_WRITE, bh_end_write);
>  
>  	wait_on_buffer(bh);
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
