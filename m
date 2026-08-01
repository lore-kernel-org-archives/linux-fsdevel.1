Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805B38E11C
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785560054; cv=none; b=qO768qM5sChE7neqo+7sht4YPMoi/o8WJfjwyh95IUvP0QG6Pk2hTXiFj3VG48Kc8JH2H+WTjp2LcOisKfLPz3wmKAHewD3dYjzVcqXMGGyfETRMBKEbQ7noAFeoKk8DdeuUXJXkuuh8Qrzb3Vn58IhKGGFzpiBBF35w3lHTlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785560054; c=relaxed/simple;
	bh=9xwEliJvg9tsnBLh1kxGzssuJyh1pagWCYud3w6709M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP7dY3H8aH7s59EqOxbi4Dy0hB4xg+4K/rUZM2fG9NpDCbld1QhtmKAyUpg21owFjMa1WQfW9Dsv9sImUU0Mz31kRlhxwTGe/B46GfyZ94t/iHMXukNRptj1Q9hMUXgz2p8cla7mlQruvpYEKpdzdSI8M330+beYeZ78Bvp5iKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Thp9401/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Thp9401/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E011F00AC4;
	Sat,  1 Aug 2026 04:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785560053;
	bh=ppJWKk0cJU55Y/c9qFRI7xsAa51NkaGOWxlmXXXq4oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Thp9401/jMpVAx0YhTervJiX5eLi/Tk3jLgeEZEJ5EfaDen8yrW4UBsHtaOy2Ak+Y
	 c5yqiuKwAt7hCqvR3jFSV7lL0hLdCMUc62mbx+GA6KE4ZioRIidxQSfkP/YSG3GEOs
	 tbxhz5UfuULFqzQFwdAKebiOScuoT8Ne/oH44Ya4LErvuHFqw3pUmNINDFD2DpiW0N
	 nVciQTmEyYs6hHXt2Lwo3QPq9lfS1G5efUzz/z3klU41JSedlVPqJ0QS7JJggAHdvL
	 nh2YtG922b/tzGrlEaIlyo7gPI06vVRuBbADEWvRdk22VzfjZY+2JtTGZLvXUZp8Lf
	 BDsoU4lVkK+BQ==
Date: Sat, 1 Aug 2026 12:54:06 +0800
From: Gao Xiang <xiang@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org
Subject: Re: [PATCH v2] erofs: reuse superblock for file-backed mounts
Message-ID: <am177uT-j-AmiTL8@XiangdeMacBook-Pro.local>
Mail-Followup-To: Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org
References: <20260731160901.2276832-1-gscrivan@redhat.com>
 <am0x7PYFTYjrItGy@XiangdeMacBook-Pro.local>
 <87a4r6xy4s.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a4r6xy4s.fsf@redhat.com>

On Sat, Aug 01, 2026 at 06:28:35AM +0200, Giuseppe Scrivano wrote:
> Hi Gao,
> 
> thanks for the review!
> 
> Gao Xiang <xiang@kernel.org> writes:
> 
> > Hi Giuseppe,
> >
> > On Fri, Jul 31, 2026 at 06:08:21PM +0200, Giuseppe Scrivano wrote:
> >> When the same file-backed image is mounted multiple times (via path or
> >> fd) with the superblock_share mount option and matching domain_id, reuse
> >
> > First, I still need to get vfs maintainer opinions for "the sharing
> > superblock feature for file-backed mounts"
> >
> > I don't think it needs to be bothered with "domain_id" since
> > "domain_id" represents a trusted zone so a security concept for data
> > sourcing, and here I think you should just share the same filesystem
> > (with the same backing files) and the same option, so I don't think
> > "domain_id" is really useful.
> 
> I wanted to be conservative and let it behave as inode_share, but I
> agree it is not needed, I'll drop this.

It doesn't need to be aligned with "inode_share", but you remind me a
bit, let's exclude this feature with "inode_share" for now (since
composefs doesn't need it) and let's handle more coupled features later.

