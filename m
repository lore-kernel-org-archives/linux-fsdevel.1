Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B199E344D91
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151805; cv=none; b=RQczbEqqUbukvM5GGoWxrWd7gTV8VBDDHCKlj4eo02fYrMGlR92reRI+TBgbwxtZbKcFrWSi7qNOqTK+PY/3W8bX2iRy45YSmvq+5VXEidS0D7c1EFu/rQEz98INwv/KR0BMsGrGNiL27tD2HxYKWbAyJp3BZxjLNHQcx2AtuMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151805; c=relaxed/simple;
	bh=7u57Gczzlmsak8YtA1QwE3bILuFCgA1G6AheEvWUReY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BhZQoiRbOkXCU4nB6YguCA73UOKyTpcnmNG/jh5YB/ghimfOJOCUcvNu9oP4rkWXbEGkEi6rRLrr0PEIeQVvSOcylWwwdvcpgiWUiP8f91ak4CxAt5e4mjpO1Cf0AKCvdWpR8oi0OFTZkHVFSOM568wZPh0lRkEyVrUb88gxP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=uwkY1MD8; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="uwkY1MD8"
X-KPN-MessageId: 322eda85-8096-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 322eda85-8096-11f1-8f54-005056992ed3;
	Wed, 15 Jul 2026 23:43:20 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 322dd654-8096-11f1-9b0c-00505699693e;
	Wed, 15 Jul 2026 23:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=UBEx3/dTZVYIeyYLMEeHLArKqDvp66UAcZ3kOJGs2Ng=;
	b=uwkY1MD8ZDOOGNL87VSdLVYff9QmUwbGH+aLjuWinX2I7LfF2Z0aA+ESjKTwsbx4qgK9TwAkH26JA
	 ZHvhlR6C2+PQ+ObCfLuVlG2538abonlwSRKWryX+RTUGFvlc99Zcp0Yt/rut3jLueBeSkts3eghmLr
	 YFk1yRyzO1d7JDUTPcHq4rFcVfk2d0R13fQgyhb6wlswFmUCmWvVgDRTJLGb5sP2DOuPQGToUAiazT
	 8qgZAN9Ewnp/sbpADEWnLe37YI3TndJeKeGctxGuxhTlK9oubrqZsjU9A3mlZu4dBaxmj86qLV0ImW
	 6Bj8BdM3GLOG3jCSOyINfu0cxaZJ22A==
X-KPN-MID: 33|Gym1H851Eb4Ko2O71k0Pg0YisVLyawvqAm22s+tgQq3GVbyKH9O7ZZhhQTGbIlo
 G3YeYdSv3iDjLlSDcvqPGIUw/yOhljVpdJKnpTIZtEUQ=
X-CMASSUN: 33|y+ypWrPvWd/5hAFI9rJ52XeABvadprY0ldpGRMZHcrA70yxqgQRl7/m9f0NUvAN
 yqgs5IK5BLx/7de1ZivuWyQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 3222e6a7-8096-11f1-916a-005056995d6c;
	Wed, 15 Jul 2026 23:43:20 +0200 (CEST)
Date: Wed, 15 Jul 2026 23:43:19 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Message-ID: <21817263.1168614.1784151799976@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260714230534.776886-4-neilb@ownmail.net>
References: <20260714230534.776886-1-neilb@ownmail.net>
 <20260714230534.776886-4-neilb@ownmail.net>
