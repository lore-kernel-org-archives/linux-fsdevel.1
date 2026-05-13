Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091453A6F03;
	Wed, 13 May 2026 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695777; cv=none; b=ELs8Xh6BB/iclRoNQervunNwRUCz2/G9q57EicxQTp+iPC0/QQ+gdkEYxyCQGgRiQC7O9HgLuV4FhKFWUtj4JFodlrWyhD8MnL3+tetYtT9qK4qnveL/SX7bOtUMIDMDON21y7Dx8bjeayGatcw5DGZ+FGL/p/9xZB/znH+/xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695777; c=relaxed/simple;
	bh=OvvU5olmF2zBYT1YZ+Tjal98wpY7ec79uhQsQNRjXcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+xQ16vcInv01yhcuC8Ux1bRd9ooEAjVa/I/gVlKHAUyK33M6rxsD4C4MFReafKp1CwjS9QjbqxGAX/FPZTEgA3dmw9mFmK8fsqsriWdEeZMh/EPqWp1JvfpAQ83/eNIvw9hZADEpRIQ/QlSNZzSmG8yEam/bVRQiE5ijCHALIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du9Whl9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du9Whl9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B055C2BCB7;
	Wed, 13 May 2026 18:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778695776;
	bh=OvvU5olmF2zBYT1YZ+Tjal98wpY7ec79uhQsQNRjXcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Du9Whl9qtfTXD3WNe3rC3LVu0LKYepm5H+FvakvEFnv7yzugwmNcNH8E1AmU3DvpN
	 lSrWeKh4IBzdKBke4IIApz2K7nWpP13uTG94DNGwj/aH/XAFX878e5khri6ux96sm4
	 Jd122FupF2PhAYR2v7skBkjH2rYyggaiNpVZzFim/W16Os9AT3cmWc5eJDdmCBHTZm
	 EA8GsSGWLYTAInzEzvngMuqZyTLKDG007NmI0j/K/DEb3dNrXSs7qFq6+5O7DNCfT0
	 XJKoqUKwSA3yAPgAkmfDPghagHgUmAmJMJmb26vT0enFgLOaiGAuYmHlq+qSlgHv52
	 rBK7yeXZmdWvA==
Date: Wed, 13 May 2026 11:09:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 08/33] fuse: create a per-inode flag for setting
 exclusive mode.
Message-ID: <20260513180936.GI9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205321.4101881.130891634127766129.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205321.4101881.130891634127766129.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:25:46AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a per-inode flag to control whether or not this inode can use
> exclusive mode.  This enables more aggressive use of cached file
> attributes for things such as ACL inheritance and transformations.
> 
> The initial user will be iomap filesystems, where we hoist the IO path
> into the kernel and need ACLs to work for regular files and directories
> in the manner that most local filesystems expect.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h          |   17 +++++++++++++++++
>  include/uapi/linux/fuse.h |    4 ++++
>  fs/fuse/inode.c           |    5 +++++
>  3 files changed, 26 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 740589d5dc6c2d..07ad5abc48f70f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1116,6 +1116,23 @@ static inline bool fuse_is_bad(struct inode *inode)
>  	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
>  }
>  
> +static inline void fuse_inode_set_exclusive(const struct fuse_conn *fc,
> +					    struct inode *inode)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +
> +	/* This flag wasn't added until kernel API 7.99 */
> +	if (fc->minor >= 99)
> +		set_bit(FUSE_I_EXCLUSIVE, &fi->state);
> +}
> +
> +static inline void fuse_inode_clear_exclusive(struct inode *inode)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +
> +	clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
> +}
> +
>  static inline bool fuse_inode_is_exclusive(const struct inode *inode)
>  {
>  	const struct fuse_inode *fi = get_fuse_inode(inode);
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 5ae6b05de623d7..2d35dcfbf8aaf5 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -244,6 +244,7 @@
>   *  7.99
>   *  - XXX magic minor revision to make experimental code really obvious
>   *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
> + *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -584,9 +585,12 @@ struct fuse_file_lock {
>   *
>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
>   * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
> + * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
> + * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
>   */
>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
>  #define FUSE_ATTR_DAX		(1 << 1)
> +#define FUSE_ATTR_EXCLUSIVE	(1 << 2)
>  
>  /**
>   * Open flags
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index bf86edbfa22d6b..36814b5de46879 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -197,6 +197,8 @@ static void fuse_evict_inode(struct inode *inode)
>  		WARN_ON(!list_empty(&fi->write_files));
>  		WARN_ON(!list_empty(&fi->queued_writes));
>  	}
> +
> +	fuse_inode_clear_exclusive(inode);
>  }
>  
>  static int fuse_reconfigure(struct fs_context *fsc)
> @@ -436,6 +438,9 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
>  	inode_set_mtime(inode, attr->mtime, attr->mtimensec);
>  	inode_set_ctime(inode, attr->ctime, attr->ctimensec);
>  
> +	if (attr->flags & FUSE_ATTR_EXCLUSIVE)
> +		fuse_inode_set_exclusive(fc, inode);

Codex points out that the root inode gets created without the exclusive
flag being set, so a subsequent attempt by the fuse server to set it in
a LOOKUP/GETATTR call will fail.  fuse_change_attributes_common should
add the following snippet:


	/*
	 * The root inode is created with attr->flags == 0 at mount time prior
	 * to FUSE_INIT, so this is the only way that the fuse server can set
	 * the attribute on the root directory after the fact.
	 */
	if (get_node_id(inode) == FUSE_ROOT_ID &&
	    (attr->flags & FUSE_ATTR_EXCLUSIVE))
		fuse_inode_set_exclusive(fc, inode);

I also realized that the uapi header should say that the exclusive flag
must be set at in-kernel inode creation time and cannot change for the
life of that in-kernel inode.

--D

> +
>  	switch (inode->i_mode & S_IFMT) {
>  	case S_IFREG:
>  		fuse_init_file_inode(inode, attr);
> 
> 
