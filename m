Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5E194C96
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429448; cv=none; b=SlwMRQTjSmOKaNEQTlH+lB+lVQ3PXyifBQtE/O4Bl1i5rrK4peWK7zVUMHRjGJkRIL8jUOpryJ3Z0KDEHhOfiSa+st8wWqfq+WNK0SPtyujkCPrhZb++WbunUPeuxRo7T3jf3Qw/UURwe446tdMItifs83mPSTRZ/iDLawR5fp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429448; c=relaxed/simple;
	bh=jdOlVOQNu6ZaSU8PPN+HddxcPHuB7KD5A3m8JgKY3es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBgkKMKp79EX6VCxWx3ZUHHJRndw+EEifWuJadsDF3DhzZoZNoWaKYFZrh6mb9w57wVyhuNWm6jLy1tuZKXm76re1yh2fA7xpQdcfMVjkcmGfMzv+1eQ9VU6uxez4j/O7xnJTMcI1f2hwppxKLGjOTFbZBgJsqYBpXAVY8MJD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LDzmfEr2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3voDg9Zz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LDzmfEr2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3voDg9Zz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LDzmfEr2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3voDg9Zz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LDzmfEr2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3voDg9Zz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A3B575B83;
	Tue,  7 Jul 2026 13:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783429445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TngwfjgEyBB7+6toiltv9nsXYHBVMJFAqKrQORUJ5V8=;
	b=LDzmfEr2T+FRo5lZjQxLw1e01zJndnVCRbyQysHVYllmCtwns/h7jukvJ6seRPJt4Q/ZQV
	yOfy9UySuskiCV1jRR7+4JPojk6QUh0v+9ZiYYHjfdm5yVx19LbGsGI0Bqidw7ONHdMDVS
	fyhpE3yHWs4V3OjvqmIGBhXTezr6xKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783429445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TngwfjgEyBB7+6toiltv9nsXYHBVMJFAqKrQORUJ5V8=;
	b=3voDg9Zzd3T190CAJXHBuuLWSJG3Btd7UA7/pSRo7/zUFxl2SZI4QMUtkVB5W4IrgVqkzK
	glDPziJfGculk4Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LDzmfEr2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3voDg9Zz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783429445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TngwfjgEyBB7+6toiltv9nsXYHBVMJFAqKrQORUJ5V8=;
	b=LDzmfEr2T+FRo5lZjQxLw1e01zJndnVCRbyQysHVYllmCtwns/h7jukvJ6seRPJt4Q/ZQV
	yOfy9UySuskiCV1jRR7+4JPojk6QUh0v+9ZiYYHjfdm5yVx19LbGsGI0Bqidw7ONHdMDVS
	fyhpE3yHWs4V3OjvqmIGBhXTezr6xKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783429445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TngwfjgEyBB7+6toiltv9nsXYHBVMJFAqKrQORUJ5V8=;
	b=3voDg9Zzd3T190CAJXHBuuLWSJG3Btd7UA7/pSRo7/zUFxl2SZI4QMUtkVB5W4IrgVqkzK
	glDPziJfGculk4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68384779AE;
	Tue,  7 Jul 2026 13:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id goQWFkT5TGrBFQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 07 Jul 2026 13:04:04 +0000
