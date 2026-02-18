Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DDC2ECEA3;
	Wed, 18 Feb 2026 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450891; cv=none; b=nLcPfiPR+Si4A1zKnkzhEwBvVKLCFdio5ol5RXbaJiw6zJa6ZQBWZbF0Yfflk4h9QSo2j7RnaQIDyX6RRS5fAEj06tX1umy5mY6Lf/9FBPvjNIDhBhcdYN9ORgljWrzRThT+JHl51iA0DUP3mQEZdYSzvghE+2oXhtIr6hj1MY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450891; c=relaxed/simple;
	bh=/IflDQzD1mZk9rjG4pZkPRLVYTGkljhA6AxzxuIUJiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZJqI9fNyCBakuAvW2c/JlJth+Am9n4tE7O/jQ1ZSS4YKq7eEbJO0Q6V1pIKy7feL2iklASvkXRqNZZi+iLcBhDj033PbGdRcfry5HiAPGemhTtQhBgoDddRK1YoVGdCTp7SCU0Jeb2Eu0t8n+ENquzUHUQwlc7uW8pnf0pecI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDeRLZ2N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDeRLZ2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D7DC116D0;
	Wed, 18 Feb 2026 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771450890;
	bh=/IflDQzD1mZk9rjG4pZkPRLVYTGkljhA6AxzxuIUJiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDeRLZ2N+mftD8U/rpydot+/RR5oKjcvZZgi6mrt6x020Dev65ezbvAaUWf99d5e+
	 ouAqWD8bJ3TYTMTvToI+xqVjwifi/9wkwO4ZOgWZnZYIOv/haJsxi056KGNtVh4PHR
	 XqslNQ+VjQe9+svEfYzNGLWixIGfOqh6MzDzmZ7fPeIFM+Q/RRRs99plv6Tb0mZZmt
	 Xip/WO168g56PS+9LeEl2SV2Nxod+/2K9EMT1NZOAFuO+KSo3psQtO7Y9apcsfLKcp
	 46tbUxNxQBYfNzPFI/tTDEKxP2F9B2cGHoyeYPc43jsx0QCk93J6Zclo/LJiWOB5sA
	 Ny9gDvGJGhp3Q==
Date: Wed, 18 Feb 2026 13:41:29 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fsverity: fix build error by adding fsverity_readahead()
 stub
Message-ID: <20260218214129.GB2128@quark>
References: <20260218012244.18536-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218012244.18536-1-ebiggers@kernel.org>

On Tue, Feb 17, 2026 at 05:22:44PM -0800, Eric Biggers wrote:
> hppa-linux-gcc 9.5.0 generates a call to fsverity_readahead() in
> f2fs_readahead() when CONFIG_FS_VERITY=n, because it fails to do the
> expected dead code elimination based on vi always being NULL.  Fix the
> build error by adding an inline stub for fsverity_readahead().  Since
> it's just for opportunistic readahead, just make it a no-op.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602180838.pwICdY2r-lkp@intel.com/
> Fixes: 45dcb3ac9832 ("f2fs: consolidate fsverity_info lookup")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  include/linux/fsverity.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next

- Eric
