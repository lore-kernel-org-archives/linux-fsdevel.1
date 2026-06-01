Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F838B12D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308379; cv=none; b=ra6RuOx9RPR98R08PVbuZYE4mD5tB7x/nPg87bOxnjNlSdGnLPKQ1s6hy1ibzGXByLsbFnGvNDZBT6/N6MqEwH/l/eCQ1zNjb4NApTV0u9WgxkfVFqo9/tCC0JTfSi/56iZaY8NSbvj0wt9AIRr/WuqxNaDqegODh7S/sp3cb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308379; c=relaxed/simple;
	bh=tnP6282aQ7IG5rTs04ELrhipqwSgWpXjQW7cHfAS6cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDnjmgOpa2n+ZZnE9cJ8/GOAHn5+GMbL11upD0bVcwL6ruK6JsfWFytFpp/myZA95k1uAjSs/9x85gM2yuXBxys+vAFo9ryNNo0rHewCIfD+YAqqN55E6bW9tRKBOZ6VqS57geJC0cHV18wrz7ZM0SksxRhTBH9JDpB87edCpmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OQpszQ7Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q3idjIhl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OQpszQ7Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q3idjIhl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OQpszQ7Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q3idjIhl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OQpszQ7Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q3idjIhl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AC7D67C39;
	Mon,  1 Jun 2026 10:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780308369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SV0Sd/aUfkOiLR6E2uJ2EltBg6cZLpwXqAqEceXid4=;
	b=OQpszQ7ZF6LIcvddC8xm3twVGMgQ8l2qqcX2ft2Zs6NC1N4aAwxdiUxTtRJWql0FMQbt8J
	SbwAgCQfGZtLvS988DTP2T1RkPna347AzTavlHxImlhjfdfeoC3sLuTNxqf2s6JTPQB45M
	ZZbdzmQk9JN5ebRz/E6REriY9PQPKo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780308369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SV0Sd/aUfkOiLR6E2uJ2EltBg6cZLpwXqAqEceXid4=;
	b=Q3idjIhlpjIWcxdwm1ymatyx0kGHqZ01arPs1BuUKySekZxn4R5oRYlQ96YLI0Py3U77uj
	p3Gl3otZVQBEqfBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OQpszQ7Z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Q3idjIhl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780308369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SV0Sd/aUfkOiLR6E2uJ2EltBg6cZLpwXqAqEceXid4=;
	b=OQpszQ7ZF6LIcvddC8xm3twVGMgQ8l2qqcX2ft2Zs6NC1N4aAwxdiUxTtRJWql0FMQbt8J
	SbwAgCQfGZtLvS988DTP2T1RkPna347AzTavlHxImlhjfdfeoC3sLuTNxqf2s6JTPQB45M
	ZZbdzmQk9JN5ebRz/E6REriY9PQPKo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780308369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SV0Sd/aUfkOiLR6E2uJ2EltBg6cZLpwXqAqEceXid4=;
	b=Q3idjIhlpjIWcxdwm1ymatyx0kGHqZ01arPs1BuUKySekZxn4R5oRYlQ96YLI0Py3U77uj
	p3Gl3otZVQBEqfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F9F5779A7;
	Mon,  1 Jun 2026 10:06:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qlM2G5FZHWoWdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jun 2026 10:06:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 07D8DA0EBE; Mon, 01 Jun 2026 12:06:01 +0200 (CEST)
Date: Mon, 1 Jun 2026 12:06:01 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] fanotify: gate fs events checks in
 fanotify_mark() by group type
