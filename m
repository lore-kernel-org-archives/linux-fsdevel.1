Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F2D3E5588
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877511; cv=none; b=E3S2FhhoYc+g6ZBHIEQNp+h340jp/EY4lT4hNyhpjf9yYCNAfmtjrVECJ0TDd5nsAWZwzOoQgjNyq/hvBSLy+Dt5JdO3/P0e18NuFeiF8RCgCmE80jBgbg4ptAshdai837wdZ6sKNmJkbdBjBBDvqOye3C+MFcuQN50PReDnuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877511; c=relaxed/simple;
	bh=SHtuV1iZQe6q8XVc2nqPa4wu+usU7R+X1YuWtCDce4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8KbR3HBxsky8YpkAu5gzhhz7Gfsn8cXzhXh8GgTKe7dnjtFh/Vqm51uL11uI4CAbAFVS9gbyVnRh6Y6kxbWEcb9XtU3pL1d7M9/TNRNlTl2aacOVELRxYxZJHJRwUDNjiCgA5ClVdl+6j8Uuid+79V7V1H6sSOp9guYueD+a7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qB3yeLXv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqQGPb5Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qB3yeLXv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqQGPb5Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qB3yeLXv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqQGPb5Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qB3yeLXv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqQGPb5Z"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BE9E6AA6B;
	Wed, 27 May 2026 10:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSpKG+N/6Q7HThn2fTJ1IkGYGyJptgHdDddlCO4aV3g=;
	b=qB3yeLXvY8Mp2Gnx/k2eGbh4vq8ZfLavuBSNMk6Hzo4ux8pGSU1b4ZLDLJZnddmnTMk/6t
	8TwrGVlqgFLL6NKkHlPy+zkLY1sW2x9L4+LBs12Vv8mU5QuKi3O/aPAxq/1+CYIc9V05gT
	YiW6H4tAw8RYgqFZuPJtHUCgVfirQyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSpKG+N/6Q7HThn2fTJ1IkGYGyJptgHdDddlCO4aV3g=;
	b=lqQGPb5ZSUVyMhDLv1Fq/PLnmDtcOIjaqG9wae9TBN1a7APMuF7RY+hjo3NCLk9jSLkYCt
	bKIL9vafrhe1INDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSpKG+N/6Q7HThn2fTJ1IkGYGyJptgHdDddlCO4aV3g=;
	b=qB3yeLXvY8Mp2Gnx/k2eGbh4vq8ZfLavuBSNMk6Hzo4ux8pGSU1b4ZLDLJZnddmnTMk/6t
	8TwrGVlqgFLL6NKkHlPy+zkLY1sW2x9L4+LBs12Vv8mU5QuKi3O/aPAxq/1+CYIc9V05gT
	YiW6H4tAw8RYgqFZuPJtHUCgVfirQyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSpKG+N/6Q7HThn2fTJ1IkGYGyJptgHdDddlCO4aV3g=;
	b=lqQGPb5ZSUVyMhDLv1Fq/PLnmDtcOIjaqG9wae9TBN1a7APMuF7RY+hjo3NCLk9jSLkYCt
	bKIL9vafrhe1INDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32C135A7A6;
	Wed, 27 May 2026 10:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 62JiDITGFmoZaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 10:25:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DBD7AA0EB5; Wed, 27 May 2026 12:25:07 +0200 (CEST)
Date: Wed, 27 May 2026 12:25:07 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/34] buffer: Convert __bh_read to bh_submit()
Message-ID: <35okv55uj7el2fdsefwrjwwwhnfvjzb6jf72p4jnelpc6ucp42@koe6fe7jfzh7>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-9-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-9-willy@infradead.org>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]

On Mon 25-05-26 18:19:01, Matthew Wilcox (Oracle) wrote:
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
> index fbbb2febe383..48b4480e9915 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3083,8 +3083,7 @@ int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
>  	BUG_ON(!buffer_locked(bh));
>  
>  	get_bh(bh);
> -	bh->b_end_io = end_buffer_read_sync;
> -	submit_bh(REQ_OP_READ | op_flags, bh);
> +	bh_submit(bh, REQ_OP_READ | op_flags, bh_end_read);
>  	if (wait) {
>  		wait_on_buffer(bh);
>  		if (!buffer_uptodate(bh))
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
