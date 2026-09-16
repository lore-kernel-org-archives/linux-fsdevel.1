Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1373DA7EE;
	Wed, 16 Sep 2026 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551079; cv=none; b=IqHx5x4Rg+TjsbJ7xTVjHlWPPPt/xP10YxEIEXglCwZbXYW11sNqwwjLVQSVHz0lbVE4dcyvlproAOEbiHwT/r4yppE7eY2iv31YKO5Dm2AWl8xLnm5m1PKdE4XMsXR4J6A0Ln7P0VH+s6cnL/hGqVWEb7bk/G6+p7BnzfvLI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551079; c=relaxed/simple;
	bh=E85HFhhUs0x/aXOlHxaHq64C3ilYeiVBNuDhvL0gjJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML2m4ZoBynwDwwG5/cL5p1oGPfg93EW6V25Y/UnLOWKP39F9k/x4ytfA/excEE+khSHTdTgtHJktslNYyoRmiQZxF0yZrH/hjMV2/c+xEFU2px187zAhTStGzfVYvWtbX0w75P5JUgTbfX9OW8d29v+1fpQcslJQ6saAmxSP+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YC0yeZB2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=giRW4EAs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xT9P6R9Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tXzHzh+w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YC0yeZB2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="giRW4EAs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xT9P6R9Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tXzHzh+w"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1DEFB1F816;
	Wed, 16 Sep 2026 09:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789551061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PE4H9Iusm4ufJrCI8/QB/PPlK1J8REHfZKLgB0l8e5E=;
	b=YC0yeZB2mlauiByNGe1wm6ebHPHgvg/3nrS+I4IjP+9APDjvX0pmRofnK/whpcvdzIvim/
	J+XOZiEysGkhRXba9AF6TBIn0FBkQc5cRVfaK+juBoNUaueyjjvuqPhvfsPnyxHVyC2Ess
	R+ZPIYcWi2cPF7AOoDQcGJbfeSVgpU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789551061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PE4H9Iusm4ufJrCI8/QB/PPlK1J8REHfZKLgB0l8e5E=;
	b=giRW4EAszBKwFx6h9PO9jfUyerVLSNyf0fDQaNMVUTI+q/LXNO0XRYDw5uQtyYFnvrHvcp
	PgTvFoAEzjl7DFDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xT9P6R9Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tXzHzh+w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789551057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PE4H9Iusm4ufJrCI8/QB/PPlK1J8REHfZKLgB0l8e5E=;
	b=xT9P6R9YusBxe6h3HSuYqoQt+qMoxQ+WJcIcjFlaX4w5JIsaMkXpD4lKJQ6rGVc0TyPVQE
	3iGeaNY/F/sGQHp9lg2pTh71XCqaKtU7f7Kz0kMxYjcf4iLboqe56vtabgPi971EH019DN
	BEiFnviGdfiTRYsf90lAm/jyRUN+W5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789551057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PE4H9Iusm4ufJrCI8/QB/PPlK1J8REHfZKLgB0l8e5E=;
	b=tXzHzh+wBMIoFw6OBcvwhe1dZ+EftVuzsrmz/fLiA7tw5HssAjxkNLR78XIfbxROUW4hIP
	O6s38da9/ByVK+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46BF3136A5;
	Wed, 16 Sep 2026 09:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 665kN89hqmrjGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Sep 2026 09:30:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C5A74A13B4; Wed, 16 Sep 2026 11:30:36 +0200 (CEST)
Date: Wed, 16 Sep 2026 11:30:36 +0200
From: Jan Kara <jack@suse.cz>
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7ff3adde89dd795ad4c4@syzkaller.appspotmail.com, glider@google.com, dvyukov@google.com
Subject: Re: [PATCH v2] dcache: fully initialize the inline name in
 __d_alloc()
Message-ID: <fth2khqf5a4lx6wyqhxz6v5qts45ycbb2erqdgof6zq3uw2nzf@r7i6kvipji3l>
References: <20260913152802.13413-1-drifabdelmalekmohamedsaid@gmail.com>
 <20260914192926.1591-1-drifabdelmalekmohamedsaid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914192926.1591-1-drifabdelmalekmohamedsaid@gmail.com>
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 1DEFB1F816
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[7ff3adde89dd795ad4c4];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO

On Mon 14-09-26 20:29:26, Drif Abdelmalek Mohamed Said wrote:
> syzbot reported:
> 
>     BUG: KMSAN: uninit-value in dentry_string_cmp fs/dcache.c:291 [inline]
>     BUG: KMSAN: uninit-value in dentry_cmp fs/dcache.c:322 [inline]
>     BUG: KMSAN: uninit-value in __d_lookup_rcu+0x37d/0x5e0 fs/dcache.c:2522
> 
>      dentry_string_cmp fs/dcache.c:291 [inline]
>      dentry_cmp fs/dcache.c:322 [inline]
>      __d_lookup_rcu+0x37d/0x5e0 fs/dcache.c:2522
>      lookup_fast+0x194/0xa40 fs/namei.c:1854
>      lookup_fast_for_open fs/namei.c:4545 [inline]
>      open_last_lookups fs/namei.c:4579 [inline]
>      path_openat+0x9ef/0x6540 fs/namei.c:4856
>      do_file_open+0x2aa/0x680 fs/namei.c:4888
>      do_sys_openat2+0x17c/0x390 fs/open.c:1395
>      do_sys_open fs/open.c:1401 [inline]
>      __do_sys_openat fs/open.c:1417 [inline]
>      __se_sys_openat fs/open.c:1412 [inline]
>      __x64_sys_openat+0x240/0x300 fs/open.c:1412
>      x64_sys_call+0x2445/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:258
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>      do_syscall_64+0x15d/0x3c0 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was stored to memory at:
>      copy_name fs/dcache.c:3031 [inline]
>      __d_move+0xd29/0x21f0 fs/dcache.c:3099
>      d_move+0x71/0xf0 fs/dcache.c:3147
>      vfs_rename+0x2619/0x2770 fs/namei.c:6085
>      filename_renameat2+0xa59/0x1230 fs/namei.c:6188
>      __do_sys_rename fs/namei.c:6232 [inline]
>      __se_sys_rename+0xc5/0x5c0 fs/namei.c:6228
>      __x64_sys_rename+0x78/0xb0 fs/namei.c:6228
>      x64_sys_call+0x329/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:83
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63
>      do_syscall_64+0x15d/0x3c0 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>      slab_post_alloc_hook mm/slub.c:4617 [inline]
>      slab_alloc_node mm/slub.c:4939 [inline]
>      kmem_cache_alloc_lru_noprof+0x376/0x1230 mm/s
>      __d_alloc+0x52/0x9f0 fs/dcache.c:1902
>      d_alloc+0x57/0x300 fs/dcache.c:1981
>      lookup_one_qstr_excl+0x19d/0x7a0 fs/namei.c:1806
>      __start_renaming+0x341/0x850 fs/namei.c:3888
>      filename_renameat2+0x625/0x1230 fs/namei.c:6163
>      __do_sys_rename fs/namei.c:6232 [inline]
>      __se_sys_rename+0xc5/0x5c0 fs/namei.c:6228
>      __x64_sys_rename+0x78/0xb0 fs/namei.c:6228
>      x64_sys_call+0x329/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:83
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63
>      do_syscall_64+0x15d/0x3c0 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The race happens between a concurrent open() and rename() of the same
> path.  __d_alloc() initializes only the name itsel
> of the inline buffer; the tail in between is left uninitialized.
> copy_name(), called from rename(), copies the enti
> including that uninitialized tail - into the moved dentry.  Meanwhile
> __d_lookup_rcu(), called from open(), is an optimi
> it checks d_name.hash_len first and leaves the seqcount retry to its
> caller, so a lookup of the old (longer) name racin
> compares with a stale length.  While copy_name() is rewriting the name
> in place, the walker can transiently step past the
> terminating NUL and read bytes from the uninitialized tail, which KMSAN
> reports.
> 
> The race is benign by design - the read stays in bounds and the lookup
> result is discarded by the seqcount retry - but th
> is real.  Fix it by zeroing the entire inline buffer in __d_alloc(),
> so every byte a racy walker can touch is defined;
> past a mid-rewrite name now simply stops at a NUL.
> 
> Reported-by: syzbot+7ff3adde89dd795ad4c4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7ff3adde89dd795ad4c4
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>

Firstly, the lines in the changelog are weirdly truncated so it is barely
readable. Please fix that. Secondly, I don't think it is reasonable to
impose additional cost of zeroing on this hot path only to fix harmless
KMSAN warning. So if we can somehow annotate this to silence KMSAN then
that would be a way to go in my opinion.

								Honza

> ---
> v2:
>   - Screwed up by using memcpy in v1, fixed it here by using memset, only change
>  fs/dcache.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 1b1a81f10da6..730571e92af8 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1910,12 +1910,17 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  		return NULL;
>  
>  	/*
> -	 * We guarantee that the inline name is always NUL-terminated.
> -	 * This way the memcpy() done by the name switching in rename
> -	 * will still always have a NUL at the end, even if we might
> -	 * be overwriting an internal NUL character
> +	 * Fully initialize the inline name buffer.  copy_name() and
> +	 * swap_names() copy d_shortname in its entirety, so any
> +	 * uninitialized tail would propagate to the other dentry, and
> +	 * __d_lookup_rcu() may transiently read any byte of the inline
> +	 * name while rename() rewrites it in place.
> +	 *
> +	 * This also keeps the inline name NUL-terminated: the name
> +	 * switching in rename will still always have a NUL at the end,
> +	 * even if we might be overwriting an internal NUL character.
>  	 */
> -	dentry->d_shortname.string[DNAME_INLINE_LEN-1] = 0;
> +	memset(dentry->d_shortname.string, 0, DNAME_INLINE_LEN);
>  	if (unlikely(!name)) {
>  		name = &slash_name;
>  		dname = dentry->d_shortname.string;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
