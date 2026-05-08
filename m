Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02222F4A18
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261812; cv=none; b=VlSP7zesX58+0wR1EUBwHJzZpXJ0nC3x6m4AY6H5dYEueN3dUERGjUM8+fcms/ysj3mqWOgX3y/HoO+FEyZKKr0UmLGdVtQQ6gtDAx1y6cPwhBgn/6X42t0PhDXtMldjSeXBwvrKeI18T1syTAacwNPNucMH2T+r78e84BEq/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261812; c=relaxed/simple;
	bh=3zWJyKs3KACWzczwpPCufRtipMTJCgItkIObQl3U6yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWb6tAXlf1AjVrGqqOZkjex5A1QUtQV0mp9+E1ShCLJs6iPwXVOT7xMIixnMOz0eZbiKbpKxd8sd8pTfutCGzezGxFLGCDqheOvukdQDyOnWDeGjDfR951Zh42FxwdpoeiGZaivyo+AMXLCbqxhl4geEdg5096cpYk8HrkandRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (204-141-067-156.ip-addr.inexio.net [156.67.141.204])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id D969EE03DF;
	Fri,  8 May 2026 19:29:44 +0200 (CEST)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 8 May 2026 19:29:44 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: add fusex filesystem
Message-ID: <af4clh11ik-DYbiF@fedora.fritz.box>
References: <20260429102058.1362965-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429102058.1362965-1-mszeredi@redhat.com>

