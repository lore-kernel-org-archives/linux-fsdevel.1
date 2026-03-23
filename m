Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91D373BE4
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299792; cv=none; b=rDpuc7mu5a+96bkU+AOzddoTdxJgA/G7rM9Si+/haG6tC1AlAvZi1QWMt9RIly8T+y4RqI2du6t+qhq3XMBwePbJ4BcizZ5wQQwQC421xAlI9hYsSPTw4K5IjehVxLaqvmdviG/YXlKNM2wQ6PBz5+voYsf3b0sHS0c1qJZUwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299792; c=relaxed/simple;
	bh=pf/MxoLKRA1uDDWxf8KfdmB5rvOJ6ScGAkr5fmX9Q+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E19x91pCqJcjI63MU03pdf1DCtIGMLwi54J+LH/+PWYTNLjYdckF5qHYyIAYCdVo4ez/bedCp1pUw01lZA3Tjq4T19CF+bNsXeWSW2635TaDy/eV34UN4kUVpLSdKZnRFWJ0p1VZaJYDMGFXKpc3xTXbfU19FK+18v8rv2dBaYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeuV0UPb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeuV0UPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFB9C4CEF7;
	Mon, 23 Mar 2026 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774299792;
	bh=pf/MxoLKRA1uDDWxf8KfdmB5rvOJ6ScGAkr5fmX9Q+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FeuV0UPbeUJ79+1btsNoHEf27Vv/KxEQXWl+YO8qEI6bt2KQ4NCSY3ktuzbzvfx3M
	 5DC9p4Il4mrHDkWuNLw78PtVGCPX4r1jTZDQyCIHX2iuSFSUUUPJOT3/OdVyuonBuq
	 AO3BS3IOr3hNxoZyRc/VDYfEHLQtQJXXB1pcRSoqVcQX2oQWsYBd2e6IqGPg+fZc7+
	 vLtctdM75FQ3blit1Nl+ynOy0R+VWN6KvuRpmOsN/1PLdU+csvuZPfO7Xnnj6e/Q5x
	 LeRmvZLr8Xu2EXnW6X03KFHxxRlQDoVyvAODfpmorvpKvGhMI21si+NdOE+trD5S1o
	 B6FvsJIzLj2eg==
Date: Mon, 23 Mar 2026 14:03:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 02/19] Add 'STRCPY' to the checkpatch ignore option
Message-ID: <20260323210311.GE6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-2-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-2-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:44:57PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> checkpatch.pl is a kernel copy and the strcpy warning is not valid
> for libfuse.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

I agree with this, having been bonked on the nose for it before :)

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  .github/workflows/checkpatch.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.github/workflows/checkpatch.yml b/.github/workflows/checkpatch.yml
> index 4a98c91cddeab686c782a1d34cd5d15f86f0b42d..8dead95b065bc81449a98fa7ea94fac7463d2334 100644
> --- a/.github/workflows/checkpatch.yml
> +++ b/.github/workflows/checkpatch.yml
> @@ -35,7 +35,7 @@ jobs:
>            fi
>            subject=$(git log -1 --format=%s $commit)
>            echo "Checking commit: $commit - $subject"
> -          if ! ./checkpatch.pl --max-line-length=100 --no-tree --ignore MAINTAINERS,SPDX_LICENSE_TAG,COMMIT_MESSAGE,FILE_PATH_CHANGES,EMAIL_SUBJECT,AVOID_EXTERNS,GIT_COMMIT_ID,ENOSYS_SYSCALL,ENOSYS,FROM_SIGN_OFF_MISMATCH,QUOTED_COMMIT_ID,PREFER_ATTRIBUTE_ALWAYS_UNUSED,PREFER_DEFINED_ATTRIBUTE_MACRO  -g $commit; then
> +          if ! ./checkpatch.pl --max-line-length=100 --no-tree --ignore MAINTAINERS,SPDX_LICENSE_TAG,COMMIT_MESSAGE,FILE_PATH_CHANGES,EMAIL_SUBJECT,AVOID_EXTERNS,GIT_COMMIT_ID,ENOSYS_SYSCALL,ENOSYS,FROM_SIGN_OFF_MISMATCH,QUOTED_COMMIT_ID,PREFER_ATTRIBUTE_ALWAYS_UNUSED,PREFER_DEFINED_ATTRIBUTE_MACRO,STRCPY  -g $commit; then
>              echo "checkpatch.pl found issues in commit $commit - $subject"
>              exit 1
>            fi
> 
> -- 
> 2.43.0
> 
> 
