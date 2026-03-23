Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F74397689
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265207; cv=none; b=Z1Y/2OLmNIiKCEqMIEOYX0+SIILucPWhCUy/Ag2TAovYMrIhnmgj2TzMr3+LmxUZ/pVShXfNSa/t9w7INyXq4aln8Vy1UJRa0scLS8z/lnWQaioWKxhc8BugM2a8ZXDvBvmFPYRtk4T0hXaF9m/BcyMIwPBOmbTSLwcHXIZVxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265207; c=relaxed/simple;
	bh=s7FbZSGSFl4R35DzHs9ebkgY6i12r6hArBu0SjX294U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP0SM4Ser4uz5Ep2KQAVjA0GXZh3Czy1gC7HeyOHd45l6mTCNI6mYcGIaLG8B1yRRxqUodJN54lV7ncQB5KnWT5sbHWA7siDYrbAT60Nl32ZJiXNY11sSrxn73+ENvlpHQj1uSX1PonNntbXFUmsV9xfmkoY+SapuXTvtOSZ5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sKtvEIJt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Wkoisyc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sQgL2gku; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I+lLQApd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKtvEIJt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Wkoisyc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sQgL2gku";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I+lLQApd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C67664D35D;
	Mon, 23 Mar 2026 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774265200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzA1OazZvduyDc8iwHx/Ga49/szQshIWrDuiSqg2t4w=;
	b=sKtvEIJtBsUjTzKOOos/1/Ti9TUtyClWI2+muzVaSsHsnzJQwe6A7P6f3J6eVuWbm4rK6K
	i+sFqbkdVL9C2QS105JUK3t7Paq/s1qBLc/i6ew7PT52uG/1zP6RGR7JWTsuznNMKdqLdI
	filHzzTQ+21jCCnme8Xlezu3IKHM0Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774265200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzA1OazZvduyDc8iwHx/Ga49/szQshIWrDuiSqg2t4w=;
	b=3WkoisycAWH5iN7oW1L58d6wLBKI4YuBh1Dlu4Ed3EIoX3v/lK3HrgfGp2yqifWyMhbZT9
	K+b0VabhoRBClIBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sQgL2gku;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=I+lLQApd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774265199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzA1OazZvduyDc8iwHx/Ga49/szQshIWrDuiSqg2t4w=;
	b=sQgL2gkuQoZMRqU7wvdyZ2ohtvJVYfzbThRCorseEOwIeYf3Njh+FqZZfkyjIYZcneTZdb
	KSSM5YtL1J4y4q2aAoLlXkMEGX0JNx2fwkMggGeQNkEZU6Tm7Za0ybnMu7QK+tJXh5Th0t
	Vgg2uiN0cbRIORnHuEZsgv0JPuEpDdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774265199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzA1OazZvduyDc8iwHx/Ga49/szQshIWrDuiSqg2t4w=;
	b=I+lLQApdNuK2W2r/9cF1C9nJrXE0CMUZZRi8UamJPcBJnEFoABu6/k4SSY9BBayPp+ne48
	C8YKjwQZCSeGxcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCCE243852;
	Mon, 23 Mar 2026 11:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qz8SLm8jwWnVXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 11:26:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 698ADA0B2E; Mon, 23 Mar 2026 12:26:35 +0100 (CET)
Date: Mon, 23 Mar 2026 12:26:35 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: replace deprecated strcpy in
 fanotify_info_copy_{name,name2}
Message-ID: <niouvteqpcdthu2gptw3f4izu7qnb7pzgxqg7e7olkfh2m5yrf@npprjnfd5typ>
References: <20260321210544.519259-4-thorsten.blum@linux.dev>
 <jdyy4txjjlmbwofqbsvpk53yx6cvx5lto47guv3nevpiflylhc@vjyncn6aesh3>
 <20260323-frohsinn-rudel-2f5a8bbae433@brauner>
 <CAOQ4uxgHuZvYfw2nZV+1h5L=_Q37jbMR2YhgN0fhX=+ciif3Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgHuZvYfw2nZV+1h5L=_Q37jbMR2YhgN0fhX=+ciif3Rg@mail.gmail.com>
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
	URIBL_BLOCKED(0.00)[linux.dev:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,linux.dev:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C67664D35D

On Mon 23-03-26 12:00:27, Amir Goldstein wrote:
> On Mon, Mar 23, 2026 at 11:12 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Mar 23, 2026 at 10:14:24AM +0100, Jan Kara wrote:
> > > On Sat 21-03-26 22:05:47, Thorsten Blum wrote:
> > > > strcpy() has been deprecated [1] because it performs no bounds checking
> > > > on the destination buffer, which can lead to buffer overflows. Replace
> > > > it with the safer strscpy().
> > > >
> > > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > >
> > > I was a bit undecided about this one because I was wondering what
> > > additional protection does the use of strscpy() bring here. But I guess the
> > > protection from corrupted qstr (where the length doesn't match the real string
> > > length) makes some sense. So I've taken the patch into my tree. Thanks!
> >
> > Fwiw, patches are now auto-tested on vfs-ci:
> > https://github.com/linux-fsdevel/vfs/pull/860
> > Just for some testing data. We should probably hook up the relevant LTP
> > tests for fanotify there as well.
> 
> That would be cool :)
> 
> I guess for vfs you would would to run these LTP test groups
> $ ls runtest/fs*
> runtest/fs  runtest/fs_bind  runtest/fs_perms_simple  runtest/fs_readonly
> 
> fanotify tests are currently only in the syscalls group.
> 
> I could create an fsnotify test group or
> we could try to create a vfs focused group such as fs_syscalls,
> but actually, at a quick glance, it looks like ~75% are fs related syscalls.

Some of the LTP tests do take noticeable amount of time so I'm not sure if
we want to run all of them for each commit. Ideally tests would be selected
based on modified code but maybe that's a bit of overengineering (but it
might be an interesting project for AI to write a script that based on gcov
data outputs a set of tests to run for given patch :)).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
