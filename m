Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427613;
	b=B9a/JezXKuqmMNcbhSLNIOOKz4dGAs5KBam7z3z5jFu3HYNEad0AjDGdgkqA4y8L7i8y
	 tMCP+QVa4z7pz352hXCcjgtfC/Ax9IzsXRfxF1b/lc6LwHmmapMnxjMcGdVssX6Eby5HK
	 UOCsKfb0EZDWw1URqJA3qnoWv8tZjhoBCSLTUMqq9e3Eg0j72Q3wlFXPPHuyc1QHJeN/p
	 soT3xBQ650KDmNAzdeD+KNgu8eY0hM2FAmdczLldSqKrtxRlhoHglP4n2WDt9Xl9t0ANl
	 qHzGGWUHTyfUaxkBRgCRyq0pa3e49h4YhprB+A+LjLGLwzT0C5jlFeFmtZWBRjnV4wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427613;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=+oVyYgl6b2gLIr7f27UmkTo1zRzv9x8FeUby/c3kXZA=;
	b=Yxt1wRK8pU4ACvYAh9rQlCSoxJMDyTwBY3cc3CFgjuUeM3h613ITBNlzg9zDqm9mzVJl
	 7emiUOOT55Zh95jn21y9oHe3SsnujT2gBKFEwxIy7B/LW6JCGj79Xh+pDUhYR5VrnowYJ
	 aL7wBXrAYFxah9WzHj2HU4OXFQtotV7/Dpv9tjQuoBFZHulAGj1MXIkTox13P7V2LQVgV
	 1a8/x1mKxk1TOsHMyRZ0tVcdG3Acs7yvexSs54qZoJvlfqKHCjhCshVgmHKA1CQehcpfk
	 2353l93Gt9FzpKPPz4XAyPXxBKbiiaNnOzT7cmzCnMPBFj5EajObIf+c3lgDIkeFtyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="Q+b9A/E6";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5pdxL2dz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="Q+b9A/E6";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5pdxL2dz;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC14606A335;
	Mon, 23 Nov 2026 09:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC14606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Q+b9A/E6;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5pdxL2dz;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Q+b9A/E6;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5pdxL2dz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49A891F385;
	Mon, 23 Nov 2026 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795427610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oVyYgl6b2gLIr7f27UmkTo1zRzv9x8FeUby/c3kXZA=;
	b=Q+b9A/E6TjtjdB34W92HlMan6o4IV68KzHiffQ0+Emxp7zXtbFIREt5032lteXIylVmN7/
	UEF4UZ2amQVIZhR8b3yT0G5souxWc7E+QeISXvZ8/DFUFE+ti/Qq2Jg+MQsfJVMEEfEzjl
	+JiYqOQJdhfKbRvli3tg9f9Nb4JdQ6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795427610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oVyYgl6b2gLIr7f27UmkTo1zRzv9x8FeUby/c3kXZA=;
	b=5pdxL2dzRJDHaTwYQk8wGOat9amdD9Pw+eeVsq5je4NQsjb306NFS7op/QmpNwGAd5ftyF
	vDOWI0vtTuQA5ICg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Q+b9A/E6";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5pdxL2dz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795427610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oVyYgl6b2gLIr7f27UmkTo1zRzv9x8FeUby/c3kXZA=;
	b=Q+b9A/E6TjtjdB34W92HlMan6o4IV68KzHiffQ0+Emxp7zXtbFIREt5032lteXIylVmN7/
	UEF4UZ2amQVIZhR8b3yT0G5souxWc7E+QeISXvZ8/DFUFE+ti/Qq2Jg+MQsfJVMEEfEzjl
	+JiYqOQJdhfKbRvli3tg9f9Nb4JdQ6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795427610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oVyYgl6b2gLIr7f27UmkTo1zRzv9x8FeUby/c3kXZA=;
	b=5pdxL2dzRJDHaTwYQk8wGOat9amdD9Pw+eeVsq5je4NQsjb306NFS7op/QmpNwGAd5ftyF
	vDOWI0vtTuQA5ICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B581352B;
	Mon, 23 Nov 2026 09:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7i+MOxkNBGuAPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Nov 2026 09:53:30 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id A93CB27632; Mon, 23 Nov 2026 10:53:29 +0100 (CET)