Message-ID: <u4wnn46chae6helb5yuqw2eqjxux6plmyffxilisxnuiuyhyyh@mq7rahg3g5fq>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-8-amir73il@gmail.com>
 <ulal5iiolonkeccun5lyzkuf73odidgbkmabzupbwtawwjhhlz@tneaqqtlody6>
 <CAOQ4uxjO+Q_Z0OF4XquO7o4GVF2b3akRDrLYadtUNpZzi8nEsQ@mail.gmail.com>
 <cz26vtfw5xq3hi7lv6guec75untdqrtqx5violro7ymefxduqy@ajieh3qai7xr>
 <CAOQ4uxi93n7beP20Lt865hGotZA-=2Kvuc=rMA+H+gwbQaWOAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi93n7beP20Lt865hGotZA-=2Kvuc=rMA+H+gwbQaWOAg@mail.gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7AC7D67C39
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu 28-05-26 19:52:43, Amir Goldstein wrote:
> On Thu, May 28, 2026 at 1:05 PM Jan Kara <jack@suse.cz> wrote:
> > On Mon 25-05-26 14:52:46, Amir Goldstein wrote:
> > > On Mon, May 25, 2026 at 1:28 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Fri 24-04-26 19:05:00, Amir Goldstein wrote:
> > > > > fanotify_mark() has plenty of checks on the event mask.
> > > > > The event mask bits that correspond to filesystem watchers are only
> > > > > meaningful in the context of filesystem group type.
> > > > >
> > > > > Hence, before checking if event is a specific event (e.g. FAN_FS_ERROR)
> > > > > need to check that the group type as well (e.g. filesystem).
> > > > >
> > > > > Add helpers fanotify_test_{fs,ns}_watcher_event() and use them instead
> > > > > of checking the event mask directly.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > I was looking into this and thinking about it for some time and I have one
> > > > brainstorming suggestion:
> > > >
> > > > > +static inline bool fanotify_test_fs_watcher_event(struct fsnotify_group *group,
> > > > > +                                               u32 mask, u32 test_mask)
> > > > > +{
> > > > > +     return fsnotify_is_fs_watcher(group) && (mask & test_mask);
> > > > > +}
> > > > > +
> > > > > +static inline bool fanotify_test_ns_watcher_event(struct fsnotify_group *group,
> > > > > +                                               u32 mask, u32 test_mask)
> > > > > +{
> > > > > +     return fsnotify_is_ns_watcher(group) && (mask & test_mask);
> > > > > +}
> > > >
> > > > These helpers look a bit cumbersome (having to manually select the right
> > > > one, there's no safety if you accidentally pick the wrong helper, you need
> > > > to pass the group as well, ...). So I was thinking about the following: In
> > > > fanotify uAPI the mask is actually 64-bit. What if we carve out some bits
> > > > from the upper word (8?) and store the group type there? Either we can do
> > > > this type-encoding only internaly once we receive the mask from userspace
> > > > or we could even have the encoding in uAPI constants as well - which would
> > > > provide additional uAPI constant type safety (we'd have to special-case
> > > > FAN_MNT_ATTACH & FAN_MNT_DETACH in that case but that should be doable,
> > > > since they are not widely used yet we could maybe even eventually deprecate
> > > > the old values).
> > > >
> > > > Anyway, once we have the type encoded in the 64-bit mask we can easily
> > > > compare, mask, combine, ... these with some helper functions without having
> > > > to check the group all the time and having to select different helper
> > > > function based on event type. We are not very consistent with passing
> > > > 64-bit mask everywhere since the fsnotify core has only 32-bit mask and so
> > > > far we use only the lower 32-bits in fanotify as well so that would need to
> > > > be fixed.  Also once we store the mask into the mark, it would be squashed
> > > > down to 32 bits but I think that's fine.
> > > >
> > > > What do you think about it? Do you find this worth it? What's your opinion
> > > > on having the type encoded already in uAPI constants?
> > >
> > > My opinion is that I had already started playing with that, see:
> > >
> > > https://github.com/amir73il/linux/commits/fanotify_event_type-wip
> >
> > Cool :)
> >
> > > --- a/include/linux/fsnotify_backend.h
> > > +++ b/include/linux/fsnotify_backend.h
> > > @@ -78,8 +78,10 @@
> > >
> > >  /* 64bit kernel internal event hint flags */
> > >  #define FS_EVENT_IS_PERM       BIT_ULL(33)     /* Wait for user response */
> > > +#define FS_EVENT_ON_NS         BIT_ULL(34)     /* For namespace watchers */
> > >
> > >  #define FS_PERM_EVENT(mask)    (FS_EVENT_IS_PERM | (mask))
> > > +#define FS_NS_EVENT(mask)      (FS_EVENT_ON_NS | (mask))
> >
> > I'd prefer we have couple bits reserved like:
> >
> > #define FSNOTIFY_EVENT_TYPE_BITS 8
> > #define FSNOTIFY_EVENT_TYPE_MASK (~0ULL << (64 - FSNOTIFY_EVENT_TYPE_BITS))
> >
> > And then allocate different types (FILESYSTEM == 0, NAMESPACE == 1, ...)
> > from this in an enum fashion. This is much more efficient on bit space than
> > just event flags.
> 
> Wow, 256 types. What a rich future ;)

:) It may be a bit too much but OTOH in those 64 bits I think we can spare
8 bits...

