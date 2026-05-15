Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA643EEACB;
	Fri, 15 May 2026 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869989; cv=none; b=ndRBOBPNCMSLM9YJ50pLaFKeMHtj6ejwLeHZeQaBV6TRHFlJNJhtrOiQS28LG6MqhrsIPY7zFn0sR5zk9xoOg9KQuaG9EjP00D7EyFBY7hHzCo1v7tjFrRr/tcrhkfL3LOplL6GR62Mul1cc4frYmeoAZlTEmXOQG1WP8WMT2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869989; c=relaxed/simple;
	bh=Vq8Z2k6hvodlVnHeRDMv68ZqnClkkQns6FSC7vPwZ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1mQ33EZolFkdCD4v+MISJtT+X6z896CgNOyZVnjOIfiMKudXHIKFDRmKp3dk+v4CO3hPbGQY2Fv1zFOQFQ5bKTlspqqMKicPQmP52ErxucM/CkLDHMV7IX1v3Z7WaKLqOdcyJG6aoPT2ebNqN9G5ujYTetyzWnXMeM1kLM4KLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udHd7hlU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udHd7hlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D32C2BCB0;
	Fri, 15 May 2026 18:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778869989;
	bh=Vq8Z2k6hvodlVnHeRDMv68ZqnClkkQns6FSC7vPwZ1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udHd7hlUdkqMYUGnv6doEWda3SHWRT0X98ik7GUkSuoiSE3tAQAvXun4QmW/IgGgx
	 M8J1GAaRND9qOyy/URX+HGVFrt63JLBtvG3rB9NhrJ8hp3dywgJXNS3XHdxTwhUq2h
	 yV4gEtD8j2xhuw6ySZ45N1FO1NnmQztT6ziSi2g4TmvJNrCvRR3kCLqXM+vM60GXI6
	 HLob+LDUKllAhv9lIw2QW0OC2xQYwHtaWMH2CRqqRlFANglLU8MRR2F1VSkt51jZD7
	 mhfl4aHvRmusm30sXjhuZiQX/KwA2AAmzjSOdOdYSNYPOrOomeue9W9EQXXf3+6FOt
	 482Loz09IQ0TA==
Date: Fri, 15 May 2026 11:33:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Subject: Re: [PATCH 04/25] libfuse: add fuse commands for iomap_begin and end
Message-ID: <20260515183308.GU9544@frogsfrogsfrogs>
References: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
 <177747211638.4104686.9463757189882373298.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747211638.4104686.9463757189882373298.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:40:07AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Teach the low level API how to handle iomap begin and end commands that
