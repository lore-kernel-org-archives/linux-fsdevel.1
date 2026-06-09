Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524A2222D0;
	Tue,  9 Jun 2026 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964421; cv=none; b=Bp/2k7RPtw2/dlTYIEjccRJaJHfpUfUwS33x7gk5BbnXbCqAcjkH7NdTyBnBadbShs5T2WdymXi1dgPwK0QmtYhtjehj8nUVrmYc3yThbNpu0PcIvph3SK5VhGJq32keh18ErUtMChR4+DDoDeEqJ7I6FPpsrdxBIOOSyP7AQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964421; c=relaxed/simple;
	bh=DqRsDzrsjByObsaR6dzGhjeRVxCmvLT0ZFvQSGhNQ20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyBzq/8LKsPM4//KnMfqu1Mv023NDZ3CvoUS9xa8gBk6WTOju4t0oYdqBGCGfMxNPUnq/C3jkoZY5tE4NYAViRQR/ns0KgBSAz0S9VSnf3VxbwZdNm7IVi1zuhiVpFoXvjihKii3X05E3ndThwjdoMJ2tJN+RQBxkGZ9zmqM2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knVMtIlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knVMtIlG"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3C9C91F00893;
	Tue,  9 Jun 2026 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780964420;
	bh=n5jOMGeJ7Fd7mfxqMbVq+/DE1zg2tqCsfzxWBtGA1hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=knVMtIlGD3Z50LK83AZRpDL8VIXmQM/iE6TyvN21kKujqvNBsiF79M1nDJvM74WA7
	 C3VjqFoBl3qJ02TgQGZ1SZOFaueSTaysTkvgWoX5ULFYUx3RKLSZ2BY7c+//Wa3uFb
	 LzDcdar9Ho8aHNErkEAX2JToMZikZVQwfRU99wZVQHTFBjShY3EyVICNw82ymFSp8H
	 Q6HxdB8isg5m90P6KmmR5PJ7nuI8mjUhe3LZWydV/pD0/gpFKPg0JYwE1WRRSBY3Jt
	 ZBSAC7a0nDHuaMQtf9bWFwBLLJzTStUPeeiSQ07b6xCZKJuG1HoJNQxcxPBkKkTEI8
	 nRG2fkSxm6dWQ==
Date: Mon, 8 Jun 2026 17:20:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 2/6] mount_service: don't pass the chopped buffer to
 apply_fsconfig_mount_opts
Message-ID: <20260609002019.GO6095@frogsfrogsfrogs>
References: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
 <178044567862.1435997.14889132979032394431.stgit@frogsfrogsfrogs>
 <a36689e2-705f-4311-a04e-55462fee1713@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36689e2-705f-4311-a04e-55462fee1713@bsbernd.com>

On Sun, Jun 07, 2026 at 09:36:30PM +0200, Bernd Schubert wrote:
> 
> 
> On 6/3/26 02:15, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > If mount_service_handle_mntopts_cmd previously looked at the mount
> > options to screen for allow_{other,root}, then tokstr (aka oc->value)
> > has been modified and not put back.  This causes truncation of the mount
> > options passed to fsconfig, so let's use the snapshot that we took
> > previously.  Codex noticed this.
> > 
> > Fixes: 7211953256526f ("mount_service: use the fsmount API helpers from mount_fsmount.c")
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  util/mount_service.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > 
> > diff --git a/util/mount_service.c b/util/mount_service.c
> > index adcc7a296645ff..360a78bab3bd3d 100644
> > --- a/util/mount_service.c
> > +++ b/util/mount_service.c
> > @@ -994,7 +994,7 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
> >  
> >  #ifdef HAVE_NEW_MOUNT_API
> >  	if (mo->fsopenfd >= 0) {
> > -		int ret = apply_fsconfig_mount_opts(mo->fsopenfd, oc->value);
> > +		int ret = apply_fsconfig_mount_opts(mo->fsopenfd, mntopts);
> 
> Btw, what does "oc" stand for? I would have probably called it "cmd".

Nothing in particular; it got copied from mount_service_handle_open_cmd
into all the other dispatch functions.  But I guess you could think of
it as "outer command", aka the structure that wraps the struct
fuse_service_packet.

--D

> Thanks,
> Bernd
