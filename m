Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885523CCFCA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853576; cv=none; b=gquHVSnUg5Q75o84a2zzVpYy5Lhl1wcQQ0oMqlvSjyo5q09A3Y5Qq64UklIfKWkNPBT3dfFgcdvGs+plkB5udz8NYLlPBy/eSn8CrgjfZ/dEWO2huvOsAKMzcf+rCd7RZmrCvMKHoszrefr90v/GppYkuyt5k1gN7FfyrUU2WPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853576; c=relaxed/simple;
	bh=1mL51MMT3uCnVpmrl53EbEyuHqYLNIkGHsM9wOV+siY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhbHaBWomftxzrmqb3dPI/G8F0R+kwoxcf4BN9YRb0efuvvLxYAQHYX6QeASw306sFWfw3gxc/SDf6bs9d/vjiwcxDo9qopRlXQ2BpQMWrLxlC4o4JU/QTUv5zbZQ0X/jGMO7d5628Fq5TM8/43VCSP2oo3j6Z+t03ptQ6Xe4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a3/dTic7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bdbgQJSv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a3/dTic7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bdbgQJSv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a3/dTic7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bdbgQJSv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a3/dTic7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bdbgQJSv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C04EC5BD56;
	Wed, 22 Apr 2026 10:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776853571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VET/417HAuSDXbte8eLrRfcbPV2qlopUhM7jfM8Di+Q=;
	b=a3/dTic7SqWMrkbfxxEdQlue/F1b4mrafFIYv/AWHC23RXUhEDPomrQKGAyYwGliJvLxZ7
	osn765dayUIEfCZu72QMqVpzN4QsWAaNh4AqSjRKb3MNW1yS/oVJJkgxdxe24IYo04C7Wp
	ZKkZJ9zoWIp45HAGIXnP5qdI/HKaSEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776853571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VET/417HAuSDXbte8eLrRfcbPV2qlopUhM7jfM8Di+Q=;
	b=bdbgQJSvuVnd1HZoJtfG7xzE42CKtALiYv+YkzbFEgAd+hGmR3a6SPyA1JeIENJRKUuHmg
	wQwmS93AGjqd+hDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776853571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VET/417HAuSDXbte8eLrRfcbPV2qlopUhM7jfM8Di+Q=;
	b=a3/dTic7SqWMrkbfxxEdQlue/F1b4mrafFIYv/AWHC23RXUhEDPomrQKGAyYwGliJvLxZ7
	osn765dayUIEfCZu72QMqVpzN4QsWAaNh4AqSjRKb3MNW1yS/oVJJkgxdxe24IYo04C7Wp
	ZKkZJ9zoWIp45HAGIXnP5qdI/HKaSEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776853571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VET/417HAuSDXbte8eLrRfcbPV2qlopUhM7jfM8Di+Q=;
	b=bdbgQJSvuVnd1HZoJtfG7xzE42CKtALiYv+YkzbFEgAd+hGmR3a6SPyA1JeIENJRKUuHmg
	wQwmS93AGjqd+hDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3B8C593AF;
	Wed, 22 Apr 2026 10:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +wrfK0Oi6GmGcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 10:26:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7BD29A0B60; Wed, 22 Apr 2026 12:26:07 +0200 (CEST)
Date: Wed, 22 Apr 2026 12:26:07 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] fs: allow lockless ->i_count bumps as long as it
 does not transition 0->1
Message-ID: <2bhx357rrmgp77olzxx5halgehfffsym2ltcbyekagxmddrjhg@hrpnza4xovnn>
References: <20260421182538.1215894-1-mjguzik@gmail.com>
 <20260421182538.1215894-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421182538.1215894-4-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO

