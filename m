Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1162F7EE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703519; cv=none; b=JNYnp+Qgc7l4lJuGNjOiyeHWI3sf/+bl5ljIoe5lkxkfQs30WWjtU7MVdYpNq8pBiRmBWpjFtD3UdWW0qiPdd3ZtEySURGr9qd5ChPWYHEEib9y1itivqTrFVkpYUfMB7hWaaFYGOf6wiLcPOQ/sAYdLnRrKuRVH8VBzxKvjJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703519; c=relaxed/simple;
	bh=buRbykSgUgyNb0r5exBi8pX4DEffa5mGGoFU2f07ggU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxAGrMZAuzl9e6gFvMtFNoqGa5BaClt6GQ7ATKp8gsyNokiPu8yQ8PagZzOs8HmcBS7sdpvpmvYZM4cuNetSEYGYmEVIn15NTzTDOsXsNmmD8QgLpXH9RNU5dlwR4lrUHuX5CeiSWWHC/BP6xQp6IFSDfEvytdzJXvdlzMhaN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KMAUfRqB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=buLmxyhk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KMAUfRqB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=buLmxyhk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KMAUfRqB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="buLmxyhk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KMAUfRqB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="buLmxyhk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D4016B041;
	Mon, 25 May 2026 10:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779703516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUEiK6uTrRxaAG74FyiomvpK1M3Pvg5PKLh9THfc7HE=;
	b=KMAUfRqBAEEt6SeodMBgl9dMPE9QqBBgpa9zl9uZDC61IxVHmMiiNVKlMLcLu+L0dEmE+U
	9u6jPwT09T4WzBgwrAwE//hhJP5PCdCXH+Dpx6HxfhAcfKqxx8GV6x64wyLz8aMdCtCAAk
	KozYRk0G7MNYiHoG51qpYyoMJC16Cx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779703516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUEiK6uTrRxaAG74FyiomvpK1M3Pvg5PKLh9THfc7HE=;
	b=buLmxyhkJtYb7OCQDdGOI1W6nnu75Fj3NnMFFY/Nh+uAgf27EFM+J+OHMjw1Rx686v9oDH
	CVdLbwkA/KQcf+Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KMAUfRqB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=buLmxyhk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779703516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUEiK6uTrRxaAG74FyiomvpK1M3Pvg5PKLh9THfc7HE=;
	b=KMAUfRqBAEEt6SeodMBgl9dMPE9QqBBgpa9zl9uZDC61IxVHmMiiNVKlMLcLu+L0dEmE+U
	9u6jPwT09T4WzBgwrAwE//hhJP5PCdCXH+Dpx6HxfhAcfKqxx8GV6x64wyLz8aMdCtCAAk
	KozYRk0G7MNYiHoG51qpYyoMJC16Cx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779703516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUEiK6uTrRxaAG74FyiomvpK1M3Pvg5PKLh9THfc7HE=;
	b=buLmxyhkJtYb7OCQDdGOI1W6nnu75Fj3NnMFFY/Nh+uAgf27EFM+J+OHMjw1Rx686v9oDH
	CVdLbwkA/KQcf+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93FD959BB1;
	Mon, 25 May 2026 10:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s8YeJNweFGp3LwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 10:05:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3DB38A08D7; Mon, 25 May 2026 12:05:12 +0200 (CEST)
Date: Mon, 25 May 2026 12:05:12 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] fanotify: test event->type instead of event
 mask when possible
Message-ID: <2ao6rhm3oa3lz53wvlgzw3xi7wxhaifffl5nmglqrli66myhyy@jx3tplb6gqs6>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-5-amir73il@gmail.com>
 <a4kh65jinwm2tyk57xhmqemmirbxr756cj3rkjlatlnsef335h@nex47pw2wvt4>
 <CAOQ4uxgj+3pzzaFpBFaJ6FuFPe2bEskixESKX5kqR6KdmRvABg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgj+3pzzaFpBFaJ6FuFPe2bEskixESKX5kqR6KdmRvABg@mail.gmail.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 9D4016B041
X-Rspamd-Action: no action
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
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	internal_greylist_whitelist(0.00)[2a07:de40:b281:104:10:150:64:97];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Thu 21-05-26 19:10:34, Amir Goldstein wrote:
> On Thu, May 21, 2026 at 6:34 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 24-04-26 19:04:57, Amir Goldstein wrote:
> > > The fanotify_event already has a type field, so tests like
> > > fanotify_is_mnt_event() should check the type and not the mask.
> > >
> > > In fanotify_alloc_event() determine the mnt and fs_error event
> > > types by data_type, which uniquely identifies those events.
> > >
> > > The helper for classifying an fs permission event is renamed to
> > > fanotify_is_fs_perm_event() and takes the group argument to verify
> > > that this is a filesystem group type.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ...
> > > @@ -845,11 +845,10 @@ static struct fanotify_event *fanotify_alloc_event(
> > >       /* Whoever is interested in the event, pays for the allocation. */
> > >       old_memcg = set_active_memcg(group->memcg);
> > >
> > > -     if (fanotify_is_perm_event(mask)) {
> > > +     if (fanotify_is_fs_perm_event(group, mask)) {
> >
> > Instead of creating this fanotify_is_fs_perm_event() helper func along with
> > similar fanotify_is_perm_event(), I'd just opencode the mask checks in the
> > two places where we don't have the event yet. Things will be IMHO more
> > obvious that way. BTW I don't think we need anything besides the mask
> > check. fanotify_group_event_mask() check should have taken care of the
> > rest...
> >
> 
> Not sure about this.
> They have to be gated with fsnotify_is_fs_watcher(), but anyway

Well, the two places where the mask checks happen are already sure we have
a filesystem event watching group (i.e., they have effectively checked
fsnotify_is_fs_watcher() earlier).

> a later patch introduces fanotify_test_fs_watcher_event() helper
> and then it will be easy to drop fanotify_is_fs_perm_event() and
> open code it as
> fanotify_test_fs_watcher_event(group, mask,
>                                               FANOTIFY_PERM_EVENTS);
> 
> Not sure if that end results addresses your concern.

But yes, if we can get rid of this helper later, that addresses my concern
as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
