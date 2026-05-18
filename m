Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFF47B405
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109096; cv=none; b=na2S/UeRpzHehJ0CJHSjabj4BOeW7J9hSEVyC0/gXz/foH/UQMfPiKIpbNUF1FZoquYVMlN5P4d/GdK4MYcuFCU7tP4aOtz+r1VY737QrYSRcr3fBATFWXDyXIx+wEwnPN7HVs4DwE0OGH/0+6rguSc4mTCTrRg67J11VXVHU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109096; c=relaxed/simple;
	bh=orKYFWVi3CXRhUgcnDXvRsMCgTiH9ywN4peUu1KYl/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adkq2uBPUaMOtQXd2pFnWh1c64kK2yf2COZCywTVt9qOPPm1+xNzUV2HmgTL+F2/gx4+M8KIZn/ZjoCJshobMGv72qlOm8chVwwkgMkMdtah8PGfHDP+iR2huwaucweJVY6ve+ai6b+oz9bXJLg4b9o/gV/AscMlmz/KACWPKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MRau2ObS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WmoktVxG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RhnR1gcV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YlG+xf1P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MRau2ObS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WmoktVxG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RhnR1gcV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YlG+xf1P"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EAF1963F37;
	Mon, 18 May 2026 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779109091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Atww93U6D5JdAxqjmbMVqPIzy82s2PKfQeI28FbNwKQ=;
	b=MRau2ObSMw1hTohSzHu8mTcWXhw04s4DCVJD1e8f9YAbwnj6qbou1rSmrLjt+gjhmdtkRx
	G0TlEhuN+Qf0SlFaxLKyUXIzNPiHKLFm1zdx0+ErNmPNH8Z1tNztaEy3NoOUIJyGVbrfoF
	1N+z9wA6+qLPueltskY5XvkexBfQcpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779109091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Atww93U6D5JdAxqjmbMVqPIzy82s2PKfQeI28FbNwKQ=;
	b=WmoktVxGbcpV9Gx96QWSuNPOYIZVCpaPP4APqGxl5YoZtMMbKKTgXCPyrQX/KU/gajfKaU
	OAO8isF4JJ1CDTBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779109090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Atww93U6D5JdAxqjmbMVqPIzy82s2PKfQeI28FbNwKQ=;
	b=RhnR1gcVlC+ky0xyIH48CydNWaqEvSIQiwWE/X9SIaW//pREzHHSU/rfVxByWPKvweIOgm
	GFfAmsHoyPeinm5+5mXfp5kXK+Tz+m9RHP2H72vP4iUJk1Lhu9dWfSOlLh33SA4XPyZkAY
	4XSe37k9Yg4lOaRNuTVJinpFc8292fQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779109090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Atww93U6D5JdAxqjmbMVqPIzy82s2PKfQeI28FbNwKQ=;
	b=YlG+xf1P6Tg8N4z5qxtTE66Wk8rSYaN8Sw487YzgmachxP7vg7ifEK7h/FzDve1cxveaMx
	jsyZOKkNpPE0gcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E09EB593A8;
	Mon, 18 May 2026 12:58:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lyfSNuIMC2olMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 May 2026 12:58:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9B50A0A90; Mon, 18 May 2026 14:58:01 +0200 (CEST)
Date: Mon, 18 May 2026 14:58:01 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] writeback: fix race between
 cgroup_writeback_umount() and inode_switch_wbs()
Message-ID: <a4e6xpdpwer2ci3vaddhlr57ci4b2i3fdlxqqxwklcy2fmvxmf@ht3erpxusegd>
References: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
 <20260517142147.3354909-2-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517142147.3354909-2-libaokun@linux.alibaba.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,alibaba.com:email,suse.com:email]
X-Spam-Level: 

