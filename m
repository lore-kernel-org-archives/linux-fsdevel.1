Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669087;
	b=H9elo6zog80JhFKiV5sO2gbZeVQGz+kQKfpVbIYEJ5suI4AUB4vmTv+4H5dh8zHVokfc
	 TjAqSqlqQg/r2VCzLle7pXfVF2JQiofQhN0yGmJcLyxLBlgRhmqKDtqxG6vYpy8iQZS5z
	 P7O2Y7HPuXh5y0t6dj/9QUwc9geT99jBsC2XKWRRoR4p+sDNfUEqEWc0rD9J0uzTnltoP
	 Guj9JW59BEatVbqT3lwOLtdtCMSjtfv51rg2zzN/da/OF98IwiG1Cd9upwkQRiuEDstJl
	 mtMDF1SK+lZFUFpwxUGx2vsfZqtEW+t48GsRPgSNF9dtVQT6XWedTU0/jPlgo7BxOLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669087;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=7+QlMJtzdTUiaiMniT1YJj/g7FxrcjRnFfXwAlxNdpE=;
	b=HRlc/jjfFWCrKj6nzWhCxPfLzFAApXiU4f2iokvN+GM6s7l6onUeT1s12PLKxhKjP4Dy
	 9wyuZGCcC0agiifbF3zzdC9E5E3P7RcZqUNGdLahyXHfyuMB9MpZsLV+yyV3EPin76/a+
	 x9eanOwI1rgPoPirSJLTil5FJdrYtD6DnENE9olDda8mkVMbMPjKn3K5ooCLfPJayek4x
	 fRL/IeveGuP+iCpeU84pYicu1c6ozU6sBG3yJThgLN3PMNehGfpw7uTmxcGZFzaXTmK8a
	 8h975zSjl1OpFoO4G64HPG/Tyf1SauCjvnaT/NMDBPt2GyXdKSgvilcYabnBvUZejEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YZqXS8xB;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NkuvhItb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YZqXS8xB;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NkuvhItb;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682A606A319;
	Thu, 22 Oct 2026 11:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7682A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YZqXS8xB;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NkuvhItb;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YZqXS8xB;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NkuvhItb
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5E9F220D3;
	Thu, 22 Oct 2026 11:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792669084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+QlMJtzdTUiaiMniT1YJj/g7FxrcjRnFfXwAlxNdpE=;
	b=YZqXS8xBsH92TnIuuGOOGOHPczGqHcNrQ/jcUU/kppQFj45I8SYdzFb9r3Vbo6tsDvdgtQ
	d4RcUrId0dAPJGiqA/6Isvvj59MJfVyQHQB4YPwEaaevKA2sysza5hwcruRwfkBuST/qfr
	sKbOUij96SqyXEuhNSFc69BMVstkU1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792669084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+QlMJtzdTUiaiMniT1YJj/g7FxrcjRnFfXwAlxNdpE=;
	b=NkuvhItbYpR4cTQeyUF/6cHCgBX+2zvQpvSJA2H8P1cDjII2zRVaSfj6B/xHJTY6MREoDS
	1NuHD5O6G6EjlcAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792669084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+QlMJtzdTUiaiMniT1YJj/g7FxrcjRnFfXwAlxNdpE=;
	b=YZqXS8xBsH92TnIuuGOOGOHPczGqHcNrQ/jcUU/kppQFj45I8SYdzFb9r3Vbo6tsDvdgtQ
	d4RcUrId0dAPJGiqA/6Isvvj59MJfVyQHQB4YPwEaaevKA2sysza5hwcruRwfkBuST/qfr
	sKbOUij96SqyXEuhNSFc69BMVstkU1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792669084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+QlMJtzdTUiaiMniT1YJj/g7FxrcjRnFfXwAlxNdpE=;
	b=NkuvhItbYpR4cTQeyUF/6cHCgBX+2zvQpvSJA2H8P1cDjII2zRVaSfj6B/xHJTY6MREoDS
	1NuHD5O6G6EjlcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B32B133F3;
	Thu, 22 Oct 2026 11:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hadAFpz12WpYdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 11:38:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 099CDA1417; Thu, 22 Oct 2026 13:38:04 +0200 (CEST)
