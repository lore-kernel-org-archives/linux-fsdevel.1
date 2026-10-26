Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016173;
	b=lGPaKgGx+vT2KWEzd7kdD2nBttyklcRn56ktS8ph5Q3LD21mfFdZqa0NW7XXfnbn09iB
	 M2VkbxVOD9YhMzPnPc6lNUwGGVMvcBT/tElgaP842VecdEjPhqR0kaPEaE7KkUzM1nlrU
	 CHtL8pjcCOImDLsxifJylxDHswbvcosyYnOlYDo0TbfmXiU8ZS85b2hQKHlG7yjKa/D20
	 s1d4w9VUFoenaUgPNsDb29mZESSPzPlKJrWq4IUL0+hSkVwf9JTowDZr3EPTfJ0jHymF4
	 YkCdLJAOARSbzDk1COUvceK7+mp75nyEB3BP2/sJycKP0ngLYiOh2j/B9zjlTfdELww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016173;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=zlmTMmi6YudkfPu7PQopDM7ohP807S77yK/bEEbWsyw=;
	b=AxQVnf48kU1QwgmruFb7/YJdJxgMN2l1pfT9dwf0fSH0YXk3dy/BhFkJb5CgQA/BokmW
	 sEfHhQGTC5ur+UO/z+hZEZCyOdgpmpOQl06cskKay7dl6KiYa2Oghd6nm+mXrsuNGX+Lw
	 IyWOLo2EoUSFy66OKJtwdR6iUg58wxIFHB2asKedbJ8eUZjKGQ8X0LShtday/tXrr+d4w
	 /+z6g5b6S8OJukhNzlrbMvmLsCRSM8VPgqSRsseXHHd+m7RfNMby5rSeaxuK3ZKQV+E/n
	 sG02aLvpe5YijQ/VLw4gMMJUDDqyEcRZ8TRIdwuvrE80M8k/C3j5SkYKDgyo9hPg1Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FTmYjyKn;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4Mg8YKoq;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FTmYjyKn;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4Mg8YKoq;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52298606A31E;
	Mon, 26 Oct 2026 12:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52298606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FTmYjyKn;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4Mg8YKoq;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FTmYjyKn;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4Mg8YKoq
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E28A1F43B;
	Mon, 26 Oct 2026 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793016171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlmTMmi6YudkfPu7PQopDM7ohP807S77yK/bEEbWsyw=;
	b=FTmYjyKnXuz+M22Q+mfqbSj6/T0RlrpgAX8TNuLV+Gg0qTUxAs7JCesva4HdWI/YoDh1xT
	O+YQrKbcx0GG13sZwvdwMNwzGPgMJFqFBr1aJNSuOMKfrqfSeXnY/1CBJTNg55KC4tlFar
	zE92SmgX9kH+RK1SA9BshbjHOWgMUWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793016171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlmTMmi6YudkfPu7PQopDM7ohP807S77yK/bEEbWsyw=;
	b=4Mg8YKoqM3mMVBgLb7V41KBwnjE00rEZ9nZBiYx1zpFYMpO7KF1MqMoyhxiAYToaez1VM9
	9xJr06wBjPLp+UCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793016171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlmTMmi6YudkfPu7PQopDM7ohP807S77yK/bEEbWsyw=;
	b=FTmYjyKnXuz+M22Q+mfqbSj6/T0RlrpgAX8TNuLV+Gg0qTUxAs7JCesva4HdWI/YoDh1xT
	O+YQrKbcx0GG13sZwvdwMNwzGPgMJFqFBr1aJNSuOMKfrqfSeXnY/1CBJTNg55KC4tlFar
	zE92SmgX9kH+RK1SA9BshbjHOWgMUWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793016171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlmTMmi6YudkfPu7PQopDM7ohP807S77yK/bEEbWsyw=;
	b=4Mg8YKoqM3mMVBgLb7V41KBwnjE00rEZ9nZBiYx1zpFYMpO7KF1MqMoyhxiAYToaez1VM9
	9xJr06wBjPLp+UCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40B5813319;
	Mon, 26 Oct 2026 12:02:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YdaJCGtB32oQHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 12:02:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4A2BA1419; Mon, 26 Oct 2026 13:02:46 +0100 (CET)
