Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4625370D57
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117087; cv=none; b=iN4gljB9ic16wStL8LpoNiycqyMEKlCl54jdIMkVw/DpVKq2EnVWpbZKvxZrJdSfgwEpjfnK0r/Wbgs+JJehzGgsxTdi+d5fYYwlPibzs4pHpEltECGJ/NjrceCUZ7CkeJeIggECcQDMsTbAg+Vv/JYfpQE8zAHopmU/Nl01A7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117087; c=relaxed/simple;
	bh=lXyC5ur/NJFKcEhr53Q98+jxnmcfAEcoab6BTwY4QUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOKrgNZ4DnxaTofilymt8IRHd3pdleZGLmRqgrbja6Hd+ElPgUYnvgGVQgecbhNmaIIM2oQbTdkL79xEcwIMomRoDhMae3uI+q5rK6jrav9maD1oYgNCZoC+q9E+NHKEjjvOpUwbpHVrf/bpga43rj6yQkzFls3fOt7kufPSsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fkCWkNj/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yHRMAZJq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1dLC2pI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8wQ9ie87; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fkCWkNj/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yHRMAZJq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1dLC2pI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8wQ9ie87"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 884A55D38B;
	Mon, 18 May 2026 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779117082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auiA2sl7vx+v+6pGthsFzgqHxlfGheBbt0t92r0XuFs=;
	b=fkCWkNj/x4DpT8FAMc1hwbKYNRAo/NLgltp4l8qiryT1vGkFWbt3UtKfcKkD1d4qZuH6OZ
	I1DlFKAc0oJpt704Nk3OMM1KcXVoT5dJTb1Its/nTzGaFFM9UJqhKx/ndZA4dfKJ0zJyMu
	YwaPlqUUwcUitRsnW1aXCfCxkq2gy3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779117082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auiA2sl7vx+v+6pGthsFzgqHxlfGheBbt0t92r0XuFs=;
	b=yHRMAZJqoCM7coIEGtgf08NQcofuJ7JJM9pvaq35xg4LMwlzaoTBDaziH1TuH33mHWuGL/
	FFm2m9HCbVnh2fAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L1dLC2pI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8wQ9ie87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779117081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auiA2sl7vx+v+6pGthsFzgqHxlfGheBbt0t92r0XuFs=;
	b=L1dLC2pI53nQ5uepcJsqmpfOTFCUK/E4rQZixuYbQ9NmJM8LjVAC4ak3Nkg8/t0+4FXuDt
	4M8FNySAtaK731Ha7pw7Si9fypwp1LkNewzT1DgAYnuhzjXlTJcQeVEnLPLF/0FnzaSU9x
	tRtM68eiM1hBLqz4MPm5WWkWYNm/zCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779117081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auiA2sl7vx+v+6pGthsFzgqHxlfGheBbt0t92r0XuFs=;
	b=8wQ9ie87qCC7sRE9oRxQefnFYa417hrhSD6mDt9S6zEyz7yirzxrPlTNrFmLS+hZQP8u/n
	mLYy4gvuGQnClwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FD81593A8;
	Mon, 18 May 2026 15:11:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dpIwHxksC2qINAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 May 2026 15:11:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97551A0A90; Mon, 18 May 2026 17:11:20 +0200 (CEST)
Date: Mon, 18 May 2026 17:11:20 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] writeback: drop now-unnecessary rcu_barrier() in
 cgroup_writeback_umount()
Message-ID: <ys7qk6kxigenulaexqutppupyx4c6uqrtivjegfa2qnvhyia5u@p52cfwvustrc>
References: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
 <20260517142147.3354909-3-libaokun@linux.alibaba.com>
 <q75moaoyuys22umiai3h6jnrowes37rrif2ap6v44j7vgd7qgw@lx4esnq6stjg>
 <306ba367-0e84-465f-8449-d88c45eb68b7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <306ba367-0e84-465f-8449-d88c45eb68b7@linux.alibaba.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,alibaba.com:email]
X-Rspamd-Queue-Id: 884A55D38B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 18-05-26 21:10:20, Baokun Li wrote:
> 在 2026/5/18 21:01, Jan Kara 写道:
> > On Sun 17-05-26 22:21:31, Baokun Li wrote:
> >> Commit e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
> >> switching inodes") replaced the queue_rcu_work() based scheduling of
> >> inode wb switches with a plain queue_work().  Since then no switcher
> >> goes through call_rcu(), so rcu_barrier() in cgroup_writeback_umount()
> >> has no work to wait for and is effectively a no-op.
> >>
> >> Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
> >> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> > Looks good. Just I think this should be folded in patch 1, since you have
> > proper Fixes tag, I don't think there's a concern this would be backported
> > to kernels where rcu_barrier() is still needed.
> >
> > 								Honza
> 
> Thank you for your review!
> 
> Because the two patches have different fix tags, there is concern that
> removing rcu_barrier here could cause the stable branches still using
> queue_rcu_work (5.10.y, 6.6.y, ...) to reintroduce similar issues when
> the round of fix patches deletes this necessary synchronization.
> 
> Therefore, the patches are split into two to make their purposes clearer.

Ah, ok, I didn't notice that the first patch has so old fixes tag. OK. Feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> >> ---
> >>  fs/fs-writeback.c | 5 -----
> >>  1 file changed, 5 deletions(-)
> >>
> >> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> >> index 1f95ddcee363..9ae290547eb2 100644
> >> --- a/fs/fs-writeback.c
> >> +++ b/fs/fs-writeback.c
> >> @@ -1246,11 +1246,6 @@ void cgroup_writeback_umount(struct super_block *sb)
> >>  		 * will then drain it.
> >>  		 */
> >>  		synchronize_rcu();
> >> -		/*
> >> -		 * Use rcu_barrier() to wait for all pending callbacks to
> >> -		 * ensure that all in-flight wb switches are in the workqueue.
> >> -		 */
> >> -		rcu_barrier();
> >>  		flush_workqueue(isw_wq);
> >>  	}
> >>  }
> >> -- 
> >> 2.43.7
> >>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
