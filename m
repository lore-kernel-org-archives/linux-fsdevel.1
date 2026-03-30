Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCAF3AE190
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860573; cv=none; b=D84kocV9zJTdNhwGH44/90FmDADub5mgU1bNzLFS3sJSUJJx0zFDTQmGIlj0JQCTknTyNVshnPZm4rInslp/14P7PuqNQj4DOh9hpRi2Kce5UhY4fCYjC6yHw7KIyfKw+4gjeDs6UR01WP3S7/JCZKseBRAr4On/IYusYOv+tSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860573; c=relaxed/simple;
	bh=l2n3Ez94ZoHEl0LRA0//bLKqwb+OqvyrGfLUwZyMgyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgzTitqRn8DkmCW0jQ981mXzr4cVaDf84fQo7BHq5e6b2wUYi84LL84mZr7aeZDBbRx3mruNv8qOE1h+wjWZAZgkWioHOvIBZJYnKTbpGuruJvfbWwC1TPVWKqxSJeLOf7eJb+ONgZiACSaa36pZ3Yxa7yxMyCbgFAh0pUwMFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EPlitZ48; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T6TqwY02; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rkFJVdxb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jLnyqyom; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EPlitZ48";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T6TqwY02";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rkFJVdxb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jLnyqyom"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F145D5BE85;
	Mon, 30 Mar 2026 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774860571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpP7sO3dKpkjqec/jHvEEd0xRgfjbLjJF+9mXjhTPuc=;
	b=EPlitZ48BJhhEnwXh2fRSxBf67yuv0Cax8eMEsTeth/9NbFJa3zklREohsHHzwAv3Vclki
	/Q2FS+w56EYP/11tBs2RUGgbpyTdet7VMqSif3/ouA594hxvbBAuKx9QCnmR+dfKl1/yKt
	AG5Ee8D4b4vpsC2/O+cW0I4TyK2n5sI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774860571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpP7sO3dKpkjqec/jHvEEd0xRgfjbLjJF+9mXjhTPuc=;
	b=T6TqwY029/6qvX1AEBkEJNaVa3L9OktQe7rFZT35hIUtqLxlyredhcZ37TrRvRojhpY+yz
	rVe3mhKZ4mccTeAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774860570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpP7sO3dKpkjqec/jHvEEd0xRgfjbLjJF+9mXjhTPuc=;
	b=rkFJVdxbotQs2c+fLaf0vpkpVP2n15NfN2+MmP+vqCcf0qvioxucvGeppY7hu7tbt8dWdN
	y6eEDid0u+Ps0azdQwOlxQBtmxxV0AS7ss/rz4iK26fSl73wdeaqitmYPHQv0yR+oryCS+
	6CTlRyNRsBfcSwQxtSwmZsUvefYioco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774860570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpP7sO3dKpkjqec/jHvEEd0xRgfjbLjJF+9mXjhTPuc=;
	b=jLnyqyomooFPERZpHzAw+7lFen58Jn1g3m2RUP8IyaQKJE7bao1nI4VrMGanZFgTAt8tcu
	xfhHC+e4qWc6KQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA8484A0A2;
	Mon, 30 Mar 2026 08:49:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id itA4ORo5ymkIdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Mar 2026 08:49:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C5F30A0AE1; Mon, 30 Mar 2026 10:49:26 +0200 (CEST)
Date: Mon, 30 Mar 2026 10:49:26 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: write a better comment in step_into() concerning
 .mnt assignment
Message-ID: <6su6xeledpjkxamao2x3prscoblljn4xahxnztlbpbveb77nee@4lp4sahqxbqp>
References: <20260328175841.3390950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328175841.3390950-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sat 28-03-26 18:58:40, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 2113958c3b7a..c7fac83c9a85 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2140,7 +2140,7 @@ static __always_inline const char *step_into(struct nameidata *nd, int flags,
>  		if (unlikely(!inode))
>  			return ERR_PTR(-ENOENT);
>  		nd->path.dentry = dentry;
> -		/* nd->path.mnt is retained on purpose */
> +		/* nd->path.mnt remains unchanged as no mount point was crossed */
>  		nd->inode = inode;
>  		nd->seq = nd->next_seq;
>  		return NULL;
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
