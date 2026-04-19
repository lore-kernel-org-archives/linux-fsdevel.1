Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F7148850;
	Sun, 19 Apr 2026 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776621318; cv=none; b=PVEw/HXBeHSvnRYdAWG1CC74nt1CYJJMaCQLMD5FywUxE+snyStrdlZ0jzEWKszDfe817Cl02TWMHBl01muAWR4MufTyvG4Jhy9ErH2zQuzi5A2OwPqlfwpDy4RGmY+9RF2l4/e2NqoY9rqDLm1z/cRRX0OLeOll4AIFaShbF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776621318; c=relaxed/simple;
	bh=aUVIeiUAAXDjPSTdfpROh2RoTGDqXDmSHq5HxubqVaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoJXRC5ebe0kyp+sMSmpj/hyjQcofDSUv3VPLuOyPSH0X61UiFwW1EV82nRAYzNa+7+11l6nRAfQL2EJHZe3mN6QUqatvvbboodWtEUkRGgutXeVlmFLUCItf/NyABgymIV8ohzkDFdluDppVIaN4GQr/8ue5tPuWAunqwk+SVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF/BXsJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF/BXsJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0FBC2BCAF;
	Sun, 19 Apr 2026 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776621318;
	bh=aUVIeiUAAXDjPSTdfpROh2RoTGDqXDmSHq5HxubqVaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JF/BXsJWkZrT418RvS509kp6ZrESlTHScYEWSH5DfDMje+XkbBB1RyAnOG0xLWVxf
	 fpEUCd33bb1XEwFD1Bv/g3/bgCTOoMPbPVajpdYzFddg3Aych4fxmEYOShWF8oqoYo
	 sVjbpF7epki+jH6+Jln5RO2DVKHDJ440bfT2iCsczqLe+j+8J0Pl0L/cPw+27anlSS
	 9q8TXemqy1xrTNuxDitdfaDcZued0Y97gbwBvHWbOsmjZAQZH8RmC70TKZf8/WodTi
	 zqN4AmFsZTFaxTRXESxL0gfY/Ec/WM9KUigEfrFHQ6fniTAtvAmHU2n0rBoOji4iit
	 vaET4DGnxJNtA==
Date: Sun, 19 Apr 2026 10:55:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Joanne Koong <joannelkoong@gmail.com>, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add new fuse-devel list
Message-ID: <20260419175517.GD7765@frogsfrogsfrogs>
References: <20260419113529.1523179-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419113529.1523179-1-amir73il@gmail.com>

On Sun, Apr 19, 2026 at 01:35:28PM +0200, Amir Goldstein wrote:
> Document the new fuse-devel list in FUSE entry.
> For now, we are not removing fsdevel list, but we can consider that
> after wider adoption of fuse-devel list.
> 
> Link: https://lore.kernel.org/r/CAOQ4uxg+DhWoKtHFOt4eEgYYqAAmcJG_q3nJcQ2ZVOFCWRN0bw@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Yep, that's definitely the new list.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7dc9e6fad2ea..83f2edcd22769 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10519,6 +10519,7 @@ F:	drivers/net/ethernet/fungible/
>  FUSE: FILESYSTEM IN USERSPACE
>  M:	Miklos Szeredi <miklos@szeredi.hu>
>  L:	linux-fsdevel@vger.kernel.org
> +L:	fuse-devel@lists.linux.dev
>  S:	Maintained
>  W:	https://github.com/libfuse/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
> -- 
> 2.53.0
> 
