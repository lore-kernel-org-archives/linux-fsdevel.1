Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4239291864;
	Thu, 14 May 2026 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799652; cv=none; b=LfjsDQZVO2umrxsrsgjCY+akEqAGIDUG5pQLuU8zvLMvzNvWT367N31o5xso7LsJMNNfNxgCXRi9MYsRzWEqQbj/CoKAjohBj0z7ZVLlnWUQdV7qrAJyCuTxtcA51jse/f+/OG+YmjdgZNu2GzDzw0eDUg0w+jRNaf7UkQvRZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799652; c=relaxed/simple;
	bh=cUVWykWb61R4Vtt5OhcFToulYfcJCPxuhC+/m0p1hkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsA6Zc09j3evtoZP5J9RMIeMH74ioMuOjtw1eJjXtgp4l0OhKx22ui5D1dKsJFaiWfpbNpKztiCDkJfIjOuDGEvQXPPkmcR2+Ek7d03bFTxx4gIm8SeqQUlFreCIyZYxCiv0wD4WnOBAZBQo2N3wnWxd3WivpDndABTwIUT2+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU91FKcz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU91FKcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B364C2BCB3;
	Thu, 14 May 2026 23:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778799651;
	bh=cUVWykWb61R4Vtt5OhcFToulYfcJCPxuhC+/m0p1hkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dU91FKczr+lumNyFzhhTSozUzQpG6PbQMpMla+shBrlbH7eastXIrfrWzayFpRat6
	 XHFujje64NX3p9xrkUYglH9E+KRXm9zztGNiLxZMNmwbotqTO5oiKN+fOnedHb6JqU
	 0eenHBvzeT9q2s9r16tmdur5x70AKtDK75GgktVVR+dbuYlN5s0LkmKF1QwLNNax/F
	 0ta8an1M+n7Qk53mbgKPCrv/fPX1sk8CYfVcuSS3G9yBwSNJX47t2YEuC8FHLL3NE0
	 GOdVxn88AghgcXHH5OlxF8hykoAdPWeV7qZw8nZEwxxXddvwzRDl6tQ3TpAnHERgsP
	 54Edmp72QOZHA==
Date: Thu, 14 May 2026 16:00:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 10/12] fuse: constrain iomap mapping cache size
Message-ID: <20260514230051.GR9544@frogsfrogsfrogs>
References: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
 <177747207212.4103699.2461140884653539505.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747207212.4103699.2461140884653539505.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:38:02AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Provide a means to constrain the size of each iomap mapping cache.