Date: Thu, 22 Oct 2026 13:38:04 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] fs: make a mount waiting on another mount killable
Message-ID: <tmw22jj2hn6g6lklme2j3rsfjvmstzpoicvibvmmv6sivd66oj@nhc4lng25gti>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
 <20261021-b4-super-lock-unborn-v1-1-0265eddb6dee@toxicpanda.com>
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
In-Reply-To: <20261021-b4-super-lock-unborn-v1-1-0265eddb6dee@toxicpanda.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 21-10-26 16:46:57, Josef Bacik wrote:
> A superblock is put on the lists by sget_fc() and becomes usable when
> vfs_get_tree() sets SB_BORN, after the filesystem has read what it needs
> from its device or its server.  If that doesn't answer, this takes forever.
> 
> Somebody else mounting the same thing finds that superblock in sget_fc()
> and waits in grab_super() for it to be born, to share it, or to die, to
> make its own.  It has to.  But it does so in super_lock(), which can't be
> killed, so one stuck mount collects every later attempt.
> 
> mount(2) and fsconfig(2) can fail at this point, as they already do when
> they are killed while waiting for a superblock to die.
> 
> Add super_lock_killable(), in which both the wait for SB_BORN and taking
> s_umount can be killed, and use it in grab_super().  It tells a superblock
> which is going away from a wait which was cut short, so it returns an int:
> 0 with the lock held, -ENOENT, or the error from the wait.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

...

> +/**
> + * super_lock - wait for superblock to become ready and lock it
> + * @sb: superblock to wait for
> + * @excl: whether exclusive access is required
> + *
> + * If the superblock has neither passed through vfs_get_tree() or
> + * generic_shutdown_super() yet wait for it to happen. Either superblock
> + * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
> + * woken and we'll see SB_DYING.
> + *
> + * A superblock which is being shut down is not waited for, see
> + * super_wait_shutdown() and super_wait_shutdown_killable() for that.
> + *
> + * The caller must have acquired a temporary reference on @sb->s_passive.
> + *
> + * Return: The function returns true if SB_BORN was set and with
> + *         s_umount held. The function returns false if the superblock
> + *         is being shut down or SB_DYING was set and without s_umount
> + *         held.
> + */
> +static __must_check bool super_lock(struct super_block *sb, bool excl)
> +{
> +	return !super_lock_common(sb, excl, false);
> +}
> +
> +/**
> + * super_lock_killable - killable super_lock()
> + * @sb: superblock to wait for
> + * @excl: whether exclusive access is required
> + *
> + * Only for callers which give up altogether when they are killed.
> + *
> + * The caller must have acquired a temporary reference on @sb->s_passive.
> + *
> + * Return: 0 if SB_BORN was set and with s_umount held. Without s_umount held,
> + *         -ENOENT if the superblock is being shut down or SB_DYING was set,
> + *         -EINTR or -ERESTARTSYS if the task was killed.
> + */
> +static __must_check int super_lock_killable(struct super_block *sb, bool excl)
> +{
> +	return super_lock_common(sb, excl, true);
>  }

IMHO it is subtle that super_lock() and super_lock_killable() have
different convention for the return value (bool vs int). I'd just make both
return int and 0 on success. There aren't that many users so the change
won't even be that painful... Thanks.

								Honza
>  
>  /**
> @@ -674,25 +722,27 @@ EXPORT_SYMBOL(deactivate_super);
>   * sb->kill() and be marked as SB_DEAD.
>   *
>   * Return: 0 if an active reference could be acquired, -EAGAIN if the
> - *         superblock is gone and the caller should look again,
> - *         -ERESTARTSYS if the task was killed while waiting for that.
> + *         superblock is gone and the caller should look again, -EINTR or
> + *         -ERESTARTSYS if the task was killed while waiting for either.
>   */
>  static int grab_super(struct super_block *sb)
>  {
> -	bool locked;
>  	int ret;
>  
>  	refcount_inc(&sb->s_passive);
>  	spin_unlock(&sb_lock);
> -	locked = super_lock_excl(sb);
> -	if (locked) {
> +	ret = super_lock_killable(sb, true);
> +	if (!ret) {
>  		if (atomic_inc_not_zero(&sb->s_active)) {
>  			put_super(sb);
>  			return 0;
>  		}
>  		super_unlock_excl(sb);
> +		ret = -ENOENT;
>  	}
> -	ret = wait_var_event_killable(&sb->s_flags, super_flags(sb, SB_DEAD));
> +	if (ret == -ENOENT)
> +		ret = wait_var_event_killable(&sb->s_flags,
> +					      super_flags(sb, SB_DEAD));
>  	put_super(sb);
>  	return ret ? ret : -EAGAIN;
>  }
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
