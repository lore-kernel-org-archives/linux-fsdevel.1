Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791C2BDC26;
	Thu, 14 May 2026 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784107; cv=none; b=tlPAvJ0ulzqE4dlzdPaeoD+dpt1OiwTZQj4KMeT1H62hn4HEsx6qjmpByiXWOMwBVbn6c1tUAgB1bwqonuEG1XGj4pREMHHNhuxJByuUPRVtx9xp2tyxwUf+C+OuqGOjba2zm1uMB1DakjaIFZ2p+mhq7lIMFE1hN4jxFBdyBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784107; c=relaxed/simple;
	bh=VVvwJ7fzoRk3WxdKVm9kGe+JnTu6EeZf8i/8YaKQavg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkyDK+9Ok5coNyD4PiF2FYnEWVY2Awj58FanzID+TfxqwGdpa+7Yf/ESjxCfCNjmquAsjO1Wgq4Ictumxj/S1qkd7LSm5yU3BKQ+2uxnhRzfsFEap3RYQTRTRWhv08HZkSkTtjMrTGV8s1qGtoUShrARZ79xrD9fyBa9t77F7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1H4dt1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1H4dt1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03897C2BCB3;
	Thu, 14 May 2026 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778784107;
	bh=VVvwJ7fzoRk3WxdKVm9kGe+JnTu6EeZf8i/8YaKQavg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1H4dt1ZWvGcyyoLL+GI5Y8JlXRjNvX3pTY2qRxqJ4n+nm2KkUhTj3lCoNHMhOtL5
	 Yai2F+FwyukvUbe6/psf4j8h15GzJXYVzjLgXMJRdikAo1cyncgpZVnkyfuQpwz2tU
	 DDD1bPLbOxAToD8Z/EXmHAXl93tR1eIAl/0H+hMWg79hTLKqvfAeWkNWZl2jPP+tCf
	 AVvipAV4Ky1L96f2BUfvB25VqCG9nLt5ZIf5fUyNAaXTT+Q1PQGo/vuDsdRosc1a/N
	 C4s8nKtcbX95HqBJje3Gm9pBJRvWEY9UFQjMJqGeutPyokFhxmSPncFRXndBRAEtvB
	 1jAEA3jdgNalw==
Date: Thu, 14 May 2026 11:41:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] fuse_trace: move the passthrough-specific code back
 to passthrough.c
Message-ID: <20260514184146.GC9544@frogsfrogsfrogs>
References: <177747204594.4101743.18108570914300152558.stgit@frogsfrogsfrogs>
 <177747204647.4101743.5488320024551450875.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747204647.4101743.5488320024551450875.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:23:41AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add tracepoints for the previous patch.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/fuse_trace.h |   35 +++++++++++++++++++++++++++++++++++
>  fs/fuse/backing.c    |    5 +++++
>  2 files changed, 40 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index bbe9ddd8c71696..286a0845dc0898 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h
> @@ -124,6 +124,41 @@ TRACE_EVENT(fuse_request_end,
>  		  __entry->unique, __entry->len, __entry->error)
>  );
>  
> +#ifdef CONFIG_FUSE_BACKING
> +TRACE_EVENT(fuse_backing_class,

s/TRACE_EVENT/DECLARE_EVENT_CLASS/ ; will fix in the next version.

--D

> +	TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
> +		 const struct fuse_backing *fb),
> +
> +	TP_ARGS(fc, idx, fb),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,			connection)
> +		__field(unsigned int,		idx)
> +		__field(unsigned long,		ino)
> +	),
> +
> +	TP_fast_assign(
> +		struct inode *inode = file_inode(fb->file);
> +
> +		__entry->connection	=	fc->dev;
> +		__entry->idx		=	idx;
> +		__entry->ino		=	inode->i_ino;
> +	),
> +
> +	TP_printk("connection %u idx %u ino 0x%lx",
> +		  __entry->connection,
> +		  __entry->idx,
> +		  __entry->ino)
> +);
> +#define DEFINE_FUSE_BACKING_EVENT(name)		\
> +DEFINE_EVENT(fuse_backing_class, name,		\
> +	TP_PROTO(const struct fuse_conn *fc, unsigned int idx, \
> +		 const struct fuse_backing *fb), \
> +	TP_ARGS(fc, idx, fb))
> +DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
> +DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
> +#endif /* CONFIG_FUSE_BACKING */
> +
>  #endif /* _TRACE_FUSE_H */
>  
>  #undef TRACE_INCLUDE_PATH
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index adb4d2ebb21379..d7e074c30f46cc 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -72,6 +72,7 @@ static int fuse_backing_id_free(int id, void *p, void *data)
>  
>  	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
>  
> +	trace_fuse_backing_close((struct fuse_conn *)data, id, fb);
>  	fuse_backing_free(fb);
>  	return 0;
>  }
> @@ -145,6 +146,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
>  		fb = NULL;
>  		goto out;
>  	}
> +
> +	trace_fuse_backing_open(fc, res, fb);
>  out:
>  	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
>  
> @@ -194,6 +197,8 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
>  	if (err)
>  		goto out_fb;
>  
> +	trace_fuse_backing_close(fc, backing_id, fb);
> +
>  	err = -ENOENT;
>  	test_fb = fuse_backing_id_remove(fc, backing_id);
>  	if (!test_fb)
> 
> 