> 
> >> the existing superblock instead of creating a new one.  This allows
> >> multiple mounts of the same image to share in-kernel data structures
> >> more efficiently.
> >> 
> >> Superblock sharing requires both superblock_share and domain_id to be
> >
> > But I think a "superblock_share" yes/no mount option may be useful.
> >
> >> specified, following the same pattern as inode_share.  The backing file
> >> is identified by its inode and fsoffset.  If mount options conflict, a
> >> separate superblock is created transparently as a fallback.  Remount is
> >> not allowed on shared superblocks.
> >> 
> >> Tested by mounting a 177M Fedora EROFS image 20 times with full
> >> traversal:
> >> 
> >>   #!/bin/sh
> >>   IMG=${1:-/root/fedora.erofs}
> >>   N=20
> >>   DIR=$(mktemp -d)
> >>   trap "umount $DIR/m* 2>/dev/null; rm -rf $DIR" EXIT
> >> 
> >>   sync; echo 3 > /proc/sys/vm/drop_caches
> >>   INODES_BEFORE=$(grep erofs_inode /proc/slabinfo | awk '{print $2}')
> >>   MEM_BEFORE=$(grep ^Slab: /proc/meminfo | awk '{print $2}')
> >> 
> >>   for i in $(seq 1 $N); do
> >>       mkdir $DIR/m$i
> >>       mount -t erofs -o domain_id=test,superblock_share "$IMG" $DIR/m$i
> >>       find $DIR/m$i > /dev/null
> >>   done
> >> 
> >>   echo "Superblocks: $(grep $DIR /proc/self/mountinfo | \
> >>       awk '{print $3}' | sort -u | wc -l)"
> >>   echo "erofs_inode delta: +$(( $(grep erofs_inode /proc/slabinfo | \
> >>       awk '{print $2}') - INODES_BEFORE ))"
> >>   echo "Slab delta: +$(( $(grep ^Slab: /proc/meminfo | \
> >>       awk '{print $2}') - MEM_BEFORE )) kB"
> >> 
> >> unpatched kernel:
> >> 
> >>   Superblocks: 20
> >>   erofs_inode delta: +46368
> >>   Slab delta: +39952 kB
> >>   0.08user 0.82system 0:00.98elapsed
> >> 
> >> patched kernel:
> >> 
> >>   Superblocks: 1
> >>   erofs_inode delta: +2044
> >>   Slab delta: +1088 kB
> >>   0.07user 0.21system 0:00.31elapsed
> >> 
> >> The time difference shows that sharing the superblock also benefits
> >> the page cache and inode cache, as subsequent mounts of the same image
> >> avoid re-reading the backing file.  This is particularly useful for
> >> container hosts running multiple containers from the same base image.
> >> 
> >> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> >> ---
> >> v1: https://lore.kernel.org/linux-fsdevel/20260730124120.1501126-1-gscrivan@redhat.com/
> >> Needs: https://lore.kernel.org/linux-fsdevel/20260728160619.853924-1-gscrivan@redhat.com/
> >> 
> >>  Documentation/filesystems/erofs.rst | 16 ++++++-
> >>  fs/erofs/internal.h                 |  1 +
> >>  fs/erofs/super.c                    | 72 +++++++++++++++++++++++++++--
> >>  3 files changed, 83 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> >> index 774e8b236d09..517c526163e2 100644
> >> --- a/Documentation/filesystems/erofs.rst
> >> +++ b/Documentation/filesystems/erofs.rst
> >> @@ -131,12 +131,17 @@ device=%s              Specify a path to an extra device to be used together.
> >>  directio               (For file-backed mounts) Use direct I/O to access backing
> >>                         files, and asynchronous I/O will be enabled if supported.
> >>  domain_id=%s           Specify a trusted domain ID. Filesystems sharing the same
> >> -                       domain ID can share page cache across mounts when inode
> >> -                       page sharing is enabled. (not shown in mountinfo output)
> >> +                       domain ID can share page cache across mounts when
> >> +                       inode_share is enabled, and share superblocks when
> >> +                       superblock_share is enabled. (not shown in mountinfo
> >> +                       output)
> >>  fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
> >>  inode_share            Enable inode page sharing for this filesystem.  Inodes with
> >>                         identical content within the same domain ID can share the
> >>                         page cache.
> >> +superblock_share       Share the superblock when the same backing file is mounted
> >> +                       more than once with the same domain_id and compatible
> >> +                       options.  Remount is not allowed on shared superblocks.
> >
> > As I commented above.
> >
> >>  ===================    =========================================================
> >>  
> >>  File-backed mounts
> >> @@ -154,6 +159,13 @@ Only regular files are accepted as backing files; to mount an image that
> >>  resides on a block device, use the traditional block device mount path
> >>  instead.
> >>  
> >> +When domain_id and superblock_share are both specified and the same
> >> +backing file (identified by inode and fsoffset) is mounted more than
> >> +once with the same domain_id and compatible mount options, the kernel
> >> +reuses the existing superblock instead of creating a new one.
> >> +
> >> +Remount is not allowed on shared superblocks.
> >> +
> >>  Sysfs Entries
> >>  =============
> >>  
> >> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> >> index 580f8d9f14e7..8d65cac35702 100644
> >> --- a/fs/erofs/internal.h
> >> +++ b/fs/erofs/internal.h
> >> @@ -156,6 +156,7 @@ struct erofs_sb_info {
> >>  #define EROFS_MOUNT_DAX_NEVER		0x00000080
> >>  #define EROFS_MOUNT_DIRECT_IO		0x00000100
> >>  #define EROFS_MOUNT_INODE_SHARE		0x00000200
> >> +#define EROFS_MOUNT_SUPERBLOCK_SHARE	0x00000400
> >>  
> >>  #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
> >>  #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
> >> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> >> index 558041011398..23fee43de1d1 100644
> >> --- a/fs/erofs/super.c
> >> +++ b/fs/erofs/super.c
> >> @@ -386,7 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
> >>  enum {
> >>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
> >>  	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
> >> -	Opt_source,
> >> +	Opt_source, Opt_superblock_share,
> >>  };
> >>  
> >>  static const struct constant_table erofs_param_cache_strategy[] = {
> >> @@ -415,6 +415,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
> >>  	fsparam_u64("fsoffset",			Opt_fsoffset),
> >>  	fsparam_flag("inode_share",		Opt_inode_share),
> >>  	fsparam_file_or_string("source",	Opt_source),
> >> +	fsparam_flag("superblock_share",	Opt_superblock_share),
> >>  	{}
> >>  };
> >>  
> >> @@ -536,7 +537,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
> >>  		++sbi->devs->extra_devices;
> >>  		break;
> >>  	case Opt_domain_id:
> >> -		if (!IS_ENABLED(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)) {
> >> +		if (!IS_ENABLED(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) &&
> >> +		    !IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE)) {
> >>  			errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
> >>  		} else {
> >>  			kfree_sensitive(sbi->domain_id);
> >> @@ -560,6 +562,12 @@ static int erofs_fc_parse_param(struct fs_context *fc,
> >>  		else
> >>  			set_opt(&sbi->opt, INODE_SHARE);
> >>  		break;
> >> +	case Opt_superblock_share:
> >> +		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE))
> >> +			errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
> >> +		else
> >> +			set_opt(&sbi->opt, SUPERBLOCK_SHARE);
> >> +		break;
> >>  	case Opt_source:
> >>  		return erofs_fc_parse_source(fc, param);
> >>  	}
> >> @@ -659,6 +667,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
> >>  		errorfc(fc, "domain_id is needed when inode_ishare is on");
> >>  		return -EINVAL;
> >>  	}
> >> +	if (!sbi->domain_id && test_opt(&sbi->opt, SUPERBLOCK_SHARE)) {
> >> +		errorfc(fc, "domain_id is needed when superblock_share is on");
> >> +		return -EINVAL;
> >> +	}
> >>  	if (test_opt(&sbi->opt, DAX_ALWAYS) && test_opt(&sbi->opt, INODE_SHARE)) {
> >>  		errorfc(fc, "FSDAX is not allowed when inode_ishare is on");
> >>  		return -EINVAL;
> >> @@ -788,6 +800,55 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
> >>  	return 0;
> >>  }
> >>  
> >> +static int erofs_fc_test_file_super(struct super_block *sb,
> >> +				    struct fs_context *fc)
> >> +{
> >> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> >> +	struct erofs_sb_info *new_sbi = fc->s_fs_info;
> >> +
> >> +	if (sb->s_iflags & SB_I_RETIRED)
> >> +		return 0;
> >> +	if (!sbi->dif0.file || !new_sbi->dif0.file)
> >> +		return 0;
> >> +	if (!test_opt(&new_sbi->opt, SUPERBLOCK_SHARE))
> >> +		return 0;
> >
> > I think it'd be better to just memcmp(sbi->opt, new_sbi->opt, ..)
> > directly.
> >
> >> +	if (!sbi->domain_id || !new_sbi->domain_id ||
> >> +	    strcmp(sbi->domain_id, new_sbi->domain_id))
> >> +		return 0;
> >
> > And also you need to ensure the devs has the same backing files too.
> 
> are you fine if we just skip mounts with extra_devs?  It can be
> relaxed in future if needed.  Otherwise we would need to open them
> before we do these checks to be sure we are referring to the same
> files.

Sorry I totally missed that, that is fine, but if there is a dedicated
"superblock_inode" feature, I hope it could be errored out other than
silent fallback.

Also it'd be better to have a code comment that it doesn't cover mounts
with extra_devs so that we could handle them in the follow-ups.

Thanks,
Gao Xiang

> 
> Thanks,
> Giuseppe
