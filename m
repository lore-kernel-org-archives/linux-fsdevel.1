Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200F480357
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109378; cv=none; b=lbKjXInVbdFmMzIgYa0ca3ybLk2cLfYRSM1Fwf8bdlqzu7CToCg69f7e3jF2l0NuClPcurXVOTE8jgVZx37nF52b+++EDkY4io6I7atK63bt/YU9iRT8w66v9MqA2XTkQVu7WwdH8EOcdLXzpWVNLBj9cT/EWfMDfSZFjGtIQxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109378; c=relaxed/simple;
	bh=/6nDMfYJlcbmwvZpAUY5wX6zo6LgmRPSXaE3OIrXqWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2pswNW4BaG/fvClXOKPXsFrAEQMJM4b1I0VFYEEXn0UrEc0UJQsoWgbatBM+b43vURzxDFE/Zs59ezLwWxx3SUFyOrZ8y6qgW2BeYjd90Z6KP6gTmG/LvO2cYVeOk1BZYcRreDjWxPu17qpno7/0VVxWvXKxGTudV/F7xW8Uyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cyNixFHJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z14FOFUf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XfN8rflu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fOt95REw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cyNixFHJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z14FOFUf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XfN8rflu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fOt95REw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CACD0675D6;
	Mon, 18 May 2026 13:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779109375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObkzII2JaqHTZHIokj2Y++4VgvpMZd+Ed7H5/84HqeY=;
	b=cyNixFHJbSygkE3J3nChbI7q9h6UGTomvN3s32crn3FECQEA19vYfx93NnQjw3MJJy8CJU
	j1H9t7pOZwQnISe/X3mR8OJuSm04v2UDytMekGxVOuSqffx9yRIHTAH+G0Q91ViIIMxQ8L
	D9adCFhsnesRiNc7qgPNOmNcA08Vomo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779109375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObkzII2JaqHTZHIokj2Y++4VgvpMZd+Ed7H5/84HqeY=;
	b=z14FOFUfrLYj0gg03ohaqifKLbQWllfcGIl3zUTCOLSJoKT4YtH7SZJmOJj07jlABIcHUV
	9h/Ja8u+82a88sAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779109371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObkzII2JaqHTZHIokj2Y++4VgvpMZd+Ed7H5/84HqeY=;
	b=XfN8rflujBO2Q60Nk5cVmup764r7b5TH1NRrHGGA9d5ApSbuNYHPPwK+bE3UGxj7KHGl+E
	6Cvaj7qLOzeqnhWM+f+v4J3/IfabpSl7PSdjsAxjXX0jTgloTSQd+Y1gf/ruP3pXMyxQzF
	gnpuj4CUo+CHjPpBAtFR6C6siqd3oTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779109371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ObkzII2JaqHTZHIokj2Y++4VgvpMZd+Ed7H5/84HqeY=;
	b=fOt95REwqork6eZ0d5LOYaKuY6VqYaGEPFh+gxqhk16K4OkAbkybXIIIbYP8E6WWZitKGP
	M8oOL3BedM453ACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAB9F593A8;
	Mon, 18 May 2026 13:02:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h6srKfsNC2rhNQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 18 May 2026 13:02:51 +0000
Date: Mon, 18 May 2026 15:02:42 +0200
From: Pedro Falcato <pfalcato@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <agsJyFYLg5sd_34j@pedro-suse>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <20260518-starten-messdaten-3b8aa670ec85@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-starten-messdaten-3b8aa670ec85@brauner>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kvack.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Level: 

