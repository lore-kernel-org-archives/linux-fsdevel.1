Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6CD49BB5A;
	Mon, 19 Oct 2026 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399388; cv=none; b=jGz4Zc0whgwbLE8h7v6Cs0vjxBOprjFkYEuN8jnufbqeOcIvRbV5hthMD8IU83JpTutb0QnH0B7mAzj9VGUnq7T92UMSAi48UNTBZkUsgsz5x7sOarbefBnwbq82Q6czNE/Gpu2aDpM8BeqkVIcEsyIU7T6xbKz3kBhxwbAAvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399388; c=relaxed/simple;
	bh=BNV1uK1opZ3O523xbTqfMaRdwIgp+qR8cOeXr05w9Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmGSa+3O5c4bwd2wO/C+p7vUlCZ7PYf4klYsaIPLTXj6sdiYgcPZAX3wiwYUjBRmGiGIMPkuDWdjoK33ZRW/ZyT0Z28nx8sNyj09ggHTUCVU7dgX3zavmSKUxsAcN+arF2UDfQXU4bgZ87aPdtdx27rIiFyLq6WkA/OLsPNutsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Aa3zvWak; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v6pSfpIi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dDnw2qAO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RhFTBS8g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aa3zvWak";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v6pSfpIi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dDnw2qAO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RhFTBS8g"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D77EB1F797;
	Mon, 19 Oct 2026 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792399383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/l9YtqXmGv0QvRj7l3zaZcE45o8ZMbbiR+ytpWvrGM=;
	b=Aa3zvWaks8roH3gnv8JmUJT9z6Nbhz3aai73hRXD7QeL3Cg9ryJCJqgGSGMm1akkFhOH0L
	6GpEyFcONfDCHOUrizqymh04BiCt4HT/Gx/w2IQK4l1BBixETOCCLAjlh8+iNi4PX7boJg
	VVpUr+jm3IUiZO4kfEmrgLlCbJxz3iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792399383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/l9YtqXmGv0QvRj7l3zaZcE45o8ZMbbiR+ytpWvrGM=;
	b=v6pSfpIiUF/TmG5NHmQumDySfUnGjdd9njuX34BQo5awbQcIUTxGOxPr4bhtdDCE+vK1Ku
	ibvl13NbjNtKIVAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dDnw2qAO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RhFTBS8g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792399382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/l9YtqXmGv0QvRj7l3zaZcE45o8ZMbbiR+ytpWvrGM=;
	b=dDnw2qAOrcZ0ZrT9ki1pxyzmgY/+ho/5nmxy+PsKgHvxqGLanMpBBsH7i/6ecmBUSouwTR
	8nW2FWyGCpP1K4Ct2eRDvnMIxgNgUVV49NZ2GPu1isc0XonZrG2ULNfO05O2CuFTrHAYoO
	htz7dwTC02No806qU6024PrqBtVsaww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792399382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/l9YtqXmGv0QvRj7l3zaZcE45o8ZMbbiR+ytpWvrGM=;
	b=RhFTBS8g+CAt3x0gR2HUFgiZFSBrVKO+MHHB/G0nj0byhypK6w/0/DWKFP0eAM4d3nMIyh
	MwbONi/Nq/TNwMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99D16136CC;
	Mon, 19 Oct 2026 08:43:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zSvHFxbY1WopcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Oct 2026 08:43:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 10D08A1413; Mon, 19 Oct 2026 10:43:02 +0200 (CEST)
Date: Mon, 19 Oct 2026 10:43:02 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached
 connector
