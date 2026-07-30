Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061443F4BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433061; cv=none; b=DchSw/N/V+z1RMk/IUyjOSJQDG4Rc0LY/jIN0ze8XjvRKcZc6Lshmh8SDK3wFAvs0wKF+OYoP1wapMQ3uB5UHH7Q10adPTpimwXy6pl+SPsnPev3PA0Fd08HK/YeSEjaSfRb/CTswmBLUvLQ8zhkz4svizfH6gBU/SvgfslIORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433061; c=relaxed/simple;
	bh=lmLFSXZJeZzjs6e2WjafdMs5Vcjcekz0yRe1DzAAEW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCMLsNk+UVvBHQJ+jKGMtjAQldPYfhTyRc0ZCa35wkcunAOaOM3EqFXp8nw3xOcizU8R+kvo0JwjhYGcHYclF8g/kJp6i8Y8k9loBhuhOlPsMoB9knjL1L7Cwa4mr90R/4hBqbm72CWssI5zLBh8udd7bDg808a1rK9OBaS+ZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z001HcP8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MBHpurHg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u7NtnlWg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KtGM8xK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z001HcP8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MBHpurHg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u7NtnlWg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KtGM8xK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 644177D645;
	Thu, 30 Jul 2026 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785433053;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7PcLkae55LhJNpeUQcnpjsV2xFkFmUXM8dWWPuA5W4=;
	b=z001HcP8wWRDo7+JcZOc6vAuglXef6X9EbnUbof1whEtKOQIK0Zt3vVYjyCPdszg3FcyEy
	Y+T0cBP5yZggY9udTnX1jg0OLaC0BOiHPVRtWNoaRgx1yDSzQU7+HOkPT9EpeYrHI2L2zd
	ie3f/1/n+CQeUsNLWpFRPTnfqn9rOrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785433053;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7PcLkae55LhJNpeUQcnpjsV2xFkFmUXM8dWWPuA5W4=;
	b=MBHpurHgTv3Czp2jk3ryfCNXjgQbo3j+XyWTU4WsBFWwE5HSksz2NYCg7BdNlMBI4DZkXK
	59St8uqFio8njXBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u7NtnlWg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2KtGM8xK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785433049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7PcLkae55LhJNpeUQcnpjsV2xFkFmUXM8dWWPuA5W4=;
	b=u7NtnlWg+owG6ebeGWmLLaJiDe07PZamtfADFWDla2mjjDQ5TvU6HaxBfJIukUNBLW9wPE
	YinN1cvmHncq4a1VsZXimyLQmQIeQQ0d1CqtFM8uH6mUJzCYkFoWy/o1+rnIoopY/PbYR6
	5lUZfyIzYcryQDEvlMNR+saCIU6/NnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785433049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7PcLkae55LhJNpeUQcnpjsV2xFkFmUXM8dWWPuA5W4=;
	b=2KtGM8xKF5KYaJ/Hh798jX5CZDos4zeNNAgNsv31oC6Isqwp4+pKTncqKlk5tGbwAx1vP4
	Mk9LUZkPfEU4L3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 525BD779CC;
	Thu, 30 Jul 2026 17:37:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jLeCE9mLa2rTVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 30 Jul 2026 17:37:29 +0000
Date: Thu, 30 Jul 2026 19:37:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Agamalt 10 <agamalt10@gmail.com>, David Sterba <dsterba@suse.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: URGENT BUGS TO FIX IN THE FILE SYSTEM, KERNEL PANICS, INT
 OVERFLOWS, ETC.
Message-ID: <20260730173719.GU10684@suse.cz>
Reply-To: dsterba@suse.cz
References: <CAMwtO3LAzbJHZXixDbYD-LGu2qe5P4zVQBD4fsqNr-P3wzAZUg@mail.gmail.com>
 <CAHk-=wjrds=Xi4SrMQocb7_kF5eyi0WOUbJ7Lb3bBbRf9gTvoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjrds=Xi4SrMQocb7_kF5eyi0WOUbJ7Lb3bBbRf9gTvoQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-1.21 / 50.00];
	SUBJ_ALL_CAPS(3.00)[73];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.21
X-Spam-Level: 
X-Rspamd-Queue-Id: 644177D645
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed, Jul 29, 2026 at 05:15:46PM -0700, Linus Torvalds wrote:
> Please do proper kernel bug reporting, which means "don't just sent to
> Linus", but figure out the maintainer etc. We have documentation about
> this all.
> 
> That filesystem isn't a serious filesystem, and that code needs a lot
> more fixing if somebody cares.
> 
> Instead of doing
> 
>         if (affs_validblock(sb, block)) {
>                 bh = sb_getblk(sb, block);
> 
> it should probably just do
> 
>         bh = affs_getblk(sb, block);
>         if (bh) {
> 
> instead, but honestly, I can't find it in myself to care about an
> unlikely error case that nobody has ever seen and reported, all in a
> legacy Amiga filesystem that nobody really uses outside of hobby Amiga
> enthusiasts.
> 
> But we do have a listed sucker^Hmaintainer for it that says "Odd
> Fixes", and this certainly counts as an odd fix.
> 
> So I'm cc'ing David and fsdevel in case there is somebody else with an
> Amiga background.

Thanks, I have a few more pending AFFS fixes, but nothing serious so
it's in the backlog. The last fix from the community was in 2020
d3a84a8d0dde4e ("affs: fix basic permission bits to actually work"). The
rest is tree-wide and recently the AI assisted reports.

> Me, I'm still bitter about those rich kids with their fancy sprites on
> their Amiga HW, which may be one reason I don't feel like fixing the
> problems in AFFS ;)

For me it was only a ZX Spectrum on a grayscale 12" TV, blissfully unaware.
