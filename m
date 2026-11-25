Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606476;
	b=MkGYbpMUTKkPkUfakBIEFCkExPwMIFScRor830XruMPPz3evfyLCVRuepILr6dBO4WsK
	 H8LLi1D4VB5z9I+Su3OM4mV4rurZmwGBDmv3h/NXlqq0cfLqXqtax/g6gesexEl1GeDpV
	 kGQNHgGAw8mftaj+Y3oC9NeHD1nS8LnXNNgolknpcx+UEn2T5Q9nahN1fJOuFG1G5O0fi
	 3MpDbbkI4SiBYEA85wBP0dm67Xo6e/BE1WN0KNliFOKu/4juKWaG7xdn7ILbvEs1v7A0A
	 te6XxDjk+e0A23hLQscPDIGZLaTgCm+u3PiF4zUnK8NVPnl1sTRAUEhEa0j5D0rbzGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606476;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=QCWPZqy3E8KI6D3pSid9ooewA3U8Dto5kOddsAtNGhk=;
	b=iSxA9L6IB7VXBmL1fEAEIejTYf9IpqOhl5f8DZ7BPc4WwaY2KhD6f1ou1TOvOqQ3D4m4
	 3LP51VzFGxe3U/J3rTH1Qb3bU2kwef+CQxh6PwGTpZLBm9YrRxpjiPbndITOoaSNy1VTv
	 v10kcWs3vHLjZ+9XOVjPhGyseq87ErybBOoS7QQsCDIiWOTMCFHdG6Y4NYMK3rwevBfl0
	 6eHxogFgs0EpyDRtBjh4mPkiTPfRcr64TI97nWAMknPizHThR5bzFnstCMjkVdRYjlSdf
	 9LkQ0m4SZ0o8MMSEvgQpScUXDpHy3qCluQV91Biin7+sfUQ+Mftmzha6skcrhkeOFyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZgffNQ2J;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CdD2uzJA;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZgffNQ2J;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CdD2uzJA;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76405606A31E;
	Wed, 25 Nov 2026 11:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76405606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZgffNQ2J;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CdD2uzJA;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ZgffNQ2J;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CdD2uzJA
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37A3A22346;
	Wed, 25 Nov 2026 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795606473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCWPZqy3E8KI6D3pSid9ooewA3U8Dto5kOddsAtNGhk=;
	b=ZgffNQ2JaTbrObSnm1IFKJ0T2dJkkcLj1nQNGkBIXw4Cgv7GqznmCMrhPxSfSHcar8BTVg
	LA+cUCkUVJDyRuyZQdgJ6k89bvzt8UMk4SBLR1xhEzGtSdsy4ozBeB5AjiTrD+rKv9iwRl
	ZSoARKoQK/nwX8pdIkiiHfOH7xB2X1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795606473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCWPZqy3E8KI6D3pSid9ooewA3U8Dto5kOddsAtNGhk=;
	b=CdD2uzJAJB2fkd1qeggAP/dpDI4mTovh7kYVT/579Rv+4SOqGt9B5EimsUZk9fS1JprvkA
	3wc9onrEHdfamJDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZgffNQ2J;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CdD2uzJA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795606473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCWPZqy3E8KI6D3pSid9ooewA3U8Dto5kOddsAtNGhk=;
	b=ZgffNQ2JaTbrObSnm1IFKJ0T2dJkkcLj1nQNGkBIXw4Cgv7GqznmCMrhPxSfSHcar8BTVg
	LA+cUCkUVJDyRuyZQdgJ6k89bvzt8UMk4SBLR1xhEzGtSdsy4ozBeB5AjiTrD+rKv9iwRl
	ZSoARKoQK/nwX8pdIkiiHfOH7xB2X1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795606473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCWPZqy3E8KI6D3pSid9ooewA3U8Dto5kOddsAtNGhk=;
	b=CdD2uzJAJB2fkd1qeggAP/dpDI4mTovh7kYVT/579Rv+4SOqGt9B5EimsUZk9fS1JprvkA
	3wc9onrEHdfamJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00BB81339F;
	Wed, 25 Nov 2026 11:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IRg7M8jHBmsvLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Nov 2026 11:34:33 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 7F31827C21; Wed, 25 Nov 2026 12:34:24 +0100 (CET)
