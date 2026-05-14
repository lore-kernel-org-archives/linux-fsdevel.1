Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28130F958
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764189; cv=none; b=anvVd8HYSG7O/iiDEq99FbDc7a8KF+stTOVa8t/ouIfqaOWQFwOs3oOiKXEBKSLnDZ+xD2PoG8aPZsCY72acw5vgWyp1XOuch+ssNflSmb8h6v5Ei7RinW1Tftz3C9Hy3y+xhL+zBuRq3Fa0E0mwGAa66mVDDb7JUFrDUCtc1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764189; c=relaxed/simple;
	bh=slMAwfvWGpCYmvrX51E67AatDZm8mfiaLwA2d7coZQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGedaa/mX5M2mooDGSUIsnv9HIVoiSpHLbFYOA4Q4WLV12aYynKQMsnQ7lAhC0/tUDRNTT9OKjx00El2+TLyBRSDYtfp5etlJDz4oVjcEuxFz5/ee3BEsyLZNPVqU31O1KyPLoDObSiAjbSjFcQPK3t6I0RcHB1gMcjbz8Not/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJPXuqJO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EsOwrvKO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJPXuqJO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EsOwrvKO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJPXuqJO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EsOwrvKO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJPXuqJO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EsOwrvKO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04E8D678B2;
	Thu, 14 May 2026 13:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778764186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/05sYzqkJ1sCkKAbVhUIGvOBbX68pJDgCE0fMoXWIRw=;
	b=XJPXuqJOvNPRgzmoSfKXOk/J8xxyA0UxjcyfkcDzkqaHK9gGSr2FDc4KptaPyKMPCmvuKO
	79IELpDHSWfr0dC2RQXkUq2U7Njr+x3/UYaogb3PKS1D8AG+CyT9xcAi2t26lYeQyHZTAU
	s6LqVAW25xJYopkcC7X338dTlhzQTmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778764186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/05sYzqkJ1sCkKAbVhUIGvOBbX68pJDgCE0fMoXWIRw=;
	b=EsOwrvKO+xZKHoJyORrCx5zCrLy30gK07s1V5v/KG5Z8H4S3bHmd8CUc89bQSaZXWWM5Sf
	QzXmgXNJAilVtlBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XJPXuqJO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EsOwrvKO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778764186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/05sYzqkJ1sCkKAbVhUIGvOBbX68pJDgCE0fMoXWIRw=;
	b=XJPXuqJOvNPRgzmoSfKXOk/J8xxyA0UxjcyfkcDzkqaHK9gGSr2FDc4KptaPyKMPCmvuKO
	79IELpDHSWfr0dC2RQXkUq2U7Njr+x3/UYaogb3PKS1D8AG+CyT9xcAi2t26lYeQyHZTAU
	s6LqVAW25xJYopkcC7X338dTlhzQTmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778764186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/05sYzqkJ1sCkKAbVhUIGvOBbX68pJDgCE0fMoXWIRw=;
	b=EsOwrvKO+xZKHoJyORrCx5zCrLy30gK07s1V5v/KG5Z8H4S3bHmd8CUc89bQSaZXWWM5Sf
	QzXmgXNJAilVtlBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0FC6593A9;
	Thu, 14 May 2026 13:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YHLWOpnJBWq6XQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 May 2026 13:09:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C455A080D; Thu, 14 May 2026 15:09:37 +0200 (CEST)
Date: Thu, 14 May 2026 15:09:37 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: fix race between cgroup_writeback_umount()
 and inode_switch_wbs()
Message-ID: <mxnjq2l6guusfchvauxr3v7c4bwjasybxlleqbbh4efloeqspz@iqylk76ohufz>
References: <20260513094829.867648-1-libaokun@linux.alibaba.com>
 <22cda97d61cc9d540d4e7116d5f3f08a@kernel.org>
 <a7f260f7-63a6-4e6f-99aa-0a4be29f740f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7f260f7-63a6-4e6f-99aa-0a4be29f740f@linux.alibaba.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 04E8D678B2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 14-05-26 10:55:03, Baokun Li wrote:
