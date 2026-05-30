Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90C3AB293
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141693; cv=none; b=IhAMx9+G2gu2kpx4hxYPWXc6oH9lRx6y7ZJIcpA7VcKguMY62TnlOK4AriSz8P42pXxZ5yN046KgVwIla3zojZy9osyAy86q4SRqKDJNbyexsGVXPWCt/JKUPIHcgHuByvY/jLh1Ho99SYttB1G2CtrZ4jsDXpGfaT2NkI7xWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141693; c=relaxed/simple;
	bh=S/WfLeBInpu9q5dbCsrSGK52OfvE62OeDWdd//MU+Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdsxQ8APZYQszwrrNeQ/VKJLcqwhRY44eW9DI4a0HRikla4pD83XTIx8SJZ9mp9sSlnfHvGAI0ezsG/d0msACNXjJM60BjXfsCWv5pfEJp3CnZPbKf/tJF1TdX1iXype4E0gbBXofe1kt4H/+MlurAFtJV1eXVYOJPr+MHKwam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FbM7kavX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G8AHhKBe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FbM7kavX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G8AHhKBe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FbM7kavX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G8AHhKBe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FbM7kavX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G8AHhKBe"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0ECEE67B55;
	Sat, 30 May 2026 11:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQaSFWhxpn4bODMn+mzfB/J+eFiSohG+KgVqU9/Gzrs=;
	b=FbM7kavXbolXflmgYGtM72VhzjGCf1WwxRJtKH5Med/WLZd3qvvIIGCjPF0zGMR1elAW9a
	pJeK34hV4xX5moDm7RrAW1xwZ9VACq0Mco9Xed9GQXTE9NcfvPopY0ph0PbQy2eMQwUI9c
	ebrOWIAatG/rMZJGhBnmlWoRUV0Timg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQaSFWhxpn4bODMn+mzfB/J+eFiSohG+KgVqU9/Gzrs=;
	b=G8AHhKBekmiQictfzLQPUvBLp+Ik9qt3Pggt4I0F3DH4QooR/ROfbhv2eQ8uBex7FoLXaw
	SC4/WGr/Z722u6CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQaSFWhxpn4bODMn+mzfB/J+eFiSohG+KgVqU9/Gzrs=;
	b=FbM7kavXbolXflmgYGtM72VhzjGCf1WwxRJtKH5Med/WLZd3qvvIIGCjPF0zGMR1elAW9a
	pJeK34hV4xX5moDm7RrAW1xwZ9VACq0Mco9Xed9GQXTE9NcfvPopY0ph0PbQy2eMQwUI9c
	ebrOWIAatG/rMZJGhBnmlWoRUV0Timg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wQaSFWhxpn4bODMn+mzfB/J+eFiSohG+KgVqU9/Gzrs=;
	b=G8AHhKBekmiQictfzLQPUvBLp+Ik9qt3Pggt4I0F3DH4QooR/ROfbhv2eQ8uBex7FoLXaw
	SC4/WGr/Z722u6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05B9C779A7;
	Sat, 30 May 2026 11:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NilhAXvOGmo7QgAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:48:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B9CE1A0EBD; Sat, 30 May 2026 13:48:02 +0200 (CEST)
Date: Sat, 30 May 2026 13:48:02 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v2 20/34] ocfs2: Convert ocfs2_read_blocks to bh_submit()
Message-ID: <asgua5rnwo3a2v2on7tecjjxss2vw5mxgnnccpcgkhowzvoaat@en3h2pufk3nw>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-21-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-21-willy@infradead.org>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,infradead.org:email,alibaba.com:email]

On Thu 28-05-26 18:31:33, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call and changing the buffer refcount
> by using bh_submit() instead of submit_bh().
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
> index 9edaeef5c4b9..185ff4dcba75 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -319,11 +319,9 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>  				continue;
>  			}
>  
> -			get_bh(bh); /* for end_buffer_read_sync() */
>  			if (validate)
>  				set_buffer_needs_validate(bh);
> -			bh->b_end_io = end_buffer_read_sync;
> -			submit_bh(REQ_OP_READ, bh);
> +			bh_submit(bh, REQ_OP_READ, bh_end_read);
>  			continue;
>  		}
>  	}
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
