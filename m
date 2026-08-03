Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0F33F582
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756252; cv=none; b=WsOWIYJscdVKsQZfzPcigNQnfn2sxnvwgmOO4cZN14GiZhsUJP31TT1bWyEHBpgrdQCviyU/94RjbL03rIw+H9lNooDISfuSGUQxT8Vz+bS4/oSkfc98qVHM5vhcSWCkylLLslkuKQVGkW3okuqnBFPDu4fRk8YTCOOeXMuTfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756252; c=relaxed/simple;
	bh=+qc5cXdZ7+u8gDyNrcxsoHsjZDQMrKTOhVRzKTotZkA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RncWMvL22hq4BtNHONkpb7oFSGZoHVp23Dw1FTbnxBmYSMZDemPQNn/MdqTHJnQ+nRcgWrE50QrL5JrCisM6oNwSYDjgZzeRMeL3h5EPRWZ+s/x0VF+60xTThwrEoZHrGx2Tdk0ixcH5pnozI4zZS9FuerrTsl2qaJHQUugMqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzEH3Vn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzEH3Vn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788281F00A3A;
	Mon,  3 Aug 2026 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785756250;
	bh=a8jUYpGWRjKfK2pFbcsKSFyQNtwQ/7x9wAUlWuXO6ag=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=gzEH3Vn6SZXDmv67N+MhwViK2cjpIsBSX0aGOZ6ji+ufjITteyKwMvKPuByQ7c9SD
	 C71J+OmNx/37ev1jvBIkWxdhDqdTLjCSlveJKjZQRBnzJcOr2PNe2iwnW39ijeCMbw
	 UwlgCk4764m5+WVkyoY4nEW2dXpxX2fLxJYhVckc8MQxiT+JSzW6Ws5glBDtW4o3D9
	 FQd7VcQebeFyCuF15ydCR9PwzJpBxjr3kSz0Bjux/Q6gdJTPr5nztC9gkogcXiUqC7
	 bW+NjbcS+DE1pUvs0vQlEwjSIcGv0PvxVHc37qFANtsKkjDM9TZ0hJFqUPznscmLFQ
	 3UgZNNkTTsZYw==
Message-ID: <366a9c6b-ec56-4cdf-b373-22a3cd8c9beb@kernel.org>
Date: Mon, 3 Aug 2026 19:24:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, cyphar@cyphar.com, hsiangkao@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] erofs: accept source file descriptor via fsconfig
To: Giuseppe Scrivano <gscrivan@redhat.com>, linux-erofs@lists.ozlabs.org
References: <20260728160619.853924-1-gscrivan@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260728160619.853924-1-gscrivan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 00:05, Giuseppe Scrivano wrote:
> Allow userspace to pass an already-opened file descriptor as the mount
> source instead of a path string.  This is useful for tools that already
> hold an fd to the image, such as composefs reusing an existing erofs
> backing file.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
> v4: https://lore.kernel.org/linux-fsdevel/20260717134147.1602735-1-gscrivan@redhat.com/
> v3: https://lore.kernel.org/linux-fsdevel/20260714154917.489993-1-gscrivan@redhat.com/
> v2: https://lore.kernel.org/linux-fsdevel/20260711071137.4130824-1-gscrivan@redhat.com/
> v1: https://lore.kernel.org/linux-fsdevel/ak5GfvVfWLJU1EwK@debian/
> 
>   Documentation/filesystems/erofs.rst | 15 ++++++
>   fs/erofs/super.c                    | 73 ++++++++++++++++++++++++-----
>   2 files changed, 77 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 4230884fb359..774e8b236d09 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -139,6 +139,21 @@ inode_share            Enable inode page sharing for this filesystem.  Inodes wi
>                          page cache.
>   ===================    =========================================================
>   
> +File-backed mounts
> +==================
> +
> +When CONFIG_EROFS_FS_BACKED_BY_FILE is enabled, EROFS file-backed images
> +can be mounted directly without a loopback block device.  The backing file
> +can be given either as a path, or as an already-opened file descriptor.
> +
> +When a file descriptor is used, the kernel resolves its path and records it
> +so that /proc/mounts and similar interfaces can still report the mount
> +source.
> +
> +Only regular files are accepted as backing files; to mount an image that
> +resides on a block device, use the traditional block device mount path
> +instead.

Do we need to add an entry to describe the new mount option source= in
"Mount options" section in erofs.rst?

