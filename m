Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2DC18B0F
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703265; cv=none; b=L7FMQDe6DT/SVK6l2YPKet/2z0qLNNeLxCRJW9plhQqVLnVfJ+zI+qEkCTXCrLsze2571LiIk/XKL2nlNgA4lU0I19vSfqP3gmZo0knxGXRkKQ5ApTWGF44ePMCZblJwLmyWYCy1vbNBjMlK0NaG/7nDVGz32XLeesCLWRwUngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703265; c=relaxed/simple;
	bh=ZUvWZjz5CQuQujvT8FIPKubMr0V0wuvDoVE+bQrAtUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwLv6dtu+5YjBNgkWtUlKRWtX98ZFA8LtSbuQOkn9OUukvFKsmmgB3FwjzkFH9l07PQCnzxL3w/ib6xUWj2DE9AMG6hcVN6iHipyYolFN42AjL+KYht1AL1D0El2tUVUy9g2Fw8rmjXiAW6E0XPNF0BG9hUsechMpnhFbzf/lR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G08D1TQ4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lXo+MxG/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G08D1TQ4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lXo+MxG/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G08D1TQ4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lXo+MxG/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G08D1TQ4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lXo+MxG/"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4D966B795;
	Mon, 25 May 2026 10:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779703261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZQVzDWo4lTpKfj3HS/QxhpWhcjOpgvSH+H2KZhssF0=;
	b=G08D1TQ4dncnbuI7syr8Z/eiHCB4Hcmw196PdsEaeCDjywjrgORlRSsXIGdAZicM0B/7wp
	EKSfz23yMuKSMqfaZJw1b/au2Gm1gt3DTEINk+1xUmsT5IXEcup4toHhL0lrqTGzS3x0OU
	GRyW4/MMU5+pjZdz/MbmRo5sfR7p1B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779703261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZQVzDWo4lTpKfj3HS/QxhpWhcjOpgvSH+H2KZhssF0=;
	b=lXo+MxG/W8gZeXutxZXpRw3Hz7Vz7QHNaeLNh7S+K8rYytVN4ufpHIDDsKynqNbHT02sg6
	ylRRx+qcqNZ57yDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779703261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZQVzDWo4lTpKfj3HS/QxhpWhcjOpgvSH+H2KZhssF0=;
	b=G08D1TQ4dncnbuI7syr8Z/eiHCB4Hcmw196PdsEaeCDjywjrgORlRSsXIGdAZicM0B/7wp
	EKSfz23yMuKSMqfaZJw1b/au2Gm1gt3DTEINk+1xUmsT5IXEcup4toHhL0lrqTGzS3x0OU
	GRyW4/MMU5+pjZdz/MbmRo5sfR7p1B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779703261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZQVzDWo4lTpKfj3HS/QxhpWhcjOpgvSH+H2KZhssF0=;
	b=lXo+MxG/W8gZeXutxZXpRw3Hz7Vz7QHNaeLNh7S+K8rYytVN4ufpHIDDsKynqNbHT02sg6
	ylRRx+qcqNZ57yDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF53A59BAC;
	Mon, 25 May 2026 10:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +0/JKt0dFGrNKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 10:01:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 58898A08D7; Mon, 25 May 2026 12:00:57 +0200 (CEST)
Date: Mon, 25 May 2026 12:00:57 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] fsnotify: separate the events bitmask macros by
 group type
Message-ID: <hmbmwxwos5bbel4pkytgm4esttamnd4iiojf42njphllnag2lm@5oaom2vnxyiq>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-4-amir73il@gmail.com>
 <pnpqweynr6u4jtc67orwdqcelj4yo4c4ydeiw2td7777dzxl7j@xmo22qzv3yp4>
 <CAOQ4uxjcPa=DWwmnU3AK+qA_CGd+HP0h5rfA5FhrpdBTqxprxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjcPa=DWwmnU3AK+qA_CGd+HP0h5rfA5FhrpdBTqxprxg@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 21-05-26 19:00:38, Amir Goldstein wrote:
