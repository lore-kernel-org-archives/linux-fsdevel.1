Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C818448CEE
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249195; cv=none; b=Z/s1EGoKfv60+/3Sop7Jx6DObgWT4cW7SXe1ZCt3kOzYa5FfXauCLgtSlyMsd83/fKfr/8Fxfj/o4N1Ji5UKe9VxXMNL+4B56JRmp1HVLhjNGwDVstlkhh0xJ2E83SzA8GH3V3l2HbpqNiyrZeVdLBNDzlnZly9z3mdmvyWXPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249195; c=relaxed/simple;
	bh=Dpd/hS6ASd+U4fh9rO/ZSikuWFiJS1cPpXyPi3Yy0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3z9trsa2IQyWHj857WBpk37aBRHmonWmSF9GTbChCS+P9/6FjmGbknfoTeGnOdWqppEklmK0ikvs/NWjojftQawjjAH85aX6sTIp5pZDO2XBcP3dX4sPPglViDKh8sn9LTHC/1gozbViJM/sypfYrM/13r9iFNGtI+3hsCDdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K/Sa9iVZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B17sxPjd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wN66Cxsk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4mJBLtIl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K/Sa9iVZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B17sxPjd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wN66Cxsk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4mJBLtIl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0BCE17C3FF;
	Tue, 28 Jul 2026 14:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785249180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8DvnMMtGcwVWHGWoFhfyE5KClXsFThSF9L45tJAw60=;
	b=K/Sa9iVZfDXvScIxmLXwJhfldwZGZa5mwNaZyC2sbuqXVkGy7AO6KBWlVnNcftdlvwTeJI
	aL6+OvBREERWuDq+pMr5F9wIPsvr16jSyBrC9PqwZLjMISOEuHSvtP/vVpK9M+t5Ro8ryN
	1/P1p8K0sUaIvlPzPWPg97B1GRKh8gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785249180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8DvnMMtGcwVWHGWoFhfyE5KClXsFThSF9L45tJAw60=;
	b=B17sxPjdSTWKp7Lx0pOmcdQoultEHlgvAkwiWYXKYGtqTyRYiXjVdU4nAWv6tPCjKU50lx
	bQb7FVQnNSos/ODw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wN66Cxsk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4mJBLtIl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785249173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8DvnMMtGcwVWHGWoFhfyE5KClXsFThSF9L45tJAw60=;
	b=wN66CxskGGhVy9gtqFngPgREG+Ve0MFTND1mdgwb7gzNOqxNVuIJuW013VlKOkbqZvOTlb
	ca+7WfDuxLaqIWo3VI2CrLv0ArkYfqaSAg71tk2p911yKEqs9W6unVEBlrthVcLU+72shY
	LRH+7GWOPG1zmsBFfxMdjAHXC/O8c+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785249173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8DvnMMtGcwVWHGWoFhfyE5KClXsFThSF9L45tJAw60=;
	b=4mJBLtIlRLR24FzoYLQgLVrwWhoQAEeDgx/vDYNcDdhbull0tBT7W5qsCy/STQqcSGkGGv
	ZnZ4DbUGvS1PM5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDA60779B1;
	Tue, 28 Jul 2026 14:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8616OZO9aGruGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 Jul 2026 14:32:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 95F19A10B6; Tue, 28 Jul 2026 16:32:51 +0200 (CEST)
Date: Tue, 28 Jul 2026 16:32:51 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] lockref: tidy up dead count handling
Message-ID: <dg6nl6xihsf7gugo2hmfiznuayeuzm3kdvbenqdf57wbaw6h62@fm2nngfwyooj>
References: <20260724171422.429284-1-mjguzik@gmail.com>
 <20260724171422.429284-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724171422.429284-2-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 0BCE17C3FF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Fri 24-07-26 19:14:21, Mateusz Guzik wrote:
