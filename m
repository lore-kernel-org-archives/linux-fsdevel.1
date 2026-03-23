Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771662D7D3A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300145; cv=none; b=bb80I25TwcP0zX+gxkn5hDLaHNbCKvn4HDJmw8/WrreJTik+nN2gkqki/wM6AYz/8lOARtJv8AgJhsS9fFsLRg3a2jiIP96jsT28zl7Y7lO/SvGuFPRPrJZuLD2Q4j6t9+T91PQ9wTWxAnb4V9g0CnRs6XAQRwSV18OTOsqhE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300145; c=relaxed/simple;
	bh=yBYWQ3DZIE/IbPPYRNgNwEIi77CeAiUz245cTojxh+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzof83MvRpiWtDtnWJ0jaqLWMbbJXD+4bblhZR3t88s4foWKfs8nfPpl3pPI0I6LEgE1mmNUOgIVZ7BbvKHM2bbDetx1yy+kM38AzfmBuqNyH5x9kFDsuddBYTkQxCwV3D14eW8BgOhGZ4gDHcS0CJSoazr/9nWZ2gND4gIvLT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHYQMR2E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHYQMR2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6EAC4CEF7;
	Mon, 23 Mar 2026 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774300145;
	bh=yBYWQ3DZIE/IbPPYRNgNwEIi77CeAiUz245cTojxh+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHYQMR2EpT5J663kXJIFCV/Ebyt5aEWSTcFa833Qbdsy5Cw/jG7JuERdl+sL8TqPP
	 L+2z9kThVQCTy9jDySgX6mxayeZo+H5S7WJJpUU8NQENeR3Ldqa+z1sozJL+wmv8fG
	 AonVS8EdfzwqCm23YiJiNLQqmrcmvqgOBsvw6O1TsOK8fiR/6pYTiAbiHddGNpuKKN
	 6gAQqpPS7bfJVsJu39kckDLlAm+Q8CrGYb6OnlO4xsEVhWPuwleMcLk07ysuY+++pM
	 BoUqjogzi9E0XaumwVyt0sSx+4pow7I8A+r6mljDiZLitP3EZJh3pmErvvp9entBms
	 G6TvMs3tDqklQ==
Date: Mon, 23 Mar 2026 14:09:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 03/19] checkpatch.pl: Add _Atomic to $Attribute patttern
Message-ID: <20260323210904.GF6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-3-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-3-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:44:58PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> WARNING: Missing a blank line after declarations
> +       int init_error;
> +       _Atomic bool terminate_mount_worker;
> 
> This change should go to linux upstream.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

That seems fine to me, dunno if the kernel people will accept it.
But for here it's certainly ok since libfuse uses _Atomic variables.

Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/checkpatch.pl b/checkpatch.pl
> index 9eed3683ad76caffbbb2418e5dbea7551d374406..2d44e0e6edac303731c7637de00ed35d7b1dfcb7 100755
> --- a/checkpatch.pl
> +++ b/checkpatch.pl
> @@ -520,7 +520,8 @@ our $Attribute	= qr{
>  			____cacheline_aligned_in_smp|
>  			____cacheline_internodealigned_in_smp|
>  			__weak|
> -			__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\)
> +			__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\)|
> +			_Atomic
>  		  }x;
>  our $Modifier;
>  our $Inline	= qr{inline|__always_inline|noinline|__inline|__inline__};
> 
> -- 
> 2.43.0
> 
> 
