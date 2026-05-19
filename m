Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406383EFFB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181969; cv=none; b=F9iqB4krlSiv35XNZsuKZDkuS1COFtPQUf1qISV4449OF9+DZYsGVPinaxzmhu3AB7Wq4KcsHUGQRQRNLB5y8gkCsCDv8syX3cp43YDaFwMizktXU17x6WOHwXX89K2gMT2CoXE0VEOnkfoDoou6FfbTRl3BYgm0hWKBYKLGW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181969; c=relaxed/simple;
	bh=onFQ4v+FSFK2UXSilq7yV/sB/D4Z8/XdOpqBb9Xk3E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2YcebOxEhamVigr6n5W5mWzv1eaKAd3jHuUaOOiKOWeWcLVuFavWJ960pNnqq0jMjszn6am0TS9s+iVdVyi3PW03SL8bT4HTdaZ5ZLMUe8jM5GbagtlJ7+vnBjeft3Zj3/YJvtL1EZUQDafqdmCdSFmzQ9AwREJ3l45y39chKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XbGAhXBI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X6ZgIe8/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XbGAhXBI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X6ZgIe8/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XbGAhXBI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X6ZgIe8/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XbGAhXBI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X6ZgIe8/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43A9B67F29;
	Tue, 19 May 2026 09:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779181965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OapOTgqeeMhqW6YJcFJ+j8t6Yq/X2hHrIATznFjjbVc=;
	b=XbGAhXBI/QiMYRG8U49S3i/aUHqHv9uVX6HFUqDB3MwrdQEyfg9DiS6Zy2mPlItAJT2zMn
	lu7gGfHHr7C5r9r76uzaFqckqahM1Cy2hkxxW2E0ez5/OjQWOPpttSzKyEe0ZmEQuXZzUH
	0ntBxWkoYL/lk5HYq46I0Jgzz1Qp1J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779181965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OapOTgqeeMhqW6YJcFJ+j8t6Yq/X2hHrIATznFjjbVc=;
	b=X6ZgIe8/BF2YcZiNuiESI0iJepoaOwNhOBat0Ui8p3LR/d7mzitu7tICbisOUxdEcJ5NLg
	jrE9VxN/n0AccJCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XbGAhXBI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="X6ZgIe8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779181965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OapOTgqeeMhqW6YJcFJ+j8t6Yq/X2hHrIATznFjjbVc=;
	b=XbGAhXBI/QiMYRG8U49S3i/aUHqHv9uVX6HFUqDB3MwrdQEyfg9DiS6Zy2mPlItAJT2zMn
	lu7gGfHHr7C5r9r76uzaFqckqahM1Cy2hkxxW2E0ez5/OjQWOPpttSzKyEe0ZmEQuXZzUH
	0ntBxWkoYL/lk5HYq46I0Jgzz1Qp1J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779181965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OapOTgqeeMhqW6YJcFJ+j8t6Yq/X2hHrIATznFjjbVc=;
	b=X6ZgIe8/BF2YcZiNuiESI0iJepoaOwNhOBat0Ui8p3LR/d7mzitu7tICbisOUxdEcJ5NLg
	jrE9VxN/n0AccJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 391C2593A8;
	Tue, 19 May 2026 09:12:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DrDsDY0pDGq/OQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 09:12:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 69844A0ADE; Tue, 19 May 2026 11:12:44 +0200 (CEST)
Date: Tue, 19 May 2026 11:12:44 +0200
From: Jan Kara <jack@suse.cz>
To: Ian Kent <raven@themaw.net>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Horst Birthelmer <horst@birthelmer.com>, Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first
 reaper
Message-ID: <fglq7n2brxwdsu7and6nt6xpgdziua754yzgxkmd33pmk6tor4@noxa5ajva7wg>
References: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>
 <177906210551.3947082.4313294634549021141@noble.neil.brown.name>
 <bc359831-e653-4269-9d57-742b48d56d9f@themaw.net>
 <yk2hem4zwinm4glenpc74to7sm5kyriksgwn6mxh7t4saotiba@7zik7jcnbs5m>
 <b320ff9a-7f6f-44c3-940f-33f79cc5569f@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b320ff9a-7f6f-44c3-940f-33f79cc5569f@themaw.net>
X-Spam-Flag: NO
X-Spam-Score: -4.01
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,brown.name,birthelmer.com,gmail.com,szeredi.hu,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,kernel.org,vger.kernel.org,ddn.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 43A9B67F29
X-Spam-Level: 

