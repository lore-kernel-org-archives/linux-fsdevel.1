Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F13955FB
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072123; cv=none; b=SNGKJzofO6qljvqX5apJht8ts++oVPOh/yxKogHGeZC3kvd+QdDqvPdKB+1xs6WVfziXR6KX6hwrMVO6HRLX/sxAu0TyoQCA6H5VNwigHUQ8tvxTdLwzNWz9zBhXTvNrgTZdg+sq6g08noga+MVHPDzPvZVodMMYsGRxR+TT97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072123; c=relaxed/simple;
	bh=qCpAU3TIY6HX9nnbRVK8k2FRexBeVcv8ABGQJ+e4KTw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OCTjlTh4REBc9TOo4Sktfg6lEAfJFY2lSvAv/UAegd6Fr0n2reUEg3TwJUs1kI9QWvENAqf+Phc5Kk0GOqUCnSO9bIT3S+B/mlDE2x0WWl2a1OI9oiQSwKgEjIft02bckcKp06Hb40yI+col6j9euCBGjABptf3oofC6vpviRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpZ+hLvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpZ+hLvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2C71F000E9;
	Fri,  3 Jul 2026 09:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072120;
	bh=LJO8Y0qvUj+/VTe86yo8t9fy5lKL0VPc7cKRzy0tBA4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=OpZ+hLvCptvoXCgTsANdxuj/DGtU37oGGR23/UtPqDbOqujtsRnezeu0ztGBfDuTm
	 IcZVLOiBLq6dSmmi/SnR+LM1tyCX5EYj7ZjWA73lIVIhGTISqZrNYvnQliuVYIgJV/
	 vy9joZJSvHDnoFMCfi+WSl3+36Y/D9XZ4ez7RBPaqZwXXNC37qI2GTAlo52OsomKHC
	 HYYvkc/rut4RKDx7OfS2uGKrgNs8c58eWrbkfb+Q4EwY6GnOm+FcLKXTcWA2EeU1Bp
	 p6ooYPQSwb2kU93RroveZStqYh169YW193G4G5f5lJGNthgyCd0YnitN5KE444ssnP
	 hnDFRJ2ugeSZw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] VFS: add vfs_lookup_open()
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jori Koolstra <jkoolstra@xs4all.nl>
In-Reply-To: <20260702111529.3559835-4-neilb@ownmail.net>
References: <[PATCH 0/3] VFS: replace dentry_create>
 <20260702111529.3559835-1-neilb@ownmail.net>
 <20260702111529.3559835-4-neilb@ownmail.net>
Date: Fri, 03 Jul 2026 11:48:36 +0200
Message-Id: <20260703-sololauf-erheiterung-resozialisieren-5f2d4f5b791f@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qCpAU3TIY6HX9nnbRVK8k2FRexBeVcv8ABGQJ+e4KTw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5t5ZtXeS3s2vv6+epM01LgraqGKy99PTtr12S/xT2p
 DJWaj6Y3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR9TMZGS5kBj4I/LT/JbMV
 EzP7X413/xa8MVJbzn/w64vVyWo+MlcZ/seZvNGuLLmUUsBcV+W3xGi+z9o/oavaP8/NU1w+M3H
 2Gw4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> vfs_lookup_open() is a limited version of lookup_open() which is
> exported for nfsd to use - to replace dentry_create().
> 
> It is limited in that no filename is given (thus no auditing) and no
> LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
> the open flags.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
>
> diff --git a/fs/namei.c b/fs/namei.c
> index cb33a01d16eb..737c4b2422dc 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4562,6 +4562,65 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
> + * functionality open_last_lookups() for in-kernel users, particularly
> + * nfsd.
> + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
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

You should assert that either mode_t mode doesn't container S_IFMT or
that it contains S_IFREG. WARN_ON_ONCE() would be appropriate here since
it's not really a fast path.

> +	dentry = lookup_open(&nd, file, &op);
> +
> +	if (IS_ERR(dentry))
> +		return ERR_CAST(dentry);
> +
> +	if (d_really_is_negative(dentry)) {
> +		error = -ENOENT;
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

Afaict nfs is compilable as a module so this needs a symbol export.
Since this is for consumption by nfs only it would be prudent to use:

EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "WHATEVER_THE_MODULE_THING_IS");

so it can only be consumed by nfs.

-- 
Christian Brauner <brauner@kernel.org>
