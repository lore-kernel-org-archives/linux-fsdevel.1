Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE53A785E;
	Wed, 13 May 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697031; cv=none; b=DKyPt6h7f9AK+h8mjaVfOWgocLnHvSLsvSiiVyOXzg/P20OpKXp2AThBLMyNiQ9pQ5hPh8OdNmz4OopDXRoZzT4UfjITToCn8eKfyCA/v93+B+E1SRO497DGAMT8DzcB2zmA1LVndxpLGFqPn0z4Nu4gQTXlfy2BsaB/oieVVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697031; c=relaxed/simple;
	bh=7kjJGeBPigZQzrAbkwafJ/mIPNUgjmDzDVmNEMfDIj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtiS8q20fkwVTPENxXkqTC5IbtRb8Ajmb/VrlWIDRtdVl5vh3Ur3/IYQjZNm5strGkkpLKUKzAM1uc1nYtb4OL4A3BKV2RkaOJosGhIsXY9eeOCEMXqu3APfMNQtrdOBZwRiIRySrZlZ+sgJoc+asbFhPAsuWk3q5yTIGAd7+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ00g9Ra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ00g9Ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E18C2BCC9;
	Wed, 13 May 2026 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778697031;
	bh=7kjJGeBPigZQzrAbkwafJ/mIPNUgjmDzDVmNEMfDIj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ00g9RaV+/7NiP4j3mP16DAa21xJjxSFJrJLio3b5Ausuq4I4LggZyxBwOk3PStK
	 IdpaG70e+1P5Bilx0vFUfar2uKUfkqxQeV9BOTSx2T9EzwdUEeNCns3xmn15uZnj7k
	 sTBUpi0ru96ul6JQNJKepbSDZg12NrhHd9UJFb+hi5Y9Rt3+y27rEx2/G1h4qOf5Jp
	 ig/gStyWC/oABPTkHEERlkX3LU6GpReoGRgUCHUVJjN1rDanLTkliHGvZqlqhZCeiK
	 s8SvCIvOv8NsG2r+QClRku64Ie7D3iM30WPgWSX57gxKkAMhnTzvlsgwUTY+meQW4Q
	 42Ff/KvOEywVA==
Date: Wed, 13 May 2026 11:30:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 12/33] fuse: implement basic iomap reporting such as
 FIEMAP and SEEK_{DATA,HOLE}
