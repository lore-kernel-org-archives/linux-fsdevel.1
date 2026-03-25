Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21839D6CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439807; cv=none; b=B5r2SovgQgNHi+sjEI8ksFjoLWsiNh01jCfPDSGtSOymJbKwWmfyvcvXpOp56CxBnX16bZTeDjPy0i79Ojcl/ZwsW/7ecf3qVvl8lX458E5rCgrUYpiPlOTPYXBTEVKKZNduI5oIrhdvTpX9h5Zg6Gn6XXnTfwFb8vaKpoXD2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439807; c=relaxed/simple;
	bh=uTHPqxw3UYHwGVQpEtsV2GJLMp9K4GIDB0UNygmVhrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iijZ0ZlT7NXRysMO2HS3rjovOPy8NrB9wgR2P1KtrPzOtLvis4x0FSu64p8k2LehqhgzeEIBmA5PbSFQHYihjgNzn/xQshyWRMcpjSlemU6Nn5WAjriUW+tGkt6C2JEJe2YAayw6lVGkH2ZeV5DbyZ2il21dbjbZON2IYVH0N/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FC+C8gbg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vbQM1uDW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D3bahNEQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZhG7au/K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FC+C8gbg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vbQM1uDW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D3bahNEQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZhG7au/K"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0EB85BD10;
	Wed, 25 Mar 2026 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774439804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pmx3NqdMxxB4h/+7NGoFmWUCMX3uUql3PQFCGE4gw7o=;
	b=FC+C8gbg8KL06L32c5z21xZVdUkK94KPnqD+w7O+d2KiBRzYLgbXUi82nLlvbrBgEswQHf
	SA/FDo58JR8clvLNoo6fmX5Y17SfR2lUEB5bVknaLFyuxVaLW+oAY7IQ+1YOzTPzPLRvNL
	3LC+F8GJZRE6NRX1w0JUFP+eJ5VGDFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774439804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pmx3NqdMxxB4h/+7NGoFmWUCMX3uUql3PQFCGE4gw7o=;
	b=vbQM1uDW4Ct0XXzlCgbvnDuL2bytIw3nPY0JRZ+CgibWI+eIUQ1xx7t26amwOSLumzreN3
	7xxWQlqNaL3dnUCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D3bahNEQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ZhG7au/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774439803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pmx3NqdMxxB4h/+7NGoFmWUCMX3uUql3PQFCGE4gw7o=;
	b=D3bahNEQj4dtnfRcPXjLMZQgvjZeL61SPrNX+OFRR0RAkjcQe1HVyXXZp7g+NIR3zOZbVE
	iEAyhyq20JJjArvLpihDraWia4/jsDVrRzgtI7mk2piL47W5n/soHc6YWgmb+X8VqGfQum
	xo/eTyLvE9ehge84eTISjpkKIv4ARY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774439803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pmx3NqdMxxB4h/+7NGoFmWUCMX3uUql3PQFCGE4gw7o=;
	b=ZhG7au/KuDzpit7odKFagEIc7Ie6gu7xUiibnZnzr5KtsAVAN28DseMtc6lKAXX/WAv1q2
	fF/1c4sPv7JkiABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4E11443B1;
	Wed, 25 Mar 2026 11:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EJAoLHvNw2lxKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Mar 2026 11:56:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A38EA0B32; Wed, 25 Mar 2026 12:56:28 +0100 (CET)
