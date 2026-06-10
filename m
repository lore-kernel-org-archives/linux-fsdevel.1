Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F823B95FA
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082861; cv=none; b=cSHbaa0E5geroqGaDKYpeeTM9DgPAI1aNChYDc6DIFjDwuJguY2yXjzyHymAm2q2nZlHB52zJ98MuT48yZFZ5NZZcKowpJWb2YezffzZFaVOYEwENsY0LkDdGCxE3lu0BZilST+x3m18IQc8QoaJPzQIDveqf0LH5WQg01/0v4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082861; c=relaxed/simple;
	bh=CGugeexrzwFixnY7kHmUiTXqUHGFXgLO2rvrrtQJgMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3FInXnSZHctPeB1+RZijiKg5i/xYYY3FPaQ7PhWhwlFaWuJHSLM6EmxvN39jjaO8jvgBPhfFVhFXX0/Bq87CEq3GaihPs57I/cdCJwvS4eerjjji8hY/kyf31CNb7V91icRy7fdzf160nhHnbAqtISewwAi45lky6IMpSDbvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kRtb1cbm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OzqmzqZQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kRtb1cbm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OzqmzqZQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kRtb1cbm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OzqmzqZQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kRtb1cbm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OzqmzqZQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C03A6A893;
	Wed, 10 Jun 2026 09:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781082858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dkQRTCNb2n3biDzLuwGkzdBYvUxShFJPgoiLRxg5lFE=;
	b=kRtb1cbmnFYRB9Z1nudTcy6WlD2arF4inZpVpkyqy+lIsbc4T6AV1AJl39ZSHBKxfX0B1O
	W7Dw8I2rq7qjlZo1OUVRmycEF8IUdXjBmNHge0J5MBguEDJFuPEs8Vtl1mshCC5PAICF/6
	Dryfrvyjhd2qOQ0Urf/MvULdLSBB2IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781082858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dkQRTCNb2n3biDzLuwGkzdBYvUxShFJPgoiLRxg5lFE=;
	b=OzqmzqZQUt40OWzokYI0myHgYY0sYnV0Ck2iRkZckVtgzjFclTU/R9L+coWvvtQJgy9ahC
	7NxZ8TdBvfOLdADg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kRtb1cbm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OzqmzqZQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781082858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dkQRTCNb2n3biDzLuwGkzdBYvUxShFJPgoiLRxg5lFE=;
	b=kRtb1cbmnFYRB9Z1nudTcy6WlD2arF4inZpVpkyqy+lIsbc4T6AV1AJl39ZSHBKxfX0B1O
	W7Dw8I2rq7qjlZo1OUVRmycEF8IUdXjBmNHge0J5MBguEDJFuPEs8Vtl1mshCC5PAICF/6
	Dryfrvyjhd2qOQ0Urf/MvULdLSBB2IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781082858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dkQRTCNb2n3biDzLuwGkzdBYvUxShFJPgoiLRxg5lFE=;
	b=OzqmzqZQUt40OWzokYI0myHgYY0sYnV0Ck2iRkZckVtgzjFclTU/R9L+coWvvtQJgy9ahC
	7NxZ8TdBvfOLdADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72809779A7;
	Wed, 10 Jun 2026 09:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1HvsG+oqKWr4KwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Jun 2026 09:14:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FBC1A0A90; Wed, 10 Jun 2026 11:14:18 +0200 (CEST)
Date: Wed, 10 Jun 2026 11:14:18 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, AnonymeMeow <anonymemeow@gmail.com>, 
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] fanotify: lift pidfd reporting restrictions
Message-ID: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
References: <20260607003343.425939-1-anonymemeow@gmail.com>
 <hsqpfvobwt3pf5he6hho653wl2tkwjaszfldqk6itch5uoqccy@jkijxqcm2in5>
 <20260610-umkippen-bauformen-fehlpass-d637b7bc0555@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-umkippen-bauformen-fehlpass-d637b7bc0555@brauner>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7C03A6A893
X-Spam-Score: -4.01

On Wed 10-06-26 09:31:22, Christian Brauner wrote:
> On Tue, Jun 09, 2026 at 12:29:05PM +0200, Jan Kara wrote:
> > On Sun 07-06-26 08:33:41, AnonymeMeow wrote:
> > > The pidfd API now supports pidfds for tasks that are not thread group leaders,
> > > but fanotify has not caught up yet. This patch set lifts that restriction and
> > > allows fanotify to report pidfds referring to the event-generating thread.
> > > 
> > > Additionally, this patch set allows fanotify to hand out pidfds for reaped
> > > tasks by registering the event pid with pidfs when pidfd reporting is
> > > requested and dropping the pid_has_task() check before the pidfd_prepare()
> > > call, as suggested by Christian.
> > > 
> > > Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/
> > > Link: https://lore.kernel.org/lkml/20260602-patzt-sturz-segen-f1f305d61b75@brauner/
> > > 
> > > Changes since v4:
> > >  - Add a pidfs_register_pid_gfp() helper function to pass in custom flags.
> > > 
> > > v4: https://lore.kernel.org/lkml/20260603001516.26234-1-anonymemeow@gmail.com/
> > 
> > The patches look good to me. Thanks! I'd prefer the change adding gfp
> > argument to pidfs_register_pid() was a separate commit but unless Christian
> > objects I can live with that. I'll wait for Christian's ack for pidfs
> 
> I would also prefer it to be a separate commit but same as you I'm not
> gonna insist. :)
> 
> > changes before merging this through my tree.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks! Merged and pushed out. AnonymeMeow, what's the situation with
fixing up fanotify20 & fanotify21 LTP tests? Are you working on it please?
They'll now start failing with linux-next so it would be good to fix that
up ASAP... Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
