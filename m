Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169353;
	b=LlfuTKxrAT/E20jQEGCj+cA9HTI4x3O4YW0/hhjJBG77Glgug7yBDii68kX/l/nmlIZW
	 bDwl/oisoe8IGq4vrPCbvrfOX31VdSfGnZk4w2brhizSyyVAdXQNBj4MKFFLP75mmMHt9
	 B3DR6N8Cgi8L4BcI0mmhbxKhtm+isM32fBHVqtkVxFd3dCyvDR9Us1UB/ZIysxraiqzE0
	 MpEDhrx/7IgkrYIe/r1K05JmA2/iPJnmRJShUSCjIJ67CgqjFvkz0kkBo2lBNdbdp21Vt
	 AzDLXvM1czNyoKaFg9kMcx4v9h3gXJj9ZU2iHeRRtMe+lAVyZ9DzoKK8sfXAiHxn71w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169353;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=YXUPlOtVsHyGsAvN0gcRfJ7d4p2UrmspQBy4CnwR4Kc=;
	b=aNm1K+HA9BRpOwOS397a1oDs0kwWr5fHkuWIMz2NgE6IGnSfJ4a6Zq1UZKi3NBEkYqTK
	 5x28pF4358kHmT/qeLHROC1ZmqwYC0k7N0Sbf0i+QLBpAtXFQG/8ah9ja0ixqdqipQUb9
	 kW6oezq+Bzb198VMPROYalZscQbk/ZQz1l3RIrbUa9M0KpPpV7KY7p1vahJg59IGFO4Ni
	 MmB2N+5HE7+EqYNV7vhIQM8SyRDEDr+8mMWQiOMorWhvSCZ5jEt0mkOnuHnNYLSns8Nch
	 MJ39ObBPeL4194KDM5+O9eipN9czlYpiTbmbaWS30PgFfkf0rzZEb/XBU2VFTWEeG9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tjRe2pYX;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5dqb+r4V;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tjRe2pYX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5dqb+r4V;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83B606A334;
	Fri, 20 Nov 2026 10:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F83B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tjRe2pYX;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5dqb+r4V;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tjRe2pYX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5dqb+r4V
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 654811FB61;
	Fri, 20 Nov 2026 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795169350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXUPlOtVsHyGsAvN0gcRfJ7d4p2UrmspQBy4CnwR4Kc=;
	b=tjRe2pYXkVOCWboxAQ4I4+y7F+QkNEyWHKPPVMe7ZwLYsY2RrfkHhCB3c59c6UK9F3Kw4K
	+FP2Br7+68+PoGJztTqdoOFcCSk1oUPpW3yK66JXE589IN9aYzl7htut9tKNuzBG52uPCm
	kUqfX+avw4NGICu/y7HHv8pTSyJIcYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795169350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXUPlOtVsHyGsAvN0gcRfJ7d4p2UrmspQBy4CnwR4Kc=;
	b=5dqb+r4VQwzwTXN2IGy2oYFOudbr/K7deRp20h6X8LAVgTVidcR0Und2pphSugg2okZQBy
	YdPx43uLmbQjeIAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tjRe2pYX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5dqb+r4V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795169350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXUPlOtVsHyGsAvN0gcRfJ7d4p2UrmspQBy4CnwR4Kc=;
	b=tjRe2pYXkVOCWboxAQ4I4+y7F+QkNEyWHKPPVMe7ZwLYsY2RrfkHhCB3c59c6UK9F3Kw4K
	+FP2Br7+68+PoGJztTqdoOFcCSk1oUPpW3yK66JXE589IN9aYzl7htut9tKNuzBG52uPCm
	kUqfX+avw4NGICu/y7HHv8pTSyJIcYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795169350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXUPlOtVsHyGsAvN0gcRfJ7d4p2UrmspQBy4CnwR4Kc=;
	b=5dqb+r4VQwzwTXN2IGy2oYFOudbr/K7deRp20h6X8LAVgTVidcR0Und2pphSugg2okZQBy
	YdPx43uLmbQjeIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DF801348F;
	Fri, 20 Nov 2026 10:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id imEhB0YcAGu9IQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Nov 2026 10:09:10 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id D8FF825EFF; Fri, 20 Nov 2026 11:09:09 +0100 (CET)
