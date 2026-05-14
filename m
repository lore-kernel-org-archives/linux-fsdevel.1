Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2532572F;
	Thu, 14 May 2026 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797176; cv=none; b=JbylJT7boJJnb6BANe2USY4zNBWUyYu9ybwsbH6EwjfHmxwzy/k/gYjZaBykpZfIG7QLC93/RTgMV684849A1v6IPTa1RiRr6ZdGiLBtL9RPG06BCNd1LsMBKycm9AslfIQfrh8ISUsBJIi2njEQ08i3wUyo3mfHGHvpl4qZOEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797176; c=relaxed/simple;
	bh=x/F+n4/ft7ACj2BZGKK9pqFR2W/k2GLx2FMQx1Juzww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/XcC2fwHyYObqoi1gruF44hL8OZNXaykRrQVpxcigsQchNInnsb0PVAKimrn6G5HLfjALOrbXhc09uG3ETXPbfeekkNoFrlnrl2MnKeHuL8x+vnLl+BSqvtNDpFhqGVnZgSH82wCgIy2GMEdrtcgiaWKpLA9v13RDIffqwvOhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1ljLy3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1ljLy3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91D2C2BCB3;
	Thu, 14 May 2026 22:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778797175;
	bh=x/F+n4/ft7ACj2BZGKK9pqFR2W/k2GLx2FMQx1Juzww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1ljLy3Xtl0126BSjH8q4inMVaALIKuSjOLthz5BdNYt630qXP3iliTe7+XupNohi
	 kpZdCE6amvics7g+LiVUTYqzEqm+IISMg8/0+DxImOwBsVzGRHDLQhWmxJ2/KO+vGu
	 fnrgjQfW/5yHC6ljoVgl9R3vnHvNFHcaRWC6gzW4rrIXSzroZT9cDIeyp7yppVstNy
	 4KUFxhz+g9dm128ZcMAV1KfRpa99BYSXeMP930pM1Yk8v29crP3usPbZg8vBDs/r4/
	 uzQgutt3EHx8ZPxfnjhlvFGoQiQSKlFfiituTbPHV3TekiUuRsLHeEpwf1QV6Qd684
	 uVB1QvhrRc3vg==
Date: Thu, 14 May 2026 15:19:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 7/9] fuse_trace: let the kernel handle
 KILL_SUID/KILL_SGID for iomap filesystems
Message-ID: <20260514221935.GM9544@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206638.4103309.8411512653073787254.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747206638.4103309.8411512653073787254.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:34:54AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add tracepoints for the previous patch.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_trace.h |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/dir.c        |    5 ++++
>  2 files changed, 63 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index 7136ecf25e1f2b..a6374d64a62357 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h
> @@ -208,6 +208,64 @@ DEFINE_EVENT(fuse_fileattr_class, name,		\
>  DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_update_inode);
>  DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_init);
>  
> +TRACE_EVENT(fuse_setattr_fill,
> +	TP_PROTO(const struct inode *inode,
> +		 const struct fuse_setattr_in *inarg),
> +	TP_ARGS(inode, inarg),
> +
> +	TP_STRUCT__entry(
> +		FUSE_INODE_FIELDS
> +		__field(umode_t,		mode)
> +		__field(uint32_t,		valid)
> +		__field(umode_t,		new_mode)
> +		__field(uint64_t,		new_size)
> +	),
> +
> +	TP_fast_assign(
> +		FUSE_INODE_ASSIGN(inode, fi, fm);
> +		__entry->mode		=	inode->i_mode;
> +		__entry->valid		=	inarg->valid;
> +		__entry->new_mode	=	inarg->mode;
> +		__entry->new_size	=	inarg->size;
> +	),
> +
> +	TP_printk(FUSE_INODE_FMT " mode 0%o valid 0x%x new_mode 0%o new_size 0x%llx",
> +		  FUSE_INODE_PRINTK_ARGS,
> +		  __entry->mode,
> +		  __entry->valid,
> +		  __entry->new_mode,
> +		  __entry->new_size)
> +);
> +
> +TRACE_EVENT(fuse_setattr,
> +	TP_PROTO(const struct inode *inode,
> +		 const struct iattr *inarg),
> +	TP_ARGS(inode, inarg),
> +
> +	TP_STRUCT__entry(
> +		FUSE_INODE_FIELDS
> +		__field(umode_t,		mode)
> +		__field(uint32_t,		valid)
> +		__field(umode_t,		new_mode)
> +		__field(uint64_t,		new_size)
> +	),
> +
> +	TP_fast_assign(
> +		FUSE_INODE_ASSIGN(inode, fi, fm);
> +		__entry->mode		=	inode->i_mode;
> +		__entry->valid		=	inarg->ia_valid;
> +		__entry->new_mode	=	inarg->ia_mode;
> +		__entry->new_size	=	inarg->ia_size;

I also noticed while chasing the atime bug that the iattr fields are
unset if the ia_valid flags aren't set, and can contain stack garbage.
Will fix that.

--D

> +	),
> +
> +	TP_printk(FUSE_INODE_FMT " mode 0%o valid 0x%x new_mode 0%o new_size 0x%llx",
> +		  FUSE_INODE_PRINTK_ARGS,
> +		  __entry->mode,
> +		  __entry->valid,
> +		  __entry->new_mode,
> +		  __entry->new_size)
> +);
> +
>  #ifdef CONFIG_FUSE_BACKING
>  #define FUSE_BACKING_FLAG_STRINGS \
>  	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index e664a60200ee26..716f3e893dda66 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -8,6 +8,7 @@
>  
>  #include "fuse_i.h"
>  #include "fuse_iomap.h"
> +#include "fuse_trace.h"
>  
>  #include <linux/pagemap.h>
>  #include <linux/file.h>
> @@ -2205,6 +2206,8 @@ static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
>  			      struct fuse_setattr_in *inarg_p,
>  			      struct fuse_attr_out *outarg_p)
>  {
> +	trace_fuse_setattr_fill(inode, inarg_p);
> +
>  	args->opcode = FUSE_SETATTR;
>  	args->nodeid = get_node_id(inode);
>  	args->in_numargs = 1;
> @@ -2486,6 +2489,8 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
>  	if (!fuse_allow_current_process(get_fuse_conn(inode)))
>  		return -EACCES;
>  
> +	trace_fuse_setattr(inode, attr);
> +
>  	if (!is_iomap &&
>  	    (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
>  		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |
> 
> 
