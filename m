Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80793ACA42
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463786; cv=none; b=WtHFqS5tbMgCYlPBergcQGINiFIQxbZomNenZBTOvk1t5Y3qG75MrA2WrtZay+quxP9IoZkvoNjaW/Z2uYDt2u2hT2m3r7OZSUE3+qPYJDbWa0sIflBDqwgQh7WdBETCdqArwEM63RUjO2I/R0jbx17sWP/ndxcQPgA5AotONiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463786; c=relaxed/simple;
	bh=ZuAsxB5R855wT7sA4kl2qIceMYCmKMSddKoAZrfbDtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKpwUpTqtYdgc0XKmsa0ZyCBAGNV7VlNO9+rP5D40GRNRLAtuy/n0U/VPqBbl6dhWPlAOkuUI9LOa44FFxkwMBz/5g2BDjwY+vdDqBC4DMHvkto+UmrF90oztaLdGuMpLJhlrRcoZ9TqNFJNqr54yOQJdj/8voYcXjHcEAE7tB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uRia1am1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s5n53UbL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TjOe4NXx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K95oPW21; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uRia1am1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s5n53UbL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TjOe4NXx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K95oPW21"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B073D81CD9;
	Tue, 11 Aug 2026 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786463778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iECLUVQDiYeX3pk/bmx7ZeFPdWyG8V/3EA5JWKbB0cQ=;
	b=uRia1am17arTk3ksaXl3lnQhxB0YsSqw6JJis3eilLxvnzYx47Cg4Dum60zDQBSiboKH95
	CC08qeyLKANjNW4BnWgf3w+4cXt3cRJw8uAGuXurmCfHhucS8/WiI4NZ33dK9IdlkNe1KM
	//BkRbk84lEOM+ZpyeNPhD8UD2BkofE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786463778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iECLUVQDiYeX3pk/bmx7ZeFPdWyG8V/3EA5JWKbB0cQ=;
	b=s5n53UbLFVev4UBmR2w2FUkZH8p5J7te3nKgKgKhYBQnhZqWjOSZ9bMnlZB7zp+Oc5gjzp
	3nzfDkvtqPuI2LBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786463774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iECLUVQDiYeX3pk/bmx7ZeFPdWyG8V/3EA5JWKbB0cQ=;
	b=TjOe4NXxThEe3BzhkV+j3LOQAzPC0jWHdxNCoFoYeLmp3KuCTHFAZQId4Sy4Vl+2sLW6NO
	U2TqbBXCc4ftEDJXYT6BYf6HhlVngz8Fd9v0wt1AFbfaYypyjogeHeeAjsMYUx6vXZ8ntK
	2Lnhf+XIdTcgFYHslDAKKkFba54HiFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786463774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iECLUVQDiYeX3pk/bmx7ZeFPdWyG8V/3EA5JWKbB0cQ=;
	b=K95oPW21gLpkEzvdJe4TuGgbxGqhgntVeCelAuKjIm1ahiO8dRzj+hk4DS0hkihHwCkAgk
	JoRwbzCf6zrhHaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA04D779B2;
	Tue, 11 Aug 2026 15:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7gYIKh1Ge2q6eAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 11 Aug 2026 15:56:13 +0000
Date: Tue, 11 Aug 2026 16:56:11 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: vova tokarev <vladimirelitokarev@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, security@kernel.org, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Fwd: BadBunny: UFFDIO_COPY shmem killpriv bypass leading to
 local privilege escalation
Message-ID: <ans7BPymaYBVT2zy@pedro-suse>
References: <CAGBKPgOm8q-8_rwyRPEmSj8JXdh_GaK1Q8vpJ=j-+yA0SgcNQw@mail.gmail.com>
 <CAGBKPgPPALX_5CQJAKUNjwi2fD28pBeS5pRuwQgePU93pOy8EA@mail.gmail.com>
 <anXnHMInq_JLYbWc@pedro-suse.lan>
 <CAGBKPgOfbMJruqcegJca6BBpEtpd91s5ASF_VU+gucWsjwp8WA@mail.gmail.com>
 <ancYCBUT8aB0qHwz@pedro-suse.lan>
 <anlOGOmO1HWVCMdF@casper.infradead.org>
 <20260811-knieprobleme-holten-palmen-4d42742b1962@brauner>
 <CAGBKPgPanzn8WuHK1hm44FLCXwJcnk7W=J6b17D9UzScWW7SJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGBKPgPanzn8WuHK1hm44FLCXwJcnk7W=J6b17D9UzScWW7SJQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.78 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.920];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.78
X-Spam-Level: 

On Tue, Aug 11, 2026 at 02:16:31PM +0300, vova tokarev wrote:
> Matthew, Christian, Pedro,
> 
> Lol - fair point, I'll keep the reggaeton references out of future
> commit messages.
> 
> Agreed on severity - but this is a
> killpriv invariant violation, and the kernel has treated those as
> security fixes worth backporting before.
> 
> 1. The fallocate killpriv fixes (XFS fbe7e5200365, ext4, f2fs) are
>    exact precedent: same reasoning ("can change the file contents [...]
>    should drop file privileges like suid just like we do for a regular
>    write()"), same one-line fix, and they went through the security fix
>    process with CVE assignment and stable backports.
> 
> 2. CVE-2023-0386 (overlayfs SUID preservation) -- same bug class,
>    CVSS 7.8, CISA KEV.

I don't see how this is related. It looks like an entirely different bug.

> 
> 3. If permissions alone protected SUID, write() wouldn't strip it.
>    killpriv exists for POSIX ACLs granting write to non-owners,
>    group-writable SUID, container shared mounts, and chaining with
>    other write-access bugs.
> 
> 4. This path is reachable unprivileged even with
>    vm.unprivileged_userfaultfd=0 (UFFD_USER_MODE_ONLY bypasses it).
> 
> 5. Pedro's point that MAP_SHARED faults also skip killpriv isn't a
>    counterargument -- it's another instance of the same class. We can
>    fix them independently.

Again, I don't think this is a real issue. I'm happy to be proven wrong
though. Otherwise, I don't see why we should care about this, especially
in MM. All of these helpers (file_modified(), etc) require the inode lock
which, if taken with the mmap_lock/vma lock held, will result in lock
inversion; so you need to implement awkward retry loops everywhere (pin file,
release the VMA lock/mmap lock, grab inode lock, call file_modified(),
unlock inode, retry). And I don't think you can ever specify sane semantics
for mmap (but, again, who the heck cares).

I'm sure this was all a great idea in the UNIX of old in the 1980s and 90s,
I don't think this is particularly important these days. I can theorize some
particularly weird scenarios (what if file is group-writable, but setuid (so
the owner "blessed" it); group writes, setuid should no longer bless it), but
we're much closer to a world where suid is no longer a thing, than a world
where suid (and the UNIX model for users, groups) is this important.


-- 
Pedro
