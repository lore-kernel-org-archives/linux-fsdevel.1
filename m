Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D73442B75D;
	Mon, 11 May 2026 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516676; cv=none; b=D+G1eJh5orHM2fXe7tyAmBSWDhapp0DgNdsWP8YZgrtbrXMLKGOTKplo1eSQ7I9krG+gpjNo3feGNOKviuve0zILiWNENNVm0zTYM9hk9e6c8CR+8rHG/rYVIACe7egZrqWusqXNG7xhPCye5gdjeFpmXF8zAQGhNXbeOAaoJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516676; c=relaxed/simple;
	bh=UKNn7tsUPRgXmD+x1uG9z2qtp+bfT80iqcbLwE6zXYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXAfr2Hw6/QwZ7VwfySWxf8tqatNIkS/7IgZr1I7TOatVhd1liRESZvzU8lcCaTMq54cAB9XFyQ7rKlAuM2ewTidJm+UF2SbGVOwmeXW9di6J/tn0750ybwK4R8aoIiw+vZ9KoU3NvdX8dIKvt2UxTfzA87ddeN+WjOL+CJEDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMnmOiV7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMnmOiV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D4DC2BCB0;
	Mon, 11 May 2026 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516675;
	bh=UKNn7tsUPRgXmD+x1uG9z2qtp+bfT80iqcbLwE6zXYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMnmOiV7lFTlwmGLDEciZ0u2ikSYfA+R07Z5q8TToxCkZLGUnYNaXW0O0iddAWYmV
	 uf0GmmzXEEGMY6Vcf+a6Lv5733LKLbW/zlqlAiPDOcrz0MZjTFFcDSzLCB5qJRf/Gk
	 E5c1fXqLGdMC3v80Omhg0m0TbGdiasiDnNpWJugiWnWqs062wgil7dyrvpkBdMHedr
	 arDuoIDQJl/AIxMNAUWef69Emj3SSHEHubu2AnaT4eUH2DdIUCF9j8RD9MmqRQswN9
	 SEGQge7hjbjj0SaaYw/mBJ3BVECQU+Em/HeoAo8AA0hFWgBn0MKS9e+1zPFCQJVeNy
	 +deusBhcj4nOA==
Date: Mon, 11 May 2026 09:24:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
	neal@gompa.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] mount_service: use the mount_flags table instead of
 declaring our own
Message-ID: <20260511162434.GH7739@frogsfrogsfrogs>
References: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
 <177819198067.3490792.2943381236495611249.stgit@frogsfrogsfrogs>
 <45b102f5-423f-40de-887a-a54772a8504b@bsbernd.com>
 <20260508175945.GE2241589@frogsfrogsfrogs>
 <20260509004851.GF7739@frogsfrogsfrogs>
 <37d55a0c-7358-455d-9552-c621160bb269@bsbernd.com>
 <20260511152210.GG7739@frogsfrogsfrogs>
 <1f30f0f7-5900-4cc6-951e-8762ce312ba1@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f30f0f7-5900-4cc6-951e-8762ce312ba1@bsbernd.com>

