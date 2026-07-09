Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07053FCB33
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592572; cv=none; b=e1SnAyQQ0XgJuGh1sA9GYFOPr0d7Vx/zfL70hBqF+f0YL48xtoykMZwBVTt9fdPmsPJvrlzV+6qiWri/ytRtzmM3mBtmfrgFW4tYscAnQbvzRXeyruHPrO5kowUpMxbdAlbNz7edvtb55+L7ub+spjNoPCAYG+3TOoZrfYN2hzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592572; c=relaxed/simple;
	bh=M71Ty8SkpsNB1cwHt6/GOBQhL9Tpgd2xpjY8XvYbCj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGQ6n1iCxwd31HEjkJwxYE9WSkwHsaq5GoFEAKSz7MYqws2pWv8cpTTSsW5Dzc1DVS1xjybzEoWqIHpFbWul84L/wz9y9aYn+PPncOGPc8otQBaZ6kfpQ6uVY5vcUJOB69UxULZ30FUWxhJ+H5IxoI+PLQjgWttkHnSYwhYjP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dje02QeN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AtxxGKZB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dje02QeN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AtxxGKZB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dje02QeN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtxxGKZB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dje02QeN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtxxGKZB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1D827610B;
	Thu,  9 Jul 2026 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783592567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx4/K/592I8NvYZBqlKcnuj2Yy+ngX/K4XOfGwEMKkc=;
	b=dje02QeN4Kv4vewc8fdEDVAyiP6dM6F2MCy/4dbE0DPWyaDVjCCsl/AFlDNN0Y2GW+6mj8
	JzzCg5K0h0nYq6JIiWICW7w9elGyxQfGH2vXywtdYveDP6NlWkHRdGrqzPAFk7ntImzmD2
	3+NKc5X2ujcwu/aVbMg8TO/B/h58hn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783592567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx4/K/592I8NvYZBqlKcnuj2Yy+ngX/K4XOfGwEMKkc=;
	b=AtxxGKZBJTGfrfXeBqEvc3IB14FA4a6umkjlwYGgREDYKTamlpyIeMBSz1SOAzSikCgSnT
	+1OoVmHVLMcm1dAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dje02QeN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AtxxGKZB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783592567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx4/K/592I8NvYZBqlKcnuj2Yy+ngX/K4XOfGwEMKkc=;
	b=dje02QeN4Kv4vewc8fdEDVAyiP6dM6F2MCy/4dbE0DPWyaDVjCCsl/AFlDNN0Y2GW+6mj8
	JzzCg5K0h0nYq6JIiWICW7w9elGyxQfGH2vXywtdYveDP6NlWkHRdGrqzPAFk7ntImzmD2
	3+NKc5X2ujcwu/aVbMg8TO/B/h58hn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783592567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx4/K/592I8NvYZBqlKcnuj2Yy+ngX/K4XOfGwEMKkc=;
	b=AtxxGKZBJTGfrfXeBqEvc3IB14FA4a6umkjlwYGgREDYKTamlpyIeMBSz1SOAzSikCgSnT
	+1OoVmHVLMcm1dAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B97AA779AA;
	Thu,  9 Jul 2026 10:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1wlCLXd2T2rmdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Jul 2026 10:22:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 66888A12D7; Thu, 09 Jul 2026 12:22:47 +0200 (CEST)
Date: Thu, 9 Jul 2026 12:22:47 +0200
From: Jan Kara <jack@suse.cz>
To: Chengfeng Lin <lin2530632123@gmail.com>
Cc: Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] tmpfs: flistxattr(fd) small-list slowdown after
 simple_xattrs rhashtable conversion
Message-ID: <q6pq2txjkc4hkdgo23s7t34l76rjsvbyebthqcawjq2dz6aiv4@rfygllbnj77r>
References: <CANGjgdm=gbQj=tmakUipHz9wR-mUvMVECfvJbTm=sEufxOe20g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANGjgdm=gbQj=tmakUipHz9wR-mUvMVECfvJbTm=sEufxOe20g@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C1D827610B
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi!

On Mon 06-07-26 16:53:28, Chengfeng Lin wrote:
> I found a small-list flistxattr(fd) slowdown on tmpfs while looking at FS
> performance regressions.  This is a performance regression report.
> 
> The scope is intentionally narrow:
> 
>   tmpfs + user xattrs + flistxattr(fd) + small xattr lists
> 
> The cleanest reproducer creates a tmpfs file, sets one or more `user.*`
> xattrs, and repeatedly measures:
> 
>   flistxattr(fd, list, list_size)
> 
> The single-xattr scenario checks that the returned list is non-empty; the
> count-gradient scenario also checks the exact returned list length.
> 
> The bare-metal test machine is an x86-64 Intel Core i7-14700 system with 28
> logical CPUs and 30 GiB RAM.  The benchmark was pinned to CPU 2, and the test
> filesystem was tmpfs.
> 
> On bare metal, the parent/child A/B around:
> 
>   52b364fed6e1 shmem: adapt to rhashtable-based simple_xattrs with
> lazy allocation
> 
> shows a clear jump.  The parent has the rhashtable infrastructure but tmpfs
> still uses the old rbtree path.  The child switches tmpfs to the lazy
> rhashtable-based simple_xattrs path.  I understand that the lazy allocation
> part is meant to avoid per-inode rhashtable overhead for tmpfs inodes that do
> not use xattrs; this report focuses on the small-list listxattr cost for tmpfs
> inodes that already have user xattrs.
> 
> With one xattr, skipping the first round:
> 
>   kernel / state                         flistxattr_ns_per_op
>   parent A, tmpfs old rbtree path         135.754
>   child,  tmpfs lazy rhashtable path      229.663
>   parent B, tmpfs old rbtree path         135.335
> 
> That is about +69.4% for the child vs the average of the two parent runs.
> The two parent runs agree closely, and the skip-first-round ranges were:
> 
>   parent A: 134.451..140.153 ns/op
>   child:   217.758..239.498 ns/op
>   parent B: 134.273..138.098 ns/op

Thanks for report! Couple of questions:

1) Can you still observe a difference in your benchmark between 7.0 kernel
and kernel after commit 1e7cd8a53b72 ("simpe_xattr: use per-sb cache").
Because that was exactly addressing performance regression for small number
of xattrs.

2) If yes, we need to better understand where the time is spent but we need
to analyse profiles after commit 1e7cd8a53b72 because that significanly
changed how things behave...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
