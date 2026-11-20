Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166959;
	b=GGiBWbPxSEbfWqyCEFsXa9Mxj+dpR8jkdjGi5VfqT/XFY8X0H9Y2RG5MNy7GOY9kmivx
	 k2lKuP93NINNKXfhivcXjNe36nbv8jLkXNOhMENaMoysmEGDWoB3Ps4tanDGqY4k/JQcx
	 aKepoto8w6OKEdem57QMNao/qfkqX6eAAlg+/Ma3Uj4ocQpXnzY/2s/nnMKrovEU295zQ
	 Q4/iiR2Zffvw1AmkG19Pscb/RHKVqi0cBNpKbxaLeQAcnybXR6BmOV3VgztT52r2eAQTg
	 E59RYNg27MPylD5CRW4HtjYd4dnXpqwkMF0XGi4v2b0TNM21JOiRIW9ugO4pyHQyavg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166959;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=X2YC1TTws8KLuu08hlxiayAwsin99Gj2bgemDA7Na04=;
	b=XRZyacerJKgypx6rsoqf8BScN1r7VDTRLEPwM48raOmp3DP/sZWSafunEKQ3N8MJN42e
	 1OwcB3LfWEGSH+bLQx0ghN1rWa2JwR7zyb1HllHCf8E6gQkyBMhyCyII+zEtpvbQVe+1/
	 BBjZ0uv0JkQ7YUuggQvVy7fSp5XdBhh/dOoe6glUyEpjVnvSE83KE5kHewS5MpMOBWy4U
	 K1BT6kDUvkzjg2n0sfspH8LQXQUCw2isapyhfjPI2olQfUogCn52VQ4LALI/FYtZbqQJ3
	 nwHnB6z/jrE0ksFVTMETLBT8x7q91DrPI/staALOUOj5es9QUdUoVJV63c4I2PnYdVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=AL0p2DiZ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="2sdPf//r";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=AL0p2DiZ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="2sdPf//r";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09978606A320;
	Fri, 20 Nov 2026 09:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09978606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=AL0p2DiZ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2sdPf//r;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=AL0p2DiZ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2sdPf//r
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27C7422548;
	Fri, 20 Nov 2026 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795166957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2YC1TTws8KLuu08hlxiayAwsin99Gj2bgemDA7Na04=;
	b=AL0p2DiZrITNSOLwtt2jNKbkaqEEFn2m0lKzF9VLt3kcNACEftlMQhK0ArfpzJg/8637QH
	UXXaDoY2lb5/5u79raMtqfgM1yKXsIZubysrkhREfPZrehGoA3EJp15drrJSX338/83+v6
	wr0mdyoFWbpffzWK+oT93zV2fTrwl1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795166957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2YC1TTws8KLuu08hlxiayAwsin99Gj2bgemDA7Na04=;
	b=2sdPf//rK88LA5Wul+Vtob7aFOQO84PgRHdnhSGZ/EJQoDUrPRggP58VMZMyPSVtigkUhd
	BS5czNNL5DSrdNDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795166957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2YC1TTws8KLuu08hlxiayAwsin99Gj2bgemDA7Na04=;
	b=AL0p2DiZrITNSOLwtt2jNKbkaqEEFn2m0lKzF9VLt3kcNACEftlMQhK0ArfpzJg/8637QH
	UXXaDoY2lb5/5u79raMtqfgM1yKXsIZubysrkhREfPZrehGoA3EJp15drrJSX338/83+v6
	wr0mdyoFWbpffzWK+oT93zV2fTrwl1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795166957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2YC1TTws8KLuu08hlxiayAwsin99Gj2bgemDA7Na04=;
	b=2sdPf//rK88LA5Wul+Vtob7aFOQO84PgRHdnhSGZ/EJQoDUrPRggP58VMZMyPSVtigkUhd
	BS5czNNL5DSrdNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1BD91348F;
	Fri, 20 Nov 2026 09:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hzqnNOwSAGu2dwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Nov 2026 09:29:16 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 819BE25EE1; Fri, 20 Nov 2026 10:29:12 +0100 (CET)
