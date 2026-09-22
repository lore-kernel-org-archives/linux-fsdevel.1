Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FB20459A;
	Tue, 22 Sep 2026 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078678; cv=none; b=OPjdgPE1U9xotUZr1OHujoYpGjJ+HzkIg2rIb062jfmi1V+Q0WsD6dhVdHBipVPlAipnu78AOkCFkGqNKS/wQKRPPYw5aU5dJXIOucuZhQ/JruTQ5lXRZosb91aROP6R2x+acqOHhe0thxtjgjd+ac+uBUtTYwkqYxRFuXqb0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078678; c=relaxed/simple;
	bh=pvWQvPGfG+aUgaVcAPRE9vVHdj05FUHUfosdjjs7KJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRtHKj4NNnT2ZUeU3OPGiB6u63uWBIA7KNV5rlSRfQuuargh97bX66dfKSlzOk3rFLoEuIhxZgeUkA6/aVVKDvjUtq5cY20wZLejZRGDJEvKkk0Daxk/b0nTOD+YHCJn5j7AKbzLDTvSlrTHgduSp0LJLdLNANhBgTCYx71DRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ftrr0ue6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pxh+C+WZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k8Tlx4YL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uvq45gfw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ftrr0ue6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pxh+C+WZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k8Tlx4YL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uvq45gfw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60CF721A7A;
	Tue, 22 Sep 2026 12:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790078670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V4XuCq3+J5F64kl0D/fnBWAa1Wx7FGRcIOUudUTD/9U=;
	b=ftrr0ue6FGt6fAtunPjfqFJtR+XUj5N3DV2YLqQpAwF0a/pAlKIqdNqoHIxgKKJruKWIia
	bhIHbpGF6/K+2Z5o/yKw553lkkjSkZD/b0HoNiK5XGfNo8V+GqeV04akfgT13ZPKL5BPeN
	ShiOLxOD/mBDKSMY58o1GssglRS5TnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790078670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V4XuCq3+J5F64kl0D/fnBWAa1Wx7FGRcIOUudUTD/9U=;
	b=Pxh+C+WZPnudic+mCe/iKm1FJHv/4dHRMkucEv8XDfqtoZxxdI7f4WpV2QFsht5DEsYwWW
	KNLJ+lUK+YTCAsBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k8Tlx4YL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uvq45gfw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790078666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V4XuCq3+J5F64kl0D/fnBWAa1Wx7FGRcIOUudUTD/9U=;
	b=k8Tlx4YLbYkwnif+dTEMIl47zqpSlVZmFBvAkVwSff+ZG1QCCfsMxGVGqI10Ta9vzljCqx
	QOG00kC/cUNwVA0PklHem0iu6l0k6APIfsGJ7OQouUy/srQl/SiFwz0BfLUEObM2hqqmzn
	gilXPraUsz5UrK++iscoGzxKBvlZ+rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790078666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V4XuCq3+J5F64kl0D/fnBWAa1Wx7FGRcIOUudUTD/9U=;
	b=uvq45gfwueVIeGDOoAjD4Gcjw0aYlCaW8RY4PAbEwhMZZzYH2/VdwN8+9ywYNx8f8hHiNf
	vJ4op0Xhu+VIwYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B5DD132D3;
	Tue, 22 Sep 2026 12:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FfIgAspusmo2FwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Sep 2026 12:04:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A8FB3A13D4; Tue, 22 Sep 2026 14:04:21 +0200 (CEST)
Date: Tue, 22 Sep 2026 14:04:21 +0200
From: Jan Kara <jack@suse.cz>
To: jaidevshastri@vt.edu
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer: publish max_buffer_heads with release
 semantics
Message-ID: <if45dwtnxaoq56a247vcs34pjymmil3zgadjunyorwzekdslu2@c5m2x333rn7l>
References: <20260921-mb-fs-buffer-v1-1-e9ce65e8df43@vt.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-mb-fs-buffer-v1-1-e9ce65e8df43@vt.edu>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 60CF721A7A
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vt.edu:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 21-09-26 21:15:46, Jaidev Shastri via B4 Relay wrote:
> From: Jaidev Shastri <jaidevshastri@vt.edu>
> 
> buffer_init() creates bh_cachep and then computes max_buffer_heads, both
> with plain stores. recalc_bh_state() reads max_buffer_heads with a plain
> load from alloc_buffer_head() and free_buffer_head(), on any CPU.
> 
> Store it with smp_store_release() and read it with smp_load_acquire().
> 
> Found with MBCheck, a static herd7-based memory consistency checker.
> 
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>

And how exactly could these race? If alloc_buffer_head() could run so that
it won't see full results from buffer_init(), we'd be in big trouble. Hint:
buffer_init() is marked as __init and thus is run very early during kernel
bring up when we still run in single-cpu mode.

								Honza

> ---
>  fs/buffer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ed966fa73..bf5a674c1 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2864,7 +2864,8 @@ static void recalc_bh_state(void)
>  	__this_cpu_write(bh_accounting.ratelimit, 0);
>  	for_each_online_cpu(i)
>  		tot += per_cpu(bh_accounting, i).nr;
> -	buffer_heads_over_limit = (tot > max_buffer_heads);
> +	/* Pairs with the smp_store_release() in buffer_init(). */
> +	buffer_heads_over_limit = (tot > smp_load_acquire(&max_buffer_heads));
>  }
>  
>  struct buffer_head *alloc_buffer_head(gfp_t gfp_flags)
> @@ -2998,7 +2999,9 @@ void __init buffer_init(void)
>  	 * Limit the bh occupancy to 10% of ZONE_NORMAL
>  	 */
>  	nrpages = (nr_free_buffer_pages() * 10) / 100;
> -	max_buffer_heads = nrpages * (PAGE_SIZE / sizeof(struct buffer_head));
> +	/* Pairs with the smp_load_acquire() in recalc_bh_state(). */
> +	smp_store_release(&max_buffer_heads,
> +			  nrpages * (PAGE_SIZE / sizeof(struct buffer_head)));
>  	ret = cpuhp_setup_state_nocalls(CPUHP_FS_BUFF_DEAD, "fs/buffer:dead",
>  					NULL, buffer_exit_cpu_dead);
>  	WARN_ON(ret < 0);
> 
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20260921-mb-fs-buffer-0a91680176e5
> 
> Best regards,
> --  
> Jaidev Shastri <jaidevshastri@vt.edu>
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
