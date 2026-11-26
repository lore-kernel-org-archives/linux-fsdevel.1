Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690662;
	b=Nsu3zqYbuMzoh/dvsTgyUlYAPEbZtE6YsMeVIOaUzUy6oXPouVIEZUFlMuZ2diJesYxS
	 MufE7fe38j3X8Sd9m/+yPabOjFenn03zfViORzMrjYMIDdBa0ubXg1hpyW7w1GuLx97bo
	 doULBMNZpnFw+I9s09uBbzntj/+lHalI+rBq2nhMBftE2/IfxUCvqPEGa2o1qLaR2mMOM
	 iKHP+suy56ZWMSq0MHyEHlku4M57NuOjuzMuBGDKHOOHC4P3pAdV6CeifC/NN03MCVilV
	 RDbvJo+0JUX/d54iCFCwPHWpPy3PG2cZJFtiFJNFcCfDuNYBJHF7vPzN1Y37pFpwIbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690662;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=9mWzlU3he+fyESHGNkqcr507tRPFrQL/Ymayc2PN8Ws=;
	b=cD6669Qw74opoX8v04tg3tLY3osQ9e9OAZ4fKkksmD0tskTKVcWBnT2po4tkSjdv8ufI
	 Zq7myq+87/Mb9hBPnpa6AiywCyrE+2QPLlenQ06Vt1eYY9BXohByG8SXne5v6h5i4k1oX
	 Kgp8GxyaD2VCn8A5w5gAjTU95K4TNNQuI/RKIXDLlZZsqZBRNwInrrMl/4uZL9hCoUClR
	 uAoJbyh/4grZ4AQTgNT79oZnJwPJ7kH8Jxhzyu35jpO6YoRr0ZweC8b9u54j8kNBm/q34
	 aIbeKNoAHlRm6uEqKXPXNJlWETkeMsflWgaIHz5rb8NhRIFKFs0NSK+23BfrEtd7VMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=PYzIYI5t;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Bm4sS4v3;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=PYzIYI5t;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Bm4sS4v3;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94016606A339;
	Thu, 26 Nov 2026 10:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94016606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=PYzIYI5t;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Bm4sS4v3;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=PYzIYI5t;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Bm4sS4v3
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 667CD2272B;
	Thu, 26 Nov 2026 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795690659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mWzlU3he+fyESHGNkqcr507tRPFrQL/Ymayc2PN8Ws=;
	b=PYzIYI5tBr8k1HNORhXxA+J5DtCIzluPhyywRPwznAJsNWyBCUUNqZMFDqgOXYtTiS62c/
	AprDGhgclb2RulviHAmHH411GJXUKMf/RgMPjLRAF4fHSbC9ls+r4Ur+U9EybcHpYdLaSk
	09IhpmO/euqtVoDoMy6U0CTgY4x/h+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795690659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mWzlU3he+fyESHGNkqcr507tRPFrQL/Ymayc2PN8Ws=;
	b=Bm4sS4v3mT5DsuspaRs0OJo8/rrdGXc114d1QEJXjRK0O6L0Z0vzhnb9yWlydwX24pOJ7g
	wYvPRnFZkLL1a/Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PYzIYI5t;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Bm4sS4v3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795690659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mWzlU3he+fyESHGNkqcr507tRPFrQL/Ymayc2PN8Ws=;
	b=PYzIYI5tBr8k1HNORhXxA+J5DtCIzluPhyywRPwznAJsNWyBCUUNqZMFDqgOXYtTiS62c/
	AprDGhgclb2RulviHAmHH411GJXUKMf/RgMPjLRAF4fHSbC9ls+r4Ur+U9EybcHpYdLaSk
	09IhpmO/euqtVoDoMy6U0CTgY4x/h+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795690659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mWzlU3he+fyESHGNkqcr507tRPFrQL/Ymayc2PN8Ws=;
	b=Bm4sS4v3mT5DsuspaRs0OJo8/rrdGXc114d1QEJXjRK0O6L0Z0vzhnb9yWlydwX24pOJ7g
	wYvPRnFZkLL1a/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4038E13432;
	Thu, 26 Nov 2026 10:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P1frCKMQCGtjQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Nov 2026 10:57:39 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id C196227DD9; Thu, 26 Nov 2026 11:57:34 +0100 (CET)
