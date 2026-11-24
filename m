Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537607;
	b=3FNnUSvFvTWUp6HOs9fEny+xfm9frjhVvvmkQJ9BLMCtVOA/xJaiOV5Gs/Y37OlzmSVr
	 GpJwjmcWadsJjB+b/Dj5NX6hFPchECeq4CKdP/zaFA5Eb+FFk/HF4v60iE4MV8lGR1VXe
	 qJx37lK7PiLBYx7hd6ZoTJWWQ5ad4YrviLj0QteI3gA+ribJVaI/ZcUL4G/pZnXCbunPb
	 4GVTTej3C8m0JepB2S0qaI7yvtJckuKafkkUb7tPu1xrdrHXllOLsFCQKvcSjSnndBhxr
	 oWWIZVKyNAi+bKdmU1cmxwV2dqNj2TNZHuYFPDZgiX70xci5VjWD8v4CNd+3pZ31ekQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537607;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=Tau/QfvGh+vZNEbbYD2fA9tQVdy3zBtPCuE6/6Yzmh8=;
	b=3grluORgJuaE9a/zRVXSSl6W0vSk7SlRLFlhfHjA2Z7+ItG546/ywMOwN8h22WYEBshn
	 Av545jvFxshhN9r0lsr8XZIv13rAYR6VcR+H9U6boUPQOaTNfjXWhdCMP5SGNDa9je932
	 SNeb0dftEaTzJxgX0gDQCcbUfIpR1vEul5jSF5ksvLJ0mewi5ZbPGU+isYU5DmP9DzWEo
	 NyLlD0iQmfRGQdgugWXkwZSWyWL1TycdtnG5KxNhnpGM6ZplDS+IkWyaSgIUc7svKuo+H
	 jOFUr9OC8HQ02pDO/O+yNRBudNhcLru/rKmILDyl1+XsXM4Ai2gIUT98/fDCziUxxAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="e9b/edhz";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vpbpMcZK;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="e9b/edhz";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vpbpMcZK;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6453606A338;
	Tue, 24 Nov 2026 16:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6453606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=e9b/edhz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vpbpMcZK;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=e9b/edhz;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vpbpMcZK
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C87031FB62;
	Tue, 24 Nov 2026 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795537604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tau/QfvGh+vZNEbbYD2fA9tQVdy3zBtPCuE6/6Yzmh8=;
	b=e9b/edhzEQ+/NTZLcyNh/hLEfnNj7dBc2n4GBsbWmjUBzcbsPaEXB3aTDZGPFluHCvxdsb
	jVrMXoJG8lTxsb0L9/TLQL9GY4riObqPRUKH7nQpOOgdhZUJkbO3zgZlVJ1D2boXV99a5s
	EOM0tx9FdIgPD2Qa66rXrxVswpvUZIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795537604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tau/QfvGh+vZNEbbYD2fA9tQVdy3zBtPCuE6/6Yzmh8=;
	b=vpbpMcZKYCNKaIWWfeoxmCuySeYmlGMouv9BvXL6ZbUR02uzmwJ9F3MT8MQibkXbIRpcKm
	FBfiADgW2zKsrBCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795537604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tau/QfvGh+vZNEbbYD2fA9tQVdy3zBtPCuE6/6Yzmh8=;
	b=e9b/edhzEQ+/NTZLcyNh/hLEfnNj7dBc2n4GBsbWmjUBzcbsPaEXB3aTDZGPFluHCvxdsb
	jVrMXoJG8lTxsb0L9/TLQL9GY4riObqPRUKH7nQpOOgdhZUJkbO3zgZlVJ1D2boXV99a5s
	EOM0tx9FdIgPD2Qa66rXrxVswpvUZIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795537604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tau/QfvGh+vZNEbbYD2fA9tQVdy3zBtPCuE6/6Yzmh8=;
	b=vpbpMcZKYCNKaIWWfeoxmCuySeYmlGMouv9BvXL6ZbUR02uzmwJ9F3MT8MQibkXbIRpcKm
	FBfiADgW2zKsrBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A07281339F;
	Tue, 24 Nov 2026 16:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hP5KHsS6BWsjKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 16:26:44 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 2EED827A1C; Tue, 24 Nov 2026 17:26:44 +0100 (CET)
Date: Tue, 24 Nov 2026 17:26:44 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v6 0/5] Fix easy bits of the negative dentry problem
Message-ID: <aau5z6kck6a2efcjvzrt6gno6ljs4eioncgizeh7vfbc6ipkr3@hjxzdk5pvgmt>
References: <20261123221410.3328780-1-neilb@ownmail.net>
 <179550252639.1728055.4014817916838632741@noble.neil.brown.name>
 <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com>
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
In-Reply-To: <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80

On Tue 24-11-26 14:08:07, Amir Goldstein wrote:
> On Tue, Nov 24, 2026 at 7:42 AM NeilBrown <neilb@ownmail.net> wrote:
> >
> > On Tue, 24 Nov 2026, NeilBrown wrote:
> > > This v6:
> > >  - fixes the autofs changes in 1/5
> >
> > Sashiko says this is racy.  I think it is but the original code was just
> > as racy.  Maybe the race isn't relevant.  I haven't properly understood
> > it yet.
> >
> > >  - updates d_duplicate() in 1/5
> >
> > The fix was seriously broken.  Sorry.
> >
> > >  - uses a new version of 2/5 from Amir
> >
> > Sashiko has something to say about this
> >
> >     Can clearing FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN and dropping conn->lock
> >     before fsnotify_set_children_dentry_flags() finishes allow a concurrent
> >     watch-adding syscall to return to userspace before the children's
> >     DCACHE_FSNOTIFY_PARENT_WATCHED flags have been set?
> >
> > Thoughts?
> 
> Sashiko is right, but this race is not new.
> The same window exists upstream: if another thread's recalc observes
> the 0->watching transition and does the walk, fanotify_mark() can return
> to userspace before all children have DCACHE_FSNOTIFY_PARENT_WATCHED set.
> 
> What changes with this series is that the walk is sleepable, so the
> window is longer, and in some workloads it could go from rare to
> plausible. OTOH, skipping negative dentries may shorten the walk.
> 
> The more important question is whether a child can be left without
> PARENT_WATCHED permanently. Upstream it can: the transition can be
> observed by a recalc from the mark destroy path, which never walks.
> With FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN that cannot happen.
> Every transition sets the flag, and every caller that can add a watch
> consumes it,
> so a walk that started after the transition always runs and fixes the flags.
> What remains is the transient window above.

I agree this is preexisting issue. Let's not block this series with it.

> I think a proper fix for the transient window needs a sequence counter
> of scans in the connector. Each caller would wait until a scan that
> started after its transition has completed, no matter which thread ran it.
> 
> I think we can live with this v6 patch for your series and deal with
> the remaining race later if we want to, but I am not sure and would
> like to hear what Jan thinks.
> 
> If you want, I can implement the sequence counter for v7.

No sure what exactly you have in mind but a sequence counter per inode
looks like an overkill for this. A global one can get contended and
a bit hairy to manage but let's see...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
