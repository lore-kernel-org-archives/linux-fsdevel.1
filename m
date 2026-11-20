Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179426;
	b=bhNNIp9KpgjB99odP+HXbxkyG2Q1Df/2LSf6BHiE8yAjWfwWpiXm33t1l0fAuLNOd5lc
	 NP/FGqCGjgtZKmB9gFJT4RPFzYYhOvUVdyYQhFIRAwp7RuwYpaFAJtKDpwB5ovuGHP+aB
	 cjHJh2bTPWGD7TZ6e7fitAQl7XAC8Iy/a4DCSPewHKSIYvjtKQ7dVoRWrjqLyzKaemfRC
	 Qrc1O0gjnniADGZ6zS47IZnJl/k0eM8hplR0iwc2fexoJqedwHlNaLQTbZCipzD0PBQ+x
	 KS8i/SBT7nXT1GvK50QW9whvuu5Lqzuw/pKrsuFLSfvWVnB06pCiaXcybprMTyshl8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179426;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=CQSfXtGExS+r7EMGoE8V+0jN1UrSAhuXyvkW/z2/teM=;
	b=muV3XfPVVGb4ng6q2Jhc4KOX4fLLwd1P4sb1Hd4SvWmTBz0g7FWKtypIi8ps+T6Y4GCB
	 H3oSYlNqFefU9NrrFxUNJvlHogZ/MawRYKMPoX1AqG6gPkZsT6Zj+Eazv9mnZU5WrEUc4
	 1b1SR0b7phwLo5iyQph6tKOEtA1m0lhNkKaNm/seMggLS0VUSPU1Wmw3VseMmMohwn3qc
	 aRYp3AHTfVsoNEskgPptFD3UGowzXQ5hYqq87Kbg3YWa2dyJuinuvhdvurFVAcGNIYYrI
	 Wj3MxxGt86y82ZYA2ThG7Iu1oOXxUNNo4hLVdlzB1uHA5/JDbS8HqPXJnJMHAwgqUaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LasEFBFg;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="7sbxD/IL";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GXa0G4Sc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0tpA+nrB;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38760A2618
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 12:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA38760A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LasEFBFg;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7sbxD/IL;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GXa0G4Sc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0tpA+nrB
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0D70225DD;
	Fri, 20 Nov 2026 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795179423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CQSfXtGExS+r7EMGoE8V+0jN1UrSAhuXyvkW/z2/teM=;
	b=LasEFBFgLQ+1UWgPIdr9dCi32BdrBAycZx0IIoI5uPwFVrBE5Wed2nF0LrNpXx0aM8L0N4
	K6tWfnWk9BQNpPm9K488Bcvgv5RQP/StiPwdRzt0U+7fgPzBdKwqE4oVJ1VtBXNOUy4zRR
	6UrWAA6NTWrrHfD6FflKDjETCMC9PtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795179423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CQSfXtGExS+r7EMGoE8V+0jN1UrSAhuXyvkW/z2/teM=;
	b=7sbxD/IL1Mz+S5J1xgs0rVX1cA52u8K7/61A4bfwUk5efclNwJCkD9HfVRpu4/q9JNFvJF
	KrA0xIefmAE7ZADw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795179421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CQSfXtGExS+r7EMGoE8V+0jN1UrSAhuXyvkW/z2/teM=;
	b=GXa0G4Sc5WllTulPtVYY3HJ/Zw6L1AZytB9Tw7MdSoKzMBOEMGVSaeE03gx8mNI6zOjfIt
	8EOMw0qETl92safdfrMS7YTRIcbN7NDaSY0y3zsHoTedDlFHHxT6gNZPyIk19xJwmEIthF
	plEUn3+1+OgEpnx2VLDb+HN2uER+Cfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795179421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CQSfXtGExS+r7EMGoE8V+0jN1UrSAhuXyvkW/z2/teM=;
	b=0tpA+nrB7uYb20MZpZ7ieYKgB2zTzzsVbCVQCcLrMZ29EefMiX200O4ZFiWQjtZrFGWbYG
	RUAdqlCXgTIzrBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C93171342D;
	Fri, 20 Nov 2026 12:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rIv/J51DAGvxTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Nov 2026 12:57:01 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 532EF25F5E; Fri, 20 Nov 2026 13:56:57 +0100 (CET)
Date: Fri, 20 Nov 2026 13:56:57 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Ye Bin <yebin@huaweicloud.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: hold freeze protection across writable regular file
 ->open()
Message-ID: <4czsdzcffhzpkcdf7zffpj2ow2oa2skb64f4brrbf6z2jqmbik@zkeuyyuyvcdp>
References: <20261112135245.3347102-1-yebin@huaweicloud.com>
 <20261120-zehnfach-flugfeld-textil-72ab74773d45@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-zehnfach-flugfeld-textil-72ab74773d45@brauner>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 20-11-26 12:19:03, Christian Brauner wrote:
