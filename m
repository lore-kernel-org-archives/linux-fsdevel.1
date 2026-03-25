Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD63C9EF8
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439660; cv=none; b=AjpCU47szPVoKO+R/BRTBtwMskEKoQitISdp23w1zIa792GXSesMgZrKDL2pbY+48z9yRpc5e/zKoJuuIXfVxxFZ9Ahs1Fo9QMn1xWjH9y+GgY7XFtVCJPMuy9kvUAdTtK3covPYYC5F3hMB0BCDuVnkNY7FgoUjM+fUHduJh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439660; c=relaxed/simple;
	bh=ijmICtvxUjNMHOCVjFErAQ1cUQ0JxS7fEY2fXgFk3U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZHHDz+8YckzS6JDHEHj5+enYXJ1ru/9COvUtpoJQIm5JHSZPbkwK/x9o5p6epnivFGIS7FdkPK264OQh+bjd89rSaiquEv8NEgb7Bs+kt9JJtgNghaSJHfB4tlv5u4x2KJAqZBczlVCC75KpeRF+TC7woMR3rnPOCcWMoiSjAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xvu3BMTZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qOcsE+YD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xvu3BMTZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qOcsE+YD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xvu3BMTZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qOcsE+YD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xvu3BMTZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qOcsE+YD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A68464D21F;
	Wed, 25 Mar 2026 11:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774439657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0tx0zeKdiA//elNndgloBMUBLIsZabWlSMPzBCeOgc=;
	b=Xvu3BMTZn8LRoD8qGZubIQH/OekdOtairPHOBJhSnCSrowMWq9q5P/NSn5T7iPRIfwkD3Q
	NJL4FctJOvszehkf2hwkPsqgX3kMieIbCNAtSgrBrg5ZZhYngzFeH4aKPPdUVuIh9wjj3q
	OJV5ijzqrUAehXoV1aGlnQv4TSzJOdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774439657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0tx0zeKdiA//elNndgloBMUBLIsZabWlSMPzBCeOgc=;
	b=qOcsE+YDYlHkLnjCzdBlMMx004JA7vmlmaYRf0ho9LjB8fiAKdq0Z8CF9JHOpMyuPN7eyh
	xGxrzmoCiv8YSMCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774439657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0tx0zeKdiA//elNndgloBMUBLIsZabWlSMPzBCeOgc=;
	b=Xvu3BMTZn8LRoD8qGZubIQH/OekdOtairPHOBJhSnCSrowMWq9q5P/NSn5T7iPRIfwkD3Q
	NJL4FctJOvszehkf2hwkPsqgX3kMieIbCNAtSgrBrg5ZZhYngzFeH4aKPPdUVuIh9wjj3q
	OJV5ijzqrUAehXoV1aGlnQv4TSzJOdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774439657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0tx0zeKdiA//elNndgloBMUBLIsZabWlSMPzBCeOgc=;
	b=qOcsE+YDYlHkLnjCzdBlMMx004JA7vmlmaYRf0ho9LjB8fiAKdq0Z8CF9JHOpMyuPN7eyh
	xGxrzmoCiv8YSMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BAAC443B0;
	Wed, 25 Mar 2026 11:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3gH/JenMw2mcJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Mar 2026 11:54:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 64C88A0B32; Wed, 25 Mar 2026 12:54:17 +0100 (CET)
Date: Wed, 25 Mar 2026 12:54:17 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yangtao Li <frank.li@vivo.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] affs: rename affs_notify_change to affs_setattr
Message-ID: <bxwtnuhxk5za5iwdoohhmgqfdg2oswr2xgo4xevdfpydsc7nbg@33z3ijspithp>
References: <20260325063711.3298685-1-hch@lst.de>
 <20260325063711.3298685-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325063711.3298685-4-hch@lst.de>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,lst.de:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Wed 25-03-26 07:36:50, Christoph Hellwig wrote:
> Make the function name match the method that it implements.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/affs/affs.h    | 2 +-
>  fs/affs/dir.c     | 2 +-
>  fs/affs/file.c    | 2 +-
>  fs/affs/inode.c   | 5 ++---
>  fs/affs/symlink.c | 2 +-
>  5 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/affs/affs.h b/fs/affs/affs.h
> index ac4e9a02910b..43e20b02b449 100644
> --- a/fs/affs/affs.h
> +++ b/fs/affs/affs.h
> @@ -184,7 +184,7 @@ extern int	affs_rename2(struct mnt_idmap *idmap,
>  /* inode.c */
>  
>  extern struct inode		*affs_new_inode(struct inode *dir);
> -extern int			 affs_notify_change(struct mnt_idmap *idmap,
> +extern int			 affs_setattr(struct mnt_idmap *idmap,
>  					struct dentry *dentry, struct iattr *attr);
>  extern void			 affs_evict_inode(struct inode *inode);
>  extern struct inode		*affs_iget(struct super_block *sb,
> diff --git a/fs/affs/dir.c b/fs/affs/dir.c
> index 5c8d83387a39..c53b98f7c687 100644
> --- a/fs/affs/dir.c
> +++ b/fs/affs/dir.c
> @@ -71,7 +71,7 @@ const struct inode_operations affs_dir_inode_operations = {
>  	.mkdir		= affs_mkdir,
>  	.rmdir		= affs_rmdir,
>  	.rename		= affs_rename2,
> -	.setattr	= affs_notify_change,
> +	.setattr	= affs_setattr,
>  };
>  
>  static int
> diff --git a/fs/affs/file.c b/fs/affs/file.c
> index 6c9258359ddb..cede4bb1134e 100644
> --- a/fs/affs/file.c
> +++ b/fs/affs/file.c
> @@ -1013,5 +1013,5 @@ const struct file_operations affs_file_operations = {
>  };
>  
>  const struct inode_operations affs_file_inode_operations = {
> -	.setattr	= affs_notify_change,
> +	.setattr	= affs_setattr,
>  };
> diff --git a/fs/affs/inode.c b/fs/affs/inode.c
> index 0bfc7d151dcd..f660e76584b3 100644
> --- a/fs/affs/inode.c
> +++ b/fs/affs/inode.c
> @@ -213,13 +213,12 @@ affs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  }
>  
>  int
> -affs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
> -		   struct iattr *attr)
> +affs_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *attr)
>  {
>  	struct inode *inode = d_inode(dentry);
>  	int error;
>  
> -	pr_debug("notify_change(%lu,0x%x)\n", inode->i_ino, attr->ia_valid);
> +	pr_debug("setattr(%lu,0x%x)\n", inode->i_ino, attr->ia_valid);
>  
>  	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
>  	if (error)
> diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
> index 094aec8d17b8..af6147e1d975 100644
> --- a/fs/affs/symlink.c
> +++ b/fs/affs/symlink.c
> @@ -71,5 +71,5 @@ const struct address_space_operations affs_symlink_aops = {
>  
>  const struct inode_operations affs_symlink_inode_operations = {
>  	.get_link	= page_get_link,
> -	.setattr	= affs_notify_change,
> +	.setattr	= affs_setattr,
>  };
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