> 1. put the dead val into a macro so that it can be used in other places
> 2. __lockref_is_dead():
> - drop the __ suffix, this is not an internal routine
> - drop the spurious cast, the value is already a signed int
> - use READ_ONCE to prevent any compile shenanigans
> 3. provide lockref_is_dead_or_zero()
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ceph/dir.c           |  2 +-
>  fs/erofs/zdata.c        |  4 ++--
>  fs/gfs2/glock.c         |  6 +++---
>  fs/gfs2/lock_dlm.c      |  6 +++---
>  fs/gfs2/quota.c         |  4 ++--
>  fs/xfs/xfs_buf.c        |  4 ++--
>  fs/xfs/xfs_qm.c         |  4 ++--
>  include/linux/lockref.h | 12 ++++++++++--
>  lib/lockref.c           |  2 +-
>  9 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index b957149abe5a..f39856ff3ea1 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1667,7 +1667,7 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
>  		if (!spin_trylock(&dentry->d_lock))
>  			continue;
>  
> -		if (__lockref_is_dead(&dentry->d_lockref)) {
> +		if (lockref_is_dead(&dentry->d_lockref)) {
>  			list_del_init(&di->lease_list);
>  			goto next;
>  		}
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 74520e910259..d022d1dff5a1 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -725,7 +725,7 @@ static bool z_erofs_get_pcluster(struct z_erofs_pcluster *pcl)
>  		return true;
>  
>  	spin_lock(&pcl->lockref.lock);
> -	if (__lockref_is_dead(&pcl->lockref)) {
> +	if (lockref_is_dead(&pcl->lockref)) {
>  		spin_unlock(&pcl->lockref.lock);
>  		return false;
>  	}
> @@ -945,7 +945,7 @@ static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
>  	if (lockref_put_or_lock(&pcl->lockref))
>  		return;
>  
> -	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
> +	DBG_BUGON(lockref_is_dead(&pcl->lockref));
>  	if (!--pcl->lockref.count) {
>  		if (try_free && xa_trylock(&sbi->managed_pslots)) {
>  			free = __erofs_try_to_release_pcluster(sbi, pcl);
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index b8a144d3a73b..eaa2980051ed 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -2080,7 +2080,7 @@ static void clear_glock(struct gfs2_glock *gl)
>  	gfs2_glock_remove_from_lru(gl);
>  
>  	spin_lock(&gl->gl_lockref.lock);
> -	if (!__lockref_is_dead(&gl->gl_lockref)) {
> +	if (!lockref_is_dead(&gl->gl_lockref)) {
>  		gl->gl_lockref.count++;
>  		if (gl->gl_state != LM_ST_UNLOCKED)
>  			request_demote(gl, LM_ST_UNLOCKED, 0, false);
> @@ -2115,7 +2115,7 @@ static void dump_glock_func(struct gfs2_glock *gl)
>  static void withdraw_glock(struct gfs2_glock *gl)
>  {
>  	spin_lock(&gl->gl_lockref.lock);
> -	if (!__lockref_is_dead(&gl->gl_lockref)) {
> +	if (!lockref_is_dead(&gl->gl_lockref)) {
>  		/*
>  		 * We don't want to write back any more dirty data.  Unlock the
>  		 * remaining inode and resource group glocks; this will cause
> @@ -2483,7 +2483,7 @@ static void gfs2_glock_iter_next(struct gfs2_glock_iter *gi, loff_t n)
>  				continue;
>  			break;
>  		} else {
> -			if (__lockref_is_dead(&gl->gl_lockref))
> +			if (lockref_is_dead(&gl->gl_lockref))
>  				continue;
>  			n--;
>  		}
> diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
> index 7828ad0b6f5a..cc901fb97da0 100644
> --- a/fs/gfs2/lock_dlm.c
> +++ b/fs/gfs2/lock_dlm.c
> @@ -126,7 +126,7 @@ static void gdlm_ast(void *arg)
>  	clear_bit(GLF_BLOCKING, &gl->gl_flags);
>  
>  	/* If the glock is dead, we only react to a dlm_unlock() reply. */
> -	if (__lockref_is_dead(&gl->gl_lockref) &&
> +	if (lockref_is_dead(&gl->gl_lockref) &&
>  	    gl->gl_lksb.sb_status != -DLM_EUNLOCK)
>  		return;
>  
> @@ -182,7 +182,7 @@ static void gdlm_bast(void *arg, int mode)
>  {
>  	struct gfs2_glock *gl = arg;
>  
> -	if (__lockref_is_dead(&gl->gl_lockref))
> +	if (lockref_is_dead(&gl->gl_lockref))
>  		return;
>  
>  	switch (mode) {
> @@ -329,7 +329,7 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
>  	uint32_t flags = 0;
>  	int error;
>  
> -	BUG_ON(!__lockref_is_dead(&gl->gl_lockref));
> +	BUG_ON(!lockref_is_dead(&gl->gl_lockref));
>  
>  	if (test_bit(GLF_INITIAL, &gl->gl_flags)) {
>  		gfs2_glock_free(gl);
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 91e9975d25e8..001c8b39ca55 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -342,7 +342,7 @@ static void qd_put(struct gfs2_quota_data *qd)
>  	if (lockref_put_or_lock(&qd->qd_lockref))
>  		return;
>  
> -	BUG_ON(__lockref_is_dead(&qd->qd_lockref));
> +	BUG_ON(lockref_is_dead(&qd->qd_lockref));
>  	sdp = qd->qd_sbd;
>  	if (unlikely(!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))) {
>  		lockref_mark_dead(&qd->qd_lockref);
> @@ -486,7 +486,7 @@ static bool qd_grab_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
>  	    qd->qd_sync_gen >= sync_gen)
>  		goto out;
>  
> -	if (__lockref_is_dead(&qd->qd_lockref))
> +	if (lockref_is_dead(&qd->qd_lockref))
>  		goto out;
>  	qd->qd_lockref.count++;
>  
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 21d67af781da..17b9d643e1a8 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -80,7 +80,7 @@ xfs_buf_stale(
>  
>  	spin_lock(&bp->b_lockref.lock);
>  	atomic_set(&bp->b_lru_ref, 0);
> -	if (!__lockref_is_dead(&bp->b_lockref))
> +	if (!lockref_is_dead(&bp->b_lockref))
>  		list_lru_del_obj(&bp->b_target->bt_lru, &bp->b_lru);
>  	spin_unlock(&bp->b_lockref.lock);
>  }
> @@ -841,7 +841,7 @@ static void
>  xfs_buf_destroy(
>  	struct xfs_buf		*bp)
>  {
> -	ASSERT(__lockref_is_dead(&bp->b_lockref));
> +	ASSERT(lockref_is_dead(&bp->b_lockref));
>  	ASSERT(!(bp->b_flags & _XBF_DELWRI_Q));
>  
>  	if (bp->b_pag)
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index 896b24f87ac9..99a82107b8e6 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -128,7 +128,7 @@ xfs_qm_dqpurge(
>  	struct xfs_quotainfo	*qi = dqp->q_mount->m_quotainfo;
>  
>  	spin_lock(&dqp->q_lockref.lock);
> -	if (dqp->q_lockref.count > 0 || __lockref_is_dead(&dqp->q_lockref)) {
> +	if (dqp->q_lockref.count > 0 || lockref_is_dead(&dqp->q_lockref)) {
>  		spin_unlock(&dqp->q_lockref.lock);
>  		return -EAGAIN;
>  	}
> @@ -429,7 +429,7 @@ xfs_qm_dquot_isolate(
>  	 * from the LRU, leave it for the freeing task to complete the freeing
>  	 * process rather than risk it being free from under us here.
>  	 */
> -	if (__lockref_is_dead(&dqp->q_lockref))
> +	if (lockref_is_dead(&dqp->q_lockref))
>  		goto out_miss_unlock;
>  
>  	/*
> diff --git a/include/linux/lockref.h b/include/linux/lockref.h
> index 6ded24cdb4a8..ddfb7d3b8cec 100644
> --- a/include/linux/lockref.h
> +++ b/include/linux/lockref.h
> @@ -34,6 +34,8 @@ struct lockref {
>  	};
>  };
>  
> +#define __LOCKREF_DEAD_VAL	-128
> +
>  /**
>   * lockref_init - Initialize a lockref
>   * @lockref: pointer to lockref structure
> @@ -55,9 +57,15 @@ void lockref_mark_dead(struct lockref *lockref);
>  bool lockref_get_not_dead(struct lockref *lockref);
>  
>  /* Must be called under spinlock for reliable results */
> -static inline bool __lockref_is_dead(const struct lockref *l)
> +static inline bool lockref_is_dead(const struct lockref *l)
> +{
> +	return (READ_ONCE(l->count) == __LOCKREF_DEAD_VAL);
> +}
> +
> +static inline bool lockref_is_dead_or_zero(const struct lockref *l)
>  {
> -	return ((int)l->count < 0);
> +	int count = READ_ONCE(l->count);
> +	return (count == __LOCKREF_DEAD_VAL || count == 0);
>  }
>  
>  #endif /* __LINUX_LOCKREF_H */
> diff --git a/lib/lockref.c b/lib/lockref.c
> index 5d8e3ef3860e..9b3dd688d8cd 100644
> --- a/lib/lockref.c
> +++ b/lib/lockref.c
> @@ -131,7 +131,7 @@ EXPORT_SYMBOL(lockref_put_or_lock);
>  void lockref_mark_dead(struct lockref *lockref)
>  {
>  	assert_spin_locked(&lockref->lock);
> -	lockref->count = -128;
> +	lockref->count = __LOCKREF_DEAD_VAL;
>  }
>  EXPORT_SYMBOL(lockref_mark_dead);
>  
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
