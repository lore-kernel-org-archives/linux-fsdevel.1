Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FB3B9D94;
	Thu, 14 May 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794693; cv=none; b=dDByCzUYUCSzEgNOiI9/MllWPzoVxk6c/wG+xuaO2xO+AZnGylIJlYWmcGTBwBSr39eaSij9xb6ArhTmesykRcjuZUnq0AIlpP6SYBCZFFZ/v4lkmVgUj2/HNXnyZ7X1rUNz5cyfqcauSr4JZbgzmRprmBhRlhpemngRxhRY47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794693; c=relaxed/simple;
	bh=tAfzSWFhKO9T7fYt//JEwxqY2I/s21xT3eq3uCP3l9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOnApMy3hgeOKC79QMusCBIt4fIXNkM5A51jsrzc7B6GWoO1AFltpzT9s23HjUwWRsDdSj4sg7EeAaMMSiRZZXkuyBgth9jP2R5y1QAfBThAVvVz4i357nrzb+AcmWJ+Lt85cCzGjz84ksj74FF0rpO4j3YU/HdAeY8/VdChNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHLikAgX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHLikAgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E95C2BCC7;
	Thu, 14 May 2026 21:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778794693;
	bh=tAfzSWFhKO9T7fYt//JEwxqY2I/s21xT3eq3uCP3l9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHLikAgXa9K3CKXXM87ZkqMtSa2sGUs4FbSyIZ0Ve8yrdcd1vqPM4ePtaYIyhKmEd
	 eyVPFBmFa2kM4+UT0IF16t5Wau8002oaZ3FiM7k1/zQAiE9q0XAIOSL9+Vhvh8aQx4
	 V4SvdObUiCbt3jTGIiLgzrn3pR2h+pmgb2relUXSaqnZ0OnU7I/wp0Z8t6wR7QlhNj
	 hUOoDz/ADsAtE/61weiHQENYOBz8GDpg957WN0zKLYOyMXtqhiY9QYUtCdfYTMiAm6
	 bJwmNdqNdc7V7GXM1+uIMnlcnmBo4ePppkKqCIYMUXEd31jGIDrtG8q4DiRwSIHaJZ
	 9KTk3bNIGC+mw==
Date: Thu, 14 May 2026 14:38:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 1/3] fuse: make the root nodeid dynamic
Message-ID: <20260514213812.GG9544@frogsfrogsfrogs>
References: <177747206108.4103135.16385179491642925149.stgit@frogsfrogsfrogs>
 <177747206145.4103135.16263150644393951842.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747206145.4103135.16263150644393951842.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:32:33AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Change this from a hardcoded constant to a dynamic field so that fuse
> servers don't need to translate.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Codex noticedthat fuse_epoch_work didn't get ported properly, probably
because this patch was originally written before that.  Will fix for the
next version.

--D

