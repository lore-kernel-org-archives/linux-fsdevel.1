Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60C43C7B4;
	Fri, 11 Sep 2026 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124933; cv=none; b=dOqqZNv1cLY1FbEWV3Gys/2o8pq9cqdCq88JNPRLZBUPGlb8lHVtLrDH1lCAIrI+w+WnbEm9mk3jmKvnrhZgfMHWM7suZtqLJSxSPzo3y9jWirQ360+kJDgxiKbAph9xu4u7pEO7daOS+VpceLeBO8O3lnTFI3+PcsTbxqOaxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124933; c=relaxed/simple;
	bh=PZiWfJM51jSQ8Kih4WHyyAkPaJvMkpe+Rc7YfS/Yqqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyc8xcQVWMenaj8yPqOD5b59jK5ay3UV4pTomDe9eXAZVsSp1FiBCmnHqiQuJWfMDcarCPFEn7okKwuAdZKYzGLIj/2T9dGwZRoLNHt7u3G39a2pVquxdKedYf80t0Ti9UOHxGh470XSOMHgKwisQlio6bZZMLd/A3ekD0rl7Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jbew0h3X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b33VcsHH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GEmwGDrx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TsO+UcaX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jbew0h3X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b33VcsHH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GEmwGDrx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TsO+UcaX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52B8A21C40;
	Fri, 11 Sep 2026 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789124925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOp0ESLVbdASBuzD4NROGywGEjSmfGoDax+3LVJYeyU=;
	b=jbew0h3X06exX0QjPVdN5rg/YGYXphtyDgAIUYU7VVTU3ESogv+o04cwPk9M8r1zcW7SWz
	kGwTAMv1v3EZl7P1P3X0RUe0HJGwETuLtBGC54VXuHyoWrC3WhN/6qDEuiwpDz1FxDTkIH
	YtywAWIhMoKQGOqsDH8rPknDIqveah0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789124925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOp0ESLVbdASBuzD4NROGywGEjSmfGoDax+3LVJYeyU=;
	b=b33VcsHHHsSWGDUMU9VGQiGTt/eA54BKTiJ1qRXIexIFFmf/hvOJcj0MY+gTNra8Z8kDrM
	TkkZDHj5DpoMsBDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789124921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOp0ESLVbdASBuzD4NROGywGEjSmfGoDax+3LVJYeyU=;
	b=GEmwGDrxSrMEKK58ASQOZCRAZcxh9lEegaf75sl15qR8QS2ZKz9LR9uQ6RY3zOm2aqhc1T
	CxNBCno83ZuXvebVLCv4TLjfOCJ8IUf7nDGhIb+ni2Xztl/ZRepRValKwqQdPyvmnAKNS6
	FL8bwLx+m2p09irTWBmBU0TrOOnVy2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789124921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOp0ESLVbdASBuzD4NROGywGEjSmfGoDax+3LVJYeyU=;
	b=TsO+UcaXyaP0FJjEYk40XNabe4kP6R692TRJDNbWCATznIWOJJMBIQFFZfdoCIWKl1rppO
	qV2K0hw4CSorZyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23502132D3;
	Fri, 11 Sep 2026 11:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CmqTCDnho2pjKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 11:08:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9D599A1342; Fri, 11 Sep 2026 13:08:36 +0200 (CEST)
Date: Fri, 11 Sep 2026 13:08:36 +0200
From: Jan Kara <jack@suse.cz>
To: =?utf-8?B?5bC55qyj?= <yinxin.x@bytedance.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] writeback: snapshot foreign flush pages
Message-ID: <22ia4tpnbik23zb4lgkb7rn4v3rbaeburhtxg5ymdwv6dnfar7@iustvvybmr3i>
References: <cover.1788836830.git.yinxin.x@bytedance.com>
 <dce170b76e9501d555b0af70cc8c45c248577400.1788836830.git.yinxin.x@bytedance.com>
 <matvd3klv4w7buhnjkdpllkautw3zu2e5hpjfdedvvoozpbfxj@z7joalz5an74>
 <b0a5d388d0b2cb320744535d7f9d8f59e469aa88.aa79b65b.6b2f.41be.bcbf.08bf9deeb395@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0a5d388d0b2cb320744535d7f9d8f59e469aa88.aa79b65b.6b2f.41be.bcbf.08bf9deeb395@bytedance.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email,kernel.dk:email,bytedance.com:email,linux.org.uk:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Wed 09-09-26 10:08:08, 尹欣 wrote:
