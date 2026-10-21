Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599624;
	b=mHGaxEN6UTmiWWplDsJcwqdwelAhUUBGSc+nEt5dCmzNEsiVsw5dHYgXHhQYYvp06C+q
	 UUjELTpiGNNyzvpmSZbaiq6GLd8zPTW6Hvb31oL84hLKMSHPFTWlqu/Nv5WDPeSPWGald
	 idGco3q8Xa/Q1Jpr+oHkhVJYhNb9oFMmeMzvFIly4SFgMXFnTy3ovhe9GtgkHPeZXTnb5
	 rmuERyitSL8Pyf8Ou3WMM80GhNLi37FyL63u0mZuWyMz3x6mndcYTmJwVhIfovRXTUBQB
	 hi+w4HJaIfoiIARWmrGsCl77sbicJY5/XPhZ3Hoe7MJEcMP0FRxgdlqh23fIBx9tLpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599624;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=Tav5y5jFkau2LmUYqTnA1wpMJIvN6h4hM3tj4E8VzrE=;
	b=SYmHKcwP+xRf62wViLIsj1jP1uo1bbwoVOIy21ZY5CfAnCe53ZKG9B8XTcXXEdzokxxc
	 FYGJfMMbRcccKikhh4/6dSX8lv3uth347fu6ioPp6FwXHLCgLePE3YVfGNElhE6Zht6Kz
	 pklNk3r4+gilQ5XlAYEQxIMGTCmk1kxvpeMoRMaY5Pa5rptni5Zhix31jmkl+uq0xKY3f
	 1gBt1cFqPb+He1uBCWWdVfcK0qTzT+446XI5B97qQan0EIcEx79VCKPO/n/x1cG5kwyr6
	 SiA/gbqUZg3WATmjjgRkjHhtU2ivGVxfPfCX0ugjTuwaGC5s9mR8kUofyxA5+7U/NUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sazbDk7J;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ymt8Kd2v;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sazbDk7J;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ymt8Kd2v;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B13606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 16:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B13606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sazbDk7J;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ymt8Kd2v;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sazbDk7J;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ymt8Kd2v
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7232C21DD1;
	Wed, 21 Oct 2026 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792599622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tav5y5jFkau2LmUYqTnA1wpMJIvN6h4hM3tj4E8VzrE=;
	b=sazbDk7Jp42D9Z5NdeyLUE1OcGu1nRmZpajaw7CVCmsDZprfrotgkGsrQwQYe5/Bbxvcre
	typgZVJwUShb1f0HcHtI6nycvsZTVVD5gDiTJAzIPvlyqRHKNvGgId6JCLI69hASVpJtBp
	pwPTXZUruQuRogJc6W2aVTO+QOCGY6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792599622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tav5y5jFkau2LmUYqTnA1wpMJIvN6h4hM3tj4E8VzrE=;
	b=Ymt8Kd2vfBHv+m/U7yEAQSPnS7zjXjOXil3bIAOaaAlo5Yt102QKVhbjyEMgJXB1Sg3xwY
	B9MrwlRzWtDaHNCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792599622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tav5y5jFkau2LmUYqTnA1wpMJIvN6h4hM3tj4E8VzrE=;
	b=sazbDk7Jp42D9Z5NdeyLUE1OcGu1nRmZpajaw7CVCmsDZprfrotgkGsrQwQYe5/Bbxvcre
	typgZVJwUShb1f0HcHtI6nycvsZTVVD5gDiTJAzIPvlyqRHKNvGgId6JCLI69hASVpJtBp
	pwPTXZUruQuRogJc6W2aVTO+QOCGY6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792599622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tav5y5jFkau2LmUYqTnA1wpMJIvN6h4hM3tj4E8VzrE=;
	b=Ymt8Kd2vfBHv+m/U7yEAQSPnS7zjXjOXil3bIAOaaAlo5Yt102QKVhbjyEMgJXB1Sg3xwY
	B9MrwlRzWtDaHNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45D5A134FD;
	Wed, 21 Oct 2026 16:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TPcCCEbm2Gp9SAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 16:20:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C82A4A1418; Wed, 21 Oct 2026 18:20:21 +0200 (CEST)
Date: Wed, 21 Oct 2026 18:20:21 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <dgc@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Mikhail Rudenko <xyzzy@yandex-team.ru>, 
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 0/7 v3] fs: Deferred inode reclaim
Message-ID: <pm2fqzpmq7pmv7csi7k7vmbugceblvjlzcaoq3a6itakkri3wz@oagg7akwqrjf>
References: <20261009133253.20102-1-jack@suse.cz>
 <atfmukIp61u_dn6Z@dread>
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
In-Reply-To: <atfmukIp61u_dn6Z@dread>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 21-10-26 09:10:02, Dave Chinner wrote:
> On Mon, Oct 12, 2026 at 10:23:38AM +0200, Jan Kara wrote:
> > here is the third revision of my patches implementing deferred inode reclaim to
> > deal with MM warnings due to GFP_NOFAIL allocations from reclaim paths. This
> > happens because to reclaim some inodes, filesystems have to do IO including
> > complex operations using journalling and forward progress of these depends on
> > successful memory allocations (which is impossible to guarantee from reclaim
> > context).
> > 
> > Since the last revision the most notable changes include addition of automatic
> > deferal of inode eviction from iput() when inode link-count is 0 and we are in
> > reclaim (PF_MEMALLOC flag set). This path gets triggered e.g. by overlayfs
> > whose inodes hold dentry references on upper filesystem and thus slab reclaim
> > of overlayfs inodes can trigger the last dput() (and thus iput()) of already
> > unlinked files. Since inode deletion is practically guaranteed to require IO
> > (and thus possibly e.g. loading allocation information into memory) I've
> > decided to unconditionally defer reclaim in this case instead of marking inodes
> > in each filesystem.
> > 
> > Another bigger change in this series is that we now protect deferred inode
> > reclaim from filesystem freezing. Otherwise inode eviction could block the
> > reclaim worker on frozen filesystem which could stall deferred inode reclaim on
> > the whole system. Deferred reclaim workers now skip reclaiming inodes on frozen
> > filesystem and we block filesystem freezing while the worker is evicting
> > current batch of its inodes.
> > 
> > The last bigger change is that mark_inode_reclaim_deferred() does not block
> > when the queue of deferred inodes grows over limit anymore. Instead it queues
> > task work to delay the task appropriately when returning to userspace. This
> > solves possible lockups when tasks would get throttled when calling
> > mark_inode_reclaim_deferred() with some locks or transaction started.
> 
> Hmmm. This re-implements the XFS inodegc infrastructure at the VFs
> level, but without all the internal XFS knowledge of when background
> inodegc processing is required. It looks rather complex compared to
> the XFS inodegc code....

