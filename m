Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBAD445AFF
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520286; cv=none; b=i1+HI/tIJPo5EBkyLw21qLmXEgNfR3Ohey/oK7jxipRGG13l13+V/l7Res1cJM5giPNJQfjECixg0crL7CCrjnQQyHy7ohBOnSiuztQI+IEnmTtWdqJX6ggB24iFQjsOk77KVGFqDvtzF9lcdSHDmAgrrKU+xuShjwnY62yLqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520286; c=relaxed/simple;
	bh=GSzs3ohFwSpz3Usw0NMxtmbCqvzjHJNfDAev5jozZQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3P+OkVSamKzCQ481WUUDhd8wGEZ7rJFJJHL50KS9fsOPGVrRo8SFrMw5/sNJ3osuZsfSEvOyP+aFHYWO7sBDLWn6kLNm0fvU3khZpOtKjaOB9jLJ3GZvxiuyH5UYUNflqJspI5EYVMuCNRWp6TCz4jnLiOeVT8gjytSRHb3NpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h7xZyb78; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I3pGWSQF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPBbcjqg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G+GR8Jhm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h7xZyb78";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I3pGWSQF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPBbcjqg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G+GR8Jhm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 635CD3F79;
	Fri, 31 Jul 2026 17:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785520274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+JK+qglgn++M009CymMWtIeS3RnPPqQr8EsDrUrbF8=;
	b=h7xZyb78QZMx0miyBdrQIijFbzzQVm1Oq7vWWR0DMW7b0MMc34xRwPL5CLsVqS0xeLyF0f
	mTqqxIwstxI6oG+cKDVyvoAd0Ty25vXlAU8ysDbZddjx06hUAiaH3AZAUPxSPE5IWBtVqV
	mDkKgQoIlcqYUtzYyKmmaprOUbBIoak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785520274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+JK+qglgn++M009CymMWtIeS3RnPPqQr8EsDrUrbF8=;
	b=I3pGWSQFXzVNlVfaXVvSyHDfHhLrqcxML1OSP83W1TWI3/IprZ+i0bzaOk//Q2qdJ4geFw
	MuEccBKPL6yNkJBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785520270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+JK+qglgn++M009CymMWtIeS3RnPPqQr8EsDrUrbF8=;
	b=DPBbcjqg93FulReLibfFQLWM5Wom9Dga9wPhpZR02U1Ye91GTlAS3P856NB63rdj4bv3CI
	yCD6HPYJNgktuQv0sSCqiXLEONgYJxNLEz+Z5U89a5k+PjssggpLlYp6qld9Fmk9/qhhzA
	txk8ZXIEXFpbLp1niXqNvvbPKR0AT+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785520270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+JK+qglgn++M009CymMWtIeS3RnPPqQr8EsDrUrbF8=;
	b=G+GR8JhmuIpxka8+q9jX4Ev9dKlQZLExrsOtbGZ+nMiY9df/MlSGladzNVxYk1zcUTizFo
	cbt2KXFxgCvF8KCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BCAF779B0;
	Fri, 31 Jul 2026 17:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fMv0EY7gbGq1QQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 31 Jul 2026 17:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DBFEEA13A8; Fri, 31 Jul 2026 19:51:09 +0200 (CEST)
Date: Fri, 31 Jul 2026 19:51:09 +0200
From: Jan Kara <jack@suse.cz>
To: Chris S <coshi036@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, 
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
Message-ID: <zuntjkh7ir3wwql3pckp2rq446cxtyzehjsgjldpckvankw5xv@i6wag4niumr4>
References: <20260430053645.1466196-1-coshi036@gmail.com>
 <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
 <CACd_6n17-pJuNoCLsstP7goocedrr5F8T8BwTjRUNx8frKEPgA@mail.gmail.com>
 <bnchcfog427eo3bxt5h6qautlq7sb2o4ww7cjgad73biycdn5f@np7qkbyqizup>
 <CACd_6n1Sht4xs6P_GT0-+wj1uu9Ww_4X=TysQRvq6ZSFJ71CBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACd_6n1Sht4xs6P_GT0-+wj1uu9Ww_4X=TysQRvq6ZSFJ71CBQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 30-07-26 15:47:23, Chris S wrote:
> Hi Jan, I'm currently working on the changes we discussed.  Based on
> vfs.all now.  Four things came out of writing it that I would rather
> resolve before posting.
> 
> 1. mark_buffer_write_io_error() is not safe for jbd2's buffers yet.  It
> dereferences bh->b_folio->mapping directly (fs/buffer.c:1057), and
> jbd2_journal_write_metadata_buffer() points the temporary bh at
> virt_to_folio(jh->b_frozen_data), which is slab-backed.
> buffer_set_crypto_ctx() right next to it already uses folio_mapping() for
> exactly this reason.  So I would send a prerequisite converting
> mark_buffer_write_io_error() to folio_mapping() before the jbd2 change.
> Also worth noting the consequence of A2: in ordered mode the temp bh
> inherits the source folio, so the error lands on the bdev mapping and
> mapping_set_error() errseq_set()s s_wb_err - a later syncfs() on an
> unrelated fd of the same fs can then return EIO.

