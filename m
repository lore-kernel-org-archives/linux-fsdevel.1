Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03751F3B85
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267931; cv=none; b=WYsUFOD8brmSROLvhUWEbif/Zvq+3ZzFw7XXgSm85SuaKwXSDRpuxh5yBFKtuP6QQw9OcxmexvBXtRmdxTLCGTvlKF4s44TvvtMDH3xZsDGqtDbE3U56QttFSL8Vwxy2+9XNbBGeriXCbkYzRzcuetl6h/tLYm+eJ9upj6jxQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267931; c=relaxed/simple;
	bh=pT4u9T+1r+S9YV37bgBruXMES3CvFU9vu1M14DAtb3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzIsenXc0YN2RjlAmHKIX5VJqzSUYIb4JCGsfcYCBIdpuxSPtXvYiUhNxR6Y6eodoPS95KPPc2gvnz0BYwVvskFTYfot2WaBPB675dtJ1XxA233D68V1PU7JxUbQxYyhZ78pSZy691vxFYkFBS4fURZv6YpxNCO4eO/6NYTxK/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y23RwSFB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XLaev6wn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GtSCubq9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EAE/rcPs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y23RwSFB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XLaev6wn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GtSCubq9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EAE/rcPs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2BA07C447;
	Tue, 28 Jul 2026 19:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785267923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFxIVjPMvgkVWUzEgqxOj3BBfaPaRw/MzSwBpY0MgOc=;
	b=y23RwSFBhAwyEHA4xWa97KWuX04f6Xd+j+8ci0nTxGA5/4i/SB4JUVNelgkXpTa0kFY+J+
	oT/co3KKIukDLoLreiSVTpWqiJcApSrBBD4Hc9ltgHF5iz7Vb8/3RRowjY8Bf5vGcBeoK+
	WVHnnKXDxn4E+1E5+H9mmmcLjSoMrnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785267923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFxIVjPMvgkVWUzEgqxOj3BBfaPaRw/MzSwBpY0MgOc=;
	b=XLaev6wnVurb4QoGX7ZZLaluXx9djhriT14I+3PrhsStDHUAF9ZPl5DuwhcoO5OubQo3kb
	YCTUXL7uiQsdvIBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785267919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFxIVjPMvgkVWUzEgqxOj3BBfaPaRw/MzSwBpY0MgOc=;
	b=GtSCubq9OCDXBZK6NqEGJ8R7FFCj0GoZ4fNj18gUnQkf+TxJK6npfU9lOjSZAjxWXVRCz0
	q5Cg16zpn+UXJuG8MPnR2UtNf+T+91tuN32V2MwF9Y9CbLv9qrWEMtlEWw8Wgb/BE9xG6r
	S7SpGcTavfTY3k/ZH9rmlu0qRaI+beM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785267919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFxIVjPMvgkVWUzEgqxOj3BBfaPaRw/MzSwBpY0MgOc=;
	b=EAE/rcPsHms3qwJsos/qZY7zk2a5OEzsOUeVtugdjrmw6jHTNQ0OkPeX+Cgh9cct0RMv3p
	kDzC0VeJRrZjjGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A96A2779B1;
	Tue, 28 Jul 2026 19:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uepQKc8GaWo/RAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 Jul 2026 19:45:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 56172A10B6; Tue, 28 Jul 2026 21:45:11 +0200 (CEST)
Date: Tue, 28 Jul 2026 21:45:11 +0200
From: Jan Kara <jack@suse.cz>
To: Chao S <coshi036@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, 
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
Message-ID: <bnchcfog427eo3bxt5h6qautlq7sb2o4ww7cjgad73biycdn5f@np7qkbyqizup>
References: <20260430053645.1466196-1-coshi036@gmail.com>
 <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
 <CACd_6n17-pJuNoCLsstP7goocedrr5F8T8BwTjRUNx8frKEPgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n17-pJuNoCLsstP7goocedrr5F8T8BwTjRUNx8frKEPgA@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Sun 19-07-26 02:28:54, Chao S wrote:
