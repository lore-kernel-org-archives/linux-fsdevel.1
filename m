Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511C78C9C;
	Fri,  5 Jun 2026 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617696; cv=none; b=Rsf5w3YAt0g0hZUtRSbDbqMSy3JlVn/Uosmx45/UVgTTRFjzziRvTbZJI5rvbbcCRPzdRx6ww7DSRNpT3uBKE/1o2qOzb7Ij+g5u656pH4UFBTAanKYmHKKT5j6PR8V6H4vI2eB04KBKz9oPEmj+J0sd5tbGhnNWDm51aiBqavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617696; c=relaxed/simple;
	bh=7MSlpgTRB7O2EjRCOfIgIugKxFlb1l0F7/ns+bRdqQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZfSdwahCU0tSHWzGVBlrqQec1QPYcN5JoyZZKKeppIC+kTnwqjOQoixegwmoPWkU5xOh/2BUoD46VxECQav8eijd8Ff5mUUFygQn1lOzVs7UbeDlJz8sr3BwHcM7H7EppzRfgo1WdWQpMKVAzqO1eM9VqWUC2NLibV6XSscuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWhIcH36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWhIcH36"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 466EF1F00893;
	Fri,  5 Jun 2026 00:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780617695;
	bh=xot4ftVLuYLoGEya37hf1ZUN7zwMR1DOZHxE0swXg/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mWhIcH36vkkJ0mjoUbaifqqN9tmx/zdo77jUsiE26kxtiTzdgrqsD4Nnh4AbsLxH8
	 ADZbEkKHgTos5z3fynrhGpADO8aPtigKgonQmsnxWERR7gmtM7OMmcVABMS0Gqu2qf
	 HSqwujuMDshLNXlbtyRMyLSpWmbzDyI6b6j93tUHQ0wlbjA8cW0flVDkMo+AAFZBww
	 3oQ47g6r2L3gna/XzhfqxNoxfeUNrBALrq69/ErUriY31FEumF7soomWKkOv2SQPUB
	 cvFZKGqlxphEn2l3WT2MyG0Wk8SYP/gQoAroLQWXG5n21qIn7wUNaOg9FQBRdD/FaW
	 DcMkM7Wk4Vwhw==
Date: Thu, 4 Jun 2026 17:01:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 9/9] fuse: set iomap backing device block size
Message-ID: <20260605000134.GJ6070@frogsfrogsfrogs>
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
 <177922946372.2439242.13829037107289830266.stgit@frogsfrogsfrogs>
 <CAJnrk1ZQbvCL=ok4WHBn0gC+=k88Cejts_-_DP3epa51Wz5+5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZQbvCL=ok4WHBn0gC+=k88Cejts_-_DP3epa51Wz5+5g@mail.gmail.com>

On Fri, May 22, 2026 at 06:06:15PM -0700, Joanne Koong wrote:
> On Tue, May 19, 2026 at 3:33 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Add a new ioctl so that an unprivileged fuse server can set the block
> > size of a bdev that's opened for iomap usage.
> 
> If I'm understanding it correctly, doesn't the fs/iomap layer align
> all i/o to the fuse file inode->i_blkbits and submits bios to the
> underlying iomap->bdev without ever reading the bdev's
> inode->i_blkbits? Why do we need this fuse ioctl then for setting the
> block size of a bdev?

It's not for the regular file IO, it's for the blockdev pagecache that
sits in front of filesystem metadata IO.  Block devices do writeback of
their pagecache in units of buffer heads, which is a problem if the
buffer head size is not aligned to the fsblock size.

Basically, imagine a 1k-fsblock filesystem with 4k pages.  Let us
further assume that block 0 is a superblock, and block 1 is the only
file data in the whole filesystem.

If the BLKBSZGET size is also 4k, then dirtying the superblock now means
that the bdev pagecache will think that the whole 4k is dirty, because
there's only one bh for the whole 4k.

Now let's say iomap writes to the sole file data block.  The ondisk data
is newer than the bdev pagecache.  Next, the fuse server initiates
writeout of the dirty bdev pagecache.  It writes the whole page out to
disk, which means the ondisk super is newest, but the file data block
has just been clobbered by stale bdev pagecache!

Ouch.

So if we can set the bh size to 1k, we avoid the clobbering.

> It seems like this ioctl is re-implementing the BLKBSZSET ioctl but
> bypasses the cap sys admin privilege checking that the BLKBSZSET ioctl
> requires, which seems like a security violation. Am I understanding
> this correctly?

It is, but the assumption was that you'd only get fuse-iomap if you
already had CAP_SYS_RAWIO, so you have to have some privilege.  But I
concede that RAWIO != ADMIN.  This might be unnecessary now that fuse
service containers can ask the mount helper to open a bdev in O_EXCL
mode and set a particular blocksize.

Though note the weird thing -- a sysadmin can use chmod to let
unprivileged userspace to open a bdev and it can open it O_EXCL, but it
can't set the block size unless they have CAP_SYS_ADMIN.

