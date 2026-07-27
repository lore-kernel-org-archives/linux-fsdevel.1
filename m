Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8373A873C
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167847; cv=none; b=BgeGCocy5Jq9d1O8sgEHxrvjKjbAaf/KClKUH4yo/9SZNkEtYtBAuBQn3yluhSb4Yr0BkzOSO5mUursB4+idkW55A16+97gcsGaIMS/1bvNadspK2hevYo/44bxCScuc0j2EV9wXYxwceKGLqHZvYorKhbGoloYSdpRKXa4GvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167847; c=relaxed/simple;
	bh=DxYRo6/OcOwrAc9jvJMva38QnpvhfJT4IXjqt/fmTTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ8g4IbZhr9y47fwoxriKm/gZIKuorcJ5ZcPy5d7qzjYW/CUlM35iClCGOAPKjTlO8HesLlx8z8YpG1ooANmd4STXlegQGlYvWYUxqYVMpB4GWWG6fdx0HM9OJCauHa9MK/P1h+Ej1GEICYUJsZvkUqU1WXdFK6APrTZ/q+Pse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1p8HshxJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1884Zwi9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qe5v+oyJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qPDDpjzi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1p8HshxJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1884Zwi9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qe5v+oyJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qPDDpjzi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FC477B980;
	Mon, 27 Jul 2026 15:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785167838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eamMMT550ofEglpL8nzRc2oDOeSt3/PH6Ml02EKhIQ8=;
	b=1p8HshxJHatb2QpGfKqCpdCzlvpC5pSHxSOes+UVA/HrheSfomvXRA9BzcuPq4/oTP/b+N
	5znBHvUpXABM0IeJy+eOHpUc9Av7bHC/tMSROUS+kQc65wV5EXry0644iDePPuRPVRI7qK
	Eht1tC3Mc/fSYock5mYXU4Nrx781nWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785167838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eamMMT550ofEglpL8nzRc2oDOeSt3/PH6Ml02EKhIQ8=;
	b=1884Zwi92BJcTjM9nggxCfNT2JDZeVezSwpr9bpV4K0ll/vbvMrx27aubP3hVbTOGGy7Gc
	PRiENKlif6Pf+ZBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785167834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eamMMT550ofEglpL8nzRc2oDOeSt3/PH6Ml02EKhIQ8=;
	b=Qe5v+oyJBD4Qm6oLT7hYrBG4phAugQ7fgx7lkV1ymQnaz+4f56KbsZPo2Maj+DWa+5ovlB
	Y/lyPNQrz5rAxSt7XZFvGTERLABsDsAHj6/JRGb6hlbKU50GkqLkp+o8RBIpMNjBU4ZcWo
	AeUmqXZA4R7QPbKsq6I5KEuX+6MpKsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785167834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eamMMT550ofEglpL8nzRc2oDOeSt3/PH6Ml02EKhIQ8=;
	b=qPDDpjzi0CDVbmVZWm1IHOEmkVCcpmEyOnVytg4BheOVN4fOVma+82qSM1GYOhfjq4Ttlc
	7KkMHCHKSXXZccCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66252779B9;
	Mon, 27 Jul 2026 15:57:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TTLhGNp/Z2rxGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Jul 2026 15:57:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 11E48A0BA1; Mon, 27 Jul 2026 17:57:14 +0200 (CEST)
Date: Mon, 27 Jul 2026 17:57:14 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Li Chen <me@linux.beauty>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] pidfs: preserve thread pidfds reopened by file handle
Message-ID: <v2etqvlc6cq3al2pbdf43gu5b4d5f5py7dagkblbbt6mxltfro@kospd7xpqeyo>
References: <20260716052726.1032092-1-me@linux.beauty>
 <ks7xfhn7pzzm267bcfo725xwqa6famsv5yulmzgqt7hjdmepep@zm2dw2djd7yb>
 <20260722-esszimmer-umsetzen-nennt-ed5fc604300a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-esszimmer-umsetzen-nennt-ed5fc604300a@brauner>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 22-07-26 14:07:37, Christian Brauner wrote:
