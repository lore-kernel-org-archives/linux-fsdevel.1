Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0503603F7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300613; cv=none; b=a4BH1vh4WdAE6tW+r6V95REz+TxsvzkzxtXfLXv+riC2Q+dWIT+R+3DpCzCAqXxrPDzXZY6YkMmpj9jG1pfB1vNMFoHliKK8ANt77ZNIu7hVVEvfYAYQtLuOU4WVNvWScWSGKl7SRUQ69dx9XRJHYm1v85niryrefFEgY2KoQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300613; c=relaxed/simple;
	bh=eQMdqMwpXHlqAcrypeNMpEHY/0HzjV9Fm7kSBwBc0Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4oklxy/wgrTxFlEzLe6bdqpmXRObeuiuchdtAdQd7U1purj986IU3dHMuUedIpmxBld9VLA6Kvr8smH9fj/v+NA8Nf4UQCdqurfjlkbC4Lf7mFUt+YyEnVohNSbyh7YXsnXsEDiTxwHg3kWvp1kDAWNX6MGgaeEJIAWDHq0QRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUi4kmVR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUi4kmVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661D8C4CEF7;
	Mon, 23 Mar 2026 21:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774300613;
	bh=eQMdqMwpXHlqAcrypeNMpEHY/0HzjV9Fm7kSBwBc0Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUi4kmVRgHcM0q2mM6LMIQKTmdGQBGW/Ck2BIFlb1l9mVtLm7rbwUHdN5zMpHo/aF
	 JwUb2Pw0eNY+zpO1xZvxwORc/khQjhWtdljYMIqPAl8VUoVQWzHzZGoYk8mv+RHER2
	 wjjdKfDZduyS+NMQ+bvun/QPlYmXkoUnOFY1Ui3ebGpGpNEmP2KQmmhgmWUizPxz8s
	 3BXTi1i9U4qjZxu7Gs43Udsg3smtC3HabxYwIY80Ly1o3dzBu5Syk0wnrfgmHllOiC
	 SCp1EQoZksAqVtGUbMz9iyfnV1wmB3oBkMVm6/zgyOYXI/UQFSH8rK7+SfeQ9mU/BZ
	 hGE2nPiba2BQg==
Date: Mon, 23 Mar 2026 14:16:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 05/19] Sync fuse_kernel.h with linux-6.18
Message-ID: <20260323211650.GD6254@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-5-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-5-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:45:00PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  include/fuse_kernel.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> index f0dee3d6cf51b0eb83104c1f30f70b8ba9d710cd..c13e1f9a2f12bd39f535188cb5466688eba42263 100644
> --- a/include/fuse_kernel.h
> +++ b/include/fuse_kernel.h
> @@ -1138,6 +1138,7 @@ struct fuse_backing_map {
>  #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
>  					     struct fuse_backing_map)
>  #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
> +#define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
>  
>  struct fuse_lseek_in {
>  	uint64_t	fh;
> 
> -- 
> 2.43.0
> 
