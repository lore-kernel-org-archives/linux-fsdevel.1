Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3134023BD1D;
	Tue,  1 Sep 2026 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265488; cv=none; b=Nc8uN0AaHTmY/cqVqpeGOdP+7THjYpVnvWhV6zJB94ioxr3HzqsnGVpb5F7rM1TXIHx43czCDaF90PrBSup1gYm0OmVQOtkLoYNlQh/3maKjcNTVnlaQ54EGrx3zfItAgLMKg5PuAgys/V7HE698pKvrssRuRbVQpyICmZe5I2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265488; c=relaxed/simple;
	bh=qftqCtjCBY7wKQMOoS6ap8jXNv4Qv/Kul7Lie0xCCFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5UDk5AFSfz2IKAgp1ucsfn8RskUnpEkU1yYWJHTRcP8xJ/41W7PrXpp1HbcD/JWuvLN3mC6iErKWhrIToWmFjHjbRNu7onYk00dSbFl0n1BFWD9adgVEKte59ycZe2c9THv1H95KOLMHPxHSD0WZiMaTgtSSNjk/RLkyqxx2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=imxBGETj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6O57BEOs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vx2QucMe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wp258brr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="imxBGETj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6O57BEOs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vx2QucMe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wp258brr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F270D1F794;
	Tue,  1 Sep 2026 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788265481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6ScYrcbTJ0tOAG5oiqEdXV2D1V4U1bKFlU+ezidy2Y=;
	b=imxBGETjIXPzXwGCi6mjdjDo8jKbWk9UKuQeU+E3QmwMVacRAJROpwDuwC/dNrEFbZaWZ2
	J3yeKqjriSmtcXfv2YZitC8uazaWjF3FFvN6pTcCb5L27SyBl70CSnUGVrKiQ/IKa/ONCr
	8MnjUMRyeTb2U66VrNsG04/L7XSCFL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788265481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6ScYrcbTJ0tOAG5oiqEdXV2D1V4U1bKFlU+ezidy2Y=;
	b=6O57BEOsOxEtstOMGA54zz4aA78XfZhuqcGwm6fN4pk846jngdnMmCMwQP0+UxCxvUdK5F
	ypciR+xaZsil5/AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vx2QucMe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wp258brr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788265477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6ScYrcbTJ0tOAG5oiqEdXV2D1V4U1bKFlU+ezidy2Y=;
	b=vx2QucMeNZzCUfzdJ1Xec+hQwEUggMqVfkhtO43SgvPCFDAHpSn6mCusEJRLPephitlIXE
	ulcOfklC/3FV6Mf+oyqVyCfzobuNEhTdExM6aZ46qw+eyd4Wx8kSbIQAgRgfryFyumVgWO
	AEk3D60zYxdA+amX7ewLOGiN5XiXVJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788265477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6ScYrcbTJ0tOAG5oiqEdXV2D1V4U1bKFlU+ezidy2Y=;
	b=wp258brrk9KL23SLnHI6TxhI4mDhgqovlh5shWnJ1TbfzxMFSoE2qzgh2M8uTnPsUBzi88
	KSN5YJZTwKekyKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADAEC136A2;
	Tue,  1 Sep 2026 12:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rVNiKgTElmrdcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Sep 2026 12:24:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37B8EA13B2; Tue, 01 Sep 2026 14:24:32 +0200 (CEST)
Date: Tue, 1 Sep 2026 14:24:32 +0200
From: Jan Kara <jack@suse.cz>
To: Mikhail Rudenko <xyzzy@yandex-team.ru>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Defer final iputs for dirty-time inodes in
 PF_MEMALLOC context
Message-ID: <27v2ckdgybmvxog5b55sr3o6ri4bkbzu6ycwtjwckrhzyazxzd@7qruolrsu5t7>
References: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F270D1F794
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

I'm sorry for the delayed reply. Due to vacation and backlog after it it
took me long to get back to this.

On Thu 13-08-26 12:43:28, Mikhail Rudenko wrote:
> The motivation for this small series is the following kernel WARNING:
> 
> [  893.915584] ------------[ cut here ]------------
> [  893.915589] WARNING: mm/page_alloc.c:4749 at __alloc_pages_slowpath.constprop.0+0xd4d/0x10f0, CPU#1: stress-ng-vm/3784

<snip>
 
> It was initially observed in the wild on linux 6.12.y, but later I
> reproduced it in Qemu with linux 7.0.11. I believe it is still an
> issue in the mainline master. Similar issue was reported earlier [1],
> but looks like no real analysis was performed then.
> 
> The warning is triggered when a process with PF_MEMALLOC flag set
> requests a __GFP_NOFAIL page allocation. In this case, the allocation
> comes from ext4_dirty_inode() called when shrinker frees a dentry,
> resulting in i_count of an inode going zero, which in it turn can
> trigger sync_lazytime() if said inode has I_DIRTY_TIME flag, resulting
> in inode becoming dirty. On ext4 this causes an immediate journal
> transaction, which may lead to __GFP_NOFAIL allocation in the
> slowpath.

Yes, we are well aware of this problem. It actually goes significantly
further than just lazytime processing.

> The proposed approach to fix this basically boils down to "if need to
> do sync_lazytime() in PF_MEMALLOC context, defer instead".
> 
> Patch 1 adds basic per-superblock infrastracture for deferring iputs:
> a workqueue, a work_struct, a list, a bool flag, a spinlock, and some
> glue code. A tricky place is superblock shutdown: we should stop
> accepting deferred iputs not too early, so that no legit cases fail to
> defer, and not too late, so that superblock is still operational and
> we can flush the workqueue. Since we cannot enter
> deactivate_locked_super() from PF_MEMALLOC context, stopping after
> shrinker_free() seems safe.
> 
> Patch 2 uses this infrastructure to defer iputs of inodes with
> I_DIRTY_TIME, which would trigger sync_lazytime() otherwise, when
> running in PF_MEMALLOC context. Clumping default and PF_MEMALLOC paths
> together in iput() would have resulted in decreased readablity, so I
> avoided that by setting up a separate iput_memalloc(), at cost of
> slight code duplication.

Thanks for your patches. I've actually submitted patches to address this
problem back at the end of April [1]. In particularly the problem you
report was addressed somewhat differently by patch 1. We've then discussed
them at LSF/MM/BPF summit and people mostly agreed with the approach, just
there were some requests for better parallelization of deferred inode
reclaim (which I so far failed to implement). But it's currently high on my
todo list so I should hopefully send v2 of the patches for the next merge
window.

								Honza

[1] https://lore.kernel.org/all/20260429174850.18223-1-jack@suse.cz/
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
