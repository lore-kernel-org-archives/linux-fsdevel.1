Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885CD2F8EB0
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779708497; cv=none; b=BLscaHqkDcXlYqfcfg5K4D/qXkFVmPkdJBBbD8lEpb3Xn6tsQccKwor9L+WHzsfDMnkX3Bf638Np0hd7lsNAuJCxnqe1H136PG+KbBSSZlbYybUHZsxpQr3DOnkKxG1y+FExGmUJUsnytcWGr+FsCLdiKim3M4gv5PJ/J7F/Olk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779708497; c=relaxed/simple;
	bh=0snZmlcqXEGQP1K4bao/1uFBGLPbCJQiT8N178ClSCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2UWzkxtD99pNWSDMVJ2pX6PXfMmZfw+1nbTNAMj29+IbUQj137+Mk6JlNHR/L6xln7VlTK4s5BaolByurmBLuDe3SHZ6aLDgeDpQMpsMDsJPrZ7FSQXCzxyPXCTHYUe9h8heTqgBD28aO66pe4eUwZccL1jTLlSK69PAcoF6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xtB0TWq8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3KD7GAMt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xtB0TWq8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3KD7GAMt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xtB0TWq8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3KD7GAMt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xtB0TWq8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3KD7GAMt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A5CA758F1;
	Mon, 25 May 2026 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779708488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CeVXlONvLjhpFHjJfyhJSXJo0kTSQ936LLJG7JqBYbw=;
	b=xtB0TWq8uomgT814cGos8wv8SNQB7b7gO5UhoZCCCuifaPzJeWqLLdrsWCI9FrZXl/hpt5
	p+OwtQncminyASWpdjZgLZtXRSIpn2h6m8rozzGsANNAc62ZFa4AEgEJSq1ms/qKSG1mco
	WaA4/fI4PQ43ZhewApS8J52xUPuR1co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779708488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CeVXlONvLjhpFHjJfyhJSXJo0kTSQ936LLJG7JqBYbw=;
	b=3KD7GAMtow9sAUGqKqCYMEaC0cCLbXJhkE8At2Tsbhd/eSPi8WYs7LAcbl2H45N/bFSshz
	4yc5cIN+x05DXhCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xtB0TWq8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3KD7GAMt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779708488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CeVXlONvLjhpFHjJfyhJSXJo0kTSQ936LLJG7JqBYbw=;
	b=xtB0TWq8uomgT814cGos8wv8SNQB7b7gO5UhoZCCCuifaPzJeWqLLdrsWCI9FrZXl/hpt5
	p+OwtQncminyASWpdjZgLZtXRSIpn2h6m8rozzGsANNAc62ZFa4AEgEJSq1ms/qKSG1mco
	WaA4/fI4PQ43ZhewApS8J52xUPuR1co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779708488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CeVXlONvLjhpFHjJfyhJSXJo0kTSQ936LLJG7JqBYbw=;
	b=3KD7GAMtow9sAUGqKqCYMEaC0cCLbXJhkE8At2Tsbhd/eSPi8WYs7LAcbl2H45N/bFSshz
	4yc5cIN+x05DXhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32B4859C03;
	Mon, 25 May 2026 11:28:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bnBZDEgyFGpzfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 11:28:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7EE9A08D7; Mon, 25 May 2026 13:28:07 +0200 (CEST)
Date: Mon, 25 May 2026 13:28:07 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] fanotify: gate fs events checks in
 fanotify_mark() by group type
Message-ID: <ulal5iiolonkeccun5lyzkuf73odidgbkmabzupbwtawwjhhlz@tneaqqtlody6>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-8-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424170503.2096847-8-amir73il@gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 3A5CA758F1
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO

On Fri 24-04-26 19:05:00, Amir Goldstein wrote:
> fanotify_mark() has plenty of checks on the event mask.
> The event mask bits that correspond to filesystem watchers are only
> meaningful in the context of filesystem group type.
> 
> Hence, before checking if event is a specific event (e.g. FAN_FS_ERROR)
> need to check that the group type as well (e.g. filesystem).
> 
> Add helpers fanotify_test_{fs,ns}_watcher_event() and use them instead
> of checking the event mask directly.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I was looking into this and thinking about it for some time and I have one
brainstorming suggestion:

> +static inline bool fanotify_test_fs_watcher_event(struct fsnotify_group *group,
> +						  u32 mask, u32 test_mask)
> +{
> +	return fsnotify_is_fs_watcher(group) && (mask & test_mask);
> +}
> +
> +static inline bool fanotify_test_ns_watcher_event(struct fsnotify_group *group,
> +						  u32 mask, u32 test_mask)
> +{
> +	return fsnotify_is_ns_watcher(group) && (mask & test_mask);
> +}

These helpers look a bit cumbersome (having to manually select the right
one, there's no safety if you accidentally pick the wrong helper, you need
to pass the group as well, ...). So I was thinking about the following: In
fanotify uAPI the mask is actually 64-bit. What if we carve out some bits
from the upper word (8?) and store the group type there? Either we can do
this type-encoding only internaly once we receive the mask from userspace
or we could even have the encoding in uAPI constants as well - which would
provide additional uAPI constant type safety (we'd have to special-case
FAN_MNT_ATTACH & FAN_MNT_DETACH in that case but that should be doable,
since they are not widely used yet we could maybe even eventually deprecate
the old values).

Anyway, once we have the type encoded in the 64-bit mask we can easily
compare, mask, combine, ... these with some helper functions without having
to check the group all the time and having to select different helper
function based on event type. We are not very consistent with passing
64-bit mask everywhere since the fsnotify core has only 32-bit mask and so
far we use only the lower 32-bits in fanotify as well so that would need to
be fixed.  Also once we store the mask into the mark, it would be squashed
down to 32 bits but I think that's fine.

What do you think about it? Do you find this worth it? What's your opinion
on having the type encoded already in uAPI constants?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
