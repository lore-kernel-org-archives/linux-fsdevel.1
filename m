Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619B184540
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2026 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788127630; cv=none; b=B+e0MYbqDaRXcMHKO+WfP0q2WRnHugJJtxTR4vwT/gUpFV7Mf8SXfpMhGk1Qx5HHOdhTcl6sg5SILr4clqnO3HTX6caEhUZd+OSN8VU5M8rBsohP5EuISe78qJ7FyFuVCP0DBhTM1HOyMv3QeTnDqw1clfyQkXg+Dg4LLHiQGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788127630; c=relaxed/simple;
	bh=57Mu784D4x6t4ZDIjBG5ypdqnipOtlVWOJ5KFZhhrEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfEjsXa+5cXTivDAZJzMT+jKv6ZUwWd3wKqeXgzqHXOD76cXFTJNqYV5uYEFIKV8RNlyQd76AZ5QhItceISPsVTv2VRIO54LEeXFSfSz5YvLFAnjkiI0EBSUfWKhhFrIOJNYMJfvZi4dUDUPbgK3IbatDt2CD0mwlq51u83gBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=msX4qP8E; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="msX4qP8E"
X-KPN-MessageId: f80c69e3-a4be-11f1-83b4-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f80c69e3-a4be-11f1-83b4-005056ab378f;
	Mon, 31 Aug 2026 00:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=Lsf5NsFzPaorS/9woplqtN+XphdrOiDRUsyY2lkrT5g=;
	b=msX4qP8Edkft2tfgAAQ1kGnOVQrbcndc5/UfBABVFORBJLNHsXv+M3tHAesujoV0+QkfF3RDx5gzY
	 fXHf2Msrd9pMOvgenCyxK6N5opRJXNVKs6QofR72wYblGMmYrsUYeSlwumg5mLGnbq/0G5M1ibGILy
	 JSKGEBPjDkwDj/7pe1EdTmdi5V9opMc10AtTbf6SOCHoZoPPHNsjh70gd3fYKIerLyIY6XPtAkodKL
	 +aGWOvOzXkiTnFVfO/xCEGmvFN63Epc/UMd2lnvPdSNnkhuAqtpsjT1toqgy9oo75jgN+1tfixnmZc
	 CdyBdGF1G2ITkQgODTzDpWT3Y0xEGJw==
X-KPN-MID: 33|Jv2/0rIq33NJNxEeypGaM1uyj44B33/L6yCGdo1JkLgZTJj7uk72kNflk5YzjyZ
 SDUl8xM+AP5fU/cwJcwaboinDWAq06YRJhJtqGyNJ6ks=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|x8nYVI/1Nv6lAVyMCIP6tj1z+q0wWe6QzKvKsbvRpibkBbMp+L/XTdM5AJ2uIc3
 F9FdqkoCLtCBC//z4eBlyHw==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f74c8911-a4be-11f1-927f-005056ab1411;
	Mon, 31 Aug 2026 00:05:53 +0200 (CEST)
Date: Mon, 31 Aug 2026 00:05:45 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] fs: avoid spurious dentry ref/unref cycle on open
Message-ID: <apSkPymcTBsKOjCV@lt-jori.localdomain>
References: <20260803125138.1937674-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803125138.1937674-1-mjguzik@gmail.com>

On Mon, Aug 03, 2026 at 02:51:38PM +0200, Mateusz Guzik wrote:
> Opening a file grabs a reference on the terminal dentry in
> __legitimize_path(), then another one in do_dentry_open() and finally
> drops the initial reference in terminate_walk().
> 
> That's 2 modifications which don't need to be there -- do_dentry_open()
> can consume the already held reference instead.
> 
> When benchmarking on a 20-core vm using will-it-scale to open the same
> file read-only, the results are (ops/s):
> before:	4043375
> after:	5629378 (+39%)
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

So, the legitimize path stuff grabs a ref to the nd path which is
balanced at terminate_walk(), and you're saying that in the regular open
path (not O_TMPFILE or O_PATH), since vfs_open() also grabs a ref, why
not reuse that one. Is that what you are saying?

It seems then that this issue also plagues do_o_path():

static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
{
	struct path path;
	int error = path_lookupat(nd, flags, &path);
	if (!error) {
		audit_inode(nd->name, path.dentry, 0);
		error = vfs_open(&path, file);
		path_put(&path);			// Not needed?
	}
	return error;
}

