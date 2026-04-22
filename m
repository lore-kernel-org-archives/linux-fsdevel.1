Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782113E8C75
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862305; cv=none; b=pcOv4n4ylsHu0qNsKHIB4kzplY3N8/20LFuAo789x23RYVA5gtJXdT6CkFjbb7qqGZg24xWXGRdAL+6I/RDPo2vdQYGrQU0lmIQv8ofIPCaWBBz6OK3sJSdsW4ATBAaj6NGRdNdflMM+lhZBXyUpUxakv/mJStRfmWL+o/DFiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862305; c=relaxed/simple;
	bh=dpAUL4E19uXFj+BYkHT3L1MJDPniMdcMueWRbEqJSgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPkYk4WRLa1dbbFeAZlP0PG4n9QTvEz8uvdfYvECoSr+m/z98a0E9Bk2NekO+FMEAiAw3TJqsLg8v+KuA2JxVJ1x6kxQM3A/faXuUuW1vkWwoP265GlG8Ni4JO8OmF4p35nqqCwrFDK+SDOacH/RdKE7mfG6uJUSATEdvIZ6MII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PilHOyyw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bd2kH+cR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PilHOyyw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bd2kH+cR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PilHOyyw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bd2kH+cR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PilHOyyw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bd2kH+cR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C19446A83C;
	Wed, 22 Apr 2026 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776862302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0X6f87U/iTG5tmZ1gOf5pB6RBPch3WD+0Io3+/BtJ0=;
	b=PilHOyywy4aRM99jH4iJ+Pkz7mPRAA7Ur2C5q556sGkAmQduAB6Hq+JUCiYEO01W1+uobL
	h4eb7wix7EYjoJkacwc5r+v4SkpjPrCR7TNPDpEDwHJnXwjSQ2DrVgPaKvuZu75JcgcwhX
	Gs97ckZoak6+Y1NYxp919RhrQ8v/mMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776862302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0X6f87U/iTG5tmZ1gOf5pB6RBPch3WD+0Io3+/BtJ0=;
	b=bd2kH+cRrdSIjP/OiTwBKtPPJDenY2r09xR7HUB3Dtybt2HUM7hvcG+Rvcu6NBvQvZ0Pra
	cIrQFT7pr5ZFEgCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PilHOyyw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bd2kH+cR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776862302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0X6f87U/iTG5tmZ1gOf5pB6RBPch3WD+0Io3+/BtJ0=;
	b=PilHOyywy4aRM99jH4iJ+Pkz7mPRAA7Ur2C5q556sGkAmQduAB6Hq+JUCiYEO01W1+uobL
	h4eb7wix7EYjoJkacwc5r+v4SkpjPrCR7TNPDpEDwHJnXwjSQ2DrVgPaKvuZu75JcgcwhX
	Gs97ckZoak6+Y1NYxp919RhrQ8v/mMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776862302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0X6f87U/iTG5tmZ1gOf5pB6RBPch3WD+0Io3+/BtJ0=;
	b=bd2kH+cRrdSIjP/OiTwBKtPPJDenY2r09xR7HUB3Dtybt2HUM7hvcG+Rvcu6NBvQvZ0Pra
	cIrQFT7pr5ZFEgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B89CE593AF;
	Wed, 22 Apr 2026 12:51:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8s4QLV7E6GkPAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 12:51:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84587A0B44; Wed, 22 Apr 2026 14:51:42 +0200 (CEST)
Date: Wed, 22 Apr 2026 14:51:42 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namei: use QSTR() instead of QSTR_INIT() in path_pts
Message-ID: <u3kpzpjhuwaxansmvaosnspj5wdr3u2kybovw4m5zwf5uqv2uo@wurlm4pzyzvm>
References: <20260422123002.99876-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422123002.99876-3-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C19446A83C

On Wed 22-04-26 14:30:03, Thorsten Blum wrote:
> Drop the hard-coded length argument and use the simpler QSTR().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..817bba800d7b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3617,7 +3617,7 @@ int path_pts(struct path *path)
>  	 */
>  	struct dentry *parent = dget_parent(path->dentry);
>  	struct dentry *child;
> -	struct qstr this = QSTR_INIT("pts", 3);
> +	struct qstr this = QSTR("pts");
>  
>  	if (unlikely(!path_connected(path->mnt, parent))) {
>  		dput(parent);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
