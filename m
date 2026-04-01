Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4FA371D0A;
	Wed,  1 Apr 2026 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076242; cv=none; b=Rq9gA89yuFYZmSLE4QMVUfKCjzvm9An6pgFhrfkhym/QkMBGAfO51eAn3zJSqZ9sVWEdTHplULkBa2kPaytQ8lp/w2ag2bXKG4YKmNjRuAYtAPOw2S9kyyIm89lFNuqD0f0RVWpX8IGs2KI3zqkAgwIsEmfNz0/GUW7x3c24ziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076242; c=relaxed/simple;
	bh=kTOS3uekJiiJ5a6z93beysMcrDQebo3EZ8N7JGrOBNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIFcZDRf86VIPmb/Pzyj7aRsuRGH4LJO7CCFLr1z+/cx2cNl97UwBG6aKGkj3+NgMsSXrJOx6ruGZI1Xyq2W0wUL0rH54679kgpdesYxsri2XA9MCd6GLWX+am/xWlEa5B/2+osDrxHPDGKWW6mEu2TKrFfg4GAoXEsCpJK2K7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVC1G+9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVC1G+9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCACC4CEF7;
	Wed,  1 Apr 2026 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775076241;
	bh=kTOS3uekJiiJ5a6z93beysMcrDQebo3EZ8N7JGrOBNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVC1G+9qBK5pCrZkNWxdglydUIgueJO94ACXdf/Xztp3Npu7WHpWWPpRC59QtVDTu
	 jwIRDs1ZwWfKffRZq2/C25rUuH6bXOvsqbOiXkq52vDgNWX+Xl0ozaeaJaVkqMj9Qw
	 qRK1Iyl1gtxyEUD/5R3EOGrpZQ6DsKiqPYLCnjsiqW/FsF7zNnQy1TltcT7+JunXGo
	 dNEDAzO4oj9lOaoimycNQyMyoz9aBXvMdIg14QAYWoK+iT/XYGgeQR9dorQlRoLt0c
	 57LAT8WKdtDLr2DgJfw+aQTxzcZW5dW4HdTzhGPuV1lsSzbLZMem3p2bDkwbZBnF3D
	 VUuBjnWo7FERQ==
Date: Wed, 1 Apr 2026 13:43:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] execve: block Emacs binaries
Message-ID: <20260401204359.GD2466@quark>
References: <20260401131226.4011156-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401131226.4011156-1-mjguzik@gmail.com>

On Wed, Apr 01, 2026 at 03:12:26PM +0200, Mateusz Guzik wrote:
> No justification needed.
> 
> A new errno is introduced to indicate what happened.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/exec.c                        | 16 ++++++++++++++++
>  include/uapi/asm-generic/errno.h |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 9ea3a775d51e..2e954b31e3a2 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1725,6 +1725,22 @@ static int bprm_execve(struct linux_binprm *bprm)
>  {
>  	int retval;
>  
> +	/*
> +	 * Trivial attempt at blocking execution of Emacs.
> +	 *
> +	 * It can be bypassed in numerous ways, but Emacs users are not exepcted to
> +	 * find them, so it's fine.
> +	 *
> +	 * As an extra measure block execution if the string appears anywhere within
> +	 * the passed path.
> +	 */
> +	if (strstr(bprm->filename, "emacs")) {
> +		/*
> +		 * Disgusting!
> +		 */
> +		return -EMACS;
> +	}

Won't this break some existing text editing workflows?  To ensure a
seamless transition I'd suggest also embedding a copy of a proper text
editor into the kernel image, and making the kernel automatically
replace the emacs binary with it.

- Eric
