Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DFF44A724
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249199; cv=none; b=WdJFlaZi9dltYYMp73yECnIc7KJG/f/w0xMcm5ZAoijGqD1QLFjSIFjs8Ae6cQ1uoG6bUqzkdQGoEpD44KcRA0x9oj3q5G5WkZUqicaZkAoVxfQy0QTj+Gy5lyE0u3qH9jjgKTzPKkJ0LAVuGbxN4m/7WgdzqxlsQnQGyToVKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249199; c=relaxed/simple;
	bh=UBz7mWH4Jp3X0SGJyUm+pDWrAV+7gpi1h7CmiOwRKUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+RFuzKnZWr4oYPsm+6ccaosAbYHZNhBMDLJs3VvkJDJdKtoL3Y06n3jwnP31ULDpfgvjsfqVYMtWX+hoDYRgI/0HW9dubIklKjRnjBtojfyh+De92+tDLbVaBKbnJzAJJcOVp/vV9tNFqT/PqX0Su5RzNV3gq3+8SMHA6PEsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QhBKoUGx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BNCMZyBX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kFojoaDJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Dzloi3b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QhBKoUGx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BNCMZyBX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kFojoaDJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Dzloi3b"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1B0B3E26;
	Tue, 28 Jul 2026 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785249191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTkUJ0hFDMnooB30kx4X5b5tP/peiZzwfdHPfsGR7Pc=;
	b=QhBKoUGx3HjIrM1cJFvk0lPHYgnLLwsdLc+6+5fx9ze9KQ7caOeqXTse7iilshUIlTxLHW
	utEY2k5g1Sx8cqoKr+wcvkO0QtlGR+jcUjEgyquskBUGGBc0q7bsmCmpIi0PXyW3gEX9oP
	StGAig0QFHlQsyFVvJnL9rKM5LXFwgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785249191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTkUJ0hFDMnooB30kx4X5b5tP/peiZzwfdHPfsGR7Pc=;
	b=BNCMZyBXw1B8qHxge/kRru+DHfBl7KMX4SIHBP28SE/Hm7+BJR4moEMujiEK2oF+3AAQOt
	GefD60QZotOdYbDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785249186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTkUJ0hFDMnooB30kx4X5b5tP/peiZzwfdHPfsGR7Pc=;
	b=kFojoaDJQarL9JXgzeEx6qaMXq7/YU762sGgKbGymoTj5au8hiFUKUDVuiR4PjjFf7Mge6
	rkVa8xM+yBVILzvrL3v/mT415azS9bTFJBx7nUd8ZKEjyQMYySWpex+S90IcbOvtje5JJS
	Hs1ehyIS92rqq+/SK8fJGDey8HWAa2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785249186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTkUJ0hFDMnooB30kx4X5b5tP/peiZzwfdHPfsGR7Pc=;
	b=3Dzloi3bjD769KTxoX7lW5riqLmuJ3jcwLe+Vv7gfLI0KAVLGjPf8iyf8t9tCgMZYGgUqD
	/h8Q/Ht8Mal0BjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA002779B1;
	Tue, 28 Jul 2026 14:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id viQfOaK9aGoAGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 Jul 2026 14:33:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ABC69A10B6; Tue, 28 Jul 2026 16:33:02 +0200 (CEST)
Date: Tue, 28 Jul 2026 16:33:02 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] dcache: use lockref routines for dead count checks
Message-ID: <ccv3yeizeijgvir2lhttgqvhlmwu2f2dfnu2x2b2awtp3nic6u@i5nq4zog3tah>
References: <20260724171422.429284-1-mjguzik@gmail.com>
 <20260724171422.429284-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724171422.429284-3-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]

On Fri 24-07-26 19:14:22, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 3e9af9de7074..2aee85f3fbaa 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -434,7 +434,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
>  static void dentry_free(struct dentry *dentry)
>  {
>  	DENTRY_WARN_ONCE(d_really_is_positive(dentry), dentry);
> -	DENTRY_WARN_ONCE(dentry->d_lockref.count >= 0, dentry);
> +	DENTRY_WARN_ONCE(!lockref_is_dead(&dentry->d_lockref), dentry);
>  	D_FLAG_VERIFY(dentry, 0);
>  	if (unlikely(dname_external(dentry))) {
>  		struct external_name *p = external_name(dentry);
> @@ -782,7 +782,7 @@ static bool lock_for_kill(struct dentry *dentry)
>   *
>   * If @dentry is idle and remains such after we assemble the full
>   * locking environment for eviction (see lock_for_kill() for details)
> - * we mark it doomed (->d_lockref.count < 0) and proceed to detaching
> + * we mark it doomed (see lockref_mark_dead()) and proceed to detaching
>   * it from any filesystem objects.  Otherwise we drop ->d_lock and
>   * return %NULL.
>   *
> @@ -946,7 +946,7 @@ static inline bool fast_dput(struct dentry *dentry)
>  	if (unlikely(ret < 0)) {
>  		spin_lock(&dentry->d_lock);
>  		rcu_read_unlock();
> -		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
> +		if (WARN_ON_ONCE(lockref_is_dead_or_zero(&dentry->d_lockref))) {
>  			spin_unlock(&dentry->d_lock);
>  			return true;
>  		}
> @@ -1644,7 +1644,7 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
>  	if (data->start == dentry)
>  		goto out;
>  
> -	if (dentry->d_lockref.count <= 0) {
> +	if (lockref_is_dead_or_zero(&dentry->d_lockref)) {
>  		__move_to_shrink_list(dentry, &data->dispose);
>  		data->found++;
>  	}
> @@ -1676,7 +1676,7 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
>  	if (data->start == dentry)
>  		goto out;
>  
> -	if (dentry->d_lockref.count <= 0) {
> +	if (lockref_is_dead_or_zero(&dentry->d_lockref)) {
>  		if (!__move_to_shrink_list(dentry, &data->dispose)) {
>  			/*
>  			 * We need an enter RCU read-side critical area that
> @@ -1747,7 +1747,7 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
>  			spin_lock(&v->d_lock);
>  			rcu_read_unlock();
>  
> -			if (unlikely(v->d_lockref.count < 0)) {
> +			if (unlikely(lockref_is_dead(&v->d_lockref))) {
>  				// It's doomed; if it isn't dead yet, notify us
>  				// once it becomes invisible to d_walk().
>  				need_wait = d_add_waiter(v, &wait);
> @@ -1823,7 +1823,7 @@ void shrink_dcache_for_umount(struct super_block *sb)
>  		spin_unlock(&sb->s_roots_lock);
>  		spin_lock(&dentry->d_lock);
>  		rcu_read_unlock();
> -		if (unlikely(dentry->d_lockref.count < 0)) {
> +		if (unlikely(lockref_is_dead(&dentry->d_lockref))) {
>  			struct completion_list wait;
>  			bool need_wait = d_add_waiter(dentry, &wait);
>  
> @@ -2822,7 +2822,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  		spin_lock(&dentry->d_lock);
>  		rcu_read_unlock();
>  		/* now we can try to grab a reference */
> -		if (unlikely(dentry->d_lockref.count < 0)) {
> +		if (unlikely(lockref_is_dead(&dentry->d_lockref))) {
>  			spin_unlock(&dentry->d_lock);
>  			goto retry;
>  		}
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
