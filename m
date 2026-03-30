Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D33A0B2E
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904959; cv=none; b=mVgsj5+hYXjVnyV5dlACsdpC9rU1IEYrJAXdfVjugaULATOl8cbBQSqSciplELhONQnDa1qvHMyIa2pnSV/NAGNUEw4g5Tb+69Z/wcEfhP+bmuTwMipEKejSxYy747a29CMayazjgCy/0P6ZmbHKODixQ6gCmLXh0m3/yDXHCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904959; c=relaxed/simple;
	bh=IYuFInESGgXDi7ZRAoqIjFykK/MklCWWh9My8v3r2So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcPXOjvJxzYNNgLVSuoR/h8JyqN+5pl0eIPhO5Bud0VN5VLcrNJdNwtJqzkhPKTYChFfNS2jLij35dDT/AcBGyryYAp6I73BTDnM0Vg1iXG74I+k4E6u6UrtDjFBEYN9+z9xGvz5876Jmc33Jwb+J7iS7Wz+YAHQOU96aX1q/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKqLlVOW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKqLlVOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F565C4CEF7;
	Mon, 30 Mar 2026 21:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774904958;
	bh=IYuFInESGgXDi7ZRAoqIjFykK/MklCWWh9My8v3r2So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKqLlVOW4tCgvyoOMvtLgMMs49KMiJKaDvBzCqnbd/eLUFD/LMniHeCI9hvadsIq2
	 rOmGTcUVKHpVseYb56xCem4mWDHUvmcmbZ3Kopp3YqN0ctANgjJKjuXPyRXkdBi+BU
	 GlVcXHLrgrd/sgLHQlzCzOhIa51Ugmb6s0tk6FdX31IF/Hb6vaTDF8UFB4xuyXFyFd
	 ijIA5plnYOE8eNxtb7T6VjAlrDoC1AkA6VO7BEADkuCAeONq9QqKiExLJVSaHG/0B1
	 gs8Mo19I9w1A1KqJbIrTMdtWzwxoX1aCTNOhAdmKNK2TAKZj7l2tH2hO3ioF40SxUP
	 xl3Ok6Wwpctbg==
Date: Mon, 30 Mar 2026 14:09:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>
Subject: Re: [PATCH 03/17] mount_service: create high level fuse helpers
Message-ID: <20260330210916.GD6202@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
 <177457463171.1008428.692188550544402497.stgit@frogsfrogsfrogs>
 <d7e830f2-fb3f-4782-a6bc-9b850ebdcc36@bsbernd.com>
 <20260330203007.GJ6254@frogsfrogsfrogs>
 <095a92b6-889d-4207-8aa5-7b76098a3937@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <095a92b6-889d-4207-8aa5-7b76098a3937@ddn.com>

