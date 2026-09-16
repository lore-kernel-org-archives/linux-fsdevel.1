Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03884AD7F4;
	Wed, 16 Sep 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552051; cv=none; b=obCJma0sbD3T8wqK44Ixk8sz1wE60Ls5y9EQzkt6x/YsKWDgbof93WA0LTw+8Qfj0UdD0SNiR8/mCeUFCZBYQGwu1/l9wlJDl4fjJyZyW8QZCJFRj5hNk5EqqE+ZFk8vj5ixdTyowv4qqCEAZjXYJXtUVz/yg3DwjYN96aVq8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552051; c=relaxed/simple;
	bh=2/nUhID70nd3UBtWpIokx/y0ElhYZeJTlYAQxWD3dCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEVjs38Z62YSeiiss7dGLpiq+rczkKbyhFdfpRK1rEwGIV88yjzk9BpJlEGZZZLYtY9RE+DvlPsHImFi/PXYfmlRFomp/sD5dpqEzfCd4iFpg9CA+Fl6fLao4pMOK0fxdfM8T0EHQXNjct48oXz9D7kmkheXsixA3mxW4IvWEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dmPi5gY3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ovXlcxtU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+8XU9v2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y8BLwrd5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dmPi5gY3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ovXlcxtU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+8XU9v2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y8BLwrd5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9A481FE17;
	Wed, 16 Sep 2026 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789552034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqY+24AxyOUUC4qwBGW7FIJfuFQNNQ3qEH9mDMCErn4=;
	b=dmPi5gY3xI5A3GKfgqy3q4tBpID79U3gIGlq8CUVAmt6FulzCvSTidQc6kaL5+IBQ9O+B2
	EwGS7hcqITi20utnp8GIzM23bRx9xG7U4Vx3rQT0SRj5U91J0rd6CIZ3y3UwGaYr0aDuOZ
	y0IUubz5/xMsaMtBLs/kfL6Fc2fnj94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789552034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqY+24AxyOUUC4qwBGW7FIJfuFQNNQ3qEH9mDMCErn4=;
	b=ovXlcxtUtHm0zyFIYYGdTdBBhiaLKxQcEDmm2+esPKjr+sma6yz78vbwJlXLnsHixLbNNu
	o53DvaZx1kyz8VAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789552029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqY+24AxyOUUC4qwBGW7FIJfuFQNNQ3qEH9mDMCErn4=;
	b=f+8XU9v2TVBwfZt3u+GBWZk9uRcQHch+EwiBx3eyfXpz5zG+BcfSpym5k0gO/Y2rSh1d/j
	W0VaJb69+RWCR2p215X0xU6KP74kDwjIVPnJqATS/HYur2r0rW5y0NOXUOYC+d4JGtajIp
	ds55BTi3nXf+EJA0OXHOEwCmiACq+OI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789552029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqY+24AxyOUUC4qwBGW7FIJfuFQNNQ3qEH9mDMCErn4=;
	b=Y8BLwrd5WunkjQ8ENA5k0LSFWujp9ablOjR1gKFewBuvPJ2cbvmMP8W+IMTgjOe5GSTJCR
	R1WXmeeTyiUV61Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A2F3136DB;
	Wed, 16 Sep 2026 09:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hOKOOJtlqmpJKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Sep 2026 09:47:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 804A7A13B4; Wed, 16 Sep 2026 11:47:00 +0200 (CEST)
Date: Wed, 16 Sep 2026 11:47:00 +0200
From: Jan Kara <jack@suse.cz>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: hoobnn <853555@gmail.com>, ericvh@kernel.org, lucho@ionkov.net, 
	v9fs@lists.linux.dev, linux_oss@crudebyte.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sripathik@in.ibm.com, aneesh.kumar@linux.vnet.ibm.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] 9p: dynamically allocate directory entry names
Message-ID: <vz5bum547fqyxf5z4m3x7tuqkuq52jlopm65t7hvynqeulh7i3@2t4wnhfxs7qv>
References: <20260826064819.52523-1-853555@gmail.com>
 <aqa9WXmrgd_P7yxw@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqa9WXmrgd_P7yxw@codewreck.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ionkov.net,lists.linux.dev,crudebyte.com,davemloft.net,google.com,redhat.com,in.ibm.com,linux.vnet.ibm.com,vger.kernel.org,infradead.org,zeniv.linux.org.uk,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Mon 14-09-26 00:12:25, Dominique Martinet wrote:
> +fsdevel@ & vfs maintainers to Cc TL;DR:
> Should the 9p .iterate_shared() dir_emit files with path
> components > NAME_LEN, as allowed in fs/readdir.c verify_dirent_name()
> only enforcing length < PATH_MAX, or should we skip any such entry given
> nothing can interact with them later anyway?

So my take on this is that I'd refuse any entries larger than NAME_MAX
(255). As you say it is very likely something in userspace or other parts
of the kernel (fs drivers, ...) will break with such names so I don't think
there's a good reason to provoke these bugs. For example POSIX states
readdir(2) should be returning component of at most NAME_MAX length and
although we don't take POSIX very seriously in the kernel in this case I
don't think there's a good enough reason to deviate from it.

								Honza

> hoobnn wrote on Wed, Aug 26, 2026 at 02:48:19PM +0800:
> > p9dirent_read() copies names into a fixed 256-byte buffer. A name that is
> > valid on the host filesystem but longer than that buffer makes strscpy()
> > fail and aborts getdents64(), hiding the remaining directory entries.
> > 
> > Keep ownership of the protocol-allocated string in p9_dirent and free it
> > after dir_emit() consumes the name.
> > 
> > Fixes: 7751bdb3a095 ("9p: readdir implementation for 9p2000.L")
> > Closes: https://github.com/microsoft/WSL/issues/41192
> > Assisted-by: Codex:gpt-5
> > Signed-off-by: hoobnn <853555@gmail.com>
> 
> Sorry, but pseudonyms are not allowed to contribute to the kernel:
> please use a real name here.
> 
> 
> Okay, I've just tried with a dummy server that adds a few bytes to every
> filenames, and it's weirder than I expected... The vfs only checks for
> PATH_MAX length, not NAME_MAX, so e.g. getdents64 will list the long
> file name but then any operation on that file name will fail with
> ENAMETOOLONG...
> I think it'd make sense to be more clear about this in the commit
> message.
> (The patch subject is also pretty bad, by the way, in that "dynamically
> allocate ..." sounds like it adds an extra allocation whereas it just
> reuses the one that exists, so it should be more like "9p: skip
> intermediate directory entry name copy in p9dirent_read()" and explain a
> bit more how the current readdir processing works in the commit message
> e.g. first alloc+copy in p9pdu_vreadf etc)
> 
> 
> Anyway, code-wise:
> - p9_dirent are very temporary and are meant to get freed immediately,
> I think it's perfectly fine to skip the strscpy here and pass the
> pointer directly.
> - I'd like a second opinion on whether it's acceptable that we return a
> file whose lenght is > NAME_MAX to userspace here; we're already calling
> strlen() again in v9fs_dir_readdir_dotl() so we could just skip the
> dir_emit() call here if required.
> 
> 
> Thanks,
> -- 
> Dominique Martinet | Asmadeus
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