Date: Wed, 25 Nov 2026 12:34:24 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v6 0/5] Fix easy bits of the negative dentry problem
Message-ID: <sc6xnwguimy23dexr3eosbe64xmmewn5ml5gso4m5xozw6fqlt@2hji64vi7eaw>
References: <20261123221410.3328780-1-neilb@ownmail.net>
 <179550252639.1728055.4014817916838632741@noble.neil.brown.name>
 <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com>
 <aau5z6kck6a2efcjvzrt6gno6ljs4eioncgizeh7vfbc6ipkr3@hjxzdk5pvgmt>
 <CAOQ4uxjXP4Zegb2Vgsv-yBeFmhvc8FT2bDKDcaM_t0=oJ5KpXQ@mail.gmail.com>
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
In-Reply-To: <CAOQ4uxjXP4Zegb2Vgsv-yBeFmhvc8FT2bDKDcaM_t0=oJ5KpXQ@mail.gmail.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 37A3A22346

On Wed 25-11-26 08:46:45, Amir Goldstein wrote:
> On Tue, Nov 24, 2026 at 5:26 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 24-11-26 14:08:07, Amir Goldstein wrote:
> > > On Tue, Nov 24, 2026 at 7:42 AM NeilBrown <neilb@ownmail.net> wrote:
> > > >
> > > > On Tue, 24 Nov 2026, NeilBrown wrote:
> > > > > This v6:
> > > > >  - fixes the autofs changes in 1/5
> > > >
> > > > Sashiko says this is racy.  I think it is but the original code was just
> > > > as racy.  Maybe the race isn't relevant.  I haven't properly understood
> > > > it yet.
> > > >
> > > > >  - updates d_duplicate() in 1/5
> > > >
> > > > The fix was seriously broken.  Sorry.
> > > >
> > > > >  - uses a new version of 2/5 from Amir
> > > >
> > > > Sashiko has something to say about this
> > > >
> > > >     Can clearing FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN and dropping conn->lock
> > > >     before fsnotify_set_children_dentry_flags() finishes allow a concurrent
> > > >     watch-adding syscall to return to userspace before the children's
> > > >     DCACHE_FSNOTIFY_PARENT_WATCHED flags have been set?
> > > >
> > > > Thoughts?
> > >
> > > Sashiko is right, but this race is not new.
> > > The same window exists upstream: if another thread's recalc observes
> > > the 0->watching transition and does the walk, fanotify_mark() can return
> > > to userspace before all children have DCACHE_FSNOTIFY_PARENT_WATCHED set.
> > >
> > > What changes with this series is that the walk is sleepable, so the
> > > window is longer, and in some workloads it could go from rare to
> > > plausible. OTOH, skipping negative dentries may shorten the walk.
> > >
> > > The more important question is whether a child can be left without
> > > PARENT_WATCHED permanently. Upstream it can: the transition can be
> > > observed by a recalc from the mark destroy path, which never walks.
> > > With FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN that cannot happen.
> > > Every transition sets the flag, and every caller that can add a watch
> > > consumes it,
> > > so a walk that started after the transition always runs and fixes the flags.
> > > What remains is the transient window above.
> >
> > I agree this is preexisting issue. Let's not block this series with it.
> 
> preexisting, but sleepable children walks could make an
> improbable race actually observable, because the scans are not
> serialized and could take longer (I don't know how the scheduler
> treats a dying process which has its marks removed).
> Just wanted to make sure that the point is clear.

