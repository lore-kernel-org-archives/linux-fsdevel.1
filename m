Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A102B39EF36
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643491; cv=none; b=MGJNcvJ1zaxRFwopsP7QEAyDpizelmJLS7BJpAvlXssP/dghZQZdDm9hgJMbUqMPLGZcUa53l+ZaPetqojXksSjgjh00MoXH5z3peHkDMSpGlUzUsPValUtlDAzI3EdY0SEcmdYBfSleEPvfBxujH2wVaYUR7qsOJX2LAWnXOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643491; c=relaxed/simple;
	bh=l8BPnUOANCT6RPwO0bdTuwHO/qNtAG7af8F59VKML6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/D/+b4NKIAAsaNB7Ot+fLW73H7WbBKFaV7Aq84KYJz10QTcDejgV/uHTf/DLOQIUC0Y++2nfTpj0FhPsJP0D2kYqwSv/Ul+ERdo94b83zFFLviKoJLzg7SHEq9vFS5wjudMRYg1ZOIsHLb9lN6sQMlMqQW12M8op87ShphRmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WyEOP7Nz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rPi9Ulp8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WyEOP7Nz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rPi9Ulp8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WyEOP7Nz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rPi9Ulp8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WyEOP7Nz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rPi9Ulp8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FFEB5BDAE;
	Wed,  8 Apr 2026 10:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775643486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cR8jLrw5rPi3Lcfoioo9FvWpU3IA0ni2nbDWar/q74A=;
	b=WyEOP7NzeRf5E3+6l7TwmOxY8aj3uXx+kOwDRmw52F4GXs04IneaLQoMaEZBDMpgE0gJkR
	wUHr579UitYxGD7rckE49PQqd2iDoF/wlCDtsybCwC7DMNEXVS6DELoteh5mQ41wQDGNZN
	UCjVK9ZTPhT/R0w8BZsvWyI+QDTP6q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775643486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cR8jLrw5rPi3Lcfoioo9FvWpU3IA0ni2nbDWar/q74A=;
	b=rPi9Ulp8AeRmzO/VLtA3uKcIVY/nXkYb799C9Nt0c8REB3Kx60quNGMapblArgB0A9Rl7M
	RbEOcHv6d61C45CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WyEOP7Nz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rPi9Ulp8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775643486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cR8jLrw5rPi3Lcfoioo9FvWpU3IA0ni2nbDWar/q74A=;
	b=WyEOP7NzeRf5E3+6l7TwmOxY8aj3uXx+kOwDRmw52F4GXs04IneaLQoMaEZBDMpgE0gJkR
	wUHr579UitYxGD7rckE49PQqd2iDoF/wlCDtsybCwC7DMNEXVS6DELoteh5mQ41wQDGNZN
	UCjVK9ZTPhT/R0w8BZsvWyI+QDTP6q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775643486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cR8jLrw5rPi3Lcfoioo9FvWpU3IA0ni2nbDWar/q74A=;
	b=rPi9Ulp8AeRmzO/VLtA3uKcIVY/nXkYb799C9Nt0c8REB3Kx60quNGMapblArgB0A9Rl7M
	RbEOcHv6d61C45CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FA9B4A0B3;
	Wed,  8 Apr 2026 10:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ixFWF14r1mkcZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Apr 2026 10:18:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E257A0A7E; Wed,  8 Apr 2026 12:17:58 +0200 (CEST)
Date: Wed, 8 Apr 2026 12:17:58 +0200
From: Jan Kara <jack@suse.cz>
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Eric Sandeen <sandeen@sandeen.net>, Frank Sorenson <fsorenso@redhat.com>, 
	Jay Shin <jaeshin@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Yafang Shao <laoar.shao@gmail.com>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
Message-ID: <g72jlphxouvfml5ewxrvbo4u6drhue3pnsawoywhnvitnga3sd@rvi4wfep2az5>
References: <20260331012925.74840-1-raven@themaw.net>
 <20260331012925.74840-2-raven@themaw.net>
 <20260331-engste-raushalten-f66cd264ce77@brauner>
 <d8e591a1-d105-408f-b794-48573e1aa2fd@themaw.net>
 <20260407-frieden-girlanden-7b761912b2b1@brauner>
 <06760176-fb65-4fd8-b127-28b25d449b1f@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06760176-fb65-4fd8-b127-28b25d449b1f@themaw.net>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,szeredi.hu,sandeen.net,redhat.com,linux-foundation.org,gmail.com,suse.cz,infradead.org,huawei.com,verbum.org,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6FFEB5BDAE