This you've already solved with Matthew.

> 2. gfs2 already has what we are building: gfs2_end_log_write_bh()
> (fs/gfs2/lops.c:171) calls mark_buffer_write_io_error() and does not clear
> uptodate.  Which means fs/gfs2/log.c:110 and :324 are blind to log write
> errors today, and converting them is not behaviour-preserving - it makes
> them start catching those.  I think that is right, but say if you would
> rather it were separate.

Yes, that's a desirable change. I think it's minor enough that we can keep
it in the series.

> 3. On the sticky BH_Write_EIO: I am adding it to BUFFER_FLAGS_DISCARD as
> you suggested.  That covers discard_buffer(), but there are four other
> clear_buffer_req() sites (fs/buffer.c:1687, fs/gfs2/aops.c:600,
> fs/jbd2/commit.c:1035, fs/jbd2/transaction.c:2462).  Three of them also
> clear_buffer_mapped() and NULL b_bdev, so __bh_submit()'s
> BUG_ON(!buffer_mapped(bh)) makes them unreachable.  Only
> clean_bdev_aliases() leaves the buffer writable, and I could not construct
> a workload that reaches it.

That get's used e.g. when a block is first used for metadata, then it's
freed before it is written, and then the block gets reallocated as data.
Whatever is set on the bdev buffer head is irrelevant at that point. But
clean_bdev_aliases() is practically dead (only called from legacy DIO code
and ntfs). I'd just leave it alone. What would make sense though is to
clear the BH_Write_EIO in bforget() which is generally used by filesystems
on metadata blocks to be freed.

> So I am not sending the ungating patch.  The
> one place it would matter is ocfs2: fs/ocfs2/journal.c:691 is nested
> inside an if (!buffer_uptodate(bh)) at :675 that goes dead once the clear
> is gone, so :691 has to be hoisted out, and it then becomes a pre-use
> check on a sticky flag rather than a post-write one. I will Cc ocfs2-devel
> on that patch.

Not sure what you exactly mean here but it needs to become something like:

	
	if (!buffer_uptodate(bh)) {
		mlog(ML_ERROR, "giving me a buffer that's not uptodate!\n");
		mlog(ML_ERROR, "b_blocknr=%llu, b_state=0x%lx\n",
		     (unsigned long long)bh->b_blocknr, bh->b_state);
	}
	/*
	 * A previous transaction with a couple of buffer heads fail
	 * to checkpoint, so all the bhs are marked as BH_Write_EIO.
	 * For current transaction, the bh is just among those error
	 * bhs which previous transaction handle. We can't just clear
	 * its BH_Write_EIO and reuse directly, since other bhs are
	 * not written to disk yet and that will cause metadata
	 * inconsistency. So we should set fs read-only to avoid
	 * further damage.
	 */
	if (buffer_write_io_error(bh)) {
		lock_buffer(bh);
		if (buffer_write_io_error(bh)) {
		        unlock_buffer(bh);
		        return ocfs2_error(osb->sb, "A previous attempt to "
	        	                "write this buffer head failed\n");
		}
		unlock_buffer(bh);
	}


And yes, CCing lists & maintainers for the corresponding filesystems that
are touched is needed in all the cases.

> 4. fs/jbd2/transaction.c:923, J_EXPECT_JH(jh, buffer_uptodate(bh)) in
> jbd2_freeze_jh_data(): after the series a failed write leaves the buffer
> uptodate, so this stops firing for write errors.  Arguably correct - the
> in-memory copy being frozen is still valid - but it is your assert.  Leave
> it, or convert it?  I instrumented it and ran ext4 with data=journal under
> injected write errors, forcing copy-out; it never saw a non-uptodate
> buffer, so I have no evidence either way.

I'd convert it to:

	J_EXPECT_JH(jh, !buffer_write_io_error(bh), "IO failure.\n");

> One thing I did settle by testing.  fs/ext4/ext4_jbd2.c:416 open-codes
> buffer_req(bh) && !buffer_uptodate(bh) after sync_dirty_buffer(), which
> already returns -EIO.  On an instrumented kernel (ext4 without a journal,
> -o sync, injected write errors) the two agreed on all 40 occurrences and
> never diverged, with BH_Write_EIO set every time.  So that site just
> consumes the return value and the buffer_req() question goes away.

