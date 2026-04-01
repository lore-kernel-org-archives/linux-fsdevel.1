Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E13314AE
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064539; cv=none; b=XN+hWWRcOUOeTDKrtkvX2Uu+Kwl1Zi2L6P1RlRqVeaIwoBtbjH0pP4C3mQyKFb6S/hBz+YQUrVSUfMoN92wtVe1ebSdx9goglcgg+JFHVZWdmcORqciFWbBVkZJs7dlhy0SjTNcJFdU7Ob1XuXj9AzV0AMGbnqSd+MgunhjB9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064539; c=relaxed/simple;
	bh=H7ZjqncVuECHfIgS7Mf5UlSU4ILQfmpKvBoWIP1eifQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXD2p8FHC1iWTTI8pSMq5L9l/sEngXwJ2+SFb0yQGIJHrNM0+SF/pbF4koG9YUT1yITnuIWaOxVr5ztIEsv/DrN5WM89/nk1ws+M6XCXD6QeBYz/e9iPO4QWKhY3J+X4Hg/Z1YuzMy/LPfQ/9PJNScGZM/3/5VMW/w5Z8hNwpqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gELf2CMd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gILnsBa5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gELf2CMd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gILnsBa5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gELf2CMd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gILnsBa5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gELf2CMd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gILnsBa5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B5005BDC5;
	Wed,  1 Apr 2026 17:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775064536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lFARJ5ipfGxdYB/fRzHUVyl0Qd4hs9Zkn3AlH/Ljgs=;
	b=gELf2CMd6/gkBeYIV0H/ocdo9ERb+kSKEvlhzQvMVtHG0HhXrioBzwSsXzUP9852QJIdq1
	9chFJc5Qnh0RvZUbb8IGcHxXnv2MmhyR0LJw/8WICcw+sfbNbs/sRZPBrSEJrhHx0O0L1f
	hnwwJ3tJEVwzDbSOQX2IYlQX/YJzU4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775064536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lFARJ5ipfGxdYB/fRzHUVyl0Qd4hs9Zkn3AlH/Ljgs=;
	b=gILnsBa5sVn6fP4WXFT94K0P92oQqM8jmq5HyXEf3F88utfX8lZ/rc0HwrGcVlcvWGQ65t
	T9KT3milWhv33eBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gELf2CMd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gILnsBa5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775064536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lFARJ5ipfGxdYB/fRzHUVyl0Qd4hs9Zkn3AlH/Ljgs=;
	b=gELf2CMd6/gkBeYIV0H/ocdo9ERb+kSKEvlhzQvMVtHG0HhXrioBzwSsXzUP9852QJIdq1
	9chFJc5Qnh0RvZUbb8IGcHxXnv2MmhyR0LJw/8WICcw+sfbNbs/sRZPBrSEJrhHx0O0L1f
	hnwwJ3tJEVwzDbSOQX2IYlQX/YJzU4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775064536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lFARJ5ipfGxdYB/fRzHUVyl0Qd4hs9Zkn3AlH/Ljgs=;
	b=gILnsBa5sVn6fP4WXFT94K0P92oQqM8jmq5HyXEf3F88utfX8lZ/rc0HwrGcVlcvWGQ65t
	T9KT3milWhv33eBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E87B4A0B0;
	Wed,  1 Apr 2026 17:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FLkkE9hVzWkoOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Apr 2026 17:28:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 06E7BA0B39; Wed,  1 Apr 2026 19:28:52 +0200 (CEST)
Date: Wed, 1 Apr 2026 19:28:51 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] fs: relocate and tidy up ihold()
Message-ID: <s2paybz4lrlfihs2auwplx4pcgedpjlffuypsm6rmf43fpwqw3@xa5ta5r7bcrk>
References: <20260331160851.3854954-1-mjguzik@gmail.com>
 <20260331160851.3854954-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331160851.3854954-3-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5B5005BDC5

On Tue 31-03-26 18:08:49, Mateusz Guzik wrote:
> The placement was illogical, move it next to igrab().
> 
> Take this opportunity to add docs and an assert on the refcount. While
> its modification remains gated with a WARN_ON, the new assert will also
> dump the inode state which might aid debugging.
> 
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 1f5a383ccf27..e397a4b56671 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -522,15 +522,6 @@ static void init_once(void *foo)
>  	inode_init_once(inode);
>  }
>  
> -/*
> - * get additional reference to inode; caller must already hold one.
> - */
> -void ihold(struct inode *inode)
> -{
> -	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
> -}
> -EXPORT_SYMBOL(ihold);
> -
>  struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
>  					    struct inode *inode, u32 bit)
>  {
> @@ -1578,6 +1569,17 @@ ino_t iunique(struct super_block *sb, ino_t max_reserved)
>  }
>  EXPORT_SYMBOL(iunique);
>  
> +/**
> + * ihold - get a reference on the inode, provided you already have one
> + * @inode:	inode to operate on
> + */
> +void ihold(struct inode *inode)
> +{
> +	VFS_BUG_ON_INODE(icount_read_once(inode) < 1, inode);
> +	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
> +}
> +EXPORT_SYMBOL(ihold);
> +
>  struct inode *igrab(struct inode *inode)
>  {
>  	spin_lock(&inode->i_lock);
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
