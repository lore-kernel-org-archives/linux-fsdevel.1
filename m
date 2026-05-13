Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560033955ED;
	Wed, 13 May 2026 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708018; cv=none; b=MydmpxQ77J3bLy5hFF+iO2Pd+ttmpCmGbNum1YUQh4bs2MBE/o1cryEysBaXxdobkNGUWg+iTtnO8RwY0FtsQrG86IJ5mb+HlN9b5ivpUAEMfykzp1PYYNQE0rge7sH7hUSpAtZfDzqyEoybp919aE9L7dpGVU7mOAauDu9yThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708018; c=relaxed/simple;
	bh=RRtFnMqnQlkkImKfign5KqzteQSuZdB7wBmviuQ5gRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+PKDukca6t50OedVZkOTOeZixa8EvFNngkGy0bZjFP85yf8igLKQZA/hRmexoxtwGgijejnDiRCsRSpAyNCL942bg1n9ZyjpsIiUKCSHJQwtru1ASWU/OdUf9NCv4x3nKTOLqNymIAXYeWPGZIkz8/Sr/uS3DE/hWQs8Tvv3+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diS37fS2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diS37fS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D702FC19425;
	Wed, 13 May 2026 21:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778708017;
	bh=RRtFnMqnQlkkImKfign5KqzteQSuZdB7wBmviuQ5gRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diS37fS2S7VEgtqHLYt6jxr5obkohra73zJvH00cxobXLoHcWu2bUE0Ti5g1ralPx
	 y+f+CVJTC8x/nszGxijcVOjwsZqPKyK1TWU6Wqz5rdZbJ8jBrPk4aa2WamlMR9VxJL
	 P0+vj1hvD5bdJBNneoxnqadEgKQhVHA13mZxqvEOyFeWYNQZhJeBUa5Og3wE4L86Ul
	 cBRTNzNXcxK/jd5FOZz5oeRAURQFYNFKtbySSZ1RFgqilbsfzs8vVcRpirE48ee7kZ
	 kcKUhZGMUovhxRxTRuFXTKnifWQZGKXSP0envdfs1zc47jsMOt+r64nJFt+SpoeBe5
	 hL9WF9eXZJaPQ==
Date: Wed, 13 May 2026 14:33:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] fuse: allow privileged mount helpers to pre-approve
 iomap usage
Message-ID: <20260513213337.GU9544@frogsfrogsfrogs>
References: <177747207487.4104197.2228921108809032839.stgit@frogsfrogsfrogs>
 <177747207517.4104197.2708127799087809184.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747207517.4104197.2708127799087809184.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:38:49AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> For the upcoming safemount functionality in libfuse, we will create a
