Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051648;
	b=dpfZT1K/U1/vOgdYUrBNiI6U/Nld3zrrPMsxbfF5DIhlG2Z7luirA4FukJgqvf/+3+IU
	 A2jLzF9XZWki/XeFRkcoSWs0xPcX66PmJU00hLzL4+ZNWorozKuxf1kSQIgFpXLVgj582
	 HeWZBI1WqmQQZtvcyFINPsE7GPb67g4/wRmxIzk0RrBtkPdNCsLd8nWxjIvuRybNpHX/G
	 l5E7RNsc+ccfCQAxZjXRZBHuVHiuovhyBy1P6rL7ThTI76U1QmJKoNAhbshTjA2QucP3k
	 LiF0mStcS0EJO8HwPBzlID1bFzjT7c4o1pIjZOc+tU//4/GVVrlBNMnxacqtJNWaWNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051648;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=pf3S30pSW0zRv1AOVALzxFmv0Ce8aBbZC2HWrVwtQ0k=;
	b=n3rP2adYulaFsDe9OVR+BdGJiVSEB6d3XQZeyuaAwRTnRNkn6D+bX78SAFe2jwPQg3ED
	 4Osg7cQoYyFBxMeZVJ18ekUSG5mxuAPHthKsaTNC32fmstsLSMM51/dwLZn6ZXRc/mLm4
	 2+Za+HL3jpoQx8Ki3yvHcKTPbC0h8lXGzA0W5iFMjvy0lmcbakZemEWOP1FdmT8RAUHIj
	 CKmDPHWXLFOTZVA8GPWAcQ0wwJqsDNfkFZiHUAJxRzZFLt2luoL7aqldHyLxB+ErVG55j
	 31yFx5q3SS1OC2ESQ3oU9myJtAa5mCUwkunRL9cRNfkD/t8I30e4cSu/Ju7Cu3F2saA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=of181jWl;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8QG2qy3k;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=vmUyTTmL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ksiUWbKe;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF8606A31E;
	Mon, 26 Oct 2026 21:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02DF8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=of181jWl;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8QG2qy3k;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=vmUyTTmL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ksiUWbKe
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 310B41F457;
	Mon, 26 Oct 2026 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793051646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pf3S30pSW0zRv1AOVALzxFmv0Ce8aBbZC2HWrVwtQ0k=;
	b=of181jWlE24V1YchHTnAbfa6DvBROfm21FOhrvZxE3/WE3ub/jzfqztQ7ZEyVUzvmYHWLf
	Wk5QuyNTssa8db2DAeGfRinabyX/tcaMR13itFnGHT0KkwbGDVnzzO8QJ8TY8gNOif6JlJ
	hrwoI+QoC6qWwvDLZ+exOZNyqS46gd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793051646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pf3S30pSW0zRv1AOVALzxFmv0Ce8aBbZC2HWrVwtQ0k=;
	b=8QG2qy3kxjDS8gWtfiZZb82xl4IPeo20JBGmqFR3Aedrls2FqL2P9OK/lzC9kOWh8MhaQo
	eitJKcOutKC5mkBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vmUyTTmL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ksiUWbKe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793051645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pf3S30pSW0zRv1AOVALzxFmv0Ce8aBbZC2HWrVwtQ0k=;
	b=vmUyTTmLdaZAwBYgjkw/QyA2Xjjfz8UchViKglAwbb7oYI/lpYIQAwW5JECH48zIBNNHCX
	klnjCNBQNqophVhLIEvEy+tIg0u7iE0Yh3OXfSNVXEy59dv+g6abh/u6eB7UhmXzjV8s4g
	UinrVww4MeOy7BUhnF5bkqypVkcIQSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793051645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pf3S30pSW0zRv1AOVALzxFmv0Ce8aBbZC2HWrVwtQ0k=;
	b=ksiUWbKeDvuES6KhGnl/L/nFOP8h6joc4JaID0sI6C7U2W/N2hsN5czxgK9P2fq25VfY5V
	+qMllW8R0lWikNCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D807F13408;
	Mon, 26 Oct 2026 21:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iOpCK/zL32onCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 21:54:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 612ACA1419; Mon, 26 Oct 2026 22:54:04 +0100 (CET)