On Sun 17-05-26 22:21:30, Baokun Li wrote:
> When a container exits, the following BUG_ON() is occasionally triggered:
> 
> ==================================================================
>  VFS: Busy inodes after unmount of sdb (ext4)
>  ------------[ cut here ]------------
>  kernel BUG at fs/super.c:695!
>  CPU: 3 PID: 6 Comm: containerd-shim Tainted: G OE K 6.6 #1
>  pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>  pc : generic_shutdown_super+0xf0/0x100
>  lr : generic_shutdown_super+0xf0/0x100
>  Call trace:
>   generic_shutdown_super+0xf0/0x100
>   kill_block_super+0x20/0x48
>   ext4_kill_sb+0x28/0x60
>   deactivate_locked_super+0x54/0x130
>   deactivate_super+0x84/0xa0
>   cleanup_mnt+0xa4/0x140
>   __cleanup_mnt+0x18/0x28
>   task_work_run+0x78/0xe0
>   do_notify_resume+0x204/0x240
> ==================================================================
> 
> The root cause is a race between cgroup_writeback_umount() and
> inode_switch_wbs()/cleanup_offline_cgwb(). There is a window between
> inode_prepare_wbs_switch() returning true and the subsequent
> wb_queue_isw() call. Following is the process that triggers the issue:
> 
>       CPU A (umount)           |          CPU B (writeback)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                                  inode_switch_wbs/cleanup_offline_cgwb
>                                   atomic_inc(&isw_nr_in_flight)
>                                   inode_prepare_wbs_switch
>                                    -> passes SB_ACTIVE check
>                                    __iget(inode)
>  generic_shutdown_super
>   sb->s_flags &= ~SB_ACTIVE
>   cgroup_writeback_umount(sb)
>    smp_mb()
>    atomic_read(&isw_nr_in_flight)
>    rcu_barrier()
>     -> no pending RCU callbacks
>    flush_workqueue(isw_wq)
>     -> nothing queued, returns
>   evict_inodes(sb)
>    -> Inode skipped as isw still holds a ref.
>   sop->put_super(sb)
>    /* destroys percpu counters */
>   -> VFS: Busy inodes after unmount!
>                                   wb_queue_isw()
>                                    queue_work(isw_wq, ...)
>                                   /* later in work function */
>                                   inode_switch_wbs_work_fn
>                                    process_inode_switch_wbs
>                                     iput() -> evict
>                                      percpu_counter_dec() // UAF!
> 
> Fix this by extending the RCU read-side critical section in
> inode_switch_wbs() and cleanup_offline_cgwb() to cover from
> inode_prepare_wbs_switch() through wb_queue_isw().  Since there is
> no sleep in this window, rcu_read_lock() can be used.  Then add a
> synchronize_rcu() in cgroup_writeback_umount() before the existing
> rcu_barrier(), so that all in-flight switchers that have passed the
> SB_ACTIVE check have completed queue_work() before flush_workqueue()
> is called.
> 
> Fixes: a1a0e23e4903 ("writeback: flush inode cgroup wb switches instead of pinning super_block")
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/all/mxnjq2l6guusfchvauxr3v7c4bwjasybxlleqbbh4efloeqspz@iqylk76ohufz
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

Looks good! Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a65694cbfe68..1f95ddcee363 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -665,7 +665,6 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
>  	if (memcg_css && !css_tryget(memcg_css))
>  		memcg_css = NULL;
> -	rcu_read_unlock();
>  	if (!memcg_css)
>  		goto out_free;
>  
> @@ -680,10 +679,18 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	isw->inodes[0] = inode;
>  
>  	trace_inode_switch_wbs_queue(inode->i_wb, new_wb, 1);
> +	/*
> +	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
> +	 * Holding rcu_read_lock across wb_queue_isw() ensures
> +	 * synchronize_rcu() cannot return until the work is queued, so
> +	 * the subsequent flush_workqueue() will wait for the switch.
> +	 */
>  	wb_queue_isw(new_wb, isw);
> +	rcu_read_unlock();
>  	return;
>  
>  out_free:
> +	rcu_read_unlock();
>  	atomic_dec(&isw_nr_in_flight);
>  	if (new_wb)
>  		wb_put(new_wb);
> @@ -741,6 +748,14 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  		new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
>  
>  	nr = 0;
> +	/*
> +	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
> +	 * Holding rcu_read_lock across the SB_ACTIVE check, the inode grab
> +	 * and wb_queue_isw() ensures synchronize_rcu() cannot return until
> +	 * the work is queued, so the subsequent flush_workqueue() will wait
> +	 * for the switch.
> +	 */
> +	rcu_read_lock();
>  	spin_lock(&wb->list_lock);
>  	/*
>  	 * In addition to the inodes that have completed writeback, also switch
> @@ -758,6 +773,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  
>  	/* no attached inodes? bail out */
>  	if (nr == 0) {
> +		rcu_read_unlock();
>  		atomic_dec(&isw_nr_in_flight);
>  		wb_put(new_wb);
>  		kfree(isw);
> @@ -766,6 +782,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  
>  	trace_inode_switch_wbs_queue(wb, new_wb, nr);
>  	wb_queue_isw(new_wb, isw);
> +	rcu_read_unlock();
>  
>  	return restart;
>  }
> @@ -1221,6 +1238,14 @@ void cgroup_writeback_umount(struct super_block *sb)
>  	smp_mb();
>  
>  	if (atomic_read(&isw_nr_in_flight)) {
> +		/*
> +		 * Paired with rcu_read_lock() in inode_switch_wbs() and
> +		 * cleanup_offline_cgwb().  synchronize_rcu() waits for any
> +		 * in-flight switcher that already passed the SB_ACTIVE check
> +		 * to finish queueing its work, so flush_workqueue() below
> +		 * will then drain it.
> +		 */
> +		synchronize_rcu();
>  		/*
>  		 * Use rcu_barrier() to wait for all pending callbacks to
>  		 * ensure that all in-flight wb switches are in the workqueue.
> -- 
> 2.43.7
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
