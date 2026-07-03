Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AE13161A4
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078848; cv=none; b=Q78LqT6WAEvGk+DvyVu78ESGg5MYXsXrUiqYxqeRCIJ/PqJbWwTCXFI8VfnamRDrCgiOi8I4+sDhGcUUTxxx6OqDeg7GvuCy+NyhIFF2fycwdL2IQ5Im1gRJhItLZvGchuIfTymi97mpZkh6Ja/eAW5Iy2VmXopCdsWMQSXstc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078848; c=relaxed/simple;
	bh=NI8LkYKrS+8vnsvJJ3p4pDFPcqRU+t01Ph61ngM+R7c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nXyzlmJy3CUxiS+12iDWVxcet3IYQC3gecYtH7PFkFf9wL/tKLB7U4M1W6IDZQcVHxoLTTwbHz4RU510T5UROdpx7R0aDc6DxRG4TLVTsOSdBTDwazoIiRMSe9lMpZP8oML+CN5UIFWiH01A9whAXixYqz86qNJNvYqPL73Kff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=SxzXmtLs; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="SxzXmtLs"
X-KPN-MessageId: 06bf7c8f-76d4-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 06bf7c8f-76d4-11f1-bfba-00505699b430;
	Fri, 03 Jul 2026 13:40:44 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 06be286d-76d4-11f1-ae68-0050569981f5;
	Fri, 03 Jul 2026 13:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=l2beMmFi4U8+WuPh7TjjIBOQCFrinNxlkwp66YYG7Ps=;
	b=SxzXmtLsnBCOjzy0D+69F0Z59E3lnDBowGwq6KgMxQHsnQS2ijuTIbdmouKhHqib4pNFqbcTVPE2q
	 HFKizZ/XJul6kgnFn6mTgZ2PeQW/1sm9xS485ziThZe7tnxhIRGqPOwe3GBzVrnYBF1/NztXkR5vO1
	 ShoB1UoWw34rsqJ/j1ODbf6LvVbcw4PeGiyKT6PIHWNSBppzhaF2VCUnYaHXI8IBwkJNr4SbNoGxYX
	 hCaO2VVx2v/WlekNtPI9GGo8LgazmpOrzqDYTAwEC0HqwCYHixLz0Efvxqhr8qzzIz4Y+2oP/BBVoy
	 m1TTHpc2eeN3zGx8ehHpEqSo03Qm4rw==
X-KPN-MID: 33|Jjuz26zIzOjd4JK2YHfebOZYpaZTSKgIKuEXiTdkxm5zFWPr6bvpfnhGYL7xl1Q
 SiT2Fj/wgmL+xK+JNNi7X5JdT7o1XUSsT+D3ZM+Bjvys=
X-CMASSUN: 33|3MZjFG0nRglD1nj4SH6g/DmN7PFvzcDUFiq6sFRpyzxwoUOPHDwu5QvI5kOGbQq
 T0G+kyG2slMbtK641HMQP5w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 06b3a8e9-76d4-11f1-8edb-00505699eff2;
	Fri, 03 Jul 2026 13:40:44 +0200 (CEST)
Date: Fri, 3 Jul 2026 13:40:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Message-ID: <469116844.3933963.1783078844275@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260702111529.3559835-4-neilb@ownmail.net>
References: <[PATCH 0/3] VFS: replace dentry_create>
 <20260702111529.3559835-1-neilb@ownmail.net>
 <20260702111529.3559835-4-neilb@ownmail.net>
Subject: Re: [PATCH 3/3] VFS: add vfs_lookup_open()
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


> Op 02-07-2026 13:09 CEST schreef NeilBrown <neilb@ownmail.net>:
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
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c            | 59 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h |  3 +++
>  2 files changed, 62 insertions(+)
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

Other than what Christian has already mentioned, looks good.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
