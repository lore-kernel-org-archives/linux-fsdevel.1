Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A81E1DE5
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755165; cv=none; b=qyvswiQe54BnWOcy8lK0syByzXqIGtysFieA37lTOR7AX2kancLurRi8aj8jxJWC+2Wce22JTMfoo2KHrb51Fcu+tSlwoJQkcm18i2KFYwrkh/PGfYmHy3ah5i++WJmrcH9SJLLG6VYyDWxBXlqdSNZTDZloNi6Q7DnD8FsySrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755165; c=relaxed/simple;
	bh=Veqjct3u0pTf3tmvMYqU/BhwJ2Z6mKk6/0wSWxRCMwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo5TeP0yI68m9wi4XIROc83V2s57Kw/CU3hJcGrBgyk0YA1WasJZ3hv0SdThsgrnmWGTo0nXRkBE4ph4xB0zdmxiAZ89gHGZcTytufeO8J966NASVl9gJJ2pr4ipKr/7+Z89T4J+Wxn/tgLgwL4fS2kBuJWrxbQmfDvXxTwbpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W795KbpU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fp1silJn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p37OWch6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I1rmCx/G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W795KbpU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fp1silJn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p37OWch6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I1rmCx/G"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B285C5BCEE;
	Tue, 21 Apr 2026 07:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776755157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx7PzHp5an6+JrT5TXlRNI9jsUTr73lga4BNT8yjZ1A=;
	b=W795KbpUuLJEAOrch77yXD5jQoTW39Edf+fYNQIyw5d24e08iaaxataTZSvPyF/XLjRVUo
	e9pw2c9A9y+5Ssoa9k1MS7Yfrz6iMKU548lOulfVLuNSieY9GHjhjnCzcKycNDjomlwsz7
	qXNZn1CbfpjFMuQVPLX5RuyEa3h2eYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776755157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx7PzHp5an6+JrT5TXlRNI9jsUTr73lga4BNT8yjZ1A=;
	b=fp1silJnaDqOwIfpj68lc12Jx2SMvCrKsqYZVgDH90ehv96W43x2czRzWRgnnIG9ia/Yl/
	Up6gVC7vE5/8OUCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776755155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx7PzHp5an6+JrT5TXlRNI9jsUTr73lga4BNT8yjZ1A=;
	b=p37OWch6q2MPxO/VehEGpbYWCPCiXpx1+hxas8gRLqeG0ADLYkmuKjUNgTA2tRAGkJs+dY
	kyrs7ZJ2397kQGTJoOoOzedUBZX1aGL+MOQtGIa5gQ21Uuo1h7iuIAqhpJoBoUC6Xm4NfD
	tUQEbBrgc9NRdE5IgUrTGKdb35w8hyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776755155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx7PzHp5an6+JrT5TXlRNI9jsUTr73lga4BNT8yjZ1A=;
	b=I1rmCx/GZ7M6jEFYYF5qMeRnw1Pi/oYa1RElYYgEDlvnjEz8VuWCS8pKZ3havm87xztkeF
	0izNVlbXJEuc9vCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA8A2593B0;
	Tue, 21 Apr 2026 07:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HhCeKdMh52liEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Apr 2026 07:05:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65BA5A0AE1; Tue, 21 Apr 2026 09:05:51 +0200 (CEST)
Date: Tue, 21 Apr 2026 09:05:51 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH v3 2/2] fanotify: introduce restartable permission events
Message-ID: <tgy5xqn3ytxbx4wiwjff3tljdejanehf3k36ggwjv6rclvx65r@bdebggx5qrew>
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
 <20260416194844.3874004-3-ibrahimjirdeh@meta.com>
 <bcodsu6plppnwotjuisi7kvwkftpennowemslxur33qhtmd4qp@wc536gzxu53m>
 <CAOQ4uxjXLXOc=peppj705C+PfR32102VCthCufeRNXTLqQfOuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjXLXOc=peppj705C+PfR32102VCthCufeRNXTLqQfOuw@mail.gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,meta.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Mon 20-04-26 20:07:45, Amir Goldstein wrote:
> On Mon, Apr 20, 2026 at 4:37 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 16-04-26 12:48:44, Ibrahim Jirdeh wrote:
> > > This adds support for restarting permission events. The main goal of
> > > the change is to provide better handling for pending events for lazy
> > > file loading use cases which may back fanotify events by a long-lived
> > > daemon. For prior discussion of approaches see [1][2].
> > >
> > > In terms of implementation, we add a new control-fd/queue-fd api.
> > > Control fd returned by fanotify_init keeps fanotify group alive and
> > > supports operations like fanotify_mark as well as a new ioctl
> > > FAN_IOC_OPEN_QUEUE_FD to open a queue fd. Queue fd is used
> > > for reading events and writing back responses. Upon release of
> > > queue fd, pending permission events are reinserted back into
> > > notification queue for reprocessing.
> > >
> > > Control-fd/queue-fd api is guarded by FAN_RESTARTABLE_EVENTS flag.
> > > In addition FAN_RESTARTABLE_EVENTS can only be used in conjunction
> > > with FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT, and only permission
> > > events can be added to the mark mask if a group is initialized with
> > > FAN_RESTARTABLE_EVENTS.
> > >
> > > [1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr
> > > [2] https://lore.kernel.org/linux-fsdevel/20250623192503.2673076-1-ibrahimjirdeh@meta.com
> > >
> > > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com
> > > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> >
> ...
> 
> > > +
> > >  static int fanotify_find_path(int dfd, const char __user *filename,
> > >                             struct path *path, unsigned int flags, __u64 mask,
> > >                             unsigned int obj_type)
> > > @@ -1640,6 +1730,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
> > >       int f_flags, fd;
> > >       unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
> > >       unsigned int class = flags & FANOTIFY_CLASS_BITS;
> > > +     unsigned int restartable_events = flags & FAN_RESTARTABLE_EVENTS;
> >                                                   ^^^ Can we perhaps call
> > this FAN_EVENT_FD or something like that? Because I can forsee we will find
> > other interesting ways how to use the scheme with two fds and not all of
> > them tied to restarting of permission events. So FAN_RESTARTABLE_EVENTS
> > will become confusing at that point.
> >
> 
> FAN_EVENT_FD sounds too close to event->fd and to FANOTIFY_FD_EVENTS
> Maybe FAN_CONTROL_FD, which is what is requested from fanotify_init()?

Yes, FAN_CONTROL_FD sounds fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
