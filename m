Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D73537F1
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667715; cv=none; b=Zx81jr9d6mrg/LgmS17ReGsI0Tn5BL4//Eqps6xVE5upHpfld3/rVlQCCc6TNw+wn/7WIFCwi9y5RUxVREIMFfRL5yRxK1hlJsjCioABaN0IBjUlztGsrk+dOPnQ4OlzUNtaI0bSBS86K5N88QLAXozS6Da7Mz6GTumGyc8DT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667715; c=relaxed/simple;
	bh=h6BTwiBWIazkTEPClgqSAWJM1oVCLlO3AoXPOGhJwZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTMy6t+iT+uo+JH6yCd1JI+l0kiCtlnQ5IWOk4x7W48mdzCS4+ZKGHu3Mv1XRmHuON8MLbr171zXA08+LFg4nCsg6YeTeWyMFppZJexD/Frr1fct8CMfq2bbZCD6sRKNWcGcUDCjR7RyLGGjM2GHHZi2POV9367wrzaYounYks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dvr2P59S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WN68tshX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dvr2P59S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WN68tshX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dvr2P59S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WN68tshX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dvr2P59S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WN68tshX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B110F4EAB0;
	Wed,  8 Apr 2026 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775667705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6XnQBQc+ka7sQjyBZa0Xxjm8wcETBhneh2nSiVj3Ok=;
	b=Dvr2P59SgvLBjeejgg/t3yFgMab4f52JXlC1NJd4GAVGDqDWjRjQ/B6jVCDJr7W+1PQM4A
	I1Smu+QJaLNDq/zgmfMtLFLuwFYVF3TXzvAanYheLKB5i8sDbiSPwSH8HD47k9PbbvF5jn
	1P4PD5161PLjbvHZkwUvlIY83KgKqgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775667705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6XnQBQc+ka7sQjyBZa0Xxjm8wcETBhneh2nSiVj3Ok=;
	b=WN68tshXwSDs6uIdPmfmGVvxQn6Q0Akk1/FRYYlAODva27l9tmtTHn0bKC87aNxVWrnUdN
	woHMrfPvw4FM8wAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775667705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6XnQBQc+ka7sQjyBZa0Xxjm8wcETBhneh2nSiVj3Ok=;
	b=Dvr2P59SgvLBjeejgg/t3yFgMab4f52JXlC1NJd4GAVGDqDWjRjQ/B6jVCDJr7W+1PQM4A
	I1Smu+QJaLNDq/zgmfMtLFLuwFYVF3TXzvAanYheLKB5i8sDbiSPwSH8HD47k9PbbvF5jn
	1P4PD5161PLjbvHZkwUvlIY83KgKqgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775667705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6XnQBQc+ka7sQjyBZa0Xxjm8wcETBhneh2nSiVj3Ok=;
	b=WN68tshXwSDs6uIdPmfmGVvxQn6Q0Akk1/FRYYlAODva27l9tmtTHn0bKC87aNxVWrnUdN
	woHMrfPvw4FM8wAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A56EA4A0B3;
	Wed,  8 Apr 2026 17:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /wdgKPmJ1mmVfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Apr 2026 17:01:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4597CA0A7E; Wed,  8 Apr 2026 19:01:37 +0200 (CEST)
Date: Wed, 8 Apr 2026 19:01:37 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] fs: allow lockless ->i_count bumps as long as it
 does not transition 0->1
Message-ID: <4fhhn57gzilze4bgkwinanbfovd3iez2s7ajujiob3kkpu6kcy@ic55f5utqogs>
References: <20260331160851.3854954-1-mjguzik@gmail.com>
 <20260331160851.3854954-5-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331160851.3854954-5-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 31-03-26 18:08:51, Mateusz Guzik wrote:
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

Nice!

> diff --git a/fs/dcache.c b/fs/dcache.c
> index 9ceab142896f..b63450ebb85c 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2033,6 +2033,10 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
>  	__d_instantiate(entry, inode);
>  	spin_unlock(&entry->d_lock);
>  	WARN_ON(!(inode_state_read(inode) & I_NEW));
> +	/*
> +	 * Paired with igrab_try_lockless()
> +	 */
> +	smp_wmb();
>  	inode_state_clear(inode, I_NEW | I_CREATING);
>  	inode_wake_up_bit(inode, __I_NEW);
>  	spin_unlock(&inode->i_lock);

It's a bit sad you're reintroducing part of the barries you've removed in
a27628f43634 ("fs: rework I_NEW handling to operate without fences") but I
guess it's worth it.

> +/*
> + * igrab_try_lockless - special inode refcount acquire primitive for the inode hash
> + * (don't use elsewhere!)

Why is this special for inode hash? Because of I_NEW & I_CREATING checks?
Then I'd call this function igrab_from_hash() or something like that and
integrate there also all the i_state checking and waiting common between
find_inode() and find_inode_fast().

Otherwise the patch looks good.

								Honza

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
> +static bool igrab_try_lockless(struct inode *inode)
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
> index 07363fce4406..119e0a3d2f42 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2234,8 +2234,8 @@ static inline int icount_read_once(const struct inode *inode)
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