On Tue 07-04-26 20:41:08, Ian Kent wrote:
> On 7/4/26 18:35, Christian Brauner wrote:
> > On Wed, Apr 01, 2026 at 10:10:55AM +0800, Ian Kent wrote:
> > > On 31/3/26 17:39, Christian Brauner wrote:
> > > > On Tue, Mar 31, 2026 at 09:29:09AM +0800, Ian Kent wrote:
> > > > > If there's a very large number of children present in a directory dentry
> > > > > then the benifit from retaining stale child dentries for re-use can
> > > > > become ineffective. Even hashed lookup can become ineffective as hash
> > > > > chains grow, time taken to umount a file system can increase a lot, as
> > > > > well as child dentry traversals resulting in lock held too long log
> > > > > messages.
> > > > Fwiw, there's also e6957c99dca5 ("vfs: Add a sysctl for automated deletion of dentry")
> > > I'm pretty sure I saw that earlier on but had forgotten about it when I
> > > 
> > > reviewed the bug this time around. It is essentially 681ce8623567 ("vfs:
> > > 
> > > Delete the associated dentry when deleting a file") with opt-in of course.
> > > 
> > > 
> > > > This patch introduces the concept conditionally, where the associated
> > > > dentry is deleted only when the user explicitly opts for it during file
> > > > removal. A new sysctl fs.automated_deletion_of_dentry is added for this
> > > > purpose. Its default value is set to 0.
> > > I meant to update Documentation/admin-guide/sysctl/fs.rst to also say that
> > > 
> > > setting dir-stale-max to 0 disables it. I also get the impression you might
> > > 
> > > feel better about this if the default was 0 as well.
> > > 
> > > 
> > > The thing that I don't much like with the d_delete() approach is that it
> > > 
> > > fails to cater for files that have been closed and are otherwise unused
> > > 
> > > who's dentries make there way to the LRU eventually resulting in the bad
> > > 
> > > behaviour being discussed.
> > > 
> > > 
> > > > I have no massive objections to your approach. It feels a bit hacky tbh
> > > > as it seems to degrade performance for new workloads in favor old
> > > > workloads. The LRU should sort this out though.
> > > My aim was to improve performance so I'm a bit puzzled by the comment.
> > > 
> > > 
> > > The problem is the sheer number of dentry objects and the consequences
> > > 
> > > of that. Hash table chains growing will affect performance, umounting
> > > 
> > > the mount will take ages, and there are cases of child dentry traversals
> > > 
> > > in the VFS. Once you get a large number of stale dentries that necessarily
> > > 
> > > need to stay linked into the structures to get the benefit of caching your
> > > 
> > > exposed to this problem.
> > > 
> > > 
> > > The LRU mechanism is so far unable to cope with this.
> > I meant when when you start limiting the number of negative dentries and
> > start to not accumulate more that some workload was relying on this. It
> > was just a theoretical musing. That initial "delete on unlink" thing led
> > to regressions for a bunch of workloads when we did it unconditionally
> > initially.
> 
> Yes, I did take that on board.
> 
> It's trivial to initially disable it with a doc update describng this.
> 
> But this only works (gets accepted) if people think it's worth while and
> 
> I'm not sure my proposed case is convincing enough.

I think we definitely need to find a way to manage negative dentries (and
possibly all dentries) better. It is coming up several times each year that
people have issues with negative dentries accumulating too much and they
hit issues in various places.

I don't particularly like your solution because it effectively stops
caching new dentries for the parent and old ones stay while, as Christian
suggested, we'd prefer to prune older dentries first. Also usually the
problem is with negative dentries while you approach treats negative and
positive dentries in the same way which could be a problem for some cases.
But with this second objection I'm less sure so take that mostly as a
preference :).

The problem is how to efficiently prune older children dentries without
slowing down fast paths or growing struct dentry...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
