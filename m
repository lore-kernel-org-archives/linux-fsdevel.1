Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7F35E1DD;
	Fri, 15 May 2026 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875116; cv=none; b=AcqjqE+sWvGYg15Zc8qGlgL21SnWcKsIlpK88zmFRRlVGfQYSttXowmied138ywhSSQSMcFzTF9v6k6Q4iEASNgSeeBXisYSutb+nA+l7Bhly+8lUV5moq/vupm07hn4E7tccJdl5aO3Ymp+feVCwWSgQ1EUpGhoJzNGjP3UonM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875116; c=relaxed/simple;
	bh=gKdJYrUwgdph0X2fbZh9YjDGCjtjogu6yZDUqVx0jYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6Dk5U/ahPmPzN+fRWkTQoQczTMn/uCjrSIoqXLn6QspzXBpbgOyBMzhe1geWv+U6kK0UWjWjJbA5Rye9xBqfXrmqLtIBJwH5AiJC7yipFrBGcF2EZZwCxGA9ufEyzeSuVwsY4VZivh5huAZXhzajPUIWlkLJSszn1orZvIJTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrqXj5wW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrqXj5wW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C172BC2BCB0;
	Fri, 15 May 2026 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875115;
	bh=gKdJYrUwgdph0X2fbZh9YjDGCjtjogu6yZDUqVx0jYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrqXj5wWtVeX/YwnEvmXrZLVrQq6O/Vfu/GyhPoW2NZHrJj3BKAONe+Fh+FUJomgt
	 hrdpyGyXCk61WoQaadYxKLuNIhHTjETKJP4KVWRWo2NihQao0vUwteGnuydxnkhJAM
	 5ZG6A0sQMn2v4m+CznxFI3L18Xo//G8YxmDJFTzO03kNbaUulHi7pi4lJw5BJ88rE7
	 jR0K6Ggu0cL+onDMg2a3cFIlCbVlcu40IehX9McYaHWsxtZ2TseGrGFlYwLw39LOuf
	 IGO/858vkS1MlxGEyo7UVuU09Oluz3UK+gpvOY5KDiHNxwXOT4PSKYRvFjTGgc7gpy
	 pCubxy4q6hnKg==
Date: Fri, 15 May 2026 12:58:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Subject: Re: [PATCH 1/9] libfuse: enable iomap cache management for lowlevel
 fuse
Message-ID: <20260515195835.GZ9544@frogsfrogsfrogs>
References: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
 <177747213264.4106384.4204511496835236374.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747213264.4106384.4204511496835236374.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:49:14AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add the library methods so that fuse servers can manage an in-kernel
