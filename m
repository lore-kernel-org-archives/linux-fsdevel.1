Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594864;
	b=bn7vJchRTC9jMUGyhbzzR2inknJ1oc49WmfgZUQ+jvSs0EjbYgOMwDiTCzg4/bwoydV2
	 nOBrK/IKXNCn4BA5oJ/5fWVFe+xe7qRy91XQP5jOS96g2UzWjLDe3+CFNKwXx9Q7OoBH/
	 QX4ciS9LEHBFu/V5rg5aQqmjmzKEWnj6j0Eiwd1EF8OrqE0CBf7xCdf9U98Or0Hbq9Nvf
	 UwS/iu3Z4N6cqy80R4p4+ZTj2QPLTdlxPU0tTlmVT+eT+ZqHPc3neGKhCy7ksU1Y27X+1
	 1EmMGmnJcjsK28nDuhLaGsMuQq5HEQYSh95SQUhe6tVPU7QxO8mZnA7thde4HWNfeBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594864;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=tRot9ckE5IeuuxQhmUQ5VAPpviDIfa2ZpGidw3QZugY=;
	b=JdWmDqBleoBQGENA8mTJnWu7ywxzszSpC7cYZpz7HHVfySpjZ/d7UwzuBPZkVrt94BtF
	 1pWI0osvcxIfmFp35cOFtpc4gEz1BgxwWq+ZhyQEKeLtQlGj1nm2WdfvL+39shZ4embWe
	 nyQpkSKKiwsGn5FYmSxjvzACTuTjK6hdPFSiXPsFjfarNoHe4K/XmIwHpVliwl4xEAqh+
	 fSQAA30frw2qeXgTsXS14RcKLF49hBbs5pU48/4uQQI4NoJGvoHGJQ/Kk+SpAiuRdDe01
	 lZCAw3MpVNa5sjRAYwPqid+wdGMPukk53K8QGy7nvwvOCzEGUvSAhGt75lzHAnLqGrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GInMaisL;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XwKWmzhH;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=03rM78bH;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gkZpgIKo;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E3606A31B;
	Wed, 21 Oct 2026 15:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A08E3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GInMaisL;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XwKWmzhH;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=03rM78bH;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gkZpgIKo
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA10B1FABD;
	Wed, 21 Oct 2026 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792594862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRot9ckE5IeuuxQhmUQ5VAPpviDIfa2ZpGidw3QZugY=;
	b=GInMaisLjC1lr7T+GoH4M/h691CR0hNv0+uzAxd74WiWazoSjoQoMtNJ2mR0aQ7EhNdhID
	qAs7GJnKgFWTpGdwwdyT0NvIIr2EwG7pUOsq1tcfVm25tINXYM5ap1ngMxg+5GjkqidCr6
	IIfntZz+ZdsJeur+rJeALRUktZYvgYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792594862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRot9ckE5IeuuxQhmUQ5VAPpviDIfa2ZpGidw3QZugY=;
	b=XwKWmzhHPwiMFAsMzmkKZmZzpdx8UjioJMtzRQtxY9DIRC4l3epapu5VrhxHDRk3D58H3T
	nQ35XuQxSZff+hAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=03rM78bH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gkZpgIKo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792594856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRot9ckE5IeuuxQhmUQ5VAPpviDIfa2ZpGidw3QZugY=;
	b=03rM78bHl/9qSCJI1sSvmVYtOdWikLwLXuXztOqzvGGrfLNVA1rThQgGOHqkqmPnTL3FGe
	Z99Negluwr7efJoICRPRqD0EIvoyOYtBXeiAP986Ff7WTMiAkbXLpdy3vmDGR9b6DAbMx9
	nKo5onB581+5uSocHuqN5MWLhR2DbjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792594856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRot9ckE5IeuuxQhmUQ5VAPpviDIfa2ZpGidw3QZugY=;
	b=gkZpgIKodHnx8263vzcc7K4VRQ1d7izNHKB+Pva74y5SBuOMiDfyzbL/KSfynf97c0l2yx
	FMdsuhtzv/CNFUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB9C4134A5;
	Wed, 21 Oct 2026 15:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AHyfJajT2GpjdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 15:00:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4D227A13C6; Wed, 21 Oct 2026 17:00:52 +0200 (CEST)
