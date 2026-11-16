Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823049;
	b=o3M9rRb/hBx7rhcFrwb707QEhYY+5YEcTazfSjRyg8MNrbnPxaIGCcsP/10ASGW4FiZN
	 1RCjAZHDIlTinmwLtXyRVqr0PZ93uyEzTi90QfcnWuA/x6Njjd6Vs6kGP23f58Tj3QWMr
	 OvDjzwRQPxWGU2tnsk8mVjWZwxWnTTXxmuT3CKuyPKR0Yvi3Nilut8qOw+F5VaAXScn6r
	 ODxksrCotpJkgQofyo2KEaTtqxzN/PY4Numk7osfsBCFiXjZe5AR3Nhjg0vKVnqTLAYxx
	 88wZuDinu1sCwqDOgBgahLfTCEzzx5oKZq4huciS2CAo1AOAUMqLtrvSHNVvy0oN6fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823049;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=tr+0ABK9hTMyO3EM/bWvOFolskcjlJK76EwtyivgyOo=;
	b=fKBBNoITnDkbDNpj+cNH2RZPjyDKemezmQexfgwKtNK15g3jABS4Y7mWZgw1JzWapTdt
	 KWema6XVDHtrGNv4KOZ9yl9fQepG6zJbYIYYeUmVvoBDx6LPGYTh4E+A4Vl8w5UjB3GuJ
	 oUwLl4WpSXlWCEEzKVcUbkarv6jc+66RxzfVxgFHPbf9+U1YtZqVGixIgNS6SLaRKRPqC
	 Vjbpss1mpJOOSo7HzN+Mm0L/LQBNSHqh+2eIuBIvSpCDA6iyKZ1amyiYToHxX8rbk/nUp
	 vf4q9FhhsMDnhqW854YYO/z6dfdz6i7KjdsVS2CdA9+lojHVPiRyrc6pqEzC0HI2FOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BHY0M4RV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fm5hbCCz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BHY0M4RV;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fm5hbCCz;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3E606A329
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 09:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5C3E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BHY0M4RV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fm5hbCCz;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BHY0M4RV;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fm5hbCCz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 901B62226C;
	Mon, 16 Nov 2026 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794823046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr+0ABK9hTMyO3EM/bWvOFolskcjlJK76EwtyivgyOo=;
	b=BHY0M4RVIcsONEBJUwXo1A2FzNAdsWjZg2kgU8EFwJcEzHsuX5tE3TNZWNbTqJZ6sIlX6s
	Cycwlk6LS/QCn18HzfSFFOZd8u6mDZFSST6L6ADMDg6ujyMQJifBQS7Cf4eINDEbKo9UXg
	ko/8voAN1T+rBAGghm6CJExYl5RtNtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794823046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr+0ABK9hTMyO3EM/bWvOFolskcjlJK76EwtyivgyOo=;
	b=Fm5hbCCzCSbQ5WTkKbqid+UqUh+/elySoSVEVmbyXZWQJFbx0Wgd4amqr+FhwpHXZlBAP+
	7hyg4ZgKf79kJ4Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794823046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr+0ABK9hTMyO3EM/bWvOFolskcjlJK76EwtyivgyOo=;
	b=BHY0M4RVIcsONEBJUwXo1A2FzNAdsWjZg2kgU8EFwJcEzHsuX5tE3TNZWNbTqJZ6sIlX6s
	Cycwlk6LS/QCn18HzfSFFOZd8u6mDZFSST6L6ADMDg6ujyMQJifBQS7Cf4eINDEbKo9UXg
	ko/8voAN1T+rBAGghm6CJExYl5RtNtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794823046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr+0ABK9hTMyO3EM/bWvOFolskcjlJK76EwtyivgyOo=;
	b=Fm5hbCCzCSbQ5WTkKbqid+UqUh+/elySoSVEVmbyXZWQJFbx0Wgd4amqr+FhwpHXZlBAP+
	7hyg4ZgKf79kJ4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A3D61334C;
	Mon, 16 Nov 2026 09:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XaaAEYbT+moqRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 09:57:26 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id EF5C724D86; Mon, 16 Nov 2026 10:57:25 +0100 (CET)
Date: Mon, 16 Nov 2026 10:57:25 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] Partition the fanotify watchers by type
Message-ID: <xt6ondsazxnsdraiatmaxcuslzr3agxsw5unvbax6rfmhmgmgn@l5tqnoohg5rz>
References: <20261015143601.2095784-1-amir73il@gmail.com>
 <CAOQ4uxh7oEQ_BzzN23C87+LN1SLoNz2PNYi=k3fNn-NHG4P-5Q@mail.gmail.com>
 <CAOQ4uxi-6trYv2PR3PAVeX2Sg9X8uv3dz5xi=o0dYKBFbw+PAw@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi-6trYv2PR3PAVeX2Sg9X8uv3dz5xi=o0dYKBFbw+PAw@mail.gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Sun 15-11-26 16:38:21, Amir Goldstein wrote:
> On Fri, Nov 13, 2026 at 7:20 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Oct 15, 2026 at 4:36 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Jan,
> > >
> > > As discussed on the "namespace monitoring" patch set [1], the proposed
> > > namespace events do not need to be mixed on the same group with legacy
> > > fanotify filesystem events.
> > >
> > > The mount events are already not mixable with filesystem events, but we
> > > want to be able to mix them with the new namespace events.
> > >
> > > Therefore, introduce the concept of "watcher type" where all the legacy
> > > events belong to the filesystem watcher type and the new mount events
> > > belong to a new namespace watcher type.
> > >
> > > The new watcher type is free to reuse most of the 32bit mask space that
> > > we have internally in fsnotify for event masks.
> > >
> > > The prep patch set only does the partitioning by watcher type.
> > > Followup namepsace events work in available for review in my tree [2].
> > >
> > > If you are fine with this plan and have time to review the patches,
> > > perhaps it is not too late to stage this prep series for next cycle?
> > >
> > > Otherwise, we could aim for merging this together with the namespace
> > > events for the following cycle.
> > >
> >
> > Hi Jan,
> >
> > I suppose with the firehose of bugs you had not had a chance to look
> > at this yet.
> >
> > Just making sure it didn't fall between the cracks.
> 
> Anyway, I addressed some review comments from AI tools.
> Besides some issues that I already mentioned on specific patches,
> fixed sparse warnings reported by the kbuild robot and some other
> minor cleanups and pushed to fsnotify_group_type branch on github.
> 
> I won't send v4 for those minor changes because I first want to know
> that you are ok with the shape that this took since your v2 review.

Yes, I'm aware of this patch set and I'm sorry for the delay but as you
guessed this is getting pushed out by other stuff that keeps popping up.
But I'm hopeful this week I'll have a look.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
