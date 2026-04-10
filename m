Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD473395D90;
	Fri, 10 Apr 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819561; cv=none; b=LJuKXtPxcDn5BrfCjmqym+DKUwKkSEU5GeisImZ0qV/rV7EX2yV6uvJuesUoOkPRmzICpOUytIoNRrli6OA+95ColKLctcRi7lR4hhojG1nMaiU9PBuX5hz8ytzB00Q6C75sgQyxfUTbTK5CLYO+lsYnIbEhNJmm8lOTW2Zo5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819561; c=relaxed/simple;
	bh=wM2A+17g/Ua5mDDboh62uYwjkJFHo1LNxa0bdAUoYyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihPShliJfpqesws9F/RfhkYs3EMjc5fEl0M0opUj2bwdkpxHapkwLtjOJgD2G8cPyLnqSABoxK1o9fOdFlA1S6Ui+gfYcX35SeCj/iaxc66raA2OEqJ8rV7dQwOAKQbUSDBzNsL5tclaqaMVGC+nm8QPIERlBOaUAjQXokjvOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6+BkjPn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6+BkjPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE4CC19421;
	Fri, 10 Apr 2026 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775819561;
	bh=wM2A+17g/Ua5mDDboh62uYwjkJFHo1LNxa0bdAUoYyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6+BkjPn9JJSeBobaJAw39DbhZtFmFjFtsLkNJGdQDqNS99hyg8pV6Y4OglTbAOK2
	 Kj3aSvpgbSzKVrDJLytge3h4zr4cgQHDamzsyT+Hz5RrMOk3cdnnqcLwOwl+CIkIsU
	 QgZDe/7rQODR/mMufQw6vNe7FfegPC5GokpbJk32hwu50IAMizJE5mUK/OyxfpX4IZ
	 gmKmtPjIKexBKb5hjmO/1eJck8RPguMuLaIEVIPCGEejFnGmmyOaX2y3oPiUFrSzE+
	 Ek60KaZMn1Au0r5fZJh41xsOMCfjeBPLoztmC36Uu0uZ1Md752vsvBQYhMzrhV1tRY
	 qiKw7qShMOqFQ==
Date: Fri, 10 Apr 2026 13:12:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Dan Klishch <danilklishch@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] proc: Relax check of mount visibility
Message-ID: <20260410-textstellen-anrollen-17acbf930c3a@brauner>
References: <cover.1768295900.git.legion@kernel.org>
 <cover.1770979341.git.legion@kernel.org>
 <0943f113592a25bee341aae25d1cea088791054f.1770979341.git.legion@kernel.org>
 <20260217-helikopter-parkplatz-859f8f7c0054@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217-helikopter-parkplatz-859f8f7c0054@brauner>

On Tue, Feb 17, 2026 at 12:59:54PM +0100, Christian Brauner wrote:
> On Fri, Feb 13, 2026 at 11:44:29AM +0100, Alexey Gladkov wrote:
> > When /proc is mounted with the subset=pid option, all system files from
> > the root of the file system are not accessible in userspace. Only
> > dynamic information about processes is available, which cannot be
> > hidden with overmount.
> > 
> > For this reason, checking for full visibility is not relevant if
> > mounting is performed with the subset=pid option.
> > 
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > ---
> >  fs/namespace.c                 | 29 ++++++++++++++++-------------
> >  fs/proc/root.c                 | 17 ++++++++++-------
> >  include/linux/fs/super_types.h |  2 ++
> >  3 files changed, 28 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index c58674a20cad..7daa86315c05 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -6116,7 +6116,8 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
> >  		/* This mount is not fully visible if it's root directory
> >  		 * is not the root directory of the filesystem.
> >  		 */
> > -		if (mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
> > +		if (!(sb->s_iflags & SB_I_USERNS_ALLOW_REVEALING) &&
> > +		    mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
> >  			continue;
> >  
> >  		/* A local view of the mount flags */
> > @@ -6136,18 +6137,20 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
> >  		    ((mnt_flags & MNT_ATIME_MASK) != (new_flags & MNT_ATIME_MASK)))
> >  			continue;
> 
> There are a few things that I find problematic here.
> 
> Even before your change the mount flags of the first fully visible
> procfs mount would be picked up. If the caller was unlucky they could
> stumble upon the most restricted procfs mount in the mount namespace
> rbtree. Leading to weird scenarios where a user cannot write to the
> procfs instance they just mounted but could to another one that is also
> in their namespace.
> 
> The other thing is that with this change specifically:
> 
>     if (!(sb->s_iflags & SB_I_USERNS_ALLOW_REVEALING) &&
>         mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
> 
> we start caring about mount options of even partially exposed procfs
> mounts. IOW, if someone had a bind-mount of e.g., /proc/pressure
> somewhere that got inherited via CLONE_NEWNS then we suddenly take the
> mount options of that into account for a new /proc/<pid>/* only instance.
> I think we should continue caring only about procfs mounts that are
> visible from their root.
> 
> The the other problem is that it is really annoying that we walk all
> mounts in a mount namespace just to find procfs and sysfs mounts in
> there. Currently a lot of workloads still do the CLONE_NEWNS dance
> meaning they inherit all the crap from the host and then proceed to
> setup their new rootfs. Busy container workloads that can be a lot.
> 
> So let's just be honest about it and treat procfs and sysfs as the
> snowflakes that they have become and record their instances in a
> separate per mount namespace hlist as in the (untested) patch below [1].
> 
> Also SB_I_USERNS_ALLOW_REVEALING seems unnecessary. The only time we
> care about that flag is when we setup a new superblock. So this could
> easily be a struct fs_context bitfield that just exists for the duration
> of the creation of the new superblock and mount. So maybe pass that down
> to mount_too_revealing() and further down into the actual helper.
> 
> [1]:
> >From 4bbd41e7a3ef91667dd334f31b1b6bf8caec0599 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Tue, 17 Feb 2026 12:02:34 +0100
> Subject: [PATCH] namespace: record fully visible mounts in list
> 
> Instead of wading through all the mounts in the mount namespace rbtree
> to find fully visible procfs and sysfs mounts, be honest about them
> being special cruft and record them in a separate per-mount namespace
> list.

If you rework this I would expect to take it for v7.3. It's a bit late
now...