Date: Fri, 20 Nov 2026 11:09:09 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v5 4/5] Add d_for_each_positive_child family of iterators
Message-ID: <t2pgbjenemfhv7oz3wpy2eplpc627bns5dot7ly43hrczvd4yz@caeyfokaqycw>
References: <20261119025942.2848130-1-neilb@ownmail.net>
 <20261119025942.2848130-5-neilb@ownmail.net>
 <CAOQ4uxgan=mpQ9yHOyZwZZp8E69+oH3uaPJ5CBkP7Z5BCO-5jA@mail.gmail.com>
 <179513093550.1728055.17648674323193416652@noble.neil.brown.name>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179513093550.1728055.17648674323193416652@noble.neil.brown.name>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,themaw.net,lwn.net];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 654811FB61

On Fri 20-11-26 10:28:55, NeilBrown wrote:
> On Fri, 20 Nov 2026, Amir Goldstein wrote:
> > On Thu, Nov 19, 2026 at 4:00 AM NeilBrown <neilb@ownmail.net> wrote:
> 
> > > +
> > > +/**
> > > + * d_next_sibling_sched - return next sibling, but schedule() first
> > > + * @child:  current child
> > > + *
> > > + * This behaves like d_next_sibling(), but drops the parent d_lock
> > > + * and calls cond_resched() to avoid any soft-lockup.  A cursor
> > > + * is inserted as place holder.
> > > + *
> > > + * Caller must hold the parents d_lock, and must hold a counted
> > > + * reference on the parent.
> > > + *
> > > + * Returns: the next sibling, or %NULL if there is none.
> > > + */
> > > +struct dentry *d_next_sibling_sched(struct dentry *child)
> > > +__must_hold(&child->d_parent->d_lock)
> > > +{
> > > +       struct dentry cursor;
> > > +
> > > +       /* always skip cursors to ensure we make some real progress */
> > > +       while (child && (child->d_flags & DCACHE_DENTRY_CURSOR))
> > > +               child = d_next_sibling(child);
> > > +       if (!child)
> > > +               return child;
> > 
> > Why is this skip loop here and not after the resched?
> > 
> > As this is written, if the caller passed @child which is another cursor,
> > now child the next real dentry after another cursor and hlist_add_behind()
> > below will insert our cursor after the real dentry.
> 
> You are right of course - that is the wrong way to address the problem.
> 
> I think moving the test into d_next_positive(), like with this
> incremental patch, will work better.

With this change it looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>
								Honza

> diff --git a/fs/dcache.c b/fs/dcache.c
> index bacb218400a8..46aca619a9a3 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2095,6 +2095,9 @@ static void d_init_cursor(struct dentry *dentry, struct dentry *parent)
>   * Caller must hold the parents d_lock, and must hold a counted
>   * reference on the parent.
>   *
> + * @child should not be a cursor, else two threads could potentially
> + * live-lock, each only stepping over each others cursors.
> + *
>   * Returns: the next sibling, or %NULL if there is none.
>   */
>  struct dentry *d_next_sibling_sched(struct dentry *child)
> @@ -2102,12 +2105,6 @@ __must_hold(&child->d_parent->d_lock)
>  {
>  	struct dentry cursor;
>  
> -	/* always skip cursors to ensure we make some real progress */
> -	while (child && (child->d_flags & DCACHE_DENTRY_CURSOR))
> -		child = d_next_sibling(child);
> -	if (!child)
> -		return child;
> -
>  	d_init_cursor(&cursor, child->d_parent);
>  	hlist_add_behind(&cursor.d_sib, &child->d_sib);
>  	spin_unlock(&cursor.d_parent->d_lock);
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 7150ecd81d72..c384b0f8743e 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -697,7 +697,10 @@ struct dentry *d_next_sibling_sched(struct dentry *child);
>  static inline struct dentry *d_next_positive(struct dentry *child)
>  {
>  	do {
> -		if (need_resched())
> +		/* Don't schedule on cursors to ensure we make some real
> +		 * progress between scheduling
> +		 */
> +		if (need_resched() && !(child->d_flags & DCACHE_DENTRY_CURSOR))
>  			child = d_next_sibling_sched(child);
>  		else
>  			child = d_next_sibling(child);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
