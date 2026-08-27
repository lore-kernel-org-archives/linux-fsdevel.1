Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF1837CD32;
	Thu, 27 Aug 2026 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848244; cv=none; b=Vr77E0YQt+QQBb1FgiBdY0rwEqALGDCtrh4TC5bI88V0e84ctgPDW40Ty7NWXB4WZe9IMaf/JlJ2utHR+GkkzphQ1bG5BiQ+7Mezn1R7gpLxZigZcVmBRWEnPIGn2wGAtFJSyx2xtyBK5aLPzWpBZhRVbf4KyAa+hdp7g1H+Bw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848244; c=relaxed/simple;
	bh=uU3MShrf7vIGXaSHpzqQistr9vSdlLVHYIeZFH6OOVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSPj37DdfQeeYwYKRPAHOZ+8QmmaP44ne+E/R9Kn5GN32FaR2RFpwv+Wuhmn4RIoCOSh5ABVi5tpQaYCCXLwRH4v4VqNAlKdNlIH3pqtYDdwsiMPk36fOoWJxkJ1jBNzoBjTHDY2Nz30NKpfuRCBn27IYbkS6/bS2trjie3nPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lXSGBpro; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gRTA9UhZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jgd3Q9WD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pWfaT/iP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lXSGBpro";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gRTA9UhZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jgd3Q9WD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pWfaT/iP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22A2021971;
	Thu, 27 Aug 2026 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787848237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4qayCPNGl34g2mn5/ScRPGLzWTQaFo4U/WhwlU3vTU=;
	b=lXSGBproWskHSLMOiEgnyv+cgoFiJuI5ZQrLZEVN/TbLtFP5gcL1oUBx1ic+H+rI28AuGB
	VjjMVQSU+Trj/QVCKS9JQ6yebfF55GIdpVdZI1TVVXt03h9AGiwql4cHSggMM6J41sDaaK
	yep3urLox3Obj7U9PGURHBqkVlXjSkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787848237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4qayCPNGl34g2mn5/ScRPGLzWTQaFo4U/WhwlU3vTU=;
	b=gRTA9UhZzJwtTPkq9oj+2AS6VINhmXBxfGJGALav+ql5FnLdmrbPJtFOHVLVMpcZ4idGdN
	R1DPFxNhs0PrZhCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Jgd3Q9WD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="pWfaT/iP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787848233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4qayCPNGl34g2mn5/ScRPGLzWTQaFo4U/WhwlU3vTU=;
	b=Jgd3Q9WDCK+UASQHkubofzM9fx3ECK5/fFvZCROq8Kh/qmEQYq1BL8g8Q3yAnwy5DdOAKK
	bhp7IEdQ/OY8VVUMpA1NVz+olDy/136k9+gbo+Z2vhLliGDyg8wY9BcunVOjlhaWDe3Ldh
	rJG7+SrN6GO5Ts9eKxuayBaMjFAbKwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787848233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4qayCPNGl34g2mn5/ScRPGLzWTQaFo4U/WhwlU3vTU=;
	b=pWfaT/iPSphk/ibRJHE+HVw+fzNJ9+TvFP2db0i+zAc1uO3GmdoNuesz4mwav28v3VQphW
	WTNfD1cuvlpkZXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B61C1352C;
	Thu, 27 Aug 2026 16:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j1paAilmkGrPJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Aug 2026 16:30:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 54BB2A1324; Thu, 27 Aug 2026 18:30:28 +0200 (CEST)
Date: Thu, 27 Aug 2026 18:30:28 +0200
From: Jan Kara <jack@suse.cz>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached
 connector
Message-ID: <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
References: <20260827045007.3831259-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827045007.3831259-1-4ncienth@gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 22A2021971
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,redhat.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

Hello!

On Thu 27-08-26 13:50:04, Daehyeon Ko wrote:
> I found an unprivileged race in fsnotify_destroy_marks() that can leave an
> attached fanotify mark on a detached connector. On unmodified Linux v7.2 and
> v6.12.105 source builds, it naturally reaches the fsnotify_conn_mask()
> warning from fanotify_mark(). On unmodified builds, the only observed
> system-wide failure was a v7.2 panic when panic_on_warn=1; no memory
> corruption or privilege escalation was observed.
> 
> Tested and source-inspected versions:
> 
>   - Linux v7.2, commit
>     8d3ae59288f1e7d58d76558a6ee96d533bc5019f: reproduced.
>   - Linux v6.12.105, commit
>     14c37ff05f22da2fa7076d10f6a07c7ede330c83: reproduced.
>   - Torvalds master at
>     73e3f0710014fe6d4ed98cfc02292f6121db7558: the relevant destroy
>     iterator and fdinfo consumer remain present. Commit e422777fdd47
>     changed mark-mask updates and can mask the immediate warning, but it
>     did not change this iterator or the detached-connector state.
> 
> The unconditional connector detachment involved in the race appears to
> originate in commit 6b3f05d24d35 ("fsnotify: Detach mark from object list
> when last reference is dropped"), released in v4.12-rc1. My unprivileged
> runtime results are limited to the two versions listed above. The limited
> unprivileged fanotify functionality used by this reproducer was introduced
> by 7cea2a3c505e ("fanotify: support limited functionality for unprivileged
> users"), released in v5.13-rc1; I am not asserting ordinary-user
> reachability before that change.
> 
> Root cause:
> 
> fsnotify_destroy_marks() holds a reference to the current mark, drops
> conn->lock, destroys that mark, and then continues the hlist walk. While the
> lock is dropped, an equal-priority mark can be inserted immediately before
> the current entry. The walk resumes from the current entry's next pointer,
> so it never visits the new predecessor, but it still detaches the connector
> from the object after the walk.
> 
> The skipped mark remains ALIVE|ATTACHED and remains on both its group list
> and the connector list. At the same time, the object no longer points to the
> connector, conn->obj is NULL, and conn->type is DETACHED.
> 
> Representative v6.12.105 output is:
> 
>   WARNING: CPU: 1 PID: 163 at fs/notify/mark.c:128
>   fsnotify_conn_mask+0x113/0x150
>   CPU: 1 UID: 65534 PID: 163 Comm: fanotify_destro
>   ...
>   do_fanotify_mark
>   __x64_sys_fanotify_mark
> 
> The source reproducer ran on ext4 as UID/GID 65534 with CapEff=0 and
> NoNewPrivs=1. It uses ordinary FAN_REPORT_FID groups and races final unlink
> against fd-based mark insertion.

Thanks for the detailed report. Before discussing possible solutions I'd
like to better understand how the race happens because so far that's
unclear to me. You mention you are racing final unlink with fd-based mark
insertion - so I presume we are speaking about inode marks here. Fair.

Now for "final unlink" to reach fsnotify_destroy_marks() it has to go
through:
  d_delete() -> dentry_unlink_inode() -> fsnotify_inoderemove()

But to go through this path, d_delete() has to validate that
dentry->d_lockref.count == 1 which should not be possible if the inode is
still open (and thus the file->f_path holds the dentry reference). What am
I missing here? Which two calls are exactly racing?

FWIW my current suspicion is that calling fanotify_inode_delete() from
fsnotify_inoderemove() is actually too early and we should always leave it
to __destroy_inode() time which would also avoid any races with mark
addition. But the fact that the above race can happen at all makes me
nervous we can be missing some other cornercases...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
