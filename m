Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B9396B73
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774902608; cv=none; b=rFq+hNnIPZrAYUCLduxZ1Js5vZRuULVIv50o0YTRifz+QW/WoE1YlhF/CAy+kbD47JaIA/iiAqiL2JOs1wRuokZqfRmg0qwhhNyN+mpS61A9bk+kOHatqPEQIhV3ceWMtIJxibA8vv+EkuGUR6uevYAiXroxw2sSHu/0XXTRuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774902608; c=relaxed/simple;
	bh=O40cr2ETSE5nQ9U5AR60paoYTtqQq/lnoBOio5+TF7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVfqFrXlrZz7X29duG6s7GLtlW9jIHizLGNRaRjKQ6oT6NsoSRKE8XQdz5e9PDS/dP9HtxHBG5GFD0aNGmmBOZ6UVjNLtvYo/bedpyT2KlPEjvN5Tb2rvq8oWTGp5kNPftRlIBqvb5PIiK3b/S3cmHgKGYJHKCLF6otrnHEChAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw5hzaTu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw5hzaTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA5CC4CEF7;
	Mon, 30 Mar 2026 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774902608;
	bh=O40cr2ETSE5nQ9U5AR60paoYTtqQq/lnoBOio5+TF7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fw5hzaTu71aP2J8u34Gp6L11nyLBR6H0mXXt/RatGx34PpBEKQnFtiXLSXwqnDA2r
	 29hoqinqlmfZvSRZWbs3k+rHvj2dBAGqTQa9TlZZPTtW+Cw5xGeWuQzfsB7LPu6dOR
	 Z8dwgqQvFTUP00CkSUkUl6oscAO9AfH9PVYHsrQ6CSKQCsNIEYam+sCFk5ky6Fz6ZH
	 z2uPrw8QbXYS0a0KIsoWvU3X43ILXLrhqI+4cmB524/6gWBWd95LBnt9aX+5MGatQk
	 KrAaUkNV9Oyriyk3x5w1jmZcC3tA1r5dL3D5feQkZYaBr8m7JCVEEK8pWDv/gdN6xi
	 JRhkdcxsp3ang==
Date: Mon, 30 Mar 2026 13:30:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
	neal@gompa.dev, joannelkoong@gmail.com
Subject: Re: [PATCH 03/17] mount_service: create high level fuse helpers
Message-ID: <20260330203007.GJ6254@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
 <177457463171.1008428.692188550544402497.stgit@frogsfrogsfrogs>
 <d7e830f2-fb3f-4782-a6bc-9b850ebdcc36@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e830f2-fb3f-4782-a6bc-9b850ebdcc36@bsbernd.com>

