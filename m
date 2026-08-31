Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C977F3B47C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165189; cv=none; b=W9EoHNXPYQO6zqeht61snARjAmTeJh+m/vMzam9+y1IiopG3enr3jTpUshMbZGDXJgf++6u04Lb71PbSn08uA0TPHahcmWl0lurxqDas8Ef5GIkthdMxtydYILjOu5cGDjE3nt/28WtHlSOezWwxLPIsLm37Evd9iAGYupJrbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165189; c=relaxed/simple;
	bh=lF7Vluuz3ZO5bN4Yq0QTY1OsPp30QCf+76sdoT6kpb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoq0Get56MQavj+0jDK1AhfR4zhF7rKIVtGxBvUnOKX7EcSLu6wVAOQDbcpg7pYN5UOFugJq7JJIsZ05OC0UkJVO7rCcx+T/zN9JLWozO0H5I7KVcnb7Pt+0VhbXiUSIBZ6fSmiFYNYwUd2xW+sVrbhkEk0gNx7CVn76XiU9gSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s5YlVeNp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oNRhGaM3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZgsWieoM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d4+BIhmi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s5YlVeNp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oNRhGaM3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZgsWieoM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d4+BIhmi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63DC421BBE;
	Mon, 31 Aug 2026 08:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788165181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLiVn9JnuWVZzxLodi5R8dfPt3sFwfArbvouSogfchA=;
	b=s5YlVeNpYYcrXRBZEstUszo9JQ4PXd7kk7Won76LVcvsTnxHe+q4Rx9F99JYxXZqHYLSCJ
	9YoBVPRq7strG/ffbYanoo5BCspV/qZ8vzAoZjEQW5EDTPcSn+kCeuZCiY0VYESpGKeO45
	vjVgTw1a+6Gftp5idyV7wNBcMyt0evE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788165181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLiVn9JnuWVZzxLodi5R8dfPt3sFwfArbvouSogfchA=;
	b=oNRhGaM3OWT7vE7c0fvsDwDbtXT5rGG21yzTw0Dy8Fkcbd9un0ypTOGO6abZJD+xXEiRZr
	YqrWZritEphKIwBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788165177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLiVn9JnuWVZzxLodi5R8dfPt3sFwfArbvouSogfchA=;
	b=ZgsWieoMmwj+z1+7GtAVkqSgXnhhVCBTrRNE9lpOoNjAZW0T83NKxniz1Am+OJlCmkHGtU
	vbpcJwYf8sVK6Hq+H38uYybazsB9zCRizTOismxKCj35Bwd19qs2rU/Z1gd0LeIEX3EKG3
	XU5cyzWOlsaXaNIktkmDteiiognbAuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788165177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLiVn9JnuWVZzxLodi5R8dfPt3sFwfArbvouSogfchA=;
	b=d4+BIhmi3HGG2VZE2N8aLet7KwRuVpoCFHx5SjyXKKs1K4iAguI6cvBNqkw10rzJNrLKF/
	OG6kV9pEkI342hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4609113515;
	Mon, 31 Aug 2026 08:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F0wYETk8lWoyGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Aug 2026 08:32:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EAEB0A13B5; Mon, 31 Aug 2026 10:32:56 +0200 (CEST)
Date: Mon, 31 Aug 2026 10:32:56 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] fs: Remove references to mark_buffer_dirty_inode()
Message-ID: <t3egtfesi7rqgdpzbd5kgxqoyigf7fied7hwa2nkysuqcso35r@s6bqasavpnrg>
References: <20260828205429.3678204-1-willy@infradead.org>
 <20260828205429.3678204-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828205429.3678204-3-willy@infradead.org>
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo]

On Fri 28-08-26 21:54:22, Matthew Wilcox (Oracle) wrote:
> Complete the removal of mark_buffer_dirty_inode() by changing all
> references to it in the documentation to refer to mmb_mark_buffer_dirty()
> instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks. Somehow I missed these. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/porting.rst | 2 +-
>  fs/buffer.c                           | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 60880eb0c49d..de96b6745600 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -348,7 +348,7 @@ simply of return 1.  Note that all actual eviction work is done by caller after
>  As before, clear_inode() must be called exactly once on each call of
>  ->evict_inode() (as it used to be for each call of ->delete_inode()).  Unlike
>  before, if you are using inode-associated metadata buffers (i.e.
> -mark_buffer_dirty_inode()), it's your responsibility to call
> +mmb_mark_buffer_dirty()), it's your responsibility to call
>  invalidate_inode_buffers() before clear_inode().
>  
>  NOTE: checking i_nlink in the beginning of ->write_inode() and bailing out
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 90ea52af042a..daf851ea9824 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -520,8 +520,8 @@ EXPORT_SYMBOL_GPL(mmb_has_buffers);
>   *
>   * Do this in two main stages: first we copy dirty buffers to a
>   * temporary inode list, queueing the writes as we go. Then we clean
> - * up, waiting for those writes to complete. mark_buffer_dirty_inode()
> - * doesn't touch b_assoc_buffers list if b_mmb is not NULL so we are sure the
> + * up, waiting for those writes to complete. mmb_mark_buffer_dirty()
> + * doesn't touch b_assoc_buffers list if b_mmb is set so we are sure the
>   * buffer stays on our list until IO completes (at which point it can be
>   * reaped).
>   */
> @@ -542,7 +542,7 @@ int mmb_sync(struct mapping_metadata_bhs *mmb)
>  		bh = BH_ENTRY(mmb->list.next);
>  		WARN_ON_ONCE(bh->b_mmb != mmb);
>  		__remove_assoc_queue(mmb, bh);
> -		/* Avoid race with mark_buffer_dirty_inode() which does
> +		/* Avoid race with mmb_mark_buffer_dirty() which does
>  		 * a lockless check and we rely on seeing the dirty bit */
>  		smp_mb();
>  		if (buffer_dirty(bh) || buffer_locked(bh)) {
> @@ -580,7 +580,7 @@ int mmb_sync(struct mapping_metadata_bhs *mmb)
>  		bh = BH_ENTRY(tmp.prev);
>  		get_bh(bh);
>  		__remove_assoc_queue(mmb, bh);
> -		/* Avoid race with mark_buffer_dirty_inode() which does
> +		/* Avoid race with mmb_mark_buffer_dirty() which does
>  		 * a lockless check and we rely on seeing the dirty bit */
>  		smp_mb();
>  		if (buffer_dirty(bh)) {
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