Date: Mon, 23 Nov 2026 10:53:29 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v5 2/5] fsnotify: update children flags only when adding
 mask bits
Message-ID: <4gx6ksbwjwsv3roi4m4dcq56nkogfj6zmkwielb4v3epb7irbi@fevnoqepuqns>
References: <20261119025942.2848130-1-neilb@ownmail.net>
 <20261119025942.2848130-3-neilb@ownmail.net>
 <mk7u4brorzgbyol7x4nyolufk3s3piqwqd5hnya3nhoq43d5ui@x5sdqeyrhde6>
 <CAOQ4uxgEqDiw2=dCM_PV9kObBboCmt7ohnHehKR8cgKyvLTPUw@mail.gmail.com>
 <CAOQ4uxjpLOmESHfkTRGziY-MuFvhD5B_Ay3dxZLLbsr2KafUvw@mail.gmail.com>
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
In-Reply-To: <CAOQ4uxjpLOmESHfkTRGziY-MuFvhD5B_Ay3dxZLLbsr2KafUvw@mail.gmail.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 49A891F385

On Fri 20-11-26 18:42:59, Amir Goldstein wrote:
> On Fri, Nov 20, 2026 at 1:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Nov 20, 2026 at 10:48 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 19-11-26 13:57:02, NeilBrown wrote:
> > > > From: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > Since we only ever set the PARENT_WATCHED flag from
> > > > fsnotify_recalc_mask(), there is never a need to update children flags
> > > > when removing mark mask bits only when adding them.
> > > >
> > > > Add a helper fsnotify_recalc_mask_and_update_children() to be called
> > > > in cases where updating children flags may be needed (i.e. add mark).
> > > >
> > > > Also avoid update children walk with mark spinlock held.
> > > > This was only done by dnotify and can be easily avoided.
> > > >
> > > > neilb: added update_children flag in fcntl_dirnotify() so we only
> > > >   do the update when needed.
> > > >
> > > > Fixes: 172e422ffea20 ("fsnotify: clear PARENT_WATCHED flags lazily")
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > Signed-off-by: NeilBrown <neil@brown.name>
> > >
> > > One question to Amir below. Otherwise I like it.
> > >
> > > > +/*
> > > > + * Recalculate mask and update children dentry PARENT_WATCHED flags if the
> > > > + * connector started watching children.  When parent stops watching, we
> > > > + * clear false positive PARENT_WATCHED flags lazily in __fsnotify_parent().
> > > > + *
> > > > + * The caller must make sure connector and connector->obj cannot disappear
> > > > + * under us.  This is achieved by holding mark->group->mark_mutex for a
> > > > + * mark on this list.  mark->lock must not be held by the caller.
> > > > + */
> > > > +void fsnotify_recalc_mask_and_update_children(
> > > > +                                     struct fsnotify_mark_connector *conn)
> > > > +{
> > > > +     if (fsnotify_recalc_mask(conn))
> > > >               fsnotify_conn_set_children_dentry_flags(conn);
> > > >  }
> > > >
> > > > @@ -367,8 +383,8 @@ void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear)
> > > >               recalc = true;
> > > >       spin_unlock(&mark->lock);
> > > >
> > > > -     if (recalc)
> > > > -             fsnotify_recalc_mask(mark->connector);
> > > > +     if (recalc && fsnotify_recalc_mask(mark->connector) && set)
> > >
> > > Amir, why is the '&& set' check here? Under normal circumstances if
> > > fsnotify_recalc_mask() return's true, 'set' is true as well. We can be
> > > racing with other updates to the connector list of marks and in that case our
> > > fsnotify_recalc_mask() call could be the first one that noticed the marks
> > > attached to the inode are now watching children and is thus resposible for
> > > setting children dentry flags even if 'set' was false. So I think it can do
> > > only harm...
> >
> > You're right. It's wrong.
> >
> > >
> > > And for similar reasons I believe fsnotify_recalc_mask() call in
> > > fanotify_remove_mark() needs to be updated to
> > > fsnotify_recalc_mask_and_update_children() as well. Standalone
> > > fsnotify_recalc_mask() is simply never safe unless it is followed by the
> > > update children later - perhaps make it __must_check?
> >
> > Yeh... neither dnotify_flush() nor dnotify_handle_event() check return
> > value now. I'll need to look into that.
> >
> 
> Here is a candidate for v6
> 
> No more races.
> Set a conn flag under lock for need_update
> First thread to see the flag clears it under lock
> and then updates children without lock.
> 
> Neil,
> 
> I removed your propagation of return value from
> dnotify_recalc_inode_mask() because now the cost of checking
> the flag is low enough to check it unconditionally.
> If this still bothers you much you can put it back.
> 
> This is of course only sanity tested - none of the races are
> covered by our tests.
> 
> Thanks,
> Amir.