Subject: Re: [PATCH v4 3/3] VFS: add vfs_lookup_open() for nfsd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 15-07-2026 01:04 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> From: NeilBrown <neil@brown.name>
> 
> vfs_lookup_open() is a limited version of lookup_open() which is
> exported for nfsd to use - to replace dentry_create().
> 
> It is limited in that no filename is given (thus no auditing) and no
> LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
> the open flags.
> 
> If a non-regular file is found and appropriate error is returned and no
> file is opened.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c            | 96 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h |  3 ++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index cb33a01d16eb..630f93608224 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4562,6 +4562,102 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	goto out;
>  }
>  
> +/**
> + * vfs_lookup_open - open and possibly create a regular file
> + * @parent: directory to contain file
> + * @last: final component of file name
> + * @open_flag: O_flags
> + * @mode: initial permissions for file
> + *
> + * Open a file after lookup and/or create.  This provides similar
> + * functionality open_last_lookups() for non-VFS users, particularly
> + * nfsd.
> + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
> + *
> + * If the fs object found is not a regular file then an error is returned.
> + * In some cases, related errors are repurposed so that the caller can
> + * determine the type of file found from the error.
> + * -EISDIR : a directory was found
> + * -ELOOP  : a symlink was found
> + * -ENODEV : a block or character device special file was found
> + * -EFTYPE : any other non-regular file was found, such as FIFO or SOCK.
> + *           or ->atomic_open responded to __O_REGULAR.
> + *
> + * Returns: the opened struct file, or an error.
> + */
> +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> +			     int open_flag, umode_t mode)
> +{
> +	struct file *file __free(fput) = NULL;
> +	struct nameidata nd = {};
> +	struct open_flags op = {};
> +	struct dentry *dentry;
> +	int error = 0;
> +
> +	WARN_ONCE(mode & ~S_IALLUGO, "mode must only have permission bits");
> +	WARN_ONCE(open_flag & ~(O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC|__O_REGULAR),
> +		  "open_flag has unsupported flags");
> +
> +	mode |= S_IFREG;
> +	open_flag |= __O_REGULAR;
> +
> +	error = lookup_noperm_common(last, parent->dentry);
> +	if (error)
> +		return ERR_PTR(error);
> +
> +	file = alloc_empty_file(open_flag, current_cred());
> +	if (IS_ERR(file))
> +		return file;
> +
> +	nd.path = *parent;
> +	nd.last = *last;
> +	nd.flags = LOOKUP_OPEN;
> +	if (open_flag & O_CREAT) {
> +		nd.flags |= LOOKUP_CREATE;
> +		if (open_flag & O_EXCL)
> +			nd.flags |= LOOKUP_EXCL;
> +	}
> +	op.open_flag = open_flag;
> +	op.mode = mode;
> +	dentry = lookup_open(&nd, file, &op);
> +
> +	if (IS_ERR(dentry))
> +		return ERR_CAST(dentry);
> +
> +	if (d_really_is_negative(dentry)) {
> +		error = -ENOENT;
> +	} else if (!(file->f_mode & FMODE_CREATED) && (open_flag & O_EXCL)) {
> +		error = -EEXIST;
> +	} else if ((dentry->d_inode->i_mode & S_IFMT) != S_IFREG) {
> +		switch (dentry->d_inode->i_mode & S_IFMT) {
> +		case S_IFDIR:
> +			error = -EISDIR;
> +			break;
> +		case S_IFLNK:
> +			error = -ELOOP;
> +			break;
> +		case S_IFBLK:
> +		case S_IFCHR:
> +			error = -ENODEV;
> +			break;
> +		case S_IFIFO:
> +		case S_IFSOCK:
> +		default:
> +			error = -EFTYPE;
> +			break;
> +		}
> +	} else if (!(file->f_mode & FMODE_OPENED)) {
> +		nd.path.dentry = dentry;
> +		error = vfs_open(&nd.path, file);
> +	}
> +	dput(dentry);
> +
> +	if (error)
> +		return ERR_PTR(error);
> +	return no_free_ptr(file);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "nfsd");
> +
>  static inline bool trailing_slashes(struct nameidata *nd)
>  {
>  	return (bool)nd->last.name[nd->last.len];
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index ebe6e29f7e93..86d657b24fc6 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -97,6 +97,9 @@ struct dentry *start_creating_dentry(struct dentry *parent,
>  struct dentry *start_removing_dentry(struct dentry *parent,
>  				     struct dentry *child);
>  
> +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> +			     int open_flag, umode_t mode);
> +
>  /* end_creating - finish action started with start_creating
>   * @child: dentry returned by start_creating() or vfs_mkdir()
>   *
> -- 
> 2.50.0.107.gf914562f5916.dirty

So I am not really familiar with the nsfd backend where this function will be put
to use, but I imagine you need the fileserver to mirror operations on the client.
And since from within the kernel we don't do syscalls, we need this function to
mimic the client syscall path and call into the actual underlying fs. Is that
more-or-less correct?

So then the rights checking happens on the properly authenticated client-end? Or
does nsfd have another mechanism for that?

I just want to ensure that using this function cannot bypass the sticky directory
semantics, as that now is the task of do_open(), which this skips of course.
If that is OK, this function LGTM :)

Best,
Jori.
