Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9D2F617C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065524; cv=none; b=JHYKHKsLtV7YvwPne7ZtGeNytn4h6ZIVHXJQicfqN2G91XNl/+6Mkh2UhP80axrYppzEwNuVuC4+7Dh3sYH8GtB8aGbYMDuu6WIxPV322I9mSLqX3515TRkTRhg7W5cSJDKJRXX95+VTvNE3+TQ7hey9VqnI/doj7u4l/snkTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065524; c=relaxed/simple;
	bh=oU1GHFk7i1dejkvKl6CthCYfsaP+QybMuMQE22q+i3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAPIEsq8VeBOXohftLFgRM/uXZDV6sO2RrWxcKR+3/n6S6AV8Ljnob3Q/y2Y4ObFDHegLDl1bC/XyyLN0OEC960ylkUz+1c1FzvDdxXzs5ToybHg3XD9ddLDjT6vzrNy36m5N33cVYVraGoomugw5EnXMIln1/QTIWyW0kQkIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X2WbQjWg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=06TGD1aH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X2WbQjWg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=06TGD1aH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X2WbQjWg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="06TGD1aH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X2WbQjWg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="06TGD1aH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 838804D2E7;
	Wed,  1 Apr 2026 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775065520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0t9/TDazaEKKOaWIAjtayuQAJqK5yo0rY0RW2LWkiU4=;
	b=X2WbQjWgJ8dFuZ1f8fTeUdaWrebRMnKzKx/7XafJT+fJYfI3BKWdcSwZPGy+mbU4QZi7ND
	IvVX+w9uF3bso0vmCBBEiZSNnt5Or8CWJdeROvwTbRauYstbpnBJBuULe5iVUhj0t9zJrJ
	Xnd9Ut/Hgr+GvafA8fLccoF+2Q3ORBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775065520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0t9/TDazaEKKOaWIAjtayuQAJqK5yo0rY0RW2LWkiU4=;
	b=06TGD1aHls0Gu3ioEJVOd9bubsi6FAqJbgG7/7/f2zQ61ywHBoTjVoxVhwgfH68iPTtRlU
	Xrjfe0usXF1jzWBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775065520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0t9/TDazaEKKOaWIAjtayuQAJqK5yo0rY0RW2LWkiU4=;
	b=X2WbQjWgJ8dFuZ1f8fTeUdaWrebRMnKzKx/7XafJT+fJYfI3BKWdcSwZPGy+mbU4QZi7ND
	IvVX+w9uF3bso0vmCBBEiZSNnt5Or8CWJdeROvwTbRauYstbpnBJBuULe5iVUhj0t9zJrJ
	Xnd9Ut/Hgr+GvafA8fLccoF+2Q3ORBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775065520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0t9/TDazaEKKOaWIAjtayuQAJqK5yo0rY0RW2LWkiU4=;
	b=06TGD1aHls0Gu3ioEJVOd9bubsi6FAqJbgG7/7/f2zQ61ywHBoTjVoxVhwgfH68iPTtRlU
	Xrjfe0usXF1jzWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7785B4A0B0;
	Wed,  1 Apr 2026 17:45:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rJ0sHbBZzWnPSgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Apr 2026 17:45:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2AF05A0B39; Wed,  1 Apr 2026 19:45:05 +0200 (CEST)
Date: Wed, 1 Apr 2026 19:45:05 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] fs: handle potential filesystems which use
 I_DONTCACHE and drop the lock in ->drop_inode
Message-ID: <itaix3v2pgkrlvhxetyepfzrbyg7bnigghrkrdofznas37nsyf@irriakb7cwzj>
References: <20260331160851.3854954-1-mjguzik@gmail.com>
 <20260331160851.3854954-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331160851.3854954-4-mjguzik@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 31-03-26 18:08:50, Mateusz Guzik wrote:
> f2fs and ntfs play games where they transitioning the refcount 0->1 and release

I don't see ntfs providing .drop_inode at all in current Linu's kernel? The
f2fs case is indeed ugly and a gross hack. But I don't see easy way how to
fix that for now.

> the inode spinlock, allowing other threads to grab a ref of their own.
> 
> They also return 0 in that case, making this problem harmless.
> 
> However, should they start using the I_DONTCACHE machinery down the road
> while retaining the above, iput_final() will get a race where it can
> proceed to teardown an inode with references.
> 
> The easiest way out for the time being is to future-proof it by
> predicating caching on the count.
> 
> Developing better ->drop_inode semantics and sanitizing all users is
> left as en exercise for the reader.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/inode.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index e397a4b56671..013470e6d144 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1935,20 +1935,29 @@ static void iput_final(struct inode *inode)
>  	else
>  		drop = inode_generic_drop(inode);
>  
> -	if (!drop &&
> -	    !(inode_state_read(inode) & I_DONTCACHE) &&
> -	    (sb->s_flags & SB_ACTIVE)) {
> +	/*
> +	 * FIXME: there are ->drop_inode hooks playing nasty games releasing the
> +	 * spinlock and temporarily grabbing refs, in turn opening a possibility
> +	 * someone else will sneak in and grab a ref while it happens.
> +	 *
> +	 * If such a hook returns 0 (== don't drop) it ends being up harmless as long
> +	 * as the inode is not marked with I_DONTCACHE. Otherwise we are proceeding
> +	 * with teardown despite references being present.
> +	 *
> +	 * Damage-control the problem by including the count in the decision. However,
> +	 * assert no refs showed up if the hook decided to drop the inode.
> +	 */

Would be better to format the comment to fit 80 columns...

> +	if (drop)
> +		VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
> +
> +	if (unlikely(icount_read(inode) > 0) ||
> +	    (!drop && !(inode_state_read(inode) & I_DONTCACHE) &&
> +	    (sb->s_flags & SB_ACTIVE))) {

Any reason why you want to gracefully handle the buggy filesystem code? If
a filesystem playing games with .drop_inode starts using I_DONTCACHE, it
will BUG_ON below which is good enough I'd say. I don't think we need to
handle buggy fs drivers any better...

								Honza

>  		__inode_lru_list_add(inode, true);
>  		spin_unlock(&inode->i_lock);
>  		return;
>  	}
>  
> -	/*
> -	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
> -	 * Note we only execute this if the verdict was to drop the inode.
> -	 */
> -	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
> -
>  	if (drop) {
>  		inode_state_set(inode, I_FREEING);
>  	} else {
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
