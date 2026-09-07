Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C9543935C;
	Mon,  7 Sep 2026 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768571; cv=none; b=HyMCedVLC2tUIRybGc5gbkYMJcuSS41gFIZpcV54nac8V+MXi6Bk0xqX74pRcsfq4JE+nr0/OhYJqZJ4Ql4Xh7a5e5f6S3JBqkaB8QTHaY8vF/nF0P9bf+ADJk+2eblb9TxiuzFF8aYzNJD13xWR2qcwiOuiRMyK3Hl+gW+Hllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768571; c=relaxed/simple;
	bh=WfIdmfDObgfwwf02sJRuNe7sZCz+Uu0/ZlVs9pKYyZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxIuR1Bo/0DqLw5gax6/QDSSvxaYWETsQeC3jGUZ5EpntDvwly4E/qGWBKTQEnolUX8Xf6vImxoHV4/5E1LIAx8/rzebyJlMf1h9FZsCaykmSTp4g7asssgrdPNQDs3RGEh+8QSc7sIg9rBNNEkQ8aufgoQUhAGUG0sakZpJIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jtfd/JJA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yB9JKPeJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1cDgkDw0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B6KiCy5E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jtfd/JJA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yB9JKPeJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1cDgkDw0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B6KiCy5E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3782C21AF2;
	Mon,  7 Sep 2026 08:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788768563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y4vUVmFFBovQf0DjtO33NPPdFIZMgNa/F1VoWVVo1yA=;
	b=Jtfd/JJA8vzcNeBwMOnG0UhaLMHxNNkHmi7vwDggzOsL9oif2CUV5H0G7uGCyB6COuWJ5D
	SUdYaJsmG+1igX7S2C+tli3C2QDjfCzhtKK0EJuq/KIn42/IhZ/g4v33hIWtCxHEjNXtD+
	wxwFKkYLfs1kEf/hjDwa4K99oRj3Duo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788768563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y4vUVmFFBovQf0DjtO33NPPdFIZMgNa/F1VoWVVo1yA=;
	b=yB9JKPeJ1JqyRN8abB13X2+FRoa2U+3CDrgUIY06KAgDmePn0poY/Eez245GQVBQ7K7kTX
	PqNNSQ/6IBaSXGAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788768559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y4vUVmFFBovQf0DjtO33NPPdFIZMgNa/F1VoWVVo1yA=;
	b=1cDgkDw06HhuSp/fqz/VmeMys12ywhzTtDVFA2mXdLiy6Vvp0P1J+dMZYMJZ2pZrrLmQcy
	v53URvB2/P9tEjE7CpvAN72uO/PvKWAyQ0Un+VZMNhzVlKi+IoHzbBlGOqzFk2wrohLGYA
	YLhTNGHPhcX9kPZnGgbAmGKi7BlI2Gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788768559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y4vUVmFFBovQf0DjtO33NPPdFIZMgNa/F1VoWVVo1yA=;
	b=B6KiCy5Ey3OXeG9vHVySGLWyg8PfWqHEp3ywxJ2yOXJeT02Lq2/8/Myis6DbfIgdYXSRg1
	Gh0eJF2MDg4hmmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18F381368D;
	Mon,  7 Sep 2026 08:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SCkQBi9xnmoxLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Sep 2026 08:09:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4CB5A13B2; Mon, 07 Sep 2026 10:09:14 +0200 (CEST)
Date: Mon, 7 Sep 2026 10:09:14 +0200
From: Jan Kara <jack@suse.cz>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: fix typo "anonynous" in comment
Message-ID: <pvrjx6ekuelhlibuvz3wyrgmshn5ymyfixwh33ertklthvyv6i@bqkjt2vjh2ra>
References: <20260904121146.22419-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904121146.22419-1-hemanth.selam@gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
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
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Fri 04-09-26 17:41:45, Hemanth Selam wrote:
> Correct "anonynous" to "anonymous", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index a32c6634d592..63c9759fc3b0 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1837,7 +1837,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
>  	/*
>  	 * mount and sb marks are not allowed on kernel internal pseudo fs,
>  	 * like pipe_mnt, because that would subscribe to events on all the
> -	 * anonynous pipes in the system.
> +	 * anonymous pipes in the system.
>  	 *
>  	 * SB_NOUSER covers all of the internal pseudo fs whose objects are not
>  	 * exposed to user's mount namespace, but there are other SB_KERNMOUNT
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
