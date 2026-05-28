Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527443DEAFA
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966334; cv=none; b=Qi6ufwPE9oFvK7He9Wm5q6sDXtgbJigG6Dn8LzxDMzrq6R9iabw4BjhaNe2qwVJRa4KGMlO1PfQYQcC6hJcE0q7imN71xOWirUj5hFnxHXy7oaVbpd9kP8QsfawldLHU5ey9okYBK6HTANEu6P5hedss+TXvVpobXKL97ntOrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966334; c=relaxed/simple;
	bh=eLrCalg9WnvlDaGVnZUkVI4Jtv8YULEhUp3wydw136E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cghvu+aKUOws9LiAE40x9oN0yYnWvLAsAvdZALmmSs9Q1gMo3o8Nu21bIgLlyLBTRLQ/falAwZfv/wQcgNHUtDQj453XCo+Jh4Qdg7XEWRxiQdqXAYS7I3cKX8Zxi1rTyuNhii0lC8XbKn4cbRl98/wEtodsu6mvNgO/oTMTOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=li5rh6Hn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zLyB6hcu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=li5rh6Hn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zLyB6hcu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="li5rh6Hn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zLyB6hcu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="li5rh6Hn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zLyB6hcu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 354D266E71;
	Thu, 28 May 2026 11:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779966330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/XjWxOPXbnMeidbsiYQrQhVk14VwN+KxoiAOni36Ss=;
	b=li5rh6Hnhyzvp1UM3vC9d0EZezeTRW9NM2OOgmf1oPFgvvbs/dYkKfpjvnFZsrkBvW9Gjr
	8KlQppjP1mFDTaZbDdhgJM+H1+EWNGpuEj8cOln8M+c9tM9HcxziC8XQGGe8n1Pj4VURT3
	vGTBLtTynJNQLkhaA502iY5jzQMuhpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779966330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/XjWxOPXbnMeidbsiYQrQhVk14VwN+KxoiAOni36Ss=;
	b=zLyB6hcuOETbrpc3BciselW9IRyZMU8LwqAJsOciwT9aFGIc4mMSdLzy5THR2Da+bUDwp0
	4fSGyRq1tKgeIGBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=li5rh6Hn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zLyB6hcu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779966330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/XjWxOPXbnMeidbsiYQrQhVk14VwN+KxoiAOni36Ss=;
	b=li5rh6Hnhyzvp1UM3vC9d0EZezeTRW9NM2OOgmf1oPFgvvbs/dYkKfpjvnFZsrkBvW9Gjr
	8KlQppjP1mFDTaZbDdhgJM+H1+EWNGpuEj8cOln8M+c9tM9HcxziC8XQGGe8n1Pj4VURT3
	vGTBLtTynJNQLkhaA502iY5jzQMuhpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779966330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/XjWxOPXbnMeidbsiYQrQhVk14VwN+KxoiAOni36Ss=;
	b=zLyB6hcuOETbrpc3BciselW9IRyZMU8LwqAJsOciwT9aFGIc4mMSdLzy5THR2Da+bUDwp0
	4fSGyRq1tKgeIGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23E725AD58;
	Thu, 28 May 2026 11:05:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GBhUCHohGGqeKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 28 May 2026 11:05:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B3BEBA0905; Thu, 28 May 2026 13:05:29 +0200 (CEST)
Date: Thu, 28 May 2026 13:05:29 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] fanotify: gate fs events checks in
 fanotify_mark() by group type
Message-ID: <cz26vtfw5xq3hi7lv6guec75untdqrtqx5violro7ymefxduqy@ajieh3qai7xr>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-8-amir73il@gmail.com>
 <ulal5iiolonkeccun5lyzkuf73odidgbkmabzupbwtawwjhhlz@tneaqqtlody6>
 <CAOQ4uxjO+Q_Z0OF4XquO7o4GVF2b3akRDrLYadtUNpZzi8nEsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjO+Q_Z0OF4XquO7o4GVF2b3akRDrLYadtUNpZzi8nEsQ@mail.gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 354D266E71
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]