> iomap cache.  This enables better performance on small IOs and is
> required if the filesystem needs synchronization between pagecache
> writes and writeback.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse_common.h   |   12 +++++++
>  include/fuse_kernel.h   |   27 ++++++++++++++++
>  include/fuse_lowlevel.h |   52 ++++++++++++++++++++++++++++++++
>  lib/fuse_lowlevel.c     |   77 +++++++++++++++++++++++++++++++++++++++++++++++
>  lib/fuse_versionscript  |    2 +
>  5 files changed, 170 insertions(+)
> 
> 
> diff --git a/include/fuse_common.h b/include/fuse_common.h
> index 7b209b217b310e..76c65f7e79179e 100644
> --- a/include/fuse_common.h
> +++ b/include/fuse_common.h
> @@ -1163,6 +1163,10 @@ int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
>  
>  /* fuse-specific mapping type indicating that writes use the read mapping */
>  #define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(255)
> +/* fuse-specific mapping type saying the server has populated the cache */
> +#define FUSE_IOMAP_TYPE_RETRY_CACHE	(254)
> +/* do not upsert this mapping */
> +#define FUSE_IOMAP_TYPE_NOCACHE		(253)
>  
>  #define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
>  
> @@ -1292,6 +1296,14 @@ struct fuse_iomap_config {
>  	int64_t s_maxbytes;	/* max file size */
>  };
>  
> +/* invalidate to end of file */
> +#define FUSE_IOMAP_INVAL_TO_EOF		(~0ULL)
> +
> +struct fuse_file_range {
> +	uint64_t offset;	/* file offset to invalidate, bytes */
> +	uint64_t length;	/* length to invalidate, bytes */
> +};
> +
>  /* ----------------------------------------------------------- *
>   * Compatibility stuff					       *
>   * ----------------------------------------------------------- */
> diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> index 3ed174567dc172..115c8a228e765a 100644
> --- a/include/fuse_kernel.h
> +++ b/include/fuse_kernel.h
> @@ -251,6 +251,8 @@
>   *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
>   *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
>   *    attributes
> + *  - add FUSE_NOTIFY_IOMAP_{UPSERT,INVAL}_MAPPINGS so fuse servers can cache
> + *    file range mappings in the kernel for iomap
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -718,6 +720,8 @@ enum fuse_notify_code {
>  	FUSE_NOTIFY_INC_EPOCH = 8,
>  	FUSE_NOTIFY_PRUNE = 9,
>  	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
> +	FUSE_NOTIFY_IOMAP_UPSERT_MAPPINGS = 100,
> +	FUSE_NOTIFY_IOMAP_INVAL_MAPPINGS = 101,
>  };
>  
>  /* The read buffer is required to be at least 8k, but may be much larger */
> @@ -1468,4 +1472,27 @@ struct fuse_iomap_dev_inval_out {
>  	struct fuse_range range;
>  };
>  
> +struct fuse_iomap_inval_mappings_out {
> +	uint64_t nodeid;	/* Inode ID */
> +	uint64_t attr_ino;	/* matches fuse_attr:ino */
> +
> +	/*
> +	 * Range of read and mappings to invalidate.  Zero length means ignore
> +	 * the range; and FUSE_IOMAP_INVAL_TO_EOF can be used for length.
> +	 */
> +	struct fuse_range read;
> +	struct fuse_range write;
> +};
> +
> +struct fuse_iomap_upsert_mappings_out {
> +	uint64_t nodeid;	/* Inode ID */
> +	uint64_t attr_ino;	/* matches fuse_attr:ino */
> +
> +	/* read file data from here */
> +	struct fuse_iomap_io	read;
> +
> +	/* write file data to here, if applicable */
> +	struct fuse_iomap_io	write;
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> index 67c9bd4b2c6cee..3e9ceae9aa4aa4 100644
> --- a/include/fuse_lowlevel.h
> +++ b/include/fuse_lowlevel.h
> @@ -2261,6 +2261,58 @@ int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id);
>  int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
>  					  off_t offset, off_t length);
>  
> +/*
> + * Upsert some file mapping information into the kernel.  This is necessary
> + * for filesystems that require coordination of mapping state changes between
> + * buffered writes and writeback, and desirable for better performance
> + * elsewhere.
> + *
> + * Added in FUSE protocol version 7.99. If the kernel does not support
> + * this (or a newer) version, the function will return -ENOSYS and do
> + * nothing.
> + *
> + * @param se the session object
> + * @param nodeid the inode number
> + * @param attr_ino inode number as told by fuse_attr::ino
> + * @param read mapping information for file reads
> + * @param write mapping information for file writes
> + * @return zero for success, -errno for failure
> + */
> +int fuse_lowlevel_iomap_upsert_mappings(struct fuse_session *se,
> +					fuse_ino_t nodeid, uint64_t attr_ino,
> +					const struct fuse_file_iomap *read,
> +					const struct fuse_file_iomap *write);
> +
> +/*
> + * Update a mapping that will be sent to the kernel as part of an iomap_begin
> + * reply to signal that the mapping has been upserted into the cache.
> + */
> +static inline void fuse_file_iomap_retry_cache(struct fuse_file_iomap *map)
> +{
> +	map->type = FUSE_IOMAP_TYPE_RETRY_CACHE;
> +	map->dev = FUSE_IOMAP_DEV_NULL;
> +	map->addr = FUSE_IOMAP_NULL_ADDR;
> +}
> +
> +/**
> + * Invalidate some file mapping information in the kernel.
> + *
> + * Added in FUSE protocol version 7.99. If the kernel does not support
> + * this (or a newer) version, the function will return -ENOSYS and do
> + * nothing.
> + *
> + * @param se the session object
> + * @param nodeid the inode number
> + * @param attr_ino inode number as told by fuse_attr::ino
> + * @param read file read mapping range to invalidate
> + * @param write file write mapping range to invalidate
> + * @return zero for success, -errno for failure
> + */
> +int fuse_lowlevel_iomap_inval_mappings(struct fuse_session *se,
> +				       fuse_ino_t nodeid, uint64_t attr_ino,
> +				       const struct fuse_file_range *read,
> +				       const struct fuse_file_range *write);
> +
>  /* ----------------------------------------------------------- *
>   * Utility functions					       *
>   * ----------------------------------------------------------- */
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index d3e2d4c698a62b..6e8d2a7d74201b 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -3777,6 +3777,83 @@ int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
>  	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_DEV_INVAL, iov, 2);
>  }
>  
> +int fuse_lowlevel_iomap_upsert_mappings(struct fuse_session *se,
> +					fuse_ino_t nodeid, uint64_t attr_ino,
> +					const struct fuse_file_iomap *read,
> +					const struct fuse_file_iomap *write)
> +{
> +	struct fuse_iomap_upsert_mappings_out outarg = {
> +		.nodeid		= nodeid,
> +		.attr_ino	= attr_ino,
> +		.read		= {
> +			.type	= FUSE_IOMAP_TYPE_NOCACHE,
> +		},
> +		.write		= {
> +			.type	= FUSE_IOMAP_TYPE_NOCACHE,
> +		}
> +	};
> +	struct iovec iov[2];
> +
> +	if (!se)
> +		return -EINVAL;
> +
> +	if (se->conn.proto_minor < 99)

Codex complains that we need to check proto_major here (and in the other
notify function) ... but I think we should check for FUSE_CAP_IOMAP.

--D

> +		return -ENOSYS;
> +
> +	if (!read && !write)
> +		return 0;
> +
> +	if (read)
> +		fuse_iomap_to_kernel(&outarg.read, read);
> +
> +	if (write)
> +		fuse_iomap_to_kernel(&outarg.write, write);
> +
> +	iov[1].iov_base = &outarg;
> +	iov[1].iov_len = sizeof(outarg);
> +
> +	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_UPSERT_MAPPINGS, iov, 2);
> +}
> +
> +static inline void
> +fuse_iomap_range_to_kernel(struct fuse_range *range,
> +			   const struct fuse_file_range *firange)
> +{
> +	range->offset = firange->offset;
> +	range->length = firange->length;
> +}
> +
> +int fuse_lowlevel_iomap_inval_mappings(struct fuse_session *se,
> +				       fuse_ino_t nodeid, uint64_t attr_ino,
> +				       const struct fuse_file_range *read,
> +				       const struct fuse_file_range *write)
> +{
> +	struct fuse_iomap_inval_mappings_out outarg = {
> +		.nodeid		= nodeid,
> +		.attr_ino	= attr_ino,
> +	};
> +	struct iovec iov[2];
> +
> +	if (!se)
> +		return -EINVAL;
> +
> +	if (se->conn.proto_minor < 99)
> +		return -ENOSYS;
> +
> +	if (!read && !write)
> +		return 0;
> +
> +	if (read)
> +		fuse_iomap_range_to_kernel(&outarg.read, read);
> +	if (write)
> +		fuse_iomap_range_to_kernel(&outarg.write, write);
> +
> +	iov[1].iov_base = &outarg;
> +	iov[1].iov_len = sizeof(outarg);
> +
> +	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_INVAL_MAPPINGS, iov, 2);
> +}
> +
>  struct fuse_retrieve_req {
>  	struct fuse_notify_req nreq;
>  	void *cookie;
> diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> index 9c9013c964488c..41e0193708e57d 100644
> --- a/lib/fuse_versionscript
> +++ b/lib/fuse_versionscript
> @@ -272,6 +272,8 @@ FUSE_3.99 {
>  		fuse_lowlevel_add_iomap;
>  		fuse_service_configure_iomap;
>  		fuse_lowlevel_iomap_set_blocksize;
> +		fuse_lowlevel_iomap_upsert_mappings;
> +		fuse_lowlevel_iomap_inval_mappings;
>  } FUSE_3.19;
>  
>  # Local Variables:
> 
> 
