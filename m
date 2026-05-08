Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255802857EE;
	Fri,  8 May 2026 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263186; cv=none; b=XcB3YDyv3fjQZE9fE3zYRa47fXArBVyxUMpcHhGJRsvD4BVmSXUu9uXKq0xi1ugIrLMkI0ya675yPH1Q8g2goE3DeYc96m/XqfiNU84elKggNSM9JVYOTE28E+wAkVIgRaREN6fIdqq1HSQ/k2fTaCa3p24u4hBC2VPzvamDv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263186; c=relaxed/simple;
	bh=gatNClLZL9QgFANDBhG0hyiMVGWwiq4u3yUV2zU/oKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3AvtmZrfwzRiiuBymeH1E5WUqy5XekjQabtEpR/FxtSzPUjJVXnUa15zZ5EliDysCZjyqTrCs+uVGlzu0GKMQBWEBfhZrYZuZRjTRrfss7KLII2ehTt11pZecjzVbeUIiIzsbQmdNKRmEDsHc3nKoeUR6YZw369ut8NQ3S6h+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsAntoyE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsAntoyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D8CC2BCB0;
	Fri,  8 May 2026 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778263185;
	bh=gatNClLZL9QgFANDBhG0hyiMVGWwiq4u3yUV2zU/oKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DsAntoyE4NIrSkNaCi0kDY6cv7l05GedlxDY2BE13kk+3u9CgWI5Sq+2v50UeSteP
	 5pC1rCQC5sWtIcwyoLvKgaYNR2Gtl6folOitQ1GzQ8t2e7VOxnG8WzcqlBQGua1X9V
	 5YTtQU02NRAvD279kuY+TJo0NkPr9lSeqT6w7GeeoHBpfkgOV0fajZvNYXO6V8O2gJ
	 3ADs3Sv1YStKJV0xn3U6K2r7GqjTSxLrrjSDOszSvmETGvndl/srrPyC2rYYYotdyM
	 d/xzKJDzyjQ4ZHdI7yE4ohDhb6AXjWaaosnM9lCicoEAYtvLgpiuzsxDBOTGL2v3x7
	 tBalW0MGGNx/w==
Date: Fri, 8 May 2026 10:59:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
	neal@gompa.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] mount_service: use the mount_flags table instead of
 declaring our own
Message-ID: <20260508175945.GE2241589@frogsfrogsfrogs>
References: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
 <177819198067.3490792.2943381236495611249.stgit@frogsfrogsfrogs>
 <45b102f5-423f-40de-887a-a54772a8504b@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b102f5-423f-40de-887a-a54772a8504b@bsbernd.com>

On Fri, May 08, 2026 at 06:51:45PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/8/26 00:14, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Use the canonical mount flags table in mount_util.c instead of
> > opencoding our own version in mount_service.c.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  util/mount_service.c |   51 +++++++++++++-------------------------------------
> >  1 file changed, 13 insertions(+), 38 deletions(-)
> > 
> > 
> > diff --git a/util/mount_service.c b/util/mount_service.c
> > index 8c9747b3928a51..79e5b060ba3356 100644
> > --- a/util/mount_service.c
> > +++ b/util/mount_service.c
> > @@ -1457,73 +1457,48 @@ struct ms_to_mount_map {
> >  	unsigned int mount_attr_flag;
> >  };
> >  
> > -static const struct ms_to_mount_map attrs[] = {
> > -	{ MS_RDONLY,		MOUNT_ATTR_RDONLY },
> > -	{ MS_NOSUID,		MOUNT_ATTR_NOSUID },
> > -	{ MS_NODEV,		MOUNT_ATTR_NODEV },
> > -	{ MS_NOEXEC,		MOUNT_ATTR_NOEXEC },
> > -	{ MS_RELATIME,		MOUNT_ATTR_RELATIME },
> > -	{ MS_NOATIME,		MOUNT_ATTR_NOATIME },
> > -	{ MS_STRICTATIME,	MOUNT_ATTR_STRICTATIME },
> > -	{ MS_NODIRATIME,	MOUNT_ATTR_NODIRATIME },
> > -#ifdef MOUNT_ATTR_NOSYMFOLLOW
> > -	{ MS_NOSYMFOLLOW,	MOUNT_ATTR_NOSYMFOLLOW },
> > -#endif
> > -	{ 0, 0 },
> > -};
> > -
> >  static void get_mount_attr_flags(const struct fuse_service_mount_command *oc,
> >  				 unsigned int *attr_flags,
> >  				 unsigned long *leftover_ms_flags)
> >  {
> > -	const struct ms_to_mount_map *i;
> > +	const struct mount_flags *i;
> >  	unsigned int ms_flags = ntohl(oc->ms_flags);
> >  	unsigned int mount_attr_flags = 0;
> >  
> > -	for (i = attrs; i->ms_flag != 0; i++) {
> > -		if (ms_flags & i->ms_flag)
> > -			mount_attr_flags |= i->mount_attr_flag;
> > -		ms_flags &= ~i->ms_flag;
> > +	for (i = mount_flags; i->opt != NULL; i++) {
> > +		if (!i->on || !(ms_flags & i->flag))
> > +			continue;
> > +
> > +		mount_attr_flags |= i->mount_attr;
> > +		ms_flags &= ~i->flag;
> >  	}
> >  
> >  	*leftover_ms_flags = ms_flags;
> >  	*attr_flags = mount_attr_flags;
> >  }
> >  
> > -struct ms_to_str_map {
> > -	unsigned long ms_flag;
> > -	const char *string;
> > -};
> > -
> > -static const struct ms_to_str_map strflags[] = {
> > -	{ MS_SYNCHRONOUS,	"sync" },
> > -	{ MS_DIRSYNC,		"dirsync" },
> > -	{ MS_LAZYTIME,		"lazytime" },
> > -	{ 0, 0 },
> > -};
> > -
> >  static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
> >  {
> > -	const struct ms_to_str_map *i;
> > +	const struct mount_flags *i;
> >  	int ret;
> >  
> > -	for (i = strflags; i->ms_flag != 0; i++) {
> > -		if (!(ms_flags & i->ms_flag))
> > +	for (i = mount_flags; i->opt != NULL; i++) {
> > +		if (!i->on || !(ms_flags & i->flag))
> >  			continue;
> >  
> > -		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
> > +		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->opt,
> >  			       NULL, 0);
> >  		if (ret) {
> >  			int error = errno;
> >  
> >  			fprintf(stderr, "%s: set %s option: %s\n",
> > -				mo->msgtag, i->string, strerror(error));
> > +				mo->msgtag, i->opt, strerror(error));
> >  			emit_fsconfig_messages(mo);
> >  
> >  			errno = error;
> >  			return -1;
> >  		}
> > -		ms_flags &= ~i->ms_flag;
> > +		ms_flags &= ~i->flag;
> >  	}
> >  
> >  	/*
> > 
> > 
> 
> 
> Hi Darrick,
> 
> wouldn't it make sense to use the functions from mount_fsmount.c? I can
> also clean this up later if you want.

Oh, hah!  Yes, I'll revise this patch to use them.

> I guess this doesn't handle the case for "ro" going into fsmount() and
> fsconfig() yet - update now or later?

That'll become another fix patch for mount_service.c.

--D

> 
> Thanks,
> Bernd
> 
> 
> 
> 
