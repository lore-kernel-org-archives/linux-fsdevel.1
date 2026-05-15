Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB5390C9E;
	Fri, 15 May 2026 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881782; cv=none; b=kIn0e7hXnoaTQ81vtcW33ShEfWZT8t9tGU8JyoiI2MddCbdm0Xvsox9u48yuQRRrJSN98bxblaS/v/c/SBJuLt44gNY/MRSm2E5X4xhzH9Vkou3Aa/FTa4FlJDLwCEAtL04g9vpYx+Jw36w4cqXp5aiOSQnJ2njWJy09L++ufwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881782; c=relaxed/simple;
	bh=eZtnPAyW3wvMBTGehn2ipTsmWPu1akcmgaOfWu07T8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzFF1eqshIEtzcqU+TD/O5KX+ewnx4xDCZKSfA6HquGXsX6xi9aixCT8Hp4rALpdTLQFL6kEImQ9RxzatwWBN8OckgAhT4eVe5OgAAoI8w2O76K1HDRUVoGdbXeL3sgvYASeG9z506at6+eI8pc1aWV5uc/7k/ldk9FqZqL4/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogqKoG12; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogqKoG12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F32C2BCB0;
	Fri, 15 May 2026 21:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778881781;
	bh=eZtnPAyW3wvMBTGehn2ipTsmWPu1akcmgaOfWu07T8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogqKoG12+DU5czBbA5XPetQeISucAbVmVk7MtKLEFGy+ODzPQZcIn383uej1enefk
	 DSnTkoUJ6Y1KbbGbSiiWhfDJkNSiKYdH86xoqqfmkES25x9q1TsWefhfxu3PNRY91a
	 0K5hmCFxub/09irTGulE5NYA4i+R1gSw2NP2P3w9DqhtPetCdG6tSL2XMcxLtIZjB/
	 uJ/Sh54WcOaLxt1dPvgmP5XrFvnZ3tPvUFHxiEpY4NdbvA1HHNCRssMnb2/TZGpg3u
	 SERNQ7eC/AUIRko12we5xKK4Lef1t8bF0KUPX36cqA6mFnjV3P6So1XMZ59nMPzCFb
	 El0iiQcTYhxFQ==
Date: Fri, 15 May 2026 14:49:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev,
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH 3/9] fuse: allow local filesystems to set some VFS iflags
Message-ID: <20260515214941.GF9568@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206552.4103309.6736684975553576273.stgit@frogsfrogsfrogs>
 <20260514221439.GJ9544@frogsfrogsfrogs>
 <CAOQ4uxj-JandJhCQ8VzsqqvkqCCenMFkAQxNwm9e2RRiqQqACg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj-JandJhCQ8VzsqqvkqCCenMFkAQxNwm9e2RRiqQqACg@mail.gmail.com>

On Fri, May 15, 2026 at 11:14:38PM +0200, Amir Goldstein wrote:
> On Fri, May 15, 2026 at 12:14 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Apr 29, 2026 at 07:33:51AM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > There are three inode flags (immutable, append, sync) that are enforced
> > > by the VFS.  Whenever we go around setting iflags, let's update the VFS
> > > state so that they actually work.  Make it so that the fuse server can
> > > set these three inode flags at load time and have the kernel advertise
> > > and enforce them.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_i.h          |    1 +
> > >  include/uapi/linux/fuse.h |    8 +++++++
> > >  fs/fuse/dir.c             |    1 +
> > >  fs/fuse/inode.c           |    1 +
> > >  fs/fuse/ioctl.c           |   50 +++++++++++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 61 insertions(+)
> > >
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 95b37f4660cc1d..3b38b98dc0096c 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -1651,6 +1651,7 @@ long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
> > >  int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
> > >  int fuse_fileattr_set(struct mnt_idmap *idmap,
> > >                     struct dentry *dentry, struct file_kattr *fa);
> > > +void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr);
> > >
> > >  /* iomode.c */
> > >  int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index b6fa828776b82f..bf8514a5ee27af 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -249,6 +249,8 @@
> > >   *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
> > >   *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
> > >   *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
> > > + *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
> > > + *    attributes
> > >   */
> > >
> > >  #ifndef _LINUX_FUSE_H
> > > @@ -606,12 +608,18 @@ struct fuse_file_lock {
> > >   * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
> > >   * FUSE_ATTR_IOMAP: Use iomap for this inode
> > >   * FUSE_ATTR_ATOMIC: Enable untorn writes
> > > + * FUSE_ATTR_SYNC: File writes are synchronous
> > > + * FUSE_ATTR_IMMUTABLE: File is immutable
> > > + * FUSE_ATTR_APPEND: File is append-only
> > >   */
> > >  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> > >  #define FUSE_ATTR_DAX                (1 << 1)
> > >  #define FUSE_ATTR_EXCLUSIVE  (1 << 2)
> > >  #define FUSE_ATTR_IOMAP              (1 << 3)
> > >  #define FUSE_ATTR_ATOMIC     (1 << 4)
> > > +#define FUSE_ATTR_SYNC               (1 << 5)
> > > +#define FUSE_ATTR_IMMUTABLE  (1 << 6)
> > > +#define FUSE_ATTR_APPEND     (1 << 7)
> > >
> 
> This feels like an abuse of the FUSE_ATTR_ flags.

Oh, it totally is!  I'm not sure what the FUSE_ATTR_ flags are meant
for: are they only for enabling the sorts of features that *must* be
turned on at INEW time?

> Seeing that Miklos wanted to convert LOOKUP
> response to a compound response of LOOKUP+STATX
> it would have been nicer to get those flags from fuse_statx

Yeah, if I could go back in time I'd redesign fuse to have its own file
attributes structure instead of stat and statx.

> only there is no STATX_ATTR_SYNC <WHY?>
> I shiver to suggest adding it to statx.

I don't know either.  File attributes on linux are a mess, look at
statx + getflags + file_getattr.

> Oh well, I don't know. It's up to Miklos to make this call.

--D