Date: Thu, 26 Nov 2026 11:57:34 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v6 0/5] Fix easy bits of the negative dentry problem
Message-ID: <dy726gpfomckyt3se66pkdfj7qlsvmu4ysr666h3w5hxkay3l3@ibdy5kcibpjn>
References: <20261123221410.3328780-1-neilb@ownmail.net>
 <179550252639.1728055.4014817916838632741@noble.neil.brown.name>
 <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com>
 <aau5z6kck6a2efcjvzrt6gno6ljs4eioncgizeh7vfbc6ipkr3@hjxzdk5pvgmt>
 <CAOQ4uxjXP4Zegb2Vgsv-yBeFmhvc8FT2bDKDcaM_t0=oJ5KpXQ@mail.gmail.com>
 <sc6xnwguimy23dexr3eosbe64xmmewn5ml5gso4m5xozw6fqlt@2hji64vi7eaw>
 <CAOQ4uxisP8YTUaexsXw4-Fxg0vand236cg5eDKirLm=kuDwSQQ@mail.gmail.com>
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
In-Reply-To: <CAOQ4uxisP8YTUaexsXw4-Fxg0vand236cg5eDKirLm=kuDwSQQ@mail.gmail.com>
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 667CD2272B

On Wed 25-11-26 18:39:20, Amir Goldstein wrote:
> On Wed, Nov 25, 2026 at 12:34 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 25-11-26 08:46:45, Amir Goldstein wrote:
> > > On Tue, Nov 24, 2026 at 5:26 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Tue 24-11-26 14:08:07, Amir Goldstein wrote:
> > > > > On Tue, Nov 24, 2026 at 7:42 AM NeilBrown <neilb@ownmail.net> wrote:
> > > > > >
> > > > > > On Tue, 24 Nov 2026, NeilBrown wrote:
> > > > > > > This v6:
> > > > > > >  - fixes the autofs changes in 1/5
> > > > > >
> > > > > > Sashiko says this is racy.  I think it is but the original code was just
> > > > > > as racy.  Maybe the race isn't relevant.  I haven't properly understood
> > > > > > it yet.
> > > > > >
> > > > > > >  - updates d_duplicate() in 1/5
> > > > > >
> > > > > > The fix was seriously broken.  Sorry.
> > > > > >
> > > > > > >  - uses a new version of 2/5 from Amir
> > > > > >
> > > > > > Sashiko has something to say about this
> > > > > >
> > > > > >     Can clearing FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN and dropping conn->lock
> > > > > >     before fsnotify_set_children_dentry_flags() finishes allow a concurrent
> > > > > >     watch-adding syscall to return to userspace before the children's
> > > > > >     DCACHE_FSNOTIFY_PARENT_WATCHED flags have been set?
> > > > > >
> > > > > > Thoughts?
> > > > >
> > > > > Sashiko is right, but this race is not new.
> > > > > The same window exists upstream: if another thread's recalc observes
> > > > > the 0->watching transition and does the walk, fanotify_mark() can return
> > > > > to userspace before all children have DCACHE_FSNOTIFY_PARENT_WATCHED set.
> > > > >
> > > > > What changes with this series is that the walk is sleepable, so the
> > > > > window is longer, and in some workloads it could go from rare to
> > > > > plausible. OTOH, skipping negative dentries may shorten the walk.
> > > > >
> > > > > The more important question is whether a child can be left without
> > > > > PARENT_WATCHED permanently. Upstream it can: the transition can be
> > > > > observed by a recalc from the mark destroy path, which never walks.
> > > > > With FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN that cannot happen.
> > > > > Every transition sets the flag, and every caller that can add a watch
> > > > > consumes it,
> > > > > so a walk that started after the transition always runs and fixes the flags.
> > > > > What remains is the transient window above.
> > > >
> > > > I agree this is preexisting issue. Let's not block this series with it.
> > >
> > > preexisting, but sleepable children walks could make an
> > > improbable race actually observable, because the scans are not
> > > serialized and could take longer (I don't know how the scheduler
> > > treats a dying process which has its marks removed).
> > > Just wanted to make sure that the point is clear.
> >
> > Yes, the window can be larger now but it still shouldn't be a practical
> > problem unless there are several watchers placing marks on insanely large
> > dir in parallel. So I think we can live with the race for a while longer :)
> >
> > > > > I think a proper fix for the transient window needs a sequence counter
> > > > > of scans in the connector. Each caller would wait until a scan that
> > > > > started after its transition has completed, no matter which thread ran it.
> > > > >
> > > > > I think we can live with this v6 patch for your series and deal with
> > > > > the remaining race later if we want to, but I am not sure and would
> > > > > like to hear what Jan thinks.
> > > > >
> > > > > If you want, I can implement the sequence counter for v7.
> > > >
> > > > No sure what exactly you have in mind but a sequence counter per inode
> > > > looks like an overkill for this. A global one can get contended and
> > > > a bit hairy to manage but let's see...
> > >
> > > I had a patch with another conn flag _CHILDREN_WATCHED
> > > set at the end of the walk, which covers the Sashiko race, but
> > > leaves some other corner cases (see below).
> >
> > Yes, I was also concerned about those races when thinking about that
> > yesterday. Let's discuss below.
> >
> > > Are you concerned over the size of the mark connector?
> > > I think that connectors should be rare and scarce.
> >
> > Yes, I was concerned about the size of the connector. On a second thought
> > I tend to agree it wouldn't be a huge deal if we need it.
> >
> > > With workloads that frequently add/remove watch,
> > > Sleepable children walks could cause a situation where
> > > scan that started a few add/remove cycles ago complete out
> > > or order with the most recent walk.
> >
> > Well, let's discuss the behavior of the walks and the flags. I imagine we
> > could have two bits like _UPDATE_CHILDREN and _UPDATE_CHIDREN_RUNNING.
> > When children flags need update we set _UPDATE_CHILDREN. When we see
> > _UPDATE_CHILDREN set, we call fsnotify_conn_set_children_dentry_flags().
> > That function checks _UPDATE_CHIDREN_RUNNING. If already set, it waits for
> > it to get cleared and returns. If not set, it sets _UPDATE_CHIDREN_RUNNING,
> > does the walk and clears both _UPDATE_CHILDREN and _UPDATE_CHIDREN_RUNNING.
> >
> 
> Yeh, I think that mostly works, with a minor variation.
> 
> If the RUNNING flag is already set, the function waits for it to get
> cleared and then checks the UPDATE flag again.
> If the UPDATE flag is set, it clears the UPDATE flag, sets RUNNING
> and starts the walk. At the end of the walk it clears only RUNNING,
> so every time UPDATE is set, a walk starts after it.
> 
> Anyway, serializing the walks per inode is a positive outcome
> and better for our mental model.

