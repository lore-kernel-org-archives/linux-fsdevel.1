Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644041DEF7
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432542; cv=none; b=R1re0z/uvH4JUy0+4WTh1hmziwDKWLFZ7w0U8hTHpTlTccEOtsgHVrSy1WWmqahJU1erJoJSrxl2D1cuawBY1VXaeIRdydsVFUWzPwxyL9rwVoZb6ejB+pjySX+zJ+caqqFu0oLFhaaRIWl5gaqBbEd3jVxOI2ib7W+gaOlD40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432542; c=relaxed/simple;
	bh=4oaxy6bT1jWcE/uPUMiI+9n4Sg+TK2snSvYlG0JZf70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+FHKWsWfA8V7pkieKy98T16JTBFHOvpWNQVXI964n2wTzI5hCqBvwwh2CnH29Gg9W1zU7y8gBhiVEYSdlCoRUsrdZjCJdL3/c9obsSqavIrntBMCgoSpYcxdNv2xGyMFXJE/as3RHfpl93n3watkLpOH20MlM6AB1EyuOml+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=12s9b6/J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nPl9tdS6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=12s9b6/J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nPl9tdS6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="12s9b6/J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nPl9tdS6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="12s9b6/J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nPl9tdS6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95F8E75D25;
	Tue,  7 Jul 2026 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783432538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOzFNv/JdSO0/cxvymA2DV/I37x3Xd4ZS3LvN1Wbd5M=;
	b=12s9b6/Jje2MlwFRqlao13viZGxtInCNEFLUWU+PeMi7OlaEWYej3mHLJWkZs92Zrd/OFm
	1zFwVkPFvur3tn/aenOnAQdHtnnVylAutuYWUUzu6Tb93dOZCTM+kRMSUApSiW2xQ7RGmF
	1l0QPt+XZ7BfHi7vP1C72Q2jUhiNW58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783432538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOzFNv/JdSO0/cxvymA2DV/I37x3Xd4ZS3LvN1Wbd5M=;
	b=nPl9tdS6BxkQG/8YNQDNNNSgr97W1FDCLU59cOlxkA1t18Z+VibVqsA7xmUv3Eobuxkuwb
	NrDPnl+WomVoH8Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783432538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOzFNv/JdSO0/cxvymA2DV/I37x3Xd4ZS3LvN1Wbd5M=;
	b=12s9b6/Jje2MlwFRqlao13viZGxtInCNEFLUWU+PeMi7OlaEWYej3mHLJWkZs92Zrd/OFm
	1zFwVkPFvur3tn/aenOnAQdHtnnVylAutuYWUUzu6Tb93dOZCTM+kRMSUApSiW2xQ7RGmF
	1l0QPt+XZ7BfHi7vP1C72Q2jUhiNW58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783432538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOzFNv/JdSO0/cxvymA2DV/I37x3Xd4ZS3LvN1Wbd5M=;
	b=nPl9tdS6BxkQG/8YNQDNNNSgr97W1FDCLU59cOlxkA1t18Z+VibVqsA7xmUv3Eobuxkuwb
	NrDPnl+WomVoH8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC738779AE;
	Tue,  7 Jul 2026 13:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zEaFMlkFTWp4SAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 07 Jul 2026 13:55:37 +0000
Date: Tue, 7 Jul 2026 14:55:35 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Aleksa Sarai <aleksa@amutable.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <akz_Ik8_eTnXav1H@pedro-suse>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <1464441345.181098.1783418805206@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464441345.181098.1783418805206@kpc.webmail.kpnmail.nl>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xs4all.nl];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amutable.com,kernel.org,zeniv.linux.org.uk,brown.name,gmail.com,suse.cz,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.80

