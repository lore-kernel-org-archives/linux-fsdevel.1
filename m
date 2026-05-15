Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53084381C4;
	Fri, 15 May 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871320; cv=none; b=uXpjC6tO0i2j5fzlI05PHsW5ZPm1WoTYRFc5bvPKp8ZiyvSNiixPXMOxx5ptCD+Wm4ENnjUoR/ss/kM9s7Kd4QxwJgZVTxFN6bSy/5dxWig/JF1kJr/Cp7CBivOddePb6pIoHNOhUGmChtFmk+ILEYKBr/mlW/BPF6NekXz7FDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871320; c=relaxed/simple;
	bh=1GkJ700uL9Ucg2x3wfOaLXOZp+rlfS1fiEOmhe4obHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0DwyjvbRSy5oWTyZpvW/09ckuaDQ29Gv+WwuurjoWdkjqF1wKJoWUIivz0nvCoBPX0dzCRanCuvkML2Ma+YLHRiqMVOy9XJ+o4kuTDIVZ6JwNzcfYukG+xoB6xdbSUol6rzZYvuV4u0OoFRyV7rMyyWQvYpbRw2vXLX5ji4d+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNZwQzox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNZwQzox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D53C2BCB0;
	Fri, 15 May 2026 18:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778871320;
	bh=1GkJ700uL9Ucg2x3wfOaLXOZp+rlfS1fiEOmhe4obHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNZwQzox4LF4VWMj9accy3yskdYWEvryuEXXow73H7rFKgwhs3JlD1QxsHWqXscVe
	 5GTsInS85oJXiJmNC8Jgn849i17FaUDNrH3cmGhosJD1TQYP5Zrmu7PeGUNb8m6Dmh
	 pPAnXqc+39iuM6n/hAgIEBcUAEXEVBRByzL3DYPBGg9dR9hT7+ZVImwyBuCyJVgHqf
	 gq2jZhPuUlYa6yyX9vqp8rllG7sEndAixiTN1EMfbB008siMO6ewf7e0cYFFDFFIWD
	 b+OG6DhGHfsokHUOCNdsUxPuiOkFH1Y6st+IcDUiaQTgWltB9YscrNLhTKZHCwCWeE
	 j8AoiKo5o6CeQ==
Date: Fri, 15 May 2026 11:55:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Subject: Re: [PATCH 16/25] libfuse: add lower level iomap_config
 implementation
Message-ID: <20260515185519.GW9544@frogsfrogsfrogs>
References: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
 <177747211854.4104686.11102678173277965542.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747211854.4104686.11102678173277965542.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:43:15AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add FUSE_IOMAP_CONFIG helpers to the low level fuse library.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse_common.h   |   37 ++++++++++++++++++++
