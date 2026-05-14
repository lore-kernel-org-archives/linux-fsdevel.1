Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2A3C9EDC;
	Thu, 14 May 2026 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792067; cv=none; b=WMuxOYHkDJ+6Z/w4juXkZnr+94CkBZzgaOzPGt2vXdq+xcpDiMT3RgdA7av0trE7LT8QTWW2N4b+kJmdjbPw3z3vR+Vub8gf/dM57cfWz3e1T5fb+IPMSSpW7zUUmBy4C38sNiJht6N5DzWNxr4qrEfSK+N6I28Lqu50Wa+zp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792067; c=relaxed/simple;
	bh=NuxWnbhYPDYOIuCoOJ9rT/xqD4WdrpjK4/ZW8u9ExPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMrP7tyN+ZyJ2690Lmpfww8rfRwgyN5X4biHG/zRW6clpfH7A+cJghTMen1SHxOZr3uYA3K5UFuZ+aFqUYsD+m97omgpcYDitCXaibfe1IPYp3HvI0+QCzofrj7O3HRUx2btWyFNboV3xXj4N39MsW8l4hDQEPotoEgCcBW0kkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpJAzyzC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpJAzyzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47649C2BCB3;
	Thu, 14 May 2026 20:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792067;
	bh=NuxWnbhYPDYOIuCoOJ9rT/xqD4WdrpjK4/ZW8u9ExPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpJAzyzCSI0ZVr+Fq5LIy/SYDGZvrlj7VQyMaDRKXvLC5f9US5AavFJGBKusoUXEi
	 Vfgic4kLRXw2v0IzVbrCoPsSKU5757mraovd4ZvqZaHmzhtPHJrTvJjzkz2bW+NKep
	 s57Eq5Q8gOSqYuF3hvaBbHdc8T9VF3ZoE77pnYze7w0JugckV+eRytpzTXk4gsc6ne
	 vhkb5ofXgPLaDvH7xYFMZud5bRPBXN1lEqVFQQzalhC+bxSURwrB8suVc7LD1G4udO
	 H+FDSh3aezm1FMI4sVkL+6e+nKM8A8HKh5CwN2tT+CGSG9A59/Qp2tZnIpJh5WvN9t
	 DJt8TBZZLK1bg==
Date: Thu, 14 May 2026 13:54:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 22/33] fuse_trace: query filesystem geometry when using
 iomap
Message-ID: <20260514205426.GE9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205622.4101881.13167523785815327361.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205622.4101881.13167523785815327361.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:29:25AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add tracepoints for the previous patch.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_trace.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_iomap.c |    2 ++
>  2 files changed, 50 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index c832fb9012d983..96c4db84c7106a 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h
> @@ -58,6 +58,7 @@
>  	EM( FUSE_SYNCFS,		"FUSE_SYNCFS")		\
>  	EM( FUSE_TMPFILE,		"FUSE_TMPFILE")		\
>  	EM( FUSE_STATX,			"FUSE_STATX")		\
> +	EM( FUSE_IOMAP_CONFIG,		"FUSE_IOMAP_CONFIG")	\
>  	EM( FUSE_IOMAP_BEGIN,		"FUSE_IOMAP_BEGIN")	\
>  	EM( FUSE_IOMAP_END,		"FUSE_IOMAP_END")	\
>  	EM( FUSE_IOMAP_IOEND,		"FUSE_IOMAP_IOEND")	\
> @@ -345,6 +346,14 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
>  	{ IOMAP_IOEND_BOUNDARY,			"boundary" }, \
>  	{ IOMAP_IOEND_DIRECT,			"direct" }
>  
> +#define FUSE_IOMAP_CONFIG_STRINGS \
> +	{ FUSE_IOMAP_CONFIG_SID,		"sid" }, \
> +	{ FUSE_IOMAP_CONFIG_UUID,		"uuid" }, \
> +	{ FUSE_IOMAP_CONFIG_BLOCKSIZE,		"blocksize" }, \
> +	{ FUSE_IOMAP_CONFIG_MAX_LINKS,		"max_links" }, \
> +	{ FUSE_IOMAP_CONFIG_TIME,		"time" }, \
> +	{ FUSE_IOMAP_CONFIG_MAXBYTES,		"maxbytes" }
> +
>  DECLARE_EVENT_CLASS(fuse_iomap_check_class,
>  	TP_PROTO(const char *func, int line, const char *condition),
>  
> @@ -1005,6 +1014,45 @@ TRACE_EVENT(fuse_iomap_fallocate,
>  		  __entry->mode,
>  		  __entry->newsize)
>  );
> +
> +TRACE_EVENT(fuse_iomap_config,
> +	TP_PROTO(const struct fuse_mount *fm,
> +		 const struct fuse_iomap_config_out *outarg),
> +	TP_ARGS(fm, outarg),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,			connection)
> +
> +		__field(uint64_t,		flags)
> +		__field(uint32_t,		blocksize)
> +		__field(uint32_t,		max_links)
> +		__field(uint32_t,		time_gran)
> +
> +		__field(int64_t,		time_min)
> +		__field(int64_t,		time_max)
> +		__field(int64_t,		maxbytes)
> +		__field(uint8_t,		uuid_len)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->connection	=	fm->fc->dev;
> +		__entry->flags		=	outarg->flags;
> +		__entry->blocksize	=	outarg->s_blocksize;
> +		__entry->max_links	=	outarg->s_max_links;
> +		__entry->time_gran	=	outarg->s_time_gran;
> +		__entry->time_min	=	outarg->s_time_min;
> +		__entry->time_max	=	outarg->s_time_max;
> +		__entry->maxbytes	=	outarg->s_maxbytes;
> +		__entry->uuid_len	=	outarg->s_uuid_len;
> +	),
> +
> +	TP_printk("connection %u flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
> +		  __entry->connection,
> +		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),

Codex complains that this should be __print_flags_u64 to go with the u64
field.  Not sure why there isn't more macro magic to make this just work
(or at least avoid truncating everything above bit 30) but so it goes.

--D

> +		  __entry->blocksize, __entry->max_links, __entry->time_gran,
> +		  __entry->time_min, __entry->time_max, __entry->maxbytes,
> +		  __entry->uuid_len)
> +);
>  #endif /* CONFIG_FUSE_IOMAP */
>  
>  #endif /* _TRACE_FUSE_H */
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index cd74497ceb3f42..9a856617234f78 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -742,6 +742,8 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
>  		return error;
>  	}
>  
> +	trace_fuse_iomap_config(fm, outarg);
> +
>  	if (outarg->flags & ~FUSE_IOMAP_CONFIG_ALL)
>  		return -EINVAL;
>  
> 
> 