> On Thu, May 21, 2026 at 6:15 PM Jan Kara <jack@suse.cz> wrote:
> > > @@ -848,7 +861,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > >       metadata.metadata_len = FAN_EVENT_METADATA_LEN;
> > >       metadata.vers = FANOTIFY_METADATA_VERSION;
> > >       metadata.reserved = 0;
> > > -     metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
> > > +     metadata.mask = fanotify_event_mask(group, event);
> > >       metadata.pid = pid_vnr(event->pid);
> > >       /*
> > >        * For an unprivileged listener, event->pid can be used to identify the
> > > @@ -1881,6 +1894,35 @@ static int fanotify_events_supported(struct fsnotify_group *group,
> > >       return 0;
> > >  }
> > >
> > > +static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_type,
> > > +                                __u64 mask)
> > > +{
> > > +     u32 valid_mask = 0;
> > > +
> > > +     /*
> > > +      * Event bits for different group type may be overloaded but event
> > > +      * flags are common to all group types.
> > > +      */
> > > +     BUILD_BUG_ON(FANOTIFY_EVENTS_ON_FS & FANOTIFY_EVENT_FLAGS);
> > > +     BUILD_BUG_ON(FANOTIFY_EVENTS_ON_NS & FANOTIFY_EVENT_FLAGS);
> >
> > I'm a bit curious what's your rationale for this? It isn't like EVENT_FLAGS
> > can be sensibly used with namespace notifications, they are kind of fs
> > specific as well...
> >
> 
> The rationale is written in the cover letter.
> I should have mentioned it here:
> 
> "To simplify the implementation, the event flags (ON_CHILD, ISDIR)
> live in a shared space that cannot be overloaded by neither group types.
> This is not because ISDIR makes sense for ns watcher, just to reduce the
> number of gates in common code. ON_CHILD flag might be usable for ns
> watchers, not sure."

Sorry, I should have noticed that. I was reviewing the patches on-and-off
on a conference and some things were falling out of my context :).

> My rationale was not having to take care of gating or making sure that they
> are already gated with is_filesystem_watcher() in all the places in common
> fsnotify code that test those flags:
> 
> fsnotify_ignore_mask(), fsnotify_mask_applicable(),
> fsnotify_iter_select_report_types(), send_to_group()
> 
> Just a lot of pain and hard to maintain subtle code saving for giving up two
> bits - one of those bits may be usable to namespaces, which sounded like a
> good enough deal to me.
> 
> The reason that FAN_EVENT_ON_CHILD could be applicable to
> namepsace watchers is that namespaces are a tree so userns mark
> could be watching events on children namespaces and pidns mark
> could also be required to watch children pid namespaces or children
> processes (Christian has some ideas there).

I see. I agree the group type checks are a bit annoying and I'm still thinking
whether we cannot somehow make them nice :)

> > > +     switch (group->type) {
> > > +     case FSNOTIFY_GROUP_TYPE_FS:
> > > +             valid_mask = FANOTIFY_EVENTS_ON_FS | FANOTIFY_EVENT_FLAGS;
> > > +             if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
> > > +                     valid_mask &= ~FANOTIFY_PERM_EVENTS;
> > > +             break;
> > > +     case FSNOTIFY_GROUP_TYPE_NS:
> > > +             /* Only report mount events on mntns mark */
> > > +             if (mark_type == FAN_MARK_MNTNS &&
> > > +                 FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> > > +                     valid_mask = FANOTIFY_MOUNT_EVENTS;
> > > +             break;
> > > +     }
> >
> > Shouldn't this also check that the mark type matches the group type? The
> > condition you replace with this call did that...
> 
> Hmm not sure.
> See this check:
>         if (group->type != group_type ||
>             !fanotify_is_valid_mask(group, mark_type, mask))
>                 return -EINVAL;
> 
> group_type is determined earlier in the switch (mark_type) block.

Aha, right. Sorry for the noise.

> Because every mark type maps to one single group type,
> this makes more sense, but maybe a better choice of variable name
> for group_type is in order. mark_group_type?

Yeah, that might be a bit more understandable.

> > > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > > index b646a861a84c6..429ce614233ce 100644
> > > --- a/fs/notify/fsnotify.c
> > > +++ b/fs/notify/fsnotify.c
> > > @@ -149,7 +149,7 @@ static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
> > >       __u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
> > >                          READ_ONCE(inode->i_sb->s_fsnotify_mask);
> > >
> > > -     return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
> > > +     return mask & marks_mask & FSNOTIFY_EVENTS_ON_FS;
> > >  }
> >
> > With this change it becomes kind of obvious that fsnotify_object_watched()
> > is a misnomer after mntns events were added. And it is ok only because the
> > callers of this are really specific to fs events. Can you please fix the
> > name - perhaps to fsnotify_fs_object_watched()?
> 
> Sure, are you sure that you don't want it to be
> fsnotify_filesystem_object_watched() ;)

Maybe for consistency let's do that :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
