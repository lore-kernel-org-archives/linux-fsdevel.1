Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F2337D10A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381297; cv=none; b=NOqCczqTtHKaXUyEZfVqUZKJ+p7qPuIKrSfn/YLChQ6oSSIs0ZV5Nekbqx7VdJ9j8GZj1wfvpvz60kqLLBV6tmLe5p5RoL9pAu/qMO/TIX8iNB9qlTLChNTn/fRRFcFPf0TdENsBHy08K1/ngDi6t6HCHpxoO53u7ooQgh2kmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381297; c=relaxed/simple;
	bh=Ejs+UADSHQ4ZxK6DsLAQVvhPqPWD1ScydIlq++TWOd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/zMmBejozHnZFMZmMs76iyrLFsjx3G3cj+WbGPT/RMgJ66k3RFKOZYFnYJRMmisC4w/KUQP2EGWPsUmL3TbUj7e2gMGUDzEc3IkeLHXNWcbghvMh6ZpVNwadJyzqvzBwz5WrmRM8Kpcb4DD1iGlW0ecWLxfLPpY2KB0FslgYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UutiYmf0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lonr7Jjb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UutiYmf0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lonr7Jjb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UutiYmf0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lonr7Jjb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UutiYmf0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lonr7Jjb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C30A6B533;
	Thu, 21 May 2026 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779381294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqPaM93JFQo166MOSTQPANuj7C3WjUZFCUbTtUO0fqk=;
	b=UutiYmf0KdjlAoPkyKMOVCObQi0ujSzCCoJVopXyjQ8QQxpRC+oV2XMGjNBAb7RWUSTUYe
	v32Jw19pecOFw7ESe4v2qF/Ftz8465RLtj6nAS0Iz69GzcLDXhMxUv3vxk/rBATTslPswF
	DkoEcAOzvq9prXNdlkboTSh3Obm1OSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779381294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqPaM93JFQo166MOSTQPANuj7C3WjUZFCUbTtUO0fqk=;
	b=lonr7JjbzVxzIeg+hbw7Jfgs5HGfnkRRDoQFc0IwvueR/dQQ0C+Cm9o6aJyqnmciXd6YY7
	BMWcSJvDiEc/oyBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779381294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqPaM93JFQo166MOSTQPANuj7C3WjUZFCUbTtUO0fqk=;
	b=UutiYmf0KdjlAoPkyKMOVCObQi0ujSzCCoJVopXyjQ8QQxpRC+oV2XMGjNBAb7RWUSTUYe
	v32Jw19pecOFw7ESe4v2qF/Ftz8465RLtj6nAS0Iz69GzcLDXhMxUv3vxk/rBATTslPswF
	DkoEcAOzvq9prXNdlkboTSh3Obm1OSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779381294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqPaM93JFQo166MOSTQPANuj7C3WjUZFCUbTtUO0fqk=;
	b=lonr7JjbzVxzIeg+hbw7Jfgs5HGfnkRRDoQFc0IwvueR/dQQ0C+Cm9o6aJyqnmciXd6YY7
	BMWcSJvDiEc/oyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A011593AC;
	Thu, 21 May 2026 16:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QFRYBi40D2pnSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 May 2026 16:34:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 85243A08F3; Thu, 21 May 2026 18:34:43 +0200 (CEST)
Date: Thu, 21 May 2026 18:34:43 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] fanotify: test event->type instead of event
 mask when possible
Message-ID: <a4kh65jinwm2tyk57xhmqemmirbxr756cj3rkjlatlnsef335h@nex47pw2wvt4>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-5-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424170503.2096847-5-amir73il@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 24-04-26 19:04:57, Amir Goldstein wrote:
> The fanotify_event already has a type field, so tests like
> fanotify_is_mnt_event() should check the type and not the mask.
> 
> In fanotify_alloc_event() determine the mnt and fs_error event
> types by data_type, which uniquely identifies those events.
> 
> The helper for classifying an fs permission event is renamed to
> fanotify_is_fs_perm_event() and takes the group argument to verify
> that this is a filesystem group type.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
...
> @@ -845,11 +845,10 @@ static struct fanotify_event *fanotify_alloc_event(
>  	/* Whoever is interested in the event, pays for the allocation. */
>  	old_memcg = set_active_memcg(group->memcg);
>  
> -	if (fanotify_is_perm_event(mask)) {
> +	if (fanotify_is_fs_perm_event(group, mask)) {

Instead of creating this fanotify_is_fs_perm_event() helper func along with
similar fanotify_is_perm_event(), I'd just opencode the mask checks in the
two places where we don't have the event yet. Things will be IMHO more
obvious that way. BTW I don't think we need anything besides the mask
check. fanotify_group_event_mask() check should have taken care of the
rest...

> @@ -265,6 +265,7 @@ struct fanotify_event {
>  	struct pid *pid;
>  };
>  
> +

Stray empty line.

>  static inline void fanotify_init_event(struct fanotify_event *event,
>  				       unsigned int hash, u32 mask)
>  {

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
