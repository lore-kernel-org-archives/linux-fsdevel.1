Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1854838B130;
	Wed, 13 May 2026 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702969; cv=none; b=Wpee34TEMHEmsANFOKfPiD+Lt926jesk+BG/xC3DR0OY8kCHosiURKagVB/otoIlbSgY92BMdj2i4fIFJjygBT2kExxVwn6VzF8yqIO9t871LYRAsR3Di8MynihMf5WY9Nt4OPew/DezXuPye+vbBC+sKmMfdJ9uqtyA7Jxh7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702969; c=relaxed/simple;
	bh=V3ObskUO8jfpjBFseHVz96MM3neHlFU5X/oY4Kd/hc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb5RJWsaSue4qyWhzvq1T3TmUr5at0BsYR6tk9RKrfgPEXLeXfanqBpoNdodq4M+Jo5sPOceoZg/ArvmdghZrIUlevHlVZX99xFG+grvOlT6BkMFqlEUvwdN6Nxg6yPETUFSCJd+jJ/R5dKwUqBM0Z2h14L2pWIaIbNMnr654SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAxx2R6U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAxx2R6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A683DC19425;
	Wed, 13 May 2026 20:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778702968;
	bh=V3ObskUO8jfpjBFseHVz96MM3neHlFU5X/oY4Kd/hc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAxx2R6UtDbQXRXS+guk3Zlt174oXte9YaJk7rNancdVX2eUhPn91mMcJDzUrCemh
	 epOm+Ik7OxC9+TrpGAQ63xab9MIVpKMlXSKZa+ZoaHyePKn7laqiuX+JNYwuPjinWH
	 PNsU5n1K5hcllhIMDwRwKduinjU+7KHERVsG+QHFaLjt1k21vAG13DX54VSGijL21x
	 8UcfjGB6E9dr3dxDzjgL09D+TpOphlCiPU/4MyxgDM412xumeoBStQ9upyIRMnpxtr
	 2K4A4LneJfwH+Tx1eMOgewoBzcWiAd/K1w7kjvi/RCSLj2Ye8dAdw3sgFvdhoxoLHf
	 aJgLtWnsnrH5A==
Date: Wed, 13 May 2026 13:09:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 27/33] fuse_trace: implement inline data file IO via iomap
Message-ID: <20260513200928.GQ9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205728.4101881.16330195918071123208.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205728.4101881.16330195918071123208.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:30:43AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add tracepoints for the previous patch.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_trace.h |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_iomap.c |    7 +++++++
>  2 files changed, 52 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index 0e4be645802055..d3352e75fa6bdf 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h
> @@ -230,6 +230,7 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
>  #if IS_ENABLED(CONFIG_FUSE_IOMAP)
>  struct iomap_writepage_ctx;
>  struct iomap_ioend;
> +struct iomap;
>  
>  /* tracepoint boilerplate so we don't have to keep doing this */
>  #define FUSE_IOMAP_OPFLAGS_FIELD \
> @@ -1079,6 +1080,50 @@ TRACE_EVENT(fuse_iomap_dev_inval,
>  		  __entry->offset,
>  		  __entry->length)
>  );
> +
> +DECLARE_EVENT_CLASS(fuse_iomap_inline_class,
> +	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count,
> +		 const struct iomap *map),
> +	TP_ARGS(inode, pos, count, map),
> +
> +	TP_STRUCT__entry(
> +		FUSE_IO_RANGE_FIELDS()
> +		FUSE_IOMAP_MAP_FIELDS(map)
> +		__field(bool,			has_buf)
> +		__field(uint64_t,		validity_cookie)
> +	),
> +
> +	TP_fast_assign(
> +		FUSE_INODE_ASSIGN(inode, fi, fm);
> +		__entry->offset		=	pos;
> +		__entry->length		=	count;
> +
> +		__entry->mapdev		=	FUSE_IOMAP_DEV_NULL;
> +		__entry->mapaddr	=	map->addr;
> +		__entry->mapoffset	=	map->offset;
> +		__entry->maplength	=	map->length;
> +		__entry->maptype	=	map->type;
> +		__entry->mapflags	=	map->flags;
> +
> +		__entry->has_buf	=	map->inline_data != NULL;
> +		__entry->validity_cookie=	map->validity_cookie;
> +	),
> +
> +	TP_printk(FUSE_IO_RANGE_FMT() FUSE_IOMAP_MAP_FMT() " has_buf? %d cookie 0x%llx",
> +		  FUSE_IO_RANGE_PRINTK_ARGS(),
> +		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),

Codex complains that we're using the flags/type decoding strings for
struct fuse_iomap_io on a struct iomap object so the decoding won't be
correct.  We already know the type and the flags aren't that interesting
for an inline mapping so let's just opencode the map offset/range.

--D

> +		  __entry->has_buf,
> +		  __entry->validity_cookie)
> +);
> +#define DEFINE_FUSE_IOMAP_INLINE_EVENT(name)	\
> +DEFINE_EVENT(fuse_iomap_inline_class, name,	\
> +	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count, \
> +		 const struct iomap *map), \
> +	TP_ARGS(inode, pos, count, map))
> +DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_read);
> +DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
> +DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
> +DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
>  #endif /* CONFIG_FUSE_IOMAP */
>  
>  #endif /* _TRACE_FUSE_H */
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index b9531ad5ab5180..8be8e49605bb85 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -435,6 +435,8 @@ static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
>  		return -EFSCORRUPTED;
>  	}
>  
> +	trace_fuse_iomap_inline_read(inode, pos, count, iomap);
> +
>  	args.opcode = FUSE_READ;
>  	args.nodeid = fi->nodeid;
>  	args.in_numargs = 1;
> @@ -482,6 +484,8 @@ static int fuse_iomap_inline_write(struct inode *inode, loff_t pos,
>  	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
>  		return -EFSCORRUPTED;
>  
> +	trace_fuse_iomap_inline_write(inode, pos, count, iomap);
> +
>  	args.opcode = FUSE_WRITE;
>  	args.nodeid = fi->nodeid;
>  	args.in_numargs = 2;
> @@ -545,6 +549,9 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
>  			return err;
>  	}
>  
> +	trace_fuse_iomap_set_inline_iomap(inode, pos, count, iomap);
> +	trace_fuse_iomap_set_inline_srcmap(inode, pos, count, srcmap);
> +
>  	return 0;
>  }
>  
> 
> 