> privileged "mount.safe" helper that starts the fuse server in a
> completely unprivileged systemd container.  The mount helper will pass
> the mount options and fds for /dev/fuse and any other files requested by
> the fuse server into the container via a Unix socket.
> 
> Currently, the ability to turn on iomap for fuse depends on a module
> parameter and the process that calls mount() having the CAP_SYS_RAWIO
> capability.  However, the unprivilged fuse server might want to query
> the /dev/fuse fd for iomap capabilities before mount or FUSE_INIT so
> that it can get ready.
> 
> Similar to FUSE_DEV_SYNC_INIT, add a new bit for iomap that can be
> squirreled away in file->private_data and an ioctl to set that bit.
> That way the privileged mount helper can pass its iomap privilege to the
> contained fuse server without the fuse server needing to have
> CAP_SYS_RAWIO.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h          |   10 ++++++++++
>  fs/fuse/fuse_iomap.h      |    2 ++
>  include/uapi/linux/fuse.h |    1 +
>  fs/fuse/dev.c             |    2 ++
>  fs/fuse/fuse_iomap.c      |   32 ++++++++++++++++++++++++++++++--
>  fs/fuse/inode.c           |    7 +++++--
>  6 files changed, 50 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 91f399a7a9a990..a491b80c2afacf 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -623,6 +623,9 @@ struct fuse_dev {
>  	/** Issue FUSE_INIT synchronously */
>  	bool sync_init;
>  
> +	/** Allow fuse server to ask for IOMAP */
> +	bool may_iomap;
> +
>  	/** Fuse connection for this device */
>  	struct fuse_conn *fc;
>  
> @@ -981,6 +984,13 @@ struct fuse_conn {
>  	/* Enable fs/iomap for file operations */
>  	unsigned int iomap:1;
>  
> +	/*
> +	 * Are filesystems using this connection allowed to use iomap?  This is
> +	 * determined by the privilege level of the process that initiated the
> +	 * mount() call.
> +	 */
> +	unsigned int may_iomap:1;
> +
>  	/* Use io_uring for communication */
>  	unsigned int io_uring;
>  
> diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
> index 79625897dded50..636d75e44cda82 100644
> --- a/fs/fuse/fuse_iomap.h
> +++ b/fs/fuse/fuse_iomap.h
> @@ -72,6 +72,7 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
>  void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
>  				  u64 written);
>  
> +int fuse_dev_ioctl_add_iomap(struct file *file);
>  int fuse_dev_ioctl_iomap_support(struct file *file,
>  				 struct fuse_iomap_support __user *argp);
>  int fuse_iomap_dev_inval(struct fuse_conn *fc,
> @@ -109,6 +110,7 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
>  # define fuse_iomap_fallocate(...)		(-ENOSYS)
>  # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
>  # define fuse_iomap_copied_file_range(...)	((void)0)
> +# define fuse_dev_ioctl_add_iomap(...)		(-EOPNOTSUPP)
>  # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
>  # define fuse_iomap_dev_inval(...)		(-ENOSYS)
>  # define fuse_iomap_fadvise			NULL
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 035e1a59ce50d3..1132493c66d266 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1212,6 +1212,7 @@ struct fuse_iomap_support {
>  #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
>  					     struct fuse_iomap_support)
>  #define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
> +#define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 101)
>  
>  struct fuse_lseek_in {
>  	uint64_t	fh;
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index fcee1a23375cee..fc2875cfffdb3b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2789,6 +2789,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>  		return fuse_dev_ioctl_iomap_support(file, argp);
>  	case FUSE_DEV_IOC_SET_NOFS:
>  		return fuse_dev_ioctl_iomap_set_nofs(file, argp);
> +	case FUSE_DEV_IOC_ADD_IOMAP:
> +		return fuse_dev_ioctl_add_iomap(file);
>  
>  	default:
>  		return -ENOTTY;
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index 8d3c7273dda810..3c2821c5f74c03 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -10,6 +10,7 @@
>  #include <linux/fadvise.h>
>  #include <linux/swap.h>
>  #include "fuse_i.h"
> +#include "fuse_dev_i.h"
>  #include "fuse_trace.h"
>  #include "fuse_iomap.h"
>  #include "fuse_iomap_i.h"
> @@ -80,6 +81,12 @@ bool fuse_iomap_enabled(void)
>  	return enable_iomap && has_capability_noaudit(current, CAP_SYS_RAWIO);
>  }
>  
> +static inline bool fuse_iomap_may_enable(void)
> +{

Needs to have the same uabi blockade:

	/* Don't let anyone touch iomap until the end of the patchset. */
	return false;

> +	/* Same as above, but this time we log the denial in audit log */
> +	return enable_iomap && capable(CAP_SYS_RAWIO);
> +}
> +
>  /* Convert IOMAP_* mapping types to FUSE_IOMAP_TYPE_* */
>  #define XMAP(word) \
>  	case IOMAP_##word: \
> @@ -2537,14 +2544,35 @@ fuse_iomap_fallocate(
>  	return 0;
>  }
>  
> +int fuse_dev_ioctl_add_iomap(struct file *file)
> +{
> +	int err = -EINVAL;
> +	struct fuse_dev *fud = fuse_file_to_fud(file);
> +

Needs to check fuse_iomap_may_enable(); this apparently fell out when I
was rebasing after the fuse_dev_fc_get series was merged.

--D

> +	mutex_lock(&fuse_mutex);
> +	if (!fuse_dev_fc_get(fud)) {
> +		fud->may_iomap = true;
> +		err = 0;
> +	}
> +	mutex_unlock(&fuse_mutex);
> +	return err;
> +}
> +
>  int fuse_dev_ioctl_iomap_support(struct file *file,
>  				 struct fuse_iomap_support __user *argp)
>  {
>  	struct fuse_iomap_support ios = { };
> +	struct fuse_dev *fud = fuse_file_to_fud(file);
> +	struct fuse_conn *fc;
>  
> -	if (fuse_iomap_enabled())
> +	mutex_lock(&fuse_mutex);
> +	fc = fuse_dev_fc_get(fud);
> +	if ((fc && fc != FUSE_DEV_FC_DISCONNECTED && fc->may_iomap) ||
> +	    (!fc && fud->may_iomap) ||
> +	    fuse_iomap_enabled())
>  		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO |
>  			    FUSE_IOMAP_SUPPORT_ATOMIC;
> +	mutex_unlock(&fuse_mutex);
>  
>  	if (copy_to_user(argp, &ios, sizeof(ios)))
>  		return -EFAULT;
> @@ -2615,7 +2643,7 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
>  
>  static inline bool can_set_nofs(struct fuse_dev *fud)
>  {
> -	if (fud && fud->fc && fud->fc->iomap)
> +	if (fud && fud->fc && (fud->fc->iomap || fud->fc->may_iomap))
>  	       return true;
>  
>  	return capable(CAP_SYS_RESOURCE);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 1a09b9e1446919..ca7981c38d5a1c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1076,6 +1076,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>  	fc->name_max = FUSE_NAME_LOW_MAX;
>  	fc->timeout.req_timeout = 0;
>  	fc->root_nodeid = FUSE_ROOT_ID;
> +	fc->may_iomap = fuse_iomap_enabled();
>  
>  	if (IS_ENABLED(CONFIG_FUSE_BACKING))
>  		fuse_backing_files_init(fc);
> @@ -1610,7 +1611,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  			if (flags & FUSE_REQUEST_TIMEOUT)
>  				timeout = arg->request_timeout;
>  
> -			if ((flags & FUSE_IOMAP) && fuse_iomap_enabled()) {
> +			if ((flags & FUSE_IOMAP) && fc->may_iomap) {
>  				fc->iomap = 1;
>  				pr_warn(
>   "EXPERIMENTAL iomap feature enabled.  Use at your own risk!");
> @@ -1697,7 +1698,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
>  	 */
>  	if (fuse_uring_enabled())
>  		flags |= FUSE_OVER_IO_URING;
> -	if (fuse_iomap_enabled())
> +	if (fm->fc->may_iomap)
>  		flags |= FUSE_IOMAP;
>  
>  	ia->in.flags = flags;
> @@ -2093,6 +2094,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  			goto err_unlock;
>  		if (fud->sync_init)
>  			fc->sync_init = 1;
> +		if (fud->may_iomap)
> +			fc->may_iomap = 1;
>  	}
>  
>  	err = fuse_ctl_add_conn(fc);
> 
> 