> From 30dfb2688065e4733e81cef398894e119f3cf7a0 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Thu, 19 Nov 2026 13:57:02 +1100
> Subject: [PATCH v6] fsnotify: update children flags only when parent starts
>  watching children
> 
> We only need to set the PARENT_WATCHED flag on children when the parent
> inode starts watching children.  When the parent stops watching, false
> positive PARENT_WATCHED flags are cleared lazily in __fsnotify_parent().
> 
> The recalc that observes the parent starting to watch children is not
> necessarily the recalc of the mark that added the watch.  It may be the
> recalc of a concurrent remover in another group, or a recalc in a context
> that cannot walk the children, such as dnotify event handling.
> 
> Record the need to update children flags in a connector flag when the
> recalc observes the transition and let callers that are allowed to walk
> the children consume the flag via fsnotify_conn_set_children_dentry_flags()
> after mask recalc.  This way, the caller that added the watch is
> guaranteed to either update the children flags or find that another
> caller has already done so.
> 
> Also avoid the update children walk with mark spinlock held.  This was
> only done by dnotify and can be easily avoided.
> 
> Fixes: 172e422ffea20 ("fsnotify: clear PARENT_WATCHED flags lazily")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/dnotify/dnotify.c        |  6 +++
>  fs/notify/fanotify/fanotify_user.c |  4 +-
>  fs/notify/inotify/inotify_user.c   |  2 +-
>  fs/notify/mark.c                   | 86 +++++++++++++++++++++---------
>  include/linux/fsnotify_backend.h   |  6 +++
>  5 files changed, 77 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 9fb73bafd41d2..0afd2b0393333 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -181,6 +181,11 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
>  	}
>  
>  	spin_unlock(&fsn_mark->lock);
> +	/*
> +	 * We only remove mask bits here, but our recalc may be the first to
> +	 * observe another group starting to watch children.
> +	 */
> +	fsnotify_conn_set_children_dentry_flags(fsn_mark->connector);
>  
>  	/* nothing else could have found us thanks to the dnotify_groups
>  	   mark_mutex */
> @@ -380,6 +385,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
>  	dnotify_recalc_inode_mask(fsn_mark);
>  out:
>  	spin_unlock(&fsn_mark->lock);
> +	fsnotify_conn_set_children_dentry_flags(fsn_mark->connector);
>  
>  	if (destroy)
>  		fsnotify_detach_mark(fsn_mark);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 63c9759fc3b06..c064b0070c519 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1264,7 +1264,7 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
>  	removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
>  						 umask, &destroy_mark);
>  	if (removed & fsnotify_conn_mask(fsn_mark->connector))
> -		fsnotify_recalc_mask(fsn_mark->connector);
> +		fsnotify_recalc_mask_and_update_children(fsn_mark->connector);
>  	if (destroy_mark)
>  		fsnotify_detach_mark(fsn_mark);
>  	fsnotify_group_unlock(group);
> @@ -1538,7 +1538,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>  
>  	recalc = fanotify_mark_add_to_mask(fsn_mark, mask, fan_flags);
>  	if (recalc)
> -		fsnotify_recalc_mask(fsn_mark->connector);
> +		fsnotify_recalc_mask_and_update_children(fsn_mark->connector);
>  
>  out:
>  	fsnotify_group_unlock(group);
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 5f19c24ec187f..6018c2d717ac2 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -562,7 +562,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
>  	fsn_mark->flags |= inotify_arg_to_flags(arg);
>  	spin_unlock(&fsn_mark->lock);
>  
> -	fsnotify_recalc_mask(fsn_mark->connector);
> +	fsnotify_recalc_mask_and_update_children(fsn_mark->connector);
>  
>  	/* return the wd */
>  	ret = i_mark->wd;
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index cb07f42d34222..1658fbef61dfc 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -238,21 +238,37 @@ static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
>  	return inode;
>  }
>  
> +static bool fsnotify_conn_watches_children(
> +					struct fsnotify_mark_connector *conn)
> +{
> +	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
> +		return false;
> +
> +	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
> +}
> +
>  /*
>   * Calculate mask of events for a list of marks.
>   *
> + * If the connector started watching children, flag it so that the next call
> + * to fsnotify_conn_set_children_dentry_flags() updates the children dentry
> + * flags.  The caller that observes the transition may not be allowed to walk
> + * the children, so the update may be done by another caller.
> + *
>   * Return true if any of the attached marks want to hold an inode reference.
>   */
>  static bool __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  {
>  	u32 new_mask = 0;
>  	bool want_iref = false;
> +	bool watched_children;
>  	struct fsnotify_mark *mark;
>  
>  	assert_spin_locked(&conn->lock);
>  	/* We can get detached connector here when inode is getting unlinked. */
>  	if (!fsnotify_valid_obj_type(conn->type))
>  		return NULL;
> +	watched_children = fsnotify_conn_watches_children(conn);
>  	hlist_for_each_entry(mark, &conn->list, obj_list) {
>  		if (!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED))
>  			continue;
> @@ -267,6 +283,13 @@ static bool __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  	 */
>  	WRITE_ONCE(*fsnotify_conn_mask_p(conn), new_mask);
>  
> +	if (fsnotify_conn_watches_children(conn) != watched_children) {
> +		if (watched_children)
> +			conn->flags &= ~FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
> +		else
> +			conn->flags |= FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
> +	}
> +
>  	return want_iref;
>  }
>  
> @@ -298,22 +321,30 @@ static void *fsnotify_recalc_mask_clear_iref(struct fsnotify_mark_connector *con
>  	return fsnotify_update_iref(conn, want_iref);
>  }
>  
> -static bool fsnotify_conn_watches_children(
> +/*
> + * Update children dentry PARENT_WATCHED flags if the connector started
> + * watching children since the last update.  When parent stops watching, we
> + * clear false positive PARENT_WATCHED flags lazily in __fsnotify_parent().
> + *
> + * The caller must make sure connector and connector->obj cannot disappear
> + * under us.  This is achieved by holding mark->group->mark_mutex for a
> + * mark on this list.  mark->lock must not be held by the caller.
> + */
> +void fsnotify_conn_set_children_dentry_flags(
>  					struct fsnotify_mark_connector *conn)
>  {
> -	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
> -		return false;
> -
> -	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
> -}
> +	bool update_children;
>  
> -static void fsnotify_conn_set_children_dentry_flags(
> -					struct fsnotify_mark_connector *conn)
> -{
> -	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
> +	if (!conn || conn->type != FSNOTIFY_OBJ_TYPE_INODE)
>  		return;
>  
> -	fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
> +	spin_lock(&conn->lock);
> +	update_children = conn->flags & FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
> +	conn->flags &= ~FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
> +	spin_unlock(&conn->lock);
> +
> +	if (update_children)
> +		fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
>  }
>  
>  /*
> @@ -321,26 +352,33 @@ static void fsnotify_conn_set_children_dentry_flags(
>   * connector and connector->obj cannot disappear under us.  Callers achieve
>   * this by holding a mark->lock or mark->group->mark_mutex for a mark on this
>   * list.
> + *
> + * Callers that may sleep should use fsnotify_recalc_mask_and_update_children()
> + * or call fsnotify_conn_set_children_dentry_flags() after dropping mark->lock.
>   */
>  void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  {
> -	bool update_children;
> -
>  	if (!conn)
>  		return;
>  
>  	spin_lock(&conn->lock);
> -	update_children = !fsnotify_conn_watches_children(conn);
>  	fsnotify_recalc_mask_set_iref(conn);
> -	update_children &= fsnotify_conn_watches_children(conn);
>  	spin_unlock(&conn->lock);
> -	/*
> -	 * Set children's PARENT_WATCHED flags only if parent started watching.
> -	 * When parent stops watching, we clear false positive PARENT_WATCHED
> -	 * flags lazily in __fsnotify_parent().
> -	 */
> -	if (update_children)
> -		fsnotify_conn_set_children_dentry_flags(conn);
> +}
> +
> +/*
> + * Recalculate mask and update children dentry PARENT_WATCHED flags if the
> + * connector started watching children.
> + *
> + * The caller must make sure connector and connector->obj cannot disappear
> + * under us.  This is achieved by holding mark->group->mark_mutex for a
> + * mark on this list.  mark->lock must not be held by the caller.
> + */
> +void fsnotify_recalc_mask_and_update_children(
> +					struct fsnotify_mark_connector *conn)
> +{
> +	fsnotify_recalc_mask(conn);
> +	fsnotify_conn_set_children_dentry_flags(conn);
>  }
>  
>  /**
> @@ -368,7 +406,7 @@ void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear)
>  	spin_unlock(&mark->lock);
>  
>  	if (recalc)
> -		fsnotify_recalc_mask(mark->connector);
> +		fsnotify_recalc_mask_and_update_children(mark->connector);
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_modify_mark_mask);
>  
> @@ -1007,7 +1045,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
>  	if (ret)
>  		goto err;
>  
> -	fsnotify_recalc_mask(mark->connector);
> +	fsnotify_recalc_mask_and_update_children(mark->connector);
>  
>  	return ret;
>  err:
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index faf21564380d9..052d8674ad896 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -567,6 +567,7 @@ struct fsnotify_mark_connector {
>  #define FSNOTIFY_CONN_FLAG_IS_WATCHED	0x01
>  #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
>  #define FSNOTIFY_CONN_FLAG_DESTROYING	0x04
> +#define FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN	0x08
>  	unsigned short flags;	/* flags [lock] */
>  	union {
>  		/* Object pointer [lock] */
> @@ -888,6 +889,11 @@ static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
>  extern __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn);
>  /* Calculate mask of events for a list of marks */
>  extern void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn);
> +/* Recalculate mask and update children dentry flags if needed */
> +extern void fsnotify_recalc_mask_and_update_children(
> +					struct fsnotify_mark_connector *conn);
> +extern void fsnotify_conn_set_children_dentry_flags(
> +					struct fsnotify_mark_connector *conn);
>  extern void fsnotify_init_mark(struct fsnotify_mark *mark,
>  			       struct fsnotify_group *group);
>  /* Find mark belonging to given group in the list of marks */
> -- 
> 2.56.1
> 

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