> ---
>  fs/fuse/fuse_i.h  |    7 +++++--
>  fs/fuse/dir.c     |   10 ++++++----
>  fs/fuse/inode.c   |   11 +++++++----
>  fs/fuse/readdir.c |   10 +++++-----
>  4 files changed, 23 insertions(+), 15 deletions(-)
> 
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index c7c7f2e888bb8b..a9ca0e936524e7 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -701,6 +701,9 @@ struct fuse_conn {
>  
>  	struct rcu_head rcu;
>  
> +	/* node id of the root directory */
> +	u64 root_nodeid;
> +
>  	/** The user id for this mount */
>  	kuid_t user_id;
>  
> @@ -1116,9 +1119,9 @@ static inline u64 get_node_id(struct inode *inode)
>  	return get_fuse_inode(inode)->nodeid;
>  }
>  
> -static inline int invalid_nodeid(u64 nodeid)
> +static inline int invalid_nodeid(const struct fuse_conn *fc, u64 nodeid)
>  {
> -	return !nodeid || nodeid == FUSE_ROOT_ID;
> +	return !nodeid || nodeid == fc->root_nodeid;
>  }
>  
>  static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 2db88bc364bb50..3a76eea04c6425 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -584,7 +584,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
>  	err = -EIO;
>  	if (fuse_invalid_attr(&outarg->attr))
>  		goto out_put_forget;
> -	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
> +	if (outarg->nodeid == fm->fc->root_nodeid && outarg->generation != 0) {
>  		pr_warn_once("root generation should be zero\n");
>  		outarg->generation = 0;
>  	}
> @@ -634,7 +634,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
>  		goto out_err;
>  
>  	err = -EIO;
> -	if (inode && get_node_id(inode) == FUSE_ROOT_ID)
> +	if (inode && get_node_id(inode) == fc->root_nodeid)
>  		goto out_iput;
>  
>  	newent = d_splice_alias(inode, entry);
> @@ -885,7 +885,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
>  		goto out_free_ff;
>  
>  	err = -EIO;
> -	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
> +	if (!S_ISREG(outentry.attr.mode) ||
> +	    invalid_nodeid(fm->fc, outentry.nodeid) ||
>  	    fuse_invalid_attr(&outentry.attr))
>  		goto out_free_ff;
>  
> @@ -1032,7 +1033,8 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
>  		goto out_put_forget_req;
>  
>  	err = -EIO;
> -	if (invalid_nodeid(outarg.nodeid) || fuse_invalid_attr(&outarg.attr))
> +	if (invalid_nodeid(fm->fc, outarg.nodeid) ||
> +	    fuse_invalid_attr(&outarg.attr))
>  		goto out_put_forget_req;
>  
>  	if ((outarg.attr.mode ^ mode) & S_IFMT)
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 6d4ff08ad3069a..d883c9e3543f5c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1059,6 +1059,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>  	fc->max_pages_limit = fuse_max_pages_limit;
>  	fc->name_max = FUSE_NAME_LOW_MAX;
>  	fc->timeout.req_timeout = 0;
> +	fc->root_nodeid = FUSE_ROOT_ID;
>  
>  	if (IS_ENABLED(CONFIG_FUSE_BACKING))
>  		fuse_backing_files_init(fc);
> @@ -1116,12 +1117,14 @@ EXPORT_SYMBOL_GPL(fuse_conn_get);
>  static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned int mode)
>  {
>  	struct fuse_attr attr;
> +	struct fuse_conn *fc = get_fuse_conn_super(sb);
> +
>  	memset(&attr, 0, sizeof(attr));
>  
>  	attr.mode = mode;
> -	attr.ino = FUSE_ROOT_ID;
> +	attr.ino = fc->root_nodeid;
>  	attr.nlink = 1;
> -	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0);
> +	return fuse_iget(sb, fc->root_nodeid, 0, &attr, 0, 0, 0);
>  }
>  
>  struct fuse_inode_handle {
> @@ -1165,7 +1168,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
>  		goto out_iput;
>  
>  	entry = d_obtain_alias(inode);
> -	if (!IS_ERR(entry) && get_node_id(inode) != FUSE_ROOT_ID)
> +	if (!IS_ERR(entry) && get_node_id(inode) != fc->root_nodeid)
>  		fuse_invalidate_entry_cache(entry);
>  
>  	return entry;
> @@ -1258,7 +1261,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
>  	}
>  
>  	parent = d_obtain_alias(inode);
> -	if (!IS_ERR(parent) && get_node_id(inode) != FUSE_ROOT_ID)
> +	if (!IS_ERR(parent) && get_node_id(inode) != fc->root_nodeid)
>  		fuse_invalidate_entry_cache(parent);
>  
>  	return parent;
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index db5ae8ec10305a..5ba19ca9d8a949 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -189,12 +189,12 @@ static int fuse_direntplus_link(struct file *file,
>  			return 0;
>  	}
>  
> -	if (invalid_nodeid(o->nodeid))
> -		return -EIO;
> -	if (fuse_invalid_attr(&o->attr))
> -		return -EIO;
> -
>  	fc = get_fuse_conn(dir);
> +	if (invalid_nodeid(fc, o->nodeid))
> +		return -EIO;
> +	if (fuse_invalid_attr(&o->attr))
> +		return -EIO;
> +
>  	epoch = atomic_read(&fc->epoch);
>  
>  	name.hash = full_name_hash(parent, name.name, name.len);
> 
> 