On Mon, Mar 30, 2026 at 09:37:18PM +0200, Bernd Schubert wrote:
> Hi Darrick,
> 
> On 3/27/26 02:25, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a fuse_main wrapper for fuse services.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  include/fuse.h         |   33 ++++++++++++++++++++++++++++
> >  lib/fuse_versionscript |    1 +
> >  lib/helper.c           |   57 +++++++++++++++++++++++++++++++++++++++++-------
> >  3 files changed, 83 insertions(+), 8 deletions(-)
> > 
> > 
> > diff --git a/include/fuse.h b/include/fuse.h
> > index 595cac07f2be36..c7dae040857aca 100644
> > --- a/include/fuse.h
> > +++ b/include/fuse.h
> > @@ -1008,6 +1008,39 @@ static inline int fuse_main_fn(int argc, char *argv[],
> >  #define fuse_main(argc, argv, op, user_data) \
> >  	fuse_main_fn(argc, argv, op, user_data)
> >  
> > +#if FUSE_MAKE_VERSION(3, 19) <= FUSE_USE_VERSION
> > +struct fuse_service;
> > +int fuse_service_main_real_versioned(struct fuse_service *service,
> > +				     int argc, char *argv[],
> > +				     const struct fuse_operations *op,
> > +				     size_t op_size,
> > +				     struct libfuse_version *version,
> > +				     void *user_data);
> > +
> > +/**
> > + * Same as fuse_service_main_fn, but takes its information from the mount
> > + * service context.
> > + */
> > +static inline int fuse_service_main_fn(struct fuse_service *service,
> > +				       int argc, char *argv[],
> > +				       const struct fuse_operations *op,
> > +				       void *user_data)
> > +{
> > +	struct libfuse_version version = {
> > +		.major  = FUSE_MAJOR_VERSION,
> > +		.minor  = FUSE_MINOR_VERSION,
> > +		.hotfix = FUSE_HOTFIX_VERSION,
> > +		.padding = 0
> > +	};
> > +
> > +	return fuse_service_main_real_versioned(service, argc, argv, op,
> > +						sizeof(*(op)), &version,
> > +						user_data);
> > +}
> > +#define fuse_service_main(s, argc, argv, op, user_data) \
> > +	fuse_service_main_fn(s, argc, argv, op, user_data)
> > +#endif /* FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 19) */
> 
> sorry, this is not exactly what I meant. Could you take a look here? I

OH, you want the program to pass in both the version of libfuse that the
program was built against (struct libfuse_version) and the version of
libfuse that the program asked for (FUSE_USE_VERSION).  Not just header
guards.

> just pushed the unfinished patch I made in December. It got complicated
> in the high level API and I didn't have time to finish it yet.

Yes, that does make sense for setting defaults based on the version of
the libfuse API that the fuse server expects.

> https://github.com/libfuse/libfuse/pull/1382/changes/24836ded18e9736eb4691600600ff1d7cf581e29
> 
> Basically I would like to add the API version to the functions, in order
> to set defaults flags. The topic came up about FUSE_CAP_AUTO_INVAL_DATA,
> because it can cause data corruption, but there is also a risk to cause
> regressions. So would be good to set that based on the API version
> (assuming people read the rather new doc/ChangeLog-API.rst).
> 
> Anyway your function should basically be
> 
> int fuse_service_main_real_versioned(struct fuse_service *service,
> 				     int argc, char *argv[],
> 				     const struct fuse_operations *op,
> 				     size_t op_size,
>                                      unsigned int user_apiabi_version,
> 				     struct libfuse_version *version,
> 				     void *user_data);
> 
> 
> I.e. adding in 'user_apiabi_version'. Although while looking into this
> again, maybe we should mis-use 'padding' and rename it 'api version. It
> would definitely simplify things.
> 
> 
> While you look into all these things, what is your opinion? ;)

I like the idea of encoding the FUSE_USE_VERSION as the padding value.
I wonder if there's a danger of a client setting the fields manually:

	struct libfuse_version version;

	version.major = FUSE_MAJOR_VERSION;
	version.minor = FUSE_MINOR_VERSION;
	version.hotfix = FUSE_HOTFIX_VERSION;

	fuse_main_real_versioned(..., &version...);

such that version.padding is now set to stack garbage?  The wrapper
functions in fuse.h use struct initialization so the .padding value will
be zero, but fuse_session_new_versioned doesn't appear to require zero,
which makes such a change a bit risky.

Debian codesearch seems to think there aren't any direct callers of
fuse_session_new_versioned or fuse_main_real_versioned outside of fuse,
so this might not be a big risk.

If the risk is acceptable, it would reduce the amount of code changes to
add the FUSE_USE_VERSION number and force programs to #define it before
#include'ing fuse.h.

The existing functions that take a struct libfuse_version could just
ignore values like 0 or values that arent't in the range 30-39 or
310-319.  That might be enough to avoid complaints.

--D

