Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F43F788A
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269778; cv=none; b=jeqzcC4qR3SBJV72OlFX/QHSu2g6cHxyRmVTdUTJgk4mC7RSSOKLLntOX4Z6vS29EhTQsa67Mgp5fkb/9CjPKcMcYO7Dsv73sXWGLKl29qyxWQ+yp0Lrq46xMg+TU/Bt5hgjSlY30ZAHXbVkkiZGQJynClphCfpaptjkfWsgtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269778; c=relaxed/simple;
	bh=funxP4kwtoUaDymiI0BgVU2HZtztvhyPF2k38jdwjBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1FFGG1R3u5Wb8yaCWsjc4SWRQvCNX2u+Da6mhqTvXdKDJjp5gy21Ei1NCLOZ2xbFjgOzJkghnW0ES9Hf9LSiehsy1UfmPh8nzk0dy3qvMuNL2FUhH38HK0HeJkflvEkj/DRrAqMGRwkQBgK5uK7eA1ldCAzDJAcRUUlA4hWN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ggE9OLJD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wkn6AaC1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hD2O3EsD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvr2MR4g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ggE9OLJD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wkn6AaC1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hD2O3EsD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvr2MR4g"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EF6A21D47;
	Thu, 24 Sep 2026 17:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790269770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tP4bFPUTEwnWsI4CSDU6qWh7SX+DL+G8nmMwGV9F3A=;
	b=ggE9OLJDUJfuj/26sqpPat1KvuogdbzsgL3x/jin+yidxBp0HyZiktCVYcJwX2avqsy1xL
	8ttOD5KEh/cDFtSSWUTGea4gbv3bjBtF2LbzrWfqLuYsSFmxcY6aSfOWLQwNFTbzHL0X1M
	RDjXTuA0Bc/5p9Qgvv1GTlGk7gZicwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790269770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tP4bFPUTEwnWsI4CSDU6qWh7SX+DL+G8nmMwGV9F3A=;
	b=Wkn6AaC1odGABWmK4yEbE/yKpojIwLjfglNjgk7y1umAn55MMoRuB5x2pbn+CP+niFpfp7
	SYiv79mwutKkESDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hD2O3EsD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xvr2MR4g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790269766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tP4bFPUTEwnWsI4CSDU6qWh7SX+DL+G8nmMwGV9F3A=;
	b=hD2O3EsDlzyUsmri+VVMGQETJBxcG7Vx/FMbkH9WqRd1ct4ce+2NoV+rGLMRe3eeMoOEYr
	ERHuX0rbH1TPRJCj6HIAEb/t5HOHyBTt80cPpbXJPSwsq+EkIWlrSvEe087z6gWJQoaezo
	+FHDTH50D9Z7OUsOubLpNC9K29sh9is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790269766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tP4bFPUTEwnWsI4CSDU6qWh7SX+DL+G8nmMwGV9F3A=;
	b=xvr2MR4gXqOuiPmDAlcKP9+oSqCGskApxAlL2tKnBTCKaAaCTb05JspYprlqDc4sBTyCYl
	SuHJvpf6VrLx/QBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 227F513354;
	Thu, 24 Sep 2026 17:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4lReOkVZtWp5XwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Sep 2026 17:09:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9FA76A132E; Thu, 24 Sep 2026 19:09:25 +0200 (CEST)
Date: Thu, 24 Sep 2026 19:09:25 +0200
From: Jan Kara <jack@suse.cz>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Mikhail Rudenko <xyzzy@yandex-team.ru>
Subject: Re: [PATCH v2 4/5] fs: Add throttling to deferred inode reclaim
Message-ID: <kgxyhbgbewpch7pc3auxthhbcfelq7lgi7mxazdo5wvg2ael3b@hilsbf4622sh>
References: <20260911081309.14137-1-jack@suse.cz>
 <20260911085142.1774803-9-jack@suse.cz>
 <CAHc6FU6YT4EzM8VDX8V0+dhfRJtSrtWxbuwht+b8HG5yzyq7Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU6YT4EzM8VDX8V0+dhfRJtSrtWxbuwht+b8HG5yzyq7Lw@mail.gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 6EF6A21D47
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

On Wed 23-09-26 23:24:48, Andreas Gruenbacher wrote:
> On Fri, Sep 11, 2026 at 10:51 AM Jan Kara <jack@suse.cz> wrote:
> > Deferring difficult inode reclaim from prune_icache_sb() to a workqueue
> > removes the natural feedback loop of blocking tasks in direct reclaim
> > until they make space for new allocations. This can result in the list
> > of deferred inodes to grow beyond any bounds and possibly push the
> > machine to a reclaim storm or OOM.
> >
> > Add a throttling mechanism slowing down tasks in
> > mark_inode_reclaim_deferred() if the number of deferred inodes to
> > reclaim for a superblock grows over limit. We measure average time it
> > takes to reclaim inode on deferred list for a superblock and block tasks
> > proportionally to that.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
...
> >  void mark_inode_reclaim_deferred(struct inode *inode)
> >  {
> > +       bool throttle = false;
> > +
> >         if (inode_state_read_once(inode) & I_DEFER_RECLAIM)
> >                 return;
> >
> >         spin_lock(&inode->i_lock);
> > -       inode_state_set(inode, I_DEFER_RECLAIM);
> > +       if (!(inode_state_read(inode) & I_DEFER_RECLAIM)) {
> > +               inode_state_set(inode, I_DEFER_RECLAIM);
> > +               throttle = true;
> > +       }
> >         spin_unlock(&inode->i_lock);
> > +
> > +       if (throttle)
> > +               throttle_inode_deferred_reclaim(inode);
> 
> I would expect the throttling to happen when too many inodes marked
> I_DEFER_RECLAIM are evicted, but not here. In my use case [*], inodes
> would only require deferred reclaim intermittently, while they have
> outstanding revokes. Once there are no more outstanding revokes, those
> inodes can just be evicted directly.
> 
> [*] https://lore.kernel.org/linux-fsdevel/CAHc6FU4Rf9-r8m8SSb=e0k0zyoFhQAdjupHMWvT6rStBshntug@mail.gmail.com/T/#t

Throttling during eviction doesn't make sense - you are punishing the wrong
task (the one trying to free memory, not the one actually making that
memory hard to reclaim).

Also note that the throttling kicks in only when the queue of inodes that
we want to reclaim but worker didn't get to them yet grows above threshold.
This means there's significant memory pressure, significant amount of
deferred inodes, *and* workers cannot keep up. Throttling marking of inodes
for deferred reclaim is the best thing I was able to come up with to
eventually reduce the pressure on the cleanup workers. But I'm open to
better ideas.

I understand your objection about the need for deferal being only temporary
but let's keep that discussion to the other thread.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
