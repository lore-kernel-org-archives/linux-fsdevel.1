Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042793F86E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408618; cv=none; b=Upgr93cT8ZG0uH3J9fSFH0ywRbqBeptk9Cb0abB0A6AL1wM6+o6NtAZNn77TM+Fu+cDciuGsU44uYmxrN5Nrj4YPndL/M+sc+kQfYRXq3P4X8FB40V420WsG27SMtshKfxjp1ZfZUx8cICTIHf6L1oB24Pa8CBAt06gn1tkNg88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408618; c=relaxed/simple;
	bh=PGL8hh/iPDuMx8U3wwPvLaoo1hlzWqorYsmVIC0YSdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbqLOBRtfHWAyZJeEOGFGypei9o6XZ5c38djWp/bmklqirLMuQGuB7xr/CvhXkyp4pulu1ab9+kTt5YZfW/NJUqRjWJb8Ffi6ompugvs2t7rpdr/vNKHF7TVE3E3w4z6H1daYT/Dzlxs1yvY35UShfnxVtWFkPIN0Hyjk5l/uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGl7Orch; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jio/x70O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IRw26xah; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6X08noC/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGl7Orch";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jio/x70O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IRw26xah";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6X08noC/"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D859E3EAB;
	Thu, 30 Jul 2026 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785408611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeiXUf5UI0bba1l+buCl3P/hPidhOydoWlC3cuXzBSs=;
	b=VGl7OrchmMYNqZwW6UpA+eQlHOn60uyvwwBoovF2iHOpacQHvZtZNkBnAwviRSPuU189Ui
	AamJTjj0SwwjDh9ybCiCD7d89vg5rRqT30bkuZSATAtnnrqVxbFSkTvvjOvyf3B7K0rJ3K
	loXCnIejoNjngIyDOwB5VBVrm1wXfTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785408611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeiXUf5UI0bba1l+buCl3P/hPidhOydoWlC3cuXzBSs=;
	b=Jio/x70Oi6BTiyTzzfBqRJlFOhzgOF+UBEXf/TfeI9ER3xHyz8Lq2WO+bfl5PHAu4PDChm
	3voNWfcqskRRDKAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785408606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeiXUf5UI0bba1l+buCl3P/hPidhOydoWlC3cuXzBSs=;
	b=IRw26xah9JvFa5A83MmVh1l4TkKj0u6272S59n8EkdUL/HvkX89Bni9dfV1KeyAha8D5bN
	uoF4rAWK3QjUhayF5n/omc1rAVHvslJGhxFtM48cO6WBtVto9WvEudkN+pu8B8WbVkN797
	muLlJU68rkT1sqPSDev8SOF3wwrq4Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785408606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeiXUf5UI0bba1l+buCl3P/hPidhOydoWlC3cuXzBSs=;
	b=6X08noC/rzZYVYpYzVwZRfJC6tpXaDehRNu4uB0COZhGPgGhiBLjWo9cRm96UTIVqBRK8g
	gl5jiDXc8lyiBUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3D00779CC;
	Thu, 30 Jul 2026 10:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qPfHL14sa2rTRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Jul 2026 10:50:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 68884A0AAA; Thu, 30 Jul 2026 12:50:02 +0200 (CEST)
Date: Thu, 30 Jul 2026 12:50:02 +0200
From: Jan Kara <jack@suse.cz>
To: =?utf-8?B?6raM7JiB7J6sIC8g7ZWZ7IOdIC8g7KCE6riwwrfsoJXrs7Tqs7XtlZnrtoA=?= <yjkwon0026@snu.ac.kr>
Cc: Jan Kara <jack@suse.cz>, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] fsnotify: concurrent mark updates can publish a stale
 aggregate mask and lose events
Message-ID: <o3y7rskcnpaalaut2qro5ntewog64jdtzrxjw5q7lhg52rlo24@rxogt3dmzx6f>
References: <CACwKKmANzQaVSLni4QkvfoL6Axd3_3mYvCrsWRazXg0QeO6y3w@mail.gmail.com>
 <dtryuddxj63ibzfzmktla4ypj7vnxj5gia66joet3lp6zgzpot@btjuuubvckv3>
 <CACwKKmB_wwUoW9g_hgqESwKeEuM2k4MiAUn+6Nu=zpyE1VgmYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACwKKmB_wwUoW9g_hgqESwKeEuM2k4MiAUn+6Nu=zpyE1VgmYg@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]

Hello!