>  include/fuse_kernel.h   |   31 +++++++++++++++++
>  include/fuse_lowlevel.h |   28 +++++++++++++++
>  lib/fuse_lowlevel.c     |   85 +++++++++++++++++++++++++++++++++++++++++++++++
>  lib/fuse_versionscript  |    1 +
>  5 files changed, 182 insertions(+)
> 
> 
> diff --git a/include/fuse_common.h b/include/fuse_common.h
> index 277a8209f09d50..2f0aff038c3ece 100644
> --- a/include/fuse_common.h
> +++ b/include/fuse_common.h
> @@ -1240,6 +1240,43 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
>  /* use iomap for this inode */
>  #define FUSE_IFLAG_IOMAP		(1U << 2)
>  
> +/* Which fields are set in fuse_iomap_config_out? */
> +#define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
> +#define FUSE_IOMAP_CONFIG_UUID		(1 << 1ULL)
> +#define FUSE_IOMAP_CONFIG_BLOCKSIZE	(1 << 2ULL)
> +#define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
> +#define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
> +#define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
> +
> +struct fuse_iomap_config_params {
> +	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
> +	int64_t maxbytes;	/* max supported file size */
> +	uint64_t padding[6];	/* zero */
> +};
> +
> +struct fuse_iomap_config {
> +	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
> +
> +	char s_id[32];		/* Informational name */
> +	char s_uuid[16];	/* UUID */
> +
> +	uint8_t s_uuid_len;	/* length of s_uuid */
> +
> +	uint8_t s_pad[3];	/* must be zeroes */
> +
> +	uint32_t s_blocksize;	/* fs block size */
> +	uint32_t s_max_links;	/* max hard links */
> +
> +	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
> +	uint32_t s_time_gran;
> +
> +	/* Time limits for c/m/atime in seconds */
> +	int64_t s_time_min;
> +	int64_t s_time_max;
> +
> +	int64_t s_maxbytes;	/* max file size */
> +};
> +
>  /* ----------------------------------------------------------- *
>   * Compatibility stuff					       *
>   * ----------------------------------------------------------- */
> diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> index 95c6c179a4398a..897d996a0ce60d 100644
> --- a/include/fuse_kernel.h
> +++ b/include/fuse_kernel.h
> @@ -246,6 +246,7 @@
>   *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
>   *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
>   *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
> + *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -677,6 +678,7 @@ enum fuse_opcode {
>  	FUSE_STATX		= 52,
>  	FUSE_COPY_FILE_RANGE_64	= 53,
>  
> +	FUSE_IOMAP_CONFIG	= 4092,
>  	FUSE_IOMAP_IOEND	= 4093,
>  	FUSE_IOMAP_BEGIN	= 4094,
>  	FUSE_IOMAP_END		= 4095,
> @@ -1390,4 +1392,33 @@ struct fuse_iomap_ioend_out {
>  	uint64_t newsize;	/* new ondisk size */
>  };
>  
> +struct fuse_iomap_config_in {
> +	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
> +	int64_t maxbytes;	/* max supported file size */
> +	uint64_t padding[6];	/* zero */
> +};
> +
> +struct fuse_iomap_config_out {
> +	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
> +
> +	char s_id[32];		/* Informational name */
> +	char s_uuid[16];	/* UUID */
> +
> +	uint8_t s_uuid_len;	/* length of s_uuid */
> +
> +	uint8_t s_pad[3];	/* must be zeroes */
> +
> +	uint32_t s_blocksize;	/* fs block size */
> +	uint32_t s_max_links;	/* max hard links */
> +
> +	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
> +	uint32_t s_time_gran;
> +
> +	/* Time limits for c/m/atime in seconds */
> +	int64_t s_time_min;
> +	int64_t s_time_max;
> +
> +	int64_t s_maxbytes;	/* max file size */
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> index df41afee0cfbe5..e97c3df16fb466 100644
> --- a/include/fuse_lowlevel.h
> +++ b/include/fuse_lowlevel.h
> @@ -1425,6 +1425,21 @@ struct fuse_lowlevel_ops {
>  			    uint64_t attr_ino, off_t pos, uint64_t written,
>  			    uint32_t ioendflags, int error, uint32_t dev,
>  			    uint64_t new_addr);
> +
> +	/**
> +	 * Configure the filesystem geometry for iomap mode
> +	 *
> +	 * Valid replies:
> +	 *   fuse_reply_iomap_config
> +	 *   fuse_reply_err
> +	 *
> +	 * @param req request handle
> +	 * @param p all available iomap configuration parameters
> +	 * @param psize size of parameters structure
> +	 */
> +	void (*iomap_config)(fuse_req_t req,
> +			     const struct fuse_iomap_config_params *p,
> +			     size_t psize);
>  };
>  
>  /**
> @@ -1928,6 +1943,19 @@ int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_file_iomap *read,
>   */
>  int fuse_reply_iomap_ioend(fuse_req_t req, off_t newsize);
>  
> +/**
> + * Reply with iomap configuration
> + *
> + * Possible requests:
> + *   iomap_config
> + *
> + * @param req request handle
> + * @param cfg iomap configuration
> + * @return zero for success, -errno for failure to send reply
> + */
> +int fuse_reply_iomap_config(fuse_req_t req,
> +			    const struct fuse_iomap_config *cfg);
> +
>  /* ----------------------------------------------------------- *
>   * Notification						       *
>   * ----------------------------------------------------------- */
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index 90136408b39204..4750b39ab99137 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -2834,6 +2834,89 @@ static void do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
>  	_do_iomap_ioend(req, nodeid, inarg, NULL);
>  }
>  
> +#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
> +#define offsetofend(TYPE, MEMBER) \
> +	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
> +
> +#define FUSE_IOMAP_CONFIG_V1 (FUSE_IOMAP_CONFIG_SID | \
> +			      FUSE_IOMAP_CONFIG_UUID | \
> +			      FUSE_IOMAP_CONFIG_BLOCKSIZE | \
> +			      FUSE_IOMAP_CONFIG_MAX_LINKS | \
> +			      FUSE_IOMAP_CONFIG_TIME | \
> +			      FUSE_IOMAP_CONFIG_MAXBYTES)
> +
> +#define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_V1)
> +
> +static ssize_t iomap_config_reply_size(const struct fuse_iomap_config *cfg)
> +{
> +	if (cfg->flags & ~FUSE_IOMAP_CONFIG_ALL)
> +		return -EINVAL;
> +
> +	return offsetofend(struct fuse_iomap_config_out, s_maxbytes);
> +}
> +
> +int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg)
> +{
> +	struct fuse_iomap_config_out arg = {
> +		.flags = cfg->flags,
> +	};
> +	const ssize_t reply_size = iomap_config_reply_size(cfg);
> +
> +	if (reply_size < 0)
> +		fuse_reply_err(req, -reply_size);

Codex noticed that this should be returning, not falling through.

		return fuse_reply_err(...);

--D

> +
> +	if (cfg->flags & FUSE_IOMAP_CONFIG_BLOCKSIZE)
> +		arg.s_blocksize = cfg->s_blocksize;
> +
> +	if (cfg->flags & FUSE_IOMAP_CONFIG_SID)
> +		memcpy(arg.s_id, cfg->s_id, sizeof(arg.s_id));
> +
> +	if (cfg->flags & FUSE_IOMAP_CONFIG_UUID) {
> +		arg.s_uuid_len = cfg->s_uuid_len;
> +		if (arg.s_uuid_len > sizeof(arg.s_uuid))
> +			arg.s_uuid_len = sizeof(arg.s_uuid);
> +		memcpy(arg.s_uuid, cfg->s_uuid, arg.s_uuid_len);
> +	}
> +
> +	if (cfg->flags & FUSE_IOMAP_CONFIG_MAX_LINKS)
> +		arg.s_max_links = cfg->s_max_links;
> +
> +	if (cfg->flags & FUSE_IOMAP_CONFIG_TIME) {
> +		arg.s_time_gran = cfg->s_time_gran;
> +		arg.s_time_min = cfg->s_time_min;
> +		arg.s_time_max = cfg->s_time_max;
> +	}
> +
> +	if (cfg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
> +		arg.s_maxbytes = cfg->s_maxbytes;
> +
> +	return send_reply_ok(req, &arg, reply_size);
> +}
> +
> +static void _do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
> +		      const void *op_in, const void *in_payload)
> +{
> +	const struct fuse_iomap_config_in *arg = op_in;
> +	struct fuse_iomap_config_params p = {
> +		.flags = arg->flags & FUSE_IOMAP_CONFIG_ALL,
> +		.maxbytes = arg->maxbytes,
> +	};
> +
> +	(void)nodeid;
> +	(void)in_payload;
> +
> +	if (req->se->op.iomap_config)
> +		req->se->op.iomap_config(req, &p, sizeof(p));
> +	else
> +		fuse_reply_err(req, ENOSYS);
> +}
> +
> +static void do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
> +			    const void *inarg)
> +{
> +	_do_iomap_config(req, nodeid, inarg, NULL);
> +}
> +
>  static bool want_flags_valid(uint64_t capable, uint64_t want)
>  {
>  	uint64_t unknown_flags = want & (~capable);
> @@ -3827,6 +3910,7 @@ static struct {
>  	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
>  	[FUSE_SYNCFS]	   = { do_syncfs,      "SYNCFS"      },
>  	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
> +	[FUSE_IOMAP_CONFIG] = { do_iomap_config, "IOMAP_CONFIG" },
>  	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
>  	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
>  	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
> @@ -3887,6 +3971,7 @@ static struct {
>  	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
>  	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
>  	[FUSE_STATX]		= { _do_statx,		"STATX" },
> +	[FUSE_IOMAP_CONFIG]	= { _do_iomap_config,	"IOMAP_CONFIG" },
>  	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
>  	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
>  	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
> diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> index 46465540a1f51b..f1e5cc63da18ee 100644
> --- a/lib/fuse_versionscript
> +++ b/lib/fuse_versionscript
> @@ -264,6 +264,7 @@ FUSE_3.99 {
>  		fuse_fs_can_enable_iomapx;
>  		fuse_lowlevel_discover_iomap;
>  		fuse_service_discover_iomap;
> +		fuse_reply_iomap_config;
>  } FUSE_3.19;
>  
>  # Local Variables:
> 
> 
