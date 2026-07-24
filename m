Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA9442B31
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927442; cv=none; b=GqboxAxTswV8UXjf0XR4bas2+QMX/7nbp1U4RZL6V0XR2BGh/exB0qkFjdM1d+GjqA/BNXUoz8+XKByQpyNDWikT7Jk/ImXRVrY78khsVD04a7fj15ci0hXjy9PmJQrZ+IR3Tm/YFwpPjN1XiqSueRBl/wowU0N9B+ixY3KBkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927442; c=relaxed/simple;
	bh=lXiTbCoF1xSHjXVqT9zFR+fsIblmzXmW2oxnIVVqhtI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=QJU8sBihHalJPcqK/cRoTXeujKT2i0FAddbjmQzXNiGzxUBf9vAsUgV8nCiIcP85JTXVvWWFOh3rnhxr2aFh9T13AgF9fDlAnNHzKtQhqottk/ZiY7RPgRLrUpgJtXGqnuEvmv9xxg/tcAXhn4DE/tcEnxAcF6gdX8T9e/lyr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EAA9uKjd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EAA9uKjd"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-930f618435cso91072685a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784927438; x=1785532238; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3IG3ZNFIRzLkN3J7B1J95iq9NSlbYwcwTkMTFFpU9+o=;
        b=EAA9uKjdQ+6oSehtGXAj49gvtGCg1eqkhCWFP72B4eUowQL19FSCZZDNclE4PNHc1i
         3bEUqF99C0Rpei9hIhDNIBiqhjVxE9Su23iY8439XcAsmNm+wSdbmOJTVWBP/jctqjNa
         o8tdxsbSCOWkVMrMNNQPju8+vc9m5MNlgL/HxLRCeJ2DrQVjc2rkbEmrWr6PQxQEFXWT
         e6W0vE7V0IqJHIODrZGlCxTYpwnIfwlTGnC35lt/d5C+ZYz7xT6ucouriwzzYvDDM+8G
         Sa+4FaRcHTDdatgQWZK8VC+d2kd8oejjNZ+I7lZxutlj/K8ox23hDk466SdhODDZZrMw
         jSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927438; x=1785532238;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IG3ZNFIRzLkN3J7B1J95iq9NSlbYwcwTkMTFFpU9+o=;
        b=OTyP+X+/jdqgelyhwFBYtfF+Aob+5SoocFfD45n0WJzZrBTU8EqAZgCUEDqVa79jHi
         pwThSBBBdGmV8nGFp/wnxMPF+k6Fa47YC4WWAu9sTKuB2ByxBEQj23yA9zh0j64Jo1LL
         Tpw/7hmxMh6VpyHCYWjDA3LSRnfbD16rdHZNTcFoHgCHi0ei2R9g/v1s9C1UwBOY1kFN
         yEr3uvzsVHgLLQt4kiPF4dZhaB2eT0bkkDGnpuuaGTyrUXxFBhMpxyW9TxJlkYHTPScG
         dhftrRzyjU4+yKRdyN5qUWDJCaWJtJjHfDOpAnkHbrKiI2Kz8wRuGnGAQow+gTiHBQ0V
         QzTA==
X-Forwarded-Encrypted: i=1; AHgh+RpO1ien1wxBzSdSEmr3oD3/pDipEydJfb4gWhl4ooChbor64XcyxFv8dGKu6lCNcWY/ovlQ0DmeWJaOcHC2@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7HdNrXQeqYJdGxlQc4X9jYKV7OGQLvR70Ubj+08E+mr9IR1J
	5YpbgelGQM1woPeSXnRFnoluUjQ94t/cYKRxGQxqnq69ocxLl6wKa5gB1e1nw3Rn4A==