> On Thu 30-04-26 09:28:13, Jan Kara wrote:
> > But it would be actually very welcome if you took the work, went through
> > all the places using end_buffer_write_sync() and converted them in
> > filesystem-by-filesystem to check for IO error by checking
> > buffer_write_io_error() instead of buffer_uptodate() and then we can drop
> > clear_buffer_uptodate() call from end_buffer_write_sync().
> 
> Sorry for the long delay, I've been working on some patches and a paper
> deadline.  Also, you were right about v2, and I have dropped it.  I
> would like to
> take the conversion work.
> 
> Before writing it, I found your "fs: Fix missed inode write during fsync"
> series, v4 of 16 July.  It removes four of the sites I had on my list, so
> I will base this on top of it once it lands.  Say if you would rather
> sequence it differently.

Yes, please base your changes on top of vfs tree
(https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all). My
patches are already in there now.

> (end_buffer_write_sync() is now bh_end_write(), per b20f15420f78.  Current
> names below; line numbers against v7.2-rc1.)
> 
> The sites, one patch each:
> 
>   core     fs/buffer.c:621 (mmb_sync), :2803 (__sync_dirty_buffer)
>   adfs     fs/adfs/dir.c:194
>   ext2     fs/ext2/xattr.c:772
>   ext4     fs/ext4/ext4_jbd2.c:399, fs/ext4/mmp.c:52
>   omfs     fs/omfs/inode.c:148, :162
>   exfat    fs/exfat/misc.c:190
>   fat      fs/fat/misc.c:358
>   ocfs2    fs/ocfs2/buffer_head_io.c:69, :449, fs/ocfs2/journal.c:675, :691
>   gfs2     fs/gfs2/log.c:110, :324
>   jbd2     fs/jbd2/commit.c:880
>   removal  fs/buffer.c:210 and :444
> 
> Conversions first, removal last.  The list is short because
> __sync_dirty_buffer() and mmb_sync() test internally and return -EIO, so
> the ~40 callers that use the return value need no edit of their own.

Sounds good.
 
> I would like your suggestions on the following.
> 
> 1. BH_Write_EIO is sticky.  It is cleared only on rewrite
> (fs/buffer.c:1196), and only if BH_Req was already set, which
> BUFFER_FLAGS_DISCARD clears on its own.  So a converted test can see a
> stale error.  I would fix this first, either by making the clear at :1196
> unconditional for REQ_OP_WRITE, or by adding BH_Write_EIO to
> BUFFER_FLAGS_DISCARD.  Which do you prefer?

I think we should add it to BUFFER_FLAGS_DISCARD. It doesn't make sense to
keep it on a discarded buffer.

> 2. jbd2: log_bufs is a mixed list.  Commit descriptors come from
> journal_end_buffer_io_sync(), which never sets BH_Write_EIO; revoke
> descriptors from write_dirty_buffer(), so bh_end_write().  I would convert
> fs/jbd2/commit.c:880 to the disjunct !buffer_uptodate(bh) ||
> buffer_write_io_error(bh).  The alternative is to add
> mark_buffer_write_io_error() to journal_end_buffer_io_sync() and convert
> all three jbd2 sites.  Which do you prefer?

Please convert journal_end_buffer_io_sync() to use
mark_buffer_write_io_error() so that we completely get rid of this
antipattern.

> 3. bh_end_async_write() has the same clear at fs/buffer.c:444.  I would
> remove both, which needs the gfs2 patch first since gfs2 reads that bit at
> fs/gfs2/log.c:110 and :324.  I can also leave the async half out.

Please change gfs2 the same way as you are fixing jbd2. Keeping the mix of
uptodate & write_io_error checks only makes things more fragile...

> 4. ocfs2: fs/ocfs2/journal.c:691 sits inside an outer
> if (!buffer_uptodate(bh)) at :675, so dropping the clear stops ocfs2 going
> read-only after a failed metadata checkpoint.  I would convert both sites
> and Cc ocfs2-devel.

Yes, please.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