Date: Mon, 26 Oct 2026 13:02:46 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] super: make sync(2)'s wait for s_umount killable
Message-ID: <tqgqwii6it4zxhtsfgnkri2mppbcijvsdnywrsbsyrsc3ey6w5@ts5aqmpikwyv>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
 <20261023-work-super-lock_helpers-v1-4-d0fcb3f2f275@kernel.org>
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
In-Reply-To: <20261023-work-super-lock_helpers-v1-4-d0fcb3f2f275@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -12.80

On Fri 23-10-26 11:41:04, Christian Brauner wrote:
> iterate_supers_sync() waits killably for a superblock that's being shut
> down, but it takes s_umount of a live superblock uninterruptibly. So a
> freeze_super() or remount that's stuck under s_umount, in
> sync_filesystem() or ->freeze_fs() say, still hangs every sync(2) on
> the machine without anyone being able to kill it.
> 
> That's inconsistent with fs_bdev_sync() which already uses a killable
> super_lock() for both waits. And the reasoning is the same: if the task
> is killed the walk stops and ksys_sync() returns, there's nobody left to
> make a promise to. The emergency sync and the sync before suspend and
> hibernation run from a workqueue where that can't happen. The PROM sync
> on sparc32 runs in whatever task it interrupted but that one could
> already be cut short while it waited for a superblock being shut down.
> 
> Let __iterate_supers() pass SUPER_LOCK_KILLABLE together with
> SUPER_LOCK_WAIT_SHUTDOWN for SUPER_ITER_WAIT_SHUTDOWN. Only
> iterate_supers_sync() passes that flag.

This might get surprising in the future, I guess SUPER_ITER_KILLABLE flag
might be a more explicit way to control this but I can live with what we
have now.

> The wait for SB_BORN doesn't
> matter for sync(2) as iterate_supers_sync() skips unborn superblocks
> anyway.
> 
> This can be reproduced by freezing a filesystem on a suspended dm-linear
> device and calling sync(2) behind the freeze:
> 
>   truncate -s 512M img
>   DEV=$(losetup -f --show img)
>   mke2fs -q $DEV
>   dmsetup create t --table "0 $(blockdev --getsz $DEV) linear $DEV 0"
>   mount -t ext2 /dev/mapper/t /mnt
>   dd if=/dev/urandom of=/mnt/f bs=1M count=64
>   dmsetup suspend --nolockfs t
>   fsfreeze --freeze /mnt &
>   sleep 3
>   sync &
>   sleep 3
>   kill -9 $!
> 
> fsfreeze sits in sync_filesystem() with s_umount held for writing.
> Without this patch the sync stays in down_read() after the SIGKILL. With
> it the sync goes away.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 0f3308fb99aa..a0f9eadf0da7 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1010,9 +1010,13 @@ static inline struct super_block *next_super(struct super_block *sb,
>  static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>  			    enum super_iter_flags_t flags)
>  {
> +	enum super_lock_flags_t lock_flags = 0;
>  	struct super_block *sb, *p = NULL;
>  	int ret = 0;
>  
> +	if (flags & SUPER_ITER_WAIT_SHUTDOWN)
> +		lock_flags |= SUPER_LOCK_KILLABLE | SUPER_LOCK_WAIT_SHUTDOWN;
> +
>  	spin_lock(&sb_lock);
>  
>  	for (sb = first_super(flags);
> @@ -1032,12 +1036,14 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>  
>  		if (flags & SUPER_ITER_UNLOCKED) {
>  			f(sb, arg);
> -		} else if (!super_lock(sb, 0)) {
> -			f(sb, arg);
> -			super_unlock_shared(sb);
> -		} else if (flags & SUPER_ITER_WAIT_SHUTDOWN) {
> -			/* whoever shuts it down writes it out, wait for that */
> -			ret = super_wait(sb, SB_DYING, TASK_KILLABLE);
> +		} else {
> +			ret = super_lock(sb, lock_flags);
> +			if (!ret) {
> +				f(sb, arg);
> +				super_unlock_shared(sb);
> +			} else if (ret == -ENOENT) {
> +				ret = 0;
> +			}
>  		}
>  
>  		if (p)
> @@ -1085,8 +1091,8 @@ void iterate_supers_born(void (*f)(struct super_block *, void *), void *arg)
>   * A superblock which is still being set up isn't passed to @f either, and
>   * isn't waited for.  Nobody can have written to it yet.
>   *
> - * Return: 0 if all the superblocks were seen, -ERESTARTSYS if the task was
> - *         killed while it waited for one.
> + * Return: 0 if all the superblocks were seen, -EINTR or -ERESTARTSYS if the
> + *         task was killed while it waited for one.
>   */
>  int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg)
>  {
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
