Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210B19B5A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393367; cv=none; b=pRzl/2Tg/nlDbpuJjp3sVGVOdG0oJIhb8fbhlsZ15vLW3nyf4OtLlHj4T+edHFaj4fACGcXcCnZV1Xhc/IR4TOzqIr8/pSrCTMxUAJfZmF1NUh0lyDBeNVE7xTUsL2AuiJE/soE5iPTLSc/M66JO5NtTrdjxS0lAzd1dnQCSE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393367; c=relaxed/simple;
	bh=oUUfdVBj/sar5Md31YfqMnMQVMm6F0KIJAx5cZ6CUb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qgoy88tmgTT6VPJwZ39q8ESnZccOzXY4MMfHvxh46ssC+sqJBFtengSD/l95RcSbD8x9ya0+FTilARj32tJyq9jy3DzAwghil5mCUxF4EOd+8taov1SmZywq+kQWtCJOV3Fhc5SIF0E7FquiMOVHAxd3Bd9yHdeHFjoZtmT95o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av7YrqG6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av7YrqG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AF2C19424;
	Tue, 24 Mar 2026 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774393366;
	bh=oUUfdVBj/sar5Md31YfqMnMQVMm6F0KIJAx5cZ6CUb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Av7YrqG6GGfNfQ+Ts8LoFQTHLHA3t2bApOmmGR+U8AM7LXFJCWdpU+LzWJtOb/a+H
	 so23+svkYqOwziz0ZLioem16Tnjt2ynlRlDV5+ME+dhCc2execBCdp06w5RQkAwRrI
	 lCNy7HNDVe0ihyh2sbjEePySZ1mA0fEJUvPRfg5QUW+ucwiamAahyhAskxadMG8p6Z
	 iz3SuMxCWvuLvXv+6EJ5p8D7fUbkhFgoQursP0ysRWXmZEmnDl45kJuKcCFxQ0+fsX
	 MA2EJMFEsyU8bb2nFKUfWgG1A7kcyW9K8eibLnTvu2g+oF+yQFuczO/eb+hPFUUFga
	 xyKUFNERES1dA==
Date: Tue, 24 Mar 2026 16:02:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 18/19] New mount API: Filter out "user="
Message-ID: <20260324230246.GB6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-18-a52d3040af69@bsbernd.com>
 <20260324195153.GU6202@frogsfrogsfrogs>
 <0eb22615-7b1b-4472-aa55-6445e05d9cc7@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eb22615-7b1b-4472-aa55-6445e05d9cc7@bsbernd.com>

On Tue, Mar 24, 2026 at 09:01:16PM +0100, Bernd Schubert wrote:
> 
> 
> On 3/24/26 20:51, Darrick J. Wong wrote:
> > On Mon, Mar 23, 2026 at 06:45:13PM +0100, Bernd Schubert wrote:
> >> From: Bernd Schubert <bschubert@ddn.com>
> >>
> >> This gets added in the fusermount process and kernel then fails
> >> the mount.
> >>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >> ---
> >>  lib/mount_fsmount.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
> >> index f1fec790bb80f8815d485a068dc7efdff1746309..76c14cf9a22465160fc6b206ca9b6c9e7300adba 100644
> >> --- a/lib/mount_fsmount.c
> >> +++ b/lib/mount_fsmount.c
> >> @@ -218,6 +218,16 @@ static int is_mount_attr_opt(const char *opt)
> >>  	       strcmp(opt, "symfollow") == 0;
> >>  }
> >>  
> >> +/**
> >> + * Check if an option is a mount table option (not passed to fsconfig)
> >> + */
> >> +static int is_mtab_only_opt(const char *opt)
> >> +{
> >> +	/* These options are for /run/mount/utab only, not for the kernel */
> >> +	return strncmp(opt, "user=", 5) == 0 ||
> >> +	       strcmp(opt, "rw") == 0;
> > 
> > Oh, so these are added to the mount options string by get_mnt_opts
> > and now they need to be pulled out so they aren't passed to fsconfig?
> > How'd they get into the argument list in the first place?
> 
> 
> See the commit message ;) And then check fusermount.c in get_mnt_opts()

Ok, so this is something that you need to filter out.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> 
> Cheers,
> Bernd
> 
