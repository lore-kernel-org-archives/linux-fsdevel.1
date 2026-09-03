Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441E415B6C;
	Thu,  3 Sep 2026 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432064; cv=none; b=WDFodg3QcIeN+6uEaeTNl5yQCFOTSU6WeChJsbCcz9M0JPh/Mo7rj4EsZ+XPQ4ZMxAogF1AjMjLaAeW2LXeKiPbk/XsB3iZpKlfNydcqPL0i8n5WMe4c1EjASpLfFKeeviSgl4e9Su3yd2WBtDBICivFVsXWPipzM40HC+GcbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432064; c=relaxed/simple;
	bh=pjYrk+oEhP2JAyIypUnZXzeOAH1x7rsk9JNYsn4PFdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4olIzKU3i6t7mFpfQYDbfrKhphweAI/SwkeJEG6/axsoq59NAh7GmtydawdBV0Ah1YNlIahOca0IzWDSt6cFQO2hL8JBgcttFJSDCfqCMxhb472Q3aaPuoWcPI+VdHQPNTXhl7ecNWf2K5Rzjx/A6sqlpVxZ6PF65NzvuFx8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qujb3Iz1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=osa66p7/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=np5Gys8I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xf8mFPwV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qujb3Iz1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="osa66p7/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="np5Gys8I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xf8mFPwV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 328361FE27;
	Thu,  3 Sep 2026 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788432055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMhJVx8krsSQrkT6nrVmuvPRO8gUKluRoBkeXXRAgvg=;
	b=Qujb3Iz1ls/4zs9I3yDoJIUhIXwwj2gm/2qlYgozh+LQEeKXBU++UAaaTFIwrTFgbVA5Pg
	97YlzIhYFCirSsdd7hBlrs9u1oW/rRamLfnDmbGKxVXCO4lXZ7p2pGMGX3SA72AuGTgK98
	0jbug/aFzBIkvSdnpC1auIq2yT3L4JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788432055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMhJVx8krsSQrkT6nrVmuvPRO8gUKluRoBkeXXRAgvg=;
	b=osa66p7/njyJ5wmC8gcrRY8oxxQ70GNHb/C56LwoDxP0CvLv4Ghv/S1H9gdvsYh2hqcuTf
	EoE5M2P4hN36OKBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788432051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMhJVx8krsSQrkT6nrVmuvPRO8gUKluRoBkeXXRAgvg=;
	b=np5Gys8I/LsR79FepW6v8/30MNUIeeZtPYy+5RmxORfNNtXsKqe4068Hp/lh6jbzdmsEKa
	tUwFQFrJEGTqnM7JLZ+alpUyjtnCzGGRaYlYXgbqG4qxW988XMHjK6aQ96+jjj+SZolHHP
	EPe3AmDIY+YVkhfDpsx1AQ8e61lUvu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788432051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMhJVx8krsSQrkT6nrVmuvPRO8gUKluRoBkeXXRAgvg=;
	b=xf8mFPwVFv1Zg45A6mnA/wROHwlIZd62fanYRvShSzY+yYS4w0NByiwyHLIBKS+l0uZ3Lz
	Bw94yvhrKmvT0SAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13700136E6;
	Thu,  3 Sep 2026 10:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oQ+7BLNOmWo9LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Sep 2026 10:40:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A1BDEA13AC; Thu, 03 Sep 2026 12:40:42 +0200 (CEST)
Date: Thu, 3 Sep 2026 12:40:42 +0200
From: Jan Kara <jack@suse.cz>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Oleg Nesterov <oleg@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] super: remember whether freeze holds writer rwsems
Message-ID: <yly6lgithikpjfvmozn73zvcivoftko7ou6qozsf6xntaoi6yc@44aw3yj4i7rh>
References: <20260903060855.4610-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903060855.4610-1-kmehltretter@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Thu 03-09-26 08:08:55, Karl Mehltretter wrote:
> freeze_super() does not acquire the writer rwsems when the superblock is
> read-only. thaw_super_locked() currently decides whether to release them
> from the current SB_RDONLY flag. Filesystem error paths can change that
> flag between freeze and thaw without s_umount serialization.
> 
> If a writable freeze is followed by a forced read-only transition, thaw
> reports success but skips ->unfreeze_fs() and sb_freeze_unlock(). The
> superblock is marked unfrozen while all writer rwsems remain write-locked.
> Conversely, if a filesystem is read-only when frozen and SB_RDONLY is
> cleared before thaw, thaw can release rwsems that were never acquired.
> 
> Record whether a successful freeze acquired the writer rwsems and use that
> state during thaw instead of re-sampling SB_RDONLY.
> 
> Fixes: 8129ed29644b ("change sb_writers to use percpu_rw_semaphore")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

This looks like one of these theoretical issues LLMs come up with. Frankly,
I just wouldn't bother. If the fs gets forcibly remounted RO due to
metadata errors, a frozen fs is likely the least of your worries.

								Honza

> ---
> Tested with a test-only KUnit case in x86_64 QEMU on linux-next
> 32b6ef9a5d0e (next-20260902). It freezes a writable ramfs, sets SB_RDONLY,
> thaws it, and calls sb_start_write_trylock(). The call fails without this
> patch and succeeds with it.
> 
> Backport note: before e0b62a4dee24 ("fs: add fs/super_types.h header"),
> struct sb_writers is in include/linux/fs.h.
> 
>  fs/super.c                     | 4 +++-
>  include/linux/fs/super_types.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 9d40252135212..e8d75cef74677 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -2329,6 +2329,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
>  	 */
>  	WARN_ON_ONCE(freeze_inc(sb, who) > 1);
>  	sb->s_writers.freeze_owner = freeze_owner;
> +	sb->s_writers.freeze_rwsems_locked = true;
>  	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
>  	wake_up_var(&sb->s_writers.frozen);
>  	lockdep_sb_freeze_release(sb);
> @@ -2364,7 +2365,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
>  		goto out_unlock;
>  	}
>  
> -	if (sb_rdonly(sb)) {
> +	if (!sb->s_writers.freeze_rwsems_locked) {
>  		sb->s_writers.frozen = SB_UNFROZEN;
>  		sb->s_writers.freeze_owner = NULL;
>  		wake_up_var(&sb->s_writers.frozen);
> @@ -2387,6 +2388,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
>  	sb->s_writers.freeze_owner = NULL;
>  	wake_up_var(&sb->s_writers.frozen);
>  	sb_freeze_unlock(sb, SB_FREEZE_FS);
> +	sb->s_writers.freeze_rwsems_locked = false;
>  out_deactivate:
>  	deactivate_locked_super(sb);
>  	return 0;
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
> index ecd96aeb1cee7..3e15efab65329 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -53,6 +53,7 @@ enum {
>  
>  struct sb_writers {
>  	unsigned short			frozen;		/* Is sb frozen? */
> +	bool				freeze_rwsems_locked; /* Freeze holds writer rwsems */
>  	int				freeze_kcount;	/* How many kernel freeze requests? */
>  	int				freeze_ucount;	/* How many userspace freeze requests? */
>  	const void			*freeze_owner;	/* Owner of the freeze */
> -- 
> 2.53.0
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
