Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6953392818
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443375; cv=none; b=tc9qNY7oS8J3Cvc0x+9osaO2gVq9FSjdePx7oaVXzjYM6dXt2bwGJ7v9TLrV9XOeqigGmmUyYRzbo8SxSWNzo7X07eQ2P3guLfFP8HVyHvyInv55qliakReEThs4utxk6gphbn2dDTIMTysd21Awf70oqniCm9HbLgITGpbKVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443375; c=relaxed/simple;
	bh=y7zisj5sSVfftqJ18l5nwRZx9yrZ2/kyx9eeuZPb8Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRNl8gVOnZEJkpY/8za/u311kdrkHagNSzJCkD+uRx+IW7aNs/wlxs5e8sWwlV2/Dey8klWnEsGdvz4D6Onm4FLOT0cgb2qb8OJ9jzsFnud5SH8rqD7EiuIsv2+D2Vj9JkPG5fbadVGDSKLj8w82J5OrrD7WmgGg3O7mJ0FAWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcZJ3AWJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcZJ3AWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AC5C19421;
	Fri, 13 Mar 2026 23:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773443375;
	bh=y7zisj5sSVfftqJ18l5nwRZx9yrZ2/kyx9eeuZPb8Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcZJ3AWJhn/m+IaxHK8rEX8fFyp3nus17/HSP8yBxhfk7eA9AxvQLWTVvTbMfwU+p
	 o54ert+UvQc6+D31WLgd3kwW0M1fSlTEp6SWY7ok8/cejSjnt5iSr/DSnVWdnVsCL+
	 P4AyokrA71PrJHdg8flyIQKGjO9J8jfR6iaApbrF233SvRHEM3vzr5+P3QdeObQdup
	 F1eQ4xucJaNR+pLGcd5cnf9ddmXxV4tS8u1+sRtKxKYA0VMlBljX+x9tTIyweKPZgv
	 g+7eO0ZghzZl94KKnPC5Hykm3nf3VrNvcrxYGoGQT7peK82LZaW0utQ65/bK6zDgBs
	 I8i+kluCM73vg==
Date: Fri, 13 Mar 2026 16:09:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v2 3/6] fuse: don't require /dev/fuse fd to be kept open
 during mount
Message-ID: <20260313230934.GG1742010@frogsfrogsfrogs>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
 <20260312194019.3077902-4-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312194019.3077902-4-mszeredi@redhat.com>

On Thu, Mar 12, 2026 at 08:40:01PM +0100, Miklos Szeredi wrote:
> With the new mount API the sequence of syscalls would be:
> 
>         fs_fd = fsopen("fuse", 0);
> 	snprintf(opt, sizeof(opt), "%i", devfd);
> 	fsconfig(fs_fd, FSCONFIG_SET_STRING, "fd", opt, 0);
> 	/* ... */
> 	fsconfig(fs_fd, FSCONFIG_CMD_CREATE, 0, 0, 0);
> 
> Current mount code just stores the value of devfd in the fs_context and
> uses it in during FSCONFIG_CMD_CREATE.
> 
> This is not very elegant, but there's a bigger problem: when sync init is
> used and the server exits for some reason (error, crash) while processing
> FUSE_INIT, the filesystem creation will hang.

Hrmm, is this https://github.com/libfuse/libfuse/pull/1367 ?

Which syscall causes the synchronous FUSE_INIT to be sent?  Is it
FSCONFIG_CMD_CREATE?

> The reason is that while all other threads will exit, the mounting
> thread (or process) will keep the device fd open, which will prevent
> an abort from happening.

So I guess what's happening here is that the main thread calls
FSCONFIG_CMD_CREATE, which sends the synchronous FUSE_INIT to the worker
pool.  One of the worker threads starts working on the FUSE_INIT reply
and crashes.  All the *workers* terminate and close the fuse dev fd,
leaving just the main thread.

AFAICT, the main thread is stuck in fsconfig() here:

	/* Any signal may interrupt this */
		err = wait_event_interruptible(req->waitq,
				test_bit(FR_FINISHED, &req->flags))

so there's still an open ref to the fuse dev fd, which prevents anyone
from aborting the FUSE_INIT request so that FR_FINISH gets set?  And now
we're just hosed?  Wouldn't the SIGCHLD interrupt the wait?  Or are we
stuck someplace else?

> This is a regression from the async mount case, where the mount was done
> first, and the FUSE_INIT processing afterwards, in which case there's no
> such recursive syscall keeping the fd open.

Is this hang possible if you're using mount(2) with synchronous
FUSE_INIT?

> The solution is twofold:
> 
>  a) use unshare(CLONE_FILES) in the mounting thread

Is this after starting up the worker threads?  I guess that means the
worker threads retain their fuse dev fds even though...

>     and close the device fd
>     after fsconfig(fs_fd, FSCONFIG_SET_STRING, "fd", ...)

...the main thread closes the fuse dev fd before FSCONFIG_CMD_CREATE.
What if that main thread needs to use the fuse dev fd after this point?
Or, what if userspace doesn't cooperate and unshare()/close()?  Can this
hang be broken by kill -9, at least?

>  b) only reference the fuse_dev from fs_context not the device file itself

Can you set an abort timeout on the FUSE_INIT request?

Perhaps my broader question is, what /does/ happen if a fuse server
thread starts processing a request and crashes out before replying?  I
guess that means the request is never completed, but in the case of
!(synchronous FUSE_INIT) we'd just see the whole server terminate, which
would then release the fuse dev fd?

Sorry this isn't a review so much as me asking a lot of annoying
questions. :/

--D

> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/fuse_i.h |  4 +---
>  fs/fuse/inode.c  | 54 +++++++++++++++++++++++++++---------------------
>  2 files changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 66ec92f06497..b77b384b0385 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -603,13 +603,11 @@ static inline bool fuse_is_inode_dax_mode(enum fuse_dax_mode mode)
>  }
>  
>  struct fuse_fs_context {
> -	int fd;
> -	struct file *file;
> +	struct fuse_dev *fud;
>  	unsigned int rootmode;
>  	kuid_t user_id;
>  	kgid_t group_id;
>  	bool is_bdev:1;
> -	bool fd_present:1;
>  	bool rootmode_present:1;
>  	bool user_id_present:1;
>  	bool group_id_present:1;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index ba845092e7f2..45abcfec03a4 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -800,6 +800,26 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	{}
>  };
>  
> +static int fuse_opt_fd(struct fs_context *fsc, int fd)
> +{
> +	struct file *file __free(fput) = fget(fd);
> +	struct fuse_fs_context *ctx = fsc->fs_private;
> +
> +	if (file->f_op != &fuse_dev_operations)
> +		return invalfc(fsc, "fd is not a fuse device");
> +	/*
> +	 * Require mount to happen from the same user namespace which
> +	 * opened /dev/fuse to prevent potential attacks.
> +	 */
> +	if (file->f_cred->user_ns != fsc->user_ns)
> +		return invalfc(fsc, "wrong user namespace for fuse device");
> +
> +	ctx->fud = file->private_data;
> +	refcount_inc(&ctx->fud->ref);
> +
> +	return 0;
> +}
> +
>  static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>  {
>  	struct fs_parse_result result;
> @@ -839,9 +859,7 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>  		return 0;
>  
>  	case OPT_FD:
> -		ctx->fd = result.uint_32;
> -		ctx->fd_present = true;
> -		break;
> +		return fuse_opt_fd(fsc, result.uint_32);
>  
>  	case OPT_ROOTMODE:
>  		if (!fuse_valid_type(result.uint_32))
> @@ -904,6 +922,8 @@ static void fuse_free_fsc(struct fs_context *fsc)
>  	struct fuse_fs_context *ctx = fsc->fs_private;
>  
>  	if (ctx) {
> +		if (ctx->fud)
> +			fuse_dev_put(ctx->fud);
>  		kfree(ctx->subtype);
>  		kfree(ctx);
>  	}
> @@ -1847,7 +1867,7 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
>  
>  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  {
> -	struct fuse_dev *fud = ctx->file ? fuse_file_to_fud(ctx->file) : NULL;
> +	struct fuse_dev *fud = ctx->fud;
>  	struct fuse_mount *fm = get_fuse_mount_super(sb);
>  	struct fuse_conn *fc = fm->fc;
>  	struct inode *root;
> @@ -1950,18 +1970,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
>  	struct fuse_mount *fm;
>  	int err;
>  
> -	if (!ctx->file || !ctx->rootmode_present ||
> +	if (!ctx->fud || !ctx->rootmode_present ||
>  	    !ctx->user_id_present || !ctx->group_id_present)
>  		return -EINVAL;
>  
> -	/*
> -	 * Require mount to happen from the same user namespace which
> -	 * opened /dev/fuse to prevent potential attacks.
> -	 */
> -	if ((ctx->file->f_op != &fuse_dev_operations) ||
> -	    (ctx->file->f_cred->user_ns != sb->s_user_ns))
> -		return -EINVAL;
> -
>  	err = fuse_fill_super_common(sb, ctx);
>  	if (err)
>  		return err;
> @@ -1989,8 +2001,7 @@ static int fuse_test_super(struct super_block *sb, struct fs_context *fsc)
>  static int fuse_get_tree(struct fs_context *fsc)
>  {
>  	struct fuse_fs_context *ctx = fsc->fs_private;
> -	struct fuse_dev *fud;
> -	struct fuse_conn *fc;
> +	struct fuse_conn *fc, *key;
>  	struct fuse_mount *fm;
>  	struct super_block *sb;
>  	int err;
> @@ -2010,9 +2021,6 @@ static int fuse_get_tree(struct fs_context *fsc)
>  
>  	fsc->s_fs_info = fm;
>  
> -	if (ctx->fd_present)
> -		ctx->file = fget(ctx->fd);
> -
>  	if (IS_ENABLED(CONFIG_BLOCK) && ctx->is_bdev) {
>  		err = get_tree_bdev(fsc, fuse_fill_super);
>  		goto out;
> @@ -2022,16 +2030,16 @@ static int fuse_get_tree(struct fs_context *fsc)
>  	 * (found by device name), normal fuse mounts can't
>  	 */
>  	err = -EINVAL;
> -	if (!ctx->file)
> +	if (!ctx->fud)
>  		goto out;
>  
>  	/*
>  	 * Allow creating a fuse mount with an already initialized fuse
>  	 * connection
>  	 */
> -	fud = __fuse_get_dev(ctx->file);
> -	if (ctx->file->f_op == &fuse_dev_operations && fud) {
> -		fsc->sget_key = fud->fc;
> +	key = fuse_dev_fc_get(ctx->fud);
> +	if (key) {
> +		fsc->sget_key = key;
>  		sb = sget_fc(fsc, fuse_test_super, fuse_set_no_super);
>  		err = PTR_ERR_OR_ZERO(sb);
>  		if (!IS_ERR(sb))
> @@ -2042,8 +2050,6 @@ static int fuse_get_tree(struct fs_context *fsc)
>  out:
>  	if (fsc->s_fs_info)
>  		fuse_mount_destroy(fm);
> -	if (ctx->file)
> -		fput(ctx->file);
>  	return err;
>  }
>  
> -- 
> 2.53.0
> 
> 
