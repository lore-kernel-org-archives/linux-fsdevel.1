Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547637107E
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379217; cv=none; b=PjO7qZHNosF07jp+TQ29mxXeTN8frI6OJgPDFeRDgMtagQe/y3oNaG3uexTY8EjdqxfcqevmEpoenwUB61MPEqSCTKT7frXIzWFz6M5RJq2V5JurRDmwYx2ywx+byjphA8gtxHfAHncWWEJPMA9uMBNTMtR6t5aMmaxnxpXg3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379217; c=relaxed/simple;
	bh=V9zIqgg49x+iw4DkYtyWFaPLtp1O5xG9SLts+5+Svrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc8Oov/QXX+nBnNs3K2QaaiRST+XMRDCoEI3IUuof7lI86GdTxoeTqZ+gKkzAIsycUCWGESoVmaS9qyqiSAHbG63Zoxa9RDQ6oacRdC6gq9oQZoP+9hVws8nNgkrjPUVmA0aQ4C9Nc9jC3oiI7P1N33RtPgTZRRrg3FQb0F6U8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H0MeDAKd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sPtAF1ql; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H0MeDAKd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sPtAF1ql; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H0MeDAKd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sPtAF1ql";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H0MeDAKd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sPtAF1ql"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FDEA6B107;
	Thu, 21 May 2026 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779379214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N25gB6MMZ/Sbg6y7F5xP/2RAKGvSfMhcWbsMpE37OWU=;
	b=H0MeDAKdNYdy2vqGZrfa9vjVbNLgrCYnuO8mimeWMVvOI3t5MDwBTWpLwImWlLPYt41/n2
	DpgiG1V04HQVI6YR4+GBKvmR1Az0mth4Viyki1t/nBF3kUt2A+toQubAfA8d5bbLNQ7dgt
	EQMvBdrMNuPUA3irPihrvY3HPST1zlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779379214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N25gB6MMZ/Sbg6y7F5xP/2RAKGvSfMhcWbsMpE37OWU=;
	b=sPtAF1qlQkLitD7G9WcqnHKL/ZTVbkMepvSnskD1o60g6o0T9bPd3oJNAXD2jhHXRQjr7s
	0M9EtDJMiydgJkDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779379214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N25gB6MMZ/Sbg6y7F5xP/2RAKGvSfMhcWbsMpE37OWU=;
	b=H0MeDAKdNYdy2vqGZrfa9vjVbNLgrCYnuO8mimeWMVvOI3t5MDwBTWpLwImWlLPYt41/n2
	DpgiG1V04HQVI6YR4+GBKvmR1Az0mth4Viyki1t/nBF3kUt2A+toQubAfA8d5bbLNQ7dgt
	EQMvBdrMNuPUA3irPihrvY3HPST1zlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779379214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N25gB6MMZ/Sbg6y7F5xP/2RAKGvSfMhcWbsMpE37OWU=;
	b=sPtAF1qlQkLitD7G9WcqnHKL/ZTVbkMepvSnskD1o60g6o0T9bPd3oJNAXD2jhHXRQjr7s
	0M9EtDJMiydgJkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ABAC593AC;
	Thu, 21 May 2026 16:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4WSABg4sD2pxJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 May 2026 16:00:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E98EFA08F3; Thu, 21 May 2026 18:00:11 +0200 (CEST)
Date: Thu, 21 May 2026 18:00:11 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] fsnotify: introduce fsnotify group types
Message-ID: <mcwjatujiyunkrfsxvp5fq66soxdf2kiildxoamp34pw6cb2yn@zw77femd4ngo>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-3-amir73il@gmail.com>
 <b5xolvjlm3xnx3dzdbvyc7nqgaejjatnrrwint6gleirdy6czi@vtj2m2qpayj6>
 <CAOQ4uxjCrhOLuwW-UAcCDejrTkGrhmLwc4+rJE097w2pXOvf6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjCrhOLuwW-UAcCDejrTkGrhmLwc4+rJE097w2pXOvf6g@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	internal_greylist_whitelist(0.00)[10.150.64.97];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO

On Wed 20-05-26 21:06:00, Amir Goldstein wrote:
> On Tue, May 19, 2026 at 5:55 PM Jan Kara <jack@suse.cz> wrote:
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index 49531a4fe71de..95e7c24c70249 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -1586,8 +1586,11 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
> > >  DEFINE_CLASS(fsnotify_group,
> > >            struct fsnotify_group *,
> > >            if (!IS_ERR_OR_NULL(_T)) fsnotify_destroy_group(_T),
> > > -          fsnotify_alloc_group(ops, flags),
> > > -          const struct fsnotify_ops *ops, int flags)
> > > +          __fsnotify_alloc_group(ops, type,
> > > +                                 FSNOTIFY_GROUP_FLAG_USER,
> > > +                                 GFP_KERNEL_ACCOUNT),
> > > +          const struct fsnotify_ops *ops,
> > > +          enum fsnotify_group_type type)
> >
> > I don't like this much. It's a bit of a catch that
> > FSNOTIFY_GROUP_FLAG_USER is now always set (although I see that that's what
> > the only user is doing). I'd keep this as is.
> 
> Sorry, you mean keep it as a constant flag? or pass the flag as an argument of
> CLASS fsnotify_group?

I meant keep passing the flag FSNOTIFY_GROUP_USER as explicit argument when
declaring fsnotify_group.

> We can also make it DEFINE_CLASS(fsnotify_user_group,
> and then the constant flag will not look as awkward?

Yeah, possible as well, although I don't quite see the point with the
single declaration site we currently have. But at least with this name it
will be less surprising.

> > > -static struct fsnotify_group *__fsnotify_alloc_group(
> > > -                             const struct fsnotify_ops *ops,
> > > -                             int flags, gfp_t gfp)
> > > +struct fsnotify_group *__fsnotify_alloc_group(const struct fsnotify_ops *ops,
> > > +                                           enum fsnotify_group_type type,
> > > +                                           int flags, gfp_t gfp)
> > >  {
> >
> > Can't we just derive the group type from flags in this function? I don't
> > see a huge reason to duplicate that info in flags argument.
> 
> I am not sure I am following.
> These are FSNOTIFY_GROUP_FLAG_* flags not the fanotify_init() flags.
> Did you mean to add a temporary flag FSNOTIFY_GROUP_FLAG_NAMESPACE
> just in order to save the extra type argument?

No, I was just confused. Passing group type as a new argument to
__fsnotify_alloc_group() as you do makes sense. Sorry for the noise.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
