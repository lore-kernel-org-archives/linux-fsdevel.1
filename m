Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FEE375AB5;
	Wed, 13 May 2026 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707666; cv=none; b=QznBIQi6V82k/eINhaC/RsbvGq98Luan1roRp+uMTkBaWwVSvBdbP/0OTi8OE06HA4ncqcZaMHVtBQOHpMswXc7fTy4tzfm8gbbyyQN6Wb6PgH+cUHcmpOfDRTVkuG7Cha61jREPDp7nYozNFBPhiCDK/RU/WZ/mH7ueBeKakGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707666; c=relaxed/simple;
	bh=aHt2NKRxzUXSpOW1argeSit/2ugz/S0VoZjEUP9Ehfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoVuMztOusXnSBQUQYQG6OyN2A5lNjVRw3Qrg4E9zJO0Tlxi7kFvp2QuQEV7hZBrLUX7YNgCOfhGo3AMM4qkjF/X02KuNBdKc0vLqSwIWHrPjdhRMC6s6+I1QhsJFe4L5g5rH71Tw2ivWk7/2FPMKYW9sbqYLMKqIGkgkIfElcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6zZPpV8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6zZPpV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12662C19425;
	Wed, 13 May 2026 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778707666;
	bh=aHt2NKRxzUXSpOW1argeSit/2ugz/S0VoZjEUP9Ehfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6zZPpV8XAXcSES7VaAyZu/u3qzoKwPUW4SkSNo6D/rXn1pFIrzpQdT05v8NlmBID
	 pOszelYyfX4s06gBC4aFHeQhX9a08s0YkEVALmTgm7rdDcKQITy4+pJeUoBmRikW/m
	 lUd1O+p4ozCzK4JAjEfOEp1Wp/klVk2uzueFYvWkLm5KRyJhCKCUYKN0ttn7FLWfNG
	 WRyff1EtSo5RQ5+GJLicDQoQuUm7L8lYiDI88QpbyR5LoMcXSVMLUlkyuh6sG+gI8u
	 MDy8hCoo9GflOs+T0KfJpCxRZTvsdsN5aCdNw+dfMATX/8Qi4nUwe1lU8dp9au7UhY
	 /WJLnvdwrh5ww==
Date: Wed, 13 May 2026 14:27:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 31/33] fuse: disable direct fs reclaim for any fuse
 server that uses iomap
Message-ID: <20260513212745.GT9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205813.4101881.6342439978613586458.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205813.4101881.6342439978613586458.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:31:47AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Any fuse server that uses iomap can create a substantial amount of dirty
> pages in the pagecache because we don't write dirty stuff until reclaim
> or fsync.  Therefore, memory reclaim on any fuse iomap server musn't
> ever recurse back into the same filesystem.  We must also never throttle
> the fuse server writes to a bdi because that will just slow down
> metadata operations.
> 
> Add a new ioctl that the fuse server can call on the fuse device to set
> PF_MEMALLOC_NOFS and PF_LOCAL_THROTTLE.  Either the fuse connection must
> have already enabled iomap, or the caller must have CAP_SYS_RESOURCE.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_iomap.h      |    2 ++
>  include/uapi/linux/fuse.h |    1 +
>  fs/fuse/dev.c             |    2 ++
>  fs/fuse/fuse_iomap.c      |   37 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 42 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
> index ca44df00f113d2..25c36c9c39d6f3 100644
> --- a/fs/fuse/fuse_iomap.h
> +++ b/fs/fuse/fuse_iomap.h
> @@ -76,6 +76,7 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
>  			 const struct fuse_iomap_dev_inval_out *arg);
>  
>  int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
> +int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
>  #else
>  # define fuse_iomap_enabled(...)		(false)
>  # define fuse_has_iomap(...)			(false)
> @@ -103,6 +104,7 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
>  # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
>  # define fuse_iomap_dev_inval(...)		(-ENOSYS)
>  # define fuse_iomap_fadvise			NULL
> +# define fuse_dev_ioctl_iomap_set_nofs(...)	(-EOPNOTSUPP)
>  #endif /* CONFIG_FUSE_IOMAP */
>  
>  #endif /* _FS_FUSE_IOMAP_H */
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c454cea83083d3..9e59fba64f48d9 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1195,6 +1195,7 @@ struct fuse_iomap_support {
>  #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
>  #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
>  					     struct fuse_iomap_support)
> +#define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
>  
>  struct fuse_lseek_in {
>  	uint64_t	fh;
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9918911fe44855..cf4bad6ffc287b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2741,6 +2741,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>  
>  	case FUSE_DEV_IOC_IOMAP_SUPPORT:
>  		return fuse_dev_ioctl_iomap_support(file, argp);
> +	case FUSE_DEV_IOC_SET_NOFS:
> +		return fuse_dev_ioctl_iomap_set_nofs(file, argp);
>  
>  	default:
>  		return -ENOTTY;
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index 94ed7c69d892d3..1e01e0011a412d 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -12,6 +12,7 @@
>  #include "fuse_trace.h"
>  #include "fuse_iomap.h"
>  #include "fuse_iomap_i.h"
> +#include "fuse_dev_i.h"
>  
>  static bool __read_mostly enable_iomap =
>  #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
> @@ -2289,3 +2290,39 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
>  	up_read(&fc->killsb);
>  	return ret;
>  }
> +
> +static inline bool can_set_nofs(struct fuse_dev *fud)
> +{
> +	if (fud && fud->fc && fud->fc->iomap)
> +	       return true;
> +
> +	return capable(CAP_SYS_RESOURCE);
> +}
> +
> +int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp)
> +{
> +	struct fuse_dev *fud = fuse_get_dev(file);

Codex complains that fuse_get_dev() can return EINTR, so we need to
handle that.

	if (IS_ERR(fud))
		return PTR_ERR(fud);

--D

> +	uint32_t flags;
> +
> +	if (!can_set_nofs(fud))
> +		return -EPERM;
> +
> +	if (copy_from_user(&flags, argp, sizeof(flags)))
> +		return -EFAULT;
> +
> +	/*
> +	 * The fuse server could be asked to perform a substantial amount of
> +	 * writeback, so prohibit reclaim from recursing into fuse or the
> +	 * kernel from throttling any bdis that the fuse server might write to.
> +	 */
> +	switch (flags) {
> +	case 1:
> +		current->flags |= PF_MEMALLOC_NOFS | PF_LOCAL_THROTTLE;
> +		return 0;
> +	case 0:
> +		current->flags &= ~(PF_MEMALLOC_NOFS | PF_LOCAL_THROTTLE);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> 
> 