X-Gm-Gg: AR+sD10+jT6efL/Iydfc8Nwv5S92NoEujhQM3ekQx6GorabgUlGGuC9logXp6ttLvOA
	2spK6GM+IWY0qCn9FR+xjkEuBWRMtKofpqXJcGy1dJqsEG1XTKgUq3MD/JB6xdDOl2qlv6SY7ys
	iK9a2YzKniFHMgkHcGaWYpCMXWaDC+MjvV5McvYeESqy6jKiWrK3WJuJ5Sa1rl9GvA0FRi8+oLK
	qopqbhWtri0I2u3iADfuIlvOfDAwLkycf4vYA7P+ZABboiEl8luFAZWEtkdNZR5hJiCKbMljzhc
	g5OGvdbrVckJFui0tmBsGOKzii47HmQncUH2/vJagd+rBl48hs4IGtFMIzJQJIQaZJ607bmDS38
	S4X88+gtFXl9ilZZ+taaNVVATQqJdug4HZhH2qZ7SdYVsliIlg+ONTyHaqeGVtgOUpcs7dwXvrc
	ZQTquoaLv9Td+67w0Trb+QoVKEcvaoDl4/jOf80J4/Fw7g1wA=
X-Received: by 2002:a05:620a:a1cc:20b0:92f:1d0:871c with SMTP id af79cd13be357-93103a685d2mr773505185a.75.1784927438489;
        Fri, 24 Jul 2026 14:10:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de635855sm6186085a.22.2026.07.24.14.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:10:37 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:10:36 -0400
Message-ID: <c2985096f8d2b03e0b1cca7006a71be9@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260724_1628/pstg-lib:20260724_1535/pstg-pwork:20260724_1628
From: Paul Moore <paul@paul-moore.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Eric Paris <eparis@redhat.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Jori Koolstra <jkoolstra@xs4all.nl>
Subject: Re: [PATCH 2/3] vfs: call audit_inode_child() in lookup_open() on  failure
References: <20260710164233.827744-3-jkoolstra@xs4all.nl>
In-Reply-To: <20260710164233.827744-3-jkoolstra@xs4all.nl>

On Jul 10, 2026 Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> 
> audit_inode_child() is called in may_create_dentry() so that failed
> filesystem operations still register an audit entry. On success, the
> entry is overwritten when, for instance, fsnotify_create() is called.
> This is the calling convention in vfs_create() and vfs_mkdir().
> In lookup_open(), however, when atomic_open() should have created a
> file but didn't, no call to audit_inode_child() is made. The same is
> true for the regular ->create() path.
> 
> Fix the calling of audit_inode_child() in lookup_open() to match the
> vfs_create() path. For the ->atomic_open() filesystems this logic has
> been pushed into atomic_open(). This function is also reordered a bit
> to make the case distinction of the possible returns from
> ->atomic_open() more explicit (i.e. finish_open() or finish_no_open()).
> 
> When retrying delegation breaking, audit_inode_child() could be called
> more than once, but this is OK because those entries are reused.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 92 ++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 55 insertions(+), 37 deletions(-)

I didn't dig into the directory lease/delegation changes because there
are better people on the To/CC line to comment on that, but the audit
changes look good to me.  Thanks for working on this, help is always
appreciated :)

Acked-by: Paul Moore (audit) <paul@paul-moore.com>

