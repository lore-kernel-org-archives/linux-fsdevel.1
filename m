Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37A38D417;
	Mon, 18 May 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128051; cv=none; b=Ab2VBNclxnz0LAjuTZ/f4oNhTGyA4862IBvEHl1p7/C0+YSv3IYhjUQ49pIQKcYNNuFvSQbZzWCCxepg6TbuX5LyZpVgMNMtk0Yl7VKLFeBAnRlMq3xewftGyRKm9XAPpWjrQDXvDkybKL6xIeFR3IhdEqZroO04ZLXNdqEEYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128051; c=relaxed/simple;
	bh=w219VhTpTihdHlnOdR7aP63fg8wurPsI9DN/tAvrxwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWNEU0jZW50m4VytJ/x8Iwy0/emkQD8QfKmQ68xSMUE5ayWZvoZEdQqn8kBUdE1K6IgvTWYawCBkNnbipkcS1vdB9B/NRBs7k8GsPr6ObWAhf5teIiDgsLa2viSjOA1XYq7ZggSfUyUAtkpW+hDUyg4B9rZcAUVmhXFb+WkdPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfPzLdKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfPzLdKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5A6C2BCB7;
	Mon, 18 May 2026 18:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128051;
	bh=w219VhTpTihdHlnOdR7aP63fg8wurPsI9DN/tAvrxwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfPzLdKmy1J8MwG/or7BYCpRMu8nrF6k1j4c5VjYCt9zOWl5x9raI5SprSxEIord8
	 XLrFiQBGUrevSDUE9gzxV5uPf9tNZnuaIRQaAiM6HvXEOVRI/muZs3nkgYJ2j2nPHz
	 xkA1o7AJqW2e7Kam+571+9asE6kuvvQNhQRUyW2Ecog+n4qrdoGHqXfw1m0YOptBrf
	 vFlgd15pAs6kQFeWV+zyla3hg/IWmjEX6D/2E9O8gBDE69eeBWZGdvkJk3/JUna8SI
	 tzwfv/TdQcYb5qsEbF9ErQBPw3lzqbSkz/yVRy/P+Bd4EKKKidGPYV2VDGORs2nMR0
	 eUnqtNW2RVUnA==
Date: Mon, 18 May 2026 11:14:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 33/33] fuse: implement freeze and shutdowns for iomap
 filesystems
Message-ID: <20260518181410.GA9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205856.4101881.10694466069338531152.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205856.4101881.10694466069338531152.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:32:18AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Implement filesystem freezing and block device shutdown notifications
> for iomap-based servers
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/uapi/linux/fuse.h |   12 +++++++
>  fs/fuse/inode.c           |   73 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
> 
> 
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 5f3724f36f764a..b6fa828776b82f 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -695,6 +695,10 @@ enum fuse_opcode {
>  	FUSE_STATX		= 52,
>  	FUSE_COPY_FILE_RANGE_64	= 53,
>  
> +	FUSE_FREEZE_FS		= 4089,
> +	FUSE_UNFREEZE_FS	= 4090,
> +	FUSE_SHUTDOWN_FS	= 4091,
> +
>  	FUSE_IOMAP_CONFIG	= 4092,
>  	FUSE_IOMAP_IOEND	= 4093,
>  	FUSE_IOMAP_BEGIN	= 4094,
> @@ -1257,6 +1261,14 @@ struct fuse_syncfs_in {
>  	uint64_t	padding;
>  };
>  
> +struct fuse_freezefs_in {
> +	uint64_t	unlinked;
> +};
> +
> +struct fuse_shutdownfs_in {
> +	uint64_t	flags;
> +};
> +
>  /*
>   * For each security context, send fuse_secctx with size of security context
>   * fuse_secctx will be followed by security context name and this in turn
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index f6ec67a8eb86a2..6d4ff08ad3069a 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1264,6 +1264,74 @@ static struct dentry *fuse_get_parent(struct dentry *child)
>  	return parent;
>  }
>  
> +#ifdef CONFIG_FUSE_IOMAP
> +/*
> + * Second stage of a freeze. The data is already frozen so we only
> + * need to take care of the fuse server.
> + */
> +static int fuse_freeze_fs(struct super_block *sb)
> +{
> +	struct fuse_mount *fm = get_fuse_mount_super(sb);
> +	struct fuse_conn *fc = get_fuse_conn_super(sb);
> +	struct fuse_freezefs_in inarg = {
> +		.unlinked = atomic_long_read(&sb->s_remove_count),
> +	};
> +	FUSE_ARGS(args);
> +	int err;
> +
> +	if (!fc->iomap)
> +		return -EOPNOTSUPP;

Codex suggests that I implement ->freeze_super here so that on non-iomap
filesystems, we don't try to flush/sync the filesystem only to fail the
freeze operation here.

--D

> +
> +	args.opcode = FUSE_FREEZE_FS;
> +	args.nodeid = get_node_id(sb->s_root->d_inode);
> +	args.in_numargs = 1;
> +	args.in_args[0].size = sizeof(inarg);
> +	args.in_args[0].value = &inarg;
> +	err = fuse_simple_request(fm, &args);
> +	if (err == -ENOSYS)
> +		err = -EOPNOTSUPP;
> +	return err;
> +}
> +
> +static int fuse_unfreeze_fs(struct super_block *sb)
> +{
> +	struct fuse_mount *fm = get_fuse_mount_super(sb);
> +	struct fuse_conn *fc = get_fuse_conn_super(sb);
> +	FUSE_ARGS(args);
> +	int err;
> +
> +	if (!fc->iomap)
> +		return 0;
> +
> +	args.opcode = FUSE_UNFREEZE_FS;
> +	args.nodeid = get_node_id(sb->s_root->d_inode);
> +	err = fuse_simple_request(fm, &args);
> +	if (err == -ENOSYS)
> +		err = 0;
> +	return err;
> +}
> +
> +static void fuse_shutdown_fs(struct super_block *sb)
> +{
> +	struct fuse_mount *fm = get_fuse_mount_super(sb);
> +	struct fuse_conn *fc = get_fuse_conn_super(sb);
> +	struct fuse_shutdownfs_in inarg = {
> +		.flags = 0,
> +	};
> +	FUSE_ARGS(args);
> +
> +	if (!fc->iomap)
> +		return;
> +
> +	args.opcode = FUSE_SHUTDOWN_FS;
> +	args.nodeid = get_node_id(sb->s_root->d_inode);
> +	args.in_numargs = 1;
> +	args.in_args[0].size = sizeof(inarg);
> +	args.in_args[0].value = &inarg;
> +	fuse_simple_request(fm, &args);
> +}
> +#endif /* CONFIG_FUSE_IOMAP */
> +
>  /* only for fid encoding; no support for file handle */
>  static const struct export_operations fuse_export_fid_operations = {
>  	.encode_fh	= fuse_encode_fh,
> @@ -1286,6 +1354,11 @@ static const struct super_operations fuse_super_operations = {
>  	.statfs		= fuse_statfs,
>  	.sync_fs	= fuse_sync_fs,
>  	.show_options	= fuse_show_options,
> +#ifdef CONFIG_FUSE_IOMAP
> +	.freeze_fs	= fuse_freeze_fs,
> +	.unfreeze_fs	= fuse_unfreeze_fs,
> +	.shutdown	= fuse_shutdown_fs,
> +#endif
>  };
>  
>  static void sanitize_global_limit(unsigned int *limit)
> 
> 
