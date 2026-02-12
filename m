Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43A2E06EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890383; cv=none; b=PfA8ZUrXgIvy3uvxwxY9VibJ/qxqzM6caAHUBXgywbfJxe6VT91LopckvqVzfbOdJSW0KwR2CeeQZ2DShvX6g7XQq7iizQYHCzbTxuHwl2bMtaP09ZLrdYBqZBA85mRtUBhHeCffnwgqo5DJYn8oGWaevjmfUPKQqp0OMAexTDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890383; c=relaxed/simple;
	bh=cGTIIVBSYYIEP/aYkmS4ZcVw6+l1AQU1xSHvYaXt8yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuYSGW2NUwqVx0Zp4oi1A7SOYUhOeRkkbEUYZjrzG4FhX7p4vS75/7qYfadP+QIDrE+9iLfd6qEzR7lw/vDpLKN6MXNJoKNjAf8aefsziNuXR6vq9u9dkv5oli/03Prk0bn0TLb0UbDyADOo4Fqpt3m1gNVa5YAclot5bkTsNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D12vpx5E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zUAUc2Id; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T6jbtf0Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LFMzTLCx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D12vpx5E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zUAUc2Id";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T6jbtf0Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LFMzTLCx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23D693E715;
	Thu, 12 Feb 2026 09:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770890380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFWkfuduU3wERXWexUXMS8/sH4JTVUHJb6JIi8LK3sM=;
	b=D12vpx5ESAz4JMoGgu8WFgJqyBq5b9TIWvP2J8qAGnB9mrus+HTDNJ48sVVET9jgM/poWR
	qxIi4TUggbIyMibBZeoDGUDg5Qqf3RXCaO94bRT3bDIvbD+nhFrDFGhuoIRQxs0hgvpJMU
	2kmEdlS7W2nhBZMSC48O6gWdfbiXT94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770890380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFWkfuduU3wERXWexUXMS8/sH4JTVUHJb6JIi8LK3sM=;
	b=zUAUc2Id4qDcgiVryc5AYp2K8iBlugLGj6cTpNsE3DVEIxf5AQhyEUqAZlFdf62nH2sgdB
	XzqEF+f6DOUcbdBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T6jbtf0Z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LFMzTLCx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770890379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFWkfuduU3wERXWexUXMS8/sH4JTVUHJb6JIi8LK3sM=;
	b=T6jbtf0ZaCeGe7Y8yRiqH4szTrqx5CEFzzVuxQXZLX3o6n1DBuALHhVqLXk+MB5TmQ1XMB
	j07kLolBXWYJ48eZ5br3KdQ4gR1BWrBhcMmmE2nM28AaDJnU82O7pT3ea2prZlHRKHh8gI
	xCIf0ETrw6YQIWfna02EfDwy0U0Ny0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770890379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OFWkfuduU3wERXWexUXMS8/sH4JTVUHJb6JIi8LK3sM=;
	b=LFMzTLCx7p34FHRF+rI0HhQJ7uARWtOCieOXDR7d1tVvaJjf/O3DIzcRVoRPyb1uovboC5
	cpwEd6p0wgI6iSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 101D83EA62;
	Thu, 12 Feb 2026 09:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFbwA4ukjWkMUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Feb 2026 09:59:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BE921A0A4C; Thu, 12 Feb 2026 10:59:34 +0100 (CET)
Date: Thu, 12 Feb 2026 10:59:34 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, 
	Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH] udf: fix nls leak on udf_fill_super() failure
Message-ID: <n7blo2z6tk25p2pkjk53ifm2p2nejodngojrnmgdcr2bqpv3m4@up4qbcufnfii>
References: <20260211201845.GN3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211201845.GN3183987@ZenIV>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,linux.org.uk:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 23D693E715
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Wed 11-02-26 20:18:45, Al Viro wrote:
> [in viro/vfs.git #fixes at the moment; if you want to put it through your
> tree, just say so]
> 
> On all failure exits that go to error_out there we have already moved the
> nls reference from uopt->nls_map to sbi->s_nls_map, leaving NULL behind.
>     
> Fixes: c4e89cc674ac ("udf: convert to new mount API")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thanks for catching this! It's fine if you merge it so feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index b2f168b0a0d1..97a51c64ad48 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -2320,7 +2320,7 @@ static int udf_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  error_out:
>  	iput(sbi->s_vat_inode);
> -	unload_nls(uopt->nls_map);
> +	unload_nls(sbi->s_nls_map);
>  	if (lvid_open)
>  		udf_close_lvid(sb);
>  	brelse(sbi->s_lvid_bh);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