Message-ID: <kayajmvnwgprpyxed346x2ae5d36axl2nvfb46pxf7txca7lxt@5bghhakbobib>
References: <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
 <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com>
 <6n6r5zvcu5ojihyb52rhejlky7xrn2a2p4l2cgfut5lsscunek@bcnpy7bifjrs>
 <CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGBQR+bS93k=4vgqzFDZA@mail.gmail.com>
 <20260902070359.4163607-1-4ncienth@gmail.com>
 <CAOQ4uxjwGdKhX423KoFxW+T5hc9uzCWSsGwn0-QX=CJipPSaYQ@mail.gmail.com>
 <20260902215046.1149198-1-4ncienth@gmail.com>
 <CAOQ4uxhuOSyMHnj9JZk6LU9=wpE=BRFXJ3fSEOGGV+6tC_5hfg@mail.gmail.com>
 <CAOQ4uxgiub97wtDpWx6n+p4EBuusSp4xKm+b1Xa_GBAHH8=i=g@mail.gmail.com>
 <CAOQ4uxg7Qt436SiKhKEJKOjtCjeB_XyTjazYF7HMyQAGGcgx2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg7Qt436SiKhKEJKOjtCjeB_XyTjazYF7HMyQAGGcgx2A@mail.gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D77EB1F797
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,redhat.com,vger.kernel.org,gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 12-10-26 15:26:59, Amir Goldstein wrote:
> From ff91e13847a5dbee4e864a47be5bf4bcc8199b74 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Wed, 2 Sep 2026 18:49:25 +0200
> Subject: [PATCH v3] fs: make sure to call fsnotify_inoderemove() only once
>  when inode is dead
> 
> Daehyeon reported a race wherein fsnotify_removeinode() can be called
> when inode still has a live alias.  This can lead to several undesired
> outcomes such as crashes in fsnotify code or avoidance of inode mark
> notifications.
> 
> Check that inode is really "dead", meaning no nlink and no more aliases
> before calling fsnotify_inoderemove() for final cleanup of inode marks.
> 
> Ideally, we'd call fsnotify_inoderemove() once last inode reference is
> dropped to make things simpler. Alas fsnotify inode marks currently hold
> inode references and thus this doesn't work. Once we teach fsnotify to
> avoid holding inode references, these games with dead inodes can go as
> well.
> 
> Note that a new alias could be created by open_by_handle() to an inode
> that has already reported FS_DELETE_SELF.  This case will be handled by
> a different patch.
> 
> Reported-by: Daehyeon Ko <4ncienth@gmail.com>
> Closes: https://lore.kernel.org/linux-fsdevel/20260827045007.3831259-1-4ncienth@gmail.com/
> CC: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://patch.msgid.link/20260902164924.1333135-2-jack@suse.cz

This got burried in my inbox. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b89c8480b655b..86a3a00929de1 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -450,6 +450,16 @@ static void dentry_free(struct dentry *dentry)
>  		call_rcu(&dentry->d_rcu, __d_free);
>  }
>  
> +/*
> + * When inode is unlinked and doesn't have any aliases (i.e., all fds pointing
> + * to it are closed) we report FS_DELETE_SELF to fsnotify and cleanup all inode
> + * marks.
> + */
> +static bool inode_notify_dead(struct inode *inode)
> +{
> +	return !inode->i_nlink && hlist_empty(&inode->i_dentry);
> +}
> +
>  /*
>   * Release the dentry's inode, using the filesystem
>   * d_iput() operation if defined.
> @@ -459,6 +469,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
>  	__releases(dentry->d_inode->i_lock)
>  {
>  	struct inode *inode = dentry->d_inode;
> +	bool notify_dead;
>  
>  	raw_write_seqcount_begin(&dentry->d_seq);
>  	__d_clear_type_and_inode(dentry);
> @@ -469,9 +480,10 @@ static void dentry_unlink_inode(struct dentry * dentry)
>  	 */
>  	dentry->waiters = NULL;
>  	raw_write_seqcount_end(&dentry->d_seq);
> +	notify_dead = inode_notify_dead(inode);
>  	spin_unlock(&dentry->d_lock);
>  	spin_unlock(&inode->i_lock);
> -	if (!inode->i_nlink)
> +	if (notify_dead)
>  		fsnotify_inoderemove(inode);
>  	if (dentry->d_op && dentry->d_op->d_iput)
>  		dentry->d_op->d_iput(dentry, inode);
> -- 
> 2.55.0
> 

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
