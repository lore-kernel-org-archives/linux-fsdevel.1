Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1AC3CAE83
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853101; cv=none; b=fKDrzBgdoL1YHxYgeVRljWeyn2qzZEz9cv1kg+E3/aDTWeBvR76eeiIzGDHW5CaMdUKUHZIWCdkcSRhouvSkM6k5RxnQ0M9L3GpA1qcvSifeJuUEGI392MMWWYH9RbWa+NIfwfpaS3a+vYzPXP5apEQDHAYNl5Dea/2f+1xPH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853101; c=relaxed/simple;
	bh=FNRcS7NgRR47moLI+UzB7KIpbono1ih9GJ8s3rIGW8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0klPjUKabGsMXlhyJE6BO/r4aKJMnV4E/8EBV0w7lfI3E3aYi5iGHo0jiO9xo8EdInx9dRi/YYMhtZX8uEDoiEIZvI0glqpleqa45/aFYghdKx+5vdnNlBo2ezdD9bO28ytzCLNJk9g3h8VSTJHj4Xkvl9HHrQfaL7lqo0CfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lRn456rr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rw2Wn2qf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lRn456rr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rw2Wn2qf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lRn456rr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rw2Wn2qf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lRn456rr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rw2Wn2qf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 308D16A81C;
	Wed, 22 Apr 2026 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776853097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kch9Xtuh1ldvJ0sFIygIb3K4O08m2GeDmUv3kivXqY=;
	b=lRn456rrHhl9xOkK0ISzC+b628qVoOKBPzP5oxWslggTzpBXMYs8pth/4YmLjqZIfgUHXB
	veALZ+crs62g76jxRnfqpxksw+Q+elox+UvU2ndV0RQr0mTDErWZubmAryflOVPo0i/kzg
	mMkiiIzwNVjEDjlu/Vi5APKvWlIkY30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776853097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kch9Xtuh1ldvJ0sFIygIb3K4O08m2GeDmUv3kivXqY=;
	b=Rw2Wn2qfsWciWeuEpsuxLBzkP7SQs7lmbMdqlud7EkjAojEqvamdTuOsr4LxPXx+kaGIr9
	OfX9/PYuMF7oYuBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776853097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kch9Xtuh1ldvJ0sFIygIb3K4O08m2GeDmUv3kivXqY=;
	b=lRn456rrHhl9xOkK0ISzC+b628qVoOKBPzP5oxWslggTzpBXMYs8pth/4YmLjqZIfgUHXB
	veALZ+crs62g76jxRnfqpxksw+Q+elox+UvU2ndV0RQr0mTDErWZubmAryflOVPo0i/kzg
	mMkiiIzwNVjEDjlu/Vi5APKvWlIkY30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776853097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Kch9Xtuh1ldvJ0sFIygIb3K4O08m2GeDmUv3kivXqY=;
	b=Rw2Wn2qfsWciWeuEpsuxLBzkP7SQs7lmbMdqlud7EkjAojEqvamdTuOsr4LxPXx+kaGIr9
	OfX9/PYuMF7oYuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23922593AF;
	Wed, 22 Apr 2026 10:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gcarCGmg6GmKaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 10:18:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8B1E4A0B60; Wed, 22 Apr 2026 12:18:08 +0200 (CEST)
Date: Wed, 22 Apr 2026 12:18:08 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] fs: relocate and tidy up ihold()
Message-ID: <7ir4aysxycsjc5mlqkokvbx7vx75m2mbnlwfh2mv3hjsvmu7i3@k34ucvjvkv42>
References: <20260421182538.1215894-1-mjguzik@gmail.com>
 <20260421182538.1215894-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421182538.1215894-3-mjguzik@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 21-04-26 20:25:37, Mateusz Guzik wrote:
> The placement was illogical, move it next to igrab().
> 
> Take this opportunity to add docs and an assert on the refcount. While
> its modification remains gated with a WARN_ON, the new assert will also
> dump the inode state which might aid debugging.
> 
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

I think I've already reviewed this. Anyway feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index e57873136093..17f0804b429c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -518,15 +518,6 @@ static void init_once(void *foo)
>  	inode_init_once(inode);
>  }
>  
> -/*
> - * get additional reference to inode; caller must already hold one.
> - */
> -void ihold(struct inode *inode)
> -{
> -	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
> -}
> -EXPORT_SYMBOL(ihold);
> -
>  struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
>  					    struct inode *inode, u32 bit)
>  {
> @@ -1572,6 +1563,17 @@ ino_t iunique(struct super_block *sb, ino_t max_reserved)
>  }
>  EXPORT_SYMBOL(iunique);
>  
> +/**
> + * ihold - get a reference on the inode, provided you already have one
> + * @inode:	inode to operate on
> + */
> +void ihold(struct inode *inode)
> +{
> +	VFS_BUG_ON_INODE(icount_read_once(inode) < 1, inode);
> +	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
> +}
> +EXPORT_SYMBOL(ihold);
> +
>  struct inode *igrab(struct inode *inode)
>  {
>  	spin_lock(&inode->i_lock);
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
