Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE338F646;
	Thu, 14 May 2026 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799916; cv=none; b=nCvh6V4g+HNvDDyaJELQqnKXHHCCv1BbBiav0aKGjOzTMzKrjwsFiOrUskQjB/m94ciASlGMQH4M81/MxAppUAzglblgZf4d8d9+vP5deZt6rN8KymreMg5sPjhZSuI5EYTALfqoBP6hh0FjoPWR2D7lT49hOScI80cpsY+lsG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799916; c=relaxed/simple;
	bh=cSwkE33La5SxBMA1xFH6rKhCer/6MBN2HeDYf9tioNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBPyBAJW6+b4QNSmSCFriFTu2w0ksdUkXalj3uYoJji1XpbROAcDA6bTLrtCE3Gi7qN85wHuA9fPD184RN9XGZfgTzVQnbnslFIAbVRMPBxyeVFvz/Al+DzBqwpOm/bpT7kt5byrg4hhKrUVP4ARrgWnntomDucfVZOgnHm5CXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3inXGVn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3inXGVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75D6C2BCB3;
	Thu, 14 May 2026 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778799916;
	bh=cSwkE33La5SxBMA1xFH6rKhCer/6MBN2HeDYf9tioNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3inXGVnkSiE2V4438aL3c7TA8oADeeMqteSQ6DNF3h9JKRB1/K4cKERZpe9qbG7B
	 QpFDZ1Pks5JvcVBxmxPYxLufw9Dl2zgZkhDJxhiZ7Ia7Vcb6FTU2LSSoImG0pfroGj
	 FWYiOVS2n5wFQInG8EOlYrDSwhl+INnynCtzKCS+oCIKIgHBSv9nb86GhlPCH60oUx
	 nFfUeLw0MBW5QZ/KQzn4CeZUSxDrxRoAEikeen1sTOUoiRl2JwK9pRdGxS1obd9VER
	 aFh0ekfcm2fChR6P7K/aUl615HIhps90aUixoSN3qqPXPXjoqNqT5PSRrRiVFMcmKa
	 96ncNicevk+BQ==
Date: Thu, 14 May 2026 16:05:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 11/12] fuse_trace: constrain iomap mapping cache size
Message-ID: <20260514230515.GS9544@frogsfrogsfrogs>
References: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
 <177747207234.4103699.923541684990110487.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747207234.4103699.923541684990110487.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:38:17AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add tracepoints for the previous patch.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_trace.h       |   31 +++++++++++++++++++++++++++++--
>  fs/fuse/fuse_iomap_cache.c |    4 +++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index 09da9bce61b98c..aa2d5ca88c9d40 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h
> @@ -320,6 +320,7 @@ struct iomap_ioend;
>  struct iomap;
>  struct fuse_iext_cursor;
>  struct fuse_iomap_lookup;
> +struct fuse_iext_root;
>  
>  /* tracepoint boilerplate so we don't have to keep doing this */
>  #define FUSE_IOMAP_OPFLAGS_FIELD \
> @@ -1157,6 +1158,8 @@ TRACE_EVENT(fuse_iomap_config,
>  		__field(int64_t,		time_max)
>  		__field(int64_t,		maxbytes)
>  		__field(uint8_t,		uuid_len)
> +
> +		__field(uint32_t,		cache_maxbytes)
>  	),
>  
>  	TP_fast_assign(
> @@ -1170,14 +1173,15 @@ TRACE_EVENT(fuse_iomap_config,
>  		__entry->time_max	=	outarg->s_time_max;
>  		__entry->maxbytes	=	outarg->s_maxbytes;
>  		__entry->uuid_len	=	outarg->s_uuid_len;
> +		__entry->cache_maxbytes	=	outarg->cache_maxbytes;
>  	),
>  
> -	TP_printk("connection %u root_ino 0x%llx flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
> +	TP_printk("connection %u root_ino 0x%llx flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u cache_maxbytes %u",
>  		  __entry->connection, __entry->root_nodeid,
>  		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
>  		  __entry->blocksize, __entry->max_links, __entry->time_gran,
>  		  __entry->time_min, __entry->time_max, __entry->maxbytes,
> -		  __entry->uuid_len)
> +		  __entry->uuid_len, __entry->cache_maxbytes)
>  );
>  
>  TRACE_EVENT(fuse_iomap_dev_inval,
> @@ -1395,6 +1399,29 @@ DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_del_mapping_got);
>  DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_add_mapping_left);
>  DEFINE_IEXT_ALT_UPDATE_EVENT(fuse_iext_add_mapping_right);
>  
> +TRACE_EVENT(fuse_iomap_cache_cleanup,
> +	TP_PROTO(const struct inode *inode, unsigned int iodir,
> +		 struct fuse_iext_root *ir),
> +	TP_ARGS(inode, iodir, ir),
> +
> +	TP_STRUCT__entry(
> +		FUSE_IO_RANGE_FIELDS()

There's no file range here, so let's shrink the tracepoint data by only
recording the inode fields instead of just reporting zeroes.

--D

> +		FUSE_IOMAP_IODIR_FIELD
> +		__field(unsigned long long,	bytes)
> +	),
> +
> +	TP_fast_assign(
> +		FUSE_INODE_ASSIGN(inode, fi, fm);
> +		__entry->iodir		=	iodir;
> +		__entry->bytes		=	ir->ir_bytes;
> +	),
> +
> +	TP_printk(FUSE_IO_RANGE_FMT() FUSE_IOMAP_IODIR_FMT " bytes 0x%llx",
> +		  FUSE_IO_RANGE_PRINTK_ARGS(),
> +		  FUSE_IOMAP_IODIR_PRINTK_ARGS,
> +		  __entry->bytes)
> +);
> +
>  TRACE_EVENT(fuse_iomap_cache_remove,
>  	TP_PROTO(const struct inode *inode, unsigned int iodir,
>  		 loff_t offset, uint64_t length, unsigned long caller_ip),
> diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
> index a8e16302ce4405..66739ec59e9c8b 100644
> --- a/fs/fuse/fuse_iomap_cache.c
> +++ b/fs/fuse/fuse_iomap_cache.c
> @@ -1672,8 +1672,10 @@ fuse_iomap_cache_cleanup(
>  	struct fuse_mount	*fm = get_fuse_mount(inode);
>  	struct fuse_iext_root	*ir = fuse_iext_root_ptr(fi->cache, iodir);
>  
> -	if (ir && ir->ir_bytes > fm->fc->iomap_conn.cache_maxbytes)
> +	if (ir && ir->ir_bytes > fm->fc->iomap_conn.cache_maxbytes) {
> +		trace_fuse_iomap_cache_cleanup(inode, iodir, ir);
>  		fuse_iext_destroy(ir);
> +	}
>  }
>  
>  int
> 
> 
