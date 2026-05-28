Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E763EFFCD
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973204; cv=none; b=QnwTZZ08gIfehFNkG3kqIazZSJjGZ2bXy2FVxYavPxum5G1v8dvIw5ob4R39Qm1U53FB3k53V3aex0hteVasWfijd3KxQA5pUlWdsqZbatVwK/vV2Iezw/wCaeg7vRiFLXYLZGa+II0/FRo3hzqpJ9FMfHRNh1PTnuDc0Ci5BI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973204; c=relaxed/simple;
	bh=Djenmp2baETm7xD1hTtXkNHUzCURlH+sM71QUH5p0RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LijJGu1X07MUjaCHR5n00aV1PQjVuuGVgXSQrDITz9Q4MObozzhaJPpdel/ELR0vJYMlTASFlUcWhd+cHbpj4cjktfE51T908m8XOrgfLoGjZU6amWhC5HAOTdZPn65Ii+D5H4IKnEijpzJxnhbVF5xD3szpZrPABilPSk6tTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T0UXoAWO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8YD1IAhW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T0UXoAWO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8YD1IAhW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T0UXoAWO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8YD1IAhW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T0UXoAWO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8YD1IAhW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94C5166EA7;
	Thu, 28 May 2026 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779973201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uWMGPiFFEoPtLga1o3umCg9y3n8wcDkGSWAPBBrAqM=;
	b=T0UXoAWOAywx9BISEdCcf3/WXeg24b+fopA/2687OMPvMq+T1L4bkOsmXPed8/tXyo/+sz
	v14D2A/Y4OX0cmjC3cmozYCBbTM1hwYxs2ZFZ9h4QA1DEChaz8Nn/D/7JWr+WGa9f3Q3JK
	vlEMTKMVzlyhyYc021FRvFc4vf+gUhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779973201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uWMGPiFFEoPtLga1o3umCg9y3n8wcDkGSWAPBBrAqM=;
	b=8YD1IAhW6s0t9pNmshA3Oj+MGZpmq6wrPMUl6znMwW5j8uImZUj0oPHgoqx/TK99KjMzrv
	EJioN7D2hL59MWDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T0UXoAWO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8YD1IAhW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779973201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uWMGPiFFEoPtLga1o3umCg9y3n8wcDkGSWAPBBrAqM=;
	b=T0UXoAWOAywx9BISEdCcf3/WXeg24b+fopA/2687OMPvMq+T1L4bkOsmXPed8/tXyo/+sz
	v14D2A/Y4OX0cmjC3cmozYCBbTM1hwYxs2ZFZ9h4QA1DEChaz8Nn/D/7JWr+WGa9f3Q3JK
	vlEMTKMVzlyhyYc021FRvFc4vf+gUhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779973201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uWMGPiFFEoPtLga1o3umCg9y3n8wcDkGSWAPBBrAqM=;
	b=8YD1IAhW6s0t9pNmshA3Oj+MGZpmq6wrPMUl6znMwW5j8uImZUj0oPHgoqx/TK99KjMzrv
	EJioN7D2hL59MWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D16D85ADCB;
	Thu, 28 May 2026 13:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /lXmL1A8GGqwIAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 28 May 2026 13:00:00 +0000
Date: Thu, 28 May 2026 13:59:58 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <ahg6JgO0wUkJKjRb@pedro-suse>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <20260518-starten-messdaten-3b8aa670ec85@brauner>
 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
 <177918418452.771415.4371785688744608623.b4-reply@b4>
 <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
 <177918837114.804096.3977912252785122973.b4-reply@b4>
 <CAGudoHGSZOEzbXHOAGqrdp6D06JQQ5Af759TQ+HiQx7=ruQa-Q@mail.gmail.com>
 <20260522-haltestelle-laufpass-volltreffer-3c69a6d84fc4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522-haltestelle-laufpass-volltreffer-3c69a6d84fc4@brauner>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 94C5166EA7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.01

Hello,

Apologies for the delay (laziness^Wconferences, travel and the sort),

On Fri, May 22, 2026 at 03:11:11PM +0200, Christian Brauner wrote:
> On Tue, May 19, 2026 at 01:56:42PM +0200, Mateusz Guzik wrote:
> > On Tue, May 19, 2026 at 12:59 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On 2026-05-19 12:51 +0200, Mateusz Guzik wrote:
> > > > How about denial of splice usage or degradation to copy are still on
> > > > the table, but based on a different criterion: whether code involved
> > > > is "known good" for lack of a better description. iow the kernel would
> > > > maintain a whitelist of "safe" cases. Random-ass AF_NOBODYEVERHEARDOF
> > > > does not make the cut.
> > >
> > > I had thought about that to but I felt a bit iffy about it. You could
> > > envision an FOP_* flag for this:
> > >
> > >   /* Module may use splice-like apis */
> > >   #define FOP_MAY_SPLICE          ((__force fop_flags_t)(1 << 8))

FWIW, I don't think this works. Sockets expose the same file_operations struct
for every socket. So while it could work for other dodgy fd's around the kernel, I
would hope there isn't many of them... (or at least many of them using splice,
etc).

> > >
> > > But that doesn't address how fundamentally broken vmsplice() for example
> > > really is and that probably no one should get to use it in its current
> > > form.

Right.

> > 
> > I never looked into the area on Linux, I am willing to take claims of
> > breakage on face value.
> > 
> > In this context I'm saying the functionality is used in the real world
> > for performance reasons and just whacking imo does not cut it.

Which is why I wanted to introduce the (admittedly, rather adhoc) approach
of limiting it to files that could already be written to. So hopefully it
could actually be deployed. I'm afraid many users out there will not deploy
a "go slower, safer" flag.

> > 
> > >
> > > > Common-case usage would have to be audited of course, but this sounds
> > > > rather actionable and would provide hardening without much friction.
> > >
> > > And that's the usual problem where rando module will just raise the
> > > flag. Maybe that's fine and we will keep up.
> > >
> > 
> > If this is a genuine worry the whitelist can still be introduced and
> > managed by one person (Linus?) very easily. The implementation is only
> > mildly cumbersome to get going and trivial to spread afterwards.
> > 
> > You could have something like this:
> > struct file_operations funky_ops = {
> > ....
> > };
> > VFS_FILE_OPS_REGISTER(funky_ops);
> 
> Unless someone is going to do that work a sysctl to force degrade all
> the APIs into copies should be ok.

Ok. It seems that the general consensus is KISS and just degrade everything
with the sysctl? I can do that for v2.

-- 
Pedro
