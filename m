Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89019325494
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413315; cv=none; b=heHClOHLTRX+b2pFOX0HcLgCGlmZaN7psVXIReX2XfHhrb51zW87EdxbKuRGJBa2QgB713PyRycOFPKZSVkY/IpOxCm7xgWM9kGDMI8itxCvz+xdSfakS3QoPbWmcvl1FvanrRXCJ8IUw2xJ+xmfdQneQHpKe01rIDUvpKClV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413315; c=relaxed/simple;
	bh=gkMVOpBJGxXTADkur3l2V4Y+JGvViJ0AVHCKFaIfAIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5bjEAnWxRepf2vF4PiIGnw9q4OR1hoZyYqMRQ2/7Qn1/WpcDwZBkkYi8M1miSkZ6wCnEnuo6LZot+EJslZBnlXkr6Z/sqW6MStUTfHcO9vKyXttaQ3rTO5TBktUOOZ4Qt85MQm438XhHqPEdie+9FUuCzR6hO8PgBADHFuLN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cOvLxyjJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r/sHz3bL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cOvLxyjJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r/sHz3bL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cOvLxyjJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r/sHz3bL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cOvLxyjJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r/sHz3bL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4CC175ABC;
	Tue,  7 Jul 2026 08:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783413305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=474jpl+ZGhYm9oK23xJUrPj+p82PJeVlVSVezw3V0oo=;
	b=cOvLxyjJzMtsWVV/3MRk0VhIUt+tuzScsO+krcbG7XYEXziL7CyWN8C2xI6kGiDmsiZNl7
	BVtJ7ZQQi9OkxEc60eY5rzuRpETbGNjd2mYFX0c7psBARxSn6HSBwJqv1N9eE05tkTgSrJ
	F+V9uEPeDaZ+f8McZ0VkFn7DC8Wc3JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783413305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=474jpl+ZGhYm9oK23xJUrPj+p82PJeVlVSVezw3V0oo=;
	b=r/sHz3bLDu/gJzOlUood0KiNJfabRe8S11EI6ukT4+yFFvoGoNpe9/VbfYqdUXlHnIi+rA
	c5unYwhJGpTnLGBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cOvLxyjJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="r/sHz3bL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783413305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=474jpl+ZGhYm9oK23xJUrPj+p82PJeVlVSVezw3V0oo=;
	b=cOvLxyjJzMtsWVV/3MRk0VhIUt+tuzScsO+krcbG7XYEXziL7CyWN8C2xI6kGiDmsiZNl7
	BVtJ7ZQQi9OkxEc60eY5rzuRpETbGNjd2mYFX0c7psBARxSn6HSBwJqv1N9eE05tkTgSrJ
	F+V9uEPeDaZ+f8McZ0VkFn7DC8Wc3JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783413305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=474jpl+ZGhYm9oK23xJUrPj+p82PJeVlVSVezw3V0oo=;
	b=r/sHz3bLDu/gJzOlUood0KiNJfabRe8S11EI6ukT4+yFFvoGoNpe9/VbfYqdUXlHnIi+rA
	c5unYwhJGpTnLGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04872779AE;
	Tue,  7 Jul 2026 08:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2+5tOTi6TGrJDAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 07 Jul 2026 08:35:04 +0000
Date: Tue, 7 Jul 2026 09:35:03 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <akyyqnv9EpY7xVdC@pedro-suse.lan>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704164149.3480051-10-jkoolstra@xs4all.nl>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,amutable.com,brown.name,gmail.com,suse.cz,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B4CC175ABC
X-Spam-Score: -4.51

Hi,

Sorry for comenting so late...

On Sat, Jul 04, 2026 at 06:41:43PM +0200, Jori Koolstra wrote:
> Currently there is no way to race-freely create and open a directory.
> For regular files we have open(O_CREAT) for creating a new file inode,
> and returning a pinning fd to it. The lack of such functionality for
> directories means that when populating a directory tree there's always
> a race involved: the inodes first need to be created, and then opened
> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> but in the time window between the creation and the opening they might
> be replaced by something else.
> 
> Addressing this race without proper APIs is possible (by immediately
> fstat()ing what was opened, to verify that it has the right inode type),
> but difficult to get right. Hence, adding support for a new flag combo
> O_CREAT|O_DIRECTORY to open*(2) that creates a directory (if it does not
> exist already) and returns an O_DIRECTORY fd is very useful.
> 
> Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> a regular file exists at the open path; EISDIR if a directory exists at
> the path; and to create a regular file if no file exists at the path.
> This behaviour changed accidentally with 973d4b73fbaf ("do_last(): rejoin
> the common path even earlier in FMODE_{OPENED,CREATED} case") causing
> ENOTDIR to return in the last case while still creating the file. As
> this change was not detected for a long time, Brauner proposed to adopt
> the more consistent NetBSD behaviour, i.e. to return EINVAL on the the
> O_CREAT|O_DIRECTORY combination. This change was applied in 43b450632676
> ("open: return EINVAL for O_DIRECTORY | O_CREAT") in March, 2023. As
> the EINVAL behaviour has been in the kernel for about 3 year now, no
> rollback is expected as a result of userspace reliance on old
> behaviour, leaving us free to reassign the O_CREAT|O_DIRECTORY semantics.

Ok so I genuinely don't see how users are supposed to use O_CREAT | O_DIRECTORY.
Lets think about the portability here. This is undefined by POSIX (meaning you
cannot rely on a O_CREAT | O_DIRECTORY having particular semantics). FreeBSD
and NetBSD each have different semantics (my investigation stopped there
~3 years ago; I vaguely remember that macOS/Darwin does not/did not support
O_DIRECTORY. I don't remember what's the deal with OpenBSD/Solaris/Illumos
here).

So, essentially you can't rely on _any_ common behavior between platforms.
Ok. Now, you may say "it's 2026 lol who cares about BSD". So lets look at Linux:
- Linux for most of its lifetime had "return open directory, or create
  a regular file".
- It later had the above, with the added caveat that it always returned
  ENOTDIR.
- In 2023 I then found the bug and Christian changed it to always return
  EINVAL on that combination.

Ok. So Linux had 3 behaviors and 2 of them do not make any kind of sense. But
that's fine, we return EINVAL now. Except that the other behaviors existed.

So, lets say this feature lands as-is. If you're writing something *for Linux*,
you have to contend with the previous *3 behaviors* for a grand total of 4
behaviors. Including bizarre runtime tests, lest you are running on something
pre-6.4 (system calls can be similarly problematic, but at least there its a
simple ENOSYS test).

If you're writing something that wants to be portable, or that intends to
standardize on something, you have some 5 different behaviors all across
the FOSS UNIX landscape, not considering everything else. It's also something
that will, FWIW, probably never be included in POSIX because no one can agree
on the semantics here.

TL;DR I don't see, given the reasons above, how users are supposed to use
this without it being a total minefield.

If you're intent on the open() path, I would suggest that perhaps openat2()
would be a nice alternative, although definitely not as beautiful as
open(O_CREAT | O_DIRECTORY).

Just my 2c. And I feel horrible typing this out because you clearly spent
a great amount of time and effort between v2 and v3 as you redid this :/

-- 
Pedro
