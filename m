Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84E3A75A7;
	Thu, 14 May 2026 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794652; cv=none; b=XkDzoYjz7DjekfXnp9L9ucYvRnERuyWRQo8STG8F93fRxu5pam+aL1ka7SUaQlUUN2PDT9Jf9+j+3f1ndEIOiQoknHb7KjM4HLKOwgPjnQSRo5iDzq2HwiabqselZlPW0oPZcke2ELEulYWQ8k/nxFnKM2beiIvVLZH/TF6SDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794652; c=relaxed/simple;
	bh=iIYvuzIGMKG4VCvabVdYM8yabPX3hYaHodSth12lgd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E63bCuUoBc6/JFINif2pjGjNVFJsPUutFzNG2ec/bW9DAmkb+79PSw8m+eYkErSgb8hf/Xs0xyr5T25ZAHojeftGO5XyefAF9m+TeNH4rfYESQHlxySUE7bWr+MhOfsbgHfV47SnSS98T6xijBQKv8tm7XzQMrKM56sZZuUQ2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqkgv8EN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqkgv8EN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8114BC2BCB3;
	Thu, 14 May 2026 21:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778794652;
	bh=iIYvuzIGMKG4VCvabVdYM8yabPX3hYaHodSth12lgd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nqkgv8EN8iaknV2P/gRNGqsIsrsu4PaNCDrL2uuises07+sTpB9OW1U32uTHkTxe0
	 ner/sUZfQv50f6YoK7q+fkLFbtt33Vs10d55wacLoLw/N1qwTUQ846P228qlLdIlHf
	 c3LQtmsLkGyaBuPP90ffl1gavkCEC5rielEzHGB0hqwMG7sd0JUfmyBopuverNKkfq
	 RZ8sp4Ho2MyVX76YdrE4wmKl5f35bRiDVCBfJYIW3gStqAGTFwbG4pZ/WopVmIhFKf
	 /Z6LLFcgyPlNl9QszPhhYVhS2lP+CVpuDqbApwdRCbYJphUQ30Df/7uaHuAQJnfnX9
	 UFBVp0xZceGrg==
Date: Thu, 14 May 2026 14:37:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 3/3] fuse: allow setting of root nodeid
Message-ID: <20260514213731.GF9544@frogsfrogsfrogs>
References: <177747206108.4103135.16385179491642925149.stgit@frogsfrogsfrogs>
 <177747206187.4103135.11316004307240242988.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747206187.4103135.11316004307240242988.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:33:05AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Provide a new mount option so that fuse servers can actually set the
> root nodeid.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    2 ++
>  fs/fuse/inode.c  |   11 +++++++++++
>  2 files changed, 13 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index a9ca0e936524e7..95b37f4660cc1d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -642,6 +642,7 @@ static inline bool fuse_is_inode_dax_mode(enum fuse_dax_mode mode)
>  struct fuse_fs_context {
>  	struct fuse_dev *fud;
>  	unsigned int rootmode;
> +	u64 root_nodeid;
>  	kuid_t user_id;
>  	kgid_t group_id;
>  	bool is_bdev:1;
> @@ -654,6 +655,7 @@ struct fuse_fs_context {
>  	bool no_control:1;
>  	bool no_force_umount:1;
>  	bool legacy_opts_show:1;
> +	bool root_nodeid_present:1;
>  	enum fuse_dax_mode dax_mode;
>  	unsigned int max_read;
>  	unsigned int blksize;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index d883c9e3543f5c..d48a76e6d17995 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -816,6 +816,7 @@ enum {
>  	OPT_ALLOW_OTHER,
>  	OPT_MAX_READ,
>  	OPT_BLKSIZE,
> +	OPT_ROOT_NODEID,
>  	OPT_ERR
>  };
>  
> @@ -830,6 +831,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	fsparam_u32	("max_read",		OPT_MAX_READ),
>  	fsparam_u32	("blksize",		OPT_BLKSIZE),
>  	fsparam_string	("subtype",		OPT_SUBTYPE),
> +	fsparam_u64	("root_nodeid",		OPT_ROOT_NODEID),
>  	{}
>  };
>  
> @@ -950,6 +952,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>  		ctx->blksize = result.uint_32;
>  		break;
>  
> +	case OPT_ROOT_NODEID:
> +		ctx->root_nodeid = result.uint_64;

Codex says we need to reject zero nodeids here, because fuse doesn't
consider that to be a valid id.  Generally speaking, unix filesystems
don't allow a zero inumber so ... yeah.

--D

> +		ctx->root_nodeid_present = true;
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -987,6 +994,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
>  			seq_printf(m, ",max_read=%u", fc->max_read);
>  		if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
>  			seq_printf(m, ",blksize=%lu", sb->s_blocksize);
> +		if (fc->root_nodeid && fc->root_nodeid != FUSE_ROOT_ID)
> +			seq_printf(m, ",root_nodeid=%llu", fc->root_nodeid);
>  	}
>  #ifdef CONFIG_FUSE_DAX
>  	if (fc->dax_mode == FUSE_DAX_ALWAYS)
> @@ -2052,6 +2061,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	sb->s_flags |= SB_POSIXACL;
>  
>  	fc->default_permissions = ctx->default_permissions;
> +	if (ctx->root_nodeid_present)
> +		fc->root_nodeid = ctx->root_nodeid;
>  	fc->allow_other = ctx->allow_other;
>  	fc->user_id = ctx->user_id;
>  	fc->group_id = ctx->group_id;
> 
> 
