Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9FF377ED5
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050560; cv=none; b=RI7Q0Tdh7+wyOZmV9iLNqcIxZHVcZg/+b0Ok7FtONdfpntA5FskkX+3MfrYfh4D4tKEnn5c3U9zx2CRQ2t6wju2gslXiE7vCOiNFtZD96P2lUIcgYKxXic8qIDLplZWpuEaph1US97adEiTnE1K5tlqoaIE59sf8akwpsz0g0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050560; c=relaxed/simple;
	bh=wKiOwk7FTVHL3YQ2T9dlGt4RAyyhwmZAzRlDzSuUdlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dcj45W/3WIvfwxvX1zALOo1lv/rxhI/7j8m3afP0gO7kxuZbaSuNqwfhOD/VCUD4bOG7Sbfp9KD4QHekaQq6kAUorzVxoyCSyEXGJaBJ+gmOzdIfDouc7AbbvS4xiWYxPpD6n2eAypBxz+JKul5S+TQLxdX7TUFz5eyVWc7sewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FHQEYBYq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7NkrPQgB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FHQEYBYq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7NkrPQgB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FHQEYBYq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7NkrPQgB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FHQEYBYq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7NkrPQgB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A97914D20A;
	Mon,  9 Mar 2026 10:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773050557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYHDwVpNTjo6GnoiOz4n6t12VW6VfF1jYLPHSYmUKrE=;
	b=FHQEYBYqevRTbJ4Is4MaRARPFqoFXy80mJcLN5qhzIhNlYD69UcLZrnageE5eLJ9LFtfO1
	//sIo34Ounqqup6qeJztt/v35ggAQrXvLQt4Q3s+gZMolqxM2v7wf/ye8wEpet8LhOlBmS
	eupIZMjgMFKsufoT7XjIocAa9mDxf/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773050557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYHDwVpNTjo6GnoiOz4n6t12VW6VfF1jYLPHSYmUKrE=;
	b=7NkrPQgB8KKBks7CxKgY3PxG5YQGD+LK8RL484yrZWtR+qyIP9NP7+umE9HtzDxnhcXeV6
	Fn/V8v+jV7RWgTDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773050557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYHDwVpNTjo6GnoiOz4n6t12VW6VfF1jYLPHSYmUKrE=;
	b=FHQEYBYqevRTbJ4Is4MaRARPFqoFXy80mJcLN5qhzIhNlYD69UcLZrnageE5eLJ9LFtfO1
	//sIo34Ounqqup6qeJztt/v35ggAQrXvLQt4Q3s+gZMolqxM2v7wf/ye8wEpet8LhOlBmS
	eupIZMjgMFKsufoT7XjIocAa9mDxf/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773050557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYHDwVpNTjo6GnoiOz4n6t12VW6VfF1jYLPHSYmUKrE=;
	b=7NkrPQgB8KKBks7CxKgY3PxG5YQGD+LK8RL484yrZWtR+qyIP9NP7+umE9HtzDxnhcXeV6
	Fn/V8v+jV7RWgTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A07063EE3B;
	Mon,  9 Mar 2026 10:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yZckJ72arml5GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Mar 2026 10:02:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E839A09A4; Mon,  9 Mar 2026 11:02:37 +0100 (CET)
Date: Mon, 9 Mar 2026 11:02:37 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: remove externs from fs.h on functions modified
 by i_ino widening
Message-ID: <urwtj2zfmxfhksormxkzb2z26a7nt5vesbkuwtow47fflf4u2l@x7cbae5dv7tr>
References: <20260307-iino-u64-v2-1-a1a1696e0653@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307-iino-u64-v2-1-a1a1696e0653@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sat 07-03-26 14:54:31, Jeff Layton wrote:
> Christoph says, in response to one of the patches in the i_ino widening
> series, which changes the prototype of several functions in fs.h:
> 
>     "Can you please drop all these pointless externs while you're at it?"
> 
> Remove extern keyword from functions touched by that patch (and a few
> that happened to be nearby). Also add missing argument names to
> declarations that lacked them.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
...
> -extern void inode_init_once(struct inode *);
> -extern void address_space_init_once(struct address_space *mapping);
> -extern struct inode * igrab(struct inode *);
> -extern ino_t iunique(struct super_block *, ino_t);
> -extern int inode_needs_sync(struct inode *inode);
> -extern int inode_just_drop(struct inode *inode);
> +void inode_init_once(struct inode *inode);
> +void address_space_init_once(struct address_space *mapping);
> +struct inode *igrab(struct inode *inode);
> +ino_t iunique(struct super_block *sb, ino_t max_reserved);

I've just noticed that we probably forgot to convert iunique() to use u64
for inode numbers... Although the iunique() number allocator might prefer
to stay within 32 bits, the interfaces should IMO still use u64 for
consistency.

Otherwise I like the changes in this patch so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