On Mon 18-05-26 21:39:13, Ian Kent wrote:
> On 18/5/26 16:19, Jan Kara wrote:
> > Hi Ian,
> > 
> > On Mon 18-05-26 10:55:43, Ian Kent wrote:
> > > On 18/5/26 07:55, NeilBrown wrote:
> > > > On Fri, 15 May 2026, Horst Birthelmer wrote:
> > > > According to the email you linked, a problem arises when a directory has
> > > > a great many negative children.  Code which walks the list of children
> > > > (such as fsnotify) while holding a lock can suffer unpredictable delays
> > > > and result in long lock-hold times.  So maybe a limit on negative
> > > > dentries for any parent is what we really want.  That would be clumsy to
> > > > implement I imagine.
> > > But the notion of dropping the dentry in ->d_delete() on last dput() is
> > > simple enough but did see regressions (the only other place in the VFS
> > > besides dentry_kill() that the inode is unlinked from the dentry on
> > > dput()). I wonder if the regression was related to the test itself
> > > deliberately recreating deleted files and if that really is normal
> > > behaviour. By itself that should prevent almost all negative dentries
> > > being retained. Although file systems could do this as well (think XFS
> > > inode recycling) it should be reasonable to require it be left to the
> > > VFS.
> > > 
> > > But even that's not enough given that, in my case, there would still be
> > > around 4 million dentries in the LRU cache and in fsnotify there are
> > > directory child traversals holding the parent i_lock "spinlock" that are
> > > going to cause problems.
> > Do you mean there are very many positive children of a directory?
> 
> Didn't quantify that.
> 
> The symptom is the "Spinlock held for more than ... seconds" occurring in
> the log. So there are certainly a lot of children in the list, but it's
> an assumption the ratio of positive to negative entries is roughly the
> same as the overall ratio in the dcache.

OK, but that's not necessarily true. I have seen these complaints from the
kernel but in all the cases I remember it was due to negative dentries
accumultating in a particular directory. There are certain apps such as
ElasticSearch which really do like creating huge amounts of negative
dentries in one directory - they use hashes as filenames and use directory
lookup instead of a DB table lookup and lookup lots of non-existent keys...

> > > so why is this traversal even retained in fsnotify?
> > Not sure which traversal you mean but if you set watch on a parent, you
> > have to walk all children to set PARENT_WATCHED flag so that you don't miss
> > events on children...
> 
> Yes, that traversal is what I'm questioning ... again thanks.
> 
> I think the function name is still fsnotify_set_children_dentry_flags()
> in recent kernels, the subject of commit 172e422ffea2 I mentioned above.

OK, thanks.

> When you say miss events are you saying that accessing the parent dentry to
> work out if the child needs to respond to an event is quite expensive in the
> overall event processing context, that might make more sense to me ... or do
> I completely not yet understand the reasoning behind the need for the flag?

Close but not quite. The cost is the overhead of dget_parent() in
fsnotify_parent() which is often a couple of cache cold loads and atomic
instructions to find out we don't need to send any event for the current
write(2) or read(2) call. It gets worse if there are many IOs happening to
dentries in the same directory from multiple CPUs because instead of
cache-cold loads you get a cacheline contention on the parent.

> > > > But what if we move dentries to the end of the list when they become
> > > > negative, and to the start of the list when they become positive?  Then
> > > > code which walks the child list could simply abort on the first
> > > > negative.
> > > > 
> > > > I doubt that would be quite as easy as it sounds, but it would at least
> > > > be more focused on the observed symptom rather than some whole-system
> > > > number which only vaguely correlates with the observed symptom.
> > > > 
> > > > Maybe a completely different approach: change children-walking code to
> > > > drop and retake the lock (with appropriate validation) periodically.
> > > > What too would address the specific symptom.
> > > Another good question.
> > > 
> > > I have assumed that dropping and re-taking the lock cannot be done but
> > > this is a question I would like answered as well. Dropping and re-taking
> > > lock would require, as Miklos pointed out to me off-list, recording the
> > > list position with say a cursor, introducing unwanted complexity when it
> > > would be better to accept the cost of a single extra access to the parent
> > > flags (which I assume is one reason to set the flag in the child).
> > The parent access is actually more expensive than you might think. Based on
> > experience with past fsnotify related performance regression I expect some
> > 20% performance hit for small tmpfs writes if you add unconditional parent
> > access to the write path.
> 
> That sounds like a lot for what should be a memory access of an already in
> memory structure since the parent must be accessed to traverse the list of
> child entries. I clearly don't fully understand the implications of what
> I'm saying but there has been mention of another context ...

Parent dentry is of course in memory but often cache cold - you don't need
the parent to do e.g. write(2) to an already open file. You seem to be
somewhat confused about the child dentry list traversal (or maybe I'm
misunderstanding) - that happens only when placing the notification mark
but definitely not for each IO operation.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
