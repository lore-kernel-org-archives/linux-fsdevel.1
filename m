Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876670;
	b=wpwKfUUGObqsC/1wBwNgib1VaCOm7qxrSaLq+Mt5FrVme2afQ9VLQeAQ/RSHpJSFehyi
	 LeDM8DSrEVUkvqT1uDKef9AgLh0Wi3nxqqRnBnnO/0Fx9ckSvcxw9Yz5KH4ulXHY1B6+I
	 ZhhZfRjEqCzOuHfMC3b7X55GLih4xKxbrlOOc38FzJyna4iiQov71I2hIP3ompLbQD9D9
	 oCWmR43O98gNE63kcztwuYpy+RQn96e3CFKgWlPCQAQBxBY6822n8zhweZlvQ3CmmH/9o
	 hdbvYDgyH4FNtS8xexghwr5UfW/C065ITDSzvTDfIuhErGejbP/WP+SAZTBccRIlJUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876670;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=R8OXXE6lVc0Kg4XvsdhEWlhjIxNHB/gXVg5vw+B42Y4=;
	b=4Y9zmQjcS4vhHBi44zprjIo6Lkor8VNYrQ0YW5EtZFTmbidc2CGaTBvbhu1gQ7mNFZol
	 zUZZPYIYgtOfTWJdwugkBXKADVBVusHezYX3Jbv2MI4l4XdmIukO6FWGev0XlzXl91oLC
	 7NeVc8irOAU4lI2GG6QQP+1f/Y/q5lrbGD3c+ARbyK0DEjWQ5CGOfgIP1T5xPTheMHZM4
	 z0mZUb8fQ8QU283/Ee6DLXncYgZxAeApljKrlv9v6r9coHduL3l7u6Tkl4DV8IoycYOba
	 Dj9VbO1dj3PUhm6byPWpIM46X/UN3eAjNWZITpVeC0dC55CnRASUqV/zuBeALsQAKZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GCXYQiER;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XIpQHsGl;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GCXYQiER;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XIpQHsGl;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F33606A33F;
	Thu,  5 Nov 2026 11:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28F33606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GCXYQiER;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XIpQHsGl;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GCXYQiER;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XIpQHsGl
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BAAA21F7A;
	Thu,  5 Nov 2026 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793876666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8OXXE6lVc0Kg4XvsdhEWlhjIxNHB/gXVg5vw+B42Y4=;
	b=GCXYQiERLawHs26Zm4d55q6Oi2DpMFIc6lGb0wzeYJXA32HMR6Oe8lyOWKrZa2pVh6YtoK
	e9fkl/YWIA0avnNf3RSYISsGgBDtHF95qp3FmqnRExLdSNCMVrlcftnVx6XYZ/EWCnrN0e
	JWss5Xwo9LZ7NUjwl1+1BeK5XQufM3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793876666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8OXXE6lVc0Kg4XvsdhEWlhjIxNHB/gXVg5vw+B42Y4=;
	b=XIpQHsGlc9nVHY5CIQssuyrzzo4F0qjoTpsvdjhAMJxM4wDhEUiU6WMtVU7gg7NQeV7Mup
	j5JDAan6cD4saoBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GCXYQiER;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XIpQHsGl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793876666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8OXXE6lVc0Kg4XvsdhEWlhjIxNHB/gXVg5vw+B42Y4=;
	b=GCXYQiERLawHs26Zm4d55q6Oi2DpMFIc6lGb0wzeYJXA32HMR6Oe8lyOWKrZa2pVh6YtoK
	e9fkl/YWIA0avnNf3RSYISsGgBDtHF95qp3FmqnRExLdSNCMVrlcftnVx6XYZ/EWCnrN0e
	JWss5Xwo9LZ7NUjwl1+1BeK5XQufM3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793876666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8OXXE6lVc0Kg4XvsdhEWlhjIxNHB/gXVg5vw+B42Y4=;
	b=XIpQHsGlc9nVHY5CIQssuyrzzo4F0qjoTpsvdjhAMJxM4wDhEUiU6WMtVU7gg7NQeV7Mup
	j5JDAan6cD4saoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CAAD133F6;
	Thu,  5 Nov 2026 11:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pW5rBLpi7GqiTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Nov 2026 11:04:26 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id A4A51B69D; Thu, 05 Nov 2026 12:04:25 +0100 (CET)
Date: Thu, 5 Nov 2026 12:04:25 +0100
From: Jan Kara <jack@suse.cz>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/stat: reject invalid flags for empty paths
Message-ID: <nxh7ssislnd5ylxnj7uuaoekq55fydgsvbqzmzqox5hrcgzzg3@63zcrhbm2yyj>
References: <20261031075809.3173603-2-thnkslprpt@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031075809.3173603-2-thnkslprpt@gmail.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 4BAAA21F7A

On Sat 31-10-26 09:58:10, Avi Weiss wrote:
> vfs_fstatat() and statx() take the file descriptor fast path when
> AT_EMPTY_PATH is set, even if unsupported flag bits are present.
> This bypasses vfs_statx() flag validation and lets both syscalls
> succeed with AT_RECURSIVE.
> 
> Restrict the fast paths to supported flags so invalid combinations
> fall through to vfs_statx() and return -EINVAL.
> 
> Fixes: e896474fe485 ("getname_maybe_null() - the third variant of pathname copy-in")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  fs/stat.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index a2e63c6c45b7..b75a411b502f 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -371,7 +371,9 @@ int vfs_fstatat(int dfd, const char __user *filename,
>  {
>  	CLASS(filename_maybe_null, name)(filename, flags);
>  
> -	if (!name && dfd >= 0)
> +	if (!name && dfd >= 0 &&
> +	    !(flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
> +			AT_EMPTY_PATH | AT_STATX_SYNC_TYPE)))
>  		return vfs_fstat(dfd, stat);

Shouldn't we just return EINVAL in the case of unsupported flag instead of
falling back to vfs_statx() to fail?

>  	return vfs_statx(dfd, name, flags | AT_NO_AUTOMOUNT,
> @@ -812,7 +814,9 @@ SYSCALL_DEFINE5(statx,
>  {
>  	CLASS(filename_maybe_null, name)(filename, flags);
>  
> -	if (!name && dfd >= 0)
> +	if (!name && dfd >= 0 &&
> +	    !(flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
> +			AT_EMPTY_PATH | AT_STATX_SYNC_TYPE)))
>  		return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);

For symmetry this belongs to vfs_statx_fd() similarly as in the other path
the checks are done in vfs_statx().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
