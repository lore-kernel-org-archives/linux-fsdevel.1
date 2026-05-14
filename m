Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8932572F;
	Thu, 14 May 2026 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797230; cv=none; b=L8M9XADrziUNNJ62mQ5XVGYT8GB4/X0kmUNXeS8j/NpSFw+6RGuByfZp/FjUk1/jcqLEDtcTsgyBw7YzViOGc4NkeR2Q97fuGfqtkCYvNvKRa1HpUUnfua3spk+JY16aIf7hmOISOK1IftFfxnFRImaBSiTz46oa1xN4L98KXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797230; c=relaxed/simple;
	bh=stJdyVRFwfUcBCEkW2hoL5BEyjVsaCFKmaBQr1SbiWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXMyzsVQdu7ONcmOv+smzxej5rKfpYUOOPv2nZ+AhKH+62Mq3KFXvqTQTNVpUF2WiNP5euADBr4c6GCzVdfE0ruOhrczTD/UcMgf0pV0nhiu76YoxllHUdQJrcJ/GuSl3CvttpD1G7yegddOiCO4/FowzulpdIbrzGVEyup3eAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmA7hclV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmA7hclV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BF9C2BCB3;
	Thu, 14 May 2026 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778797229;
	bh=stJdyVRFwfUcBCEkW2hoL5BEyjVsaCFKmaBQr1SbiWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmA7hclVuPwAbQnIn4bvXXfx2YRLuMF2cDC8EQlblVE5/MVXtDqY0BzDzE0h/jKaa
	 tzQZoUQ/E3GE8GmH/o8IRQypPOdatjz5EG60dv/zPrC1GoEUEi7WIDl0/5jV2UvrZ/
	 u4p0t8U2hocnMGHjYybMyrfmGupzwyx6uSJyerHS7iAj3tUJVkYr0WdNpjrmSRyJzQ
	 hcKb/cacUvlWFtdNItjs0+5S/zRrTJugnepenb5sWHbFZkB0WxEWVUNNyUPawqQKMo
	 ko6db3CO9w0fDHYAXzAKca28WMil3rALQCLh/CSFUC3ltzw+WfWRYqSXIkw7d9NsCx
	 L1xkUoJw4CHlQ==
Date: Thu, 14 May 2026 15:20:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 8/9] fuse: update ctime when updating acls on an iomap
 inode
Message-ID: <20260514222029.GN9544@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206659.4103309.4775738448916496995.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747206659.4103309.4775738448916496995.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:35:10AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In iomap mode, the fuse kernel driver is in charge of updating file
> attributes, so we need to update ctime after an ACL change.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/acl.c |   18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> index 9619ac84a85886..76c46946640d44 100644
> --- a/fs/fuse/acl.c
> +++ b/fs/fuse/acl.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include "fuse_i.h"
> +#include "fuse_iomap.h"
>  
>  #include <linux/posix_acl.h>
>  #include <linux/posix_acl_xattr.h>
> @@ -113,6 +114,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	const char *name;
>  	umode_t mode = inode->i_mode;
>  	const bool local_acls = fuse_inode_has_local_acls(inode);
> +	const bool is_iomap = fuse_inode_has_iomap(inode);
>  	int ret;
>  
>  	if (fuse_is_bad(inode))
> @@ -180,10 +182,24 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  			ret = 0;
>  	}
>  
> -	/* If we scheduled a mode update above, push that to userspace now. */
>  	if (!ret) {
>  		struct iattr attr = { };
>  
> +		/*
> +		 * When we're running in iomap mode, we need to update mode and
> +		 * ctime ourselves instead of letting the fuse server figure
> +		 * that out.
> +		 */
> +		if (is_iomap) {
> +			attr.ia_valid |= ATTR_CTIME;
> +			inode_set_ctime_current(inode);
> +			attr.ia_ctime = inode_get_ctime(inode);

Codex nitpicks that we bump ctime even if the removexattr didn't do
anything, so I'll add some more state tracking to skip the setattr if we
don't update any xattrs and don't update the mode.

--D

> +		}
> +
> +		/*
> +		 * If we scheduled a mode update above, push that to userspace
> +		 * now.
> +		 */
>  		if (mode != inode->i_mode) {
>  			attr.ia_valid |= ATTR_MODE;
>  			attr.ia_mode = mode;
> 
> 
