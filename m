Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6A399039
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289089; cv=none; b=sVE8VL1VkgpCkQksOlg7jGgetop5sGs/TZkq28LYK80lW1QbDr7VqyF7Fyk2g5egzvidXHpyghKVFdyQvJxeQ6Lw/9uxNrUry2EurOqugIYs+Cn9AIvMU6gx5bKvyHsWAanDdEp/zkjbA0klW1owDtllvnIdmPPdRbuN4urenN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289089; c=relaxed/simple;
	bh=NWhaPbMoerieAbj4qwHpJHtbZj5g44iL1/vkzNViVN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVGAuQ/NkakJ7LKALvXN2wAc0xJiSWAW+mZky7/dHQxeqUsJVTCAd0rP9i5wK7AZ4qNk5JtjGqTE6OGXXW0DVFyeJhErqP1S/P4AzzaZ/QYunMAB10sJRDseUozwlKquY8ekkPYKhM3IHR5gD/0ZXmBskmhfvMpXCXbwheyIpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PheeLn7C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9J78AAj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PheeLn7C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9J78AAj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PheeLn7C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9J78AAj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PheeLn7C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9J78AAj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 805445BD14;
	Mon, 27 Apr 2026 11:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777289085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MyfwDrkIflhGw86d1d8632pJFXn+9tHMigBB0uW59Z8=;
	b=PheeLn7CqDH4JM3gcFnhelg6MWja9BGZFC+VoUeMHkEj1eNO+NZYyK4VSyoSzKicaNbl2j
	TgDmRzhbm6yyVGV6WuxZflZdnBgCgFOOFJNcAWB4r+INrDyfslLgmspCSxhZC6H5DtLPw/
	gRww7FuI4sIM3R6Dd+OgdKAU2csPOic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777289085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MyfwDrkIflhGw86d1d8632pJFXn+9tHMigBB0uW59Z8=;
	b=J9J78AAjinEdYkXHgUQN14Rtqg1a6T+3Mv8ziqFjA/6ajIw4Gqro3ufH8TsdGBs7NLFgtQ
	0NbVyc/q4QGLdnAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777289085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MyfwDrkIflhGw86d1d8632pJFXn+9tHMigBB0uW59Z8=;
	b=PheeLn7CqDH4JM3gcFnhelg6MWja9BGZFC+VoUeMHkEj1eNO+NZYyK4VSyoSzKicaNbl2j
	TgDmRzhbm6yyVGV6WuxZflZdnBgCgFOOFJNcAWB4r+INrDyfslLgmspCSxhZC6H5DtLPw/
	gRww7FuI4sIM3R6Dd+OgdKAU2csPOic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777289085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MyfwDrkIflhGw86d1d8632pJFXn+9tHMigBB0uW59Z8=;
	b=J9J78AAjinEdYkXHgUQN14Rtqg1a6T+3Mv8ziqFjA/6ajIw4Gqro3ufH8TsdGBs7NLFgtQ
	0NbVyc/q4QGLdnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7511B593B0;
	Mon, 27 Apr 2026 11:24:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EzORHH1H72mlVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 11:24:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 25E34A0AFF; Mon, 27 Apr 2026 13:24:45 +0200 (CEST)
Date: Mon, 27 Apr 2026 13:24:45 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chao Shi <coshi036@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [RFC PATCH] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
Message-ID: <mxlij3dhmnqnile7hm2t4ixomaumibooydo6puym3edt2o2zyg@toyj4j5yid2e>
References: <20260426020137.1221985-1-coshi036@gmail.com>
 <ae17nszpQA7Eqbc6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae17nszpQA7Eqbc6@casper.infradead.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,vger.kernel.org,suse.cz,sung-woo.kim,purdue.edu,fiu.edu];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sun 26-04-26 03:42:38, Matthew Wilcox wrote:
> On Sat, Apr 25, 2026 at 10:01:37PM -0400, Chao Shi wrote:
> > A WARN_ON_ONCE(!buffer_uptodate(bh)) in mark_buffer_dirty() is reachable
> > from the buffered write path on a block device when the underlying
> > device returns I/O errors at high density.  Reproduced by fuzzing an
> > NVMe controller (FEMU) that returns crafted error completions for a
> > sustained workload from /dev/nvme0n1.
> > 
> > The race is:
> > 
> >   CPU A: block_commit_write (folio lock held)        CPU B: end_buffer_async_read
> >     set_buffer_uptodate(bh);
> >                                                        clear_buffer_uptodate(bh);
> >     mark_buffer_dirty(bh);  /* WARN fires */
> 
> Why are we calling clear_buffer_uptodate() in end_buffer_async_read()?
> If the buffer is uptodate, we shouldn't be reading into it.  If it's
> not uptodate, we don't need to clear the uptodate flag because it's
> already clear.
> 
> I've been deleting calls to ClearPageUptodate and folio_clear_uptodate()
> from filesystems; it's almost always the wrong thing to do.  But the
> buffer cache does have slightly different rules from the page cache,
> so this may not translate well.

Right, I think the clear_buffer_uptodate() call in end_buffer_async_read()
is indeed superfluous and we can just remove it - possibly replace with
WARN_ON_ONCE(buffer_uptodate(bh)) - to deal with this race.

That being said block_commit_write() could possibly race with
end_buffer_write_sync() as well and there the clear_buffer_uptodate()
should stay (well, unless we want to do a serious rework of IO error bh
handling). So the changes to block_commit_write() might still be needed.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
