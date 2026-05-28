Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644943E3C76
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973788; cv=none; b=MFCaOBbF+bcYZZqFtXjo5hKNDKAm1CoxgdNgu5WSJduexMh0wE9M/XnyAWuCfuOiyieZZ+/Tzx/xmctMay5DebTy54SVSzHJXWPZfIlxNuNauYZzGjrPi71Y/GhMkXactMrrmnwGDS+Z0eRWlbRih5mQeZjtC4ajebYeDNrFIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973788; c=relaxed/simple;
	bh=QqbiVughGxm4jyopBxqzzoWY94gnmJYWpmobDDJg/wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyLuV5uXQCRaDNtWGw+jdjJ91tV3QzDvgtQ8aq6igBDa3nZRfJIUEGn+qOvjhS67mnPow12JS7MeRmyiJus1XSs9dMYPNpHVgXWZCTUXebjo5NtiH0DX3/rEmCAE9dxQLUYmJoKnkjmz95RfgysH5Ri+mKnqWhehvG7l/Cyg7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y11KFVd7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6exRVsWm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nyzQrsci; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yljhIsYa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y11KFVd7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6exRVsWm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nyzQrsci";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yljhIsYa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64C396A8C6;
	Thu, 28 May 2026 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779973785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0sY/GQGU8TkieIOcqVRM9nUX1NC5H/xB1BsutmS9rU=;
	b=y11KFVd7LENk/yuCWeRc2BEnIAmhtesm1d5yyjg0tuQxiVvoQM88Rz4Dj78r7WmBr7kUGw
	b0JPQXYFZtTpJ5rFf+QjUtDNOEB/3ebSkloiSjdeHuwiiNhVthscz5BAbFVUma1RAA0/G/
	1JZUKrmDRQIr0ed127Ipyc1uwZFd25M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779973785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0sY/GQGU8TkieIOcqVRM9nUX1NC5H/xB1BsutmS9rU=;
	b=6exRVsWmcRDPi5z486vu4ciR+IAzp4naIlQluTAYwtVHX5ASo0/b4tlfPiDqHJfspWx3f8
	f01t9/BbMY153eAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nyzQrsci;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yljhIsYa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779973784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0sY/GQGU8TkieIOcqVRM9nUX1NC5H/xB1BsutmS9rU=;
	b=nyzQrsciAlYkIf2/xnEJ7tyTGT352MjGOxLvUw+UaPCupAy8mwb4iS0vaZu/GNvPcrKNGB
	M3xoqsnaSlqcQcAW6zButczfFlnCNgRbiySoehUuv1912fkuTo7/KmpjdAT+HIukCCDtRV
	3RQ5XQ+u6Wor8wfjahYGBM0WnAAEhnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779973784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0sY/GQGU8TkieIOcqVRM9nUX1NC5H/xB1BsutmS9rU=;
	b=yljhIsYa+twrwv0lLSlceVbJtiyOmK6Zutp2kyMVEb4185F0KkfenDsZjT5+S8tCYt6uj0
	qNyOYumh5Ay/Z8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B63D5ADD5;
	Thu, 28 May 2026 13:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1jNKFpg+GGrGKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 28 May 2026 13:09:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0846CA0905; Thu, 28 May 2026 15:09:40 +0200 (CEST)
Date: Thu, 28 May 2026 15:09:40 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: simplify fanotify_error_event_equal
Message-ID: <du3qklclddikn66yjiipyhxzrdh7zbtvmme2uvubaf4m6qlxn3@oawrodcisc5d>
References: <20260527142233.1256340-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527142233.1256340-3-thorsten.blum@linux.dev>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 64C396A8C6
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,linux.dev:email]

On Wed 27-05-26 16:22:35, Thorsten Blum wrote:
> Return the result of calling fanotify_fsid_equal() directly to simplify
> the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 38290b9c07f7..8ed77901db57 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -120,10 +120,7 @@ static bool fanotify_error_event_equal(struct fanotify_error_event *fee1,
>  				       struct fanotify_error_event *fee2)
>  {
>  	/* Error events against the same file system are always merged. */
> -	if (!fanotify_fsid_equal(&fee1->fsid, &fee2->fsid))
> -		return false;
> -
> -	return true;
> +	return fanotify_fsid_equal(&fee1->fsid, &fee2->fsid);
>  }
>  
>  static bool fanotify_should_merge(struct fanotify_event *old,
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
