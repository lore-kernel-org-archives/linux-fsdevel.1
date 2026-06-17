Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD333FE02
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717609; cv=none; b=mItLTHdXiaqbFu1AnAiXfhVVZwE5SJ3nA43m0sZv2XfcToE55zqM38bmNmNcV+dj7vBTRULOy4c6MJea0kszQQQvqb25Ph03psyJsQJQJC1COXoQ9W7CfZ7IMAscRki7NpCaRTD/pul6FG6cS1JiBq1Ib9NHZPMMqZaAdhZM7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717609; c=relaxed/simple;
	bh=h89ETQZvBw2kNr99iUQvYv29u38Ukq8M+V8sY4yd9JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIpzczf/vtwFVpD07UrS5SzRPiDLHwaMo7legCUFEYCkN5Y3OtSblkzOViPorWK0o3i4PCYVkAopepBDyJJ0w5fE5bHIG4LZ+Hq0uLSu0GAilcW0UqObW69hOk8wQsA1Ee42/6SlDsidWG25sxo8W/Brus0QulzxNaUx/vQ13Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tJOKru/V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oaYsEz2O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fimltUbF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hau50+/i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tJOKru/V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oaYsEz2O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fimltUbF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hau50+/i"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E33706C30F;
	Wed, 17 Jun 2026 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781717606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFO8j0NeMGyL2grHLlFtQIT6uKWu7PcEuhycY778oFY=;
	b=tJOKru/Vwxy1/WIXVlm5ijQakkNAvW5Xx1HoZy/f7pR5noVu0LVKKG4LvdJjXRdXVO7FdX
	uXW/ggrAZQlY2JmKecpbxplCgTTL4mEFrfVOx6XH7LncBi+9ZMNyN04DxpBmRT3mg2rDQa
	vJg4jzV+4rr6aTllO3dLaBaiFaf/u4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781717606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFO8j0NeMGyL2grHLlFtQIT6uKWu7PcEuhycY778oFY=;
	b=oaYsEz2OBZqv0E3Vn04jwrwFL0TVf/SEitnxrcS8oMJ3+l8bYw9jg4VtYT3Dm8F0NeVNd3
	PQWcW8C64Pq0p5BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fimltUbF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="hau50+/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781717605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFO8j0NeMGyL2grHLlFtQIT6uKWu7PcEuhycY778oFY=;
	b=fimltUbFgr7My4W24+vFaGaZw7dqE575LtMPpAeSyPH7DpyvH3FBBCNSkS7fmr4MLgIVZ5
	5r9hWkgo4c8sFggFq41JRDa0KNw8lQsS8Wi0QGFgwKM56N0fRktGCxauLJIVi/0mu6l1dC
	tnEjV8h3+kxb83BcZ6R8yRXHLIbxLjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781717605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFO8j0NeMGyL2grHLlFtQIT6uKWu7PcEuhycY778oFY=;
	b=hau50+/itBYgjU5ZvyQybNVrMpLlHmfKFKiqf1ay/Qb5VsxjU5OrcldKUBFJSvBLbSBAPp
	u/tsiMc9tPSjrOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0616779A8;
	Wed, 17 Jun 2026 17:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ykk6MmXaMmq3WAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jun 2026 17:33:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 725E8A0EC0; Wed, 17 Jun 2026 19:33:21 +0200 (CEST)
Date: Wed, 17 Jun 2026 19:33:21 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, Song Liu <song@kernel.org>
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
Message-ID: <xycqm3qrhjg3uplpmozwo7nterl5tnuarghowmh3h3mv3thh6u@apagf4kqlkg6>
References: <95371379-97e9-4cb4-8358-ec014b765b74@linux.alibaba.com>
 <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com>
 <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
 <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
 <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
 <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
 <yguigvx3sapcemq2oudlc6lmiwmxr27zx572oyqocbvefnpt3s@z3oj2pzgdjuj>
 <CAOQ4uxi2Mx4ZB48DhQJWOvt6UBur3LnrkttgRjo72U4+Cu81iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi2Mx4ZB48DhQJWOvt6UBur3LnrkttgRjo72U4+Cu81iQ@mail.gmail.com>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E33706C30F
X-Spam-Score: -4.01

On Thu 11-06-26 17:25:56, Amir Goldstein wrote:
> On Thu, Jun 11, 2026 at 1:32 PM Jan Kara <jack@suse.cz> wrote:
> > > The rule is that sb_start_write(sb) pushes the sb to the tx stack
> > > after checking no loops in the stack.
> > >
> > > In the common non-stacked case, there are no checks so the push/pop
> > > should be quite cheap compared to the sb_writers locks.
> > >
> > > For the read side I hope that we do not need to track "read transactions"
> > > in the stack and that it is enough to check the write stack in page faults and
> > > stacked reads in loop/nbd/backing.
> >
> > That's another problem. Reads can create deadlocks as well. If you do
> > read(imageA_fd, mmap(fsB_fd)) in the setup I've outlined in my previous
> > email on XFS, you are holding i_rwsem for read for imageA and then doing a
> > write fault to fsB which translates to a read from imageA which needs
> > shared i_rwsem for imageA again. If you are lucky, this can pass but if
> > someone tries to acquire imageA's i_rwsem for write inbetween (and blocks),
> > your second shared i_rwsem acquisition will block and you have a deadlock.
> 
> Yeh we could introduce sb_read(sb) scopes but that would be a bit nasty.
> The two-fds syscalls (e.g. sendfile()) makes this scoping even more challenging.

Well, for stuff like sendfile() or splice we take care not to entangle the
read and write parts:
  while there's data:
    read into pipe
    write from pipe

So these shouldn't be a problem.

> > > Note that the unscoped kiocb_start_write() in aio/uring will need to be
> > > extended so that the write transaction scope will cover the io submission
> > > to cover the page faults in input buffers.
> > >
> > > I have no idea about the feasibility of this and how much of the holes
> > > this actually closes but if looking at the narrow use case of pre-content
> > > events it might just be enough.
> >
> > What looks like the most feasible approach to me is to record in struct
> > task we are doing a read/write syscall for fsA
> 
> read/write_iter could be nested within stacked fs, so we really need a stack
> of transactions, but this one could be [FILESYSTEM_MAX_STACK_DEPTH]
> 
> > and in the page fault
> > handler once we have the VMA we can check that fsB isn't fsA's ancestor in
> > the "filesystem dependency graph". Making the check cheap enough should be
> > doable (we could for example do the loop check traversal only if the
> > stacking depth of fsB is higher than that of fsA, caching the stacking
> > depth in the superblock, which would deal with 99.99% cases) but maintaining
> > the dependency graph will take some work...
> 
> My crystal ball tells me we are probably not going to do that :-/

Yeah, it won't be *that* complex and for stuff like reliable system
hibernation we would need that as well but so far it looks like too much
effort for too little gain...

> But if we did, it would have been nice to validate that LOOP_CHANGE_FD
> does not set the backing file of loopA to a file on fsB ;)
> 
> If we only wanted to protect the case of pre-content events in erofs
> backing file (readonly), is there any solution that you see which is less
> complicated?

Two ideas:
1) erofs on mmap could issue events to download the all mapped content into
the underlying image.

2) Just ignore the problem since I don't think it's really a practical
one. I mean userspace would have to issue a write to fs carrying
erofs image with buffer mmaped from the mounted erofs. If you have sane
access policies, apps on erofs shouldn't have write access to the
underlying filesystem carrying the image. And unpriviledged apps cannot
trigger freezing of underlying filesystem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
