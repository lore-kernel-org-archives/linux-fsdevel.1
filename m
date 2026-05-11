Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CC73033EA;
	Mon, 11 May 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512931; cv=none; b=dBgWb9TKaB2OkGvmXqDar0GFknhxPtsDKfx16IJ6rdQDfSyE4DlrJaQ1B0xhc+2vbsHmBGFAw2NfvJRMoOQwtjDZ5mXnMAyHUMtJZl8dHrDkGIgV5LvJ9cqOS5nATw3zzVOK5OqfUl7JwPXCNhIQA3HURh0OyKZKIA7ZhpgeZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512931; c=relaxed/simple;
	bh=ZCod6X+9qIqYRkA8HlrdAWffVWx700wF1GVfjKOVSqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RotQ2OEkm/yOrVXMhT0CotYlouhfoEY+yVQISKqbvRnMY2vJYUmC0nbFxFTqgLsChVhsxTy2pN2tvP+HHeIEDsJtn20dj8sgsk3ouX6rSBBpMUi2guPmib3HbROOhs+iJPgP/kNuZ+h91UqWfhqoH/ybb/UwqDawbcOf7qLGOZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/M4hk3L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/M4hk3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E403C2BCB0;
	Mon, 11 May 2026 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778512930;
	bh=ZCod6X+9qIqYRkA8HlrdAWffVWx700wF1GVfjKOVSqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l/M4hk3L4k2j2vAqn6b702InKrLEKCZOwe7Q9MbQzNdOCs+OhTO8kAhjBSOHQJDA5
	 Lal99skTfnqV/TzMjM48vfq+HPKYzYNdPdEIjftANKgBMRgxaET/7ZDhZKdUE48S0e
	 bfhbRwiZkwz5b0BY7ernfKuvcQ8Knk3hkIuEQk2mDz818Qad/kM73DmgTm2Hu4Uvt8
	 WMG5YJ4UzG1nygXRmKIIz4widM5ko6ND8mKGdWWcartd4Z5JP44rhfQXC8Oa94HRBl
	 /P0sUJnLvvAWvdp1brNKSYEy0+bzgSdpBd7zj1HFP2rDhpP97CppW4FhLCF3Rv8E6B
	 vznshJ+sL3kvw==
Date: Mon, 11 May 2026 08:22:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
	neal@gompa.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] mount_service: use the mount_flags table instead of
 declaring our own
Message-ID: <20260511152210.GG7739@frogsfrogsfrogs>
References: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
 <177819198067.3490792.2943381236495611249.stgit@frogsfrogsfrogs>
 <45b102f5-423f-40de-887a-a54772a8504b@bsbernd.com>
 <20260508175945.GE2241589@frogsfrogsfrogs>
 <20260509004851.GF7739@frogsfrogsfrogs>
 <37d55a0c-7358-455d-9552-c621160bb269@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d55a0c-7358-455d-9552-c621160bb269@bsbernd.com>