Yes, I took some inspiration from it. One big difference though is that
deferred inode reclaim will be applied only to inode evictions done from
SLAB reclaim and only for inodes explicitely marked for deferred reclaim by
the filesystem. Just there's this exception that currently VFS would
auto-offload (i.e. without explicit marking by fs) in the case SLAB reclaim
happens to drop the last inode reference of unlinked inode. So in that case
VFS could defer reclaim even for XFS inode but that is mostly performance
irrelevant cornercase (in vast majority of cases unlink or file close does
the last iput() of unlinked inodes and in that case we never offload in
VFS). So I'm not sure we care about avoiding the extra offload for XFS for
that case.

> Whilst I agree that the VFS should be able to do this for
> filesystems like ext4, we really don't want to be deferring inodegc
> processing twice.  Hence for XFS we really want the VFS to call
> evict() immediately for all inodes so that the filesystem can
> correctly decide if deferred processing is necessary or not...

Yep, that should mostly happen. See above.

> > The patches have survived full fstests run on ext4 when marking all loaded ext4
> > inodes for deferred reclaim to stress the deferred reclaim paths. I have also
> > tested (when marking all inodes for deferred reclaim) the patches by creating a
> > memcg with 128m memory limit and then scanning from 10 processes 1m inodes in
> > total which heavily exercises deferred inode reclaim paths. This also verified
> > efficiency of throttling of marking of inodes for deferred reclaim. Basically
> > we cannot guarantee any particular limit on the number of inodes queued for
> > deferred reclaim as that is bound only by their number in memory and memory
> > pressure. But as the number of queued inodes grows, the tasks creating them get
> > slowed down so eventually some equilibrium is hit. In my VM this was at ~10k
> > inodes (only slightly above the 8k limit when throttling kicks in) but this all
> > very much depends on the reclaim pressure, speed of deferred reclaim etc. so I
> > don't think this is some representative number.
> 
> XFS has a "almost-hard" queue limit is 256 queued inodes per CPU.
> Anything larger than that sees reduced performance under sustained
> inode cache pressure and latency problems when eviction processing
> of individual inodes takes a long time (e.g. deferred unlink of a
> set of inodes with millions of extents each).
> 
> In normal operations, however, the low queue limit means triggers
> the scheduler to move the reclaiming thread to another CPU to allow
> the queued cleanup work to run on the same CPU it was last touched
> on. Performance testing showed that moving the reclaiming task was
> much, much better than pushing the reclaiming work to other CPUs
> whilst blocking on the throttle. Deep queues (like many thousands of
> inodes) caused other problems with ongoing (non-reclaim) operations
> then contending with resources with queued background inodegc.
> 
> i.e. for XFS it has proven better to have short queues, short
> backoffs and schedule/process small batches concurrently than it is
> to have deep queues, spreading the work out many kworkers and having
> "end-of-queueing" throttling behaviour...

Yes, I was considering XFS inode reclaim design as well. The big difference
to XFS case which offloads everything is that we expect to only have to
defer inode reclaim if something expensive (like allocating blocks)
happened to the inode. At least all usecases I have in mind are like that.
Also except of rare cornercase races the reclaim of unlinked inodes will
not be handled by deferred reclaim workers but directly inline in iput().
That is why I didn't bother with per-cpu thing as I believe the performance
of the offloading mechanism itself doesn't matter as much at that point.
But I could be wrong...

> > The first patch is a pure fix for a problem I've hit when running fstests.  The
> > second patch deals with lazy timestamp updates which I've decided to handle
> > better directly inside the writeback infrastructure instead of deferring
> > reclaim. The remaining patches implement the inode reclaim deferal. Ext4 use of
> > deferred inode reclaim is there mostly as a demonstration. Other filesystems
> > need to determine which inodes need deferred reclaim and mark them as such
> > which generally requires good internal knowledge of the filesystem. I'm hoping
> > that once the infrastructure is there, fs developers prompted by MM warnings
> > will start using it :). I know for a fact that besides ext4 e.g. gfs2 wants
> > to use this infrastructure.
> 
> But XFS doesn't, so it needs to be optional. :)

If you still want the rare cases where offload could happen for XFS optional
after above explanations, I can do a filesystem_type flag for that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