On Mon, Mar 30, 2026 at 08:51:01PM +0000, Bernd Schubert wrote:
> On 3/30/26 22:30, Darrick J. Wong wrote:
> > On Mon, Mar 30, 2026 at 09:37:18PM +0200, Bernd Schubert wrote:
> >> Hi Darrick,
> >>
> >> On 3/27/26 02:25, Darrick J. Wong wrote:
> >>> From: Darrick J. Wong <djwong@kernel.org>
> >>>
> >>> Create a fuse_main wrapper for fuse services.
> >>>
> >>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> >>> ---
> >>>  include/fuse.h         |   33 ++++++++++++++++++++++++++++
> >>>  lib/fuse_versionscript |    1 +
> >>>  lib/helper.c           |   57 +++++++++++++++++++++++++++++++++++++++++-------
> >>>  3 files changed, 83 insertions(+), 8 deletions(-)
> >>>
> >>>
> >>> diff --git a/include/fuse.h b/include/fuse.h
> >>> index 595cac07f2be36..c7dae040857aca 100644
> >>> --- a/include/fuse.h
> >>> +++ b/include/fuse.h
> >>> @@ -1008,6 +1008,39 @@ static inline int fuse_main_fn(int argc, char *argv[],
> >>>  #define fuse_main(argc, argv, op, user_data) \
> >>>  	fuse_main_fn(argc, argv, op, user_data)
> >>>  
> >>> +#if FUSE_MAKE_VERSION(3, 19) <= FUSE_USE_VERSION
> >>> +struct fuse_service;
> >>> +int fuse_service_main_real_versioned(struct fuse_service *service,
> >>> +				     int argc, char *argv[],
> >>> +				     const struct fuse_operations *op,
> >>> +				     size_t op_size,
> >>> +				     struct libfuse_version *version,
> >>> +				     void *user_data);
> >>> +
> >>> +/**
> >>> + * Same as fuse_service_main_fn, but takes its information from the mount
> >>> + * service context.
> >>> + */
> >>> +static inline int fuse_service_main_fn(struct fuse_service *service,
> >>> +				       int argc, char *argv[],
> >>> +				       const struct fuse_operations *op,
> >>> +				       void *user_data)
> >>> +{
> >>> +	struct libfuse_version version = {
> >>> +		.major  = FUSE_MAJOR_VERSION,
> >>> +		.minor  = FUSE_MINOR_VERSION,
> >>> +		.hotfix = FUSE_HOTFIX_VERSION,
> >>> +		.padding = 0
> >>> +	};
> >>> +
> >>> +	return fuse_service_main_real_versioned(service, argc, argv, op,
> >>> +						sizeof(*(op)), &version,
> >>> +						user_data);
> >>> +}
> >>> +#define fuse_service_main(s, argc, argv, op, user_data) \
> >>> +	fuse_service_main_fn(s, argc, argv, op, user_data)
> >>> +#endif /* FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 19) */
> >>
> >> sorry, this is not exactly what I meant. Could you take a look here? I
> > 
> > OH, you want the program to pass in both the version of libfuse that the
> > program was built against (struct libfuse_version) and the version of
> > libfuse that the program asked for (FUSE_USE_VERSION).  Not just header
> > guards.
> 
> I don't think we need the header guards, I think these are more for the
> case the API changes. With just additions there cannot break anything?
> 
> > 
> >> just pushed the unfinished patch I made in December. It got complicated
> >> in the high level API and I didn't have time to finish it yet.
> > 
> > Yes, that does make sense for setting defaults based on the version of
> > the libfuse API that the fuse server expects.
> > 
> >> https://github.com/libfuse/libfuse/pull/1382/changes/24836ded18e9736eb4691600600ff1d7cf581e29
> >>
> >> Basically I would like to add the API version to the functions, in order
> >> to set defaults flags. The topic came up about FUSE_CAP_AUTO_INVAL_DATA,
> >> because it can cause data corruption, but there is also a risk to cause
> >> regressions. So would be good to set that based on the API version
> >> (assuming people read the rather new doc/ChangeLog-API.rst).
> >>
> >> Anyway your function should basically be
> >>
> >> int fuse_service_main_real_versioned(struct fuse_service *service,
> >> 				     int argc, char *argv[],
> >> 				     const struct fuse_operations *op,
> >> 				     size_t op_size,
> >>                                      unsigned int user_apiabi_version,
> >> 				     struct libfuse_version *version,
> >> 				     void *user_data);
> >>
> >>
> >> I.e. adding in 'user_apiabi_version'. Although while looking into this
> >> again, maybe we should mis-use 'padding' and rename it 'api version. It
> >> would definitely simplify things.
> >>
> >>
> >> While you look into all these things, what is your opinion? ;)
> > 
> > I like the idea of encoding the FUSE_USE_VERSION as the padding value.
> > I wonder if there's a danger of a client setting the fields manually:
> > 
> > 	struct libfuse_version version;
> > 
> > 	version.major = FUSE_MAJOR_VERSION;
> > 	version.minor = FUSE_MINOR_VERSION;
> > 	version.hotfix = FUSE_HOTFIX_VERSION;
> > 
> > 	fuse_main_real_versioned(..., &version...);
> > 
> > such that version.padding is now set to stack garbage?  The wrapper
> > functions in fuse.h use struct initialization so the .padding value will
> > be zero, but fuse_session_new_versioned doesn't appear to require zero,
> > which makes such a change a bit risky.
> > 
> > Debian codesearch seems to think there aren't any direct callers of
> > fuse_session_new_versioned or fuse_main_real_versioned outside of fuse,
> > so this might not be a big risk.
> > 
> > If the risk is acceptable, it would reduce the amount of code changes to
> > add the FUSE_USE_VERSION number and force programs to #define it before
> > #include'ing fuse.h.
> > 
> > The existing functions that take a struct libfuse_version could just
> > ignore values like 0 or values that arent't in the range 30-39 or
> > 310-319.  That might be enough to avoid complaints.
> 
> Hmm yeah, there a bit risk people people who access these functions with
> dlopen. My personal opinion is that one should not directly access
> libfuse functions, but write a wrapper lib, correctly define the API
> version in that lib and then dlopen the wrapper lib.
> I need to think about it again, thanks for pointing that out!

libfuse could restrict itself to failing only 1-29 and 40-309, and
warning on otherwise crazy versions:

#define FUSE_MAKE_VERSION_OLD(maj, min)  ((maj) * 10 + (min))

static inline bool validate_version(const struct libfuse_version *version,
				    size_t op_size)
{
	if (version == NULL) {
		fuse_log(FUSE_LOG_ERR, "fuse: warning: version not passed to fuse_session_new()\n");
		return false;
	}

	/* padding got turned into fuse api level, so zero is still accepted */
	if (version->padding == 0)
		return true;

	/* 3.0 -> 3.9 had one format for FUSE_MAKE_VERSION */
	if (version->padding >= FUSE_MAKE_VERSION_OLD(3, 0) &&
	    version->padding <= FUSE_MAKE_VERSION_OLD(3, 9))
		return true;

	/* 3.10+ has a different format for FUSE_MAKE_VERSION */
	if (version->padding >= FUSE_MAKE_VERSION(FUSE_MAJOR_VERSION, 0)) {
		/*
		 * Warn about too-new versions if we aren't going to print the
		 * op_size warning below.
		 */
		if (version->padding > FUSE_VERSION &&
		    sizeof(struct fuse_lowlevel_ops) >= op_size)
			fuse_log(FUSE_LOG_ERR,
				 "fuse: warning: library too old, some operations may not work\n");

		return true;
	}

	fuse_log(FUSE_LOG_ERR, "fuse: warning: version %u not recognized\n",
		 version->padding);
	return false;
}

A good question is, what format will FUSE_MAKE_VERSION have with 4.x?. :)

--D

> 
> Cheers,
> Bernd
