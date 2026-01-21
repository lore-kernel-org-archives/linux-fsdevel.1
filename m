Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3222EC55D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001349; cv=none; b=qFbqfPWm15bZyQJ2GfSQdTBq7WZiRaedgL1rlKMpq4lZtIFWZidMUgEVEoEtjrUjdXOABxGf+rnGwAFXSKu4M+2FlLFYsGiohYfu0pS7KbmNBsboS1wqbdwHpAlPONft7YzpIbKe8Eigju60ystRS+k+CaOaXZW/dL6Nsje2Lx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001349; c=relaxed/simple;
	bh=NMVkB+ffngz1V2OdHc8vHpPQUptUP34Uq8kD0dI0qWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxLSnjICVTCUQrY/obIxjlv9zo6r6BKrDI38lB5Qh5COUwiDyBtFeivalupT2ISak8sCqzZofiw8L59o8F4SbGXYTlQkO1ucalG+eC7PEB0zpiLZc71pXdhi0wLcbZ0o8hDaTlIJIWLyZGrILEQs2jL54JREBedLCISoHPH/+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EPLRK+bH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2YJx1IJg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EPLRK+bH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2YJx1IJg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EPLRK+bH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2YJx1IJg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EPLRK+bH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2YJx1IJg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37A66336A6;
	Wed, 21 Jan 2026 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769001346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCeGpK6RtBo0/1oLVmxx/8VCIw3CcjubIHD2TZKzh+Q=;
	b=EPLRK+bHwzDIIH/wtraYycBNBs/lqKPjO0XKVFCDrzOszr7iV9wtc98Vnvff7Csr5KcgS7
	plTqetQ8HQajbDhc+6UfQR2ASQQrtJ5o/AutpkEtDvQE4I+c45rt/qniVTGK1zIzHhpMQW
	WoDgrP4kPbp8knyM538BHFN/gAanEPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769001346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCeGpK6RtBo0/1oLVmxx/8VCIw3CcjubIHD2TZKzh+Q=;
	b=2YJx1IJgdVWKPzlDSWaUlIw1DQE+GIigShDVu+uE/yrrtXEvPKLru0zP0Ay2coiy7Tlep3
	uylGdXMaqvbmv9Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769001346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCeGpK6RtBo0/1oLVmxx/8VCIw3CcjubIHD2TZKzh+Q=;
	b=EPLRK+bHwzDIIH/wtraYycBNBs/lqKPjO0XKVFCDrzOszr7iV9wtc98Vnvff7Csr5KcgS7
	plTqetQ8HQajbDhc+6UfQR2ASQQrtJ5o/AutpkEtDvQE4I+c45rt/qniVTGK1zIzHhpMQW
	WoDgrP4kPbp8knyM538BHFN/gAanEPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769001346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCeGpK6RtBo0/1oLVmxx/8VCIw3CcjubIHD2TZKzh+Q=;
	b=2YJx1IJgdVWKPzlDSWaUlIw1DQE+GIigShDVu+uE/yrrtXEvPKLru0zP0Ay2coiy7Tlep3
	uylGdXMaqvbmv9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EA153EA63;
	Wed, 21 Jan 2026 13:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jo5WC4LRcGk9IgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 13:15:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D17DFA09E9; Wed, 21 Jan 2026 14:15:45 +0100 (CET)
Date: Wed, 21 Jan 2026 14:15:45 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fsnotify: Use connector hash for destroying inode
 marks
Message-ID: <wr272ow6sudm77cukhsf6ognvqhm5mf4zvo7d6lrjx3dvpczub@7ktbxlg57c24>
References: <20260120131830.21836-1-jack@suse.cz>
 <20260120132313.30198-5-jack@suse.cz>
 <CAOQ4uxi-0kM2bYYU9XJ=bbn0TSaHuDVdZ3MvmicnPXarDjEC-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi-0kM2bYYU9XJ=bbn0TSaHuDVdZ3MvmicnPXarDjEC-Q@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO

On Tue 20-01-26 20:58:46, Amir Goldstein wrote:
> On Tue, Jan 20, 2026 at 2:23 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Instead of iterating all inodes belonging to a superblock to find inode
> > marks and remove them on umount, iterate all inode connectors for the
> > superblock. This may be substantially faster since there are generally
> > much less inodes with fsnotify marks than all inodes. It also removes
> > one use of sb->s_inodes list which we strive to ultimately remove.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/notify/fsnotify.c | 71 +++++++++++++-------------------------------
> >  1 file changed, 20 insertions(+), 51 deletions(-)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 706484fb3bf3..a0cf0a6ffe1d 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -34,62 +34,31 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
> >  }
> >
> >  /**
> > - * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
> > - * @sb: superblock being unmounted.
> > + * fsnotify_unmount_inodes - an sb is unmounting. Handle any watched inodes.
> > + * @sbinfo: fsnotify info for superblock being unmounted.
> >   *
> > - * Called during unmount with no locks held, so needs to be safe against
> > - * concurrent modifiers. We temporarily drop sb->s_inode_list_lock and CAN block.
> > + * Walk all inode connectors for the superblock and free all associated marks.
> >   */
> > -static void fsnotify_unmount_inodes(struct super_block *sb)
> > +static void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
> >  {
> > -       struct inode *inode, *iput_inode = NULL;
> > -
> > -       spin_lock(&sb->s_inode_list_lock);
> > -       list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> > -               /*
> > -                * We cannot __iget() an inode in state I_FREEING,
> > -                * I_WILL_FREE, or I_NEW which is fine because by that point
> > -                * the inode cannot have any associated watches.
> > -                */
> > -               spin_lock(&inode->i_lock);
> > -               if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
> > -                       spin_unlock(&inode->i_lock);
> > -                       continue;
> > -               }
> > -
> > -               /*
> > -                * If i_count is zero, the inode cannot have any watches and
> > -                * doing an __iget/iput with SB_ACTIVE clear would actually
> > -                * evict all inodes with zero i_count from icache which is
> > -                * unnecessarily violent and may in fact be illegal to do.
> > -                * However, we should have been called /after/ evict_inodes
> > -                * removed all zero refcount inodes, in any case.  Test to
> > -                * be sure.
> > -                */
> > -               if (!icount_read(inode)) {
> > -                       spin_unlock(&inode->i_lock);
> > -                       continue;
> > -               }
> > -
> > -               __iget(inode);
> > -               spin_unlock(&inode->i_lock);
> > -               spin_unlock(&sb->s_inode_list_lock);
> > -
> > -               iput(iput_inode);
> > -
> > -               /* for each watch, send FS_UNMOUNT and then remove it */
> > +       struct fsnotify_mark_connector *conn;
> > +       struct inode *inode;
> > +
> > +       spin_lock(&sbinfo->list_lock);
> > +       while (!list_empty(&sbinfo->inode_conn_list)) {
> > +               conn = fsnotify_inode_connector_from_list(
> > +                                               sbinfo->inode_conn_list.next);
> > +               /* All connectors on the list are still attached to an inode */
> > +               inode = conn->obj;
> > +               ihold(inode);
> 
> Is this safe also without FSNOTIFY_CONN_FLAG_HAS_IREF?
> These refs rules now got my brain in a knot..
> Maybe it's worth having this explained in a comment.

Erm, that's a very good question. No, it is not safe. Because connectors
without FSNOTIFY_CONN_FLAG_HAS_IREF (i.e., only evictable marks attached)
can be happily running through evict() when this gets called and so
ihold() will rightfully complain. So we indeed do need a more careful dance
here. Sigh... I'll figure it out and send v3. Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