> > From: "Jan Kara"<jack@suse.cz>
> > Date:  Tue, Sep 8, 2026, 19:01
> > Subject:  Re: [PATCH v1 2/2] writeback: snapshot foreign flush pages
> > To: "Xin Yin"<yinxin.x@bytedance.com>
> > Cc: "Alexander Viro"<viro@zeniv.linux.org.uk>, "Christian Brauner"<brauner@kernel.org>, "Jan Kara"<jack@suse.cz>, "Tejun Heo"<tj@kernel.org>, "Jens Axboe"<axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
> > On Tue 08-09-26 11:23:52, Xin Yin wrote:
> > > WB_REASON_FOREIGN_FLUSH is best-effort writeback for foreign dirtying. It
> > > should write pages that are already visible to the target wb, but should
> > > not keep extending the same work with pages dirtied while the work is
> > > running.
> > > 
> > > Make foreign flushes use tagged writeback while preserving WB_SYNC_NONE
> > > semantics. Use the remaining work budget as the per-inode chunk, so a
> > > tagged pass is not truncated to the normal periodic chunk and a large
> > > inode still cannot exceed the finite work budget.
> > > 
> > > Queue b_dirty only once for each foreign-flush work. Later passes only
> > > retry b_more_io inodes skipped due to I_SYNC, and the work exits once
> > > b_io and b_more_io are drained. If the budget is consumed, redirty the
> > > inode instead of requeueing it to b_more_io so the same work cannot loop
> > > on a continuously dirtied inode.
> > > 
> > > Do not refresh dirtied_when for foreign flushes; later dirtying should be
> > > handled by later foreign, kupdate, or background writeback.
> > > 
> > > Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> > > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > 
> > I really dislike how your implementation ties the two writeback deadlock
> > avoidance schemes (nr_to_write for WB_SYNC_NONE writeback vs folio tagging
> > + inode dirty timestamp for WB_SYNC_ALL writeback) together. But before we
> > get to the implementation details let's discuss the purpose a bit:
> > 
> > In principle I agree with you that the primary purpose of
> > cgroup_writeback_by_id() is that it wants to flush inodes that have folios
> > that are accounted to our memcg. It does this by a rather rough approach of
> > flushing the whole wb. If this races with other dirtying, it might happen
> > that we won't actually flush the foreign folios we want. Am I getting your
> > concern right? Are you able to actually observe such situation in practice?
> 
> Yes, that's the concern. Concurrent dirtying could consume the work's
> budget without sufficiently flushing the foreign folios charged to the
> memcg we're trying to help.
> 
> We haven't confirmed that specific situation in production. What we've
> observed is long-running foreign work with many subsequent works queued
> behind it. We haven't traced the original source memcg's folios closely
> enough to show that they were left dirty because newly dirtied pages
> consumed the budget. So that part is still a concern, not an observed
> failure.

OK. So I fully agree that foreign dirty tracking and flushing is very
rough. The basic premise of that infrastructure is that foreign dirtying
should be very rare and amount of foreign dirty pages very low and thus
largely irrelevant for the dirty throttling. The flushing is there mostly
as a last resort solution to have a chance of *some* kind of forward
progress in corner cases where the amount of foreign dirty pages is
substantial.

As Tejun wrote [1], bdev inodes are kind of breaking these assumptions.
Still number of dirty pages there should be low compared to data pages but
for some workloads that isn't necessarily the case.

[1] https://lore.kernel.org/all/aqGmmw3rv_2f5Jk4@slm.duckdns.org

> The idea behind combining the two approaches was to get the budget right
> for the target wb, while keeping the flush from chasing concurrent
> dirtying. The first is about not holding up later work on the same wb,
> including syncfs. There's also a fairness concern: an old inode can keep
> getting newly dirtied pages written while later-dirtied inodes have to
> wait for another work. The second is about making the flush more useful
> to the source memcg, although tagging alone doesn't guarantee that its
> folios get flushed.

If you look at the logic in writeback_sb_inodes(), it actually goes to
great lengths to avoid the fairness issues you describe above. We only
write a limited amount of pages from each inode (see
writeback_chunk_size()), then we switch to another one, cycling through all
inodes queued to b_io list in this way. Inodes on b_io list get fixed when
the writeback work starts (see queue_io()) so new inodes cannot appear
there. This is not bulletproof but it avoids the practical livelocking
cases. So generally I don't expect your systems have practical issues with
foreign flushes not really flushing what they should.

> I see your concern about mixing the two mechanisms, though. Would you
> suggest keeping the budget-only approach for now, or is there a simpler
> way to address the concurrent-dirtying concern?

As I wrote above, at this point I'm not convinced concurrent dirtying is
your practical problem. If you can show foreign flushes in your real
workloads often don't end up flushing what they should, then we can discuss
how to improve the writeback behavior (or foreign flush behavior) to avoid
that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
