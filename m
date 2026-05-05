Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C948C8CC;
	Tue,  5 May 2026 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999104; cv=none; b=g/rrKB5oc7OV06eiFAmKUrikMeYYo8eG8rQSMMDovh2JUNbcc+MY4vav+L2pn4ohSbYa+E8Fr6WpjIrBvdxfVWvdi5iZB2WJlBmN3A8Ya90wSHBdguVF9Wnxix8ntQCUNU/jngUCUaosUh236Ve0vOVPhkL6eCsrBFkt5H1o9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999104; c=relaxed/simple;
	bh=CEJUEhi4GebLQMwAuNoV+9ZZmtfw+cenrqexC157EhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5+fCFD5v/Avf3+Mx+9xK46r692ylgw/c5d7gx3ASlpNSiTvEunNu9YLtJGdZjI746uD759gz4b0iM0cG6LOLFG65D9En3C4t3zKiVDTls8yleeK9kr8vaLUFpNNbyvaAwSk08GCN8GHc9Ci+NdZmEL5DkUSY7zxMfdQDvDsfEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxvN78/V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxvN78/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D33BC2BCF4;
	Tue,  5 May 2026 16:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777999104;
	bh=CEJUEhi4GebLQMwAuNoV+9ZZmtfw+cenrqexC157EhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxvN78/VMN6+D6N3hjxXWIR1aQpn9wSA35igMEiXAzfmAj2pUQOlhPlxf5/TG5sno
	 4yElhWui5GxPrLSIAyfnzQUGnBli7dPRnBCv6yOfsci1bclPX5PyitdXnZPgSz7Hs4
	 bwsuZUoT/W65ZTd4pSWHaGkDkVh1iW8nneP35PbcJpnAnkeDMR8vV7YmJd4YZGafZZ
	 GCpwrOHqM9mBwee+MYKmYT5DaTn3CCXlefhXNDJidl/g3xMXJ+cAh6KYKg0uJg9fiN
	 rVU98iXXn8ErGoCEaKZVAamvhuDKLCBHNHskWo6adbdc/Z505HU1kH3prTB5Yv9TSH
	 vT4VQtFox6u4g==
Date: Tue, 5 May 2026 09:38:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Subject: Re: [PATCH 2/2] libfuse: always send the subtype to the kernel when
 using fsconfig()
Message-ID: <20260505163823.GB7739@frogsfrogsfrogs>
References: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
 <177795853491.1133476.14673788941960394877.stgit@frogsfrogsfrogs>
 <3b37a5be-c3c8-461d-8382-04ae86de81cc@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b37a5be-c3c8-461d-8382-04ae86de81cc@bsbernd.com>

On Tue, May 05, 2026 at 09:41:59AM +0200, Bernd Schubert wrote:
> 
> 
> On 5/5/26 07:23, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Although it's possible to supply a filesystem subtype when calling
> > fsopen(), it does not pass the stuff after the dot to the mount option
> > parsing mechanism like the legacy mount() call does.  Therefore, it's
> > necessary to pass the subtype explicitly via fsconfig() or else the
> > subtype will be missing from the /proc/mounts output.
> > 
> > For example, fuse4fs with the old mount API produces this:
> > 
> > /dev/sda /mnt fuse.ext4 rw,nosuid,nodev,relatime,user_id=0,group_id=0 0 0
> > 
> > But with the new mount API, we only get:
> > 
> > /dev/sda /mnt fuse rw,nosuid,nodev,relatime,user_id=0,group_id=0 0 0
> > 
> > ...which breaks fstests, which requires the fsname to match the string
> > that it passes to mount -t.  Update the comment in mount_service.c to
> > match this requirement.
> > 
> > Fixes: 14cb7b93bb9688 ("Add support for the new linux mount API")
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  lib/mount_fsmount.c  |   13 +++++++++++++
> >  util/mount_service.c |    3 ++-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > 
> > diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
> > index 615271b09758c3..5e13b34ccfc610 100644
> > --- a/lib/mount_fsmount.c
> > +++ b/lib/mount_fsmount.c
> > @@ -359,6 +359,19 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
> >  		goto out_free;
> >  	}
> >  
> > +	/* Configure subtype */
> > +	if (subtype) {
> > +		res = fsconfig(fsfd, FSCONFIG_SET_STRING, "subtype",
> > +			       subtype, 0);
> > +		if (res) {
> > +			err = -errno;
> > +			log_fsconfig_kmsg(fsfd);
> > +			fprintf(stderr, "fuse: fsconfig subtype failed: %s\n",
> > +				strerror(-err));
> > +			goto out_free;
> > +		}
> > +	}
> > +
> >  	/* Configure source */
> >  	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", source, 0);
> >  	if (res == -1) {
> 
> Oh yes, that had slipped through. Going to apply this.

Thanks!

> > diff --git a/util/mount_service.c b/util/mount_service.c
> > index bc5940bc900dad..3fbabfdd69300d 100644
> > --- a/util/mount_service.c
> > +++ b/util/mount_service.c
> > @@ -821,7 +821,8 @@ static void try_fsopen(struct mount_service *mo)
> >  	/*
> >  	 * As of Linux 7.0 you can pass subtypes to fsopen, but the manpage for
> >  	 * fsopen only says that you can pass any value of the second column of
> > -	 * /proc/filesystems into fsopen.
> > +	 * /proc/filesystems into fsopen.  You must still call fsconfig() for
> > +	 * the subtype separately, however.
> >  	 */
> >  	mo->fsopenfd = fsopen(fsname(mo), FSOPEN_CLOEXEC);
> >  }
> > 
> 
> Can we integrate that into you series separately, as it is not merged yet?

I'll separate this hunk into a separate patch.

--D

> 
> Thanks,
> Bernd
> 
