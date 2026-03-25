Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B072BD5A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439635; cv=none; b=F03cxqS6Tj+bqOUNrXzz+5RYsyRB6jLfxGRT0khNBpJGF4+MpjATvEvDz6/C11ws/HutwXAPICRNRg0C+6oV4SGZemsgjSD7dDawxPxHZ6teic6qq0yNDwKe+qPCH7s6PRNHtdQJXiBfxAndp099QSQUZa53CRTJ4wIxIZbraSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439635; c=relaxed/simple;
	bh=2ZmGmCRPYntfqxLNM6YZVWmcbycVQDC6+bDeGmsCJaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0ddSp/rcK+fh91Z5glyDWYqrG3YsQItJFK6RZx1kjWq7cdtqDew8nS/Y/oE4FQiC/WU2MniBNjS95/SfKmD3PmmuYT07vOgc8C0DgSHaEwztNyQw61vAbWUnScUxxMqjktStDFCtqPHgFDgUoTAMATsk80NXZwIojYhT7ah+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L//POjBW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FqNapBfJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L//POjBW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FqNapBfJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L//POjBW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FqNapBfJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L//POjBW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FqNapBfJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D5CA5BCF1;
	Wed, 25 Mar 2026 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774439632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l7EAvKCm8LxIqiD0reokdL87UHeJISWe8PN/btVzdWI=;
	b=L//POjBW8G/u3DF8PI8CiC8btFxjNncznzYRnqtwCxp3D208QJEKzGEPN5iFzKtGGznU5K
	DYPIXWfA8O6bXJaSfR8XtriAc3wn8uw/Kd03zm4iNsiggaoyo6phgD9jHvp0ehD6py5Q1n
	ip3gQl/pv2G58EZrZwXRL1uW7K3Ejfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774439632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l7EAvKCm8LxIqiD0reokdL87UHeJISWe8PN/btVzdWI=;
	b=FqNapBfJpL67Y2nGtEYRFlsZCB640n14F7qwJzXS9O34ChqZP69pqeeByBQEvtxnWYZmrK
	eEXBklpqxHVuX1AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="L//POjBW";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FqNapBfJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774439632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l7EAvKCm8LxIqiD0reokdL87UHeJISWe8PN/btVzdWI=;
	b=L//POjBW8G/u3DF8PI8CiC8btFxjNncznzYRnqtwCxp3D208QJEKzGEPN5iFzKtGGznU5K
	DYPIXWfA8O6bXJaSfR8XtriAc3wn8uw/Kd03zm4iNsiggaoyo6phgD9jHvp0ehD6py5Q1n
	ip3gQl/pv2G58EZrZwXRL1uW7K3Ejfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774439632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l7EAvKCm8LxIqiD0reokdL87UHeJISWe8PN/btVzdWI=;
	b=FqNapBfJpL67Y2nGtEYRFlsZCB640n14F7qwJzXS9O34ChqZP69pqeeByBQEvtxnWYZmrK
	eEXBklpqxHVuX1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71E20443AE;
	Wed, 25 Mar 2026 11:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E7vIG9DMw2l+JQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Mar 2026 11:53:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2F4FBA0B32; Wed, 25 Mar 2026 12:53:52 +0100 (CET)
Date: Wed, 25 Mar 2026 12:53:52 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yangtao Li <frank.li@vivo.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] adfs: rename adfs_notify_change to adfs_setattr
Message-ID: <zw65s2prif22qhb73aqfv2fonl7fnykhom5wzj7lqyymirrolc@q4xdwyfoubbn>
References: <20260325063711.3298685-1-hch@lst.de>
 <20260325063711.3298685-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325063711.3298685-3-hch@lst.de>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,lst.de:email,suse.cz:dkim,suse.cz:email,suse.com:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7D5CA5BCF1

On Wed 25-03-26 07:36:49, Christoph Hellwig wrote:
> Make the function name match the method that it implements.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One typo correction below:

>  /*
>   * write an existing inode back to the directory, and therefore the disk.
> - * The adfs-specific inode data has already been updated by
> - * adfs_notify_change()
> + * The adfs-specific inode data has already been updated by * adfs_setattr().
							      ^^^ spurious *

>   */
>  int adfs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  {

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