> ---
> 
> The spurious ref cycle remains an issue and it is trivially avoidable,
> for the most common case anyway.
> 
> Al Viro had a more involved patchset which got stalled, see:
> https://lore.kernel.org/linux-fsdevel/20240822003359.GO504335@ZenIV/
> 
> I already pointed this out over a year ago when sending v3.
> 
> Given lack of traffic on the more involved variant, the nice win from my
> simple patch and its overall triviality, I think it should go in. Worst
> case, if the more involved work ever gets off the ground it can be
> trivially reverted later.
> 
> bench is:
> $ cat tests/openro3.c
> 
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <assert.h>
> 
> static char tmpfile[] = "/tmp/willitscale.XXXXXX";
> 
> char *testcase_description = "Same file open/close read-only";
> 
> void testcase_prepare(unsigned long nr_tasks)
> {
> 	int fd = mkstemp(tmpfile);
> 
> 	assert(fd >= 0);
> 	close(fd);
> }
> 
> void testcase(unsigned long long *iterations, unsigned long nr)
> {
> 	while (1) {
> 		int fd = open(tmpfile, O_RDONLY);
> 		assert(fd >= 0);
> 		close(fd);
> 
> 		(*iterations)++;
> 	}
> }
> 
> void testcase_cleanup(void)
> {
> 	unlink(tmpfile);
> }
> 
> v5:
> - the extra ref is of course needed, i blame the heatwave for thinking
>   it is not this time around
> 
> v4:
> - rebase
> - don't grab the extra ref on mnt for truncate
> - bench opening things r/o. note perf improved from last year thanks to
>   other changes
> 
> 
>  fs/internal.h |  1 +
>  fs/namei.c    | 15 ++++++++++++---
>  fs/open.c     | 27 ++++++++++++++++++++++++++-
>  3 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index c658c8a5ebd5..9632239036ac 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -205,6 +205,7 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
>  		int flag);
>  int chown_common(const struct path *path, uid_t user, gid_t group);
>  extern int vfs_open(const struct path *, struct file *);
> +int vfs_open_consume(struct path *, struct file *);
>  
>  /*
>   * inode.c
> diff --git a/fs/namei.c b/fs/namei.c
> index 3f9bf103ba12..f71481b9bf8f 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4789,6 +4789,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  static int do_open(struct nameidata *nd,
>  		   struct file *file, const struct open_flags *op)
>  {
> +	struct vfsmount *mnt;
>  	struct mnt_idmap *idmap;
>  	int open_flag = op->open_flag;
>  	bool do_truncate;
> @@ -4830,11 +4831,17 @@ static int do_open(struct nameidata *nd,
>  		error = mnt_want_write(nd->path.mnt);
>  		if (error)
>  			return error;
> +		/*
> +		 * A dedicated reference is needed because after the call to
> +		 * vfs_open_consume() we no longer own the reference in nd->path.mnt
> +		 * while we need to undo write acess below.
> +		 */
> +		mnt = mntget(nd->path.mnt);

Is this needed? The file cannot be closed until after open(2) is done,
so how can that ref be lost before reaching mnt_drop_write below?

>  		do_truncate = true;
>  	}
>  	error = may_open(idmap, &nd->path, acc_mode, open_flag);
>  	if (!error && !(file->f_mode & FMODE_OPENED))
> -		error = vfs_open(&nd->path, file);
> +		error = vfs_open_consume(&nd->path, file);
>  	if (!error)
>  		error = security_file_post_open(file, op->acc_mode);
>  	if (!error && do_truncate)
> @@ -4843,8 +4850,10 @@ static int do_open(struct nameidata *nd,
>  		WARN_ON(1);
>  		error = -EINVAL;
>  	}
> -	if (do_truncate)
> -		mnt_drop_write(nd->path.mnt);
> +	if (do_truncate) {
> +		mnt_drop_write(mnt);
> +		mntput(mnt);
> +	}
>  	return error;
>  }
>  
> diff --git a/fs/open.c b/fs/open.c
> index 6b1c14e684a9..2a7697cee00b 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -931,6 +931,11 @@ static inline int file_get_write_access(struct file *f)
>  	return error;
>  }
>  
> +/*
> + * Populate struct file
> + *
> + * NOTE: it assumes f_path is populated and consumes the caller's reference.
> + */
>  static int do_dentry_open(struct file *f,
>  			  int (*open)(struct inode *, struct file *))
>  {
> @@ -938,7 +943,6 @@ static int do_dentry_open(struct file *f,
>  	struct inode *inode = f->f_path.dentry->d_inode;
>  	int error;
>  
> -	path_get(&f->f_path);
>  	f->f_inode = inode;
>  	f->f_mapping = inode->i_mapping;
>  	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
> @@ -1055,6 +1059,7 @@ int finish_open(struct file *file, struct dentry *dentry,
>  	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
>  
>  	file->__f_path.dentry = dentry;
> +	path_get(&file->f_path);
>  	return do_dentry_open(file, open);
>  }
>  EXPORT_SYMBOL(finish_open);
> @@ -1098,6 +1103,7 @@ int vfs_open(const struct path *path, struct file *file)
>  	int ret;
>  
>  	file->__f_path = *path;
> +	path_get(&file->f_path);
>  	ret = do_dentry_open(file, NULL);
>  	if (!ret) {
>  		/*
> @@ -1110,6 +1116,25 @@ int vfs_open(const struct path *path, struct file *file)
>  	return ret;
>  }
>  
> +/**
> + * vfs_open_consume - open the file at the given path and consume the reference
> + * @path: path to open
> + * @file: newly allocated file with f_flag initialized
> + */
> +int vfs_open_consume(struct path *path, struct file *file)
> +{
> +	int ret;
> +
> +	file->__f_path = *path;
> +	path->mnt = NULL;
> +	path->dentry = NULL;
> +	ret = do_dentry_open(file, NULL);
> +	if (!ret) {
> +		fsnotify_open(file);
> +	}
> +	return ret;
> +}
> +
>  struct file *dentry_open(const struct path *path, int flags,
>  			 const struct cred *cred)
>  {
> -- 
> 2.53.0
> 

Thanks,
Jori.