> On 2026-07-16 13:11 +0200, Jan Kara wrote:
> > On Thu 16-07-26 13:27:22, Li Chen wrote:
> > > PIDFD_THREAD shares O_EXCL. do_dentry_open() clears O_EXCL after
> > > pidfs_export_open() validates the flags, so open_by_handle_at()
> > > silently turns a thread pidfd into a process pidfd.
> > > 
> > > Restore PIDFD_THREAD on the opened file, matching pidfs_alloc_file(),
> > > and cover the restored flag with F_GETFL.
> > > 
> > > Signed-off-by: Li Chen <me@linux.beauty>
> > 
> > Makes sense. Just looking at this code, what about PIDFD_AUTOKILL (aka
> > O_TRUNC?)? Reading the commit introducing it 07c3ef58223e it appears it was
> > never meant to be directly requested by userspace so probably
> > pidfs_export_open() needs to reject it. But that's unrelated issue to your
> > patch so feel free to add:
> 
> Good point. But pidfs_export_open() is guarded by
> pidfs_export_permission() which does:
> 
> #define VALID_FILE_HANDLE_OPEN_FLAGS \
> 	(O_RDONLY | O_WRONLY | O_RDWR | O_NONBLOCK | O_CLOEXEC | O_EXCL)
> 
> 	if (oflags & ~(VALID_FILE_HANDLE_OPEN_FLAGS | O_LARGEFILE))
> 		return -EINVAL;
> 
> and so is safe. But I've added the following patch on top which also
> splats if that is passed!
> 
> From 99a859485394eca8cf6271de09ae72ac3b846bda Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Wed, 22 Jul 2026 13:56:28 +0200
> Subject: [PATCH] pidfs: add pidfs_dentry_open() helper
> 
> Both pidfs_alloc_file() and pidfs_export_open() need to force O_RDWR
> and reapply the pidfd flags that do_dentry_open() strips. Move the
> common logic into a helper.
> 
> PIDFD_AUTOKILL is now part of the restore mask in the file handle path
> as well, but pidfs_export_permission() rejects O_TRUNC, so this is a
> no-op there. But warn nonetheless.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c20ffd747ff5..695215aa2a58 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -915,6 +915,20 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
>  	return path.dentry;
>  }
>  
> +static struct file *pidfs_dentry_open(const struct path *path,
> +				      unsigned int flags,
> +				      const struct cred *cred)
> +{
> +	struct file *file;
> +
> +	/* pidfds are always O_RDWR. */
> +	file = dentry_open(path, flags | O_RDWR, cred);
> +	/* do_dentry_open() strips O_EXCL and O_TRUNC. */
> +	if (!IS_ERR(file))
> +		file->f_flags |= flags & (PIDFD_THREAD | PIDFD_AUTOKILL);
> +	return file;
> +}
> +
>  /*
>   * Make sure that we reject any nonsensical flags that users pass via
>   * open_by_handle_at(). Note that PIDFD_THREAD is defined as O_EXCL, and
> @@ -939,18 +953,14 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
>  
>  static struct file *pidfs_export_open(const struct path *path, unsigned int oflags)
>  {
> -	struct file *file;
> -
>  	/*
> -	 * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
> -	 * O_RDWR as pidfds always are.
> +	 * Opening via file handle may never raise PIDFD_AUTOKILL. That can
> +	 * only be done at task creation!
>  	 */
> -	oflags &= ~O_LARGEFILE;
> -	file = dentry_open(path, oflags | O_RDWR, current_cred());
> -	/* do_dentry_open() strips O_EXCL, which encodes PIDFD_THREAD. */
> -	if (!IS_ERR(file))
> -		file->f_flags |= oflags & PIDFD_THREAD;
> -	return file;
> +	if (WARN_ON_ONCE(oflags & PIDFD_AUTOKILL))
> +		return ERR_PTR(-EINVAL);
> +	/* Clear O_LARGEFILE as open_by_handle_at() forces it. */
> +	return pidfs_dentry_open(path, oflags & ~O_LARGEFILE, current_cred());
>  }
>  
>  static const struct export_operations pidfs_export_operations = {
> @@ -1114,7 +1124,6 @@ static struct file_system_type pidfs_type = {
>  
>  struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>  {
> -	struct file *pidfd_file;
>  	struct path path __free(path_put) = {};
>  	int ret;
>  
> @@ -1132,16 +1141,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>  	VFS_WARN_ON_ONCE(!pid->attr);
>  
>  	flags &= ~PIDFD_STALE;
> -	flags |= O_RDWR;
> -	pidfd_file = dentry_open(&path, flags, current_cred());
> -	/*
> -	 * Raise PIDFD_THREAD and PIDFD_AUTOKILL explicitly as
> -	 * do_dentry_open() strips O_EXCL and O_TRUNC.
> -	 */
> -	if (!IS_ERR(pidfd_file))
> -		pidfd_file->f_flags |= (flags & (PIDFD_THREAD | PIDFD_AUTOKILL));
> -
> -	return pidfd_file;
> +	return pidfs_dentry_open(&path, flags, current_cred());
>  }
>  
>  void __init pidfs_init(void)
> -- 
> 2.53.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