> Note that I also considered flags (FS_EVENT_IS_PERM) as part of the
> event definition - those would control things that are common to all types.

Hum, but FS_EVENT_IS_PERM is kernel internal flag and I really want it to
stay that way. If needed we can move it out of the mask completely...

> > > @@ -136,7 +138,7 @@
> > >  #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
> > >
> > >  /* Kernel internal 64bit flags */
> > > -#define ALL_FSNOTIFY_KERN_FLAGS  (FS_EVENT_IS_PERM)
> > > +#define ALL_FSNOTIFY_KERN_FLAGS  (FS_EVENT_IS_PERM | FS_EVENT_ON_NS)
> > >
> > >  #define ALL_FSNOTIFY_BITS   (ALL_FSNOTIFY_KERN_FLAGS | \
> > >                              ALL_FSNOTIFY_EVENTS | \
> > >
> > > ---
> > >
> > > TBH, I don't remember whether I was discouraged for some reason
> > > or if I had started to question the value of this
> > > or if I thought it was better to send the simpler version first.
> > >
> > > Anyway, I am fond of this approach so I will give it a try.
> >
> > Thanks!
> >
> > > I went back and forth about exporting this explicitly in uAPI and
> > > require that all fanotify_mark() calls on namespace objects
> > > (add,remove,flush) always carry the explicit FS_EVENT_ON_NS
> > > flag and/or in the outgoing mask.
> > >
> > > or that they are defined as:
> > > #define FAN_NS_CREATE (__FAN_NS_CREATE | FS_EVENT_ON_NS)
> > >
> > > Also if we do that, we need to think of the least ugly way to handle
> > > FAN_MNT_ATTACH & FAN_MNT_DETACH.
> >
> > These are good questions. After thinking about this I think the most
> > convenient would be if:
> >
> > * Type was already included in the defined event constants
> > * Type was included in the reported outgoing events
> >
> > That way you can combine events constants like EVENT1 | EVENT2 | EVENT3 and
> > get a valid input for fanotify_mark() or a valid mask. For checking you'd
> > have to do received_mask & ~FSNOTIFY_EVENT_TYPE_MASK & (EVENT1 | EVENT2) to
> > check whether any of these events was received which is bearable, mask ==
> > EVENT1 would keep working.
> 
> When you write "you'd have to do..." meaning all the applications need to be
> educated about this and we need to expose FAN_EVENT_TYPE_MASK
> in uAPI.

Yes, all apps wanting to use other than the standard filesystem events with
type == 0 will need to be using this new way of checking.

> I guess we should provide
> 
> #define FAN_EVENT_MATCH(event_meta, event_set)

Yes, we could do that I guess.

> The risk of a programmer doing if (event->mask & EVENT1) exists,
> but not much more we can do about it.

Yep + documentation in the manpage obviously.

> > I've checked and FAN_MNT_ATTACH / FAN_MNT_DETACH already got used in a
> > couple of places (stress-ng, util-linux, ...) so the only realistic option
> > I see at this point is to define FAN_MNTNS_ATTACH, FAN_MNTNS_DETACH with
> > proper type info included and automatically morph FAN_MNT_ATTACH and
> > FAN_MNT_DETACH into FAN_MNTNS_ATTACH and FAN_MNTNS_DETACH, respectively in
> > fanotify_mark(). When morphing we'd have to set some group flag to disable
> > reporting of type in outgoing events as well and make sure FAN_MNT_ATTACH
> > and FAN_MNT_DETACH cannot be mixed with any other properly typed events in
> > one group.
> 
> Seems manageable.
> 
> > I also considered an option to explicitly define a group flag that
> > userspace can set to enable verification of types in fanotify_mark() and
> > reporting them in outgoing event mask. This would be an option as well but
> > so far it seemed somewhat more confusing than what I suggested above (where
> > I expect people to transition to properly typed events faster because
> > otherwise their functionality will be restricted).
> >
> > Of course there's still the question whether we want to expose types in the
> > uAPI at all but I'm slowly leaning towards yes to make it harder to use the
> > API wrongly.
> 
> I see no value in opt-in for verification of types in fanotify_mark().
> opt-in or -out for the outgoing mask - maybe, especially since we need this
> internal flag anyway for FAN_MNT_*, but I am also leaning against it.

OK, good.

> Anyway, with no end users to nag me and summer vacation getting close
> it may take me some time to post v3, so if you think of any new ideas
> there is still time to bring them up.

Sure :) Thanks for working on this!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
