Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4A2D6E5A;
	Fri, 10 Apr 2026 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820685; cv=none; b=nQcYTkjOt0i9fQ40KGIZ4wTcHl1EhJsEeyG8I6fYZljsrXCjiI5R6unbedXvhoSLzRqNU9v/cetW8r0C+mf0Q/S8smqo2RkrsVoXFYgKy3DSn7XFJBPl+OWlBxEFiVmDdKm0fTNa5UUG8qPxicdzYaP8xYQ6YvJc/voPAC87jsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820685; c=relaxed/simple;
	bh=QLKGDGwldbNIz41BFbe9eP66xq7F5Z+wbkz8Q9d4zB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5nu+ZD1QMASyFn7OzaabpF1SVRHVEAub87iatouT4BYwa3oR2HIXSzkK7NFe4HkLWobGaS4dX9xfQVkA3pis0Ze3/5DrpwVssIYAPS8kuGWwCzpkPPf6fDyOF6GGgaxhuHwXcIKVPp3zgKFmY3M8DrE2aVKNipc297j60ntYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A459o6iP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A459o6iP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2725C19421;
	Fri, 10 Apr 2026 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775820684;
	bh=QLKGDGwldbNIz41BFbe9eP66xq7F5Z+wbkz8Q9d4zB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A459o6iPYP4Ws7/tAPYUoDEj4NoHtQhqCBgsO6YNMOXvYd7Y4xlwHWNX3KvdRJWVC
	 aPkaOLIu4GUJmJBdkw+lUhfUT00qHfDAkNnG02qGt/Gwk+5cjj/iv9lGRxZ9i4znEx
	 gQg3MN9dZl2IW1cVwSaaYiNGfWpnrpdTyztGMf7hB0j7DBHDEOJxw6w+UGzu9tAGp5
	 2hP31PCMoU87QgHGcha9d79Yz3bkyzZZD1QiV8YGDa6OG4C9Tfv3ViJ8whmtE8oLjL
	 SM9eKciKr6PMKFQkboMMhmK40ePQK0B6DWAA6YDeK820yZaTYfIBo28kH0UcY/UlYU
	 cNAfhnS2zQBVQ==
Date: Fri, 10 Apr 2026 13:31:19 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Dan Klishch <danilklishch@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] proc: Relax check of mount visibility
Message-ID: <adjfhxs5JTrZDnbv@example.org>
References: <cover.1768295900.git.legion@kernel.org>
 <cover.1770979341.git.legion@kernel.org>
 <0943f113592a25bee341aae25d1cea088791054f.1770979341.git.legion@kernel.org>
 <20260217-helikopter-parkplatz-859f8f7c0054@brauner>
 <20260410-textstellen-anrollen-17acbf930c3a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410-textstellen-anrollen-17acbf930c3a@brauner>

On Fri, Apr 10, 2026 at 01:12:36PM +0200, Christian Brauner wrote:
> On Tue, Feb 17, 2026 at 12:59:54PM +0100, Christian Brauner wrote:
> > On Fri, Feb 13, 2026 at 11:44:29AM +0100, Alexey Gladkov wrote:
> > > When /proc is mounted with the subset=pid option, all system files from
> > > the root of the file system are not accessible in userspace. Only
> > > dynamic information about processes is available, which cannot be
> > > hidden with overmount.
> > > 
> > > For this reason, checking for full visibility is not relevant if
> > > mounting is performed with the subset=pid option.
> > > 
> > > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > > ---
> > >  fs/namespace.c                 | 29 ++++++++++++++++-------------
> > >  fs/proc/root.c                 | 17 ++++++++++-------
> > >  include/linux/fs/super_types.h |  2 ++
> > >  3 files changed, 28 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index c58674a20cad..7daa86315c05 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -6116,7 +6116,8 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
> > >  		/* This mount is not fully visible if it's root directory
> > >  		 * is not the root directory of the filesystem.
> > >  		 */
> > > -		if (mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
> > > +		if (!(sb->s_iflags & SB_I_USERNS_ALLOW_REVEALING) &&
> > > +		    mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
> > >  			continue;
> > >  
> > >  		/* A local view of the mount flags */
> > > @@ -6136,18 +6137,20 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
> > >  		    ((mnt_flags & MNT_ATIME_MASK) != (new_flags & MNT_ATIME_MASK)))
> > >  			continue;
> > 
> > There are a few things that I find problematic here.
> > 
> > Even before your change the mount flags of the first fully visible
> > procfs mount would be picked up. If the caller was unlucky they could
> > stumble upon the most restricted procfs mount in the mount namespace
> > rbtree. Leading to weird scenarios where a user cannot write to the
> > procfs instance they just mounted but could to another one that is also
> > in their namespace.
> > 
> > The other thing is that with this change specifically:
> > 
> >     if (!(sb->s_iflags & SB_I_USERNS_ALLOW_REVEALING) &&
> >         mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
> > 
> > we start caring about mount options of even partially exposed procfs
> > mounts. IOW, if someone had a bind-mount of e.g., /proc/pressure
> > somewhere that got inherited via CLONE_NEWNS then we suddenly take the
> > mount options of that into account for a new /proc/<pid>/* only instance.
> > I think we should continue caring only about procfs mounts that are
> > visible from their root.
> > 
> > The the other problem is that it is really annoying that we walk all
> > mounts in a mount namespace just to find procfs and sysfs mounts in
> > there. Currently a lot of workloads still do the CLONE_NEWNS dance
> > meaning they inherit all the crap from the host and then proceed to
> > setup their new rootfs. Busy container workloads that can be a lot.
> > 
> > So let's just be honest about it and treat procfs and sysfs as the
> > snowflakes that they have become and record their instances in a
> > separate per mount namespace hlist as in the (untested) patch below [1].
> > 
> > Also SB_I_USERNS_ALLOW_REVEALING seems unnecessary. The only time we
> > care about that flag is when we setup a new superblock. So this could
> > easily be a struct fs_context bitfield that just exists for the duration
> > of the creation of the new superblock and mount. So maybe pass that down
> > to mount_too_revealing() and further down into the actual helper.
> > 
> > [1]:
> > >From 4bbd41e7a3ef91667dd334f31b1b6bf8caec0599 Mon Sep 17 00:00:00 2001
> > From: Christian Brauner <brauner@kernel.org>
> > Date: Tue, 17 Feb 2026 12:02:34 +0100
> > Subject: [PATCH] namespace: record fully visible mounts in list
> > 
> > Instead of wading through all the mounts in the mount namespace rbtree
> > to find fully visible procfs and sysfs mounts, be honest about them
> > being special cruft and record them in a separate per-mount namespace
> > list.
> 
> If you rework this I would expect to take it for v7.3. It's a bit late
> now...

No problem. I understand. Sorry it took me so long to get back to you.
I was laid off from my job and had to look for a new one quickly.

I’ll be back soon to update this patch.

-- 
Rgrds, legion