> 
> Thanks,
> Bernd
> 
> > +
> >  /* ----------------------------------------------------------- *
> >   * More detailed API					       *
> >   * ----------------------------------------------------------- */
> > diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> > index 1fc73f417f90a0..43f8bf11b64548 100644
> > --- a/lib/fuse_versionscript
> > +++ b/lib/fuse_versionscript
> > @@ -236,6 +236,7 @@ FUSE_3.19 {
> >  		fuse_service_exit;
> >  		fuse_service_expect_mount_mode;
> >  		fuse_service_finish_file_requests;
> > +		fuse_service_main_real_versioned;
> >  		fuse_service_parse_cmdline_opts;
> >  		fuse_service_receive_file;
> >  		fuse_service_release;
> > diff --git a/lib/helper.c b/lib/helper.c
> > index 533526273207d5..3509f1aa0c8f79 100644
> > --- a/lib/helper.c
> > +++ b/lib/helper.c
> > @@ -15,6 +15,7 @@
> >  #include "fuse_misc.h"
> >  #include "fuse_opt.h"
> >  #include "fuse_lowlevel.h"
> > +#include "fuse_service.h"
> >  #include "mount_util.h"
> >  
> >  #include <stdio.h>
> > @@ -357,7 +358,8 @@ int fuse_daemonize(int foreground)
> >  	return 0;
> >  }
> >  
> > -int fuse_main_real_versioned(int argc, char *argv[],
> > +int fuse_service_main_real_versioned(struct fuse_service *service,
> > +			     int argc, char *argv[],
> >  			     const struct fuse_operations *op, size_t op_size,
> >  			     struct libfuse_version *version, void *user_data)
> >  {
> > @@ -367,8 +369,15 @@ int fuse_main_real_versioned(int argc, char *argv[],
> >  	int res;
> >  	struct fuse_loop_config *loop_config = NULL;
> >  
> > -	if (fuse_parse_cmdline(&args, &opts) != 0)
> > -		return 1;
> > +	if (service) {
> > +		if (fuse_service_parse_cmdline_opts(&args, &opts) != 0) {
> > +			res = 1;
> > +			goto out0;
> > +		}
> > +	} else {
> > +		if (fuse_parse_cmdline(&args, &opts) != 0)
> > +			return 1;
> > +	}
> >  
> >  	if (opts.show_version) {
> >  		printf("FUSE library version %s\n", PACKAGE_VERSION);
> > @@ -405,9 +414,17 @@ int fuse_main_real_versioned(int argc, char *argv[],
> >  		goto out1;
> >  	}
> >  
> > -	if (fuse_mount(fuse,opts.mountpoint) != 0) {
> > -		res = 4;
> > -		goto out2;
> > +	if (service) {
> > +		if (fuse_service_session_mount(service, fuse_get_session(fuse),
> > +					       0, &opts) != 0) {
> > +			res = 4;
> > +			goto out2;
> > +		}
> > +	} else {
> > +		if (fuse_mount(fuse, opts.mountpoint) != 0) {
> > +			res = 4;
> > +			goto out2;
> > +		}
> >  	}
> >  
> >  	if (fuse_daemonize(opts.foreground) != 0) {
> > @@ -421,9 +438,14 @@ int fuse_main_real_versioned(int argc, char *argv[],
> >  		goto out3;
> >  	}
> >  
> > -	if (opts.singlethread)
> > +	if (opts.singlethread) {
> > +		if (service) {
> > +			fuse_service_send_goodbye(service, 0);
> > +			fuse_service_release(service);
> > +		}
> > +
> >  		res = fuse_loop(fuse);
> > -	else {
> > +	} else {
> >  		loop_config = fuse_loop_cfg_create();
> >  		if (loop_config == NULL) {
> >  			res = 7;
> > @@ -434,6 +456,12 @@ int fuse_main_real_versioned(int argc, char *argv[],
> >  
> >  		fuse_loop_cfg_set_idle_threads(loop_config, opts.max_idle_threads);
> >  		fuse_loop_cfg_set_max_threads(loop_config, opts.max_threads);
> > +
> > +		if (service) {
> > +			fuse_service_send_goodbye(service, 0);
> > +			fuse_service_release(service);
> > +		}
> > +
> >  		res = fuse_loop_mt(fuse, loop_config);
> >  	}
> >  	if (res)
> > @@ -448,9 +476,22 @@ int fuse_main_real_versioned(int argc, char *argv[],
> >  	fuse_loop_cfg_destroy(loop_config);
> >  	free(opts.mountpoint);
> >  	fuse_opt_free_args(&args);
> > +out0:
> > +	if (service) {
> > +		fuse_service_send_goodbye(service, res);
> > +		fuse_service_release(service);
> > +	}
> >  	return res;
> >  }
> >  
> > +int fuse_main_real_versioned(int argc, char *argv[],
> > +			     const struct fuse_operations *op, size_t op_size,
> > +			     struct libfuse_version *version, void *user_data)
> > +{
> > +	return fuse_service_main_real_versioned(NULL, argc, argv, op, op_size,
> > +						version, user_data);
> > +}
> > +
> >  /* Not symboled, as not part of the official API */
> >  int fuse_main_real_30(int argc, char *argv[], const struct fuse_operations *op,
> >  		      size_t op_size, void *user_data);
> > 
> > 
> 