> we get from the kernel.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse_common.h   |   71 +++++++++++++++++++++++++++++++++
>  include/fuse_kernel.h   |   40 ++++++++++++++++++
>  include/fuse_lowlevel.h |   59 +++++++++++++++++++++++++++
>  lib/fuse_lowlevel.c     |  102 +++++++++++++++++++++++++++++++++++++++++++++++
>  lib/fuse_versionscript  |    3 +
>  5 files changed, 275 insertions(+)
> 
> 
> diff --git a/include/fuse_common.h b/include/fuse_common.h
> index 23712fed8d64c2..d8b371b6641a6c 100644
> --- a/include/fuse_common.h
> +++ b/include/fuse_common.h
> @@ -1140,7 +1140,78 @@ bool fuse_get_feature_flag(const struct fuse_conn_info *conn, uint64_t flag);
>   */
>  int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
>  
> +/**
> + * iomap operations.
> + * These APIs are introduced in version 399 (FUSE_MAKE_VERSION(3, 99)).
> + */
>  
> +/* mapping types; see corresponding IOMAP_TYPE_ */
> +#define FUSE_IOMAP_TYPE_HOLE		(0)
> +#define FUSE_IOMAP_TYPE_DELALLOC	(1)
> +#define FUSE_IOMAP_TYPE_MAPPED		(2)
> +#define FUSE_IOMAP_TYPE_UNWRITTEN	(3)
> +#define FUSE_IOMAP_TYPE_INLINE		(4)
> +
> +/* fuse-specific mapping type indicating that writes use the read mapping */
> +#define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(255)
> +
> +#define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
> +
> +/* mapping flags passed back from iomap_begin; see corresponding IOMAP_F_ */
> +#define FUSE_IOMAP_F_NEW		(1U << 0)
> +#define FUSE_IOMAP_F_DIRTY		(1U << 1)
> +#define FUSE_IOMAP_F_SHARED		(1U << 2)
> +#define FUSE_IOMAP_F_MERGED		(1U << 3)
> +#define FUSE_IOMAP_F_BOUNDARY		(1U << 4)
> +#define FUSE_IOMAP_F_ANON_WRITE		(1U << 5)
> +#define FUSE_IOMAP_F_ATOMIC_BIO		(1U << 6)
> +
> +/* fuse-specific mapping flag asking for ->iomap_end call */
> +#define FUSE_IOMAP_F_WANT_IOMAP_END	(1U << 7)
> +
> +/* mapping flags passed to iomap_end */
> +#define FUSE_IOMAP_F_SIZE_CHANGED	(1U << 8)
> +#define FUSE_IOMAP_F_STALE		(1U << 9)
> +
> +/* operation flags from iomap; see corresponding IOMAP_* */
> +#define FUSE_IOMAP_OP_WRITE		(1U << 0)
> +#define FUSE_IOMAP_OP_ZERO		(1U << 1)
> +#define FUSE_IOMAP_OP_REPORT		(1U << 2)
> +#define FUSE_IOMAP_OP_FAULT		(1U << 3)
> +#define FUSE_IOMAP_OP_DIRECT		(1U << 4)
> +#define FUSE_IOMAP_OP_NOWAIT		(1U << 5)
> +#define FUSE_IOMAP_OP_OVERWRITE_ONLY	(1U << 6)
> +#define FUSE_IOMAP_OP_UNSHARE		(1U << 7)
> +#define FUSE_IOMAP_OP_DAX		(1U << 8)
> +#define FUSE_IOMAP_OP_ATOMIC		(1U << 9)
> +#define FUSE_IOMAP_OP_DONTCACHE		(1U << 10)
> +
> +/* pagecache writeback operation */
> +#define FUSE_IOMAP_OP_WRITEBACK		(1U << 31)
> +
> +#define FUSE_IOMAP_NULL_ADDR		(-1ULL)	/* addr is not valid */
> +
> +struct fuse_file_iomap {
> +	uint64_t offset;	/* file offset of mapping, bytes */
> +	uint64_t length;	/* length of mapping, bytes */
> +	uint64_t addr;		/* disk offset of mapping, bytes */
> +	uint16_t type;		/* FUSE_IOMAP_TYPE_* */
> +	uint16_t flags;		/* FUSE_IOMAP_F_* */
> +	uint32_t dev;		/* device cookie */
> +};
> +
> +static inline bool fuse_iomap_is_write(unsigned int opflags)
> +{
> +	return opflags & (FUSE_IOMAP_OP_WRITE | FUSE_IOMAP_OP_ZERO |
> +			  FUSE_IOMAP_OP_UNSHARE | FUSE_IOMAP_OP_WRITEBACK);
> +}
> +
> +static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
> +					const struct fuse_file_iomap *map)
> +{
> +	return map->type == FUSE_IOMAP_TYPE_HOLE &&
> +		!(opflags & FUSE_IOMAP_OP_ZERO);

Technically speaking this should be checking fuse_iomap_is_write() as
well, to make sure that this was any kind of write operation.

> +}
>  
>  /* ----------------------------------------------------------- *
>   * Compatibility stuff					       *
> diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> index 354a6da01c2ecc..b3750bb6275620 100644
> --- a/include/fuse_kernel.h
> +++ b/include/fuse_kernel.h
> @@ -670,6 +670,9 @@ enum fuse_opcode {
>  	FUSE_STATX		= 52,
>  	FUSE_COPY_FILE_RANGE_64	= 53,
>  
> +	FUSE_IOMAP_BEGIN	= 4094,
> +	FUSE_IOMAP_END		= 4095,
> +
>  	/* CUSE specific operations */
>  	CUSE_INIT		= 4096,
>  
> @@ -1313,4 +1316,41 @@ struct fuse_uring_cmd_req {
>  	uint8_t padding[6];
>  };
>  
> +struct fuse_iomap_io {
> +	uint64_t offset;	/* file offset of mapping, bytes */
> +	uint64_t length;	/* length of mapping, bytes */
> +	uint64_t addr;		/* disk offset of mapping, bytes */
> +	uint16_t type;		/* FUSE_IOMAP_TYPE_* */
> +	uint16_t flags;		/* FUSE_IOMAP_F_* */
> +	uint32_t dev;		/* device cookie */
> +};
> +
> +struct fuse_iomap_begin_in {
> +	uint32_t opflags;	/* FUSE_IOMAP_OP_* */
> +	uint32_t reserved;	/* zero */
> +	uint64_t attr_ino;	/* matches fuse_attr:ino */
> +	uint64_t pos;		/* file position, in bytes */
> +	uint64_t count;		/* operation length, in bytes */
> +};
> +
> +struct fuse_iomap_begin_out {
> +	/* read file data from here */
> +	struct fuse_iomap_io	read;
> +
> +	/* write file data to here, if applicable */
> +	struct fuse_iomap_io	write;
> +};
> +
> +struct fuse_iomap_end_in {
> +	uint32_t opflags;	/* FUSE_IOMAP_OP_* */
> +	uint32_t reserved;	/* zero */
> +	uint64_t attr_ino;	/* matches fuse_attr:ino */
> +	uint64_t pos;		/* file position, in bytes */
> +	uint64_t count;		/* operation length, in bytes */
> +	int64_t written;	/* bytes processed */
> +
> +	/* mapping that the kernel acted upon */
> +	struct fuse_iomap_io	map;
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> index ea71130946ba21..b9a072841ef078 100644
> --- a/include/fuse_lowlevel.h
> +++ b/include/fuse_lowlevel.h
> @@ -1357,6 +1357,43 @@ struct fuse_lowlevel_ops {
>  	 * @param ino the inode number
>  	 */
>  	void (*syncfs)(fuse_req_t req, fuse_ino_t ino);
> +
> +	/**
> +	 * Fetch file I/O mappings to begin an operation
> +	 *
> +	 * Valid replies:
> +	 *   fuse_reply_iomap_begin
> +	 *   fuse_reply_err
> +	 *
> +	 * @param req request handle
> +	 * @param nodeid the inode number
> +	 * @param attr_ino inode number as told by fuse_attr::ino
> +	 * @param pos position in file, in bytes
> +	 * @param count length of operation, in bytes
> +	 * @param opflags mask of FUSE_IOMAP_OP_ flags specifying operation
> +	 */
> +	void (*iomap_begin)(fuse_req_t req, fuse_ino_t nodeid,
> +			    uint64_t attr_ino, off_t pos, uint64_t count,
> +			    uint32_t opflags);
> +
> +	/**
> +	 * Complete an iomap operation
> +	 *
> +	 * Valid replies:
> +	 *   fuse_reply_err
> +	 *
> +	 * @param req request handle
> +	 * @param nodeid the inode number
> +	 * @param attr_ino inode number as told by fuse_attr::ino
> +	 * @param pos position in file, in bytes
> +	 * @param count length of operation, in bytes
> +	 * @param written number of bytes processed, or a negative errno
> +	 * @param opflags mask of FUSE_IOMAP_OP_ flags specifying operation
> +	 * @param iomap file I/O mapping that was acted upon
> +	 */
> +	void (*iomap_end)(fuse_req_t req, fuse_ino_t nodeid, uint64_t attr_ino,
> +			  off_t pos, uint64_t count, uint32_t opflags,
> +			  ssize_t written, const struct fuse_file_iomap *iomap);

Codex noticed that ssize_t can be smaller than int64_t on 32-bit
platforms, so we mustn't squash the kernel's @written parameter.  Linux
will never do more than 2G of IO at any time so this is a theoretical
concern; but it's theoretically possible so we shouldn't lose data.

--D

>  };
>  
>  /**
> @@ -1752,6 +1789,28 @@ int fuse_reply_lseek(fuse_req_t req, off_t off);
>  int fuse_reply_statx(fuse_req_t req, int flags, const struct statx *statx,
>  		     double attr_timeout);
>  
> +/**
> + * Set an iomap write mapping to be a pure overwrite of the read mapping.
> + * @param write mapping for file data writes
> + * @param read mapping for file data reads
> + */
> +void fuse_iomap_pure_overwrite(struct fuse_file_iomap *write,
> +			       const struct fuse_file_iomap *read);
> +
> +/**
> + * Reply with iomappings for an iomap_begin operation
> + *
> + * Possible requests:
> + *   iomap_begin
> + *
> + * @param req request handle
> + * @param read mapping for file data reads
> + * @param write mapping for file data writes
> + * @return zero for success, or negative errno on failure
> + */
> +int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_file_iomap *read,
> +			   const struct fuse_file_iomap *write);
> +
>  /* ----------------------------------------------------------- *
>   * Notification						       *
>   * ----------------------------------------------------------- */
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index b8700cd786a034..df13e2f8f84add 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -2619,6 +2619,104 @@ static void do_syncfs(fuse_req_t req, const fuse_ino_t nodeid,
>  	_do_syncfs(req, nodeid, inarg, NULL);
>  }
>  
> +void fuse_iomap_pure_overwrite(struct fuse_file_iomap *write,
> +			       const struct fuse_file_iomap *read)
> +{
> +	write->addr = FUSE_IOMAP_NULL_ADDR;
> +	write->offset = read->offset;
> +	write->length = read->length;
> +	write->type = FUSE_IOMAP_TYPE_PURE_OVERWRITE;
> +	write->flags = 0;
> +	write->dev = FUSE_IOMAP_DEV_NULL;
> +}
> +
> +static inline void fuse_iomap_to_kernel(struct fuse_iomap_io *fmap,
> +					const struct fuse_file_iomap *fimap)
> +{
> +	fmap->addr = fimap->addr;
> +	fmap->offset = fimap->offset;
> +	fmap->length = fimap->length;
> +	fmap->type = fimap->type;
> +	fmap->flags = fimap->flags;
> +	fmap->dev = fimap->dev;
> +}
> +
> +static inline void fuse_iomap_from_kernel(struct fuse_file_iomap *fimap,
> +					  const struct fuse_iomap_io *fmap)
> +{
> +	fimap->addr = fmap->addr;
> +	fimap->offset = fmap->offset;
> +	fimap->length = fmap->length;
> +	fimap->type = fmap->type;
> +	fimap->flags = fmap->flags;
> +	fimap->dev = fmap->dev;
> +}
> +
> +int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_file_iomap *read,
> +			   const struct fuse_file_iomap *write)
> +{
> +	struct fuse_iomap_begin_out arg = {
> +		.write = {
> +			.addr = FUSE_IOMAP_NULL_ADDR,
> +			.offset = read->offset,
> +			.length = read->length,
> +			.type = FUSE_IOMAP_TYPE_PURE_OVERWRITE,
> +			.flags = 0,
> +			.dev = FUSE_IOMAP_DEV_NULL,
> +		},
> +	};
> +
> +	fuse_iomap_to_kernel(&arg.read, read);
> +	if (write)
> +		fuse_iomap_to_kernel(&arg.write, write);
> +
> +	return send_reply_ok(req, &arg, sizeof(arg));
> +}
> +
> +static void _do_iomap_begin(fuse_req_t req, const fuse_ino_t nodeid,
> +			    const void *op_in, const void *in_payload)
> +{
> +	const struct fuse_iomap_begin_in *arg = op_in;
> +	(void)in_payload;
> +	(void)nodeid;
> +
> +	if (req->se->op.iomap_begin)
> +		req->se->op.iomap_begin(req, nodeid, arg->attr_ino, arg->pos,
> +					arg->count, arg->opflags);
> +	else
> +		fuse_reply_err(req, ENOSYS);
> +}
> +
> +static void do_iomap_begin(fuse_req_t req, const fuse_ino_t nodeid,
> +			   const void *inarg)
> +{
> +	_do_iomap_begin(req, nodeid, inarg, NULL);
> +}
> +
> +static void _do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
> +			    const void *op_in, const void *in_payload)
> +{
> +	const struct fuse_iomap_end_in *arg = op_in;
> +	(void)in_payload;
> +	(void)nodeid;
> +
> +	if (req->se->op.iomap_end) {
> +		struct fuse_file_iomap fimap;
> +
> +		fuse_iomap_from_kernel(&fimap, &arg->map);
> +		req->se->op.iomap_end(req, nodeid, arg->attr_ino, arg->pos,
> +				      arg->count, arg->opflags, arg->written,
> +				      &fimap);
> +	} else
> +		fuse_reply_err(req, ENOSYS);
> +}
> +
> +static void do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
> +			   const void *inarg)
> +{
> +	_do_iomap_end(req, nodeid, inarg, NULL);
> +}
> +
>  static bool want_flags_valid(uint64_t capable, uint64_t want)
>  {
>  	uint64_t unknown_flags = want & (~capable);
> @@ -3612,6 +3710,8 @@ static struct {
>  	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
>  	[FUSE_SYNCFS]	   = { do_syncfs,      "SYNCFS"      },
>  	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
> +	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
> +	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
>  	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
>  };
>  
> @@ -3669,6 +3769,8 @@ static struct {
>  	[FUSE_LSEEK]		= { _do_lseek,		"LSEEK" },
>  	[FUSE_SYNCFS]		= { _do_syncfs,		"SYNCFS" },
>  	[FUSE_STATX]		= { _do_statx,		"STATX" },
> +	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
> +	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
>  	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
>  };
>  
> diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> index af17e7ab2d7c88..260a7047c158e4 100644
> --- a/lib/fuse_versionscript
> +++ b/lib/fuse_versionscript
> @@ -248,6 +248,9 @@ FUSE_3.19 {
>  } FUSE_3.18;
>  
>  FUSE_3.99 {
> +	global:
> +		fuse_iomap_pure_overwrite;
> +		fuse_reply_iomap_begin;
>  } FUSE_3.19;
>  
>  # Local Variables:
> 
> 
