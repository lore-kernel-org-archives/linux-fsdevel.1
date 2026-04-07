Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF03A6409
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559109; cv=none; b=kwcF+IjfItxoJJgxiWJTzuUJAoRGYV3X0XxfY2xBKUjLjQmdlvYq0aoyaunijgja3X0BLm+dfMbWj84qNCbm79nrBbbrXJpVKQR7rgWP+/+rrZ9HNuofBzYCt9O0EopKbWOE3sBug+OWv0T198fR+XCJ7ZqLt/bFOPsoX6UFS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559109; c=relaxed/simple;
	bh=5BZL4AdzWZM3JX2KsAbnIOBQXSGTB3KFBkIAppEtvTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAnyJ7sWrvyyWiaxte7jJmQJpNfa2zu1M5lyYyjpqoO6hj4IR9GuFCpcKpGS4iGgPrkWpImkh9Eid1ZkM8A73oOsytD23TnHhs8CaIbyY5oWGPn6mdQJ0EOSGc4QHOBZktaPEETOVSD7cZ57/tCp6U2c9KntlE21T97GyUpcfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=20ztr1c4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tRTwUlH0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=20ztr1c4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tRTwUlH0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="20ztr1c4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tRTwUlH0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="20ztr1c4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tRTwUlH0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A7DF4E3F4;
	Tue,  7 Apr 2026 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775559106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQXEfRIedaYcnJ+DJpAO/fuw7oGpooTScBTj/zWCXOM=;
	b=20ztr1c4w9Zfi/0V96TXseVb8eHsGEDVFlqTYbapTq8Z5rBu7x25nkHFmb6LSk2Tl6UUaU
	2bITDp9CwIn2CINmpQYj+5ojy1h0qH6anFmiHnHGp7YVFq2+Ew0Bog0zN3mBLTfXxzi7Wy
	9YHo/LYpAND7Hxb6l2rRXDjNuHRwd7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775559106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQXEfRIedaYcnJ+DJpAO/fuw7oGpooTScBTj/zWCXOM=;
	b=tRTwUlH0g5WYTFUxh8+CLX9T76Iz66fzLFKn04sNMGnP/jpSYTbYV02STlaMi7SmqTFcj+
	qs4lmieX92CgQdDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775559106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQXEfRIedaYcnJ+DJpAO/fuw7oGpooTScBTj/zWCXOM=;
	b=20ztr1c4w9Zfi/0V96TXseVb8eHsGEDVFlqTYbapTq8Z5rBu7x25nkHFmb6LSk2Tl6UUaU
	2bITDp9CwIn2CINmpQYj+5ojy1h0qH6anFmiHnHGp7YVFq2+Ew0Bog0zN3mBLTfXxzi7Wy
	9YHo/LYpAND7Hxb6l2rRXDjNuHRwd7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775559106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQXEfRIedaYcnJ+DJpAO/fuw7oGpooTScBTj/zWCXOM=;
	b=tRTwUlH0g5WYTFUxh8+CLX9T76Iz66fzLFKn04sNMGnP/jpSYTbYV02STlaMi7SmqTFcj+
	qs4lmieX92CgQdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FEE44A0B0;
	Tue,  7 Apr 2026 10:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8XDZA8Lh1GmPMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 07 Apr 2026 10:51:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C2EB8A0A81; Tue,  7 Apr 2026 12:51:41 +0200 (CEST)
Date: Tue, 7 Apr 2026 12:51:41 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: warn when a dentry is freed with a non-empty
 ->d_lru
Message-ID: <qdwhhwyiw46ues2wuua7gru42y5z5xuhwm7clog6pfvwqfwbbf@puxlyyglwov5>
References: <20260406-dcache-warn-v1-1-c665efbc005f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-dcache-warn-v1-1-c665efbc005f@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Mon 06-04-26 12:44:13, Jeff Layton wrote:
> We've had a number of panics that seem to occur on hosts with heavy
> process churn. The symptoms are a panic when invalidating /proc entries
> as a task is exiting:
> 
> queued_spin_lock_slowpath+0x153/0x270
> shrink_dentry_list+0x11d/0x220
> shrink_dcache_parent+0x68/0x110
> d_invalidate+0x90/0x170
> proc_invalidate_siblings_dcache+0xc8/0x140
> release_task+0x41b/0x510
> do_exit+0x3d8/0x9d0
> do_group_exit+0x7d/0xa0
> get_signal+0x2a9/0x6a0
> arch_do_signal_or_restart+0x1a/0x1c0
> syscall_exit_to_user_mode+0xe6/0x1c0
> do_syscall_64+0x74/0x130
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> The problem appears to be a UAF. It's freeing a shrink list of
> dentries, but one of the dentries on it has already been freed.
> 
> The d_lru field is always list_del_init()'ed, and so should be empty
> whenever a dentry is freed. Add a WARN_ON_ONCE() whenever it isn't.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Yes, looks like a sensible assert. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> We've had some of these panics internally for a while. Additionally,
> Claude also noted that these syzbot reports may be related:
> 
>     https://syzbot.org/bug?extid=0aee5e8066eddbbe7397
>     https://syzbot.org/bug?extid=e8b3520b53e78e90034e
>     https://syzbot.org/bug?extid=ad14fd37e76c579511d0
> 
> So far, I've been unable to spot the bug. Hoping this will make it
> easier.
> ---
>  fs/dcache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 7ba1801d8132..c6f475d940e3 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -429,6 +429,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
>  static void dentry_free(struct dentry *dentry)
>  {
>  	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
> +	WARN_ON_ONCE(!list_empty(&dentry->d_lru));
>  	if (unlikely(dname_external(dentry))) {
>  		struct external_name *p = external_name(dentry);
>  		if (likely(atomic_dec_and_test(&p->count))) {
> 
> ---
> base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
> change-id: 20260403-dcache-warn-a493b0e3c877
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
