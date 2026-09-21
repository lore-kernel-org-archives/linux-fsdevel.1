Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C742E8E6;
	Mon, 21 Sep 2026 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978387; cv=none; b=RZfEOJ4d/93MNIac6CPVyz66RIsWO1xWnPAj/YrzOrcspsULm8HmwUENu6I7aZWU8fL7i823E6qUKWsW9waETQmu8ZozdONSghHJO2XWaOXDzr/iaKRqAcbkHRDen04X9V+QwVmAxD5MSYyf4XBOVAykmIsm9WxrjezlrHS+Zf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978387; c=relaxed/simple;
	bh=7ubHUwnQgeZwJTdMCVBpAHpRZgp5fm9qQNJUxYSkBGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E52YuADLyTEmzt0LUxtf8S8o8UL2Aj+ag5iij2P59w8hb+L2v//2dy0AlU1VQV6AqqUmaebF8EAqqT/W738dxzuoooniKwxOgu4VaOfDtaRFgPih8JsmorTrWPVAlRTF1xTpiJw4SGKV7R6Nwvy1XJOV8FYHGC7tNfb8s7s1BZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZLdpa1L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xpr6TW7E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l0hJ/V/M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vwJCUJg0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZLdpa1L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xpr6TW7E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l0hJ/V/M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vwJCUJg0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 124831F7CD;
	Mon, 21 Sep 2026 08:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789978379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhSxmv/SAAAv5T3gGmBqPT13cth57UvtsxdAPpNlmGs=;
	b=2ZLdpa1LLgLQzDxr+ZeYoHDR3Nd3879OJ+kPAJqjQ/I3MYSkwzaBZ8z4jTFfJRJNbkdIOG
	+wx1o+h77p4IKObD1t9Z0WY1th6H9pg3AnUFMSrRsTC8mfiPG5UZjOh844cHf9ipnkxIWT
	1uttao5Lx/mg5SJcoJWDSiz7RPE2eHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789978379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhSxmv/SAAAv5T3gGmBqPT13cth57UvtsxdAPpNlmGs=;
	b=Xpr6TW7E4SIycmwpOesib2/mG9x20EmrlYLv3pCzhDlx7+H+ZhhTnbB+DiHLtvXU/qZYuv
	mAJyveHF8VUcfyCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="l0hJ/V/M";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vwJCUJg0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789978375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhSxmv/SAAAv5T3gGmBqPT13cth57UvtsxdAPpNlmGs=;
	b=l0hJ/V/MJgK59lL5Ttv1j1NErlRj/GWjdsN+MLwvJHgwC0nDUKTpb/JR5VJAwHuwStnhY2
	QVCDwjzOqXz77DNrTHze57nhohb1MXDqbyfmv2WWWm+9I1ZwoyynoOQniDkKHl42enHY+H
	6MlVla02ZuHs7mbmFv4kh3TqVFYa7qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789978375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhSxmv/SAAAv5T3gGmBqPT13cth57UvtsxdAPpNlmGs=;
	b=vwJCUJg0A5bEvRbRGHCA8sww2gnMoG8Yvn/W/iQmzdC8/dtqVMtZpE61ZoNGv7hdX6Z2Zy
	ChpgcrNjrA4LJRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1AB11368D;
	Mon, 21 Sep 2026 08:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +/RnJQbnsGosIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 21 Sep 2026 08:12:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 478ACA13D5; Mon, 21 Sep 2026 10:12:54 +0200 (CEST)
Date: Mon, 21 Sep 2026 10:12:54 +0200
From: Jan Kara <jack@suse.cz>
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7ff3adde89dd795ad4c4@syzkaller.appspotmail.com, glider@google.com, dvyukov@google.com
Subject: Re: [PATCH v3] dcache: unpoison the inline name buffer in __d_alloc()
Message-ID: <b3thqgx2tuxt3afjj3ceok2lr4aotjyzn7r6dgoozjey5c7qyd@zfr5n77z7lmz>
References: <20260914192926.1591-1-drifabdelmalekmohamedsaid@gmail.com>
 <20260918224204.3056-1-drifabdelmalekmohamedsaid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918224204.3056-1-drifabdelmalekmohamedsaid@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 124831F7CD
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[7ff3adde89dd795ad4c4];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email,suse.cz:dkim,suse.cz:email,suse.com:email,syzkaller.appspot.com:url]
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Fri 18-09-26 23:42:04, Drif Abdelmalek Mohamed Said wrote:
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
> The race is between a concurrent open() and rename() of the same path.
> 
> __d_alloc() only stores the name itself and its terminating NUL, so the
> rest of the inline buffer (d_shortname, DNAME_INLINE_LEN bytes) is left
> uninitialized.  copy_name(), called from rename(), copies that buffer as a
> whole, so the uninitialized tail is propagated into the dentry that is
> being moved.  Meanwhile __d_lookup_rcu(), called from open(), is an
> optimistic lockless lookup: it checks d_name.hash_len first and leaves the
> seqcount retry to its caller, so it can end up comparing against a dentry
> whose name a rename is rewriting in place, using a stale (longer) length.
> The comparison then runs past the terminating NUL and reads bytes of the
> uninitialized tail, which KMSAN reports.
> 
> The read is harmless by design: it stays inside the buffer, the name is
> still NUL-terminated, and the result is thrown away by the seqcount retry.
> It is not specific to KMSAN either - with CONFIG_DCACHE_WORD_ACCESS
> enabled the very same bytes are read by read_word_at_a_time(), which is
> __no_sanitize_or_inline and therefore invisible to KMSAN.  KMSAN builds
> only see the instrumented byte-at-a-time dentry_string_cmp() because
> CONFIG_DCACHE_WORD_ACCESS is disabled when KMSAN is enabled on x86:
> 
> commit 7cf8f44a5a1c ("x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS")
> 
> Zeroing the inline buffer would hide the report, but it would add a
> memset() to a hot allocation path just to initialize bytes that are never
> used as part of a name.  Instead, tell KMSAN the inline buffer is
> initialized: kmsan_unpoison_memory() compiles to nothing unless
> CONFIG_KMSAN is set, and doing it at allocation time is enough for every
> dentry, because copy_name() and swap_names() copy the whole buffer and
> thus propagate its shadow.
> 
> Reported-by: syzbot+7ff3adde89dd795ad4c4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7ff3adde89dd795ad4c4
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>

The --- separator should be here. I think Christian can fix this up on
commit. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Changes in v3:
> - Annotate for KMSAN instead of zeroing, as suggested in review: the read
>   is harmless, so unpoison the inline buffer in __d_alloc() with
>   kmsan_unpoison_memory() (a no-op unless CONFIG_KMSAN) rather than adding
>   a memset() to the dentry allocation path.
> - Document why only KMSAN builds report this at all: with
>   CONFIG_DCACHE_WORD_ACCESS the same read goes through
>   read_word_at_a_time(), which KMSAN does not instrument.
> - Rewrite the commit message; the previous one had several truncated
>   lines.
> ---
>  fs/dcache.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 1b1a81f10da6..a66be85f9d01 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1916,6 +1916,10 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  	 * be overwriting an internal NUL character
>  	 */
>  	dentry->d_shortname.string[DNAME_INLINE_LEN-1] = 0;
> +
> +	/* Racy __d_lookup_rcu() walk may read past the NUL; harmless */
> +	kmsan_unpoison_memory(dentry->d_shortname.string, DNAME_INLINE_LEN);
> +
>  	if (unlikely(!name)) {
>  		name = &slash_name;
>  		dname = dentry->d_shortname.string;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
