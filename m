Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980037E319;
	Mon, 23 Mar 2026 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267988; cv=none; b=Exxp9v25Nih8spUqq+MSykvb/0JcFCF2igLcLz25UfASauaOiAO0LoilBD3rYcqGxDNFnpQoNbL5h6vqzM9Xopoprd14Shjgtrsny/d5Nj/29IevNwfrj0lSM+VvHXHLKrH4j8NIt7m7uOvpRiS7/Hdfk1EyN2Bbpv/HtUiZxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267988; c=relaxed/simple;
	bh=cqdhvUAr2LmeoLoJmg4TpwIe6hnoe2vEbQIGpTDLIqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtePYwMhQybAPv5nbkPIdStSEYGwP3kplTr8b+My8uxHZGx50EEz5ZZs7ABezRWJrOWjbyaQkoNqcrNd8nw6vjvO7nYXgLBFOtD5NrqAlH1ee5a7QqBuYyd1Jp2xKDMuIX3nZGMFigcVoqDxcS4FcxoozYO486IOyyWXQ3t+9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koU0tkLu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koU0tkLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453D4C4CEF7;
	Mon, 23 Mar 2026 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774267987;
	bh=cqdhvUAr2LmeoLoJmg4TpwIe6hnoe2vEbQIGpTDLIqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koU0tkLupaMRD6Y8beUsYLNqatULLIXYwhzGBxGxzvHv0zME9fDg06RWzkm1UEd09
	 HuYSKmCUWbbYXz03y63B94916NPGhfonivW+RKn0s97DuuNBVMCnWDQQoWi9roYaPc
	 2pR/BOI/5Cz0A7/z+Ym9Uha+B198UMupew5UpymTxkv461n7lfsHMnQBhGS2PKLTQ+
	 uwJyoFiefEZKiIGgD5agT/cbjNSBJllbEKEq4tIN8+7CBZfv7lvhWzmiD8gVEbuHba
	 NfPphpeIX3Px3150SXlBD+GaWDqapDMwoH2J2P6iEARAOqYosoQuSzioytiu1HkRrH
	 2w6rPa9JV9teg==
Date: Mon, 23 Mar 2026 13:13:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Francis <David.Francis@amd.com>
Cc: linux-kernel@vger.kernel.org, Christian.Koenig@amd.com, 
	Alexander.Deucher@amd.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fdinfo: Option for public fdinfo
Message-ID: <20260323-neugierig-meerschwein-31b6daaa1db9@brauner>
References: <20260316183828.3354343-1-David.Francis@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316183828.3354343-1-David.Francis@amd.com>

On Mon, Mar 16, 2026 at 02:38:28PM -0400, David Francis wrote:
> We want some GPU information to be publicly available to all
> processes for basic system-wide profiling (think GPU versions
> of top).
> 
> This information is available in fdinfo and not easily exposed
> by other interfaces.
> 
> Add fd_op flag FOP_PUBLIC_FDINFO, which, if set, makes the fdinfo
> for that file available to read for processes without ptrace
> permissions.
> 
> Note that this makes public how many files each process has open,
> and what their fds are.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---

Eew, please let's not. Add an ioctl if you need to be able to retrieve
that info.
