Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD344C6D;
	Tue,  9 Jun 2026 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964250; cv=none; b=C/CgSKXDyic/Rem/f6khv7K+o7Z3wTWwVXyGOkYRvNRxYFtG3VajJieNEQxoFfhARUiifH8tzB7MYxyqCTtECAVUDR+DHgkGsGl+vIj1c1j/EKp1BMrxU4byIkGwZ7YTv9rNzcwS7U0rt9AJpcX13D5RgtJyB2G5/ALmiVfM+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964250; c=relaxed/simple;
	bh=qEBkInqQ+pWQoq2nX9RTqErYBCsMWfIvscP0cv7kgyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zs4n7j9QeqwjbvxEU1DkiMOG9Je302BJ224Ntn7xlTrS15jGgrlS3zNFj5FHPsG1AinwPUx0Hr6dKajZR3PMHQfZhQdgAZ+e5eHUAI/GQt6hO2/UfkN+Bc+UMJMdjK6W3ya4UgwL0CjMo/X4FRwodY2Fp3Pme79kIf8zyrQ6RS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxSSod/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxSSod/K"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E2E5C1F00893;
	Tue,  9 Jun 2026 00:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780964249;
	bh=d1B0q9PEE4F2yuPpcG20JornGpvJBYgJXGhP2GKo+oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nxSSod/Kfhz+pwZyv6Ej24l6ziIkGbEQ4hGIHevODF8RMZKcYdQkRTBHGK6OZSIID
	 m+xVoUDw5OSJwqmI8fiyWJGTV4o2OuwzoA9L/AdcEH5egmNygbbDA9OdmF37tNoXew
	 XE3IZTfbsVE7f73iyWIlsJkl5/EGF3PTx6K7ugDX3Lbs7PGmKaMtfp3KbR7PB+Dz2R
	 8pOTE7S9jDk71XKhXvZMsrLQiNDYs3N/GKoS7fYASKRmqrCZrgU+dYIP12EsoHz8B+
	 aBuhhjzoVrrRKEBtRD78F41FzBXqcoGXRYSzOr/L3eTH6ZbwLfE7BNX9AHBB3Otsli
	 m2+dDwusT5nbQ==
Date: Mon, 8 Jun 2026 17:17:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 6/6] mountservice: advertise fuseblk support
Message-ID: <20260609001728.GN6095@frogsfrogsfrogs>
References: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
 <178044567930.1435997.15363968498209622419.stgit@frogsfrogsfrogs>
 <0e1c9217-dfbc-4644-8e3b-994a5843a75b@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1c9217-dfbc-4644-8e3b-994a5843a75b@bsbernd.com>

