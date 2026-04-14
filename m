Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B1358375;
	Tue, 14 Apr 2026 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160531; cv=none; b=qFD2uKSg0FCo/Di2N1FzysfqzwwN3meP0CdHUi3rpIWcEmG/XrCTVhuSSZ19uVTJK3jXvYlSxV9JaEP0lGTIsiXJZQaM+zOOgzoT4Y7PlHBuW44F/EoM8kfmk/902njeIPU0S0exZD/NVZtoNfVXUTp0FTr32hpXcrSgjkssX98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160531; c=relaxed/simple;
	bh=hhE4zNnmKkl6kUlozX9TbtMR+uNdd/idlRMIa69UChE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVwG2oYcaTZ4aVlvvdFooOwx+CKb+shYK+rpJDJYo2YYZyzPxr91o5r5MgP2XLrrYSS5r3bFvhz+knEMdbblY6vu4J3R7dpbDKgqYgGtrS6n8POXMz9P1FeHTr0RirpuwcG7+DWswOIda9oLlUThu633Fww4u21pnQHIYrLZH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVMPmRhk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVMPmRhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A7BC19425;
	Tue, 14 Apr 2026 09:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776160530;
	bh=hhE4zNnmKkl6kUlozX9TbtMR+uNdd/idlRMIa69UChE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVMPmRhkJO78D11lvo1uVGLP2QyB3F/Gh0YQxQ33nGm+QyRgXcgya4lGPdqJV9mui
	 8Lx1FMTgdzO7hKhP2ihj+my7k/HahPgXDvznJuVrh3FGHmX2Y5ELlqatIxmdgozO3O
	 g5foAVX+8G8w0YwW6dlNz8LQqLkZ6vZph5StndnlceTmaW8sSVcZvhzveMCzDsx4c9
	 96p/fllxyDS0W2++8OMS5nj1kltE8zrNB3+KSjIedNkLvSg7zdUcz7++sd3Rmx8WUb
	 5GFAw+0HFV+rYlsEekpQedts+q28VLHPC0bAPOVNBdnOLYtx97bNe09z5s9YXMPOq5
	 TI7Yt0LIlibhA==
Date: Tue, 14 Apr 2026 11:55:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Dan Klishch <danilklishch@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] proc: Relax check of mount visibility
Message-ID: <20260414-mathematik-beispiel-cd22801e71af@brauner>
References: <cover.1768295900.git.legion@kernel.org>
 <cover.1770979341.git.legion@kernel.org>
 <0943f113592a25bee341aae25d1cea088791054f.1770979341.git.legion@kernel.org>
 <20260217-helikopter-parkplatz-859f8f7c0054@brauner>
 <20260410-textstellen-anrollen-17acbf930c3a@brauner>
 <adjfhxs5JTrZDnbv@example.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adjfhxs5JTrZDnbv@example.org>

On Fri, Apr 10, 2026 at 01:31:19PM +0200, Alexey Gladkov wrote:
> On Fri, Apr 10, 2026 at 01:12:36PM +0200, Christian Brauner wrote:
> > On Tue, Feb 17, 2026 at 12:59:54PM +0100, Christian Brauner wrote:
> > > On Fri, Feb 13, 2026 at 11:44:29AM +0100, Alexey Gladkov wrote:
> > > > When /proc is mounted with the subset=pid option, all system files from
> > > > the root of the file system are not accessible in userspace. Only
> > > > dynamic information about processes is available, which cannot be
> > > > hidden with overmount.
> > > > 
> > > > For this reason, checking for full visibility is not relevant if
> > > > mounting is performed with the subset=pid option.
> > > > 
> > > > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > > > ---
> > > >  fs/namespace.c                 | 29 ++++++++++++++++-------------
> > > >  fs/proc/root.c                 | 17 ++++++++++-------
> > > >  include/linux/fs/super_types.h |  2 ++
> > > >  3 files changed, 28 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > index c58674a20cad..7daa86315c05 100644
> > > > --- a/fs/namespace.c
> > > > +++ b/fs/namespace.c
> > > > @@ -6116,7 +6116,8 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
> > > >  		/* This mount is not fully visible if it's root directory
> > > >  		 * is not the root directory of the filesystem.
> > > >  		 */
> > > > -		if (mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
> > > > +		if (!(sb->s_iflags & SB_I_USERNS_ALLOW_REVEALING) &&
> > > > +		    mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
> > > >  			continue;
> > > >  
> > > >  		/* A local view of the mount flags */
> > > > @@ -6136,18 +6137,20 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
> > > >  		    ((mnt_flags & MNT_ATIME_MASK) != (new_flags & MNT_ATIME_MASK)))
> > > >  			continue;
> > > 
> > > There are a few things that I find problematic here.
> > > 
> > > Even before your change the mount flags of the first fully visible
> > > procfs mount would be picked up. If the caller was unlucky they could
> > > stumble upon the most restricted procfs mount in the mount namespace
> > > rbtree. Leading to weird scenarios where a user cannot write to the
> > > procfs instance they just mounted but could to another one that is also
> > > in their namespace.
> > > 
> > > The other thing is that with this change specifically:
> > > 
> > >     if (!(sb->s_iflags & SB_I_USERNS_ALLOW_REVEALING) &&
> > >         mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
> > > 
> > > we start caring about mount options of even partially exposed procfs
> > > mounts. IOW, if someone had a bind-mount of e.g., /proc/pressure
> > > somewhere that got inherited via CLONE_NEWNS then we suddenly take the
> > > mount options of that into account for a new /proc/<pid>/* only instance.
> > > I think we should continue caring only about procfs mounts that are
> > > visible from their root.
> > > 
> > > The the other problem is that it is really annoying that we walk all
> > > mounts in a mount namespace just to find procfs and sysfs mounts in
> > > there. Currently a lot of workloads still do the CLONE_NEWNS dance
> > > meaning they inherit all the crap from the host and then proceed to
> > > setup their new rootfs. Busy container workloads that can be a lot.
> > > 
> > > So let's just be honest about it and treat procfs and sysfs as the
> > > snowflakes that they have become and record their instances in a
> > > separate per mount namespace hlist as in the (untested) patch below [1].
> > > 
> > > Also SB_I_USERNS_ALLOW_REVEALING seems unnecessary. The only time we
> > > care about that flag is when we setup a new superblock. So this could
> > > easily be a struct fs_context bitfield that just exists for the duration
> > > of the creation of the new superblock and mount. So maybe pass that down
> > > to mount_too_revealing() and further down into the actual helper.
> > > 
> > > [1]:
> > > >From 4bbd41e7a3ef91667dd334f31b1b6bf8caec0599 Mon Sep 17 00:00:00 2001
> > > From: Christian Brauner <brauner@kernel.org>
> > > Date: Tue, 17 Feb 2026 12:02:34 +0100
> > > Subject: [PATCH] namespace: record fully visible mounts in list
> > > 
> > > Instead of wading through all the mounts in the mount namespace rbtree
> > > to find fully visible procfs and sysfs mounts, be honest about them
> > > being special cruft and record them in a separate per-mount namespace
> > > list.
> > 
> > If you rework this I would expect to take it for v7.3. It's a bit late
> > now...
> 
> No problem. I understand. Sorry it took me so long to get back to you.
> I was laid off from my job and had to look for a new one quickly.

Damn, I'm very sorry to hear this. But the hopefully this will just be a
very minor setback.