On Tue 21-04-26 20:25:38, Mateusz Guzik wrote:
> With this change only 0->1 and 1->0 transitions need the lock.
> 
> I verified all places which look at the refcount either only care about
> it staying 0 (and have the lock enforce it) or don't hold the inode lock
> to begin with (making the above change irrelevant to their correcness or
> lack thereof).
> 
> I also confirmed nfs and btrfs like to call into these a lot and now
> avoid the lock in the common case, shaving off some atomics.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c        |  4 +++
>  fs/inode.c         | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  4 +--
>  3 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index df11bbba0342..13c81a6bb5e1 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2033,6 +2033,10 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
>  	__d_instantiate(entry, inode);
>  	spin_unlock(&entry->d_lock);
>  	WARN_ON(!(inode_state_read(inode) & I_NEW));
> +	/*
> +	 * Paired with igrab_from_hash()
> +	 */
> +	smp_wmb();
>  	inode_state_clear(inode, I_NEW | I_CREATING);
>  	inode_wake_up_bit(inode, __I_NEW);
>  	spin_unlock(&inode->i_lock);
> diff --git a/fs/inode.c b/fs/inode.c
> index 17f0804b429c..39cb22e63d5b 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1023,6 +1023,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  }
>  
>  static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked);
> +static bool igrab_from_hash(struct inode *inode);
>  
>  /*
>   * Called with the inode lock held.
> @@ -1047,6 +1048,11 @@ static struct inode *find_inode(struct super_block *sb,
>  			continue;
>  		if (!test(inode, data))
>  			continue;
> +		if (igrab_from_hash(inode)) {
> +			rcu_read_unlock();
> +			*isnew = false;
> +			return inode;
> +		}
>  		spin_lock(&inode->i_lock);
>  		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
>  			__wait_on_freeing_inode(inode, hash_locked, true);
> @@ -1089,6 +1095,11 @@ static struct inode *find_inode_fast(struct super_block *sb,
>  			continue;
>  		if (inode->i_sb != sb)
>  			continue;
> +		if (igrab_from_hash(inode)) {
> +			rcu_read_unlock();
> +			*isnew = false;
> +			return inode;
> +		}
>  		spin_lock(&inode->i_lock);
>  		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
>  			__wait_on_freeing_inode(inode, hash_locked, true);
> @@ -1206,6 +1217,10 @@ void unlock_new_inode(struct inode *inode)
>  	lockdep_annotate_inode_mutex_key(inode);
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(!(inode_state_read(inode) & I_NEW));
> +	/*
> +	 * Paired with igrab_from_hash()
> +	 */
> +	smp_wmb();
>  	inode_state_clear(inode, I_NEW | I_CREATING);
>  	inode_wake_up_bit(inode, __I_NEW);
>  	spin_unlock(&inode->i_lock);
> @@ -1217,6 +1232,10 @@ void discard_new_inode(struct inode *inode)
>  	lockdep_annotate_inode_mutex_key(inode);
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(!(inode_state_read(inode) & I_NEW));
> +	/*
> +	 * Paired with igrab_from_hash()
> +	 */
> +	smp_wmb();
>  	inode_state_clear(inode, I_NEW);
>  	inode_wake_up_bit(inode, __I_NEW);
>  	spin_unlock(&inode->i_lock);
> @@ -1576,6 +1595,14 @@ EXPORT_SYMBOL(ihold);
>  
>  struct inode *igrab(struct inode *inode)
>  {
> +	/*
> +	 * Read commentary above igrab_from_hash() for an explanation why this works.
> +	 */
> +	if (atomic_add_unless(&inode->i_count, 1, 0)) {
> +		VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE), inode);
> +		return inode;
> +	}
> +
>  	spin_lock(&inode->i_lock);
>  	if (!(inode_state_read(inode) & (I_FREEING | I_WILL_FREE))) {
>  		__iget(inode);
> @@ -1593,6 +1620,43 @@ struct inode *igrab(struct inode *inode)
>  }
>  EXPORT_SYMBOL(igrab);
>  
> +/*
> + * igrab_from_hash - special inode refcount acquire primitive for the inode hash
> + *
> + * It provides lockless refcount acquire in the common case of no problematic
> + * flags being set and the count being > 0.
> + *
> + * There are 4 state flags to worry about and the routine makes sure to not bump the
> + * ref if any of them is present.
> + *
> + * I_NEW and I_CREATING can only legally get set *before* the inode becomes visible
> + * during lookup. Thus if the flags are not spotted, they are guaranteed to not be
> + * a factor. However, we need an acquire fence before returning the inode just
> + * in case we raced against clearing the state to make sure our consumer picks up
> + * any other changes made prior. atomic_add_unless provides a full fence, which
> + * takes care of it.
> + *
> + * I_FREEING and I_WILL_FREE can only legally get set if ->i_count == 0 and it is
> + * illegal to bump the ref if either is present. Consequently if atomic_add_unless
> + * managed to replace a non-0 value with a bigger one, we have a guarantee neither
> + * of these flags is set. Note this means explicitly checking of these flags below
> + * is not necessary, it is only done because it does not cost anything on top of the
> + * load which already needs to be done to handle the other flags.
> + */
> +static bool igrab_from_hash(struct inode *inode)
> +{
> +	if (inode_state_read_once(inode) & (I_NEW | I_CREATING | I_FREEING | I_WILL_FREE))
> +		return false;
> +	/*
> +	 * Paired with routines clearing I_NEW
> +	 */
> +	if (atomic_add_unless(&inode->i_count, 1, 0)) {
> +		VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE), inode);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  /**
>   * ilookup5_nowait - search for an inode in the inode cache
>   * @sb:		super block of file system to search
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a046ae84a227..bbe179b02234 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2226,8 +2226,8 @@ static inline int icount_read_once(const struct inode *inode)
>  }
>  
>  /*
> - * returns the refcount on the inode. The lock guarantees no new references
> - * are added, but references can be dropped as long as the result is > 0.
> + * returns the refcount on the inode. The lock guarantees no 0->1 or 1->0 transitions
> + * of the count are going to take place, otherwise it changes arbitrarily.
>   */
>  static inline int icount_read(const struct inode *inode)
>  {
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
