Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9293EFD3C
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920609; cv=none; b=ht3kYVsjAuMITxLp3Afeq8iuKVyAIPtsLB97mmm7ZvboAITOW7uWHtl6NblPC6Xe12m66B3nH6CkghcyeF7AmQI/VtwBavynu0sxDBiyi8YiGyaatkFXaqUE2g58pdxSghjE2yeHkrs2FLtpeOYETybg9BoTpvriAYr9LNd6UM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920609; c=relaxed/simple;
	bh=FreudI7T9jvDJncvYx6ADq3kYl6aUUJpcUnw0n/P1zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISaD5LpkudY3yGlqHNz+7+R3XVoBRpOV8wxWKOeQG6wUN1/p4XBfw5msl7y99N8vbEU9NJf+xYXeSZA4PRh8mpUi6o6oJW0HqAwHgqSr8IC+XgoaPLPJiMNrcGuvnJQCU+tO31f8wLgaQZKbMO0Fl80nH2BuZBCIwtY/AIpL3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QC8eAxxs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9b19IJxQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uhek5ed4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iB+bMjFl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QC8eAxxs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9b19IJxQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uhek5ed4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iB+bMjFl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC7AE408E;
	Wed,  5 Aug 2026 09:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785920600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6QZWf0FiiLNLtO07pc3w74e7T/F5SwkTW/u5elPG4w=;
	b=QC8eAxxsT5MxNm9PJB2Uo+uHk/OIk+niLPyRWkwiS5sfIrCjBgPffvVESHZVKpFSyatF9Y
	UytVL5vMIBaGmUgcA2Z1r43+DPlMgKFX6hUdThAGJSBglW1zf+BR3jbTlgSuJQy9xWHFpx
	+V6JqOVGJTFATBk+SdZGfjZNZKmLvNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785920600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6QZWf0FiiLNLtO07pc3w74e7T/F5SwkTW/u5elPG4w=;
	b=9b19IJxQeuY7Ml83B4Jm5bcnYq5VfsCG58qMwaWeWb6KsKze7qhQt56sEze7nW1v4r1rXX
	uE05WgBnyYOtEoDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Uhek5ed4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iB+bMjFl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785920596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6QZWf0FiiLNLtO07pc3w74e7T/F5SwkTW/u5elPG4w=;
	b=Uhek5ed425NGY/LoxkK1/anafMf6ocMz9t46ipFsJgf+Qn5SffXZ5hlafM8JvxrNkSrv51
	CefE8nP6NcNWx3E/SKZ/cd7M7mjv+aBd4fUJvccSoo6F04yuKxnxmn47vw3J4vBv0LknRd
	qoov1StPspMWGfDLdRUs1lte56lqLsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785920596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6QZWf0FiiLNLtO07pc3w74e7T/F5SwkTW/u5elPG4w=;
	b=iB+bMjFlpBUHt4HaKe6cS2UkQ1cVEYEitayyk4/sNYzaG+kQ4jQ0zxEXcjynnY840MKLMF
	wrELAknxUoELkCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B51F0779B6;
	Wed,  5 Aug 2026 09:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jds2LFT8cmoyGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Aug 2026 09:03:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 610B6A13A7; Wed, 05 Aug 2026 11:03:16 +0200 (CEST)
Date: Wed, 5 Aug 2026 11:03:16 +0200
From: Jan Kara <jack@suse.cz>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: remove stale inode_insert5() kernel-doc parameter
Message-ID: <ohxvze4ey44eifystjzlx7okc2wqo5rrsc4byqbpsfzkm3uqbb@s3tshjapg46a>
References: <20260805024149.935769-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805024149.935769-1-chenyichong@uniontech.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: BC7AE408E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed 05-08-26 10:41:49, Yichong Chen wrote:
> inode_insert5() no longer has an isnew argument, but its
> kernel-doc still documents one. This triggers a W=1 kernel-doc
> warning.
> 
> Remove the stale parameter description.
> 
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index a31aa7cb47f6..ed7c8df1bfca 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1282,7 +1282,6 @@ EXPORT_SYMBOL(unlock_two_nondirectories);
>   * @test:	callback used for comparisons between inodes
>   * @set:	callback used to initialize a new struct inode
>   * @data:	opaque data pointer to pass to @test and @set
> - * @isnew:	pointer to a bool which will indicate whether I_NEW is set
>   *
>   * Search for the inode specified by @hashval and @data in the inode cache,
>   * and if present return it with an increased reference count. This is a
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
