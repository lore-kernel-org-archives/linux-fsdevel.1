Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53162357D07;
	Tue,  2 Jun 2026 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417788; cv=none; b=rJaYEzVrn2Xkvsfl64zBFziKTF+zu/b786KqlvGmxISywUPzUdkIowzxHU3EcjwmnsQl3F1Br9JrUNkgpjhfRhN2eFjFD0k2MxFtaodjguNstEH3p0qJY8SrK373/bPuo15T2c24zfG4LtSRBFLCF2PlC5FUZ+4zH7Bs4SMLkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417788; c=relaxed/simple;
	bh=zCcneumXVd27f0wSHLeZGeucNZS3Uc6kcAT+1LZVKb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1JBw3BD1fTzEC5Sl1YEeLf+EpJ2La23g8py+51Ba7V8n5V43AN//9B1SYjI9VeuIHWohd9EoF3IBUIEjp3uwkTXdOKsxwPkUHU4dLUuMaWRD/V8ue9NJ1T9X6uGg8XTBexQLyUyvLD9IkYadrrRMJwtcrT+RwFixVdEmuj3u30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em/DIec2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em/DIec2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2C3B51F00898;
	Tue,  2 Jun 2026 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417787;
	bh=FdfQ2JJrAI1EeUhXdXWsb6dSFsvEjE9Zku/d4Crb4Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Em/DIec2p5XhPD8m44oVJHK0vFV+yn39LJsgA/J0tGJ/uqwjdL2L+Yd3lWiGgAnVM
	 XHvr2qeT0463YNP8QVveXRiwVE4M00y3qIKXkcuOPO79Pxs0wFK03fBRNJprAbQsLm
	 zK599m7E7EpIzkyGNdW5jgzRTZFVDBFdtq8HNabeRGmbhQ9QMMCCYEffDIFyATG6oL
	 k4wIQGWD1EerZLI2N4WbBhRfkdpVuOETW4E2JloGZsyKuVo5iwBPSD8TTJEIwWHx+q
	 eLnsyr1ZGNoCXjrLcGoFmmycgEB4jHeFkDuyUPJz4vzzkxW1lRCqODhmtxJSwN+NHK
	 P3zJgBKDAqpew==
Date: Tue, 2 Jun 2026 09:29:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] mount_service: call the new fsmount ms_flags helpers
 in the right order
Message-ID: <20260602162946.GH6070@frogsfrogsfrogs>
References: <178036512130.432362.7597373245082703669.stgit@frogsfrogsfrogs>
 <178036512194.432362.255954133278562428.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178036512194.432362.255954133278562428.stgit@frogsfrogsfrogs>

On Mon, Jun 01, 2026 at 06:53:25PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Codex noticed a discrepancy between the new fsmount code that Bernd
> wrote and my port of the even newer mount service code to use the
> helpers that Bernd wrote.  Specifically, set_fsconfig_ms_flags only
> clears bits from MS_FLAGS if there's no corresponding MOUNT_ATTR_ flag,
> whereas ms_flags_to_mount_attrs always clears them.
> 
> In other words, set_fsconfig_ms_flags MUST be called before
> ms_flags_to_mount_attrs or we can lose the 'ro' option.  Fix this.
> 
> Fixes: 7211953256526f ("mount_service: use the fsmount API helpers from mount_fsmount.c")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  lib/mount_fsmount.c  |    1 +
>  util/mount_service.c |   12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
> index 83768f0b8d193b..7bd772d139808e 100644
> --- a/lib/mount_fsmount.c
> +++ b/lib/mount_fsmount.c
> @@ -35,6 +35,7 @@
>  #define MOUNT_ATTR_NOSYMFOLLOW  0x00200000
>  #endif
>  
> +/* Must be called after set_fsconfig_ms_flags */
>  unsigned long ms_flags_to_mount_attrs(unsigned long ms_flags,
>  				      unsigned int *mount_attrs)
>  {
> diff --git a/util/mount_service.c b/util/mount_service.c
> index 360a78bab3bd3d..f1b61ace526275 100644
> --- a/util/mount_service.c
> +++ b/util/mount_service.c
> @@ -1410,14 +1410,12 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
>  				      const struct stat *stbuf)
>  {
>  	char tmp[64];
> -	unsigned long ms_flags;
> +	unsigned long ms_flags = ntohl(oc->ms_flags);
>  	unsigned int attr_flags;
>  	int mfd;
>  	int error;
>  	int ret;
>  
> -	ms_flags = ms_flags_to_mount_attrs(ntohl(oc->ms_flags), &attr_flags);
> -
>  	ret = set_fsconfig_ms_flags(mo->fsopenfd, &ms_flags);
>  	if (ret) {
>  		error = errno;
> @@ -1478,6 +1476,14 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
>  		goto fail_fsconfig;
>  	}
>  
> +	ms_flags = ms_flags_to_mount_attrs(ms_flags, &attr_flags);

NAK, this call should have been moved only to the other side of
set_fsconfig_ms_flags, otherwise the fallback is triggered for any MS_*
flags that could easily be translated into MOUNT_ATTR_* flags.

--D

> +	if (ms_flags != 0) {
> +		error = ENOTSUP;
> +		fprintf(stderr, "%s: unsupported mount flags encountered\n",
> +			mo->msgtag);
> +		goto fail_fsconfig;
> +	}
> +
>  	mfd = fsmount(mo->fsopenfd, FSMOUNT_CLOEXEC, attr_flags);
>  	if (mfd < 0) {
>  		error = errno;
> 
> 