Date: Mon, 26 Oct 2026 22:54:04 +0100
From: Jan Kara <jack@suse.cz>
To: Aurelien DESBRIERES <aurelien@hackers.camp>
Cc: jack@suse.cz, brauner@kernel.org, willy@infradead.org, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	aurelien.desbrieres@gmail.com
Subject: Re: [PATCH] buffer: warn when a buffer is attached to a second mmb
Message-ID: <lmns74nam22ljcd4lhdyoel3vvxmhf6gakggmbtxbmkpgzhiva@xqlyexvgkwcy>
References: <q472nkbfcfdumbxm3cebfnnmueqyl6uhhnper5t6e2cxajpvtu@7prjjo7k6ia3>
 <20261026213626.301480-1-aurelien@hackers.camp>
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
In-Reply-To: <20261026213626.301480-1-aurelien@hackers.camp>
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,infradead.org,zeniv.linux.org.uk,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,hackers.camp:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -11.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 310B41F457

On Mon 26-10-26 22:36:26, Aurelien DESBRIERES wrote:
> mmb_mark_buffer_dirty() tracks a buffer on one mapping_metadata_bhs at
> most. The per-mmb lock does not protect a buffer that changes lists,
> and mmb_sync() clears b_mmb for a moment under its own lock, so a
> filesystem that attaches a buffer shared by several inodes to each
> inode's list in turn corrupts b_assoc_buffers eventually. With
> CONFIG_DEBUG_LIST the list_del is refused and mmb_sync() spins on a
> list that never empties, holding mmb->lock: seen with beamfs under
> dbench (xfstests generic/241) as list_del corruption, a soft lockup and
> a node lost to the OOM killer, with nothing naming the filesystem.
> 
> Warn once when a buffer already tracked by another mmb is marked dirty
> through a second one, so that the misuse is named at its first
> occurrence rather than at the corruption it leads to. A corrupted
> volume in which two inodes claim the same block reaches this as well;
> the cmpxchg below keeps the lists sound in that case, and the warning
> then says which filesystem believed its block map.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/linux-fsdevel/q472nkbfcfdumbxm3cebfnnmueqyl6uhhnper5t6e2cxajpvtu@7prjjo7k6ia3/
> Assisted-by: LLM
> Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>

Thanks! Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Tested on vfs.all with beamfs, x86_64 guest, 4 CPUs:
> 
> - the module as it was before our fix, attaching the shared bitmap
>   block to each allocating inode's list in turn: the warning fires at
>   boot, 8.6 s in, on the first truncate that frees blocks of a file
>   another inode had allocated, long before the dbench run that used
>   to corrupt the list:
> 
>     WARNING: fs/buffer.c:639 at mmb_mark_buffer_dirty+0x46/0xd0, CPU#3: S01hostname-cmd/111
>      beamfs_write_bitmap_block+0x191/0x1c0
>      beamfs_inline_free_blocks_from+0x64/0x390
>      beamfs_inline_setattr+0x127/0x4c0
>      notify_change+0x33b/0x520
>      do_truncate+0xbf/0xf0
>      path_openat+0x8c1/0xaa0
> 
> - the module with the shared buffers on one superblock list: no
>   warning at boot or under the filesystem's own tests.
> 
>  fs/buffer.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 1dc933ba6925..e503a7ed9c37 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -627,6 +627,16 @@ void write_boundary_block(struct block_device *bdev,
>  void mmb_mark_buffer_dirty(struct buffer_head *bh,
>  			   struct mapping_metadata_bhs *mmb)
>  {
> +	struct mapping_metadata_bhs *cur = READ_ONCE(bh->b_mmb);
> +
> +	/*
> +	 * A buffer is tracked by one mmb at most. The per-mmb lock does
> +	 * not cover a buffer that changes lists, and mmb_sync() clears
> +	 * b_mmb for a moment under its own lock, so a filesystem that
> +	 * attaches a buffer to a second mmb corrupts b_assoc_buffers
> +	 * sooner or later. Name it here, before the lists do.
> +	 */
> +	WARN_ON_ONCE(cur && cur != mmb);
>  	mark_buffer_dirty(bh);
>  	if (!bh->b_mmb) {
>  		spin_lock(&mmb->lock);
> 
> base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
