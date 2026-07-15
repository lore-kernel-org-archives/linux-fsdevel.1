Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1E2F83A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130709; cv=none; b=VGhxo4m1MiNv69kb8HrxCwWMyEZ+d2VACDQWYDiQyokW2RWIMd3eBZmuY6EjadeaNI5G54audW12FzcE3xZo3jwXGdN8yCmLgDgsAyFxPGKtA5Vvlm4873Qn8fr4B8Bm25ZohBmPCSWsfh/ej6n2kUy9u6I2Bo44dFUJRrTyGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130709; c=relaxed/simple;
	bh=LtaH8aaxtBogs32e3wjB7vQiwT321mHwyaAwWFLSBN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp6Ytlp7EIyuXGYDQi4MEbLa26H7MX0V0XCBJ5ZY+Zmv4qk45KvrovRTRTq1WLULbqRUWxBVnjQ30uqHaAT4xjD+be4qSmrcGFXt8WtJ4/W1O1pSwwK05VYRbP/ItZgXdwDNsIY9WzaFCgygW1fRjmg8a3AuNycaoZoUGXw0FII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A3UfDlnX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SCypIxmZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A3UfDlnX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SCypIxmZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A3UfDlnX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SCypIxmZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A3UfDlnX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SCypIxmZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 923BC3E2A;
	Wed, 15 Jul 2026 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784130705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHL6hMn4ad73wofazcDZIZ5mmujzlvQ21vTZwQoS5Pg=;
	b=A3UfDlnXAmjdCC/NeSFhqujZYCm0BmMUhIn6TlK5kwuSWbRe0PjNXdKyvfI+GTR2f4ZPs1
	7NaQ3uwktFsG0XXOsQ6o/eNU90tiLOjfUk7pjFnYLoig+yk73V0hB2CsvOl3+yeQT/9yYc
	8MUEOvTVvDMeptaQDE7vcngDnShCYDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784130705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHL6hMn4ad73wofazcDZIZ5mmujzlvQ21vTZwQoS5Pg=;
	b=SCypIxmZ0L+EZxhxTN9Bj+EOZnEZepsoAbg7qU2mZ1RC6b8mYEXEIJytC7M6Zbe4jLgiIe
	91gYrrrNXq/Y7sBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784130705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHL6hMn4ad73wofazcDZIZ5mmujzlvQ21vTZwQoS5Pg=;
	b=A3UfDlnXAmjdCC/NeSFhqujZYCm0BmMUhIn6TlK5kwuSWbRe0PjNXdKyvfI+GTR2f4ZPs1
	7NaQ3uwktFsG0XXOsQ6o/eNU90tiLOjfUk7pjFnYLoig+yk73V0hB2CsvOl3+yeQT/9yYc
	8MUEOvTVvDMeptaQDE7vcngDnShCYDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784130705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHL6hMn4ad73wofazcDZIZ5mmujzlvQ21vTZwQoS5Pg=;
	b=SCypIxmZ0L+EZxhxTN9Bj+EOZnEZepsoAbg7qU2mZ1RC6b8mYEXEIJytC7M6Zbe4jLgiIe
	91gYrrrNXq/Y7sBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8933E779AD;
	Wed, 15 Jul 2026 15:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 61N6IZGsV2qvJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 15 Jul 2026 15:51:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E040A084D; Wed, 15 Jul 2026 17:51:45 +0200 (CEST)
Date: Wed, 15 Jul 2026 17:51:45 +0200
From: Jan Kara <jack@suse.cz>
To: Ze Tan <tanze@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namei: Use READ_ONCE() for d_flags in
 __follow_mount_rcu()
Message-ID: <76kfuey4pj2af3zwzbo7a3i63ooxhvzpc5q6k3iyl7mhhfszsa@6vhknryplnto>
References: <20260715125102.1051791-1-tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715125102.1051791-1-tanze@kylinos.cn>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Wed 15-07-26 20:50:57, Ze Tan wrote:
> __follow_mount_rcu() reads dentry->d_flags without holding d_lock.
> 
> Use READ_ONCE() for these reads to make the lockless access clear.
> 
> Signed-off-by: Ze Tan <tanze@kylinos.cn>

Hum, so we are somewhat sloppy with the access to d_flags. Strictly
speaking we should be using WRITE_ONCE when updating them (and we do in
some places but not in others) and READ_ONCE when accessing them. OTOH the
only practical problem is KCSAN complaining, the problems that the compiler
could somehow tear stores to the d_flags are IMHO theoretical.

Having two accesses without READ_ONCE more or less doesn't really matter in
my opinion. Cleaning up all the d_flags accesses would make some sense but
I'm not sure it's worth the churn for mostly theoretical issues (I believe
Al or Christian was against it if my memory serves well).

								Honza

> ---
>  fs/namei.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 19ce43c9a6e6..cc8e8d961d7e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1687,7 +1687,7 @@ EXPORT_SYMBOL(follow_down);
>  static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
>  {
>  	struct dentry *dentry = path->dentry;
> -	unsigned int flags = dentry->d_flags;
> +	unsigned int flags = READ_ONCE(dentry->d_flags);
>  
>  	if (unlikely(nd->flags & LOOKUP_NO_XDEV))
>  		return false;
> @@ -1701,7 +1701,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
>  			int res = dentry->d_op->d_manage(path, true);
>  			if (res)
>  				return res == -EISDIR;
> -			flags = dentry->d_flags;
> +			flags = READ_ONCE(dentry->d_flags);
>  		}
>  
>  		if (flags & DCACHE_MOUNTED) {
> @@ -1711,7 +1711,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
>  				dentry = path->dentry = mounted->mnt.mnt_root;
>  				nd->state |= ND_JUMPED;
>  				nd->next_seq = read_seqcount_begin(&dentry->d_seq);
> -				flags = dentry->d_flags;
> +				flags = READ_ONCE(dentry->d_flags);
>  				// makes sure that non-RCU pathwalk could reach
>  				// this state.
>  				if (read_seqretry(&mount_lock, nd->m_seq))
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
