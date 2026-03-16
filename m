Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E83254A8
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679140; cv=none; b=ET3qMuKvvjHaHrxs1WJvhRvFA/hdKDTbX3k16AHb0jmCfyFoTDbsO/PFftc7rsJNefWnEbffPW+zDOTVGAlWqg1f1Kw8i6g9mi8SwNQPl88bODL2QiYpxziAVrJo1G7wYud+s3JlxNxW2mUz07f9UtK0lOI5z9wybWsMjVX1Aq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679140; c=relaxed/simple;
	bh=WsYK3MNzpUYKn7OMwOKxqcLcbGu5ZS3qhKpsP0OVoF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhSmkCZhELrpS2ZfXnl8XAXwqd6p/B1eh7aqVrLdfzWz9l7f5DDsBg6+wUzeixB9RwC6HkIxMGyftTDpB76S82WhHDTSeZ+PbwrQmtQXylxO8XoCWEcNqDFyrrHRJQvNiLtqTPEmxtw/Th1WEIcvGNlQUDCx+SiFSVbLO0vnqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TF8yNnec; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rz9P31Yy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TF8yNnec; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rz9P31Yy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TF8yNnec";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rz9P31Yy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TF8yNnec";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rz9P31Yy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57F474D337;
	Mon, 16 Mar 2026 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773679137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mvwZEBqJPDQpCzsh1jXlFuYvk28Pc2L5j4EScYTe1g=;
	b=TF8yNnecYld4zyK0mTxUBrBpy5Y8ZYBeT/doHEMK1gf++6Xs+uofGOW/BLjZcWW92DRMiu
	tXej6hWtBBI3I85fX0/pt8nn19ys52bAo3ajBw3nSALHtg9hOuJsnBHaYcm+Bmvnm3EO7w
	TgPcoZZM85O9Qx4hec3dTfqizkKSEyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773679137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mvwZEBqJPDQpCzsh1jXlFuYvk28Pc2L5j4EScYTe1g=;
	b=rz9P31YyOlHsndGfHmyq9geqd/+0mswx243O9oZ/2PINdh8p/AjcjNO2nuyevusNdczPy8
	cmXVligMyYxPcTCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773679137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mvwZEBqJPDQpCzsh1jXlFuYvk28Pc2L5j4EScYTe1g=;
	b=TF8yNnecYld4zyK0mTxUBrBpy5Y8ZYBeT/doHEMK1gf++6Xs+uofGOW/BLjZcWW92DRMiu
	tXej6hWtBBI3I85fX0/pt8nn19ys52bAo3ajBw3nSALHtg9hOuJsnBHaYcm+Bmvnm3EO7w
	TgPcoZZM85O9Qx4hec3dTfqizkKSEyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773679137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mvwZEBqJPDQpCzsh1jXlFuYvk28Pc2L5j4EScYTe1g=;
	b=rz9P31YyOlHsndGfHmyq9geqd/+0mswx243O9oZ/2PINdh8p/AjcjNO2nuyevusNdczPy8
	cmXVligMyYxPcTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D98E4273D;
	Mon, 16 Mar 2026 16:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id il8DDyEyuGleJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Mar 2026 16:38:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0512CA07C1; Mon, 16 Mar 2026 11:05:31 +0100 (CET)
Date: Mon, 16 Mar 2026 11:05:31 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Tejun Heo <tj@kernel.org>, 
	"T . J . Mercier" <tjmercier@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/5] fanotify namespace monitoring
Message-ID: <3januecns3wniveivws4iftpmbvtb52djcvk5g34vtdn7rpjbn@jsyuzmzn7fgf>
References: <20260307110550.373762-1-amir73il@gmail.com>
 <20260309-einrad-mitarbeit-18397e65afd3@brauner>
 <CAOQ4uxgmttSum2a2gKBkpdzg4110rpaH4mayy=9+QzWjFRNB6w@mail.gmail.com>
 <20260310-inkompatibel-staufer-7c862857ac62@brauner>
 <CAOQ4uxiXE3Ko60_Y6ZNmxkORjOFTCACR0PeTz51nZKWHMR=+og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiXE3Ko60_Y6ZNmxkORjOFTCACR0PeTz51nZKWHMR=+og@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

Sorry for delayed reply, I was on vacation most of last week.

