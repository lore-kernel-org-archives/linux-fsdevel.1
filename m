Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3272480979
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203934; cv=none; b=A0FoW3s8KTJeMJFs1Cq4tuVpuDsdq1IJoHAE8CtZPkFQiZymNqOPXGlQOvL+twST9Fn8I8g4toMSSI4IibZHJTvPC+gXhOgrOgrETYquxPDXtgtOMCXJzcjlz28t00yb3owXq8MLJV8I4tZzYqxpwWIKHBKWKhE0PF4PjN2xqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203934; c=relaxed/simple;
	bh=TpEjXe0Uv2yRoN8KJj2CckRNDuir9UQYsSc5/BykMYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBGD2T2txdmFhkss155f2qNmpWYzXw4e8xuyz1yl71V9/yAJ3lblUquYwzQUrat3rPN8QXDtYcrG6YzUip6kM3/UfuoY2cKZvcwDX+6p1DTI7cNNFqNzRJ/EwXpXfgQiUcS+LoCfwW1sL8iMi9iNpHrsbCC/bh7sDli+S/pp1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q6GD1Ge1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Q0xJiwU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j4m9fLsw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m9hHhpSL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q6GD1Ge1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Q0xJiwU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j4m9fLsw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m9hHhpSL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84E4221DD9;
	Mon,  5 Oct 2026 12:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791203926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WBQl35Oyicga6wUAK0XLCVyhjCzAUOSndBiahFnzZaY=;
	b=Q6GD1Ge1vXy2xphzcKX18IHfY89WITGX4dY10AQxUzG3iYkJVfWkJEjVReFv8cU5Vdl5v5
	Lx8iBuP2aTMS1VhFJUtPX5qF3Rfz36pPUofJ2XhDzpRrVbFN7cRFBoznWuqZvBs2CjIuzP
	ufFHv02BpiWVMECNeZMUkhroSu1VVRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791203926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WBQl35Oyicga6wUAK0XLCVyhjCzAUOSndBiahFnzZaY=;
	b=9Q0xJiwUxXH5uprK7wLkN/WGL1zNCZOPACyzVYor7OpJG/uQDg/zHRi9Dsug/nSKSsEmzJ
	jfGXzbix5FJMQvDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791203922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WBQl35Oyicga6wUAK0XLCVyhjCzAUOSndBiahFnzZaY=;
	b=j4m9fLswQSmrTVQfbMEsrqP7d0lxPdagL1FOf6QFU4UsTRRfr+QzTChVVk4MP7e2N3ZWvI
	Xz0dWGeupqjbhg/PG2I0W70JtbxkOHAbSzEUDwMHRi/nclegO6c8wrvv8i9QjL5t4Rqdda
	G0KHllkfxnFJBKxv+GpYBSxOrgsoL/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791203922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WBQl35Oyicga6wUAK0XLCVyhjCzAUOSndBiahFnzZaY=;
	b=m9hHhpSLzT1NA7ICP/PeWEfkDS22hZ4qjEj4NeF7Jlv4e5bf52eU+5E243usxwSSyPmRbC
	1TCr5656V5OljLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EADB13AD2;
	Mon,  5 Oct 2026 12:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fe1yClKaw2piNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Oct 2026 12:38:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AF263A13FB; Mon, 05 Oct 2026 14:38:41 +0200 (CEST)
Date: Mon, 5 Oct 2026 14:38:41 +0200
From: Jan Kara <jack@suse.cz>
To: Giuseppe Scrivano <giuseppe@scrivano.org>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, hch@infradead.org
Subject: Re: [PATCH v7 1/2] fs: rename vfs_get_super() to get_tree_super()
 and export it
Message-ID: <uohz6te4kkbphnjhhkcbixkq5z7wac3funn6vqzso5qgg2efxx@5d3cikbkjinp>
References: <20261002163225.1258203-1-giuseppe@scrivano.org>
 <20261002163225.1258203-2-giuseppe@scrivano.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002163225.1258203-2-giuseppe@scrivano.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,kernel.org,vger.kernel.org,gmail.com,zeniv.linux.org.uk,suse.cz,infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 02-10-26 18:31:43, Giuseppe Scrivano wrote:
> Rename and export it so filesystems that need a custom superblock
> matching policy can reuse it directly instead of open-coding sget_fc()
> + fill_super().  No functional change.
> 
> This is a preparatory fix for the next patch.
> 
> Signed-off-by: Giuseppe Scrivano <giuseppe@scrivano.org>

OK, AFAIU you are essentially implementing kind of bind-mounting for
your file-backed mounts, aren't you? I guess makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c                 | 19 +++++++++++++++----
>  include/linux/fs_context.h |  4 ++++
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 1d5ccf540a9b..a1dc4de1b657 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1374,7 +1374,17 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
>  	return 1;
>  }
>  
> -static int vfs_get_super(struct fs_context *fc,
> +/**
> + * get_tree_super - Get a superblock, optionally sharing an existing one
> + * @fc: The filesystem context holding the parameters
> + * @test: Comparison function to find a matching existing superblock, or NULL
> + * @fill_super: Helper to initialise a new superblock
> + *
> + * If @test is non-NULL and matches an existing superblock, that superblock is
> + * reused; otherwise a new anonymous superblock is created and initialised with
> + * @fill_super.  Passing NULL for @test always creates a new superblock.
> + */
> +int get_tree_super(struct fs_context *fc,
>  		int (*test)(struct super_block *, struct fs_context *),
>  		int (*fill_super)(struct super_block *sb,
>  				  struct fs_context *fc))
> @@ -1401,12 +1411,13 @@ static int vfs_get_super(struct fs_context *fc,
>  	deactivate_locked_super(sb);
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(get_tree_super);
>  
>  int get_tree_nodev(struct fs_context *fc,
>  		  int (*fill_super)(struct super_block *sb,
>  				    struct fs_context *fc))
>  {
> -	return vfs_get_super(fc, NULL, fill_super);
> +	return get_tree_super(fc, NULL, fill_super);
>  }
>  EXPORT_SYMBOL(get_tree_nodev);
>  
> @@ -1414,7 +1425,7 @@ int get_tree_single(struct fs_context *fc,
>  		  int (*fill_super)(struct super_block *sb,
>  				    struct fs_context *fc))
>  {
> -	return vfs_get_super(fc, test_single_super, fill_super);
> +	return get_tree_super(fc, test_single_super, fill_super);
>  }
>  EXPORT_SYMBOL(get_tree_single);
>  
> @@ -1424,7 +1435,7 @@ int get_tree_keyed(struct fs_context *fc,
>  		void *key)
>  {
>  	fc->s_fs_info = key;
> -	return vfs_get_super(fc, test_keyed_super, fill_super);
> +	return get_tree_super(fc, test_keyed_super, fill_super);
>  }
>  EXPORT_SYMBOL(get_tree_keyed);
>  
> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index 0d6c8a6d7be2..d1727dffecc5 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -150,6 +150,10 @@ extern int vfs_parse_fs_param_source(struct fs_context *fc,
>  				     struct fs_parameter *param);
>  extern void fc_drop_locked(struct fs_context *fc);
>  
> +int get_tree_super(struct fs_context *fc,
> +		   int (*test)(struct super_block *, struct fs_context *),
> +		   int (*fill_super)(struct super_block *sb,
> +				     struct fs_context *fc));
>  extern int get_tree_nodev(struct fs_context *fc,
>  			 int (*fill_super)(struct super_block *sb,
>  					   struct fs_context *fc));
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
