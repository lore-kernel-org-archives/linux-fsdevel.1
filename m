Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CEB32ED3A
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525200; cv=none; b=lyPNidphyvO0cGtI3643FsTLn2hz16BO4FUtfxwzHvpZ8DfXYZCml8fZzlX/OnF0IMxJLdnuZCHupY61nVZV4VS2ggBkhsK8VVMI23NmsMmjFeg3OuJdzREWevIagh2tapy60MzPXH9D8OIxAikp+rL9q5KEVhLp8gSZbDZoQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525200; c=relaxed/simple;
	bh=ywdtWYoiW9t/iae1FPXkpzhmnWN3+UvKfR+GvEBj5oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2cy0KAuVYfwyMsc7VknW6ZvZBYzyunH9VOJY05hlUj55oEsrgcnA67+p64XFmfRGCE5bNFMTQl0YrwFoxYOthaUnT1Qd88zRSg5xQruw12XwEMtxvXjLGSfNYhTrCYABwL0SrEd6ezjIDkhVVQseMoyE3Gh+5ag7s+7THPABJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vBoy3q4P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PzqopLTh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vBoy3q4P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PzqopLTh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vBoy3q4P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PzqopLTh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vBoy3q4P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PzqopLTh"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52D50760E3;
	Wed,  8 Jul 2026 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783525197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3vGQ2CklUwYHV2HyKrHIlDi3x4AEgfI07gsoQj4jV8=;
	b=vBoy3q4P1UENaSAO+wmGPT6Wq/moUR940l5aC+4YnpMCXFl69nXgnrp0UOWV/NCxsK4Fbj
	WodTTcj4XHoM+baQ6oWHwigas5K3slub7d2+B7zG7K3dUCKjojBpOVuRLLRdZXY2f56yc3
	wv8nNFWn3DeItEoiKuyXWYDwwBbszkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783525197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3vGQ2CklUwYHV2HyKrHIlDi3x4AEgfI07gsoQj4jV8=;
	b=PzqopLThh8Lhee09HK+ZgunRfEp6/mI5leje/+o2Csy+hMLsgvd4M1GYvzA6mpbSMucYRF
	ji2cNo7Yi8+3ydAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vBoy3q4P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PzqopLTh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783525197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3vGQ2CklUwYHV2HyKrHIlDi3x4AEgfI07gsoQj4jV8=;
	b=vBoy3q4P1UENaSAO+wmGPT6Wq/moUR940l5aC+4YnpMCXFl69nXgnrp0UOWV/NCxsK4Fbj
	WodTTcj4XHoM+baQ6oWHwigas5K3slub7d2+B7zG7K3dUCKjojBpOVuRLLRdZXY2f56yc3
	wv8nNFWn3DeItEoiKuyXWYDwwBbszkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783525197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3vGQ2CklUwYHV2HyKrHIlDi3x4AEgfI07gsoQj4jV8=;
	b=PzqopLThh8Lhee09HK+ZgunRfEp6/mI5leje/+o2Csy+hMLsgvd4M1GYvzA6mpbSMucYRF
	ji2cNo7Yi8+3ydAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B970779AE;
	Wed,  8 Jul 2026 15:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I1GPIkxvTmqJRwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 08 Jul 2026 15:39:56 +0000
