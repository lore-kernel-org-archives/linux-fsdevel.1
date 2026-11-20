Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168089;
	b=LBtXz1I8wQxCnHZQJsM0xDkSJbxtA31iPxEaikx7x4InPrFIcyMw7KXnyEZX9I8wWLrv
	 rQy5ikzv+lUCjRYXa5dvD3XUBAFzDi5Bli1HaL3Ex5my3Mg7r/ecU1q41BUSpRJH87sDb
	 1VnOnog7nMw4BCBYYBF4ncVxr0LaJos3yxI27bB2DxhQYi6gy4XeJ467D/1rwW+xmEGi8
	 nstJq23FWSwSPKSfS2cab15CksHyreVEBl8gahToIcEkUfEkg6eIGeOaHNdGFFH4UVMWi
	 rEoG/Bop+68VLwL7uokVOTSgvCIo8Nk4PyrryFH5JHDjVRRzEoXRXZYATuuFZvgJGCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168089;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=NsT9uGoRAnST8Pf5uIEVETCgQNmLf9ZA3DnJoUPyAPk=;
	b=Dsdc6DGnCImvzMPo07pe3blxkZur0DD3gLGAtKQvD0wcteXPlcVwqJUYEjYI3WcTbMXl
	 wLZU/tfxdYrK1R1fs6z6yfa4/QzsLDIR8NIfRX9/M/jaINkgTWbM69UMWULJS3OPqFHHF
	 Em5QjsUdiCB8D36PXqqlf6EqpVOXxQKyGmt5eIvotmdoTRoCDJ1aVhJU59aKdILaohpPe
	 2/c6Cuz+OZCjQW+b8tCBr7SkK2RNRWnSPvdJz5rpn5UN3RvBEqY9yv6aUjmMwE5ihFbZ8
	 YwKNg9tQz1VxdWkNh/pSqjI4IhSQfo6glwNHqi79Vz0bHSkjhG0/Tfpoe/EWjfNQwkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=W7mBB1rI;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ckfE1+iC;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qmOyU1K6;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ylBmmDe7;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0F606A320;
	Fri, 20 Nov 2026 09:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6F0F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=W7mBB1rI;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ckfE1+iC;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qmOyU1K6;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ylBmmDe7
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7688B2250F;
	Fri, 20 Nov 2026 09:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795168086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NsT9uGoRAnST8Pf5uIEVETCgQNmLf9ZA3DnJoUPyAPk=;
	b=W7mBB1rI97/a7khCj6LW80l0akIq9P+AS9U4MLNkVpuIvplJT7soJMCvMDthMhaODZuuok
	9zilELAamfLDJMMjPVB87BZ11OwVjxKhL8pvTyWzjW4wkr8DhMP5PGUHGMLerscqPgVdp8
	LwLgf7JBUB8Gzds7fAi+vX5Yj9v3hUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795168086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NsT9uGoRAnST8Pf5uIEVETCgQNmLf9ZA3DnJoUPyAPk=;
	b=ckfE1+iCBSu4X5UWFKlYkQbjqIhwdl1fQbrEgYLPEHuJpQfwvHAF4Lw5Ms6SMpgFgAcEbc
	7DZBQ6gLnKN8JzDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qmOyU1K6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ylBmmDe7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795168085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NsT9uGoRAnST8Pf5uIEVETCgQNmLf9ZA3DnJoUPyAPk=;
	b=qmOyU1K6Eoi3N6obv7hQasA7mJnlGPMtC3UJREt6WvaWKXS/ITLOEU43iAVg4Kbb0brPFW
	aCMx4MhUQjsSnuWNIQWqm7zxihpsOorsYaTxXtztsoYrbWEmte96Ew8NAKFOwfMsgEFSY4
	oyLnswDfPdCm4kwWBCT1XkN+BdrWRM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795168085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NsT9uGoRAnST8Pf5uIEVETCgQNmLf9ZA3DnJoUPyAPk=;
	b=ylBmmDe7fTVCdds8LM2YkbF6OAk08f7rCggbLw4STiWXyz3r+TJzWcLJkyQj29aZ7NPAWs
	pDO0Q+tnIoz+VUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B9061348F;
	Fri, 20 Nov 2026 09:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K2KqCVUXAGtYDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Nov 2026 09:48:05 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id CBF9425EED; Fri, 20 Nov 2026 10:48:04 +0100 (CET)
Date: Fri, 20 Nov 2026 10:48:04 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v5 2/5] fsnotify: update children flags only when adding
 mask bits
Message-ID: <mk7u4brorzgbyol7x4nyolufk3s3piqwqd5hnya3nhoq43d5ui@x5sdqeyrhde6>
References: <20261119025942.2848130-1-neilb@ownmail.net>
 <20261119025942.2848130-3-neilb@ownmail.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119025942.2848130-3-neilb@ownmail.net>
X-Rspamd-Queue-Id: 7688B2250F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org,themaw.net,lwn.net];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,brown.name:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.01

On Thu 19-11-26 13:57:02, NeilBrown wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Since we only ever set the PARENT_WATCHED flag from
> fsnotify_recalc_mask(), there is never a need to update children flags
> when removing mark mask bits only when adding them.
> 
> Add a helper fsnotify_recalc_mask_and_update_children() to be called
> in cases where updating children flags may be needed (i.e. add mark).
> 
> Also avoid update children walk with mark spinlock held.
> This was only done by dnotify and can be easily avoided.
> 
> neilb: added update_children flag in fcntl_dirnotify() so we only
>   do the update when needed.
> 
> Fixes: 172e422ffea20 ("fsnotify: clear PARENT_WATCHED flags lazily")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>

One question to Amir below. Otherwise I like it.

> +/*
> + * Recalculate mask and update children dentry PARENT_WATCHED flags if the
> + * connector started watching children.  When parent stops watching, we
> + * clear false positive PARENT_WATCHED flags lazily in __fsnotify_parent().
> + *
> + * The caller must make sure connector and connector->obj cannot disappear
> + * under us.  This is achieved by holding mark->group->mark_mutex for a
> + * mark on this list.  mark->lock must not be held by the caller.
> + */
> +void fsnotify_recalc_mask_and_update_children(
> +					struct fsnotify_mark_connector *conn)
> +{
> +	if (fsnotify_recalc_mask(conn))
>  		fsnotify_conn_set_children_dentry_flags(conn);
>  }
>  
> @@ -367,8 +383,8 @@ void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear)
>  		recalc = true;
>  	spin_unlock(&mark->lock);
>  
> -	if (recalc)
> -		fsnotify_recalc_mask(mark->connector);
> +	if (recalc && fsnotify_recalc_mask(mark->connector) && set)

Amir, why is the '&& set' check here? Under normal circumstances if
fsnotify_recalc_mask() return's true, 'set' is true as well. We can be
racing with other updates to the connector list of marks and in that case our
fsnotify_recalc_mask() call could be the first one that noticed the marks
attached to the inode are now watching children and is thus resposible for
setting children dentry flags even if 'set' was false. So I think it can do
only harm...

And for similar reasons I believe fsnotify_recalc_mask() call in
fanotify_remove_mark() needs to be updated to
fsnotify_recalc_mask_and_update_children() as well. Standalone
fsnotify_recalc_mask() is simply never safe unless it is followed by the
update children later - perhaps make it __must_check?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
