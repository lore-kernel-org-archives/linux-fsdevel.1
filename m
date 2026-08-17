Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1143F8AE
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978478; cv=none; b=BQ7BChTKtNVN1kizrxsIqo1TyPD9xBNX/EwJGjBRotpwF3sw98K9NXwCYUqjcodyoPIdciJL5umQouTA0fckgOxL1hm3oTzrX/NW/r0tydonG39VmJGGAwnja9eqGQ7lgBFDptdi4vIfFrb2PR4NWHVNIOc0YKP7PZ/EhsDpu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978478; c=relaxed/simple;
	bh=su0dcYxxJLdxeTeTHT48ITtTvMswx1DVepCnd54KyKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjzKDYKAIPC+eDm+7acaU+tSz4LM/4ZDe8bftMBmwXBZlzur+uTcYrII5FEsMGDM2X7Q8trxkl98siubgNbwt6CE9fYIWFYoPyBPT5jRKz9k4yylxzVwumhb7yy+MwLdTsEweDf/T4AbJuHk75e7xp6fYFhuM0sBGMZwiOZubek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uIUBzB05; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xoehDUr5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mW/PgIhI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Vldl4kH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uIUBzB05";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xoehDUr5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mW/PgIhI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Vldl4kH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA8333CCD;
	Mon, 17 Aug 2026 14:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786978396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpOjLp52EifagBnpZ/4guSYkhgxu0erpf0alM3JApi0=;
	b=uIUBzB05QVPknq00o56pxRbPJsT1vL7Dhc3HsSTc3ywa8bbXn+TMeLDhWbMvX2BQ0dFSSr
	dbtJM5YKBwlrNMHoSy2nUZ3BOsIh71FHu2XE0HmjMhEE/+/luYbiInZh3r5jg2D228VDsN
	U0xZCzPtczTF2qVud+Ydbjqji8veTds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786978396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpOjLp52EifagBnpZ/4guSYkhgxu0erpf0alM3JApi0=;
	b=xoehDUr5BMZ3ItHOrdb4BnoT5SHW50FCloyJzvmqmaf/DZAFqS12uteL5EHi6DqHDExhEI
	4urxXmqXB5l7X8Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786978392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpOjLp52EifagBnpZ/4guSYkhgxu0erpf0alM3JApi0=;
	b=mW/PgIhIzeHttQi8xdup3NiKRaUDjgu7aiYQ1QeGHVvrrdkqSnL9kBcv5mn/YnF4+yD4bM
	NJakosw8VjVwq/MVjHtwBldQXkvgA53e00m+XH/EQGtQzdAN5LYxavwhWkwYi5wbz2ic9J
	HmU+AYtz7o0aKOvKAy6v1f9sX7lPM7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786978392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpOjLp52EifagBnpZ/4guSYkhgxu0erpf0alM3JApi0=;
	b=1Vldl4kHu/viiCCFohYYvFlgy2raPLcdQ0bwWNf7r475taSFY4kKnmSpkYq04qIMKuHzJh
	/o+cTEfHqVTLMoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF3B279505;
	Mon, 17 Aug 2026 14:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rkfAKlggg2pUGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Aug 2026 14:53:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4F645A13B5; Mon, 17 Aug 2026 16:53:08 +0200 (CEST)
Date: Mon, 17 Aug 2026 16:53:08 +0200
From: Jan Kara <jack@suse.cz>
To: vova tokarev <vladimirelitokarev@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Pedro Falcato <pfalcato@suse.de>, akpm@linux-foundation.org, 
	security@kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Fwd: BadBunny: UFFDIO_COPY shmem killpriv bypass leading to
 local privilege escalation
Message-ID: <trv2wwdwprrebu4s6i2ufepk5a5ir4edz3tnttv7ivlkzihx3e@zq6lt67oplc5>
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
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 11-08-26 14:16:31, vova tokarev wrote:
> Matthew, Christian, Pedro,
> 
> Lol - fair point, I'll keep the reggaeton references out of future
> commit messages.
> 
> Agreed on severity - but this is a
> killpriv invariant violation, and the kernel has treated those as
> security fixes worth backporting before.

I tend to agree this would be good to fix for consistency as much as I also
don't think this is a particularly serious issue. Removing SUID bits on
write is more of a hardening measure than serious security guarantee and is
there mostly for historical reasons AFAIK from the old Unix days.  POSIX
for write(2) mentions this as: "Upon successful completion, where nbyte is
greater than 0, write() shall mark for update the st_ctime and st_mtime
fields of the file, and if the file is a regular file, the S_ISUID and
S_ISGID bits of the file mode may be cleared." truncate(), chmod(), chown()
have similar notes. No mention of this when handling mmap BTW :).

Anyway, the problem with calling __file_remove_privs() when writing through
mmap is with the implementation - in particular the locking. To be able to
call __file_remove_privs() we need to hold i_rwsem and that ranks above VMA
locks / mmap_lock we hold during the page fault. Now that I'm speaking
about it I even have a vague recollection this has already come up in the
past and we've just decided to leave it alone due to these technical
difficulties.

> 1. The fallocate killpriv fixes (XFS fbe7e5200365, ext4, f2fs) are
>    exact precedent: same reasoning ("can change the file contents [...]
>    should drop file privileges like suid just like we do for a regular
>    write()"), same one-line fix, and they went through the security fix
>    process with CVE assignment and stable backports.
> 
> 2. CVE-2023-0386 (overlayfs SUID preservation) -- same bug class,
>    CVSS 7.8, CISA KEV.
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
> 
> Given that the fallocate killpriv fixes went through the security fix
> process (CVE + stable backport), should this follow the same path?
> Happy to send the patch either way.

I didn't see the patch, maybe there the locking could be reconciled in an
easier way (although I have some doubts ;)). Anyway, without solving the
locking issues I don't think we should fix this.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