On Tue, Jul 07, 2026 at 12:06:44PM +0200, Jori Koolstra wrote:
> Hi Pedro,
> 
> > Op 07-07-2026 10:35 CEST schreef Pedro Falcato <pfalcato@suse.de>:
> > 
> > Ok so I genuinely don't see how users are supposed to use O_CREAT | O_DIRECTORY.
> > Lets think about the portability here. This is undefined by POSIX (meaning you
> > cannot rely on a O_CREAT | O_DIRECTORY having particular semantics). FreeBSD
> > and NetBSD each have different semantics (my investigation stopped there
> > ~3 years ago; I vaguely remember that macOS/Darwin does not/did not support
> > O_DIRECTORY. I don't remember what's the deal with OpenBSD/Solaris/Illumos
> > here).
> > 
> > So, essentially you can't rely on _any_ common behavior between platforms.
> > Ok. Now, you may say "it's 2026 lol who cares about BSD". So lets look at Linux:
> > - Linux for most of its lifetime had "return open directory, or create
> >   a regular file".
> > - It later had the above, with the added caveat that it always returned
> >   ENOTDIR.
> > - In 2023 I then found the bug and Christian changed it to always return
> >   EINVAL on that combination.
> > 
> > Ok. So Linux had 3 behaviors and 2 of them do not make any kind of sense. But
> > that's fine, we return EINVAL now. Except that the other behaviors existed.
> > 
> > So, lets say this feature lands as-is. If you're writing something *for Linux*,
> > you have to contend with the previous *3 behaviors* for a grand total of 4
> > behaviors. Including bizarre runtime tests, lest you are running on something
> > pre-6.4 (system calls can be similarly problematic, but at least there its a
> > simple ENOSYS test).
> > 
> 
> But isn't this a problem with all UAPI design? You introduce a new feature that
> does not exist on old kernels, then userspace can use that feature but must
> provide fallback behaviors for any older kernel that the userspace program wants
> to support. Ideally, this is abstracted away by some library. Then, at some point
> this library raises its minimal supported kernel version bar, and it can clean-up
> the now obsolete fallback code.

Correct, but usually most new UAPIs have very simple checks:

if (syscall(SYS_ponies) < 0 && errno == ENOSYS) {
	fallback();
}

or

if (ponies(NEW_FLAG) < 0 && errno == EINVAL) {
	fallback();
}

(in fact, many system calls out there can even be silently emulated by the
libc if need be; this one can't, but that's besides the point)

My problem isn't with adding a new uapi, it's that the flag combination has
so horrifically overloaded with weird semantics that it's pretty non-trivial
to find out conclusively whether or not you have the feature, across the recent
lifetime of Linux. I'm not even concerned with repurposing the flags because the
old semantics were so obviously BS.

> 
> I am fairly positive for instance that libpathrs would like to use O_CREAT | O_DIRECTORY,
> but it is not going to demand kernel > 7.x anytime soon.

so it will handroll its own tests for the feature which may or may not be
wrong.

> 
> 
> > If you're writing something that wants to be portable, or that intends to
> > standardize on something, you have some 5 different behaviors all across
> > the FOSS UNIX landscape, not considering everything else. It's also something
> > that will, FWIW, probably never be included in POSIX because no one can agree
> > on the semantics here.
> > 
> 
> I have no idea how POSIX standardizes things. Does a committee get together and
> revisit old syscalls every now and then?

In theory: System X thinks up a useful feature, systems Y, Z think it's
useful and also implement it. Once there is some sort of consensus, it's
added to POSIX. Remaining systems implement it.

(this is how stuff like O_DIRECTORY and OFD locks landed from Linux to POSIX to
every other UNIX-like)

> 
> But yeah, I think POSIX compliance isn't something we are really doing anymore.

The vast majority of the kernel is compliant, and a great portion of software
uses mostly/only portable interfaces.

> Afaik there's nothing in POSIX about openat2(2) either, and we definitely wish
> people would move to that instead of keep relying on open(2) (or even better,
> use libpathrs!)

Hah, good luck! :)

> 
> > TL;DR I don't see, given the reasons above, how users are supposed to use
> > this without it being a total minefield.
> > 
> > If you're intent on the open() path, I would suggest that perhaps openat2()
> > would be a nice alternative, although definitely not as beautiful as
> > open(O_CREAT | O_DIRECTORY).
> > 
> 
> Christian told me (somewhere on this list) that at LSFMMBPF all vfs maintainers
> agreed on the O_CREAT | O_DIRECTORY direction. It allows to use all the neat
> options from openat2(2) at the cost of a bit of multiplexing in lookup_open().
> The question remains whether we also want the other things like mknodat_fd().


FWIW, thinking about this a bit more, it's possible that openat2() could serve
as a stricter check for the UAPI in open() in general. Making this less
footgunny to use.

> 
> > Just my 2c. And I feel horrible typing this out because you clearly spent
> > a great amount of time and effort between v2 and v3 as you redid this :/
> > 
> 
> It's been a lot of work, yes :)
> 
> But luckily it has allowed me to study path resolution and the open()/mkdir()/etc.
> syscalls in a fun and educative way.

Yay!

-- 
Pedro
