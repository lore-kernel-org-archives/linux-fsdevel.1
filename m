Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670096;
	b=xLpBlb1XEDsr1+X+62Al/zKZjRQZdnxzIv4JHLppi99T4wHV4Mc7HQy1qBmefJuovcPG
	 fZwrmg7DrnS8JPa+nBKnYh3Qzi4jiyBKiyX4ZF010N5fetN7LyXJkACNllMASlAnWMZHW
	 87c0IDaVhMqN8KAJ5SgwtEwoUyNwwtyErntlm6mR5pkGgFIy6IB6boCPLkqK5Nb7jCGzd
	 aP9KD6vQrJm4+w22kYgOMxySm5rY24Z3sGwoP4SiJvwMHkWWPWp7SilDLaRbztjw2Xt+0
	 P0RuaGlXGjAp32bUkPOl0tCTpwf+KGRr/l1a303LYtqDbn7h/Wj25t4BYFncyKF3qzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670096;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=Ki1cwKJQTqrG9U30cei8QndCvChWE//Qsc4WNQH7Lyg=;
	b=MnQkvsVXAVXiVsIIf3NrvgLIkXSD0laJWJNWUcofE6WYNMw0WaIbwp+m9661DQbEAcPu
	 YmIolhE2N3RimvyH0tt7oKEM9s/+mcxqBAwYf1EPY7Z5bALEfqhD10QMxILw3+ft7FNtn
	 l6YhRnx4ydBL37wX7nKsH6LbgBAHmjYyLNGmJeuk55BA5ajRpWq6homCrJZimcGMqflEn
	 QRlEgf7ch67E4s8CQkhjV6TSjxvePmxuI/yj32F9nXNY3O50kk0S5K8IxD7XXLZlqDZ+i
	 6jxzIqeW/f4ZmArlkTPBftwJYkmsDI35HArlg0WiqSg5wcp2ffaZyplN2OT4iMhTeDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=k0zHBfDA;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xK1C17rX;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Qi2Zl+TH;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/84wopBr";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60C606A319;
	Thu, 22 Oct 2026 11:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A60C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=k0zHBfDA;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xK1C17rX;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Qi2Zl+TH;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/84wopBr
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A91D21FCEE;
	Thu, 22 Oct 2026 11:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792670093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki1cwKJQTqrG9U30cei8QndCvChWE//Qsc4WNQH7Lyg=;
	b=k0zHBfDAICL3Kxcvav5lltp+hWgJl+7/oBs0x3vVDZjFQIoHZwV5mqY3DbktLBb1eAeAfa
	sG4OEU1LQbWNErkJkov9ln32JP/mME4NWBGiM5yixdKtLL9Sv8L0TCX0JTogkukrsSDk2Y
	ahN226Ab27VFmXFIFUzUapwurYEpPRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792670093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki1cwKJQTqrG9U30cei8QndCvChWE//Qsc4WNQH7Lyg=;
	b=xK1C17rXEotnc53Uol0IfbGC+rMvzDjSKOMEn/5paQX713wGLwFhpINruA7jH9arwQVRzE
	cOWqa0Jg2XcQPdCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792670092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki1cwKJQTqrG9U30cei8QndCvChWE//Qsc4WNQH7Lyg=;
	b=Qi2Zl+THVkT4STr1sxzXp66ESUiop5PM64RaxCsb6pNIXDVDTVMbL6qu2tKadkBnznBb4B
	hn2oLK/3ZoI04zlqJKZAkAnerc8szrnlGR9D6GmKOMPnVuc3X8myUTgYA9tD4fhN9i2JnL
	4oYp5K6dT2LmJUmvH2syaUcDoqyxG/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792670092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki1cwKJQTqrG9U30cei8QndCvChWE//Qsc4WNQH7Lyg=;
	b=/84wopBroN8VpAI3cZ/sXPXQZzawN/MEKdt1M+jISb6ilLmwgNkTp5PWoD759+tqAhYWa5
	aI2Zmv1s+z0bL2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89DE0133F3;
	Thu, 22 Oct 2026 11:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 18MVG4z52WrPBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 11:54:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32F38A1417; Thu, 22 Oct 2026 13:54:52 +0200 (CEST)
