Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9E800
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310676; cv=none; b=HSAU85KGOtQvz5B9GoF2zmZFL0fJigcMShFCzTB+3TuMKero4Pl0HJ7eCX3sRwME6H6tkjF+4qHrmuv/tmL5OKtiYdTkTWVcOY014d76OfnXtimJUtGlwOitRC47qBayDRaNtoOLD0zAJB0RVN4ekwnN/U9PTMcQoSZ0tGTsgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310676; c=relaxed/simple;
	bh=RjVOR47qp24IAKEEe0ulRlNxqwb5qlwoFpI9Bby45rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czYdKYp+OWnead9F+o63ybu4Peyno+4JES8W/6Xm16fss+1/i5gKXiaCtyvHL4hTN7Q/5LfHWJwWqyCOm/nyQbp7gBEQY8XqTB/IEXXiBrvdlWhab6XrKlqySeitDFzwMQfA/1YhTINQ6nOUrYR0B9Dj2VfoJmJDvtcJFxlfk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd1Kgcu7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd1Kgcu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE73C4CEF7;
	Tue, 24 Mar 2026 00:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774310676;
	bh=RjVOR47qp24IAKEEe0ulRlNxqwb5qlwoFpI9Bby45rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cd1Kgcu7xA+BOlyd2ZurQi17eGiEe827ZSRv2CUGHCsSMevA1r8VK9y8d7S4Ogcmn
	 GtfjFweZgEHVaovJm3Q3ROS/k+Itn4i+rets1eibX1Kt+VhFqIFg+Jl70mEjb5oZSG
	 Ng1V3ambxEGT5k7H0YeDSstkDeHUL4VVlg8e4KpnM+405/IOdrH8aHY5WkmBgLP56A
	 4Ckfa5IxM3XcKgRqTt/AYqMKFKaQ9z2yfGCCKLhR5Pi64TsgkRdUHtrV9bbrXqW13X
	 HA4B43neXNtKONvbPQp4lKMtP356HUrcVBmgWxaCcVG4/W9Z/ZrSJQ1JK/w7M39TE1
	 Fn6rakao9gadw==
Date: Mon, 23 Mar 2026 17:04:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 13/19] Add fuse_session_set_debug() to enable debug
 output without foreground
Message-ID: <20260324000435.GN6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-13-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-13-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:45:08PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> One might want to print debug out in background mode, which the command
> line parameter does not easily allow. Or one might want to enable and
> disable at run time.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Woot!  Have been wanting this for fuse4fs for a while :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  include/fuse_lowlevel.h | 12 ++++++++++++
>  lib/fuse_lowlevel.c     |  5 +++++
>  lib/fuse_versionscript  |  1 +
>  3 files changed, 18 insertions(+)
> 
> diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> index d8626f85bdaf497534cd2835a589e30f1f4e2466..d85929e291a77de8caad7d6b3d9ac5b092ce0e62 100644
> --- a/include/fuse_lowlevel.h
> +++ b/include/fuse_lowlevel.h
> @@ -2441,6 +2441,18 @@ int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
>   */
>  void fuse_session_want_sync_init(struct fuse_session *se);
>  
> +/**
> + * Enable debug output
> + *
> + * This allows to enable debug output without a command line parameter and
> + * without the enforcement of the command line parameter to run in foreground.
> + * The daemon needs to handle either fuse_log output via stderr, or
> + * redirection to its own logs or via syslog.
> + *
> + * @param se the session
> + */
> +void fuse_session_set_debug(struct fuse_session *se);
> +
>  /**
>   * Check if the request is submitted through fuse-io-uring
>   */
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index b10def03f3666757d312f87f177a560483691d6f..a7293a3898c37c3877eadf965d310ae2aa5cc2d1 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -5007,3 +5007,8 @@ void fuse_session_want_sync_init(struct fuse_session *se)
>  		return;
>  	se->want_sync_init = true;
>  }
> +
> +void fuse_session_set_debug(struct fuse_session *se)
> +{
> +	se->debug = 1;
> +}
> diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> index f1765d39e13bc9b1f53e625b9a091c5fa53f5afd..64bf75ac2cb252d066ac301be8fc024b59f903ac 100644
> --- a/lib/fuse_versionscript
> +++ b/lib/fuse_versionscript
> @@ -230,6 +230,7 @@ FUSE_3.19 {
>  		fuse_daemonize_start;
>  		fuse_daemonize_signal;
>  		fuse_daemonize_active;
> +		fuse_session_set_debug;
>  } FUSE_3.18;
>  
>  # Local Variables:
> 
> -- 
> 2.43.0
> 
> 
