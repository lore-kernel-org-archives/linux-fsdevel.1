Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877181;
	b=UyikgISSer9j1qz0HUq/+qVD46Oe7ECVrD/Y6Dzi/AuqtWE915oBSM4peuUxJYb2eRKk
	 +Eo3xhcHExPwURZTGmE7UrMhFpZONbUS8P4Hm3bnawvW0D1Ts9IF81u9NdzH0ZZEVjLV8
	 MHn3lbuea7Fwg+bMm1qO5L/MkVw1RZjfOmWt2b6Cu2ZYx9zjth4oVRKsYHxaSQFMjkX07
	 vm3pTVbTiRDl5VpDlru4+stEFZTZ0OcfjA6K8+eJiz24pUK9aJeBPobGhMq0XRqQke9M2
	 6Fax7mYoXAx+mhHSMYJlz/tKgZhpgYZLUgTAhLRHOSaG4t1E0COXlPi5MpNe3Xf7FUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877181;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=ZHY6y+s2RrJzwaejYRMjR8b7lUTPpigmvDA0dU0XxKE=;
	b=ZL4vgMfdknEWiXidAErizJR8D6oGMeptdqlm/kuESur2FGRb9aQb0q4pzhZa8bWKeOOk
	 BMjLs2AFPAQ13FrwPxqB4V+YRzvxDN3e0bxa9lb4CORkTlZ8+ohEbymTmVvYfxvesGIYZ
	 NcRRw79KgAXFf+gMk0hQJc84dE8obzw6JSEO1Y/8Gg3As7dvLsaW0+WY3WoOsN0ccoKL6
	 VZsRPysf3/jZtZGpI22ZRWDZxAbslA0EoUxtkHd1qP/jxKTr4c3ja0n5YtADIPSgKPzkZ
	 VQW9fMdNlcr9p7OYdhkdoGsuCnsVxg/F8LR7fLbQAuxdPBVe/YC9cd8qeZ5lMg2o3NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PFN6w7Uo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OIIJR9F3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PFN6w7Uo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OIIJR9F3;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6E606A32F;
	Thu,  5 Nov 2026 11:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D6E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PFN6w7Uo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OIIJR9F3;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PFN6w7Uo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OIIJR9F3
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0DFF21FC5;
	Thu,  5 Nov 2026 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793877173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHY6y+s2RrJzwaejYRMjR8b7lUTPpigmvDA0dU0XxKE=;
	b=PFN6w7UogynvDg6wXP5wRfpBkFaml+uFR7+DGPlk44D7H+/LQa+SoO2XJcQjvnSWrZwu11
	0Hu0xVZ/0wl3P3VSS2M4p6oN+AHfLIdMpImDTZLXRA49JKD79Q7UQ54TherVqbDKGvid1C
	dm4w3eHvJSCns3Mg7kqvbfylEJcImJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793877173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHY6y+s2RrJzwaejYRMjR8b7lUTPpigmvDA0dU0XxKE=;
	b=OIIJR9F30Nqs/C66tmGPlHwJsAZoznWM2UgcVCWZi+3xk/7RQOJOBCyTUNyGtkbOhEzr9X
	eWIQGVIGQKlqH2DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793877173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHY6y+s2RrJzwaejYRMjR8b7lUTPpigmvDA0dU0XxKE=;
	b=PFN6w7UogynvDg6wXP5wRfpBkFaml+uFR7+DGPlk44D7H+/LQa+SoO2XJcQjvnSWrZwu11
	0Hu0xVZ/0wl3P3VSS2M4p6oN+AHfLIdMpImDTZLXRA49JKD79Q7UQ54TherVqbDKGvid1C
	dm4w3eHvJSCns3Mg7kqvbfylEJcImJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793877173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHY6y+s2RrJzwaejYRMjR8b7lUTPpigmvDA0dU0XxKE=;
	b=OIIJR9F30Nqs/C66tmGPlHwJsAZoznWM2UgcVCWZi+3xk/7RQOJOBCyTUNyGtkbOhEzr9X
	eWIQGVIGQKlqH2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9F83134F4;
	Thu,  5 Nov 2026 11:12:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sAV+L7Rk7GrQVwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 05 Nov 2026 11:12:52 +0000
Date: Thu, 05 Nov 2026 12:12:52 +0100
Message-ID: <87ld77sf9n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-mm@kvack.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH RFC 0/7] proc: move procfs to what kernfs does
In-Reply-To: <20261105-erbrechen-unecht-bauformen-0794d3cfb679@brauner>
References: <20261102-defizit-jobaussicht-kurios-7016c6e67442@brauner>
	<464ef986eab97abf226791c7e19ad111.josef@toxicpanda.com>
	<20261105-erbrechen-unecht-bauformen-0794d3cfb679@brauner>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, 05 Nov 2026 11:28:56 +0100,
Christian Brauner wrote:
> 
> On Wed, 04 Nov 2026 22:23:51 +0000, Josef Bacik wrote:
> > - snd_info_text_entry_write() allocates the larger buffer and frees the
> >   old one without copying what's in it, so a text entry written in
> >   pieces loses the start once it crosses a page.  It's been like that
> >   since ffb73b08e794.
> 
> Yay, more bugfixes... You share the blame for more mail traffic now.

Indeed it's a real bug (regression by the commit).  Also your fixes
for old issues should be taken sooner.  Would it make sense to pick up
those for 7.4-rc, then rebase your rest series for 7.5?


thanks,

Takashi
