Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322062;
	b=X3z9XaFvtc+y8l0in0qEi4oCB64skGqX9Qe77qblMXdy6TN8w5Et+hdSSZ2+/bOnjo55
	 BOUoMEoz9ULxgVClTFgpc441AYGpQ2JPtpnspaD5pmed6+Mr9WBnWMK+cjcZoFjbPf4LO
	 huXrdhSHfwMnvLPE+gsXCt72ES1ty4kG9uh5EVpISAhcNR0l2kLuYOCNWWXAI66UGtK/Z
	 x0N/R1Dv7pD6P/A3Fa3vmadgEOzdwWfUpD3jfvdFMlbWpPX1IAXKb9Am7xAK3BFLhyYU0
	 HgEjYpxY3b8BnmAuNqT12T/Bd9HXeAMND2mMD2ndxi6SxE6sGmgMnEgX3/c2FxDq/bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322062;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=c6aeEJtxAqyQgEFeDwf7Lm2f5Q9ThHSvxWzcKmuaieo=;
	b=n3fo+T1E0uUTrrGhpZPMhR8ZmeVkntevp2Li04+uug51fuV5PuIx97n/b/EwkIkXKkAx
	 arR08UYbSODE4S6SIQlXbefvkqLzBZrqGciaUEY80GGkWqukU/rq7tZh4eZ2RlMsSyNsi
	 POREGTerICL6X23mlqb9dZZCPpWBcBGHHGifaUm1XNjivSkL+foUp2/xIpFfcSpJIljBT
	 RqhtYTF/NWP3uWmSY5mQgY1vRlR0HggxbWY0XaS5To1Dtkhia59bQjRxV3xYfkqu0vruN
	 d8Z4nVEJvtSu5TtcW/bqg15J27qZ2wBz/8g8Lsvnli3NTJk+5goGwuPGmYkeGZBx+1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="jPv/J9zO";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nXDjaYp1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="jPv/J9zO";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nXDjaYp1;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AD60A2612
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 000AD60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=jPv/J9zO;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nXDjaYp1;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=jPv/J9zO;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nXDjaYp1
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BD2921F09;
	Tue, 10 Nov 2026 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794322060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6aeEJtxAqyQgEFeDwf7Lm2f5Q9ThHSvxWzcKmuaieo=;
	b=jPv/J9zOazjRnbjGqGAEtJ3O4FxOoaSBc7/49CizUnSuk/uHa+eTjL5sxjZU9rwmqPma6y
	DYlXPEwMDPABt1bQu/Qcl1zpefU6NyyYuHYc3AbdjMqJgRdDFtpI9JZvKLuCnXoU20rjTj
	O/6aXfy2d+ltLmvMX2paV847tvOrdOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794322060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6aeEJtxAqyQgEFeDwf7Lm2f5Q9ThHSvxWzcKmuaieo=;
	b=nXDjaYp1+Vre0D1Vx2L3I6QoELYukN3gxsVeU6jWpC3vqvfz9ZzbE2wPMd/x34uyr6Ckn7
	kL3gwO1BSNUC22DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="jPv/J9zO";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nXDjaYp1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794322060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6aeEJtxAqyQgEFeDwf7Lm2f5Q9ThHSvxWzcKmuaieo=;
	b=jPv/J9zOazjRnbjGqGAEtJ3O4FxOoaSBc7/49CizUnSuk/uHa+eTjL5sxjZU9rwmqPma6y
	DYlXPEwMDPABt1bQu/Qcl1zpefU6NyyYuHYc3AbdjMqJgRdDFtpI9JZvKLuCnXoU20rjTj
	O/6aXfy2d+ltLmvMX2paV847tvOrdOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794322060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6aeEJtxAqyQgEFeDwf7Lm2f5Q9ThHSvxWzcKmuaieo=;
	b=nXDjaYp1+Vre0D1Vx2L3I6QoELYukN3gxsVeU6jWpC3vqvfz9ZzbE2wPMd/x34uyr6Ckn7
	kL3gwO1BSNUC22DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCC101339F;
	Tue, 10 Nov 2026 14:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jkvxK4su82omOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Nov 2026 14:47:39 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 386EC22552; Tue, 10 Nov 2026 15:47:39 +0100 (CET)
Date: Tue, 10 Nov 2026 15:47:39 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Hongyu Jin <hongyu.jin.cn@gmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] writeback: Avoid postponing periodic data writeback
 indefinitely
Message-ID: <eyag6z2asfxp3tdsfffkjlljacpfuwcruh47e3pek5osc6p3y6@b3klggyow7e7>
References: <azdwnedsaesxdsp6vxjxgzg6ynrszveibmqkpznn3yuqyttlcj@5lz4p2aw5hxk>
 <20261029015217.840177-1-hongyu.jin@unisoc.com>
 <CAMQnb4MVyDMnS039hE1A=2jp6y2WF1zQFw1DfDzeEYsT0tKk3g@mail.gmail.com>
 <20261110-replizieren-drehmoment-sukzessiv-800c7a61bfdf@brauner>
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
In-Reply-To: <20261110-replizieren-drehmoment-sukzessiv-800c7a61bfdf@brauner>
X-Rspamd-Queue-Id: 1BD2921F09
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.51

On Tue 10-11-26 15:08:26, Christian Brauner wrote:
> On Fri, Nov 06, 2026 at 01:50:49PM +0800, Hongyu Jin wrote:
> > Hongyu Jin <hongyu.jin.cn@gmail.com> 于2026年10月29日周四 09:52写道：
> > >
> > > From: Jan Kara <jack@suse.cz>
> > >
> > > f2fs periodically calls sync_inode_metadata() for some inodes. The logic
> > > in writeback_single_inode() thus periodically calls to redirty_tail() and
> > > the inode's dirtied_when timestamp never gets old enough for the inode
> > > to be eligible for periodic data writeback. Thus dirty data from it is
> > > only ever written on explicit request (fsync(2), sync(2), unmount) or
> > > on dirty limit pressure.
> > >
> > > The redirty_tail() logic in writeback_single_inode() actually should not
> > > be necessary. Since this function is used only for once-off writeback,
> > > there's no need for any livelock protection among inodes and
> > > writeback_single_inode() is only responsible for demoting inode to "less
> > > dirty" list based on dirty bits cleared as a result of writeback. So
> > > remove the redirty_tail() logic and add a comment explaining the rules.
> > >
> > > The redirty_tail() did hide a race though, the one fixed by
> > > commit 846a3351ddfe ("writeback: Avoid skipping inode writeback").
> > > __writeback_single_inode() sets I_DIRTY_PAGES again when the mapping
> > > is still tagged dirty. If the inode had no I_DIRTY bits (e.g.
> > > write_inode_now(inode, 0) or sync_inode_metadata(inode, 0) of an inode
> > > with only I_DIRTY_TIME), the dirty pages come from a racing writer,
> > > whose __mark_inode_dirty() then finds I_DIRTY_PAGES set and does not
> > > queue the inode, leaving it on b_dirty_time or b_attached. Call
> > > __mark_inode_dirty() in that case instead, so that the inode gets queued
> > > on b_dirty.
> > >
> > > Fixes: 846a3351ddfe ("writeback: Avoid skipping inode writeback")
> > > Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
> > > Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@unisoc.com
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > [hongyu.jin: let __mark_inode_dirty() queue an inode whose pages were
> > >  dirtied while it had no I_DIRTY bits, update comments]
> > > Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> Jan, you're good with this fix?

Sorry no. It still looks too hacky to me but so far my attempts at coming
up with something saner were not successful. :-| I'll look more into it
today or tomorrow at latest.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
