Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E163E1701
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092378; cv=none; b=lUNKWpHwbjpVt3auqhI/DgQRLdJJKBPIgE5LdsZfvAA5cLqSy2WANTZMlFEnra4Roc7EdzFdFE9DL0juhfLGinOlI/vAI5JWLAFPyRXLamZKya3Pc5ih1QHE24zk4KuFQ3TlIeg9QafIP3CCGlH/u1dKV/EB6+A2HWUJr1Ohruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092378; c=relaxed/simple;
	bh=63puU6u/Q/rhOWLpbHVdswxyCPYCyTBuyLju4zlY4is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Msv4vk4oYArBuT4bRITywjKSsjVpBlomhVXCCB1gjXoBesZ6tJtD7ws9XxevVG4c5zbKXZe0HlflNdF1E3PFF5NoSQ340Ngm3XHuWOoFuLK1xU3jP6EHZTZnejKHrkx1LtMBWs5jBk2S8eP3lZnlp7CraMhNu98c/FXQF+JIVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gkCo+ZN3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l/xIq4H8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gkCo+ZN3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l/xIq4H8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gkCo+ZN3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l/xIq4H8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gkCo+ZN3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l/xIq4H8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3487F67E57;
	Mon, 18 May 2026 08:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779092375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kS4DqZ2QPY3ssAog9+U/o7f+sGAEPsoSb+Orwj9q0Jg=;
	b=gkCo+ZN3ozIlnuXo4JxuWGYUdP8VcnMeGWaEIe0KL8y3J0uFEXsmsQuiF2QlmBEQKlCy/z
	+sizwsCT1IV6SozxTYFzfX1KnrSQmpCx+DemhX5SrH16S9+LSkCuRdiHpISJX0P9WEYaSi
	Vb2VkkexybKK+PIAJbC2/hoCBdJWTOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779092375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kS4DqZ2QPY3ssAog9+U/o7f+sGAEPsoSb+Orwj9q0Jg=;
	b=l/xIq4H8SrmNpRHrwPmxVLkJ2IWBwwJwNz0kkIEgSiyHu8dH0+3Bv6PyvEIFyFkDRkoWgo
	pFKOAfZuCHpCfmDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779092375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kS4DqZ2QPY3ssAog9+U/o7f+sGAEPsoSb+Orwj9q0Jg=;
	b=gkCo+ZN3ozIlnuXo4JxuWGYUdP8VcnMeGWaEIe0KL8y3J0uFEXsmsQuiF2QlmBEQKlCy/z
	+sizwsCT1IV6SozxTYFzfX1KnrSQmpCx+DemhX5SrH16S9+LSkCuRdiHpISJX0P9WEYaSi
	Vb2VkkexybKK+PIAJbC2/hoCBdJWTOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779092375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kS4DqZ2QPY3ssAog9+U/o7f+sGAEPsoSb+Orwj9q0Jg=;
	b=l/xIq4H8SrmNpRHrwPmxVLkJ2IWBwwJwNz0kkIEgSiyHu8dH0+3Bv6PyvEIFyFkDRkoWgo
	pFKOAfZuCHpCfmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28E0B593A8;
	Mon, 18 May 2026 08:19:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OkT1CZfLCmpGHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 May 2026 08:19:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47615A0A90; Mon, 18 May 2026 10:19:30 +0200 (CEST)
Date: Mon, 18 May 2026 10:19:30 +0200
From: Jan Kara <jack@suse.cz>
To: Ian Kent <raven@themaw.net>
Cc: NeilBrown <neil@brown.name>, Horst Birthelmer <horst@birthelmer.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first
 reaper
Message-ID: <yk2hem4zwinm4glenpc74to7sm5kyriksgwn6mxh7t4saotiba@7zik7jcnbs5m>
References: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>
 <177906210551.3947082.4313294634549021141@noble.neil.brown.name>
 <bc359831-e653-4269-9d57-742b48d56d9f@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc359831-e653-4269-9d57-742b48d56d9f@themaw.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[brown.name,birthelmer.com,gmail.com,szeredi.hu,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,ddn.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hi Ian,

On Mon 18-05-26 10:55:43, Ian Kent wrote:
> On 18/5/26 07:55, NeilBrown wrote:
> > On Fri, 15 May 2026, Horst Birthelmer wrote:
> > According to the email you linked, a problem arises when a directory has
> > a great many negative children.  Code which walks the list of children
> > (such as fsnotify) while holding a lock can suffer unpredictable delays
> > and result in long lock-hold times.  So maybe a limit on negative
> > dentries for any parent is what we really want.  That would be clumsy to
> > implement I imagine.
> 
> But the notion of dropping the dentry in ->d_delete() on last dput() is
> simple enough but did see regressions (the only other place in the VFS
> besides dentry_kill() that the inode is unlinked from the dentry on
> dput()). I wonder if the regression was related to the test itself
> deliberately recreating deleted files and if that really is normal
> behaviour. By itself that should prevent almost all negative dentries
> being retained. Although file systems could do this as well (think XFS
> inode recycling) it should be reasonable to require it be left to the
> VFS.
> 
> But even that's not enough given that, in my case, there would still be
> around 4 million dentries in the LRU cache and in fsnotify there are
> directory child traversals holding the parent i_lock "spinlock" that are
> going to cause problems.

Do you mean there are very many positive children of a directory?

> That's all that much more puzzling when I see things like commit
> 172e422ffea2 ("fsnotify: clear PARENT_WATCHED flags lazily") which looks
> like it implies the child flag depends entirely on the parent state (what
> am I missing Amir?)

PARENT_WATCHED dentry flags (as the name suggests) are only caching the
information whether the parent has notification marks receiving events from
the child. So yes, the flag fully depends on the parent state.

> so why is this traversal even retained in fsnotify?

Not sure which traversal you mean but if you set watch on a parent, you
have to walk all children to set PARENT_WATCHED flag so that you don't miss
events on children...

> > But what if we move dentries to the end of the list when they become
> > negative, and to the start of the list when they become positive?  Then
> > code which walks the child list could simply abort on the first
> > negative.
> > 
> > I doubt that would be quite as easy as it sounds, but it would at least
> > be more focused on the observed symptom rather than some whole-system
> > number which only vaguely correlates with the observed symptom.
> > 
> > Maybe a completely different approach: change children-walking code to
> > drop and retake the lock (with appropriate validation) periodically.
> > What too would address the specific symptom.
> 
> Another good question.
> 
> I have assumed that dropping and re-taking the lock cannot be done but
> this is a question I would like answered as well. Dropping and re-taking
> lock would require, as Miklos pointed out to me off-list, recording the
> list position with say a cursor, introducing unwanted complexity when it
> would be better to accept the cost of a single extra access to the parent
> flags (which I assume is one reason to set the flag in the child).

The parent access is actually more expensive than you might think. Based on
experience with past fsnotify related performance regression I expect some
20% performance hit for small tmpfs writes if you add unconditional parent
access to the write path.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