On Sat, May 09, 2026 at 09:42:12AM +0200, Bernd Schubert wrote:
> 
> 
> On 5/9/26 02:48, Darrick J. Wong wrote:
> > On Fri, May 08, 2026 at 10:59:45AM -0700, Darrick J. Wong wrote:
> >> On Fri, May 08, 2026 at 06:51:45PM +0200, Bernd Schubert wrote:
> >>>
> >>>
> >>> On 5/8/26 00:14, Darrick J. Wong wrote:
> >>>> From: Darrick J. Wong <djwong@kernel.org>
> >>>>
> >>>> Use the canonical mount flags table in mount_util.c instead of
> >>>> opencoding our own version in mount_service.c.
> >>>>
> >>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >>>> ---
> >>>>  util/mount_service.c |   51 +++++++++++++-------------------------------------
> >>>>  1 file changed, 13 insertions(+), 38 deletions(-)
> >>>>
> >>>>
> >>>> diff --git a/util/mount_service.c b/util/mount_service.c
> >>>> index 8c9747b3928a51..79e5b060ba3356 100644
> >>>> --- a/util/mount_service.c
> >>>> +++ b/util/mount_service.c
> >>>> @@ -1457,73 +1457,48 @@ struct ms_to_mount_map {
> >>>>  	unsigned int mount_attr_flag;
> >>>>  };
> >>>>  
> >>>> -static const struct ms_to_mount_map attrs[] = {
> >>>> -	{ MS_RDONLY,		MOUNT_ATTR_RDONLY },
> >>>> -	{ MS_NOSUID,		MOUNT_ATTR_NOSUID },
> >>>> -	{ MS_NODEV,		MOUNT_ATTR_NODEV },
> >>>> -	{ MS_NOEXEC,		MOUNT_ATTR_NOEXEC },
> >>>> -	{ MS_RELATIME,		MOUNT_ATTR_RELATIME },
> >>>> -	{ MS_NOATIME,		MOUNT_ATTR_NOATIME },
> >>>> -	{ MS_STRICTATIME,	MOUNT_ATTR_STRICTATIME },
> >>>> -	{ MS_NODIRATIME,	MOUNT_ATTR_NODIRATIME },
> >>>> -#ifdef MOUNT_ATTR_NOSYMFOLLOW
> >>>> -	{ MS_NOSYMFOLLOW,	MOUNT_ATTR_NOSYMFOLLOW },
> >>>> -#endif
> >>>> -	{ 0, 0 },
> >>>> -};
> >>>> -
> >>>>  static void get_mount_attr_flags(const struct fuse_service_mount_command *oc,
> >>>>  				 unsigned int *attr_flags,
> >>>>  				 unsigned long *leftover_ms_flags)
> >>>>  {
> >>>> -	const struct ms_to_mount_map *i;
> >>>> +	const struct mount_flags *i;
> >>>>  	unsigned int ms_flags = ntohl(oc->ms_flags);
> >>>>  	unsigned int mount_attr_flags = 0;
> >>>>  
> >>>> -	for (i = attrs; i->ms_flag != 0; i++) {
> >>>> -		if (ms_flags & i->ms_flag)
> >>>> -			mount_attr_flags |= i->mount_attr_flag;
> >>>> -		ms_flags &= ~i->ms_flag;
> >>>> +	for (i = mount_flags; i->opt != NULL; i++) {
> >>>> +		if (!i->on || !(ms_flags & i->flag))
> >>>> +			continue;
> >>>> +
> >>>> +		mount_attr_flags |= i->mount_attr;
> >>>> +		ms_flags &= ~i->flag;
> >>>>  	}
> >>>>  
> >>>>  	*leftover_ms_flags = ms_flags;
> >>>>  	*attr_flags = mount_attr_flags;
> >>>>  }
> >>>>  
> >>>> -struct ms_to_str_map {
> >>>> -	unsigned long ms_flag;
> >>>> -	const char *string;
> >>>> -};
> >>>> -
> >>>> -static const struct ms_to_str_map strflags[] = {
> >>>> -	{ MS_SYNCHRONOUS,	"sync" },
> >>>> -	{ MS_DIRSYNC,		"dirsync" },
> >>>> -	{ MS_LAZYTIME,		"lazytime" },
> >>>> -	{ 0, 0 },
> >>>> -};
> >>>> -
> >>>>  static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
> >>>>  {
> >>>> -	const struct ms_to_str_map *i;
> >>>> +	const struct mount_flags *i;
> >>>>  	int ret;
> >>>>  
> >>>> -	for (i = strflags; i->ms_flag != 0; i++) {
> >>>> -		if (!(ms_flags & i->ms_flag))
> >>>> +	for (i = mount_flags; i->opt != NULL; i++) {
> >>>> +		if (!i->on || !(ms_flags & i->flag))
> >>>>  			continue;
> >>>>  
> >>>> -		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
> >>>> +		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->opt,
> >>>>  			       NULL, 0);
> >>>>  		if (ret) {
> >>>>  			int error = errno;
> >>>>  
> >>>>  			fprintf(stderr, "%s: set %s option: %s\n",
> >>>> -				mo->msgtag, i->string, strerror(error));
> >>>> +				mo->msgtag, i->opt, strerror(error));
> >>>>  			emit_fsconfig_messages(mo);
> >>>>  
> >>>>  			errno = error;
> >>>>  			return -1;
> >>>>  		}
> >>>> -		ms_flags &= ~i->ms_flag;
> >>>> +		ms_flags &= ~i->flag;
> >>>>  	}
> >>>>  
> >>>>  	/*
> >>>>
> >>>>
> >>>
> >>>
> >>> Hi Darrick,
> >>>
> >>> wouldn't it make sense to use the functions from mount_fsmount.c? I can
> >>> also clean this up later if you want.
> >>
> >> Oh, hah!  Yes, I'll revise this patch to use them.
> > 
> > Update: I tried this, but ran into a problem: the two helpers are in
> > lib/mount_fsmount.c, which means the object code ends up in libfuse.so.
> > Unfortunately, that means that util/mount_service.c can't use them
> > unless they're exported from the .so.
> > 
> > I don't mind doing that, but I feel that I should check with you if it's
> > ok to add that to the public libfuse API before doing that?
> > 
> > Though I think a better solution is to move ms_flags_to_mount_attrs and
> > set_ms_flags to mount_util.c because that's compiled into the util/
> > programs.
> > 
> > How about I do that second thing on Monday?
> 
> 
> I would prefer the 3rd option, like for fusermount3
> 
> executable('fusermount3', ['fusermount.c', '../lib/mount_util.c',
> '../lib/mount_fsmount.c', '../lib/util.c'],
> 
> 
> I.e. add lib/mount_fsmount.c to mount_service_sources.

That works, will put together a patch to do that. :)

--D

> 
> Thanks,
> Bernd
> 