> On Thu, Nov 12, 2026 at 09:52:45PM +0800, Ye Bin wrote:
> > From: Ye Bin <yebin10@huawei.com>
> > 
> > A writable open of a regular file reaches the filesystem's ->open()
> > callback without holding any superblock write (freeze) protection.
> > ->open() can nevertheless write to the filesystem: ext4_file_open() ->
> > dquot_file_open() -> dquot_initialize() may acquire a dquot and write
> > the quota file, which starts a jbd2 transaction.  If the filesystem
> > reaches SB_FREEZE_COMPLETE in that window, ext4_journal_check_start()
> > hits
> > 
> > 	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> > 
> > and the open then sleeps in jbd2 until the filesystem is thawed.
> > 
> > The hole was created over time:
> > 
> >   - Commit 907f4554e252 ("dquot: move dquot initialization responsibility
> >     into the filesystem") moved quota initialization into ->open() and
> >     introduced dquot_file_open(), making ->open() a potentially writing
> >     operation for writable opens.
> > 
> >   - Commit eb04c28288bb ("fs: Add freezing handling to mnt_want_write() /
> >     mnt_drop_write()") added sb_start_write() to mnt_want_write() but
> >     deliberately kept the write reference held by an open file on the
> >     non-freezing __mnt_want_write() variant, so the file's own write
> >     reference does not protect its ->open().
> > 
> >   - Commit 64894cf84327 ("simplify lookup_open()/atomic_open() - do the
> >     temporary mnt_want_write() early") moved the temporary write count
> >     into do_last() and dropped it before finish_open(), so a writable
> >     open that is not O_TRUNC reaches ->open() with no sb write count at
> >     all.
> > 
> > Since then only O_TRUNC opens take mnt_want_write() in do_open().
> > 
> > Fix this by taking mnt_want_write() for any writable open of a regular
> > file and holding it across vfs_open()/->open().  Regular files are
> > checked explicitly so that opening device nodes on a read-only mount is
> > not newly rejected.  Read-only opens are unaffected.
> > 
> > Fixes: eb04c28288bb ("fs: Add freezing handling to mnt_want_write() / mnt_drop_write()")
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ---
> >  fs/namei.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index f573fd0aacaf..0ee4cf282cf5 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4906,6 +4906,7 @@ static int do_open(struct nameidata *nd,
> >  	const struct mnt_idmap *idmap;
> >  	int open_flag = op->open_flag;
> >  	bool do_truncate;
> > +	bool got_write;
> >  	int acc_mode;
> >  	int error;
> >  
> > @@ -4935,12 +4936,23 @@ static int do_open(struct nameidata *nd,
> >  		return -ENOTDIR;
> >  
> >  	do_truncate = false;
> > +	got_write = false;
> >  	acc_mode = op->acc_mode;
> >  	if (file->f_mode & FMODE_CREATED) {
> >  		/* Don't check for write permission, don't truncate */
> >  		open_flag &= ~O_TRUNC;
> >  		acc_mode = 0;
> >  	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
> > +		do_truncate = true;
> > +	}
> > +
> > +	/*
> > +	 * ->open() can write to the filesystem, e.g. when it initializes
> > +	 * quota, so writable opens of regular files need freeze protection
> > +	 * as well.  O_TRUNC opens already need it for handle_truncate().
> > +	 */
> > +	if (do_truncate ||
> > +	    (d_is_reg(nd->path.dentry) && (file->f_mode & FMODE_WRITE))) {
> >  		error = mnt_want_write(nd->path.mnt);
> 
> No, I don't think that's the right thing to do. Every
> open(O_WRONLY|O_RDWR) would now block for a regular file on a frozen
> filesystem even if it never writes. That's not acceptable. Log files,
> editors, backup tools, they all would hang rather than fail on write.
> It's a drastic uapi change.
> 
> The write in ->open() is from the quota stuff. So that should be a quota
> fix and not penalize the whole VFS layer.

Conceptually I agree with you but we cannot easily grab freeze protection
from ->open() where we do quota stuff because VFS may but need not be already
holding it.

Somewhat paradoxical is that quota code will actually write anything only
if we are creating quota structures for a new user but that never happens
from ->open (it would happen already during vfs_create() in
dentry_create()). It is just ext4 that unconditionally starts a transaction
because it doesn't know the context... But ocfs2 actually does write if we
are touching the first inode of this user so there the problem is real.

Hrm, but I think we could just use sb_start_intwrite() in filesystem's
.acquire_dquot methods and be done with that. That won't deadlock and it
will silence the warnings / fix ocfs2 breakage. AFAICS only ext4 & ocfs2
actually need anything done. Ye?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