On Mon, May 11, 2026 at 05:58:36PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/11/26 17:22, Darrick J. Wong wrote:
> > On Sat, May 09, 2026 at 09:42:12AM +0200, Bernd Schubert wrote:
> >>
> >>
> >> On 5/9/26 02:48, Darrick J. Wong wrote:
> >>> On Fri, May 08, 2026 at 10:59:45AM -0700, Darrick J. Wong wrote:
> >>>> On Fri, May 08, 2026 at 06:51:45PM +0200, Bernd Schubert wrote:
> >>>>>
> >>>>>
> >>>>> On 5/8/26 00:14, Darrick J. Wong wrote:
> >>>>>> From: Darrick J. Wong <djwong@kernel.org>
> >>>>>>
> >>>>>> Use the canonical mount flags table in mount_util.c instead of
> >>>>>> opencoding our own version in mount_service.c.
> >>>>>>
> >>>>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >>>>>> ---
> >>>>>>  util/mount_service.c |   51 +++++++++++++-------------------------------------
> >>>>>>  1 file changed, 13 insertions(+), 38 deletions(-)
> >>>>>>
> >>>>>>
> >>>>>> diff --git a/util/mount_service.c b/util/mount_service.c
> >>>>>> index 8c9747b3928a51..79e5b060ba3356 100644
> >>>>>> --- a/util/mount_service.c
> >>>>>> +++ b/util/mount_service.c
> >>>>>> @@ -1457,73 +1457,48 @@ struct ms_to_mount_map {
> >>>>>>  	unsigned int mount_attr_flag;
> >>>>>>  };
> >>>>>>  
> >>>>>> -static const struct ms_to_mount_map attrs[] = {
> >>>>>> -	{ MS_RDONLY,		MOUNT_ATTR_RDONLY },
> >>>>>> -	{ MS_NOSUID,		MOUNT_ATTR_NOSUID },
> >>>>>> -	{ MS_NODEV,		MOUNT_ATTR_NODEV },
> >>>>>> -	{ MS_NOEXEC,		MOUNT_ATTR_NOEXEC },
> >>>>>> -	{ MS_RELATIME,		MOUNT_ATTR_RELATIME },
> >>>>>> -	{ MS_NOATIME,		MOUNT_ATTR_NOATIME },
> >>>>>> -	{ MS_STRICTATIME,	MOUNT_ATTR_STRICTATIME },
> >>>>>> -	{ MS_NODIRATIME,	MOUNT_ATTR_NODIRATIME },
> >>>>>> -#ifdef MOUNT_ATTR_NOSYMFOLLOW
> >>>>>> -	{ MS_NOSYMFOLLOW,	MOUNT_ATTR_NOSYMFOLLOW },
> >>>>>> -#endif
> >>>>>> -	{ 0, 0 },
> >>>>>> -};
> >>>>>> -
> >>>>>>  static void get_mount_attr_flags(const struct fuse_service_mount_command *oc,
> >>>>>>  				 unsigned int *attr_flags,
> >>>>>>  				 unsigned long *leftover_ms_flags)
> >>>>>>  {
> >>>>>> -	const struct ms_to_mount_map *i;
> >>>>>> +	const struct mount_flags *i;
> >>>>>>  	unsigned int ms_flags = ntohl(oc->ms_flags);
> >>>>>>  	unsigned int mount_attr_flags = 0;
> >>>>>>  
> >>>>>> -	for (i = attrs; i->ms_flag != 0; i++) {
> >>>>>> -		if (ms_flags & i->ms_flag)
> >>>>>> -			mount_attr_flags |= i->mount_attr_flag;
> >>>>>> -		ms_flags &= ~i->ms_flag;
> >>>>>> +	for (i = mount_flags; i->opt != NULL; i++) {
> >>>>>> +		if (!i->on || !(ms_flags & i->flag))
> >>>>>> +			continue;
> >>>>>> +
> >>>>>> +		mount_attr_flags |= i->mount_attr;
> >>>>>> +		ms_flags &= ~i->flag;
> >>>>>>  	}
> >>>>>>  
> >>>>>>  	*leftover_ms_flags = ms_flags;
> >>>>>>  	*attr_flags = mount_attr_flags;
> >>>>>>  }
> >>>>>>  
> >>>>>> -struct ms_to_str_map {
> >>>>>> -	unsigned long ms_flag;
> >>>>>> -	const char *string;
> >>>>>> -};
> >>>>>> -
> >>>>>> -static const struct ms_to_str_map strflags[] = {
> >>>>>> -	{ MS_SYNCHRONOUS,	"sync" },
> >>>>>> -	{ MS_DIRSYNC,		"dirsync" },
> >>>>>> -	{ MS_LAZYTIME,		"lazytime" },
> >>>>>> -	{ 0, 0 },
> >>>>>> -};
> >>>>>> -
> >>>>>>  static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
> >>>>>>  {
> >>>>>> -	const struct ms_to_str_map *i;
> >>>>>> +	const struct mount_flags *i;
> >>>>>>  	int ret;
> >>>>>>  
> >>>>>> -	for (i = strflags; i->ms_flag != 0; i++) {
> >>>>>> -		if (!(ms_flags & i->ms_flag))
> >>>>>> +	for (i = mount_flags; i->opt != NULL; i++) {
> >>>>>> +		if (!i->on || !(ms_flags & i->flag))
> >>>>>>  			continue;
> >>>>>>  
> >>>>>> -		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
> >>>>>> +		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->opt,
> >>>>>>  			       NULL, 0);
> >>>>>>  		if (ret) {
> >>>>>>  			int error = errno;
> >>>>>>  
> >>>>>>  			fprintf(stderr, "%s: set %s option: %s\n",
> >>>>>> -				mo->msgtag, i->string, strerror(error));
> >>>>>> +				mo->msgtag, i->opt, strerror(error));
> >>>>>>  			emit_fsconfig_messages(mo);
> >>>>>>  
> >>>>>>  			errno = error;
> >>>>>>  			return -1;
> >>>>>>  		}
> >>>>>> -		ms_flags &= ~i->ms_flag;
> >>>>>> +		ms_flags &= ~i->flag;
> >>>>>>  	}
> >>>>>>  
> >>>>>>  	/*
> >>>>>>
> >>>>>>
> >>>>>
> >>>>>
> >>>>> Hi Darrick,
> >>>>>
> >>>>> wouldn't it make sense to use the functions from mount_fsmount.c? I can
> >>>>> also clean this up later if you want.
> >>>>
> >>>> Oh, hah!  Yes, I'll revise this patch to use them.
> >>>
> >>> Update: I tried this, but ran into a problem: the two helpers are in
> >>> lib/mount_fsmount.c, which means the object code ends up in libfuse.so.
> >>> Unfortunately, that means that util/mount_service.c can't use them
> >>> unless they're exported from the .so.
> >>>
> >>> I don't mind doing that, but I feel that I should check with you if it's
> >>> ok to add that to the public libfuse API before doing that?
> >>>
> >>> Though I think a better solution is to move ms_flags_to_mount_attrs and
> >>> set_ms_flags to mount_util.c because that's compiled into the util/
> >>> programs.
> >>>
> >>> How about I do that second thing on Monday?
> >>
> >>
> >> I would prefer the 3rd option, like for fusermount3
> >>
> >> executable('fusermount3', ['fusermount.c', '../lib/mount_util.c',
> >> '../lib/mount_fsmount.c', '../lib/util.c'],
> >>
> >>
> >> I.e. add lib/mount_fsmount.c to mount_service_sources.
> > 
> > That works, will put together a patch to do that. :)
> 
> Hi Darrick,
> 
> I didn't manage yesterday anymore to work on that, the container branch
> is in a total merge conflict with libfuse master. If you want you could
> continue on the iomap and I would solve the merge conflicts. Though,
> probably not today or tomorrow.

I don't mind trying to resolving the conflict, and will work on that
this afternoon.  I'll report back whatever the outcome of that is.

--D