Date: Wed, 21 Oct 2026 17:00:52 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] fs: don't sleep on s_umount of a superblock being
 shut down
Message-ID: <qzhzyunvo72hiitcg53ybb3nn6oph2vm4pd3f6kxdjkqinf6s5@akc5mffb4qke>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
 <20261021-b4-super-lock-dying-v1-4-2b35e86706ff@toxicpanda.com>
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
In-Reply-To: <20261021-b4-super-lock-dying-v1-4-2b35e86706ff@toxicpanda.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,toxicpanda.com:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: EA10B1FABD

On Wed 21-10-26 00:56:38, Josef Bacik wrote:
> A slow unmount holds up tasks which have no business with that filesystem.
> 
> deactivate_locked_super() drops the last active reference with s_umount
> held for writing.  generic_shutdown_super() then writes the filesystem
> out, evicts its inodes and calls ->put_super(), and only after all that
> sets SB_DYING and drops s_umount.  On a slow or unresponsive device this
> takes minutes, or forever.
> 
> super_lock() doesn't take s_umount if it sees SB_DYING, but for the whole
> of the above it isn't set yet.  So whoever walks the superblocks sleeps
> uninterruptibly on s_umount until the unmount is over, then finds SB_DYING
> set and is told that there is nothing here for them.  One stuck unmount
> this way takes along, among others, every
> 
>  - sync(2)
>  - write to /proc/sys/vm/drop_caches
>  - quotactl(Q_SYNC) without a device
>  - quotactl() and ustat() on that device
>  - BLKFLSBUF on that device
> 
> The outcome of that sleep is known when it starts.  s_active reaches zero
> only under s_umount, s_umount is then held until SB_DYING is set, and
> nobody gets a new active reference once it is zero.  Check s_active first
> and fail right away.
> 
> super_lock() and what is built on it are local to fs/super.c, so its users
> can be listed.
> 
> Those who need the unmount to be over wait for that on their own since the
> previous three patches:
> 
>  - sync(2) and BLKFLSBUF, which can now be killed while they wait
>  - the emergency sync and remount, from a workqueue
>  - fs_bdev_freeze(), fs_bdev_mark_dead() for an orderly removal and
>    filesystems_freeze(), for which nothing changes
> 
> sget_fc() waits for SB_DEAD in grab_super().
> 
> freeze_super(), thaw_super() and the second super_lock_excl() in
> do_thaw_all_callback() are called with an active reference held and never
> see such a superblock.
> 
> That leaves drop_caches, quotactl(Q_SYNC) and delayed_superblock_init() in
> selinux through iterate_supers(), cifs through iterate_supers_type(),
> quotactl() and ustat() through user_get_super(), fs_bdev_mark_dead() for a
> device which is already gone, and thawing: fs_bdev_thaw(),
> filesystems_thaw() and the emergency thaw.  They have nothing to do on a
> superblock which is going away and promise nothing about it.  They carry
> on with the next one as they always did, only sooner.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 9baaaa3256b2..9f76b399f3fb 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -104,16 +104,29 @@ static bool super_flags(const struct super_block *sb, unsigned int flags)
>   * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
>   * woken and we'll see SB_DYING.
>   *
> + * A superblock which is being shut down is not waited for, see
> + * super_wait_shutdown() and super_wait_shutdown_killable() for that.
> + *
>   * The caller must have acquired a temporary reference on @sb->s_passive.
>   *
>   * Return: The function returns true if SB_BORN was set and with
> - *         s_umount held. The function returns false if SB_DYING was
> - *         set and without s_umount held.
> + *         s_umount held. The function returns false if the superblock
> + *         is being shut down or SB_DYING was set and without s_umount
> + *         held.
>   */
>  static __must_check bool super_lock(struct super_block *sb, bool excl)
>  {
>  	lockdep_assert_not_held(&sb->s_umount);
>  
> +	/*
> +	 * The last active reference is dropped with s_umount held, which
> +	 * stays held until SB_DYING is set, and there is no getting a new
> +	 * one.  All there is to find at the end of that wait is SB_DYING,
> +	 * and it can be a long one: the filesystem is written out first.
> +	 */
> +	if (!atomic_read(&sb->s_active))
> +		return false;
> +
>  	/* wait until the superblock is ready or dying */
>  	wait_var_event(&sb->s_flags, super_flags(sb, SB_BORN | SB_DYING));
>  
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
