Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73203330675
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699581; cv=none; b=A0NOfXE9Xzu+pOhV4cE0x7Bzd256W3Cw8qctDWZIXFatdamnFJro+j6OlcQefBQYQs13/0DijHt3ev2CJj23X9StVSullfAHal61cO0W4qQVXprxIGLWxU35pU8iIu/YE9BwZLuOXSCWsVUdM9FY9QfoRWOshLIvsS7wmqbk+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699581; c=relaxed/simple;
	bh=egzSZydNIYWYzeIe5cYCuAdEwptEKVnXrVMhcjGXpcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhCfQfmeYzLdj9Z13zqHVPLL8DFmvJFhVIXeHsTnxxpIjPqnuPqlHVkAkCnPl/YgOKyodBoG4mtw0Jotf6KPzqQ57Hkn8BJ4hD5/86TNT387aPvQS9PoxweAqDRlKtHubuG7RTYXfx9bi5A0gWXpB5WAhKXaP5edHppJWB15b9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BPg26x9C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6/vQ/YBo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BPg26x9C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6/vQ/YBo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BPg26x9C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6/vQ/YBo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BPg26x9C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6/vQ/YBo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A55D46A7DC;
	Mon, 20 Apr 2026 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776699577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGtxNvCtoXWRYcvBXRhDElXjXbFEeLF9Ioh4w3FPo3A=;
	b=BPg26x9CH4rQn9dGpnAAw9u/bfmpHW2yb0Q9jDTNZ9fp2HBdk7GnU/fBtdFMmNnEDU12xQ
	DX3ySSeKnc/4y4Fakik79P0hKQbKNJHbXaabmv5PLun7A1aWHCwvrXs7fCsgXpKz58cmeL
	Um3EAZpoPQ4onhqjLOu/UdfiZbTUK6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776699577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGtxNvCtoXWRYcvBXRhDElXjXbFEeLF9Ioh4w3FPo3A=;
	b=6/vQ/YBoloZcW34P3MJUzRJH/V2AZzpN6wOQIeJR6JmJHr8DorEzxO8k0PmBbIpxNCYopm
	ZJZNonoZQqvQMPCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BPg26x9C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="6/vQ/YBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776699577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGtxNvCtoXWRYcvBXRhDElXjXbFEeLF9Ioh4w3FPo3A=;
	b=BPg26x9CH4rQn9dGpnAAw9u/bfmpHW2yb0Q9jDTNZ9fp2HBdk7GnU/fBtdFMmNnEDU12xQ
	DX3ySSeKnc/4y4Fakik79P0hKQbKNJHbXaabmv5PLun7A1aWHCwvrXs7fCsgXpKz58cmeL
	Um3EAZpoPQ4onhqjLOu/UdfiZbTUK6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776699577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGtxNvCtoXWRYcvBXRhDElXjXbFEeLF9Ioh4w3FPo3A=;
	b=6/vQ/YBoloZcW34P3MJUzRJH/V2AZzpN6wOQIeJR6JmJHr8DorEzxO8k0PmBbIpxNCYopm
	ZJZNonoZQqvQMPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94400593AE;
	Mon, 20 Apr 2026 15:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9LYlJLlI5mlULwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 15:39:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4CE5CA0AFF; Mon, 20 Apr 2026 17:39:37 +0200 (CEST)
Date: Mon, 20 Apr 2026 17:39:37 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pidfs: fix PIDFD_THREAD flag loss when opening
 pidfds via file handles
Message-ID: <jxrygr6uhecbsjft2cbrvzhfkiupzxyy5gbwm5cjb3qw5hwiv5@laidc32prrex>
References: <20260420-work-pidfs-v1-0-4bd614e1cb33@kernel.org>
 <20260420-work-pidfs-v1-1-4bd614e1cb33@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-work-pidfs-v1-1-4bd614e1cb33@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A55D46A7DC

On Mon 20-04-26 15:32:35, Christian Brauner wrote:
> pidfs_export_open() calls dentry_open() which internally calls
> do_dentry_open() that strips O_EXCL from f_flags. Since PIDFD_THREAD is
> defined as O_EXCL, thread pidfds opened via open_by_handle_at() silently
> lose their thread-specific scope.
> 
> pidfs_alloc_file() already handles this by explicitly restoring the
> PIDFD_THREAD flag after dentry_open() returns. Factor the common
> dentry_open() + flag restoration into a shared pidfs_open_file() helper
> and use it from both call sites.
> 
> Without this fix, a pidfd obtained via open_by_handle_at() with O_EXCL
> will have PIDTYPE_TGID scope instead of PIDTYPE_PID scope, causing
> pidfd_send_signal() to deliver signals to the entire thread group
> instead of the specific thread.
> 
> Fixes: 30915e955528 ("pidfs: convert to path_from_stashed() helper")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pidfs.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index e3825ee246be..11eb53f3e50a 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -897,14 +897,28 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
>  	return 0;
>  }
>  
> +/*
> + * Open a pidfs dentry. Pidfds are always O_RDWR and PIDFD_THREAD (O_EXCL)
> + * must be restored after dentry_open() as do_dentry_open() strips it.
> + */
> +static struct file *pidfs_open_file(const struct path *path, unsigned int flags)
> +{
> +	struct file *f;
> +
> +	flags |= O_RDWR;
> +	f = dentry_open(path, flags, current_cred());
> +	if (!IS_ERR(f))
> +		f->f_flags |= (flags & PIDFD_THREAD);
> +	return f;
> +}
> +
>  static struct file *pidfs_export_open(const struct path *path, unsigned int oflags)
>  {
>  	/*
> -	 * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
> -	 * O_RDWR as pidfds always are.
> +	 * Clear O_LARGEFILE as open_by_handle_at() forces it.
>  	 */
>  	oflags &= ~O_LARGEFILE;
> -	return dentry_open(path, oflags | O_RDWR, current_cred());
> +	return pidfs_open_file(path, oflags);
>  }
>  
>  static const struct export_operations pidfs_export_operations = {
> @@ -1086,7 +1100,6 @@ static struct file_system_type pidfs_type = {
>  
>  struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>  {
> -	struct file *pidfd_file;
>  	struct path path __free(path_put) = {};
>  	int ret;
>  
> @@ -1104,13 +1117,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>  	VFS_WARN_ON_ONCE(!pid->attr);
>  
>  	flags &= ~PIDFD_STALE;
> -	flags |= O_RDWR;
> -	pidfd_file = dentry_open(&path, flags, current_cred());
> -	/* Raise PIDFD_THREAD explicitly as do_dentry_open() strips it. */
> -	if (!IS_ERR(pidfd_file))
> -		pidfd_file->f_flags |= (flags & PIDFD_THREAD);
> -
> -	return pidfd_file;
> +	return pidfs_open_file(&path, flags);
>  }
>  
>  void __init pidfs_init(void)
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
