Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F33D45EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166367; cv=none; b=DfYlwd7uR54oBUvCe0/zAu97ABUYKzAERo5bX3Ea8xiw8GQQz5cdi3nEY5RfbnZPTE/d84XdlgMW4eRde2hutNq+lCHEUAzr88D9Y+VcfcdnKKCFSYUW8sdhxqqLE0KBIp3jaobbNgCVOo47UJ4x7ncVmVFflBrw+n9iqC6zJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166367; c=relaxed/simple;
	bh=M/onv5zqQRs9zurFDwsBN5IjYZABcHad9r5CT+IsJcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efVw2XsIRH/IEhS7pNgIRZy/5BiQutxXQdm5d+lJnerzkTCcXEhrKM3+fX9LM4IgkZ2uYYLRUvfWCH+7WasZIvxRGRPbvn/jDOnTni8Tu73qyxQPdGWnxnAkHhzpA/eMjPEL+Z2meF0CTRknF6pCfqR0Edzo6MkHn+JNLAB8dCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aJl9PAx4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oAYdZcne; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bv4llaLf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+PdOC96+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aJl9PAx4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oAYdZcne";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bv4llaLf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+PdOC96+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 252771FA93;
	Mon, 31 Aug 2026 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788166359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z42qwV/iBOnBsAm9YNMvpU/Zj5ntlW065VcsZivtxrI=;
	b=aJl9PAx47kk9TN4PsZtvweNnaJDZk1L19SLSKVqYAcmxv9SfxwKAbiLqMsXPZnbgv5YLIj
	0paE6qtR0tVR8PgxemFsT/9z98LsATIp1k6cyacIXk8/22b9CcK+EH6vsvOQsRm5oFyg/g
	bio4Nxu8bhHoZPl160pzWT0KYNN831M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788166359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z42qwV/iBOnBsAm9YNMvpU/Zj5ntlW065VcsZivtxrI=;
	b=oAYdZcneMgfMyiSnrnxU7+ax5rTYaaUGUs6MdCQxl1oNTb5BgLTdFcbpQ3sZMKeFyc4Bkb
	DHDgkpaQcadkHQDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788166355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z42qwV/iBOnBsAm9YNMvpU/Zj5ntlW065VcsZivtxrI=;
	b=bv4llaLfGxPClmozgeI3oiowftljw16IUL2l/Kop05qL058e9uryHjRjs0G3OpJgdYNW8h
	F6LRmAwva3ARE3G3v7sgXjNkpyyOn4EtjVgVPH9J939uwh6YHqFX4IjxoUVKf0+LiRLw1f
	nVMNzMyzwqOcckMeiePAptJ0It/4c6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788166355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z42qwV/iBOnBsAm9YNMvpU/Zj5ntlW065VcsZivtxrI=;
	b=+PdOC96+IWT5P2BoSwPu3Y2gfGg9OgWapgjgTi9SXBVVUy9w2CETaOJoaPgqa2L+RAPcaf
	p4HVkWdh/MSLJrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03CB713694;
	Mon, 31 Aug 2026 08:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LkHrANNAlWqJLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Aug 2026 08:52:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 88AE6A13B5; Mon, 31 Aug 2026 10:52:34 +0200 (CEST)
Date: Mon, 31 Aug 2026 10:52:34 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] buffer: Refer to folios in comments
Message-ID: <v2avslbirobmmy6sf7pscbv5pyaeadofksj4sk5bmdlxvghydp@rgvwjybmt7pz>
References: <20260828205429.3678204-1-willy@infradead.org>
 <20260828205429.3678204-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828205429.3678204-6-willy@infradead.org>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Fri 28-08-26 21:54:25, Matthew Wilcox (Oracle) wrote:
> Update some comments which mention pages to refer to folios instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Just one missed conversion below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1224,7 +1224,7 @@ static void bh_lru_install(struct buffer_head *bh)
>  
>  	/*
>  	 * the refcount of buffer_head in bh_lru prevents dropping the
> -	 * attached page(i.e., try_to_free_buffers) so it could cause
> +	 * attached folio (i.e., try_to_free_buffers) so it could cause
>  	 * failing page migration.
		   ^^^^
Isn't it "folio migration" these days?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