On Tue 10-03-26 12:14:45, Amir Goldstein wrote:
> On Tue, Mar 10, 2026 at 11:31 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Mon, Mar 09, 2026 at 04:47:20PM +0100, Amir Goldstein wrote:
> > > On Mon, Mar 9, 2026 at 1:33 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > If we ever want recursive watches, then we just need to add a separate
> > > > flag. This is only applicable to userns and pidns anyway.
> > >
> > > Yes, if we wanted to.
> > >
> > > >
> > > > I want to put another - crazier idea - in your head: Since pidfds are
> > > > file descriptors and now have the ability to persist information past
> > > > pidfd closure via struct pid->attr it is possible to allow fanotify
> > > > watches on pidfds.
> > > >
> > > > I think that this opens up a crazy amount of possibilities that will be
> > > > tremendously useful - also would mean fsnotify outside of fs/ proper.
> > > > Just thinking on the spot: if you allow marking a pidfd it's super easy
> > > > to plumb exec notifications via fanotify on top of it. It's also easy to
> > > > monitor _all_ namespace events for a specific process via pidfds.
> > >
> > > Anything's possible, but we need to make sure it's worth it.
> > > Aren't there already enough ways to monitor a process via ptrace/landlock?
> >
> > Oh god, no. ;)
> > ptrace() is way too heavy handed for usages outside of debugging tools
> > such as strace and also has the downside that only one ptracer can be
> > attached at any time. I have no idea about landlock but it is an LSM and
> > I don't know why an LSM should have such notification abilities.
> >
> > fanotify on the other has no odd limitations and it naturally ties in
> > with filesystem objects and with pidfs we've made processes filesystem
> > objects. So I think this is a very natural fit.
> >
> > So you could just register a pidfd with fanotify and then get notified
> > about exec events for that pidfd with arbitrary metadata attached to it
> > if need. I've wanted this for a long time and one way I thought about
> > going about this is by somehow plubming this into poll for pidfd but
> > that's not going to scale as we grow more notifications events for
> > pidfds.
> >
> > I think fanotify is the perfect fit for this with its extensible model.
> >
> 
> I have no objection to utilizing fanotify beyond fs boundaries,
> but if we do that, I think we need to carefully partition the event flags
> namespace.
> 
> As I wrote in the cover letter, I see no reason for FAN_MARK_FILESYSTEM
> watch to be in the same group (fanotifyfd) as FAN_MARK_USERNS or
> FAN_MARK_MNTNS for than matter.
> 
> I would rather use something like FAN_CLASS_PROC classification
> to explicitly say "this fanotifyfd is only for process/namespace notifications"
> and in this context user would use completely different event constants.
> 
> OTOH, maybe it will be less confusing to add new syscalls
> pnotify_init()/pnotify_mark() as a frontend to this separate class of events.
> If for no other reason, then because fanotify_mark(2) man page is
> getting out of control ;)

I agree fanotify may be a reasonable framework for generating these
kind of events in the kernel and delivering them to userspace but I also
think we should have a clear separation in the API between standard
filesystem notification events and watching of these special filesystems
for special events. Because the semantics of standard filesystem events
doesn't always necessarily match the semantics we need from these events
for special filesystems and with special events such as exec notification
we are clearly deviating from standard filesystem events even further.

We already kind of started on this path with mount event notifications.
There we've chosen FAN_REPORT_MNT for separating groups that receive mount
event notifications - so a group can either get mount notifications or
standard filesystem events. So with namespaces notification events it would
be kind of natural to continue with this tradition with other FAN_REPORT_*
flags (we could possibly use several bits of this flag space as an enum to
select type of events to receive).

I think using new FAN_CLASS would be also possible but it doesn't quite fit
the current semantic of classes in my opinion (which determine group
priority when delivering events and are kind of linearly ordered where
higher class allows you to do more). So IMHO it would be somewhat
confusing if we introduced new class that would be completely separate.

Regarding hiding the new notification group types behind new syscalls
(instead of flags bits) - I'm not strictly opposed to that but my current
thinking is it would be a bit of an overkill. Adding new syscalls is
somewhat annoying as far as I remember and (somewhat more importantly) we'd
have to explain to users big part of the mechanics of the fanotify API
anyway so the amount of information user has to digest to be able to use
the API will not be significantly smaller I'm afraid. So I think we might
just introduce something like "notification group type" - filesystem,
mount, process, ... - and clearly separate which group type can do what.
That could make things more comprehensible and easier to find in the
manpage.

Regarding events, since we are kind of short on event bits (7 bits left if
I'm counting right), I agree we could make the event spaces for these
"special type" groups separate and overlapping - i.e., the meaning of the
event bit would depend on the type of the group. That means 'mask' isn't
enough to determine which group should receive the event anymore but I
think fsnotify() could determine the type of group for which the event is
destined based on data_type.

This way I think fsnotify+fanotify could be extended for other uses.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