On Wed, Apr 29, 2026 at 12:20:57PM +0200, Miklos Szeredi wrote:
> This stands for "fuse extended/experimental".
> 
> The purpose is to provide a clean base for big features like the FUSE_IOMAP
> api.
> 
> It's also a good way to try new stuff like file handles and compound
> requests without the risk of breaking something in the large and complex
> fuse codebase.
> 
> Whether these features will be migrated back into the main fuse codebase,
> or fusex is going to end up as a major version update is still up in the
> air.
> 
> Major differences from regular fuse:
> 
>  - local filesystem mode only
>  - only synchronous FUSE_INIT is supported
>  - only no-open mode
>  - new requests:
>    + FUSE_LOOKUP_ROOT - return nodeid of root
>    + FUSE_LOOKUPX - FUSE_LOOKUP without the getattr
>    + FUSE_MKOBJX - merged FUSE_MKNOD, MKDIR, SYMLINK and TMPFILE
>    + FUSE_SETSTATX - extended version of FUSE_SETATTR
> 
> Missing features:
> 
>  - file handles / export ops
>  - compound requests
>  - xattr caching
>  - fileattr
>  - fiemap
>  - ioctl
>  - copy_file_range
>  - lazy dir open
> 
> Test server can be found at:
> 
>   https://github.com/szmi/fuse-utils
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
> 
> Patch is against
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next
> 
>  fs/fuse/Makefile          |    2 +-
>  fs/fuse/args.h            |    1 +
>  fs/fuse/dev.c             |   13 +-
>  fs/fuse/dir.c             |    4 +-
>  fs/fuse/fuse_i.h          |    8 +
>  fs/fuse/fusex.c           | 1751 +++++++++++++++++++++++++++++++++++++
>  fs/fuse/fusex.h           |    4 +
>  fs/fuse/inode.c           |   16 +-
>  include/uapi/linux/fuse.h |   36 +
>  9 files changed, 1826 insertions(+), 9 deletions(-)
>  create mode 100644 fs/fuse/fusex.c
>  create mode 100644 fs/fuse/fusex.h
> 
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 245e67852b03..d9963e411b62 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
>  
>  fuse-y := trace.o	# put trace.o first so we see ftrace errors sooner
>  fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o req_timeout.o req.o
> -fuse-y += poll.o notify.o
> +fuse-y += poll.o notify.o fusex.o
>  fuse-y += iomode.o
>  fuse-$(CONFIG_FUSE_DAX) += dax.o
>  fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
> diff --git a/fs/fuse/args.h b/fs/fuse/args.h
> index ecfe51a192af..1c1e0a25ea07 100644
> --- a/fs/fuse/args.h
> +++ b/fs/fuse/args.h
> @@ -35,6 +35,7 @@ struct fuse_args {
>  	bool out_pages:1;
>  	bool user_pages:1;
>  	bool out_argvar:1;
> +	bool out_var_alloc:1;
>  	bool page_zeroing:1;
>  	bool page_replace:1;
>  	bool may_block:1;
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 6fe0d8c263df..134572b1a9af 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1847,15 +1847,24 @@ int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
>  
>  	reqsize += fuse_len_args(args->out_numargs, args->out_args);
>  
> -	if (reqsize < nbytes || (reqsize > nbytes && !args->out_argvar))
> +	if (reqsize < nbytes)
>  		return -EINVAL;
> -	else if (reqsize > nbytes) {
> +
> +	if (args->out_argvar) {
>  		struct fuse_arg *lastarg = &args->out_args[args->out_numargs-1];
>  		unsigned diffsize = reqsize - nbytes;
>  
>  		if (diffsize > lastarg->size)
>  			return -EINVAL;
>  		lastarg->size -= diffsize;
> +
> +		if (args->out_var_alloc) {
> +			lastarg->value = kvmalloc(lastarg->size, GFP_KERNEL);
> +			if (!lastarg->value)
> +				return -ENOMEM;
> +		}
> +	} else if (reqsize > nbytes) {
> +		return -EINVAL;
>  	}
>  	return fuse_copy_args(cs, args->out_numargs, args->out_pages,
>  			      args->out_args, args->page_zeroing);
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index be41c14ef329..cbe0d4b65d49 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -542,7 +542,7 @@ int fuse_valid_type(int m)
>  		S_ISBLK(m) || S_ISFIFO(m) || S_ISSOCK(m);
>  }
>  
> -static bool fuse_valid_size(u64 size)
> +bool fuse_valid_size(u64 size)
>  {
>  	return size <= LLONG_MAX;
>  }
> @@ -2485,7 +2485,7 @@ static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
>  	return err;
>  }
>  
> -static const struct address_space_operations fuse_symlink_aops = {
> +const struct address_space_operations fuse_symlink_aops = {
>  	.read_folio	= fuse_symlink_read_folio,
>  };
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 3a7ac74a23ed..fe66281b7554 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -69,6 +69,9 @@ extern struct mutex fuse_mutex;
>  extern unsigned int max_user_bgreq;
>  extern unsigned int max_user_congthresh;
>  
> +extern struct kmem_cache *fuse_inode_cachep;
> +extern const struct address_space_operations fuse_symlink_aops;
> +
>  struct fuse_forget_link;
>  
>  /**
> @@ -911,6 +914,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>  int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
>  		     struct fuse_entry_out *outarg, struct inode **inode);
>  
> +void fuse_umount_begin(struct super_block *sb);
> +
>  /*
>   * Initialize READ or READDIR request
>   */
> @@ -1102,6 +1107,7 @@ void fuse_ctl_remove_conn(struct fuse_conn *fc);
>   * Is file type valid?
>   */
>  int fuse_valid_type(int m);
> +bool fuse_valid_size(u64 size);
>  
>  bool fuse_invalid_attr(struct fuse_attr *attr);
>  
> @@ -1204,6 +1210,8 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
>  int fuse_set_acl(struct mnt_idmap *, struct dentry *dentry,
>  		 struct posix_acl *acl, int type);
>  
> +void fuse_convert_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr);
> +
>  /* readdir.c */
>  int fuse_readdir(struct file *file, struct dir_context *ctx);
>  
> diff --git a/fs/fuse/fusex.c b/fs/fuse/fusex.c
> new file mode 100644
> index 000000000000..98e239e7e00e
> --- /dev/null
> +++ b/fs/fuse/fusex.c
> @@ -0,0 +1,1751 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "fusex.h"
> +#include "dev.h"
> +#include "fuse_i.h"
> +
> +#include <linux/fs_context.h>
> +#include <linux/miscdevice.h>
> +#include <linux/xxhash.h>
> +#include <linux/pagemap.h>
> +#include <linux/exportfs.h>
> +#include <linux/iversion.h>
> +#include <linux/posix_acl_xattr.h>
> +#include <linux/statfs.h>
> +#include <linux/falloc.h>
> +#include <linux/fs_parser.h>
> +

I think you're missing 
#include <uapi/linux/magic.h>
here for FUSE_SUPER_MAGIC