Date: Wed, 25 Mar 2026 12:56:28 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yangtao Li <frank.li@vivo.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] proc: rename proc_setattr to proc_nochmod_setattr
Message-ID: <4hey4val36723wscgpj5uocs5izs4stzhqi2ar2dlrgi7y5qzz@lcaxnz5bts6t>
References: <20260325063711.3298685-1-hch@lst.de>
 <20260325063711.3298685-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325063711.3298685-5-hch@lst.de>
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
	URIBL_BLOCKED(0.00)[lst.de:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C0EB85BD10

On Wed 25-03-26 07:36:51, Christoph Hellwig wrote:
> What is currently proc_setattr is a special version added after the more
> general procfs ->seattr in commit 6d76fa58b050 ("Don't allow chmod() on
                   ^^^^ setattr

> the /proc/<pid>/ files").  Give it a name that reflects that to free the
> proc_setattr name and better describe what is doing.
					     ^^^ is it

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/proc/base.c       | 22 +++++++++++-----------
>  fs/proc/fd.c         |  6 +++---
>  fs/proc/internal.h   |  4 ++--
>  fs/proc/namespaces.c |  4 ++--
>  fs/proc/proc_net.c   |  2 +-
>  5 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 4c863d17dfb4..d9acfa89c894 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -721,7 +721,7 @@ static bool proc_fd_access_allowed(struct inode *inode)
>  	return allowed;
>  }
>  
> -int proc_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +int proc_nochmod_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		 struct iattr *attr)
>  {
>  	int error;
> @@ -794,7 +794,7 @@ static int proc_pid_permission(struct mnt_idmap *idmap,
>  
>  
>  static const struct inode_operations proc_def_inode_operations = {
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
>  
>  static int proc_single_show(struct seq_file *m, void *v)
> @@ -1866,7 +1866,7 @@ static int proc_pid_readlink(struct dentry * dentry, char __user * buffer, int b
>  const struct inode_operations proc_pid_link_inode_operations = {
>  	.readlink	= proc_pid_readlink,
>  	.get_link	= proc_pid_get_link,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
>  
>  
> @@ -2319,7 +2319,7 @@ proc_map_files_get_link(struct dentry *dentry,
>  static const struct inode_operations proc_map_files_link_inode_operations = {
>  	.readlink	= proc_pid_readlink,
>  	.get_link	= proc_map_files_get_link,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
>  
>  static struct dentry *
> @@ -2398,7 +2398,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
>  static const struct inode_operations proc_map_files_inode_operations = {
>  	.lookup		= proc_map_files_lookup,
>  	.permission	= proc_fd_permission,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
>  
>  static int
> @@ -2885,7 +2885,7 @@ static struct dentry *proc_##LSM##_attr_dir_lookup(struct inode *dir, \
>  static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
>  	.lookup		= proc_##LSM##_attr_dir_lookup, \
>  	.getattr	= pid_getattr, \
> -	.setattr	= proc_setattr, \
> +	.setattr	= proc_nochmod_setattr, \
>  }
>  
>  #ifdef CONFIG_SECURITY_SMACK
> @@ -2944,7 +2944,7 @@ static struct dentry *proc_attr_dir_lookup(struct inode *dir,
>  static const struct inode_operations proc_attr_dir_inode_operations = {
>  	.lookup		= proc_attr_dir_lookup,
>  	.getattr	= pid_getattr,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
>  
>  #endif
> @@ -3453,7 +3453,7 @@ static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *de
>  static const struct inode_operations proc_tgid_base_inode_operations = {
>  	.lookup		= proc_tgid_base_lookup,
>  	.getattr	= pid_getattr,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  	.permission	= proc_pid_permission,
>  };
>  
> @@ -3650,7 +3650,7 @@ static int proc_tid_comm_permission(struct mnt_idmap *idmap,
>  }
>  
>  static const struct inode_operations proc_tid_comm_inode_operations = {
> -		.setattr	= proc_setattr,
> +		.setattr	= proc_nochmod_setattr,
>  		.permission	= proc_tid_comm_permission,
>  };
>  
> @@ -3779,7 +3779,7 @@ static const struct file_operations proc_tid_base_operations = {
>  static const struct inode_operations proc_tid_base_inode_operations = {
>  	.lookup		= proc_tid_base_lookup,
>  	.getattr	= pid_getattr,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
>  
>  static struct dentry *proc_task_instantiate(struct dentry *dentry,
> @@ -3992,7 +3992,7 @@ static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
>  static const struct inode_operations proc_task_inode_operations = {
>  	.lookup		= proc_task_lookup,
>  	.getattr	= proc_task_getattr,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  	.permission	= proc_pid_permission,
>  };
>  
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 9eeccff49b2a..8a48ff4a19ec 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -102,7 +102,7 @@ static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
>  
>  static const struct inode_operations proc_fdinfo_file_inode_operations = {
>  	.permission	= proc_fdinfo_permission,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
>  
>  static const struct file_operations proc_fdinfo_file_operations = {
> @@ -361,7 +361,7 @@ const struct inode_operations proc_fd_inode_operations = {
>  	.lookup		= proc_lookupfd,
>  	.permission	= proc_fd_permission,
>  	.getattr	= proc_fd_getattr,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
>  
>  static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
> @@ -402,7 +402,7 @@ static int proc_fdinfo_iterate(struct file *file, struct dir_context *ctx)
>  const struct inode_operations proc_fdinfo_inode_operations = {
>  	.lookup		= proc_lookupfdinfo,
>  	.permission	= proc_fdinfo_permission,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
>  
>  const struct file_operations proc_fdinfo_operations = {
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index c1e8eb984da8..64dc44832808 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -257,8 +257,8 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
>  extern const struct dentry_operations pid_dentry_operations;
>  extern int pid_getattr(struct mnt_idmap *, const struct path *,
>  		       struct kstat *, u32, unsigned int);
> -extern int proc_setattr(struct mnt_idmap *, struct dentry *,
> -			struct iattr *);
> +int proc_nochmod_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			struct iattr *attr);
>  extern void proc_pid_evict_inode(struct proc_inode *);
>  extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
>  extern void pid_update_inode(struct task_struct *, struct inode *);
> diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
> index ea2b597fd92c..39f4169f669f 100644
> --- a/fs/proc/namespaces.c
> +++ b/fs/proc/namespaces.c
> @@ -92,7 +92,7 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
>  static const struct inode_operations proc_ns_link_inode_operations = {
>  	.readlink	= proc_ns_readlink,
>  	.get_link	= proc_ns_get_link,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
>  
>  static struct dentry *proc_ns_instantiate(struct dentry *dentry,
> @@ -178,5 +178,5 @@ static struct dentry *proc_ns_dir_lookup(struct inode *dir,
>  const struct inode_operations proc_ns_dir_inode_operations = {
>  	.lookup		= proc_ns_dir_lookup,
>  	.getattr	= pid_getattr,
> -	.setattr	= proc_setattr,
> +	.setattr	= proc_nochmod_setattr,
>  };
> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index 52f0b75cbce2..184cddeb8215 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -322,7 +322,7 @@ static int proc_tgid_net_getattr(struct mnt_idmap *idmap,
>  const struct inode_operations proc_net_inode_operations = {
>  	.lookup		= proc_tgid_net_lookup,
>  	.getattr	= proc_tgid_net_getattr,
> -	.setattr        = proc_setattr,
> +	.setattr        = proc_nochmod_setattr,
>  };
>  
>  static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