On Mon, May 18, 2026 at 02:20:30PM +0200, Christian Brauner wrote:
> On Sat, May 16, 2026 at 07:21:26PM +0100, Pedro Falcato wrote:
> > Since the advent of vulns like Dirty Pipe, Dirty Frag, Copy Fail
> > and Fragnasia, splicing a read-only file is fundamentally unsafe.
> > 
> > As such, as a mitigation, add a way for users to block splice() for
> > files they cannot write to. This eliminates this whole class of exploits
> > that use splice()+confusion in pipe/net/etc code to gain write-access to
> > files they can only read.
> > 
> > Users can simply toggle fs.splice_needs_write=1 and suddenly splice() will
> > refuse perfectly legal splices() from files it can only read, but not write.
> > 
> > For vmsplice(), make due with the address_space attached to the folio. Care
> > is held to make sure the operation isn't too slowed down with locks. The check
> > itself isn't entirely equivalent (the mapping's host can be the internal bdev
> > inode, etc, and not the one in /dev against which permissions are checked),
> > but doing it in a more correct way would require dropping from GUP-fast to
> > GUP, and that would be too slow.
> > 
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> > 
> > Hello,
> > 
> > sending this out as an RFC so I can get better opinions from VFS & security
> > folks upstream. I wrote this out as a way to harden against all the page
> > cache attacks we've seen lately, that bottom out to splice() from a file
> > they cannot write + confusion elsewhere on the net stack/pipes/etc.
> > 
> > This is _obviously_ not perfect and not complete. My first (unsent) version
> > straight up returned -EPERM on splice() for these files. This one attempts
> > to retain some compatibility by only blocking the page splicing operation,
> > but still issuing the operation with normal copies (kindly suggested by Jan).
> > vmsplice() is a complicated issue, because gup_fast does not allow us access
> > to the VMA's vm_file. I tried hacking around it but it's not perfect (e.g you
> > cannot grab the mnt_idmap for the file, since we only have access to the
> > address_space + its host).
> > I'm also not a fan of having somewhat hairy MM code in the middle of
> > fs/splice.c but that's something we can simply hoist elsewhere as this gets
> > un-RFC'd. It's also missing the external-facing docs for the sysctl.
> > 
> > My big questions are:
> > 1) Is this a viable way forward?
> 
> I think that splice and vmsplice() are pretty wonky apis. Ignoring it's
> recent prominent role in page cache attacks it suffers from weird issues
> due to its interactions with pipe_lock().
> 
> Bug with splice to a pipe preventing a process exit
> 20250122020850.2175427-1-kolyshkin@gmail.com
> Sendfile holding pipe->mutex blocks the peer's pipe_release() from do_exit().
> 
> Change in splice() behaviour after 5.10? (LTP splice07)
> 7F3B484F-9555-486A-B19A-5A8EB6442988@kernel.org
> 
> [PATCH v2 00/11] Avoid unprivileged splice(file->)/(->socket) pipe exclusion
> cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz
> Pending splice from tty/socket/FIFO holds pipe->mutex indefinitely, blocking all other FIFO ops incl. read(O_NONBLOCK)
> 
> splice: prevent deadlock when splicing a file to itself
> 20260320130615.1109449-1-kartikey406@gmail.com
> do_splice_direct_actor() still lacks file_inode(in) == file_inode(out) guard
> 
> AF_UNIX/zerocopy/pipe/vmsplice/splice vs FOLL_PIN
> 2135907.1747061490@warthog.procyon.org.uk
> vmsplice/splice into AF_UNIX/pipe doesn't FOLL_PIN the source memory
> 
> My main gripe with the patch as written is that I find it really hard to
> figure out who would deploy this. It half-cripples splice() and
> vmsplice() for some use-cases but leaves it intact for others.

Not just splice() and vmsplice(), but sendfile(), copy_file_range() too.
My bet (perhaps not informed enough) is that there simply aren't that many
users doing splice-like opeartions from files they do not own in some way.

(maybe not true for copy_file_range(), I admit)

> 
> At that point you can also just ENOSYS splice() and vmsplice() via
> seccomp and force a fallback on non-splice codepaths that userspace has
> to have anyway as splice() isn't supported unconditionally.

IIRC GNU grep is one simple example where they assume splice() from a pipe
to /dev/null Just Works(tm) and it exits(1) otherwise.

> It feels like a knee-jerk reaction to an exploit class originating in
> buggy modules that we have little control over and we would extend an
> API to users that is really difficult to use.
> 
> What might make more sense is to add a splice specific security_*() hook
> into the code so that an LSM can deny usage of splice in whatever way it
> wants to - bpf lsm or in-tree lsm.

I don't dislike that option, but I don't love leaving hardening to LSMs. The
kernel quite literally gets a new splice-related vulnerability every week now,
where userspace gets to pass pages it has no business passing to funky
codepaths that then write on these pages. I feel like natively restricting
what you can pass is simply a natural way forward.

> 
> Then we don't have to have all this gunk in the VFS layer that will be
> annoying to maintain with little value in the long-term. So I'm not very
> likely to pick this up as is.

Totally. That's what the RFC tag is for :)

-- 
Pedro
