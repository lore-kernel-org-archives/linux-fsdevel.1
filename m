Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B53D5227
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040444; cv=none; b=VqdIj/IYtOpEOzcCNiFFeQoSUqYK1vbL1C6JzH4PACXSjJ8kdKR44cYzzCbhccrPIM9Pi3+jQlxzsk4NaOSsUcXuZmSl+pv0/1DxHeHbW25waEUktM6fNLy1DDoVtlEwM537rrYbYkYpr6cknmXziIYn69zMLlEg+dotIRbprAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040444; c=relaxed/simple;
	bh=w81+QKJnazm2+8Ef5OWth5g9nENAhW1K7tUHDbUFeyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meoH1Vz4k+TJsAWAPULqFbIsOIZ3YqWnj7tb7T7x8NWu8ueinyUj2qcxyX4kMSodRxwfPoB7xSLP3NHc6+QCQ/95LAb/FrwUJGclmxshWZT1u7duiPe25uyjF+78pv9SuZrw+1ko0zL/h0nqsO4+q3S+BUIiv2Wn97i+4YE9FPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HBBNZvco; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0hUjuPOX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qKUMENyp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xEpqk35l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HBBNZvco";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0hUjuPOX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qKUMENyp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xEpqk35l"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E93F95BCC4;
	Wed,  1 Apr 2026 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775040441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/LIvhuUhEpvyIxVl+sFFPKAGeGApPpeSdxd+SSDF98=;
	b=HBBNZvcoER7fIH7JYfSNUj9GHgegpt9WsexwmI7JjipjlW8zfip6d7sQoHh6qoD68vT9jP
	ALk3eSFOGIWVKagtEPMjmJFv5LnfIPNzV1fKfx4z8glIrH6ChgJuXoqWqvWG4Zwjh89CvC
	GC0ufSWjbZA2b+aojdhBki2YRC5seFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775040441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/LIvhuUhEpvyIxVl+sFFPKAGeGApPpeSdxd+SSDF98=;
	b=0hUjuPOXCRNcAgarc2Zuvbfr0qsUeIp6fbla0Q8iG3MS0kVyWHOiXEuU/WDL2CG24Ph3Oq
	hC/e0KA3gqf0uUDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775040440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/LIvhuUhEpvyIxVl+sFFPKAGeGApPpeSdxd+SSDF98=;
	b=qKUMENyp05fG1WSZfs5oZQPWP9sarnYDpbU02Uw3ibP3Hep0/ZrChAacr14aAjAqbg/srv
	Cm6WH0GuIWXbjzrRrx7IpMBrPsbSQtRsFNbWcmamcpD6lmI6z35NLbDvzh8qw4FSOtXCk1
	gzUiKy0GFS3dkGOryGprUSy0s5YEYq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775040440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/LIvhuUhEpvyIxVl+sFFPKAGeGApPpeSdxd+SSDF98=;
	b=xEpqk35lVlR8xunECtMaqijLCOaf1zILHi+8/kikJwXV0NFvFEmlIvwn9X2sZ8vca+oRGo
	43c6WK2jLOsG8BDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9164A0B0;
	Wed,  1 Apr 2026 10:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oi9INrj3zGl9GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Apr 2026 10:47:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A51E0A0AFD; Wed,  1 Apr 2026 12:47:16 +0200 (CEST)
Date: Wed, 1 Apr 2026 12:47:16 +0200
From: Jan Kara <jack@suse.cz>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
Message-ID: <gsfsr3o7lkwrpzdbkvfcgpr3fudimmzsinpupikpo2rqto2mn5@w2fsv7rlbi4o>
References: <20260320130615.1109449-1-kartikey406@gmail.com>
 <acvkAuq4_cWmegC7@infradead.org>
 <fa551c4c-7e9b-47b4-9011-92adc880ed1a@kernel.dk>
 <acvmXDBm1xOak_Uq@infradead.org>
 <26d2e8f0-8b82-4192-9edb-e31f3975bb82@kernel.dk>
 <e3gspf7vh2h7r5llbc7qman7tmqiyr3pd4nrzpu3cyuqtlolxy@2kobbzkgjr4d>
 <CADhLXY7N5qbXn0K+rTE4po9Kdt25vH4wcdD6fT22Dbu=CpJHzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADhLXY7N5qbXn0K+rTE4po9Kdt25vH4wcdD6fT22Dbu=CpJHzA@mail.gmail.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[d31a3b77e5cba96b9f69];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Wed 01-04-26 14:02:27, Deepanshu Kartikey wrote:
> On Wed, Apr 01, 2026, Jan Kara wrote:
> > Hum, I'm probably missing something but I just
> > don't see how the proposed deadlock is supposed
> > to happen.
> 
> You are correct, I apologize for the incorrect
> analysis in the patch description.
> 
> After looking more carefully at the code, the
> actual deadlock involves sendfile() and a
> concurrent fallocate() on the same inode:
> 
> 1. sendfile() write side calls blkdev_write_iter()
>    which acquires inode_lock_shared().
> 
> 2. Concurrent fallocate() calls blkdev_fallocate()
>    which tries inode_lock() (exclusive) and blocks
>    waiting for the shared lock to be released.
> 
> 3. sendfile() read side then calls
>    blkdev_read_iter() which tries
>    inode_lock_shared() but is blocked because
>    rwsem prevents new readers when a writer
>    is waiting.
> 
> This creates a circular dependency where nobody
> can proceed, causing the hung task.

I'm afraid you're using some LLM for your analysis and it's doing a bad
job. Please verify in the code whether what LLM says to you is in fact
correct (and if you are unable to do that then please learn more before
submitting kernel patches). As a hint, sendfile() for block devices never
ends up calling blkdev_read_iter() (plus there are other bogus things in
the analysis).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
