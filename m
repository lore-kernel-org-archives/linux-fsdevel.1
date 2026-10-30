Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793341185;
	b=GfAGOJ1G76Ffcneaw9XvKJMF2QDfAkOTHdZxBHJBXRjDINKcwe8Wx4iGIuPMGSzyM7k4
	 6a0fLM5HtVx8W7lQSOOk7ro1zgCQWStg1e8n5FeDkCgJZSnxZeeZyBj/H/jNpLBukmY/M
	 MTtnOpRY95Ol8ug55cp6FL5KHlrI4qopdwhX03oJPzAyk0OPr9R9nlWw/P69vtZdGqK8u
	 7CNJPkflKIsqhc/Ug8so1FfFhYR7E5LU0Lew+nptYfDkWDkgvW9u/k2YA81MWhe3L2Zze
	 DdACzcrffxn570T7Rp/jXCrs5MYZqRgOHT+vJ3ppUEBtEPrGeoxT1pStXbegLLW3meA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341185;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8q5Oim3Cfb1HXvi7YFN/J1UPBN525964yhc/4HlA0go=;
	b=U7yVN1TLmjjGGMQNyj+K66osRELAy6+7cow8KtyY9wYYCPid0+rJ+Vg7Ye0l/DeQZ3qn
	 bXIbh642qxJ7VTU31lI9iwXNPlJREKEdToAj6O2CAtFJkxCnNTVlDtFtpm2HqreEZPXSQ
	 kvyAHjBYzXin+dxj8RdpZHmUx5+4qJB7rRtnvcW96l2JR+ukixDdX7tJuI1hUwUmxrUOS
	 ySvZYXSmMVW0l2xfQi7yHK3d4nUzrGhgr0hbFKyL9FvrhyepH/i2QRzmZA56ceIwpp9Jf
	 o/BGrS/gCpgWte5X+Adn81SBj33X+goLKb4Qf3cZ0/4cb8Lw4DjpWaNFj6AfddIwl4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=njHC6mU3;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=pfnyQsyU;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84572606A321;
	Fri, 30 Oct 2026 06:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84572606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=njHC6mU3;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=pfnyQsyU
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 9A50626F7664;
	Fri, 30 Oct 2026 15:19:42 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793341182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8q5Oim3Cfb1HXvi7YFN/J1UPBN525964yhc/4HlA0go=;
	b=njHC6mU3ydi+BifKeggDiNYstuj0eYtFLi8cYySiVp2dXFPdTWeRt8fNZMrh/E7kKAssqn
	IdpcrkGZNKmAQ8gZ60zz8+iU7glqgbJT5M074W+FLAfoTk3D0VH8VuHCGQEySfvFxdOVez
	xaMau31hGS27gr4n/y4x4ijf3I3NTVq46snnkG6ArL/oCX+ZPkHBsWgAQ669nIQ+BoLXzO
	x7DY4WMJ3Biu82Yq1ZFb2gQTjfyXkZ+k6dEX3yVSv2jtg04nJ/rszfTpZfiIUfsLGPo3qN
	sYiNe3Iyg44GsO3pWjg9QzKQ9euqWQVrrCWggUeTmEVl/2yzqVrD0QAajkspCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793341182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8q5Oim3Cfb1HXvi7YFN/J1UPBN525964yhc/4HlA0go=;
	b=pfnyQsyUvfrP7XO2F8GoHWiQmkcWOd7PDHP5fgU6zydq4V6lF7tc4GWjhj9YQsmJsfEiU9
	xlgInMo6tSNKSCAg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 24280E00144;
	Fri, 30 Oct 2026 15:19:42 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 0AD2322001FE; Fri, 30 Oct 2026 15:19:42 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fat: fix parent link count when replacing a sibling
 directory
In-Reply-To: <20261030060011.70237-1-dennylin0707@gmail.com>
References: <20261030060011.70237-1-dennylin0707@gmail.com>
Date: Fri, 30 Oct 2026 15:19:42 +0900
Message-ID: <87ecd7soap.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hungyu Lin <dennylin0707@gmail.com> writes:

> vfat_rename() and do_msdos_rename() adjust parent link counts only when
> updating the dotdot entry for a move between different parents. Replacing
> an existing empty directory in the same parent also removes a
> subdirectory, but leaves the parent's link count unchanged.
>
> For example, renaming one of two sibling directories over the other
> leaves the parent with four links instead of three. stat and ls report
> the stale count, and find -links 3 does not match the parent.
>
> Drop the parent's link count for this case after the source entry has
> been removed successfully. Leave cross-parent renames, regular files
> and the existing error paths unchanged.
>
> Share the parent link count check with rmdir through fat_dir_drop_nlink().
> Only decrement counts of at least three and report a filesystem error
> otherwise, rather than reducing a corrupted directory's count below two.
> Export the helper for the VFAT and MSDOS modules.
>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Looks good. Thank you!

> ---
> Changes in v3:
> - Move the parent link count check into fat_dir_drop_nlink() in the FAT
>   module and export it with EXPORT_SYMBOL_GPL(), as requested by
>   OGAWA Hirofumi.
> - Use the helper in all four places: the VFAT and MSDOS rmdir paths and
>   the two sibling-directory replacement paths.
> - Retain Hirofumi's Acked-by from v1.
>
> Changes in v2:
> - Check the parent link count before decrementing it and report low
>   counts with fat_fs_error(), matching rmdir(), as noted by Sashiko.
>
> v1: https://lore.kernel.org/r/20261028211626.26103-1-dennylin0707@gmail.com
>
>  fs/fat/dir.c         | 10 ++++++++++
>  fs/fat/fat.h         |  1 +
>  fs/fat/namei_msdos.c |  9 +++------
>  fs/fat/namei_vfat.c  |  9 +++------
>  4 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 35bdb62944a2..0cebcaf82426 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -963,6 +963,16 @@ int fat_dir_empty(struct inode *dir)
>  }
>  EXPORT_SYMBOL_GPL(fat_dir_empty);
>  
> +void fat_dir_drop_nlink(struct inode *dir)
> +{
> +	if (dir->i_nlink >= 3)
> +		drop_nlink(dir);
> +	else
> +		fat_fs_error(dir->i_sb, "parent dir link count too low (%u)",
> +			     dir->i_nlink);
> +}
> +EXPORT_SYMBOL_GPL(fat_dir_drop_nlink);
> +
>  /*
>   * fat_subdirs counts the number of sub-directories of dir. It can be run
>   * on directories being created.
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 76978a268410..a8a3ca4f465b 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -332,6 +332,7 @@ extern const struct file_operations fat_dir_operations;
>  extern int fat_search_long(struct inode *inode, const unsigned char *name,
>  			   int name_len, struct fat_slot_info *sinfo);
>  extern int fat_dir_empty(struct inode *dir);
> +void fat_dir_drop_nlink(struct inode *dir);
>  extern int fat_subdirs(struct inode *dir);
>  extern int fat_scan(struct inode *dir, const unsigned char *name,
>  		    struct fat_slot_info *sinfo);
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index c7500c2859e0..5a43d042eb01 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -333,12 +333,7 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
>  	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
>  	if (err)
>  		goto out;
> -	if (dir->i_nlink >= 3)
> -		drop_nlink(dir);
> -	else {
> -		fat_fs_error(sb, "parent dir link count too low (%u)",
> -			dir->i_nlink);
> -	}
> +	fat_dir_drop_nlink(dir);
>  
>  	clear_nlink(inode);
>  	fat_detach(inode);
> @@ -565,6 +560,8 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  		(void)sync_inode_metadata(old_dir, 1);
>  
>  	if (new_inode) {
> +		if (is_dir && old_dir == new_dir)
> +			fat_dir_drop_nlink(old_dir);
>  		drop_nlink(new_inode);
>  		if (is_dir)
>  			drop_nlink(new_inode);
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index ff7652bf0410..791f2d7b8509 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -809,12 +809,7 @@ static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
>  	err = fat_remove_entries(dir, &sinfo);	/* and releases bh */
>  	if (err)
>  		goto out;
> -	if (dir->i_nlink >= 3)
> -		drop_nlink(dir);
> -	else {
> -		fat_fs_error(sb, "parent dir link count too low (%u)",
> -			dir->i_nlink);
> -	}
> +	fat_dir_drop_nlink(dir);
>  
>  	clear_nlink(inode);
>  	fat_truncate_time(inode, NULL, FAT_UPDATE_ATIME | FAT_UPDATE_CMTIME);
> @@ -1011,6 +1006,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	vfat_update_dir_metadata(old_dir, &ts);
>  
>  	if (new_inode) {
> +		if (is_dir && old_dir == new_dir)
> +			fat_dir_drop_nlink(old_dir);
>  		drop_nlink(new_inode);
>  		if (is_dir)
>  			drop_nlink(new_inode);
>
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
