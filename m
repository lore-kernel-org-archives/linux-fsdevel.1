Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E834CDD;
	Thu, 21 May 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373495; cv=none; b=fUdxVdlunfzuZlo2j8cK/V3TEzaz9zxIQMPbT2+9oaxn3Dk7fYjwpePtUPCoebg5v97J+XEEVBd2bzryzXG/chMFPLe6cCPFdo7ev5Wuphe6ojIc8h4C5F40dBlJMsrJZqiEteBoKX181OZqnfznNVM5ApUHpN/ZVnJNrXHomSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373495; c=relaxed/simple;
	bh=Yx9cz7eVx4G5yzulKSEt1dZN2OSSxEpuZLKqPmDLvaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI1mcM/Fp0kB4jo32MMJQ4KejMTQfOxFY75gWdhxDnzXjA2mJgp32nAYqYzjhWUz58RzI1wPu22PVIm7g6a70pTeovF1yTUCVgaeDawy0ASL6YXr8taTbvx+W6rqN2TixoCZ67sM2sbCtrtGzHlrw3j8swM1vCenLC2XEJjC6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTQmjD4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTQmjD4K"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 38B051F000E9;
	Thu, 21 May 2026 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779373494;
	bh=2nIcEpRj9qm69QCEM/16j+LMdKfA7oxGAEiJD8SoYnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cTQmjD4KXgt6k8rICveQBgR29OChQVEzhDLFJhTBQGmUCcOXhiQ9cJsalEcsFXJUB
	 dhNI94XIUvMLErO9nytDCpP/4+oKokE+ctlM3/Yka4beCPUPgsKPeEP450ezgHyQT8
	 c90p4TtO16ffeLHeNs3P8IBz6I7Q17JkJgcU4pYYeq1tWrKvSFZwVwXoU7CQqL7jIJ
	 uA+E1lIG/ExhdkdUo3QIagIVrLkI17C4IRfBBy8H4SgNBU5pNnfyRPUJ6UUZHH0WFn
	 eQFnq+SpcJ3DyCwsigiqF0fpeAzrGMqEcVrBLDbP70WD0sS+YGDMxft/xs5b+PUx8e
	 w9XWny07aa6HA==
Date: Thu, 21 May 2026 07:24:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 1/4] fuse: use fuse_args in try_service_main instead of
 opencoding it
Message-ID: <20260521142453.GN9568@frogsfrogsfrogs>
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
 <177933241466.3536631.2548927904330465445.stgit@frogsfrogsfrogs>
 <567436e2-46d2-4e23-9647-b9af9670a4ea@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <567436e2-46d2-4e23-9647-b9af9670a4ea@bsbernd.com>

On Thu, May 21, 2026 at 10:40:11AM +0200, Bernd Schubert wrote:
> 
> 
> On 5/21/26 05:06, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Don't open-code the argument array, just use the existing helpers.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  util/mount.fuse.c |   71 +++++++++++++++++++++++++----------------------------
> >  1 file changed, 34 insertions(+), 37 deletions(-)
> > 
> > 
> > diff --git a/util/mount.fuse.c b/util/mount.fuse.c
> > index 00b133e6234489..bbfd8355dc7f48 100644
> > --- a/util/mount.fuse.c
> > +++ b/util/mount.fuse.c
> > @@ -286,12 +286,7 @@ static int mount_service_child(char **argv)
> >  static int try_service_main(char *argv0, char *fstype, char *source,
> >  			    const char *mountpoint, char *options)
> >  {
> > -	char **argv;
> > -	char dash_o[] = "-o";
> > -	char dash_t[] = "-t";
> > -	char *mntpt;
> > -	int argc = 5; /* argv[0], -t type, mountpoint, and trailing NULL */
> > -	int i = 0;
> > +	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
> >  	int ret;
> >  
> >  	if (!mount_service_present(fstype))
> > @@ -301,44 +296,46 @@ static int try_service_main(char *argv0, char *fstype, char *source,
> >  	if (source && source[0] == 0)
> >  		source = NULL;
> >  
> > -	mntpt = strdup(mountpoint);
> > -	if (!mntpt) {
> > -		perror("mountpoint allocation");
> > -		return -1;
> > +	ret = fuse_opt_add_arg(&args, argv0);
> > +	if (ret)
> > +		goto out;
> > +
> > +	if (source) {
> > +		ret = fuse_opt_add_arg(&args, source);
> > +		if (ret)
> > +			goto out;
> >  	}
> >  
> > -	if (source)
> > -		argc++;
> > -	if (options)
> > -		argc += 2;
> > +	ret = fuse_opt_add_arg(&args, mountpoint);
> > +	if (ret)
> > +		goto out;
> >  
> > -	argv = calloc(argc, sizeof(char *));
> > -	if (!argv) {
> > -		perror("argv allocation");
> > -		free(mntpt);
> > -		return -1;
> > -	}
> > +	ret = fuse_opt_add_arg(&args, "-t");
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = fuse_opt_add_arg(&args, fstype);
> > +	if (ret)
> > +		goto out;
> >  
> > -	argv[i++] = argv0;
> > -	if (source)
> > -		argv[i++] = source;
> > -	argv[i++] = mntpt;
> > -	argv[i++] = dash_t;
> > -	argv[i++] = fstype;
> >  	if (options) {
> > -		argv[i++] = dash_o;
> > -		argv[i++] = options;
> > -	}
> > -	argv[i] = 0;
> > +		ret = fuse_opt_add_arg(&args, "-o");
> > +		if (ret)
> > +			goto out;
> >  
> > -	if (getuid() != 0) {
> > -		ret = mount_service_child(argv);
> > -	} else {
> > -		/* We're root, just do the mount directly. */
> > -		ret = mount_service_main(argc - 1, argv);
> > +		ret = fuse_opt_add_arg(&args, options);
> > +		if (ret)
> > +			goto out;
> >  	}
> > -	free(argv);
> > -	free(mntpt);
> > +
> > +	/* If we're root, just do the mount directly. */
> > +	if (getuid() != 0)
> > +		ret = mount_service_child(args.argv);
> > +	else
> > +		ret = mount_service_main(args.argc, args.argv);
> > +
> > +out:
> > +	fuse_opt_free_args(&args);
> >  	return ret;
> >  }
> >  #endif
> > 
> 
> 
> Thanks a lot much better!
> I think we need something like
> fuse_opt_add_arg(struct fuse_args *args, ...)
> Easy enough to convert to that once libfuse has it.

Oh, you mean like a va_args version of it?  Yeah, that would be useful,
but iirc the va_args user has to know the length of the args array
beforehand, and it's not so ergonomic to let people do:

	fuse_opt_add_args(&args, 3, "-o", "monkeys");	/* oh no */

There are some horrible cpp macro tricks you can play in C++20 to call
fuse_add_opt_arg() recursively until you run out of arguments:

#define PARENS ()

#define FOR_EACH_HELPER(func, base, arg, ...) \
  func(base, arg);                            \
  __VA_OPT__(FOR_EACH_AGAIN PARENS (func, base, __VA_ARGS__))

#define FOR_EACH_AGAIN() FOR_EACH_HELPER

#define FOR_EACH(func, base, ...) \
  __VA_OPT__(FOR_EACH_HELPER(func, base, __VA_ARGS__))

#define fuse_opt_add_args(args, ...) \
  FOR_EACH(fuse_opt_add_arg, args, __VA_ARGS__)

But now that I've broken my brain I'm going to go do something else for
a bit. ;)

> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

Thanks!

--D
