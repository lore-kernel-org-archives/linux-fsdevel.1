Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103427;
	b=rJ3yz9GIKKH9tUohUhjuANY49xtqjIvmPe92sRBh2scOiEIsHRN2FfTmaPsSeTugphWr
	 sBzE1zmfcTJj5FrxrlKf+PqkdwiGpywq0CPgwVG0kNPhQ17WB7r5nN+XgvRHcXnb1lcMi
	 +6OJqdMMNGiifN/T43P/c136dcSf6JR3rrDdHj2s7itDbxBQspop1IbKrqNVq1VqGdbXr
	 naisxgScRp4RsSik1C3EEvVziWREIZ6vBJGMPF6ce4XqdbN2CLcFwQVkw7pMTYdWvn3t/
	 GttWjSzHOh05sjF3FgCIaoQwAma75plUFZIa2cP7spGHwMMVKiqIG/oQ90PyNbuipjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103427;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=ReN48i1SNlLBf21oU/g/CRJer6hG5t+6hcULyWpfAhw=;
	b=NZz5DeW9O5x0Plmp0mquVKl8KaoMOPDJyI8r0jq35k5L3n5+1g/jR8v+NNvknqXq8rU4
	 4AimB374Tj7wJl5jpebZbP9gInkAGjKE9+5RGcjTt4k1NH3SsG0vOw0BzE7/DBJ3bFwX4
	 SAE3z2pCdyCIKmjeVd6ZFjrLGU4e0BxfIyHXUv0dznJBco8XPCoKZXk3DrWvLMSWGzjsN
	 Q/DNehxUy0mHXgTsIihP44Sp8JlmVz3Iez6ZweZC3qmfGWsk/QVeyRYk8Cb+SrftGfpUb
	 RgU3aYQkrm/osg1J4INqvsyN5RZF2kdVkZx8om+SrbYveNQljhZypJF+Zxpx8dTtZYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BEgjij9I;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6SBub+81;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=18OSf6FQ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3KV9l7ap;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7076606A31F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 12:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7076606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BEgjij9I;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6SBub+81;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=18OSf6FQ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3KV9l7ap
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A7261F74D;
	Tue, 27 Oct 2026 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793103425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReN48i1SNlLBf21oU/g/CRJer6hG5t+6hcULyWpfAhw=;
	b=BEgjij9I18YoRfQ6lA3+kL0VcTonnAUHwE/gZcduKdWU76Oh/JIDVHuBj6srtd1aixfT4i
	jBw8zKDmVU1notbzdq/9BKJn7IwTPQ0txF0K0OI/DeTWleB2HpI6JOxX7MjOJvTNxS+o/t
	zWSJuFqxNncSLmERVlgQSqryk5NTmBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793103425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReN48i1SNlLBf21oU/g/CRJer6hG5t+6hcULyWpfAhw=;
	b=6SBub+81H29NvYYiWBXWNoiNJZqsUnyZPk2JE6we1MN4j1JSSWMSE84y2Wn4RW+nIkwfF8
	jSM83FuOU6dzVQBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=18OSf6FQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3KV9l7ap
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793103423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReN48i1SNlLBf21oU/g/CRJer6hG5t+6hcULyWpfAhw=;
	b=18OSf6FQZbQgl80MfoBlIoxxHpDLiB67tOGF4bnO6oML9Ok1jt/NhDupNtAH7quqIhkj7+
	2XJ0wWQdOeb9a3MnFJF/qBbr4fy3EZBfGclIjPBpDadG8JrIYVXSChrN9qDJWc0WkJnbyO
	ofT9fAwrc8WI2AagQ2hcLTX4uT1qiGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793103423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReN48i1SNlLBf21oU/g/CRJer6hG5t+6hcULyWpfAhw=;
	b=3KV9l7apBsXWxIF8pURHl0YH2vVwD5Lh6x5k+wedUukcEe3XIQh7id01PIW0yHOA5oK5Y9
	C7DCKM8NAbDLr8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FD8D1321C;
	Tue, 27 Oct 2026 12:17:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FP/jEj+W4GpZfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 Oct 2026 12:17:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E9C58A133E; Tue, 27 Oct 2026 13:16:58 +0100 (CET)
Date: Tue, 27 Oct 2026 13:16:58 +0100
From: Jan Kara <jack@suse.cz>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] writeback: Avoid postponing periodic data writeback
 indefinitely
Message-ID: <azdwnedsaesxdsp6vxjxgzg6ynrszveibmqkpznn3yuqyttlcj@5lz4p2aw5hxk>
References: <20261026211010.3733399-2-jack@suse.cz>
 <CAMQnb4Nmynro93B1-xnM4pGoDk45-GEviHqDPXDf65GJaDn3pw@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMQnb4Nmynro93B1-xnM4pGoDk45-GEviHqDPXDf65GJaDn3pw@mail.gmail.com>
X-Rspamd-Queue-Id: 9A7261F74D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -11.51