Date: Fri, 20 Nov 2026 10:29:12 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v5 1/5] VFS: don't count references through ->d_parent
Message-ID: <cnud5otrkcthvaysgzyp3eokgqiax7dgn4hjrlayriwfie5iyh@73pmlo3vtifo>
References: <20261119025942.2848130-1-neilb@ownmail.net>
 <20261119025942.2848130-2-neilb@ownmail.net>
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
In-Reply-To: <20261119025942.2848130-2-neilb@ownmail.net>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org,themaw.net,lwn.net];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 19-11-26 13:57:01, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> The number of negative child dentries that a given dentry can have is
> effectively unbounded, so counting the references through ->d_parent can
> overflow ->d_lockref.count.
> 
> We only use this count so that we can know when there are no remaining
> references including from children.  However most children appear on the
> ->d_children list and the few remaining children (inactive
> DCACHE_DENTRY_CURSORs) only exist in a context were a separate reference
> is held on the parent.
> 
> So if we count whether d_children is nonempty (i.e.  dget() when it
> becomes non-empty, dput() when it comes empty) and require children not
> on ->d_children to have a reference on the parent some other way (which
> they already do), then ->d_lockref.count will not overflow and we can
> still know exactly when all references, including through ->d_parent,
> are gone.
> 
> __d_move() allows that dentries might not be on any d_children list as
> is the case for IS_ROOT() dentries.  Rather than track when this is the
> case we dget() either parent if they have an empty d_children before
> children are moved around, then dput() if they turn out to be empty
> afterwards.  This will increment dentry if it IS_ROOT(), and then
> decrement it afterwards, and will decrement the refcount on old_parent
> if its ->d_children becomes empty.
> 
> To help with this, dput_dlock() is added which warns rather than
> decrementing to zero (which should never happen).
> 
> When a DCACHE_CURSOR dentry is added to d_children, it is only ever
> added "before" or "behind" an existing child, so it will never be the
> first child added, and so never needs to adjust the refcount on the
> parent.  If it remains on the list until dput() it could be the last
> child to be removed, in which case normal handling applies in
> dentry_unlist() (where it has been moved from dentry_kill().  When a
> cursor is deliberately removed from the d_children list the refcount
> must be decremented if that leaves the list empty.
> 
> hlist_move_behind() and hlist_move_before() are added to simplify moving
> a cursor within the d_children list.  This results in some duplicate code
> as they share a common prefix with d_detach_cursor() (hlist_del)
> which is currently factored out.  We can expect the compiler to optimise
> this away and don't need to clutter the C code with it.
> 
> autofs compares d_count() with the number of known children of a dentry
> to detect if there are any concurrent references to a dentry.  These
> comparisons must be changed to reflect that we now only count "one" for
> any children rather than "one" for each child.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

Besides the objection about ino->count starting at 1 (which seems correct
AFAICS in autofs_new_ino()) this looks good to me.

								Honza

> ---
>  fs/autofs/expire.c     | 25 ++++++++++++++++---------
>  fs/dcache.c            | 40 +++++++++++++++++++++++++++++++++-------
>  fs/internal.h          | 10 ++++++++++
>  fs/libfs.c             | 14 +++++++-------
>  include/linux/dcache.h | 17 ++++++++++++++++-
>  include/linux/list.h   | 30 ++++++++++++++++++++++++++++++
>  6 files changed, 112 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
> index 5c2d459e1e48..cd276bce28c9 100644
> --- a/fs/autofs/expire.c
> +++ b/fs/autofs/expire.c
> @@ -208,15 +208,18 @@ static int autofs_tree_busy(struct vfsmount *mnt,
>  			}
>  		} else {
>  			struct autofs_info *ino = autofs_dentry_ino(p);
> -			unsigned int ino_count = READ_ONCE(ino->count);
> +			unsigned int use_count;
> +
> +			/* allow for 1 if there are any children */
> +			use_count = READ_ONCE(ino->count) > 0;
>  
>  			/* allow for dget above and top is already dgot */
>  			if (p == top)
> -				ino_count += 2;
> +				use_count += 2;
>  			else
> -				ino_count++;
> +				use_count++;
>  
> -			if (d_count(p) > ino_count) {
> +			if (d_count(p) > use_count) {
>  				top_ino->last_used = jiffies;
>  				dput(p);
>  				return 1;
> @@ -321,7 +324,7 @@ static struct dentry *should_expire(struct dentry *dentry,
>  				    unsigned int how)
>  {
>  	struct autofs_info *ino = autofs_dentry_ino(dentry);
> -	unsigned int ino_count;
> +	unsigned int use_count;
>  
>  	/* No point expiring a pending mount */
>  	if (ino->flags & AUTOFS_INF_PENDING)
> @@ -375,9 +378,11 @@ static struct dentry *should_expire(struct dentry *dentry,
>  	if (!(how & AUTOFS_EXP_LEAVES)) {
>  		/* Not a forced expire? */
>  		if (!(how & AUTOFS_EXP_FORCED)) {
> +			/* dentry has any children? */
> +			use_count = READ_ONCE(ino->count) > 0;
>  			/* ref-walk currently on this dentry? */
> -			ino_count = READ_ONCE(ino->count) + 1;
> -			if (d_count(dentry) > ino_count)
> +			use_count += 1;
> +			if (d_count(dentry) > use_count)
>  				return NULL;
>  		}
>  
> @@ -392,9 +397,11 @@ static struct dentry *should_expire(struct dentry *dentry,
>  
>  		/* Not a forced expire? */
>  		if (!(how & AUTOFS_EXP_FORCED)) {
> +			/* dentry has any children? */
> +			use_count = READ_ONCE(ino->count) > 0;
>  			/* ref-walk currently on this dentry? */
> -			ino_count = READ_ONCE(ino->count) + 1;
> -			if (d_count(dentry) > ino_count)
> +			use_count += 1;
> +			if (d_count(dentry) > use_count)
>  				return NULL;
>  		}
>  
> diff --git a/fs/dcache.c b/fs/dcache.c
> index ba17f49f8a63..0dc54ba31d8c 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -701,6 +701,8 @@ static inline void dentry_unlist(struct dentry *dentry)
>  		return;
>  	}
>  	__hlist_del(&dentry->d_sib);
> +	if (hlist_empty(&dentry->d_parent->d_children))
> +		dentry->d_parent->d_lockref.count--;
>  	/*
>  	 * Cursors can move around the list of children.  While we'd been
>  	 * a normal list member, it didn't matter - ->d_sib.next would've
> @@ -874,7 +876,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
>  	spin_unlock(&dentry->d_lock);
>  	if (likely(can_free))
>  		dentry_free(dentry);
> -	if (parent && --parent->d_lockref.count) {
> +	if (parent && parent->d_lockref.count) {
>  		spin_unlock(&parent->d_lock);
>  		return NULL;
>  	}
> @@ -2058,7 +2060,9 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
>  	 * don't need child lock because it is not subject
>  	 * to concurrency here
>  	 */
> -	dentry->d_parent = dget_dlock(parent);
> +	dentry->d_parent = parent;
> +	if (hlist_empty(&parent->d_children))
> +		dget_dlock(parent);
>  	hlist_add_head(&dentry->d_sib, &parent->d_children);
>  	spin_unlock(&parent->d_lock);
>  
> @@ -2130,7 +2134,7 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
>  	struct dentry *dentry = d_alloc_anon(parent->d_sb);
>  	if (dentry) {
>  		dentry->d_flags |= DCACHE_DENTRY_CURSOR | DCACHE_NORCU;
> -		dentry->d_parent = dget(parent);
> +		dentry->d_parent = parent;
>  	}
>  	return dentry;
>  }
> @@ -2907,7 +2911,9 @@ struct dentry *__d_alloc_parallel(struct dentry *parent,
>  
>  	new->d_flags |= DCACHE_PAR_LOOKUP;
>  	spin_lock(&parent->d_lock);
> -	new->d_parent = dget_dlock(parent);
> +	new->d_parent = parent;
> +	if (hlist_empty(&parent->d_children))
> +		dget_dlock(parent);
>  	hlist_add_head(&new->d_sib, &parent->d_children);
>  	if (parent->d_flags & DCACHE_DISCONNECTED)
>  		new->d_flags |= DCACHE_DISCONNECTED;
> @@ -3300,12 +3306,21 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
>  
>  	/* ... and switch them in the tree */
>  	dentry->d_parent = target->d_parent;
> +
> +	/*
> +	 * Ensure ref count on parents reflect d_children being non-empty,
> +	 * which they almost certainly are.  If either end up being empty,
> +	 * this is handled below after the moves.
> +	 */
> +	if (hlist_empty(&old_parent->d_children))
> +		dget_dlock(old_parent);
> +	if (dentry->d_parent != old_parent &&
> +	    hlist_empty(&dentry->d_parent->d_children))
> +		dget_dlock(dentry->d_parent);
> +
>  	if (!exchange) {
>  		copy_name(dentry, target);
>  		target->d_hash.pprev = NULL;
> -		dentry->d_parent->d_lockref.count++;
> -		if (dentry != old_parent) /* wasn't IS_ROOT */
> -			WARN_ON(!--old_parent->d_lockref.count);
>  	} else {
>  		target->d_parent = old_parent;
>  		swap_names(dentry, target);
> @@ -3318,6 +3333,17 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
>  	if (!hlist_unhashed(&dentry->d_sib))
>  		__hlist_del(&dentry->d_sib);
>  	hlist_add_head(&dentry->d_sib, &dentry->d_parent->d_children);
> +
> +	/*
> +	 * Adjust parent refcounts if either d_children ended up empty.
> +	 * This should only ever be old_parent.
> +	 */
> +	if (hlist_empty(&old_parent->d_children))
> +		dput_dlock(old_parent);
> +	if (dentry->d_parent != old_parent &&
> +	    hlist_empty(&dentry->d_parent->d_children))
> +		dput_dlock(dentry->d_parent);
> +
>  	__d_rehash(dentry);
>  	fsnotify_update_flags(dentry);
>  	fscrypt_handle_d_move(dentry);
> diff --git a/fs/internal.h b/fs/internal.h
> index 3f2fbac40f8e..22e018429759 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -235,6 +235,16 @@ extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
>  extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
>  				const struct qstr *name, unsigned *seq);
>  
> +static inline void d_detach_cursor(struct dentry *cursor)
> +{
> +	if (hlist_unhashed(&cursor->d_sib))
> +		return;
> +	hlist_del_init(&cursor->d_sib);
> +	if (hlist_empty(&cursor->d_parent->d_children))
> +		/* That was the last child, must drop implied reference */
> +		dput_dlock(cursor->d_parent);
> +}
> +
>  /*
>   * pipe.c
>   */
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 46e0205154e7..9f7f6bf5666a 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -128,9 +128,7 @@ static struct dentry *scan_positives(struct dentry *cursor,
>  			count = 1;
>  		}
>  		if (need_resched()) {
> -			if (!hlist_unhashed(&cursor->d_sib))
> -				__hlist_del(&cursor->d_sib);
> -			hlist_add_behind(&cursor->d_sib, &d->d_sib);
> +			hlist_move_behind(&cursor->d_sib, &d->d_sib);
>  			p = &cursor->d_sib.next;
>  			spin_unlock(&dentry->d_lock);
>  			cond_resched();
> @@ -166,9 +164,10 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
>  			to = scan_positives(cursor, &dentry->d_children.first,
>  					    offset - 2, NULL);
>  		spin_lock(&dentry->d_lock);
> -		hlist_del_init(&cursor->d_sib);
>  		if (to)
> -			hlist_add_behind(&cursor->d_sib, &to->d_sib);
> +			hlist_move_behind(&cursor->d_sib, &to->d_sib);
> +		else
> +			d_detach_cursor(cursor);
>  		spin_unlock(&dentry->d_lock);
>  		dput(to);
>  
> @@ -210,9 +209,10 @@ int dcache_readdir(struct file *file, struct dir_context *ctx)
>  		p = &next->d_sib.next;
>  	}
>  	spin_lock(&dentry->d_lock);
> -	hlist_del_init(&cursor->d_sib);
>  	if (next)
> -		hlist_add_before(&cursor->d_sib, &next->d_sib);
> +		hlist_move_before(&cursor->d_sib, &next->d_sib);
> +	else
> +		d_detach_cursor(cursor);
>  	spin_unlock(&dentry->d_lock);
>  	dput(next);
>  
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index aaa4ba7a1299..fff8393ec06b 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -330,7 +330,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
>  /* Allocation counts.. */
>  
>  /**
> - * dget_dlock -	get a reference to a dentry
> + * dget_dlock -	get a reference to a dentry while locked
>   * @dentry: dentry to get a reference to
>   *
>   * Given a live dentry, increment the reference count and return the dentry.
> @@ -345,6 +345,21 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
>  	return dentry;
>  }
>  
> +/**
> + * dput_dlock -	put a reference to a dentry while locked
> + * @dentry: dentry to get a reference to
> + *
> + * Given a live dentry, decrement the reference count and return the dentry.
> + * Caller must hold @dentry->d_lock.  The dentry must still have
> + * a reference after the decrement.  This can be used when two
> + * references are held and one must be dropped.
> + */
> +static inline struct dentry *dput_dlock(struct dentry *dentry)
> +{
> +	if (!WARN_ON(dentry->d_lockref.count <= 1))
> +		dentry->d_lockref.count--;
> +	return dentry;
> +}
>  
>  /**
>   * dget - get a reference to a dentry
> diff --git a/include/linux/list.h b/include/linux/list.h
> index e3753695e76c..ab8ad0d18d09 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -1123,6 +1123,36 @@ static inline void hlist_add_behind(struct hlist_node *n,
>  		WRITE_ONCE(n->next->pprev, &n->next);
>  }
>  
> +/**
> + * hlist_move_behind - move an hlist node to a new location in list
> + * @n: hlist node to be moved
> + * @prev: hlist node after which @n should be added.
> + *
> + * @n may be on the list or unhashed but must not be @prev.
> + * It is removed if necessary and re-added after @prev.
> + */
> +static inline void hlist_move_behind(struct hlist_node *n,
> +				     struct hlist_node *prev)
> +{
> +	hlist_del_init(n);
> +	hlist_add_behind(n, prev);
> +}
> +
> +/**
> + * hlist_move_before - move an hlist node to a new location in list
> + * @n: hlist node to be moved
> + * @next: hlist node before which @n should be added.
> + *
> + * @n may be on the list or unhashed but must not be @next.
> + * It is removed if necessary and re-added before @next.
> + */
> +static inline void hlist_move_before(struct hlist_node *n,
> +				     struct hlist_node *next)
> +{
> +	hlist_del_init(n);
> +	hlist_add_before(n, next);
> +}
> +
>  /**
>   * hlist_add_fake - create a fake hlist consisting of a single headless node
>   * @n: Node to make a fake list out of
> 
> base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
> -- 
> 2.50.0.107.gf914562f5916.dirty
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