The test

	if (buffer_req(bh) && !buffer_uptodate(bh)) {

is stronger than just checking the return value of sync_dirty_buffer()
because it triggers also if the buffer was written by background writeback
and hit IO error. Arguably sync_dirty_buffer() should return EIO in that
case as well but that's another cleanup I don't want to entangle with this.
So I'd rather change that test to buffer_write_io_error().

								Honza

> On Tue, Jul 28, 2026 at 3:45 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sun 19-07-26 02:28:54, Chao S wrote:
> > > On Thu 30-04-26 09:28:13, Jan Kara wrote:
> > > > But it would be actually very welcome if you took the work, went through
> > > > all the places using end_buffer_write_sync() and converted them in
> > > > filesystem-by-filesystem to check for IO error by checking
> > > > buffer_write_io_error() instead of buffer_uptodate() and then we can drop
> > > > clear_buffer_uptodate() call from end_buffer_write_sync().
> > >
> > > Sorry for the long delay, I've been working on some patches and a paper
> > > deadline.  Also, you were right about v2, and I have dropped it.  I
> > > would like to
> > > take the conversion work.
> > >
> > > Before writing it, I found your "fs: Fix missed inode write during fsync"
> > > series, v4 of 16 July.  It removes four of the sites I had on my list, so
> > > I will base this on top of it once it lands.  Say if you would rather
> > > sequence it differently.
> >
> > Yes, please base your changes on top of vfs tree
> > (https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all). My
> > patches are already in there now.
> >
> > > (end_buffer_write_sync() is now bh_end_write(), per b20f15420f78.  Current
> > > names below; line numbers against v7.2-rc1.)
> > >
> > > The sites, one patch each:
> > >
> > >   core     fs/buffer.c:621 (mmb_sync), :2803 (__sync_dirty_buffer)
> > >   adfs     fs/adfs/dir.c:194
> > >   ext2     fs/ext2/xattr.c:772
> > >   ext4     fs/ext4/ext4_jbd2.c:399, fs/ext4/mmp.c:52
> > >   omfs     fs/omfs/inode.c:148, :162
> > >   exfat    fs/exfat/misc.c:190
> > >   fat      fs/fat/misc.c:358
> > >   ocfs2    fs/ocfs2/buffer_head_io.c:69, :449, fs/ocfs2/journal.c:675, :691
> > >   gfs2     fs/gfs2/log.c:110, :324
> > >   jbd2     fs/jbd2/commit.c:880
> > >   removal  fs/buffer.c:210 and :444
> > >
> > > Conversions first, removal last.  The list is short because
> > > __sync_dirty_buffer() and mmb_sync() test internally and return -EIO, so
> > > the ~40 callers that use the return value need no edit of their own.
> >
> > Sounds good.
> >
> > > I would like your suggestions on the following.
> > >
> > > 1. BH_Write_EIO is sticky.  It is cleared only on rewrite
> > > (fs/buffer.c:1196), and only if BH_Req was already set, which
> > > BUFFER_FLAGS_DISCARD clears on its own.  So a converted test can see a
> > > stale error.  I would fix this first, either by making the clear at :1196
> > > unconditional for REQ_OP_WRITE, or by adding BH_Write_EIO to
> > > BUFFER_FLAGS_DISCARD.  Which do you prefer?
> >
> > I think we should add it to BUFFER_FLAGS_DISCARD. It doesn't make sense to
> > keep it on a discarded buffer.
> >
> > > 2. jbd2: log_bufs is a mixed list.  Commit descriptors come from
> > > journal_end_buffer_io_sync(), which never sets BH_Write_EIO; revoke
> > > descriptors from write_dirty_buffer(), so bh_end_write().  I would convert
> > > fs/jbd2/commit.c:880 to the disjunct !buffer_uptodate(bh) ||
> > > buffer_write_io_error(bh).  The alternative is to add
> > > mark_buffer_write_io_error() to journal_end_buffer_io_sync() and convert
> > > all three jbd2 sites.  Which do you prefer?
> >
> > Please convert journal_end_buffer_io_sync() to use
> > mark_buffer_write_io_error() so that we completely get rid of this
> > antipattern.
> >
> > > 3. bh_end_async_write() has the same clear at fs/buffer.c:444.  I would
> > > remove both, which needs the gfs2 patch first since gfs2 reads that bit at
> > > fs/gfs2/log.c:110 and :324.  I can also leave the async half out.
> >
> > Please change gfs2 the same way as you are fixing jbd2. Keeping the mix of
> > uptodate & write_io_error checks only makes things more fragile...
> >
> > > 4. ocfs2: fs/ocfs2/journal.c:691 sits inside an outer
> > > if (!buffer_uptodate(bh)) at :675, so dropping the clear stops ocfs2 going
> > > read-only after a failed metadata checkpoint.  I would convert both sites
> > > and Cc ocfs2-devel.
> >
> > Yes, please.
> >
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