Date: Wed, 8 Jul 2026 16:39:54 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Aleksa Sarai <aleksa@amutable.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <ak5rHOsvtMX1j7S3@pedro-suse>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <1464441345.181098.1783418805206@kpc.webmail.kpnmail.nl>
 <akz_Ik8_eTnXav1H@pedro-suse>
 <1400609680.217714.1783433931054@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400609680.217714.1783433931054@kpc.webmail.kpnmail.nl>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 52D50760E3
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[amutable.com,kernel.org,zeniv.linux.org.uk,brown.name,gmail.com,suse.cz,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Jul 07, 2026 at 04:18:50PM +0200, Jori Koolstra wrote:
> 
> > Op 07-07-2026 15:55 CEST schreef Pedro Falcato <pfalcato@suse.de>:
> > 
> >  
> > On Tue, Jul 07, 2026 at 12:06:44PM +0200, Jori Koolstra wrote:
> > > Hi Pedro,
> > > 
> > > > Op 07-07-2026 10:35 CEST schreef Pedro Falcato <pfalcato@suse.de>:
> > > > 
> > > > Ok so I genuinely don't see how users are supposed to use O_CREAT | O_DIRECTORY.
> > > > Lets think about the portability here. This is undefined by POSIX (meaning you
> > > > cannot rely on a O_CREAT | O_DIRECTORY having particular semantics). FreeBSD
> > > > and NetBSD each have different semantics (my investigation stopped there
> > > > ~3 years ago; I vaguely remember that macOS/Darwin does not/did not support
> > > > O_DIRECTORY. I don't remember what's the deal with OpenBSD/Solaris/Illumos
> > > > here).
> > > > 
> > > > So, essentially you can't rely on _any_ common behavior between platforms.
> > > > Ok. Now, you may say "it's 2026 lol who cares about BSD". So lets look at Linux:
> > > > - Linux for most of its lifetime had "return open directory, or create
> > > >   a regular file".
> > > > - It later had the above, with the added caveat that it always returned
> > > >   ENOTDIR.
> > > > - In 2023 I then found the bug and Christian changed it to always return
> > > >   EINVAL on that combination.
> > > > 
> > > > Ok. So Linux had 3 behaviors and 2 of them do not make any kind of sense. But
> > > > that's fine, we return EINVAL now. Except that the other behaviors existed.
> > > > 
> > > > So, lets say this feature lands as-is. If you're writing something *for Linux*,
> > > > you have to contend with the previous *3 behaviors* for a grand total of 4
> > > > behaviors. Including bizarre runtime tests, lest you are running on something
> > > > pre-6.4 (system calls can be similarly problematic, but at least there its a
> > > > simple ENOSYS test).
> > > > 
> > > 
> > > But isn't this a problem with all UAPI design? You introduce a new feature that
> > > does not exist on old kernels, then userspace can use that feature but must
> > > provide fallback behaviors for any older kernel that the userspace program wants
> > > to support. Ideally, this is abstracted away by some library. Then, at some point
> > > this library raises its minimal supported kernel version bar, and it can clean-up
> > > the now obsolete fallback code.
> > 
> > Correct, but usually most new UAPIs have very simple checks:
> > 
> > if (syscall(SYS_ponies) < 0 && errno == ENOSYS) {
> > 	fallback();
> > }
> > 
> > or
> > 
> > if (ponies(NEW_FLAG) < 0 && errno == EINVAL) {
> > 	fallback();
> > }
> > 
> > (in fact, many system calls out there can even be silently emulated by the
> > libc if need be; this one can't, but that's besides the point)
> > 
> 
> Forgive my ignorance, but why can't we use uname(2) or something to detect
> kernel version and rely on that? Why must we check behavior as if it is a
> black box? Is uname(2) blocked on systems for security reasons or something?

Because it's a black box:
- Maybe this feature lands in 7.3 or 7.4 and enterprise kernels (and Android)
  backport it to older releases on request (as a random example, XFS atomic
  writes were added in 6.16, but were backported to 6.12 in SLES, and UEK 8,
  and possibly RHEL/Ubuntu too)
- Maybe the feature is posteriously reverted, disabled, changed
- Upstream LTS also does its backports, so the O_CREAT | O_DIRECTORY EINVAL
  only landed in 6.4, but was backported to 6.1, but not to 6.2 or 6.3, and
  not to 5.15 or 5.10, and the behavior will again change as soon as this
  lands
- Sometimes the kernel perfectly supports a feature but you're running under
  a tight seccomp filter that rejects unknown syscalls (or ones that it can't
  filter, like SYS_clone3), so you get a mysterious -ENOSYS that uname() will
  not be able to explain.
- You can technically even be running under the uname26 personality and now
  your uname() is completely nonsensical

Reality is really, really messy :)

> 
> > My problem isn't with adding a new uapi, it's that the flag combination has
> > so horrifically overloaded with weird semantics that it's pretty non-trivial
> > to find out conclusively whether or not you have the feature, across the recent
> > lifetime of Linux. I'm not even concerned with repurposing the flags because the
> > old semantics were so obviously BS.
> > 
> 
> How bad would it be to backport -EINVAL to the last stable kernels? I mean we know
> people didn't really rely on the weird semantics prior to that because of your
> find.

It seems Christian is pre-disposed to that.

> 
> > 
> > FWIW, thinking about this a bit more, it's possible that openat2() could serve
> > as a stricter check for the UAPI in open() in general. Making this less
> > footgunny to use.
> > 
> 
> Not sure if I follow what you mean here.

openat2() is extensible and rejects weird things already (like IFMT flags in
the mode). If you were to extend openat2() to be able to do something like
S_IFDIR | 0777 as a part of this feature, then using it would possibly be as
simple as a quick openat2() test (if no EINVAL, then normal open() will also
work).

-- 
Pedro
