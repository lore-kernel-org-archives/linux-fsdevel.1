Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F04D9F9D;
	Wed, 14 Oct 2026 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978279; cv=none; b=ISSgqQ1Ots25iX6UPe1RoOjxJIpFw7leEpsK/pVFHRTTuMTwuDMdxI9tgEZemmuKrEsNqnRuR1/jzGFFMT/sDFxE/WtHSoX3hYmbxfD21KL0esi2vG2ikoXCBQWk2+ERTkIwCGpI5zaoK4wmDerfyoV1jU+yy2yThPrGlOcQd0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978279; c=relaxed/simple;
	bh=8Iqcb5J0DHIvtkYqwjH+nExgg+bw2Z185o8GhWcj9Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPElitLJhx+2vZX/eDLHtLxsegsCqDgeIbm9EEUVJIDk2TubiMiU46bXcEm/y6GN8vND2knwRs8DyVXQtXUtfC2mDyTrUNcGRJ05887RkPtV7VFz5I6nZ48Z7hdV1K5JtbXNpVhukYXsaAV8XLnz90vCH5/A7p9+JKHTwx95GWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yKmZOQSx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5+jJryL2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yKmZOQSx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5+jJryL2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yKmZOQSx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5+jJryL2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yKmZOQSx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5+jJryL2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52D3A1F444;
	Wed, 14 Oct 2026 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791978273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocy9Wwhkw9+5dyQRVw3aQD1pCbreLfNwhPg/38rBAGY=;
	b=yKmZOQSxIP3kVjIQiTjJhWCHb4UBZoyBnOajU5pvdAR5Li5L43x9z8gD5q4vl9eas1gVIo
	S+71RmQO3L8TWgp+Mo+R6DMrX8lk/40GwIdH9QB2iD304X0kihJkRZQFom1dsyyjmxUyYL
	p7Y8CLopXhJzPbmZujtBV8GFmKJopM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791978273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocy9Wwhkw9+5dyQRVw3aQD1pCbreLfNwhPg/38rBAGY=;
	b=5+jJryL2Sr3cnYe+um/+1olGL/Y1sVC6bNMVH/JvMG1XuKbdJrVVb6hRlMrnfIIjuvEp0s
	GoJVHwHp+PfxbMDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yKmZOQSx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5+jJryL2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791978273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocy9Wwhkw9+5dyQRVw3aQD1pCbreLfNwhPg/38rBAGY=;
	b=yKmZOQSxIP3kVjIQiTjJhWCHb4UBZoyBnOajU5pvdAR5Li5L43x9z8gD5q4vl9eas1gVIo
	S+71RmQO3L8TWgp+Mo+R6DMrX8lk/40GwIdH9QB2iD304X0kihJkRZQFom1dsyyjmxUyYL
	p7Y8CLopXhJzPbmZujtBV8GFmKJopM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791978273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocy9Wwhkw9+5dyQRVw3aQD1pCbreLfNwhPg/38rBAGY=;
	b=5+jJryL2Sr3cnYe+um/+1olGL/Y1sVC6bNMVH/JvMG1XuKbdJrVVb6hRlMrnfIIjuvEp0s
	GoJVHwHp+PfxbMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28539133F1;
	Wed, 14 Oct 2026 11:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aASqACFrz2pyRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 Oct 2026 11:44:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 44ECEA1411; Wed, 14 Oct 2026 13:44:32 +0200 (CEST)
Date: Wed, 14 Oct 2026 13:44:32 +0200
From: Jan Kara <jack@suse.cz>
To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: Jan Kara <jack@suse.cz>, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v2 0/2] fsnotify: drop SRCU across inotify event delivery
Message-ID: <mzx4rhr7zqhza6qh7zefytrmcx547nh2bvopwtdnannhnjl7md@sm2kdibrorwb>
References: <cover.1791452174.git.zhujia.zj@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791452174.git.zhujia.zj@bytedance.com>
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,kvack.org,linux.dev];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,lpc.events:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Rspamd-Queue-Id: 52D3A1F444
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hello!

On Thu 08-10-26 20:02:37, Jia Zhu wrote:
> We observed fsnotify teardown stalls in production. NMI backtraces
> showed inotify_handle_inode_event() in memcg reclaim, and the mark
> reaper, inotifywait and a systemd process were reported blocked for more
> than 327 seconds.
> 
> We checked upstream and found the same issue: inotify allocates events
> under fsnotify_mark_srcu, and the global mark reaper waits in
> synchronize_srcu().

Thanks for the details. Well, it isn't only inotify. fanotify also
allocates event structure for each notification group when the event is
generated. But when you run setup that can stall for over 5 minutes in
direct reclaim I wouldn't really say it's fsnotify that's broken :) In
general this seems like a classical case of priority inversion where some
heavily throttled task holds a resource other tasks need and so they block
behind. MM guys are actually looking into these issues (e.g. it was
discussed at LPC MM microconference last week [1]). Adding Shakeel to CC.

> The production report shows multiple inotify release paths blocked
> behind the global mark reaper. Because SRCU and the reaper are shared
> across groups, a stalled delivery can delay other groups' close() and
> exit paths.
> 
> Patch 1 pins the iterator marks and drops SRCU around inotify delivery.
> It retains fanotify's pinning semantics and preserves event delivery to
> a surviving inotify watch when another watch is removed. This leaves the
> reclaim stall itself unchanged.
 
This is going to noticeably slow down event delivery so it isn't really
acceptable in this form. I'd actually prefer if these cgroup priority
inversion issues got somehow dealt with in MM or with its better support so
that we don't have to add complexity to fsnotify for this. Also note that
even through we can drop SRCU like you do, the task that is doing the
operation on the filesystem will be still blocked until the allocation
succeeds and will be holding filesystem locks. So although your change will
address the particular stalls you observe, other types of stalls remain
unaddressed (which is another reason why I dislike your solution).

> Patch 2 skips the global reaper flush when only the closing group
> reference remains. As Jan noted on the earlier patch [1], this only
> helps groups with no outstanding marks. It is optional and can be
> dropped.
> 
> The teardown fast path was checked in QEMU with a test-only SRCU holder.
> 
> [1] https://lore.kernel.org/all/4467cbj7eivubtdwcawvr7mhrb7armgoc4xfqjjnncrbkxxag6@3mmou6nhviao/
> 
> Jia Zhu (2):
>   inotify: drop fsnotify SRCU protection during event delivery
>   fsnotify: avoid unrelated mark reaper waits during group teardown
> 
>  fs/notify/fsnotify.c             | 15 ++++++++++++---
>  fs/notify/group.c                | 26 +++++++++++++++-----------
>  fs/notify/inotify/inotify_user.c |  3 ++-
>  fs/notify/mark.c                 | 26 ++++++++++++++++++++++----
>  include/linux/fsnotify_backend.h |  2 ++
>  5 files changed, 53 insertions(+), 19 deletions(-)
> 
> 
> base-commit: df2908090cda368b01ff43709f51890076c56157

								Honza

[1] https://lpc.events/event/20/contributions/2418/
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
