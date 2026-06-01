Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5B3783C1
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319079; cv=none; b=ZgfALdy4BBjxfgMfUQhn9gBCSn0LfP5jhfEgPqxyRHmAjZO9P33nXAd0JxtloDbbEso7oXkWEJWrrK2NaSFZmXw6UvX9XhHvtwDLbXXwZEVVlkz8LFZMAFIRunOk398G0zLg+jy9bIpRe9azhjBc0vpyWrpZK4Z0TLTu3PbG+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319079; c=relaxed/simple;
	bh=XLJpB0NoNd5a0xV2z3M6vkIicd+vdYUvjre2FxwY718=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCoBQ69qAd4MaUTPQnPzW85p0rPQFvtLdQLD67DT3nr4/wR3f4LCk1JdUR0LZ37HPy55tFTlIRPB8j7Jpz50OrN/ewSkbCmnd+XwKFlFpKM6vu/T4F7romXN2VwXmkZMTERe19IYR4r01elpuorb3fuQT1pC8Vr2EeVjUdcRR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TqwkvYoo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/08NNac; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TqwkvYoo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/08NNac; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TqwkvYoo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/08NNac";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TqwkvYoo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/08NNac"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BB926B71A;
	Mon,  1 Jun 2026 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780319074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERTRb1GjFyLhR0nxqG8SkrVSP8iWe7aK/BBY0/uWnXg=;
	b=TqwkvYooxcu2UIFZuFTflICvha+1v84HWxjgO9AcsfuRoYC7OcFj8+/EN6Q/zIBsPkP7jd
	tZfTbIDJPLSZYPt+oRmeknN0hDxElXTloC6t4cFTWUUDt8oZ4JWZ5FcW02FhxbXUqSVRwA
	qF8eAdYpS424DS4YrmlvqSwjoCFshNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780319074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERTRb1GjFyLhR0nxqG8SkrVSP8iWe7aK/BBY0/uWnXg=;
	b=X/08NNac2f7EySDJxODAtex4hHf6h/N+GckinKN8K4dlkg6/YTJL3K5kN8DhBv0jz/7qpE
	SZ4f9nIdUEtee/Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780319074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERTRb1GjFyLhR0nxqG8SkrVSP8iWe7aK/BBY0/uWnXg=;
	b=TqwkvYooxcu2UIFZuFTflICvha+1v84HWxjgO9AcsfuRoYC7OcFj8+/EN6Q/zIBsPkP7jd
	tZfTbIDJPLSZYPt+oRmeknN0hDxElXTloC6t4cFTWUUDt8oZ4JWZ5FcW02FhxbXUqSVRwA
	qF8eAdYpS424DS4YrmlvqSwjoCFshNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780319074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERTRb1GjFyLhR0nxqG8SkrVSP8iWe7aK/BBY0/uWnXg=;
	b=X/08NNac2f7EySDJxODAtex4hHf6h/N+GckinKN8K4dlkg6/YTJL3K5kN8DhBv0jz/7qpE
	SZ4f9nIdUEtee/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5294E779A7;
	Mon,  1 Jun 2026 13:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /0clFGKDHWrJKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jun 2026 13:04:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DFEA6A0EBE; Mon, 01 Jun 2026 15:04:33 +0200 (CEST)
Date: Mon, 1 Jun 2026 15:04:33 +0200
From: Jan Kara <jack@suse.cz>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH] vfs: document locking for mnt_notify_add()
Message-ID: <qyxetdsywarovuartxqqeazkqpdedsiwam2pke4ocaqgv7sspw@rgkyf72i57zo>
References: <20260529-vfs-mnt-notify-comment-v1-1-5becd17a15c3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-vfs-mnt-notify-comment-v1-1-5becd17a15c3@google.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Score: -3.80

On Fri 29-05-26 21:38:08, Jann Horn wrote:
> The locking in mnt_notify_add(), which was introduced in commit
> bf630c401641 ("vfs: add notifications for mount attach and detach"), is a
> bit gnarly.
> notify_list is protected by namespace_lock, but there are cases where
> mnt_notify_add() is called without holding namespace_lock, for example:
> 
>     __do_sys_fsmount -> mnt_add_to_ns -> mnt_notify_add
> 
> Luckily, in cases where the namespace_lock isn't held, the namespace is
> always freshly created and can't have any fsnotify marks yet, which means
> the notify_list isn't actually accessed.
> 
> The existing comment claims that not accessing the notify_list in these
> cases is merely an optimization, which is wrong. Fix the comment, and add a
> locking assertion.
> 
> To allow mnt_notify_add() to reference the namespace_sem, move it into
> fs/namespace.c.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks for looking into this. Adding Miklos to CC who actually wrote that
code. Also in cases like path_pivot_root() I don't think we hold the
namespace_sem so the locking is even more complicated if it is correct at
all. Miklos?

								Honza

> ---
> I'm sending this patch because I spent some time staring at this
> trying to figure out if this was buggy or not.
> 
> I don't know if this is working as intended or working by accident,
> and it might be nice if this was cleaned up to have simpler locking;
> but for now, document what's going on for the next person who stares
> at this code.
> ---
>  fs/mount.h     | 10 +---------
>  fs/namespace.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index e0816c11a198..99016db2f408 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -219,15 +219,7 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
>  }
>  
>  #ifdef CONFIG_FSNOTIFY
> -static inline void mnt_notify_add(struct mount *m)
> -{
> -	/* Optimize the case where there are no watches */
> -	if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
> -	    (m->prev_ns && m->prev_ns->n_fsnotify_marks))
> -		list_add_tail(&m->to_notify, &notify_list);
> -	else
> -		m->prev_ns = m->mnt_ns;
> -}
> +void mnt_notify_add(struct mount *m);
>  #else
>  static inline void mnt_notify_add(struct mount *m)
>  {
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe919abd2f01..56f130b49e58 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6431,6 +6431,25 @@ bool mnt_may_suid(struct vfsmount *mnt)
>  	       current_in_userns(mnt->mnt_sb->s_user_ns);
>  }
>  
> +#ifdef CONFIG_FSNOTIFY
> +void mnt_notify_add(struct mount *m)
> +{
> +	/*
> +	 * notify_list is protected by namespace_sem.
> +	 * It is possible to call this function without holding namespace_sem,
> +	 * but in those cases, the mount is associated with a new mount
> +	 * namespace that can't have any fanotify marks yet.
> +	 */
> +	if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
> +	    (m->prev_ns && m->prev_ns->n_fsnotify_marks)) {
> +		rwsem_assert_held_write(&namespace_sem);
> +		list_add_tail(&m->to_notify, &notify_list);
> +	} else {
> +		m->prev_ns = m->mnt_ns;
> +	}
> +}
> +#endif
> +
>  static struct ns_common *mntns_get(struct task_struct *task)
>  {
>  	struct ns_common *ns = NULL;
> 
> ---
> base-commit: 8fde5d1d47f69db6082dfa34500c27f8485389a5
> change-id: 20260529-vfs-mnt-notify-comment-4369e0558f0b
> 
> Best regards,
> --  
> Jann Horn <jannh@google.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