Message-ID: <20260513183030.GK9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205408.4101881.8022593459391808175.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205408.4101881.8022593459391808175.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:26:49AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Implement the basic file mapping reporting functions like FIEMAP, BMAP,
> and SEEK_DATA/HOLE.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_iomap.h |    8 ++++++
>  fs/fuse/dir.c        |    1 +
>  fs/fuse/file.c       |   13 ++++++++++
>  fs/fuse/fuse_iomap.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 89 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
> index 34f2c75416eb62..8ba30a496545f5 100644
> --- a/fs/fuse/fuse_iomap.h
> +++ b/fs/fuse/fuse_iomap.h
> @@ -33,6 +33,11 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
>  
>  	return test_bit(FUSE_I_IOMAP, &fi->state);
>  }
> +
> +int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> +		      u64 start, u64 length);
> +loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
> +sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
>  #else
>  # define fuse_iomap_enabled(...)		(false)
>  # define fuse_has_iomap(...)			(false)
> @@ -41,6 +46,9 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
>  # define fuse_iomap_init_inode(...)		((void)0)
>  # define fuse_iomap_evict_inode(...)		((void)0)
>  # define fuse_inode_has_iomap(...)		(false)
> +# define fuse_iomap_fiemap			NULL
> +# define fuse_iomap_lseek(...)			(-ENOSYS)
> +# define fuse_iomap_bmap(...)			(-ENOSYS)
>  #endif /* CONFIG_FUSE_IOMAP */
>  
>  #endif /* _FS_FUSE_IOMAP_H */
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 1bb0302f7ce8bb..2ed19e21d90702 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2505,6 +2505,7 @@ static const struct inode_operations fuse_common_inode_operations = {
>  	.set_acl	= fuse_set_acl,
>  	.fileattr_get	= fuse_fileattr_get,
>  	.fileattr_set	= fuse_fileattr_set,
> +	.fiemap		= fuse_iomap_fiemap,
>  };
>  
>  static const struct inode_operations fuse_symlink_inode_operations = {
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 2a807c49792d53..67cb0844181851 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2593,6 +2593,12 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
>  	struct fuse_bmap_out outarg;
>  	int err;
>  
> +	if (fuse_inode_has_iomap(inode)) {
> +		sector_t alt_sec = fuse_iomap_bmap(mapping, block);
> +		if (alt_sec > 0)
> +			return alt_sec;
> +	}

This should go after the s_bdev check since the bmap results are only
defined for filesystems with s_bdev set, which means that FIBMAP can
only be turned on for fuseblk filesystems.

Also I don't think we need to have this weird fallback to FUSE_BMAP.
iomap is 100% in charge of mapping data, so it can be 100% in charge of
FIBMAP (non)responses.

--D

> +
>  	if (!inode->i_sb->s_bdev || fm->fc->no_bmap)
>  		return 0;
>  
> @@ -2628,6 +2634,13 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
>  	struct fuse_lseek_out outarg;
>  	int err;
>  
> +	if (fuse_inode_has_iomap(inode)) {
> +		loff_t alt_pos = fuse_iomap_lseek(file, offset, whence);
> +
> +		if (alt_pos != -ENOSYS)
> +			return alt_pos;
> +	}
> +
>  	if (fm->fc->no_lseek)
>  		goto fallback;
>  
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index dccfc9a2c9847c..32ddf2fa6bdf78 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -4,6 +4,7 @@
>   * Author: Darrick J. Wong <djwong@kernel.org>
>   */
>  #include <linux/iomap.h>
> +#include <linux/fiemap.h>
>  #include "fuse_i.h"
>  #include "fuse_trace.h"
>  #include "fuse_iomap.h"
> @@ -539,7 +540,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
>  	return 0;
>  }
>  
> -const struct iomap_ops fuse_iomap_ops = {
> +static const struct iomap_ops fuse_iomap_ops = {
>  	.iomap_begin		= fuse_iomap_begin,
>  	.iomap_end		= fuse_iomap_end,
>  };
> @@ -669,3 +670,68 @@ void fuse_iomap_evict_inode(struct inode *inode)
>  
>  	fuse_inode_clear_iomap(inode);
>  }
> +
> +int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> +		      u64 start, u64 count)
> +{
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +	int error;
> +
> +	/*
> +	 * We are called directly from the vfs so we need to check per-inode
> +	 * support here explicitly.
> +	 */
> +	if (!fuse_inode_has_iomap(inode))
> +		return -EOPNOTSUPP;
> +
> +	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR)
> +		return -EOPNOTSUPP;
> +
> +	if (fuse_is_bad(inode))
> +		return -EIO;
> +
> +	if (!fuse_allow_current_process(fc))
> +		return -EACCES;
> +
> +	inode_lock_shared(inode);
> +	error = iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_ops);
> +	inode_unlock_shared(inode);
> +
> +	return error;
> +}
> +
> +sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block)
> +{
> +	ASSERT(fuse_inode_has_iomap(mapping->host));
> +
> +	return iomap_bmap(mapping, block, &fuse_iomap_ops);
> +}
> +
> +loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
> +{
> +	struct inode *inode = file->f_mapping->host;
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +
> +	ASSERT(fuse_inode_has_iomap(inode));
> +
> +	if (fuse_is_bad(inode))
> +		return -EIO;
> +
> +	if (!fuse_allow_current_process(fc))
> +		return -EACCES;
> +
> +	switch (whence) {
> +	case SEEK_HOLE:
> +		offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);
> +		break;
> +	case SEEK_DATA:
> +		offset = iomap_seek_data(inode, offset, &fuse_iomap_ops);
> +		break;
> +	default:
> +		return generic_file_llseek(file, offset, whence);
> +	}
> +
> +	if (offset < 0)
> +		return offset;
> +	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
> +}
> 
> 
