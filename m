Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBB3F7A91;
	Fri,  8 May 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255041; cv=none; b=gRwCrolJ2umfKRxnQ4qxGJPHCGUe2dcpCcT2PBmQ2uZ38CTuo1xZ+VfYmTVkkaqsX9ZgY9lCcI+kCAYH3GWpxTrUHD0PydW//aNaojGHhZBHQYsHGSQyoprdqY1PJpiLZ+1Zvk7R9WH17BqZ61wHYK/0Me1epj1DAnWAx17Fuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255041; c=relaxed/simple;
	bh=9AOlNXIYny778TcNMekmwJuTk/aseUjn7VrZd/MFhmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqX3Jfa1FXWV0bysfi0tuMjN1eBXHGq1YwzY1wbqj/gohnwxrJJA9jtMwbe9N/AnXhmHrwbTeOmt1sp7397UXsOCm5o6kw7o9RhP1PIrLnGKDWN7KFJNugf7wSVJMdw7TUp6Otgxjl16XuDbdZhw5eMXEVpGH3gezDrU6kvpd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC49CZb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC49CZb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3CBC2BCC7;
	Fri,  8 May 2026 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778255041;
	bh=9AOlNXIYny778TcNMekmwJuTk/aseUjn7VrZd/MFhmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AC49CZb8VHwLlTgHauu8hm6U1GIo/Y+NbepnD+qMx8oCRIOR0mXKOiSbj08/TDoDk
	 iHXWHNhmw3MEYUxXWa+24Mo4rHNGKkPSX3gzqvfMlm8d0fBo23Ksdt24fDkL/1HexM
	 QJhgeqfSHJRKMXX4UoksKfg5/BbzXNwvdDvDbRI4k68oQDlgk8rO9vOvK3UQZM986X
	 Aw5KEqXODRGW1SA8MIva2eBN0lGQgmvyRpQWe4VmPR/7YqerecNW6sBUnHP95wztWs
	 CaP6qZi0Tvi5VZ7HWgAdhhi6v18QZnbddbw/1ei7s3+pPOmtT98uiljfkw9EuIDy7Y
	 sG3YkxiS5oN2g==
Date: Fri, 8 May 2026 08:44:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
	neal@gompa.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] mount_util: fix mount_flags entries for MS_RDONLY
Message-ID: <20260508154400.GC2241589@frogsfrogsfrogs>
References: <177819197881.3490692.13850589276777261250.stgit@frogsfrogsfrogs>
 <177819197899.3490692.5280827494230619038.stgit@frogsfrogsfrogs>
 <6276b3d6-cc8c-4e37-b670-ff2a25c69686@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6276b3d6-cc8c-4e37-b670-ff2a25c69686@bsbernd.com>

On Fri, May 08, 2026 at 12:43:14PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/8/26 00:13, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > MS_RDONLY maps to MOUNT_ATTR_RDONLY in the new fsmount API, but the
> > table omitted that.  Fix that.
> > 
> > Fixes: 0d7e72541564a5 ("Unify mount flag structures and remove redundant is_mount_attr field")
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  lib/mount_util.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > 
> > diff --git a/lib/mount_util.c b/lib/mount_util.c
> > index 1a0aec9bfe1a70..7ab1dba91e28e3 100644
> > --- a/lib/mount_util.c
> > +++ b/lib/mount_util.c
> > @@ -110,8 +110,8 @@
> >  
> >  const struct mount_flags mount_flags[] = {
> >  /* opt            flag             on  safe  mount_attr */
> > -{"rw",           MS_RDONLY,        0,  1,    0},                      /* fsconfig */
> > -{"ro",           MS_RDONLY,        1,  1,    0},                      /* fsconfig */
> > +{"rw",           MS_RDONLY,        0,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
> > +{"ro",           MS_RDONLY,        1,  1,    MOUNT_ATTR_RDONLY},     /* fsconfig */
> >  {"suid",         MS_NOSUID,        0,  0,    MOUNT_ATTR_NOSUID},     /* fsmount  */
> >  {"nosuid",       MS_NOSUID,        1,  1,    MOUNT_ATTR_NOSUID},     /* fsmount  */
> >  {"dev",          MS_NODEV,         0,  1,    MOUNT_ATTR_NODEV},      /* fsmount  */
> > 
> 
> Hi Darrick,
> 
> I had already pulled this the night before and it fails the new tests as
> well. I think issue is that ro needs to be done via fsmount(...,
> MOUNT_ATTR_RDONLY) *and* fsconfig(SET_FLAG, "ro"). I'm going to add a
> new column into const struct mount_flags mount_flags[].

Ewww, you're right.  util-linux also special-cases this, and in a weird
way:

       Since version 2.41, libmount has the ability to use optional
       arguments vfs and fs (e.g. ro=fs) to specify where the read-only
       setting should be applied. For example, using the command:

          mount -o ro=vfs /dev/sdc1 /A

       will mount the filesystem as read-write on the superblock level,
       but the /A node will be set as read-only. In previous versions,
       this required an additional "-o bind,remount,ro" operation to
       achieve the same result.

"ro=vfs" means apply it to the mount but don't tell the filesystem;
"ro=fs" means apply tell it to the filesystem, but not the mount;
and plain "ro" means apply it to both?  Apparently??

--D