On Mon 25-05-26 14:52:46, Amir Goldstein wrote:
> On Mon, May 25, 2026 at 1:28 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 24-04-26 19:05:00, Amir Goldstein wrote:
> > > fanotify_mark() has plenty of checks on the event mask.
> > > The event mask bits that correspond to filesystem watchers are only
> > > meaningful in the context of filesystem group type.
> > >
> > > Hence, before checking if event is a specific event (e.g. FAN_FS_ERROR)
> > > need to check that the group type as well (e.g. filesystem).
> > >
> > > Add helpers fanotify_test_{fs,ns}_watcher_event() and use them instead
> > > of checking the event mask directly.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > I was looking into this and thinking about it for some time and I have one
> > brainstorming suggestion:
> >
> > > +static inline bool fanotify_test_fs_watcher_event(struct fsnotify_group *group,
> > > +                                               u32 mask, u32 test_mask)
> > > +{
> > > +     return fsnotify_is_fs_watcher(group) && (mask & test_mask);
> > > +}
> > > +
> > > +static inline bool fanotify_test_ns_watcher_event(struct fsnotify_group *group,
> > > +                                               u32 mask, u32 test_mask)
> > > +{
> > > +     return fsnotify_is_ns_watcher(group) && (mask & test_mask);
> > > +}
> >
> > These helpers look a bit cumbersome (having to manually select the right
> > one, there's no safety if you accidentally pick the wrong helper, you need
> > to pass the group as well, ...). So I was thinking about the following: In
> > fanotify uAPI the mask is actually 64-bit. What if we carve out some bits
> > from the upper word (8?) and store the group type there? Either we can do
> > this type-encoding only internaly once we receive the mask from userspace
> > or we could even have the encoding in uAPI constants as well - which would
> > provide additional uAPI constant type safety (we'd have to special-case
> > FAN_MNT_ATTACH & FAN_MNT_DETACH in that case but that should be doable,
> > since they are not widely used yet we could maybe even eventually deprecate
> > the old values).
> >
> > Anyway, once we have the type encoded in the 64-bit mask we can easily
> > compare, mask, combine, ... these with some helper functions without having
> > to check the group all the time and having to select different helper
> > function based on event type. We are not very consistent with passing
> > 64-bit mask everywhere since the fsnotify core has only 32-bit mask and so
> > far we use only the lower 32-bits in fanotify as well so that would need to
> > be fixed.  Also once we store the mask into the mark, it would be squashed
> > down to 32 bits but I think that's fine.
> >
> > What do you think about it? Do you find this worth it? What's your opinion
> > on having the type encoded already in uAPI constants?
> 
> My opinion is that I had already started playing with that, see:
> 
> https://github.com/amir73il/linux/commits/fanotify_event_type-wip

Cool :)

> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -78,8 +78,10 @@
> 
>  /* 64bit kernel internal event hint flags */
>  #define FS_EVENT_IS_PERM       BIT_ULL(33)     /* Wait for user response */
> +#define FS_EVENT_ON_NS         BIT_ULL(34)     /* For namespace watchers */
> 
>  #define FS_PERM_EVENT(mask)    (FS_EVENT_IS_PERM | (mask))
> +#define FS_NS_EVENT(mask)      (FS_EVENT_ON_NS | (mask))

I'd prefer we have couple bits reserved like:

#define FSNOTIFY_EVENT_TYPE_BITS 8
#define FSNOTIFY_EVENT_TYPE_MASK (~0ULL << (64 - FSNOTIFY_EVENT_TYPE_BITS))

And then allocate different types (FILESYSTEM == 0, NAMESPACE == 1, ...)
from this in an enum fashion. This is much more efficient on bit space than
just event flags.

> @@ -136,7 +138,7 @@
>  #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
> 
>  /* Kernel internal 64bit flags */
> -#define ALL_FSNOTIFY_KERN_FLAGS  (FS_EVENT_IS_PERM)
> +#define ALL_FSNOTIFY_KERN_FLAGS  (FS_EVENT_IS_PERM | FS_EVENT_ON_NS)
> 
>  #define ALL_FSNOTIFY_BITS   (ALL_FSNOTIFY_KERN_FLAGS | \
>                              ALL_FSNOTIFY_EVENTS | \
> 
> ---
> 
> TBH, I don't remember whether I was discouraged for some reason
> or if I had started to question the value of this
> or if I thought it was better to send the simpler version first.
> 
> Anyway, I am fond of this approach so I will give it a try.

Thanks!

> I went back and forth about exporting this explicitly in uAPI and
> require that all fanotify_mark() calls on namespace objects
> (add,remove,flush) always carry the explicit FS_EVENT_ON_NS
> flag and/or in the outgoing mask.
> 
> or that they are defined as:
> #define FAN_NS_CREATE (__FAN_NS_CREATE | FS_EVENT_ON_NS)
>
> Also if we do that, we need to think of the least ugly way to handle
> FAN_MNT_ATTACH & FAN_MNT_DETACH.

These are good questions. After thinking about this I think the most
convenient would be if:

* Type was already included in the defined event constants
* Type was included in the reported outgoing events

That way you can combine events constants like EVENT1 | EVENT2 | EVENT3 and
get a valid input for fanotify_mark() or a valid mask. For checking you'd
have to do received_mask & ~FSNOTIFY_EVENT_TYPE_MASK & (EVENT1 | EVENT2) to
check whether any of these events was received which is bearable, mask ==
EVENT1 would keep working.

I've checked and FAN_MNT_ATTACH / FAN_MNT_DETACH already got used in a
couple of places (stress-ng, util-linux, ...) so the only realistic option
I see at this point is to define FAN_MNTNS_ATTACH, FAN_MNTNS_DETACH with
proper type info included and automatically morph FAN_MNT_ATTACH and
FAN_MNT_DETACH into FAN_MNTNS_ATTACH and FAN_MNTNS_DETACH, respectively in
fanotify_mark(). When morphing we'd have to set some group flag to disable
reporting of type in outgoing events as well and make sure FAN_MNT_ATTACH
and FAN_MNT_DETACH cannot be mixed with any other properly typed events in
one group.

I also considered an option to explicitly define a group flag that
userspace can set to enable verification of types in fanotify_mark() and
reporting them in outgoing event mask. This would be an option as well but
so far it seemed somewhat more confusing than what I suggested above (where
I expect people to transition to properly typed events faster because
otherwise their functionality will be restricted).

Of course there's still the question whether we want to expose types in the
uAPI at all but I'm slowly leaning towards yes to make it harder to use the
API wrongly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
