Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E043DA20;
	Fri,  4 Sep 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515762; cv=none; b=huzT+CWXWOjvqgc/I5HHa6exflbnDg9nzPI1ui96fVbXcOShqy6+oLDeT2B8wDFDIGVU+LvEXM3Qvi/R2AilA/WdBpnNJWThQQVA21TNdDBsDdD/E4suTvoptg7wv+Rm/fSw6CWeOxHVF9NLt957v46kczvCilms7Ax/nOh4BL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515762; c=relaxed/simple;
	bh=gnIBxKwtZtizljDf8ntnc5PsKurT8mkgOoph4B8t5LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbxFg/mWx5P+eMcgC06t66AksZNRSP9l9//LF0g4naWePOErCzJq24Qq2vTtCOg2xJzaCWTCxXNYvBkCzBF/e6kT0z+WAAArc9GhyMEnRqGpEW+nX9qXFysJAZzjT3Tr3Ajb+vsp+tjt2+tHHAEYf6fvM3FXPeSvfXK9yvF3N28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0UfkgZLG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+4h++arR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ad1QSPu6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BNvHZQEx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0UfkgZLG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+4h++arR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ad1QSPu6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BNvHZQEx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 32E891F7C1;
	Fri,  4 Sep 2026 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788515754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWnOsR3taajAx5HxQdLrn4oIj0S+37+jF+NaGCzhb2U=;
	b=0UfkgZLGuceFVSXFhOXCo3bxuMJ/ajW/SjffHOn74F0at0FcRmV49AeQ5hyGC83Kd2rkz/
	SCA+luHV89CZ9lAPn0tgbT98Y+Ggnw1dXkF73z5Y67zcXenuB2IGg/aSkVXNnR/zXtNFsU
	g5YRfJTfTDBzKarYT0aJUsfOciJr8b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788515754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWnOsR3taajAx5HxQdLrn4oIj0S+37+jF+NaGCzhb2U=;
	b=+4h++arRnl4FJbmh9/Vyp9J7QnfSbWLNoe3HTDCMTwA/eiG0QbkUvjvH0NU0guqMHpeh/q
	hjDf1JNztScsFEBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ad1QSPu6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BNvHZQEx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788515750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWnOsR3taajAx5HxQdLrn4oIj0S+37+jF+NaGCzhb2U=;
	b=ad1QSPu6lJxN90Ow+Xg3moi/PVFKz5+jCa6LpBWejhp/Q5swAHdJSOy3FQk6VShnYjXheu
	yrZGoxs9tbdRDgCDvWI+gZSd9tSOZMp5TJV5+RkaxnROpL63+vI+41Oi6SsCR5zUHnKSeg
	5ExFBG+qWtL670H8SE7qFSX59co5esY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788515750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWnOsR3taajAx5HxQdLrn4oIj0S+37+jF+NaGCzhb2U=;
	b=BNvHZQExiGh1+LTbXnIpigowoCkEO/5O6Uic8NBtADtD4i1BYpJjQfjdWuwJsqdnxuiZBd
	5w+stBh0rXm9TMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10CAA13678;
	Fri,  4 Sep 2026 09:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t8IUBKaVmmqEKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Sep 2026 09:55:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9CC8CA13CE; Fri, 04 Sep 2026 11:55:45 +0200 (CEST)
Date: Fri, 4 Sep 2026 11:55:45 +0200
From: Jan Kara <jack@suse.cz>
To: Tigran Aivazian <aivazian.tigran@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>, 
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, David Howells <dhowells@redhat.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Theodore Ts'o <tytso@mit.edu>, 
	Catalin Iacob <iacobcatalin@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Andrew Lunn <andrew@lunn.ch>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Andrei Vagin <avagin@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	Bhavik Sachdev <b.sachdev1904@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Wang Yan <wangyan01@kylinos.cn>, Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, 
	Malaya Kumar Rout <malayarout91@gmail.com>, linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] bfs: remove the filesystem
Message-ID: <35dsgpk5dsh6bm4xoblrq6hdslfvtuibl5grzag37cye2hgepk@rkrtkjxdyk5g>
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
 <CAK+_RL=RHfRLDc=Ldjx1p8KTHSKeELjnBpxEqYjwWX_8ur1hOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+_RL=RHfRLDc=Ldjx1p8KTHSKeELjnBpxEqYjwWX_8ur1hOw@mail.gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 32E891F7C1
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[42];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,infradead.org,ellerman.id.au,kernel.org,suse.cz,posteo.de,linux-m68k.org,redhat.com,alpha.franken.de,mit.edu,networkplumber.org,lunn.ch,orcam.me.uk,linux-foundation.org,kylinos.cn,vger.kernel.org,lists.ozlabs.org,lwn.net,linux.ibm.com,zeniv.linux.org.uk];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLx5fqm8k6as49t7tzapjazi4f)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Score: -2.51

Hello!

On Fri 04-09-26 09:51:10, Tigran Aivazian wrote:
> On Fri, 4 Sept 2026 at 09:30, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
> >
> > BFS (not to be confused with BeFS, the BeOS filesystem) is the
> > filesystem UnixWare uses for its boot partition. It has extremely
> > limited functionality, only supporting contiguous files and no
> > subdirectories. Even though the bfs driver is very small and is
> > unlikely to cause future maintenance problems, given that the only type
> > of data stored on such a partition is likely to be kernels and
> > bootloader settings, there is very little reason anyone would want to
> > access it from Linux. Other old Unix filesystems (efs, freevxfs) have
> > been removed recently, and bfs is highly unlikely to have any users, so
> > remove it as well. Retain the UAPI header to be safe.
> 
> You are right that probably no one would want to use BFS for storing the
> actual data today. But some things have didactical value, rather than
> mere pragmatic usage. It is the didactic value of MINIX (and its
> limitations wrt making use of the wonderful capabilities of i386) that
> has originally triggered the creation of Linux. But back to BFS: it is
> actually used in Steve Pate's book "Linux Filesystems" (2024, unfinished
> yet), which is a sequel to his excellent classic "UNIX Filesystems"
> (2003), as an illustration of a particularly simple filesystem
> implementation.

So I agree BFS is simple. In fact so simple that I was confused by how it
can get away with not implementing certain bits when having to modify it
couple months ago when doing some fs-wide fixes :). Regarding didactical
value, we currently also have minix and ext2 implementations more or less
for educational purposes so frankly, I don't think we need a third one.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
