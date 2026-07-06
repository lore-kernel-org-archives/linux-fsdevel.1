Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687CF420866
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344804; cv=none; b=qAXe6Mv3J8zlmmNTdVC+IweADMtkk0qfo4cQR32lIR+sr93PDNTWwGpOiB9Au2CndROitXjmg3SQls6etpwnx/FfN4i8iU40AeWz6WJHKGYnnWbAfLB0e/E7KikxQsN+S2wVBPA0l5Qk3dx2XsiQUeLIBJNQTCyiDgRs7FYp0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344804; c=relaxed/simple;
	bh=+rYNyS02WRGjUgjKokpfe+cnNOsidKCjYJSWXPhHO3M=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cns/+dnG7eejGayj9UmLBgiyNdHWf0egynEDjT5D5c4JG9OUz6azspYU+KDgIUsa1SWNLh/rrjoGyeggyv0IGBnWvmZ+KvXvvtbxrK9aIYr4nWaQGOSJCvDm1aQeSctY2gP/725ldynTo87UdgJLMZXK6c//kWDQZJozglIDF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHTwc7Q6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHTwc7Q6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1D91F00A3A;
	Mon,  6 Jul 2026 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783344802;
	bh=rpu3PwAkKW2jp8jAAqfi1n+z+gI5T/LQ3XHoA7A67kE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IHTwc7Q6uK5bQxqqtRf0sOFcokMHZUZ38EemA5uYBrZqgiRmFj7g6Ei9mPW3asQkI
	 ibkhIziqrBzeTfgNWLlEiwMjYGXmgjTeWuqDwu2uL6hNKr2EhMx/4rn4cDTCRDnJnB
	 QaDfA6bIK0vKZSWUuLZUs1C0zidOPVPUpZqRu+EgmHqfHOSUt9CT7VI4zh95t3YelJ
	 QgTPl7VoGmaooiPsxejkUT5s1S6diyOPDCMvhLsPgiKDKLEOV77R8ZkDo7eSXRr4A+
	 w5S6JYLVzhfGCFsSnFkOF8HkQapcyMiyO2akoQuGJbb+KszNwiU+QCEo6+7C5Pcs8q
	 9uwTyXAtV5+Qw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] VFS: add vfs_lookup_open() for nfsd
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jori Koolstra <jkoolstra@xs4all.nl>
In-Reply-To: <20260705235447.1322365-4-neilb@ownmail.net>
References: <20260705235447.1322365-1-neilb@ownmail.net>
 <20260705235447.1322365-4-neilb@ownmail.net>
Date: Mon, 06 Jul 2026 15:33:17 +0200
Message-Id: <20260706-steril-fragil-worunter-f48995ef1b29@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3250; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+rYNyS02WRGjUgjKokpfe+cnNOsidKCjYJSWXPhHO3M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR5r1tYyM58UVlwUYSWgu+f/zphnG1SZu7LPdL/RV+Xa
 N+rtDino5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK5JQz/DIP789atuPVBNHnS
 v911m45qJt6Y+DxZ6WXLR1n/b6tfnmP4H7GTe3rl0nlXS38bKXh28XF80f5r/tBBodR/05f13mb
 MDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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
> 
> Signed-off-by: NeilBrown <neil@brown.name>
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 1ca738401afa..002ffae7083d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4568,6 +4568,76 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
> + *     Caller should check that the file opened is regular,
> + *     if something else was found, an O_PATH file is provided.
> + *     Caller should validate FMODE_CREATED if O_EXCL was requested.
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
> +	WARN_ONCE(mode & !S_IALLUGO, "mode must only have permission bits");
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
> +	} else if (!(file->f_mode & FMODE_OPENED)) {
> +		nd.path.dentry = dentry;
> +		if (!d_is_reg(dentry))
> +			/*
> +			 * allow caller to see dentry and choose
> +			 * correct error code
> +			 */
> +			file->f_flags |= O_PATH;
> +		error = vfs_open(&nd.path, file);

Imho, that really throws a wrench into this function. I'd rather just
fail with well-known error codes in that case:

/* directory */ -> EISDIR
/* device */    -> ENODEV

Also, why does the caller need to know details here? Because of the
O_DIRECTORY work? But even so, EFTYPE would be enough afaict, I think?

-- 
Christian Brauner <brauner@kernel.org>
