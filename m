Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390B3A6F1A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774893458; cv=none; b=hdDGFG5d1eroXdWT+hULSZSvWAX+wtMiFYqJsUckz+oqE/3C4avQIw3hFDVp+mPH/WfVwkmXBSuocnAVc5btsZjcivaVnvtob0ij44alAA3O1hB+8zw2k9EA7ePY/JPDsvh9c0j3YUrixfd8yujNeiY4eisSY2OT6lryo1WjpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774893458; c=relaxed/simple;
	bh=mz5W6QO3D5HjvSuLLPYjKCxzhqfKfrfFEuI2QHTN2xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eV4fBh6IvL3heyIfBQVifHXfLEoC54i6c3RfqV6BZOGlk5MnW4aFxtjHK/X055Gre1jiWFtDX59ENg8EgOSN1pyplyEF0wpsO9p7Brl18SV5DMnO1s+8M71yq/JxixyugblZonDdfoQjh0ULH845h9pubYmSlZ9JKss3EPNaI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPWddP1N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPWddP1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F57C4CEF7;
	Mon, 30 Mar 2026 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774893458;
	bh=mz5W6QO3D5HjvSuLLPYjKCxzhqfKfrfFEuI2QHTN2xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPWddP1NX5cxB03ke0AmEEXL29+ljfxKDRslJotCcHNhA11nMWnOCmNfDo59s2Idt
	 mtA+LDQkVXuQGegErKyqKvUIfsKeJTsUXirSYU7sq2bVE7FSuKD9xZQDyLgnl6/EB7
	 UvXnCUV1euANv2AZWYrXU39SEwwpv/V5Je7NY9USphILTVeTYRuutSAdl6oQk4WDgL
	 meq7Typ4he1SFb1FuiGgTJYbgrlY7G0e5EFX9CmZeHjj+m4Jy4uJKBAMd5TuSt51n7
	 IL90zBpSDf3enx01BEQ/4zeIpVuIpQQdg7ijqVJDYUL+yXjrptu04Nr4HyyMPIR9Ks
	 V31kRdoynI49A==
Date: Mon, 30 Mar 2026 10:57:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
Subject: Re: [PATCH v2 18/25] fusermout: Remove the large read check
Message-ID: <20260330175737.GT6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-18-b1ca8fcbf60f@bsbernd.com>
 <20260327033213.GN6202@frogsfrogsfrogs>
 <75b57936-be43-4240-878d-2fa988494bc5@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75b57936-be43-4240-878d-2fa988494bc5@bsbernd.com>

On Mon, Mar 30, 2026 at 05:26:15PM +0200, Bernd Schubert wrote:
> 
> 
> On 3/27/26 04:32, Darrick J. Wong wrote:
> > On Thu, Mar 26, 2026 at 10:34:51PM +0100, Bernd Schubert wrote:
> >> <quote Darrick>
> >> Nobody's running 2.4 kernels
> >> anymore, right?
> >> </quote>
> >>
> >> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> >> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
> >> ---
> >>  util/fusermount.c | 37 +------------------------------------
> >>  1 file changed, 1 insertion(+), 36 deletions(-)
> >>
> >> diff --git a/util/fusermount.c b/util/fusermount.c
> >> index 8d7598998788f72ea05c2a065a88cb5efd61df35..254f24a98abf935846cfed754693cc1958c8d2ff 100644
> >> --- a/util/fusermount.c
> >> +++ b/util/fusermount.c
> >> @@ -915,33 +915,6 @@ static void free_mount_params(struct mount_params *mp)
> >>  	free(mp->mnt_opts);
> >>  }
> >>  
> >> -/*
> >> - * Check if option is deprecated large_read.
> >> - *
> >> - * Returns true if the option should be skipped (large_read on kernel > 2.4),
> >> - * false otherwise (all other options or large_read on old kernels).
> >> - */
> >> -static bool check_large_read(const char *opt, unsigned int len)
> >> -{
> >> -	struct utsname utsname;
> >> -	unsigned int kmaj, kmin;
> >> -	int res;
> >> -
> >> -	if (!opt_eq(opt, len, "large_read"))
> >> -		return false;
> >> -
> >> -	res = uname(&utsname);
> >> -	if (res == 0 &&
> >> -	    sscanf(utsname.release, "%u.%u", &kmaj, &kmin) == 2 &&
> >> -	    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
> >> -		fprintf(stderr,
> >> -			"%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n",
> >> -			progname, kmaj, kmin);
> >> -		return true;
> >> -	}
> >> -	return false;
> >> -}
> >> -
> >>  /*
> >>   * Check if user has permission to use allow_other or allow_root options.
> >>   *
> >> @@ -1041,19 +1014,11 @@ static int prepare_mount(const char *opts, struct mount_params *mp)
> >>  			   !begins_with(s, "rootmode=") &&
> >>  			   !begins_with(s, "user_id=") &&
> >>  			   !begins_with(s, "group_id=")) {
> >> -			bool skip;
> >>  
> >>  			if (check_allow_permission(s, len) == -1)
> >>  				goto err;
> >>  
> >> -			skip = check_large_read(s, len);
> >> -
> >> -			/*
> >> -			 * Skip deprecated large_read to avoid passing it to
> >> -			 * kernel which would reject it as unknown option.
> >> -			 */
> >> -			if (!skip)
> >> -				process_generic_option(s, len, &mp->flags, &d);
> >> +			process_generic_option(s, len, &mp->flags, &d);
> > 
> > Er... we should still ignore large_read, right?  It's been defunct since
> > 2.4, but there could be some script/fstab/whatever that still contains
> > the mount option.
> 
> Dunno, I'm more tempted to remove it and to filter it out if someone
> ever complains. 2.4 was a long time ago.

Ok by me then :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

(who recently got flames whilst trying to remove defunct mount options
from xfs and is probably now overcautious about that)

--D

> 
> 
> Thanks,
> Bernd
> 
