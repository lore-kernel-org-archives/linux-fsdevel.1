Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48E3F0A86
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877476; cv=none; b=Zq1cVEs6rfSrfkKoorxgj49bMLcVczsZ9n4dCQU0dj9NtYMANA4cZvks6jCO1oKnwBsibTKxHxiekDmF8dXYG3kNbqW2lozE3xUgTYKh0Xkn/ZbVfKsUEbgqjbzY087ZbvJ2Hfd8fdIi7meBcd9RfCLoUFNglOQLtVZYs07vaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877476; c=relaxed/simple;
	bh=lhKAoudUQyQWQZViYzy2sw85YVnScnVDvQ2iDyvPSFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olcR8p+wyrZ5HZa3Hj6jt1kpu0YJScscqtVurqMkFfeNJi5zA5/GfTy0+ngcG7qhoPyoXhrXd6GY7n0x3FEBH2IHvQQyJT183GKBHE3D5I1eQ0tChagv1MPmOGDJHVcKrjoVYAmN9iwI/wU1R4shGF0Zr5aWY6Foi/GuKl/Fk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eoUKSi0J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hi4fbtZt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eoUKSi0J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hi4fbtZt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eoUKSi0J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hi4fbtZt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eoUKSi0J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hi4fbtZt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1B0266E24;
	Wed, 27 May 2026 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8MP9v73bSWDYboJX/RazDgmQe9tmbSqmTR3resfbjE=;
	b=eoUKSi0J9BbiIcmcRn0xoVxlMv8gsCcT7B3lLLDwv5UCiZ5UFJkQndaag+c+azIjmVt+eg
	FVE94udbucqyehAfV228zGy+s0B84Z2gfDLZL3IDOrgkB7UeaMnCaYVdV9vwJMRM7jnbKW
	PeZ9Y/bJpRs4SDhkqlzqQTKKBg1M6KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8MP9v73bSWDYboJX/RazDgmQe9tmbSqmTR3resfbjE=;
	b=Hi4fbtZtmvK8WQ1etZ6Tu55YY8hILEzvPVtwlcWOcrxp0zbqEd79tCB1CnID5GmM6dZgXJ
	YfHTOOTE7XIxH7Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779877472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8MP9v73bSWDYboJX/RazDgmQe9tmbSqmTR3resfbjE=;
	b=eoUKSi0J9BbiIcmcRn0xoVxlMv8gsCcT7B3lLLDwv5UCiZ5UFJkQndaag+c+azIjmVt+eg
	FVE94udbucqyehAfV228zGy+s0B84Z2gfDLZL3IDOrgkB7UeaMnCaYVdV9vwJMRM7jnbKW
	PeZ9Y/bJpRs4SDhkqlzqQTKKBg1M6KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779877472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8MP9v73bSWDYboJX/RazDgmQe9tmbSqmTR3resfbjE=;
	b=Hi4fbtZtmvK8WQ1etZ6Tu55YY8hILEzvPVtwlcWOcrxp0zbqEd79tCB1CnID5GmM6dZgXJ
	YfHTOOTE7XIxH7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA3115A7A3;
	Wed, 27 May 2026 10:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1wGNKWDGFmoXaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 10:24:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6C21BA0EB5; Wed, 27 May 2026 12:24:28 +0200 (CEST)
Date: Wed, 27 May 2026 12:24:28 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/34] buffer: Convert __bread_slow to bh_submit()
Message-ID: <ezjgispcmqjjlsl6l7gvqqg5hzglgff5mdaf7n6rw5klera7wf@ypnbkgcmwoq5>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-7-willy@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]

On Mon 25-05-26 18:18:59, Matthew Wilcox (Oracle) wrote:
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
> index 3bad3f4edd54..1699be521672 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1317,8 +1317,7 @@ static struct buffer_head *__bread_slow(struct buffer_head *bh)
>  		return bh;
>  	} else {
>  		get_bh(bh);
> -		bh->b_end_io = end_buffer_read_sync;
> -		submit_bh(REQ_OP_READ, bh);
> +		bh_submit(bh, REQ_OP_READ, bh_end_read);
>  		wait_on_buffer(bh);
>  		if (buffer_uptodate(bh))
>  			return bh;
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