--D

> Thanks,
> Joanne
> 
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_iomap.h      |    3 +++
> >  include/uapi/linux/fuse.h |    8 ++++++++
> >  fs/fuse/dev.c             |    2 ++
> >  fs/fuse/fuse_iomap.c      |   27 +++++++++++++++++++++++++++
> >  4 files changed, 40 insertions(+)
> >
> >
> > diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
> > index f40d202c64c822..3cfef073cbe5aa 100644
> > --- a/fs/fuse/fuse_iomap.h
> > +++ b/fs/fuse/fuse_iomap.h
> > @@ -69,6 +69,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
> >  int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *argp);
> >  int fuse_iomap_backing_inval(struct fuse_conn *fc,
> >                              const struct fuse_iomap_backing_inval_out *arg);
> > +int fuse_iomap_backing_set_blocksize(struct file *file,
> > +                                    struct fuse_iomap_backing_info __user *argp);
> >  #else
> >  # define fuse_iomap_enabled(...)               (false)
> >  # define fuse_has_iomap(...)                   (false)
> > @@ -97,6 +99,7 @@ int fuse_iomap_backing_inval(struct fuse_conn *fc,
> >  # define fuse_dev_ioctl_iomap_support(...)     (-EOPNOTSUPP)
> >  # define fuse_dev_ioctl_iomap_set_nofs(...)    (-EOPNOTSUPP)
> >  # define fuse_iomap_backing_inval(...)         (-ENOSYS)
> > +# define fuse_iomap_backing_set_blocksize(...) (-EOPNOTSUPP)
> >  #endif /* CONFIG_FUSE_IOMAP */
> >
> >  #endif /* _FS_FUSE_IOMAP_H */
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 899964f8d6616a..0b67938bb7baf0 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -1173,6 +1173,11 @@ struct fuse_iomap_support {
> >         uint64_t        padding;
> >  };
> >
> > +struct fuse_iomap_backing_info {
> > +       uint32_t        backing_id;
> > +       uint32_t        blocksize;
> > +};
> > +
> >  /* Device ioctls: */
> >  #define FUSE_DEV_IOC_MAGIC             229
> >  #define FUSE_DEV_IOC_CLONE             _IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
> > @@ -1184,6 +1189,9 @@ struct fuse_iomap_support {
> >                                              struct fuse_iomap_support)
> >  #define FUSE_DEV_IOC_SET_NOFS          _IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
> >  #define FUSE_DEV_IOC_ADD_IOMAP         _IO(FUSE_DEV_IOC_MAGIC, 101)
> > +#define FUSE_DEV_IOC_IOMAP_BACKING_SET_BLOCKSIZE \
> > +                                       _IOW(FUSE_DEV_IOC_MAGIC, 102, \
> > +                                            struct fuse_iomap_backing_info)
> >
> >  struct fuse_lseek_in {
> >         uint64_t        fh;
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 06f52114b9aef2..d6ba8d6b1a8875 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2746,6 +2746,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
> >                 return fuse_dev_ioctl_iomap_set_nofs(file, argp);
> >         case FUSE_DEV_IOC_ADD_IOMAP:
> >                 return fuse_dev_ioctl_add_iomap(file);
> > +       case FUSE_DEV_IOC_IOMAP_BACKING_SET_BLOCKSIZE:
> > +               return fuse_iomap_backing_set_blocksize(file, argp);
> >
> >         default:
> >                 return -ENOTTY;
> > diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> > index ba54eb694dbbac..2deed4749738cb 100644
> > --- a/fs/fuse/fuse_iomap.c
> > +++ b/fs/fuse/fuse_iomap.c
> > @@ -2448,3 +2448,30 @@ int fuse_iomap_backing_inval(struct fuse_conn *fc,
> >         up_read(&fc->killsb);
> >         return ret;
> >  }
> > +
> > +int fuse_iomap_backing_set_blocksize(struct file *file,
> > +                                    struct fuse_iomap_backing_info __user *argp)
> > +{
> > +       struct fuse_iomap_backing_info fbi;
> > +       struct fuse_dev *fud = fuse_get_dev(file);
> > +       struct fuse_backing *fb;
> > +       int ret;
> > +
> > +       if (IS_ERR(fud))
> > +               return PTR_ERR(fud);
> > +
> > +       if (!fud->fc->iomap)
> > +               return -EOPNOTSUPP;
> > +
> > +       if (copy_from_user(&fbi, argp, sizeof(fbi)))
> > +               return -EFAULT;
> > +
> > +       fb = fuse_backing_lookup(fud->fc, &fuse_iomap_backing_ops,
> > +                                fbi.backing_id);
> > +       if (!fb)
> > +               return -ENOENT;
> > +
> > +       ret = set_blocksize(fb->file, fbi.blocksize);
> > +       fuse_backing_put(fb);
> > +       return ret;
> > +}
> >
> 