On Tue 27-10-26 14:08:09, Hongyu Jin wrote:
> Commit 846 a3351ddfe4a86eede4bb26a205c3f38ef84d3 problem need to be considered:
> 
> We have run into an issue that a task gets stuck in
> balance_dirty_pages_ratelimited() when perform I/O stress testing.
> The reason we observed is that an I_DIRTY_PAGES inode with lots
> of dirty pages is in b_dirty_time list and standard background
> writeback cannot writeback the inode.
> After studing the relevant code, the following scenario may lead
> to the issue:
> 
> task1                                   task2
> -----                                   -----
> fuse_flush
>  write_inode_now // in b_dirty_time
>   writeback_single_inode
>     __writeback_single_inode
>                                   fuse_write_end
>                                    filemap_dirty_folio
>                                     __xa_set_mark:PAGECACHE_TAG_DIRTY
>      lock inode->i_lock
>      if mapping tagged PAGECACHE_TAG_DIRTY
>      inode->i_state |= I_DIRTY_PAGES
>      unlock inode->i_lock
>                                     __mark_inode_dirty:I_DIRTY_PAGES
>                                        lock inode->i_lock
>                                        -was dirty, inode stays in b_dirty_time
>                                        unlock inode->i_lock
> 
>     if(!(inode->i_state & I_DIRTY_All))
>       -not true,so nothing done

Hum, right. Thanks for testing! Back to drawing board...

								Honza

> Jan Kara <jack@suse.cz> 于2026年10月27日周二 05:10写道：
> >
> > Hongyu Jin has reported that f2fs periodically calls
> > sync_inode_metadata() for some inodes. The logic in
> > writeback_single_inode() thus periodically calls to redirty_tail() and
> > the inode's dirtied_when timestamp never gets old enough for the inode
> > to be eligible for periodic data writeback. Thus dirty data from it is
> > only ever written on explicit request (fsync(2), sync(2), unmount) or
> > on dirty limit pressure.
> >
> > The redirty_tail() logic in writeback_single_inode() actually should not
> > be necessary. Since this function is used only for once-off writeback,
> > there's no need for any livelock protection among inodes and
> > writeback_single_inode() is only responsible for demoting inode to "less
> > dirty" list based on dirty bits cleared as a result of writeback. So
> > remove the redirty_tail() logic and add a comment explaining the rules.
> >
> > Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@unisoc.com
> > Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/fs-writeback.c | 35 ++++++++++++++++++++++-------------
> >  1 file changed, 22 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 58a6403780aa..de86c9055ffb 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1946,22 +1946,31 @@ static int writeback_single_inode(struct inode *inode,
> >          * as it can be finally deleted at this moment.
> >          */
> >         if (!(inode_state_read(inode) & I_FREEING)) {
> > +               enum inode_state_flags_enum istate = inode_state_read(inode);
> > +
> >                 /*
> > -                * If the inode is now fully clean, then it can be safely
> > -                * removed from its writeback list (if any). Otherwise the
> > -                * flusher threads are responsible for the writeback lists.
> > +                * __mark_inode_dirty() is responsible for promoting inode to
> > +                * the proper list (b_attached -> b_dirty_time -> b_dirty).
> > +                * Here we are responsible for demoting inode after some dirty
> > +                * bits were cleared.
> > +                *
> > +                * If the inode is now fully clean, then it can be safely moved
> > +                * to b_attached list. If the inode is dirty, we don't want to
> > +                * touch it - it should be already put to the dirty list by
> > +                * __mark_inode_dirty() and we'd just unnecessarily clobber the
> > +                * dirtied_when stamp (which is particularly problematic when
> > +                * we were called from sync_inode_metadata()). We also cannot
> > +                * touch the dirty list association when I_SYNC_QUEUED is set
> > +                * and flush worker is responsible for it. Otherwise move the
> > +                * inode to b_dirty_time list as that's the only remaining
> > +                * possibility.
> >                  */
> > -               if (!(inode_state_read(inode) & I_DIRTY_ALL))
> > +               if (!(istate & I_DIRTY_ALL))
> >                         inode_cgwb_move_to_attached(inode, wb);
> > -               else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
> > -                       if ((inode_state_read(inode) & I_DIRTY))
> > -                               redirty_tail_locked(inode, wb);
> > -                       else if (inode_state_read(inode) & I_DIRTY_TIME) {
> > -                               inode->dirtied_when = jiffies;
> > -                               inode_io_list_move_locked(inode,
> > -                                                         wb,
> > -                                                         &wb->b_dirty_time);
> > -                       }
> > +               else if (!(istate & I_SYNC_QUEUED) && !(istate & I_DIRTY)) {
> > +                       WARN_ON_ONCE(!(istate & I_DIRTY_TIME));
> > +                       inode->dirtied_when = jiffies;
> > +                       inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
> >                 }
> >         }
> >
> > --
> > 2.51.0
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
