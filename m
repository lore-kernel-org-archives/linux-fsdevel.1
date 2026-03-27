Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A8299A81
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581601; cv=none; b=oQzI0QsC942AL+YOfMqCM1YUfTFqSMJkSjUt7VQz9p4Hoj6mDaMZExKrQ4bxVgqwF9OL04dYMTHMjHZDAxl/pngr6O+0uI0Q/vLJ8ViHRBxPLlom69PMS84PMvDfWSeD7zVdrotB8T+G19XHWY91kjFOv2ao9XfR2RNN0gHoa6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581601; c=relaxed/simple;
	bh=tD95k9ZqiEYPBVLduG0z136wErsnp4EhGV35Wmt9EwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM6TRUzDeF9wd99oXy9Rtb4OKYPUG983HWYZIUDFhAfqhM0KksEcrYyTwqcmGgevm11yAp1SVubcYj27mrK9IWH0XwxVhvMTt3v+dM7Ck9ERO729Gj5fIqJMuNCUkcb8PKNzRF5kwgut+Z0uK4cr/JwcoiX/tbQIBT55G4G7D9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbZA+Of/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbZA+Of/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CB5C116C6;
	Fri, 27 Mar 2026 03:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774581601;
	bh=tD95k9ZqiEYPBVLduG0z136wErsnp4EhGV35Wmt9EwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbZA+Of/Kbc2gcHVZAqwJYZZYnTrboieAhLZcLB3HFi1hNq6Hkx8niDi2bT1QevFn
	 wpcifzmwzTrP2OmROPR2qRe50tB3D4hBKgAE9DmXuj1CxQrAepS0Xa2HT4tOej8vVb
	 zR7BcnH+VItkgghwYuInNjo/VdkxuIJU4Mho/wAt7rCL+EM/IlTW4IjcARjchShSVn
	 bKsI+yIvDZrt0BLiWzFSQ82BbvBcILHomdC7tt7euKJlUceuqmX/czFzokuhdiK6mE
	 /2NW3LqWXzk/PiAalwykrv81BwCKr0nX3nTTK/weEQDUNdfRqYJWp5U1peVTCOdldT
	 PIbiuNR4lthJA==
Date: Thu, 26 Mar 2026 20:20:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 01/25] ci-build: Add environment logging
Message-ID: <20260327032000.GJ6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-1-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-1-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:34PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> It is very hard to see what exactly fails, as everything
> is run from the same script.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

This seems reasonable to me...
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  test/ci-build.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/test/ci-build.sh b/test/ci-build.sh
> index 8b019a0b5e52c1af0eee510ede21785d584e8414..799f13b2911fac47b0bbb2d445ec22a6f40f065d 100755
> --- a/test/ci-build.sh
> +++ b/test/ci-build.sh
> @@ -30,6 +30,20 @@ export LSAN_OPTIONS="suppressions=$(pwd)/lsan_suppress.txt"
>  export ASAN_OPTIONS="detect_leaks=1"
>  export CC
>  
> +log_env()
> +{
> +    echo "=== Environment ==="
> +    echo "CC: ${CC}"
> +    echo "CXX: ${CXX}"
> +    echo "LSAN_OPTIONS: ${LSAN_OPTIONS}"
> +    echo "ASAN_OPTIONS: ${ASAN_OPTIONS}"
> +    echo "UBSAN_OPTIONS: ${UBSAN_OPTIONS}"
> +    echo "FUSE_URING_ENABLE: ${FUSE_URING_ENABLE}"
> +    echo "FUSE_URING_QUEUE_DEPTH: ${FUSE_URING_QUEUE_DEPTH}"
> +    echo "Valgrind: ${TEST_WITH_VALGRIND}"
> +    echo "==================="
> +}
> +
>  non_sanitized_build()
>  (
>      echo "Standard build (without sanitizers)"
> @@ -54,6 +68,7 @@ non_sanitized_build()
>              build_opts=''
>          fi
>  
> +        log_env
>          meson setup -Dprefix=${PREFIX_DIR} -D werror=true ${build_opts} "${SOURCE_DIR}" || (cat meson-logs/meson-log.txt; false)
>          ninja
>          sudo env PATH=$PATH ninja install
> @@ -79,6 +94,7 @@ sanitized_build()
>  
>      mkdir build-san; pushd build-san
>  
> +    log_env
>      meson setup -Dprefix=${PREFIX_DIR} -D werror=true\
>             "${SOURCE_DIR}" \
>             || (cat meson-logs/meson-log.txt; false)
> 
> -- 
> 2.43.0
> 
> 
