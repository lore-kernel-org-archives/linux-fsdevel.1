Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3A44C510;
	Mon,  7 Sep 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773836; cv=none; b=VxUqcvRr85xo343CMjDl0aCyN5slWWzJmlBx+vzLE0uStbDIrDNMkVW/l1wXRdN40JL4IbNg3/XrG9bEZHEHo+ud4ZcfExAZh3ZHifyS1m74jf5Y9YVJhicequU1Vz0hYIPR+YIfpcgMhkPPV4+Ptiu0sZ1OqiQqgKPFsUT7kiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773836; c=relaxed/simple;
	bh=co85iF7zay+xITR/ElFqLhJ/zDR3pdwuYKyo0Bwr2eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdcjFGqMhss/InIbzr2gtCr0fDN3+2oFoBqYqo1TI0Vgl87kJAwHZtdlwkSKSCeOexJ5X1cJAvrI2CyDaMQyiggt5nCJraMbspY/VunTl3HzJeoE1VITGtC/z3ufZfWe0RriO0pMcxfEqj8lMAtEF7aBqhBlFvmMwNFQsYMU4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W7zEZyUB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9OgZ2gZd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E3yHj+59; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iIBOrHnc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W7zEZyUB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9OgZ2gZd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E3yHj+59";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iIBOrHnc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E679A21987;
	Mon,  7 Sep 2026 09:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788773828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXTuRTcipgb8g59VzbVsmNoGwSaFBC6kHtxX4w47vMo=;
	b=W7zEZyUBZXQc9jOUh9eo/G3c7SVUVBz9oaC/fZvjORdr5ehB1CrQHv4SDva3LV49uGXH4u
	GJbb63yjFyHOkVSe98HN2cMGFNNavNkb8OZ9rmVF/xeruJoOhYrJJGBbM8RUXfOClG5RO5
	0PnOFk+e6T+8PHoaPx3bPU1mcz5t1U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788773828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXTuRTcipgb8g59VzbVsmNoGwSaFBC6kHtxX4w47vMo=;
	b=9OgZ2gZdg6KfSR0G9zJTmtZn2518XC6TAzzUfA4EZr2R9j6J9H+g2ZS89uhvMb/wmM31Wv
	605TNLd+S5DPY7Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E3yHj+59;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iIBOrHnc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788773824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXTuRTcipgb8g59VzbVsmNoGwSaFBC6kHtxX4w47vMo=;
	b=E3yHj+59b7l2w2A6fdsDhhIo1nwMVaVqq9HAuJLLF3R5k5/rK3C4cIlqt8hjITqrsmvZtO
	zV1WHIo/vPqR/ckBBaDaRgs33pBTMTczmyaDvTWLJK48vHvI5m/aYBx8C2dwGVJ9xAnFLr
	CDchNrccOVnztocN7dtwmKExwvbMJ3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788773824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXTuRTcipgb8g59VzbVsmNoGwSaFBC6kHtxX4w47vMo=;
	b=iIBOrHncTBiQqriIDApRf826f9WsW9u/zvKSlpshaliLmpK0RV6Az1RG04cBoyM/Y2A18+
	W70iAl2WqSyvJ4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A48FE13432;
	Mon,  7 Sep 2026 09:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id witfJ7+FnmrFBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Sep 2026 09:37:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A808A13B2; Mon, 07 Sep 2026 11:36:59 +0200 (CEST)
Date: Mon, 7 Sep 2026 11:36:59 +0200
From: Jan Kara <jack@suse.cz>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix typos in comments
Message-ID: <o7ixcy65sb3k6xniphvu4cq623shz6ww6etqrzp2lb4mggrjv2@tfdpte7untfk>
References: <20260907063252.21433-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907063252.21433-1-hemanth.selam@gmail.com>
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: E679A21987
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
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO

On Mon 07-09-26 12:02:52, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c                | 4 ++--
>  fs/coredump.c           | 2 +-
>  fs/fs-writeback.c       | 6 +++---
>  fs/inode.c              | 2 +-
>  fs/namespace.c          | 2 +-
>  include/linux/fs.h      | 2 +-
>  include/uapi/linux/fs.h | 2 +-
>  7 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index d78acc69f487..685525aef7a3 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -936,7 +936,7 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
>  
>  /*
>   * exit_aio: called when the last user of mm goes away.  At this point, there is
> - * no way for any new requests to be submited or any of the io_* syscalls to be
> + * no way for any new requests to be submitted or any of the io_* syscalls to be
>   * called on the context.
>   *
>   * There may be outstanding kiocbs, but free_ioctx() will explicitly wait on
> @@ -1280,7 +1280,7 @@ static long aio_read_events_ring(struct kioctx *ctx,
>  	 * The mutex can block and wake us up and that will cause
>  	 * wait_event_interruptible_hrtimeout() to schedule without sleeping
>  	 * and repeat. This should be rare enough that it doesn't cause
> -	 * peformance issues. See the comment in read_events() for more detail.
> +	 * performance issues. See the comment in read_events() for more detail.
>  	 */
>  	sched_annotate_sleep();
>  	mutex_lock(&ctx->ring_lock);
> diff --git a/fs/coredump.c b/fs/coredump.c
> index ac3cd74808c6..2e8f247efd65 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1047,7 +1047,7 @@ static bool coredump_write(struct core_name *cn,
>  	cn->core_dumped = binfmt->core_dump(cprm);
>  	/*
>  	 * Ensures that file size is big enough to contain the current
> -	 * file postion. This prevents gdb from complaining about
> +	 * file position. This prevents gdb from complaining about
>  	 * a truncated file if the last "write" to the file was
>  	 * dump_skip.
>  	 */
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e744f9f9d43f..f303936446da 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -233,7 +233,7 @@ void wb_wait_for_completion(struct wb_completion *done)
>   * Parameters for foreign inode detection, see wbc_detach_inode() to see
>   * how they're used.
>   *
> - * These paramters are inherently heuristical as the detection target
> + * These parameters are inherently heuristical as the detection target
>   * itself is fuzzy.  All we want to do is detaching an inode from the
>   * current owner if it's being written to by some other cgroups too much.
>   *
> @@ -248,7 +248,7 @@ void wb_wait_for_completion(struct wb_completion *done)
>   * to 16 slots.  To avoid tiny writes from swinging the decision too much,
>   * writes smaller than 1/8 of avg size are ignored.
>   */
> -#define WB_FRN_TIME_SHIFT	13	/* 1s = 2^13, upto 8 secs w/ 16bit */
> +#define WB_FRN_TIME_SHIFT	13	/* 1s = 2^13, up to 8 secs w/ 16bit */
>  #define WB_FRN_TIME_AVG_SHIFT	3	/* avg = avg * 7/8 + new * 1/8 */
>  #define WB_FRN_TIME_CUT_DIV	8	/* ignore rounds < avg / 8 */
>  #define WB_FRN_TIME_PERIOD	(2 * (1 << WB_FRN_TIME_SHIFT))	/* 2s */
> @@ -259,7 +259,7 @@ void wb_wait_for_completion(struct wb_completion *done)
>  #define WB_FRN_HIST_THR_SLOTS	(WB_FRN_HIST_SLOTS / 2)
>  					/* if foreign slots >= 8, switch */
>  #define WB_FRN_HIST_MAX_SLOTS	(WB_FRN_HIST_THR_SLOTS / 2 + 1)
> -					/* one round can affect upto 5 slots */
> +					/* one round can affect up to 5 slots */
>  #define WB_FRN_MAX_IN_FLIGHT	1024	/* don't queue too many concurrently */
>  
>  /*
> diff --git a/fs/inode.c b/fs/inode.c
> index ba7da39be4a3..817fd5254495 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1771,7 +1771,7 @@ EXPORT_SYMBOL(ilookup);
>   * function must never block --- find_inode() can block in
>   * __wait_on_freeing_inode() --- or when the caller can not increment
>   * the reference count because the resulting iput() might cause an
> - * inode eviction.  The tradeoff is that the @match funtion must be
> + * inode eviction.  The tradeoff is that the @match function must be
>   * very carefully implemented.
>   */
>  struct inode *find_inode_nowait(struct super_block *sb,
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 1ecd96c918b3..f45233f425f7 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4115,7 +4115,7 @@ int path_mount(const char *dev_name, const struct path *path,
>  	if (flags & SB_MANDLOCK)
>  		warn_mandlock();
>  
> -	/* Default to relatime unless overriden */
> +	/* Default to relatime unless overridden */
>  	if (!(flags & MS_NOATIME))
>  		mnt_flags |= MNT_RELATIME;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f9d1e05e8ae6..05d05bb9c951 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1436,7 +1436,7 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
>   * @idmap: idmap of the mount the inode was found from
>   * @inode: inode to map
>   *
> - * Return: whe inode's i_uid mapped down according to @idmap.
> + * Return: the inode's i_uid mapped down according to @idmap.
>   * If the inode's i_uid has no mapping INVALID_VFSUID is returned.
>   */
>  static inline vfsuid_t i_uid_into_vfsuid(struct mnt_idmap *idmap,
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 34c6f219462a..a46c33692aa2 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -88,7 +88,7 @@ struct fstrim_range {
>   * We include a length field because some filesystems (vfat) have an identifier
>   * that we do want to expose as a UUID, but doesn't have the standard length.
>   *
> - * We use a fixed size buffer beacuse this interface will, by fiat, never
> + * We use a fixed size buffer because this interface will, by fiat, never
>   * support "UUIDs" longer than 16 bytes; we don't want to force all downstream
>   * users to have to deal with that.
>   */
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