I agree. The only thing to watch out is that if the user could fast enough
switch the inode between "children watched" and "no children watched" during
the walk, he could hold people waiting on RUNNING practically indefinitely.
And indeed with the example you mentioned below - one group with mark with
FS_EVENT_ON_CHILD | FS_CREATE, another group with mark with FS_OPEN - would
create a situation where no single mark is watching children but together
they create a mask which results in watching children. And by constantly
adding and removing these marks userspace can stall other waiters on
RUNNING flag without any bound (it depends only whether the victim task gets
scheduled and rechecks RUNNING flag before malicious task wakes up, clears
UPDATE, and sets RUNNING again).

So I guess we'll have to use the sequence counter in the end and we'll need
to be careful. Something like:

	spin_lock(&conn->lock);
	gen = conn->scan_seqcount;
	update_children = conn->flags & FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
	/* Scan in progress? */
	if (gen & 1) {
		/*
		 * We need to wait for scan to complete even if
		 * UPDATE_CHILDREN is not set as somebody might have
		 * started a scan for us.
		 */
		gen++;
		wait_var_event_spinlock(&conn->scan_seqcount,
					conn->scan_seqcount >= gen,
					&conn->lock);
		/*
		 * Somebody started the scan we need while we waited? Just
		 * wait for it to complete.
		 */
		if (conn->scan_seqcount == gen + 1) {
			update_children = false;
			wait_var_event_spinlock(&conn->scan_seqcount,
						conn->scan_seqcount >= gen + 2,
						&conn->lock);
		}
	}
	/* Scan we needed is guaranteed to be complete */
	if (!update_children || conn->scan_seqcount >= gen + 2) {
		spin_unlock(&conn->lock);
		return;
	}
	/* We will do the scan */
	conn->scan_seqcount++;
	conn->flags &= ~FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
	spin_unlock(&conn->lock);

	fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));

	spin_lock(&conn->lock);
	conn->scan_seqcount++;
	wake_up_var_locked(&conn->scan_seqcount, &conn->lock);
	spin_unlock(&conn->lock);

> > > Only the completion of the most recent walk can guarantee
> > > that all the children dentries are watched.
> >
> > So I don't think that's an issue. Look, if someone places a mark which
> > watches children of an inode, we either end up updating the children flags
> > or we wait for _UPDATE_CHIDREN_RUNNING to clear. So any mark update from
> > userspace blocks, until the children walk is done and then they all return.
> > We hold the group lock during the wait so the mark that makes the parent
> > watch children is guaranteed to stay attached to the inode and subsequent
> > mask updates on the inode all result in the conclusion that children are
> > watched (so fsnotify_parent() doesn't clear the children flags while we are
> > still walking).
> >
> > One catch in the above argument are oneshot marks for inotify & dnotify.
> > Inotify is actually fine since it grabs group lock when removing mark after
> > the event was sent (so the above argument holds). Dnotify doesn't grab group
> > lock when removing oneshot mark and so breaks the argument. I think we
> > should just make dnotify grab that lock to make our life simpler.
> >
> > Thoughts? Counter examples?
> >
> 
> My thought is that this makes my head explode..
> I rather have a simpler mental model if possible, which is less
> dependent on all the callers and other locks.

I understand. Not sure if the above satisfies your wishes but I couldn't
make it simpler...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