> Most files (at least on XFS) don't have more than 1000 extents, so we'll
> set the absolute maximum to 10000 and let the fuse server set a lower
> limit if it so desires.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h           |    3 +++
>  fs/fuse/fuse_iomap_cache.h |    8 ++++++++
>  include/uapi/linux/fuse.h  |    7 ++++++-
>  fs/fuse/fuse_iomap.c       |    9 ++++++++-
>  fs/fuse/fuse_iomap_cache.c |   24 ++++++++++++++++++++++++
>  5 files changed, 49 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index c6a7ca4f1df76c..91f399a7a9a990 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -685,6 +685,9 @@ struct fuse_iomap_conn {
>  
>  	/* fuse server doesn't implement iomap_ioend */
>  	unsigned int no_ioend:1;
> +
> +	/* maximum mapping cache size */
> +	unsigned int cache_maxbytes;
>  };
>  #endif
>  
> diff --git a/fs/fuse/fuse_iomap_cache.h b/fs/fuse/fuse_iomap_cache.h
> index eba90d9519b8c3..cb312b0720d6b7 100644
> --- a/fs/fuse/fuse_iomap_cache.h
> +++ b/fs/fuse/fuse_iomap_cache.h
> @@ -108,6 +108,14 @@ static inline int fuse_iomap_cache_invalidate(struct inode *inode,
>  	return fuse_iomap_cache_invalidate_range(inode, offset,
>  						 FUSE_IOMAP_INVAL_TO_EOF);
>  }
> +
> +/* absolute maximum memory consumption per iomap mapping cache */
> +#define FUSE_IOMAP_CACHE_MAX_MAXBYTES		(SZ_2M)
> +
> +/* default maximum memory consumption per iomap mapping cache */
> +#define FUSE_IOMAP_CACHE_DEFAULT_MAXBYTES	(SZ_256K)
> +
> +void fuse_iomap_cache_set_maxbytes(struct fuse_conn *fc, unsigned int maxbytes);
>  #endif /* CONFIG_FUSE_IOMAP */
>  
>  #endif /* _FS_FUSE_IOMAP_CACHE_H */
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 8c5e67731b21b8..035e1a59ce50d3 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1512,7 +1512,9 @@ struct fuse_iomap_ioend_out {
>  struct fuse_iomap_config_in {
>  	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
>  	int64_t maxbytes;	/* maximum supported file size */
> -	uint64_t padding[6];	/* zero */
> +	uint32_t cache_maxbytes; /* mapping cache maxbytes */
> +	uint32_t zero;		/* zero */
> +	uint64_t padding[5];	/* zero */
>  };
>  
>  /* Which fields are set in fuse_iomap_config_out? */
> @@ -1522,6 +1524,7 @@ struct fuse_iomap_config_in {
>  #define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
>  #define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
>  #define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
> +#define FUSE_IOMAP_CONFIG_CACHE_MAXBYTES (1 << 6ULL)
>  
>  struct fuse_iomap_config_out {
>  	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
> @@ -1544,6 +1547,8 @@ struct fuse_iomap_config_out {
>  	int64_t s_time_max;
>  
>  	int64_t s_maxbytes;	/* max file size */
> +
> +	uint32_t cache_maxbytes; /* mapping cache maximum size */
>  };
>  
>  struct fuse_range {
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index 075fa62f856495..22b23a3fa2ae2c 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -1147,7 +1147,8 @@ struct fuse_iomap_config_args {
>  			       FUSE_IOMAP_CONFIG_BLOCKSIZE | \
>  			       FUSE_IOMAP_CONFIG_MAX_LINKS | \
>  			       FUSE_IOMAP_CONFIG_TIME | \
> -			       FUSE_IOMAP_CONFIG_MAXBYTES)
> +			       FUSE_IOMAP_CONFIG_MAXBYTES | \
> +			       FUSE_IOMAP_CONFIG_CACHE_MAXBYTES)
>  
>  static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
>  				     const struct fuse_iomap_config_out *outarg)
> @@ -1212,6 +1213,9 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
>  	if (outarg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
>  		sb->s_maxbytes = outarg->s_maxbytes;
>  
> +	if (outarg->flags & FUSE_IOMAP_CONFIG_CACHE_MAXBYTES)
> +		fuse_iomap_cache_set_maxbytes(fm->fc, outarg->cache_maxbytes);
> +
>  	return 0;
>  }
>  
> @@ -1273,6 +1277,9 @@ fuse_iomap_new_mount(struct fuse_mount *fm)
>  	ia->inarg.maxbytes = MAX_LFS_FILESIZE;
>  	ia->inarg.flags = FUSE_IOMAP_CONFIG_ALL;
>  
> +	fm->fc->iomap_conn.cache_maxbytes = FUSE_IOMAP_CACHE_DEFAULT_MAXBYTES;
> +	ia->inarg.cache_maxbytes = fm->fc->iomap_conn.cache_maxbytes;
> +
>  	ia->args.opcode = FUSE_IOMAP_CONFIG;
>  	ia->args.nodeid = 0;
>  	ia->args.in_numargs = 1;
> diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
> index 7d6944a6106f07..a8e16302ce4405 100644
> --- a/fs/fuse/fuse_iomap_cache.c
> +++ b/fs/fuse/fuse_iomap_cache.c
> @@ -1654,6 +1654,28 @@ void fuse_iomap_cache_free(struct inode *inode)
>  	kfree(ic);
>  }
>  
> +void fuse_iomap_cache_set_maxbytes(struct fuse_conn *fc, unsigned int maxbytes)
> +{
> +	if (!maxbytes)
> +		return;
> +
> +	fc->iomap_conn.cache_maxbytes = clamp(maxbytes, NODE_SIZE,
> +					      FUSE_IOMAP_CACHE_MAX_MAXBYTES);
> +}
> +
> +static void
> +fuse_iomap_cache_cleanup(
> +	struct inode		*inode,
> +	enum fuse_iomap_iodir	iodir)
> +{
> +	struct fuse_inode	*fi = get_fuse_inode(inode);
> +	struct fuse_mount	*fm = get_fuse_mount(inode);
> +	struct fuse_iext_root	*ir = fuse_iext_root_ptr(fi->cache, iodir);
> +
> +	if (ir && ir->ir_bytes > fm->fc->iomap_conn.cache_maxbytes)
> +		fuse_iext_destroy(ir);

Codex noticed that we don't bump the cache sequence counter, so a flush
due to excessive cache usage won't itself result in revalidations.  Will
fix this.

--D

> +}
> +
>  int
>  fuse_iomap_cache_upsert(
>  	struct inode			*inode,
> @@ -1680,6 +1702,8 @@ fuse_iomap_cache_upsert(
>  	if (err)
>  		return err;
>  
> +	fuse_iomap_cache_cleanup(inode, iodir);
> +
>  	return fuse_iomap_cache_add(inode, iodir, map);
>  }
>  
> 
> 
