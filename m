Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59329250BF2;
	Fri,  8 May 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262313; cv=none; b=GE0Uqa8hoC6t6K9O7uYEL+pUH6NX1RfGPeJk3d5E/1b2C41gXQNLAD0x+7KdbJztVqkzIINQQSKD1BbYS2hZTAPr0CGR7a+/zxYsM1fQ/XLY7Azg0uKbiieaOTRvFpnkgj9+oPhiWvVDVQKyerzvzVz/AZTdKuo25enSLLNZegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262313; c=relaxed/simple;
	bh=xz27O53rxIcMwi2WRA9mJiwEwuoeF1D8A5uESEn/3JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVHFKuzKiE5Z3EhgJE4+lkOTZmX4kkP7LM1enLuX6RUUCQUtWOmq2iTVr+GqeCvDGx2utua+e6UOH2APL3sv5rJ5DyQQhnkN2wcZalG1cY5g75xrzucLf43HqHFX6JgNoNtGLBhQiKMNTlhIG2MZfiSKC54ruMgwbqyPSe1Lfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfhEG22r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfhEG22r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008C0C2BCB0;
	Fri,  8 May 2026 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262313;
	bh=xz27O53rxIcMwi2WRA9mJiwEwuoeF1D8A5uESEn/3JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfhEG22rMx4YL638YJ+pAsd0++PrXDaiQVhyNt62IPuRHQu2W3LyPhjFtTlzMqYtn
	 AywcVgWc+Snjo2i7wFkmeNTNz3MJ6L+irV/BOMNn4KC5g3ffHjwjRMZhRfgbidx//z
	 bJjUA3ysPy/w2y8b1wMvZvMUuNFdcg99nnXNbcujQLr9yMjgYCKXNWMzX3meuV4FCt
	 ou1TNNaH3pV8jL0lSdDJSD07XB96ITVdFKgzCI4kDgDHI59zZPhm9C6ps9ZY+wsyLr
	 K77MiCOT9E9clFqvb9YjbfozXMj1BbU4KW4PlKbqVuCNys5JFZ7aKPtkV/mP5ESeOT
	 6C7zH1MvtGb5g==
Date: Fri, 8 May 2026 10:45:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
	neal@gompa.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] mount_util: fix mount_flags entries for MS_RDONLY
Message-ID: <20260508174512.GD2241589@frogsfrogsfrogs>
References: <177819197881.3490692.13850589276777261250.stgit@frogsfrogsfrogs>
 <177819197899.3490692.5280827494230619038.stgit@frogsfrogsfrogs>
 <6276b3d6-cc8c-4e37-b670-ff2a25c69686@bsbernd.com>
 <20260508154400.GC2241589@frogsfrogsfrogs>
 <4a4dda92-4c60-471f-8afc-6afa68d06f2c@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a4dda92-4c60-471f-8afc-6afa68d06f2c@bsbernd.com>

On Fri, May 08, 2026 at 06:44:25PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/8/26 17:44, Darrick J. Wong wrote:
> > On Fri, May 08, 2026 at 12:43:14PM +0200, Bernd Schubert wrote:
> >>
> >>
> >> On 5/8/26 00:13, Darrick J. Wong wrote:
> >>> From: Darrick J. Wong <djwong@kernel.org>
> >>>
> >>> MS_RDONLY maps to MOUNT_ATTR_RDONLY in the new fsmount API, but the
> >>> table omitted that.  Fix that.
> >>>
> >>> Fixes: 0d7e72541564a5 ("Unify mount flag structures and remove redundant is_mount_attr field")
> >>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> >>> ---
> >>>  lib/mount_util.c |    4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>>
> >>> diff --git a/lib/mount_util.c b/lib/mount_util.c
> >>> index 1a0aec9bfe1a70..7ab1dba91e28e3 100644
> >>> --- a/lib/mount_util.c
> >>> +++ b/lib/mount_util.c
> >>> @@ -110,8 +110,8 @@
> >>>  
> >>>  const struct mount_flags mount_flags[] = {
> >>>  /* opt            flag             on  safe  mount_attr */
> >>> -{"rw",           MS_RDONLY,        0,  1,    0},                      /* fsconfig */
> >>> -{"ro",           MS_RDONLY,        1,  1,    0},                      /* fsconfig */
> >>> +{"rw",           MS_RDONLY,        0,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
> >>> +{"ro",           MS_RDONLY,        1,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
> >>>  {"suid",         MS_NOSUID,        0,  0,    MOUNT_ATTR_NOSUID},     /* fsmount  */
> >>>  {"nosuid",       MS_NOSUID,        1,  1,    MOUNT_ATTR_NOSUID},     /* fsmount  */
> >>>  {"dev",          MS_NODEV,         0,  1,    MOUNT_ATTR_NODEV},      /* fsmount  */
> >>>
> >>
> >> Hi Darrick,
> >>
> >> I had already pulled this the night before and it fails the new tests as
> >> well. I think issue is that ro needs to be done via fsmount(...,
> >> MOUNT_ATTR_RDONLY) *and* fsconfig(SET_FLAG, "ro"). I'm going to add a
> >> new column into const struct mount_flags mount_flags[].
> > 
> > Ewww, you're right.  util-linux also special-cases this, and in a weird
> > way:
> > 
> >        Since version 2.41, libmount has the ability to use optional
> >        arguments vfs and fs (e.g. ro=fs) to specify where the read-only
> >        setting should be applied. For example, using the command:
> > 
> >           mount -o ro=vfs /dev/sdc1 /A
> > 
> >        will mount the filesystem as read-write on the superblock level,
> >        but the /A node will be set as read-only. In previous versions,
> >        this required an additional "-o bind,remount,ro" operation to
> >        achieve the same result.
> > 
> > "ro=vfs" means apply it to the mount but don't tell the filesystem;
> > "ro=fs" means apply tell it to the filesystem, but not the mount;
> > and plain "ro" means apply it to both?  Apparently??
> > 
> 
> I just sent out a new patch series that fixes plain "ro". Thanks for
> looking it up in util-linux, I see "ro=vfs/fs" as new feature and

Yeah, I know.  TBH I wonder how much of the fsdevel community knows that
this was done -- I certainly would have remained ignorant if you hadn't
noticed this. :(

> already spent the entire (public holi)day on this series (there was
> another critical sync-init issue, when sync-init was actually not used).
> I.e. I'm going to ignore the "weird ways" for now.

<nod> I'm a little preoccupied with cleaning up the fuse-iomap patchsets
right now, but I'll have time to look at your fixpatches after lunch.

--D

> 
> Thanks,
> Bernd