Thanks,

> +
>   Sysfs Entries
>   =============
>   
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 86fa5c6a0c70..558041011398 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>   enum {
>   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>   	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
> +	Opt_source,
>   };
>   
>   static const struct constant_table erofs_param_cache_strategy[] = {
> @@ -402,17 +403,18 @@ static const struct constant_table erofs_dax_param_enums[] = {
>   };
>   
>   static const struct fs_parameter_spec erofs_fs_parameters[] = {
> -	fsparam_flag_no("user_xattr",	Opt_user_xattr),
> -	fsparam_flag_no("acl",		Opt_acl),
> -	fsparam_enum("cache_strategy",	Opt_cache_strategy,
> +	fsparam_flag_no("user_xattr",		Opt_user_xattr),
> +	fsparam_flag_no("acl",			Opt_acl),
> +	fsparam_enum("cache_strategy",		Opt_cache_strategy,
>   		     erofs_param_cache_strategy),
> -	fsparam_flag("dax",             Opt_dax),
> -	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
> -	fsparam_string("device",	Opt_device),
> -	fsparam_string("domain_id",	Opt_domain_id),
> -	fsparam_flag_no("directio",	Opt_directio),
> -	fsparam_u64("fsoffset",		Opt_fsoffset),
> -	fsparam_flag("inode_share",	Opt_inode_share),
> +	fsparam_flag("dax",			Opt_dax),
> +	fsparam_enum("dax",			Opt_dax_enum, erofs_dax_param_enums),
> +	fsparam_string("device",		Opt_device),
> +	fsparam_string("domain_id",		Opt_domain_id),
> +	fsparam_flag_no("directio",		Opt_directio),
> +	fsparam_u64("fsoffset",			Opt_fsoffset),
> +	fsparam_flag("inode_share",		Opt_inode_share),
> +	fsparam_file_or_string("source",	Opt_source),
>   	{}
>   };
>   
> @@ -437,6 +439,40 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>   	return false;
>   }
>   
> +static int erofs_fc_parse_source(struct fs_context *fc,
> +				 struct fs_parameter *param)
> +{
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
> +
> +	if (fc->source || sbi->dif0.file)
> +		return invalf(fc, "Multiple sources");
> +
> +	switch (param->type) {
> +	case fs_value_is_string:
> +		fc->source = param->string;
> +		param->string = NULL;
> +		return 0;
> +	case fs_value_is_file: {
> +		char *buf __free(kfree) = kmalloc(PATH_MAX, GFP_KERNEL);
> +		char *p;
> +
> +		if (!buf)
> +			return -ENOMEM;
> +		p = file_path(param->file, buf, PATH_MAX);
> +		if (IS_ERR(p))
> +			return PTR_ERR(p);
> +		fc->source = kstrdup(p, GFP_KERNEL);
> +		if (!fc->source)
> +			return -ENOMEM;
> +		sbi->dif0.file = no_free_ptr(param->file);
> +		return 0;
> +	}
> +	default:
> +		WARN_ON_ONCE(true);
> +		return -EINVAL;
> +	}
> +}
> +
>   static int erofs_fc_parse_param(struct fs_context *fc,
>   				struct fs_parameter *param)
>   {
> @@ -524,6 +560,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		else
>   			set_opt(&sbi->opt, INODE_SHARE);
>   		break;
> +	case Opt_source:
> +		return erofs_fc_parse_source(fc, param);
>   	}
>   	return 0;
>   }
> @@ -752,13 +790,26 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   
>   static int erofs_fc_get_tree(struct fs_context *fc)
>   {
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>   	int ret;
>   
> +	if (sbi->dif0.file) {
> +		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE)) {
> +			errorfc(fc, "source fd option not supported");
> +			return -EINVAL;
> +		}
> +		if (!S_ISREG(file_inode(sbi->dif0.file)->i_mode) ||
> +		    !sbi->dif0.file->f_mapping->a_ops->read_folio) {
> +			errorfc(fc, "source is unsupported");
> +			return -EINVAL;
> +		}
> +		return get_tree_nodev(fc, erofs_fc_fill_super);
> +	}
> +
>   	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
>   		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
>   			GET_TREE_BDEV_QUIET_LOOKUP : 0);
>   	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
> -		struct erofs_sb_info *sbi = fc->s_fs_info;
>   		struct file *file;
>   
>   		if (!fc->source)