On Sun, Jun 07, 2026 at 11:22:01PM +0200, Bernd Schubert wrote:
> 
> 
> On 6/3/26 02:16, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Amazingly, permission for the use of the "blkdev" mount option (aka
> > mounting with fuseblk.SUBTYPE instead of fuse.SUBTYPE) rests solely on a
> > getuid()==0 check in userspace.  That /might/ be an indication that the
> > kernel also won't allow this, but as that's the criteria, let's
> > advertise fuseblk explicitly so that a fuse server can discover the
> > capability before calling fuse_service_session_mount().
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  include/fuse_service.h      |    8 ++++++++
> >  include/fuse_service_priv.h |    4 +++-
> >  lib/fuse_service.c          |   10 ++++++++++
> >  lib/fuse_versionscript      |    1 +
> >  util/mount_service.c        |    5 ++++-
> >  5 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > 
> > diff --git a/include/fuse_service.h b/include/fuse_service.h
> > index bd89189cfe5d5b..0536312dc7120c 100644
> > --- a/include/fuse_service.h
> > +++ b/include/fuse_service.h
> > @@ -61,6 +61,14 @@ static inline bool fuse_service_accepted(const struct fuse_service *sf)
> >   */
> >  bool fuse_service_can_allow_other(const struct fuse_service *sf);
> >  
> > +/**
> > + * Will the mount service helper accept a fuseblk mount?
> > + *
> > + * @param sf service context
> > + * @return true if it will, false if not
> > + */
> > +bool fuse_service_can_fuseblk(const struct fuse_service *sf);
> > +
> >  /**
> >   * Release all resources associated with the service context.
> >   *
> > diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
> > index 8560b1ac610143..cfbc444bf5dcbd 100644
> > --- a/include/fuse_service_priv.h
> > +++ b/include/fuse_service_priv.h
> > @@ -54,8 +54,10 @@ struct fuse_service_packet {
> >  #define FUSE_SERVICE_MAX_PROTO	(1)
> >  
> >  #define FUSE_SERVICE_FLAG_ALLOW_OTHER	(1U << 0)
> > +#define FUSE_SERVICE_FLAG_FUSEBLK	(1U << 1)
> >  
> > -#define FUSE_SERVICE_FLAGS		(FUSE_SERVICE_FLAG_ALLOW_OTHER)
> > +#define FUSE_SERVICE_FLAGS		(FUSE_SERVICE_FLAG_ALLOW_OTHER | \
> > +					 FUSE_SERVICE_FLAG_FUSEBLK)
> >  
> >  struct fuse_service_hello {
> >  	struct fuse_service_packet p;
> > diff --git a/lib/fuse_service.c b/lib/fuse_service.c
> > index 7fd10211dbeab4..2d7232c3484aea 100644
> > --- a/lib/fuse_service.c
> > +++ b/lib/fuse_service.c
> > @@ -51,6 +51,9 @@ struct fuse_service {
> >  
> >  	/* can we use allow_other? */
> >  	bool allow_other;
> > +
> > +	/* can we use fuseblk? */
> > +	bool can_fuseblk;
> >  };
> >  
> >  static int __recv_fd(const struct fuse_service *sf,
> > @@ -505,6 +508,8 @@ static int negotiate_hello(struct fuse_service *sf)
> >  
> >  	if (flags & FUSE_SERVICE_FLAG_ALLOW_OTHER)
> >  		sf->allow_other = true;
> > +	if (flags & FUSE_SERVICE_FLAG_FUSEBLK)
> > +		sf->can_fuseblk = true;
> >  
> >  	size = __send_packet(sf, &reply, sizeof(reply));
> >  	if (size < 0) {
> > @@ -612,6 +617,11 @@ bool fuse_service_can_allow_other(const struct fuse_service *sf)
> >  	return sf->allow_other;
> >  }
> >  
> > +bool fuse_service_can_fuseblk(const struct fuse_service *sf)
> > +{
> > +	return sf->can_fuseblk;
> > +}
> > +
> >  int fuse_service_append_args(struct fuse_service *sf,
> >  			     struct fuse_args *existing_args)
> >  {
> > diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> > index e09f53bbf3f7dc..b89a7f1f3df3d9 100644
> > --- a/lib/fuse_versionscript
> > +++ b/lib/fuse_versionscript
> > @@ -236,6 +236,7 @@ FUSE_3.19 {
> >  		fuse_service_accept;
> >  		fuse_service_append_args;
> >  		fuse_service_can_allow_other;
> > +		fuse_service_can_fuseblk;
> >  		fuse_service_cmdline;
> >  		fuse_service_destroy;
> >  		fuse_service_exit;
> > diff --git a/util/mount_service.c b/util/mount_service.c
> > index df22c1182541b7..6a6a8b608b7c6e 100644
> > --- a/util/mount_service.c
> > +++ b/util/mount_service.c
> > @@ -367,7 +367,10 @@ static int mount_service_send_hello(const struct mount_service *mo)
> >  	struct fuse_service_hello_reply reply = { };
> >  	ssize_t size;
> >  
> > -	if (getuid() == 0 || user_allow_other)
> > +	if (getuid() == 0)
> > +		hello.flags |= htonl(FUSE_SERVICE_FLAG_FUSEBLK |
> > +				     FUSE_SERVICE_FLAG_ALLOW_OTHER);
> > +	else if (user_allow_other)
> >  		hello.flags |= htonl(FUSE_SERVICE_FLAG_ALLOW_OTHER);
> >  
> >  	size = __send_packet(mo, &hello, sizeof(hello));
> > 
> 
> This breaks the FreeBSD build
> 
> 2026-06-07T20:28:41.0670421Z cc  -o lib/libfuse3.so.3.19.0 lib/libfuse3.so.3.19.0.p/fuse.c.o lib/libfuse3.so.3.19.0.p/fuse_loop.c.o lib/libfuse3.so.3.19.0.p/fuse_loop_mt.c.o lib/libfuse3.so.3.19.0.p/fuse_lowlevel.c.o lib/libfuse3.so.3.19.0.p/fuse_opt.c.o lib/libfuse3.so.3.19.0.p/fuse_signals.c.o lib/libfuse3.so.3.19.0.p/buffer.c.o lib/libfuse3.so.3.19.0.p/cuse_lowlevel.c.o lib/libfuse3.so.3.19.0.p/helper.c.o lib/libfuse3.so.3.19.0.p/modules_subdir.c.o lib/libfuse3.so.3.19.0.p/mount_util.c.o lib/libfuse3.so.3.19.0.p/fuse_log.c.o lib/libfuse3.so.3.19.0.p/compat.c.o lib/libfuse3.so.3.19.0.p/util.c.o lib/libfuse3.so.3.19.0.p/fuse_daemonize.c.o lib/libfuse3.so.3.19.0.p/mount_bsd.c.o lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o lib/libfuse3.so.3.19.0.p/modules_iconv.c.o -Wl,--as-needed -Wl,--no-undefined -shared -fPIC -Wl,-soname,libfuse3.so.4 -Wl,--version-script,/home/runner/work/libfuse/libfuse/lib/fuse_versionscript -pthread -Wl,--start-group -ldl -lrt -Wl,--end-group
> 2026-06-07T20:28:41.0697146Z ld: error: version script assignment of 'FUSE_3.19' to symbol 'fuse_service_can_fuseblk' failed: symbol not defined
> 2026-06-07T20:28:41.0717197Z cc: error: linker command failed with exit code 1 (use -v to see invocation)
> 2026-06-07T20:28:41.0839610Z [41/85] cc -Itest/readdir_inode.p -Itest -I../test -Iinclude -I../include -Ilib -I../lib -I. -I.. -fdiagnostics-color=always -Wall -Winvalid-pch -Wextra -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -MD -MQ test/readdir_inode.p/readdir_inode.c.o -MF test/readdir_inode.p/readdir_inode.c.o.d -o test/readdir_inode.p/readdir_inode.c.o -c ../test/readdir_inode.c

Urk, forgot to update the stub, sorry about that.

--D

> 
> 
> Thanks,
> Bernd
