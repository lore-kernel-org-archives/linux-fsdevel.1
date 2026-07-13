Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352D3806CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939202; cv=none; b=D6Yvv7lgUUGKbhyDM1IdqseocMB/pcnqncXAEwR79jdmuWYWfW7lpfFRK29IpLYmh0FAGs9YSeRc5SLOwkJJEmYiPoYh4IbVwEHBIVOyBS/l2hARSXzQJoqwYXUOmsdb8r+gVecFT9gwr/tjRqBGTNCwyNy9KwZXr/+cN/Ep8XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939202; c=relaxed/simple;
	bh=I5+cZk95+tYLoObW7aEsDX4hpMr0KPZvgWWJkO8Zylc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oeWQcJ8eldQyZuyd9w6c/sEtvB72sPalaQAWnzO1wYtUvWCwyI9hN659TmbQsOAxL3RewLrKZTZk6hnp90jn3mdl1C914cKFKaMqORv1N7VM6BghqmSeH8dP3IpdXkrv69/YHa+lL9GavhsceejZkkltRdRxrm0R35gYKmyjUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Tw8OPvaZ; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Tw8OPvaZ"
X-KPN-MessageId: 2fb4df2f-7ea7-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2fb4df2f-7ea7-11f1-8f54-005056992ed3;
	Mon, 13 Jul 2026 12:39:55 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 2fb3297e-7ea7-11f1-91b9-00505699891e;
	Mon, 13 Jul 2026 12:39:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=33vTLPPrG8fF0B88J4zdQtMq73lLlubGi2ELpke7Xy8=;
	b=Tw8OPvaZdpQtSpoB8QchyHaJsWEDoWYIux3MEwRFZ+JijhlQ4oq7Lq52ZoJULv/MwtIa+zS+ibUqI
	 TTHyRGIERZ9u7wryvjrTg48Z+uNAjTjDeiWC9jkUPiKgTDxoqRNELySjK/a7BVUT4oHmje8NcaVwMV
	 nSEqv5KG/1q+R+e5PP3+u+JBYMSxmnTpW0ukBlSKzwtICGN3XSMmW6No3J+Lt0U0tsAWbw+VFmvt4z
	 UCZZADSSRoJTcVKJY/gFJW//gdWIXje+8+zhUPal7VMTx6bpp0yl8fCtbTe9EbGMmI/yXoasQoN5kU
	 xknRTUUNbflnVQNsJ50PkThdzBWP+xg==
X-KPN-MID: 33|cCC35/FlnPQT+zbdp84LBy85TqHko24yJLoeB8J+g5mfZ0rM4MgVzK6DS964M3P
 9UsFDic/64KnPUGvmIX9QnQ==
X-CMASSUN: 33|ndW5/n1OYZKD/YpnZEb3omSSsbAj+4iczGfk8+/d012a6zma7KPSkiaZUbUl82+
 mlcykiLZn7OQ0Amy8qINp/A==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 2fa1506a-7ea7-11f1-8edb-00505699eff2;
	Mon, 13 Jul 2026 12:39:54 +0200 (CEST)
Date: Mon, 13 Jul 2026 12:39:54 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Message-ID: <1899194169.820712.1783939194879@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260713060814.2849-4-neilb@ownmail.net>
References: <20260713060814.2849-1-neilb@ownmail.net>
 <20260713060814.2849-4-neilb@ownmail.net>
Subject: Re: [PATCH v3 3/3] VFS: add vfs_lookup_open() for nfsd
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


> Op 13-07-2026 08:05 CEST schreef NeilBrown <neilb@ownmail.net>:
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
> If a non-regular file is found, an O_PATH file is returned.  This allows
> the caller to see what was found and to return an appropriate error
> code.  However if ->atomic_open was used, it may return an error rather
> then provide a dentry.

Stale commit paragraph.

> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c            | 89 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h |  3 ++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index cb33a01d16eb..2143f759443a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4562,6 +4562,95 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
> + * In some cases, related errors are repurposed to so that the caller can
> + * determine the file of file found from the error.
> + * -EISDIR : a directory was found
> + * -ELOOP  : a symlink was found
> + * -ENODEV : a block or character device special file was found
> + * -EFTYPE : any other non-regular file was found, such as FIFO or SOCK.
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
> +	op.mode = S_IFREG | mode;
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

I think it would still be sensible to check the O_ flags being allowed to
be passed in. I get that nsfd is not going to do weird things, but if this
is a helper that may be used by other code too at some point (unaware of the
intricacies of lookup_open()) the context could help as we didn't go through
all the normal checks in build_open_flags().

Best,
Jori.