> 在 2026/5/14 04:36, Tejun Heo 写道:
> > Hello,
> >
> > Resending - earlier send dropped the Cc list. Sorry for the noise.
> >
> > How rcu_barrier() got out of sync, as best I can reconstruct:
> >
> > - ec084de929e4 ("fs/writeback.c: use rcu_barrier() to wait for inflight
> >   wb switches going into workqueue when umount", 2019) put the inc
> >   after call_rcu(); rcu_barrier() worked from then.
> >
> > - 8826ee4fe750 ("writeback, cgroup: increment isw_nr_in_flight before
> >   grabbing an inode", 2021) moved the inc back ahead to cover the prep
> >   window, apparently reopening this gap.
> >
> > - e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
> >   switching inodes", 2025) replaced call_rcu() with llist_add() +
> >   queue_work(); rcu_barrier() looks like a no-op for this path since.
> >
> > Could SRCU work instead? srcu_read_lock around the publish (atomic_inc
> > through wb_queue_isw), with cgroup_writeback_umount() keeping the
> > counter gate but swapping rcu_barrier() for synchronize_srcu():
> >
> >   if (atomic_read(&isw_nr_in_flight)) {
> >           synchronize_srcu(&isw_srcu);
> >           flush_workqueue(isw_wq);
> >   }
> >
> > Thoughts?
> 
> Thanks for the detailed analysis on how rcu_barrier() got out of sync,
> that matches my understanding as well.
> 
> Regarding the SRCU idea: I considered it, but it has a key drawback.
> synchronize_srcu() waits for all read-side critical sections globally
> -- it cannot distinguish which superblock a given switcher is working
> on. So if sb A is being unmounted while unrelated switchers for sb B/C/D
> hold srcu_read_lock(), umount of A gets blocked unnecessarily. The
> global isw_nr_in_flight gate makes this worse: any non-zero count from
> any sb triggers synchronize_srcu(), even when the target sb has no
> in-flight switches at all.
> 
> This is especially problematic in high-density container environments,
> where many containers with separate filesystems are being created and
> destroyed concurrently. Frequent cgroup migrations across multiple
> superblocks keep the global isw_nr_in_flight perpetually non-zero,
> causing every single umount to pay the synchronize_srcu() cost even
> when the target sb has zero in-flight switches.
> 
> The per-sb counter avoids this entirely -- cgroup_writeback_umount()
> only waits for switches belonging to its own superblock to drain, and
> returns immediately when s_isw_nr_in_flight is zero. The global counter
> is retained solely for throttling (WB_FRN_MAX_IN_FLIGHT).
> 
> The other trade-offs are roughly comparable: both need pairing on all
> paths, but the per-sb atomic_t gets zero-initialized by kzalloc for
> free, while SRCU needs init/cleanup lifecycle management. The per-cpu
> read lock advantage doesn't matter here since wb switching is
> infrequent.
> 
> So I went with the per-sb counter for its precision and simplicity.
> That said, if you prefer the SRCU approach, I'm happy to spin a new
> version using it.

So I don't think we need a new SRCU. What really needs protection is this
snippet as you correctly identified in your changelog:

        if (!inode_prepare_wbs_switch(inode, new_wb))
                goto out_free;

        isw->inodes[0] = inode;

        trace_inode_switch_wbs_queue(inode->i_wb, new_wb, 1);
        wb_queue_isw(new_wb, isw);

So between we __iget() the inode and we queue work. The rest gets solved
either by SB_ACTIVE check in inode_prepare_wbs_switch() or
flush_workqueue() in cgroup_writeback_umount(). Since there's no sleep in
this part, we can just wrap it within rcu_read_lock() (with appropriate
comment what's protected) and that fixes the race. We could even downgrade
rcu_barrier() in cgroup_writeback_umount() to synchronize_rcu() and it
would still work. So I'd prefer to fix the race like this (also to ease
backporting to older kernels).

Now the performance optimization to make isw_nr_in_flight per
superblock makes sense and I'm open to it as well. But it should be a
separate commit with proper justification and ideally some numbers backing
it showing the benefit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