> diff --git a/fs/namei.c b/fs/namei.c
> index 447eda7cbe34..fe5d59c6f925 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4351,35 +4351,55 @@ static int may_o_create(struct mnt_idmap *idmap,
>   */
>  static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
>  				  struct file *file,
> -				  int open_flag, umode_t mode)
> +				  int open_flag, umode_t mode, int create_error)
>  {
>  	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
> -	struct inode *dir =  path->dentry->d_inode;
> +	struct inode *dir_inode = path->dentry->d_inode;
>  	int error;
>  
>  	file->__f_path.dentry = DENTRY_NOT_SET;
>  	file->__f_path.mnt = path->mnt;
> -	error = dir->i_op->atomic_open(dir, dentry, file,
> +	error = dir_inode->i_op->atomic_open(dir_inode, dentry, file,
>  				       open_to_namei_flags(open_flag), mode);
>  	d_lookup_done(dentry);
> +
>  	if (!error) {
>  		if (file->f_mode & FMODE_OPENED) {
> -			if (unlikely(dentry != file->f_path.dentry)) {
> +			/* finish_open() called */
> +			struct dentry *opened = file->f_path.dentry;
> +			if (unlikely(opened != dentry)) {
>  				dput(dentry);
> -				dentry = dget(file->f_path.dentry);
> +				dentry = dget(opened);
>  			}
> -		} else if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
> -			error = -EIO;
> -		} else {
> -			if (file->f_path.dentry) {
> +		} else if (likely(file->f_path.dentry != DENTRY_NOT_SET)) {
> +			/* finish_no_open() called */
> +			struct dentry *replaced = file->f_path.dentry;
> +			if (replaced) {
>  				dput(dentry);
> -				dentry = file->f_path.dentry;
> +				dentry = replaced;
>  			}
>  			if (unlikely(d_is_negative(dentry)))
>  				error = -ENOENT;
> +		} else {
> +			const char *fsname = dentry->d_sb->s_type->name;
> +			WARN(1, "%s: ->atomic_open() left file->f_path.dentry unset!\n",
> +			        fsname);
> +			error = -EIO;
>  		}
>  	}
> +
>  	if (error) {
> +		if (unlikely(create_error) && error == -ENOENT) {
> +			/*
> +			 * Should have done a create, but errored before.
> +			 * Some filesystems return -ENOENT directly instead of
> +			 * calling finish_no_open() with a negative dentry;
> +			 * either way it should only mean the child doesn't exist,
> +			 * so a refused create is safe to record here.
> +			 */
> +			audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> +			error = create_error;
> +		}
>  		dput(dentry);
>  		dentry = ERR_PTR(error);
>  	}
> @@ -4437,7 +4457,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		dentry = NULL;
>  	}
>  	if (dentry->d_inode) {
> -		/* Cached positive dentry: will open in f_op->open */
> +		/* Cached positive dentry: will open in do_open(). */
>  		return dentry;
>  	}
>  
> @@ -4471,10 +4491,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (dir_inode->i_op->atomic_open) {
>  		if (nd->flags & LOOKUP_DIRECTORY)
>  			open_flag |= O_DIRECTORY;
> -		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
> -		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
> -			dentry = ERR_PTR(create_error);
> -		return dentry;
> +		return atomic_open(&nd->path, dentry, file, open_flag, mode, create_error);
>  	}
>  
>  	if (d_in_lookup(dentry)) {
> @@ -4490,32 +4507,36 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  			dentry = res;
>  		}
>  	}
> +	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
> +		/* No need to create a file. If lookup returned a positive
> +		 * dentry, the file will be opened in do_open(). */
> +		return dentry;
> +	}
> +
> +	/* Negative dentry with O_CREAT flag set */
> +	audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
>  
> -	if (unlikely(create_error) && !dentry->d_inode) {
> +	if (unlikely(create_error)) {
> +		/* should have done a create, but we already errored */
>  		error = create_error;
>  		goto out_dput;
>  	}
>  
> -	/* Negative dentry, just create the file */
> -	if (!dentry->d_inode && (open_flag & O_CREAT)) {
> -		/* but break the directory lease first! */
> -		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
> -		if (error)
> -			goto out_dput;
> -
> -		file->f_mode |= FMODE_CREATED;
> -		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> -		if (!dir_inode->i_op->create) {
> -			error = -EACCES;
> -			goto out_dput;
> -		}
> +	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
> +	if (error)
> +		goto out_dput;
>  
> -		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
> -						mode, open_flag & O_EXCL);
> -		if (error)
> -			goto out_dput;
> +	file->f_mode |= FMODE_CREATED;
> +	if (!dir_inode->i_op->create) {
> +		error = -EACCES;
> +		goto out_dput;
>  	}
>  
> +	error = dir_inode->i_op->create(idmap, dir_inode, dentry,
> +					mode, open_flag & O_EXCL);
> +	if (error)
> +		goto out_dput;
> +
>  	return dentry;
>  
>  out_dput:
> @@ -5053,7 +5074,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
>  
>  		/* atomic_open will dput(dentry) on error */
>  		dget(orig_dentry);
> -		dentry = atomic_open(path, dentry, file, flags, mode);
> +		dentry = atomic_open(path, dentry, file, flags, mode, create_error);
>  		error = PTR_ERR_OR_ZERO(dentry);
>  
>  		if (IS_ERR(dentry))
> @@ -5063,9 +5084,6 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
>  			/* Drop the extra reference */
>  			dput(orig_dentry);
>  
> -		if (unlikely(create_error) && error == -ENOENT)
> -			error = create_error;
> -
>  		if (!error) {
>  			if (file->f_mode & FMODE_CREATED)
>  				fsnotify_create(dir->d_inode, dentry);
> -- 
> 2.55.0

--
paul-moore.com