Date: Tue, 7 Jul 2026 14:04:02 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Jeff Layton <jlayton@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <akznq3Tzkg3XbPAc@pedro-suse>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1A3B575B83
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xs4all.nl];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,zeniv.linux.org.uk,amutable.com,brown.name,gmail.com,suse.cz,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Jul 07, 2026 at 12:04:18PM +0200, Christian Brauner wrote:
> On 2026-07-07 09:35:03+01:00, Pedro Falcato wrote:
> > Hi,
> > 
> > Sorry for comenting so late...
> > 
> > On Sat, Jul 04, 2026 at 06:41:43PM +0200, Jori Koolstra wrote:
> > 
> > > Currently there is no way to race-freely create and open a directory.
> > > For regular files we have open(O_CREAT) for creating a new file inode,
> > > and returning a pinning fd to it. The lack of such functionality for
> > > directories means that when populating a directory tree there's always
> > > a race involved: the inodes first need to be created, and then opened
> > > to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> > > but in the time window between the creation and the opening they might
> > > be replaced by something else.
> > > 
> > > Addressing this race without proper APIs is possible (by immediately
> > > fstat()ing what was opened, to verify that it has the right inode type),
> > > but difficult to get right. Hence, adding support for a new flag combo
> > > O_CREAT|O_DIRECTORY to open*(2) that creates a directory (if it does not
> > > exist already) and returns an O_DIRECTORY fd is very useful.
> > > 
> > > Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> > > a regular file exists at the open path; EISDIR if a directory exists at
> > > the path; and to create a regular file if no file exists at the path.
> > > This behaviour changed accidentally with 973d4b73fbaf ("do_last(): rejoin
> > > the common path even earlier in FMODE_{OPENED,CREATED} case") causing
> > > ENOTDIR to return in the last case while still creating the file. As
> > > this change was not detected for a long time, Brauner proposed to adopt
> > > the more consistent NetBSD behaviour, i.e. to return EINVAL on the the
> > > O_CREAT|O_DIRECTORY combination. This change was applied in 43b450632676
> > > ("open: return EINVAL for O_DIRECTORY | O_CREAT") in March, 2023. As
> > > the EINVAL behaviour has been in the kernel for about 3 year now, no
> > > rollback is expected as a result of userspace reliance on old
> > > behaviour, leaving us free to reassign the O_CREAT|O_DIRECTORY semantics.
> > 
> > Ok so I genuinely don't see how users are supposed to use O_CREAT | O_DIRECTORY.
> > Lets think about the portability here. This is undefined by POSIX (meaning you
> > cannot rely on a O_CREAT | O_DIRECTORY having particular semantics). FreeBSD
> > and NetBSD each have different semantics (my investigation stopped there
> > ~3 years ago; I vaguely remember that macOS/Darwin does not/did not support
> > O_DIRECTORY. I don't remember what's the deal with OpenBSD/Solaris/Illumos
> > here).
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
> > If you're writing something that wants to be portable, or that intends to
> > standardize on something, you have some 5 different behaviors all across
> > the FOSS UNIX landscape, not considering everything else. It's also something
> > that will, FWIW, probably never be included in POSIX because no one can agree
> > on the semantics here.
> > 
> > TL;DR I don't see, given the reasons above, how users are supposed to use
> > this without it being a total minefield.
> > 
> > If you're intent on the open() path, I would suggest that perhaps openat2()
> > would be a nice alternative, although definitely not as beautiful as
> > open(O_CREAT | O_DIRECTORY).
> > 
> > Just my 2c. And I feel horrible typing this out because you clearly spent
> > a great amount of time and effort between v2 and v3 as you redid this :/
> 
> I don't think any of this is really an argument worth considering.
> 
> This is a lot of handwaving for the sake of portability and concerns
> about past API mistakes. To both: so what. If an API is useful it's
> useful, POSIX be damned. We're not going to be fenced in by some
> standard.

Yes, POSIX be damned but some users love their portability. No one likes
to do

#ifdef __linux__
/* do something */
#elif defined(__macos__)
/* something else */
#elif defined(__FreeBSD__) || defined(__NetBSD__)
/* BSD paths */
#endif

unless it's for a damn good reason. And if you're ifdef'ing then you don't
need to use open(), you're already in strict Linux-only land.

> 
> 90% of our interfaces blow way past POSIX already - in most subsystems.
> If we'd back down ever time someone shows up with "what about POSIX"
> Linux would be irrelevant.

My point isn't that "we shall not blow past POSIX". Indeed, if we didn't
then Linux would be near useless. My point is that extending these interfaces
should be relatively ergonomic for everyone. But I do concede that this point
is relatively weak.

> 
> It's been years since O_DIRECTORY | O_CREAT has been made consistent
> which means all LTS kernels have consistent behavior. We often make flag

This is not actually (as far as I can tell) correct. Your commit dates back
to 6.4-rc1. Since then we've had 6.6, 6.12 and 6.18. However, we have 5.10,
5.15 and 6.1 which all should still have the old behavior
(per https://kernel.dance/#43b450632676, that was only backported to 6.1).

And this is of course ignoring the beautiful world of enterprise kernels :)))

> combinations work that didn't work or where inconsisent before. Nothing
> here is special at all.

So you can very much have 2 (and if you count enterprise kernels, all 3)
behaviors out in the wild, and writing code that takes advantage of 
a useful O_CREAT | O_DIRECTORY requires some pretty gnarly tests:

static bool supports_mkdir_on_open(void)
{
	struct stat buf;
	bool haz;
	int fd;

	fd = open("/tmp/whatever", O_CREAT | O_DIRECTORY, 0777);
	if (fd < 0) {
		/* linux 6.4+ behavior, unless we get any of the other EINVALs */
		if (errno == EINVAL)
			return false;
		/* 5.7 - 6.4 behavior. We don't get the mkdir either, but have the
		 * nice bit of needing to clean up the file we left behind */
		if (errno == ENOTDIR) {
			unlink("/tmp/whatever");
			return false;
		}

		/* huh */
		err(1, "unexpected error %d\n", errno);
	}

	if (fstat(fd, &buf) < 0)
		err(1, "fstat");
	/* pre-5.7, open() returns success but creates a regular file,
	 * despite O_DIRECTORY. */
	haz = S_ISDIR(buf.st_mode);
	unlinkat(AT_FDCWD, "/tmp/whatever", haz ? AT_REMOVEDIR : 0);
	close(fd);	
	return haz;
}

which need to be done either at runtime, or at ./configure time (while praying
that you're running a similar-enough kernel).

> 
> I appreciate the concern but even if this were to fall flat then
> worst-case we'd add a new flag and we'd still make that work. But I see
> no reason to not try the semantically obvious thing and make
> O_DIRECTORY | O_CREAT work.

For what it's worth, if the fugly test function moved you, I do see an easy way
forward here with openat2(). Namely, openat2(O_CREAT | O_DIRECTORY) with
mode S_IFDIR | 0777 could Just Work (and will unambiguously be rejected
in old kernels with EINVAL). Of course it doesn't work with open() :=)

Hmm, if you could use openat2() as a way to simply feature-test for this,
then suddenly open(O_CREAT | O_DIRECTORY) can also Just Work...

-- 
Pedro
