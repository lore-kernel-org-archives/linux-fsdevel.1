Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A741DE8BE
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778979154; cv=none; b=OUbdw4L6KW7t4b4hxr6ymlCWZxu3+kglgIx3nC0of3yGUG3kY053YOW/0pYNtLm6YyGUUCwsVMH2UfEkt1zmCeLsfhzjhsc8bq79UfQ8VICqnnV3idU6PLk5+FymEjdJOKLGp4RnaNnxdIcdO3eV8beske9XQx21R2PGCLx6poY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778979154; c=relaxed/simple;
	bh=9n76sP5ROSAtR8XIukZpQLU0bjE6fJ25H4IxWVOU7BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O16bz9kLgg/gVzzKk23WjxMx7BEIYZuPJGw4iiD5gxmpmm43ietT6LfPIEhqhVi2JQowmEV+zDqACOjN/EiUf01njUH/7QLOxCqWL09kGy2K/y8907zO2CAd/v2wQINRG7HlSo8h6MvmMIwXykTqPJJx57ZxFpGX9mx+p7McQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rXTqKtS3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K8tXsDjw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rXTqKtS3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K8tXsDjw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rXTqKtS3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K8tXsDjw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rXTqKtS3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K8tXsDjw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D36C61C52;
	Sun, 17 May 2026 00:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778979150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgNm+GHE162l/M3+rLZxQ4Q5A14XvmlbUkDNHLqiHsk=;
	b=rXTqKtS3EuWQlJX5FG+D4OM/KwMFoVZ+RSkRRp11zIdSylOCQEMQriIsPszaT7FqPnFujv
	SFTE6HxUKqkTwE372+ivOjpbMB9IkbtZIfLVsmPhcYfCJ+9ZGrSZZhYdDm8Psi/iHTOz/5
	ZxvhRTbsZ4IpUMsag1wrd6hblvoNgEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778979150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgNm+GHE162l/M3+rLZxQ4Q5A14XvmlbUkDNHLqiHsk=;
	b=K8tXsDjwH8Huyie2WoWq03MC1RGXGTbzykdeii8hzxAA8CNYdyR1RUfPPE4SCc3/+tfW/I
	pVNPU+5wvOyMJeCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rXTqKtS3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K8tXsDjw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778979150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgNm+GHE162l/M3+rLZxQ4Q5A14XvmlbUkDNHLqiHsk=;
	b=rXTqKtS3EuWQlJX5FG+D4OM/KwMFoVZ+RSkRRp11zIdSylOCQEMQriIsPszaT7FqPnFujv
	SFTE6HxUKqkTwE372+ivOjpbMB9IkbtZIfLVsmPhcYfCJ+9ZGrSZZhYdDm8Psi/iHTOz/5
	ZxvhRTbsZ4IpUMsag1wrd6hblvoNgEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778979150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgNm+GHE162l/M3+rLZxQ4Q5A14XvmlbUkDNHLqiHsk=;
	b=K8tXsDjwH8Huyie2WoWq03MC1RGXGTbzykdeii8hzxAA8CNYdyR1RUfPPE4SCc3/+tfW/I
	pVNPU+5wvOyMJeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E110A593A8;
	Sun, 17 May 2026 00:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PFANM00RCWrBUAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Sun, 17 May 2026 00:52:29 +0000
Date: Sun, 17 May 2026 01:52:27 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <agkIJF5EiAYLWjA4@pedro-suse.lan>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <CAGudoHHeYbPWQbz+vXoS-Oi4PhxX6rh5XsMUkZetyfdnJHNj=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHeYbPWQbz+vXoS-Oi4PhxX6rh5XsMUkZetyfdnJHNj=g@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8D36C61C52
X-Spam-Level: 

On Sun, May 17, 2026 at 01:51:16AM +0200, Mateusz Guzik wrote:
> On Sat, May 16, 2026 at 8:21 PM Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > Since the advent of vulns like Dirty Pipe, Dirty Frag, Copy Fail
> > and Fragnasia, splicing a read-only file is fundamentally unsafe.
> >
> > As such, as a mitigation, add a way for users to block splice() for
> > files they cannot write to. This eliminates this whole class of exploits
> > that use splice()+confusion in pipe/net/etc code to gain write-access to
> > files they can only read.
> >
> 
> The patch touches stuff I'm not familiar with, so no comments on that front.
> 
> The core idea is a half-measure which will at best buy few weeks until
> splice bugs dry out and there will be a new attack vector du jour
> which people point their LLMs at. Perhaps it is worth it as a bandaid
> until a more complete solution shows up.

I won't say you don't have a point. However, the whole idea is to attempt to
restrict the attack vector. This is a proven source of problems. It's known
since 2022 - now we have 3 or 4 new vulnerabilities taking advantage of this.

Clearly, the kernel isn't doing great passing these pages around the kernel.
The API isn't the easiest to use (much less safely). Can those be tackled? Yes.
Today? Definitely not. In a few years? Also doubtful.

Merging something like this (or equivalent, that allows for a restriction) I
think is simply common sense. Basic hardening of interfaces so if anything
gets discovered it's much less severe. Even if nothing else related to splice()
gets discovered, I think it's still useful to have secure by default, minimally
intrusive hardening in the kernel.

One example: do you really need to be able to send SUID binaries in a zero-copy
super efficient way around the kernel? Not really. But if something fscks it up,
you get the world's easiest LPE.

(not that today they couldn't find some random UAF and attempt to exploit this,
since all of the page cache is mapped, but there are concurrent efforts e.g ASI
that attempt to tackle this)

> 
> A full-measure solution would git rm these modules to
> fuck^W^W^W^W^W^Wprevent suspicious modules from being usable by
> unprivileged users to begin with, at least by default. Of the cases I

Sadly, for the networking case it's pretty important to have autoloading
for protocol modules. Also, for the module in question (for Fragnesia it was
ESP), that's really not that arcane. It's just a piece of code that gets
confused as to whether or not it owns (versus "shares", like it should) the
pages it's looking at.

With fragnesia it's been found out that there are _several_ important spots
in the networking stack that aren't getting this shared flag propagation
correctly.

> had seen so far, your typical machine either does not have the thing
> loaded or in the worst case does not have a legitimate reason to
> expose them. Someone(tm) would have to figure out a sensible setup
> where stuff stops autoloading and there is a whitelist of modules
> allowed on the box, and even then the functionality provided is only
> usable by select people.
> 
> Back in the day I wrote a LSM which learned what kind of socket
> options etc. are being used in a given workload and afterwards only
> allowed that. The code never escaped $workplace, but the idea might be
> a starting point.

It's beyond my skillset to comment whether or not that works well in
practice :)

> 
> All that aside, is someone with access to many tokens(tm) racing the
> bad guys vs splice bugs? Realistically one has to assume there are

I would assume it's hard to race the bad guys (the typical security problem).
You get a great zero-day as a blackhat and (AIUI) you might be looking at
tens-to-even-hundreds of thousands in rewards.

But, again, not really my field of expertise :v

> some more waiting (as suggested by the patch) and chances are decent
> nobody has to be caught with their pants down even without the
> aforementioned mitigation.

-- 
Pedro
