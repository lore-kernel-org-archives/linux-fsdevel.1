Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459235F60F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356389; cv=none; b=BOJ07C1AczG3scSCbFtSPYfS4SotluR2steApVGQkjf0DwPnQkbTI+h8EhJHta4AQ443ulngzkHN7Pd+IBHCemsFuCBk4FZNzLObZPiwX6Pon4oNY38qhNkq8dmY7Vb/FEdrhnfdv8brqwiFvBq8fxXOggs/yQAdFk93oR/+X2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356389; c=relaxed/simple;
	bh=sVqLJtmuDwopkiRM5mDQ6E5spakL+Cf5BIkXgw3JJrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEALlb9Nd0KydMOY02qdwa5pteSeXYPAn/f+kJHDx8ya5QiLNL8uVFCvO1xf/j+BgIW/I1NjfUkyOj9Z56L7FkGUO/R+8t02pelFK4oKdT5Vb+5r/Rm4MgrKbCOiTYULNSKz9ril74mh0XdHGkA7foI/6d+ryD1drlc/MHD98P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0b/oTVX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0b/oTVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1E11F000E9;
	Wed, 29 Jul 2026 20:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785356387;
	bh=WMt7YwCC0dDfpuE1qENmuDfw/kaJXYkfFl7nmsoBBlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z0b/oTVXfDeUmhppYK57JD4ImyHuFukTrqSMz+YA1SL4o5k6I8bfakyQ5hCj6twKK
	 cHqw7pWVvlHTBlwr2zy5V1eUmOtdRA8NgHJ+EHwJIl5s40TBmjYLrIEdu85jAvNPaN
	 QbI2fLdMSKGWMBB2WB8+zBXD251jWwQE9Il1tusrZFfzsp0tzYK64km1GSfhMrI3C1
	 zxH6cj+WGkzHAa55qaH4yI7LK6XtUH3JeyOTTs7kxqHk2sp8GMkHcevgNdB+sXD/Wp
	 SLto1yoiemZ13VJmPVfX61O20TfTxqhyza5eyUjItJxPZy81rPrawxoTsDRkf7AoKN
	 QOBJbypcJwzQw==
Date: Thu, 30 Jul 2026 04:19:29 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Gao Xiang <xiang@kernel.org>, Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, cyphar@cyphar.com,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5] erofs: accept source file descriptor via fsconfig
Message-ID: <ampgUYqGnEVhqhXt@XiangdeMacBook-Pro.local>
Mail-Followup-To: Jan Kara <jack@suse.cz>, Gao Xiang <xiang@kernel.org>,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, cyphar@cyphar.com,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
References: <20260728160619.853924-1-gscrivan@redhat.com>
 <amlaIt8jjy_mSK-j@XiangdeMacBook-Pro.local>
 <7kgp355d25csimg5txuxhp33zmc5onxpyxdtkarmun62rblp7j@etbql27573dl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7kgp355d25csimg5txuxhp33zmc5onxpyxdtkarmun62rblp7j@etbql27573dl>

Hi Jan,

On Wed, Jul 29, 2026 at 11:57:25AM +0200, Jan Kara wrote:
> On Wed 29-07-26 09:40:50, Gao Xiang wrote:
> > On Tue, Jul 28, 2026 at 06:05:32PM +0200, Giuseppe Scrivano wrote:
> > > Allow userspace to pass an already-opened file descriptor as the mount
> > > source instead of a path string.  This is useful for tools that already
> > > hold an fd to the image, such as composefs reusing an existing erofs
> > > backing file.
> > > 
> > > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> > > ---
> > > v4: https://lore.kernel.org/linux-fsdevel/20260717134147.1602735-1-gscrivan@redhat.com/
> > > v3: https://lore.kernel.org/linux-fsdevel/20260714154917.489993-1-gscrivan@redhat.com/
> > > v2: https://lore.kernel.org/linux-fsdevel/20260711071137.4130824-1-gscrivan@redhat.com/
> > > v1: https://lore.kernel.org/linux-fsdevel/ak5GfvVfWLJU1EwK@debian/
> > > 
> > >  Documentation/filesystems/erofs.rst | 15 ++++++
> > >  fs/erofs/super.c                    | 73 ++++++++++++++++++++++++-----
> > >  2 files changed, 77 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> > > index 4230884fb359..774e8b236d09 100644
> > > --- a/Documentation/filesystems/erofs.rst
> > > +++ b/Documentation/filesystems/erofs.rst
> > > @@ -139,6 +139,21 @@ inode_share            Enable inode page sharing for this filesystem.  Inodes wi
> > >                         page cache.
> > >  ===================    =========================================================
> > >  
> > > +File-backed mounts
> > > +==================
> > > +
> > > +When CONFIG_EROFS_FS_BACKED_BY_FILE is enabled, EROFS file-backed images
> > > +can be mounted directly without a loopback block device.  The backing file
> > > +can be given either as a path, or as an already-opened file descriptor.
> > > +
> > > +When a file descriptor is used, the kernel resolves its path and records it
> > > +so that /proc/mounts and similar interfaces can still report the mount
> > > +source.
> > > +
> > > +Only regular files are accepted as backing files; to mount an image that
> > > +resides on a block device, use the traditional block device mount path
> > > +instead.
> > 
> > Reviewed-by: Gao Xiang <xiang@kernel.org>
> > 
> > Hi Christian, Jan, could you ack this (`fc->source` filling when
> > `source_fd` is used) if possible?
> 
> Whenever I see a use of d_path() (or file_path() in this case) I'm a bit
> watchful because its result is inherently racy and unsafe. But in this case
> the result is only used for alloc_vfsmnt() which uses it for mnt_devname so
> in the worst case we'll get an unreliable path in /proc/mounts or similar.
> I guess that's acceptable. So feel free to add:

Thanks for your reply and comment.  Yeah, the result of d_path() can become
outdated later since it only uses seqcounts to ensure that within the process,
but here I also think "mnt_devname" usage doesn't really matter (but I hope
filling like this is fine and stable in the long term.)

> 
> Acked-by: Jan Kara <jack@suse.cz>

Thanks!

Thanks,
Gao Xiang

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