Yes, the window can be larger now but it still shouldn't be a practical
problem unless there are several watchers placing marks on insanely large
dir in parallel. So I think we can live with the race for a while longer :)

> > > I think a proper fix for the transient window needs a sequence counter
> > > of scans in the connector. Each caller would wait until a scan that
> > > started after its transition has completed, no matter which thread ran it.
> > >
> > > I think we can live with this v6 patch for your series and deal with
> > > the remaining race later if we want to, but I am not sure and would
> > > like to hear what Jan thinks.
> > >
> > > If you want, I can implement the sequence counter for v7.
> >
> > No sure what exactly you have in mind but a sequence counter per inode
> > looks like an overkill for this. A global one can get contended and
> > a bit hairy to manage but let's see...
> 
> I had a patch with another conn flag _CHILDREN_WATCHED
> set at the end of the walk, which covers the Sashiko race, but
> leaves some other corner cases (see below).

Yes, I was also concerned about those races when thinking about that
yesterday. Let's discuss below.

> Are you concerned over the size of the mark connector?
> I think that connectors should be rare and scarce.

Yes, I was concerned about the size of the connector. On a second thought
I tend to agree it wouldn't be a huge deal if we need it.

> With workloads that frequently add/remove watch,
> Sleepable children walks could cause a situation where
> scan that started a few add/remove cycles ago complete out
> or order with the most recent walk.

Well, let's discuss the behavior of the walks and the flags. I imagine we
could have two bits like _UPDATE_CHILDREN and _UPDATE_CHIDREN_RUNNING.
When children flags need update we set _UPDATE_CHILDREN. When we see
_UPDATE_CHILDREN set, we call fsnotify_conn_set_children_dentry_flags().
That function checks _UPDATE_CHIDREN_RUNNING. If already set, it waits for
it to get cleared and returns. If not set, it sets _UPDATE_CHIDREN_RUNNING,
does the walk and clears both _UPDATE_CHILDREN and _UPDATE_CHIDREN_RUNNING.

> Only the completion of the most recent walk can guarantee
> that all the children dentries are watched.

So I don't think that's an issue. Look, if someone places a mark which
watches children of an inode, we either end up updating the children flags
or we wait for _UPDATE_CHIDREN_RUNNING to clear. So any mark update from
userspace blocks, until the children walk is done and then they all return.
We hold the group lock during the wait so the mark that makes the parent
watch children is guaranteed to stay attached to the inode and subsequent
mask updates on the inode all result in the conclusion that children are
watched (so fsnotify_parent() doesn't clear the children flags while we are
still walking).

One catch in the above argument are oneshot marks for inotify & dnotify.
Inotify is actually fine since it grabs group lock when removing mark after
the event was sent (so the above argument holds). Dnotify doesn't grab group
lock when removing oneshot mark and so breaks the argument. I think we
should just make dnotify grab that lock to make our life simpler.

Thoughts? Counter examples?

								Honza


> void fsnotify_conn_set_children_dentry_flags(
>                                         struct fsnotify_mark_connector *conn)
> {
>         unsigned int gen;
>         bool update_children;
> 
>         if (!conn || conn->type != FSNOTIFY_OBJ_TYPE_INODE)
>                 return;
> 
>         spin_lock(&conn->lock);
>         if (conn->flags & FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN) {
>                 conn->flags &= ~FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
>                 conn->children_gen++;
>                 update_children = true;
>         } else {
>                 /* Walk that consumed the update flag may still be in
> progress */
>                 update_children = conn->children_done != conn->children_gen &&
>                                   fsnotify_conn_watches_children(conn);
>         }
>         gen = conn->children_gen;
>         spin_unlock(&conn->lock);
> 
>         if (!update_children)
>                 return;
> 
>         fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
> 
>         spin_lock(&conn->lock);
>         /* Concurrent walks may complete out of order */
>         if ((int)(gen - conn->children_done) > 0)
>                 conn->children_done = gen;
>         spin_unlock(&conn->lock);
> }
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