On Thu 30-07-26 00:39:49, 권영재 / 학생 / 전기·정보공학부 wrote:
> This did not come from a real application. It started as an LLM-assisted
> source review, but I only reported it after reproducing the lost
> FAN_MODIFY/IN_MODIFY events on an unmodified v6.12.95 kernel.

OK, thanks for confirmation!

> The fix you describe makes sense to me. Happy to test any patch
> against my reproducer.

Since you wrote: "If either direction looks reasonable, I can prepare a
cleaned-up patch and a regression test for review." my understanding was
you want to write the fix yourself to get the full credit for you work
(which is fair). If not, just let me know I'll write the fix myself.

								Honza

> 2026년 7월 29일 (수) 오후 9:40, Jan Kara <jack@suse.cz>님이 작성:
> >
> > Hi!
> >
> > On Tue 28-07-26 14:32:33, 권영재 / 학생 / 전기·정보공학부 wrote:
> > > Concurrent updates to marks from different groups on the same inode can
> > > leave the object's cached aggregate mask missing an event bit that is
> > > still present in a live mark. An operation started after both mark-update
> > > syscalls have returned can then be filtered by fsnotify_object_watched(),
> > > so the matching fanotify or inotify notification is not delivered.
> > >
> > > I forced this source interleaving with diagnostic scheduling barriers and
> > > reproduced persistent FAN_MODIFY and IN_MODIFY loss in 3/3 independent
> > > boots for each interface. A control update that caused a fresh aggregate
> > > scan restored delivery. I also observed the same loss-and-repair outcome
> > > without kernel instrumentation on an unmodified v6.12.95 kernel image in
> > > 3/3 independent boots, with 9 strict hits in 30,000 attempts. I have not
> > > identified a memory-safety issue or a security-boundary crossing; I am
> > > reporting this as a notification correctness bug.
> >
> > Thanks for the report. To clarify is this a result of a code review
> > (personal or by LLM) or some real application was hitting the problem?
> >
> > Also for the next time I'd like to ask you to try to keep your report a bit
> > more condensed (either by instructing LLM or by selecting the substantial
> > content from LLM output). E.g. in this case the above two paragraphs
> > explain substance of the problem and reproducibility, the scheme in "The
> > race" section shows how the problem happens and the rest is mostly just
> > uninteresting noise so this report could have been less than two screens
> > worth of text whereas now it is over 7 screens in my terminal.
> >
> > Now to the problem:
> >
> > > The race
> > > ========
> > >
> > > Let P and E be marks from different groups on one inode. P initially
> > > supplies event bit X to the cached aggregate, while E does not contain X.
> > >
> > >   P update/removal                 E update/add
> > >   ----------------                ---------------------------------
> > >   remove X from P
> > >   start connector recalculation
> > >   scan E without X
> > >                                   add X to E
> > >                                   observe old aggregate containing X
> > >                                   decide recalculation is redundant
> > >   publish the older scan without X
> > >   both syscalls return
> > >
> > > The add-side decisions are not serialized with connector->lock:
> > >
> > >   fanotify_mark_add_to_mask():
> > >
> > >     recalc = fsnotify_calc_mask(fsn_mark) &
> > >              ~fsnotify_conn_mask(fsn_mark->connector);
> > >
> > >   inotify_update_existing_watch():
> > >
> > >     dropped = old_mask & ~new_mask;
> > >     do_inode = new_mask & ~READ_ONCE(inode->i_fsnotify_mask);
> > >     if (dropped || do_inode)
> > >             fsnotify_recalc_mask(...);
> > >
> > > __fsnotify_recalc_mask() scans under connector->lock and later publishes
> > > the sampled union with WRITE_ONCE(). A different mark can be mutated after
> > > it has been sampled. Its add-side redundancy check can still observe the
> > > old aggregate, which the in-flight scan then overwrites.
> > >
> > > After this ordering, E contains X but the aggregate does not. The state
> > > persists until another operation causes a full recalculation.
> >
> > Yeah, right. So for simplicity I'd just solve this by always calling
> > fsnotify_recalc_mask() whenever mark->mask is changed. We *could* keep the
> > current behavior by providing new mark->mask to fsnotify_recalc_mask() when
> > adding events and then doing the check under conn->lock or even improve on
> > it and completely avoid scanning the whole conn->list and just add the new
> > mask to the current connector mask. But at this point I think it is a
> > premature optimization - we don't expect many notification groups to be
> > watching the same inode and frequently adding marks to it. So let's keep
> > things simple for now.
> >
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> >
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