Date: Thu, 22 Oct 2026 13:54:52 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: skip unborn superblocks in drop_caches and Q_SYNC
Message-ID: <ghkbxk6qak6e6yeqi523egcyzig5pmrbzxbtpigm6zwyeao2vs@amvcxr7d33y3>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
 <20261021-b4-super-lock-unborn-v1-5-0265eddb6dee@toxicpanda.com>
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
In-Reply-To: <20261021-b4-super-lock-unborn-v1-5-0265eddb6dee@toxicpanda.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,toxicpanda.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 21-10-26 16:47:01, Josef Bacik wrote:
> Writing to /proc/sys/vm/drop_caches and quotactl(Q_SYNC) without a device
> walk all the superblocks with iterate_supers(), and like sync(2) they hang,
> unkillably, on one whose mount is stuck before SB_BORN.
> 
> Neither gets anything out of the wait.  A filesystem which isn't mounted
> yet has no page cache anybody would miss.  It may well have quota turned
> on, ext4 and XFS do that while they are being mounted, but nobody has used
> it yet.  The only changes to the quota so far are the filesystem's own,
> from cleaning up orphans say, and it has to get those to disk whether or
> not anybody calls Q_SYNC.
> 
> Add iterate_supers_born(), which skips such superblocks, and use it for
> the two.
> 
> iterate_supers() itself keeps waiting.  Its remaining user needs that:
> selinux_complete_init() sets up the superblocks which came before the
> policy was loaded.  NFS calls security_sb_set_mnt_opts() from its
> ->get_tree(), so before SB_BORN, and without a policy SELinux puts the work
> off until that walk.  Skipping the superblock there would leave it without
> labels for good.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/drop_caches.c |  2 +-
>  fs/internal.h    |  1 +
>  fs/quota/quota.c |  2 +-
>  fs/super.c       | 15 +++++++++++++++
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index 49f56a598ecb..7ba726837075 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -61,7 +61,7 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  
>  		if (sysctl_drop_caches & 1) {
>  			lru_add_drain_all();
> -			iterate_supers(drop_pagecache_sb, NULL);
> +			iterate_supers_born(drop_pagecache_sb, NULL);
>  			count_vm_event(DROP_PAGECACHE);
>  		}
>  		if (sysctl_drop_caches & 2) {
> diff --git a/fs/internal.h b/fs/internal.h
> index 71ab0ae11941..dd29e98e05fb 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -137,6 +137,7 @@ extern int reconfigure_super(struct fs_context *);
>  extern bool super_trylock_shared(struct super_block *sb);
>  struct super_block *user_get_super(dev_t, bool excl);
>  void put_super(struct super_block *sb);
> +void iterate_supers_born(void (*f)(struct super_block *, void *), void *arg);
>  int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg);
>  void __init super_dev_init(void);
>  extern bool mount_capable(struct fs_context *);
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 33bacd707580..713e66e4d00f 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -66,7 +66,7 @@ static int quota_sync_all(int type)
>  
>  	ret = security_quotactl(Q_SYNC, type, 0, NULL);
>  	if (!ret)
> -		iterate_supers(quota_sync_one, &type);
> +		iterate_supers_born(quota_sync_one, &type);
>  	return ret;
>  }
>  
> diff --git a/fs/super.c b/fs/super.c
> index b8d6f1c969ce..1cfacd71a0d8 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1110,6 +1110,21 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>  	__iterate_supers(f, arg, 0);
>  }
>  
> +/**
> + * iterate_supers_born - iterate_supers() without the wait
> + * @f: function to call
> + * @arg: argument to pass to it
> + *
> + * Doesn't wait for superblocks which are still being set up, they are not
> + * passed to @f.  For callers which are after what has piled up in a filesystem
> + * in use.  Not for callers which have to get at every superblock there is: one
> + * which is skipped may be in use a moment later.
> + */
> +void iterate_supers_born(void (*f)(struct super_block *, void *), void *arg)
> +{
> +	__iterate_supers(f, arg, SUPER_ITER_SKIP_UNBORN);
> +}
> +
>  /**
>   * iterate_supers_sync - iterate_supers() for syncing all filesystems
>   * @f: function to call
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
