Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081891A9B46
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894597; cv=none; b=OY/LrnguEze+6TZma6sii/yiCKZcqgm5EMYzCXU8+ZHaZQt1eKRLRVx2zNDykWx/BHNL5uGylMGmi5ousXU1OpyotV0VkvcXqJkZokDBQpygv0bQvNZ/PDNSUjhRckemUpjXBF7t7e+08MFu7/yTOhZvZ0mmwvRol/RbRnShleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894597; c=relaxed/simple;
	bh=fxpqoj3IwDm3dAFijO0NkXUcmlELY71sd7aMWtOTGC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdDL2ZcYMcOAN96cBxLRiYynmSSoMlTuEQPic0COHRG4CK+nrGTOoUd0fPzeUASyqlof756Ev+BZ1wJ+u75Zs4NJ5dm1jigpTGIYSIJXRtHsoXSnWEBrmVwmnzuL/0L6uTZJR7gFOpvS96UvpPZ6kGWlf3eJyCHIQFQUIEfg5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dhex0VRY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dhex0VRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98686C4CEF7;
	Mon, 30 Mar 2026 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774894596;
	bh=fxpqoj3IwDm3dAFijO0NkXUcmlELY71sd7aMWtOTGC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dhex0VRYuqydjLQLmv9lWS2T9yn8+b9sWOHNTZknN8fpaKz7vPqIIF2dgIy5irDQ5
	 z3jEhnit6G99cni1RUhOb8uoey2Ef1e/3NNJQ6TRfx194jBNf2eoq1xkCMPRNmjpnw
	 +MqDkVVexqBkwBmIKm3vZ1LlYhBDq7uFg+6CSLjW1UXDxG0CIzXJhAPiRuUE4ADD20
	 JHF2Ggmm2yd9gsFH2MHZeJTtYfjNwhs0nv3e61h3j8Tq9ZYEdkLXymOy6VWbKstbI/
	 Y6GxNUdawx9ZUs9sBLvyJxSnPfwUtg4WVCgVArOnDW3c5dBZZwY8yNhrXIGk3HU7fM
	 gEK0zzS49tyJQ==
Date: Mon, 30 Mar 2026 11:16:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 12/25] conftest.py: Add more valgrind filter patterns
Message-ID: <20260330181636.GV6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-12-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-12-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:45PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> Valgrind complains that it does not know the fsmount syscall,
> pytest checks for warnings, find that and fails the test
> 
> --14936-- WARNING: unhandled amd64-linux syscall: 430
> --14936-- You may be able to write your own handler.
> --14936-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
> --14936-- Nevertheless we consider this a bug.  Please report
> --14936-- it at http://valgrind.org/support/bug_reports.html.

Perhaps it's time to upgrade the CI system?

Oh.  valgrind didn't add fsmount until April 2025 even though the
syscalls have existed since 2018.  Even Debian 13 doesn't know:

--1794-- WARNING: unhandled amd64-linux syscall: 430
--1794-- You may be able to write your own handler.
--1794-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--1794-- Nevertheless we consider this a bug.  Please report
--1794-- it at http://valgrind.org/support/bug_reports.html.

Well I'm not surprised, the manpages didn't get merged until last
December.

<sigh>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> fuse: fsopen(fuse) failed: Function not implemented
> =========================== short test summary info
> 
> Obviously we want to filter our valgrind warnings.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  test/conftest.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/test/conftest.py b/test/conftest.py
> index 291c9199b9860d664600638213382bd8cc182104..45e9672a92e687980ba93cb25ef711ad1c2e3633 100644
> --- a/test/conftest.py
> +++ b/test/conftest.py
> @@ -67,11 +67,16 @@ class OutputChecker:
>              cp = re.compile(pattern, flags)
>              (buf, cnt) = cp.subn('', buf, count=count)
>  
> +        # Filter out Valgrind output lines before checking for suspicious words
> +        # ==PID== prefix: Valgrind standard messages (errors, info)
> +        # --PID-- prefix: Valgrind warnings (e.g., unhandled syscalls)
> +        buf = re.sub(r'^==[0-9]+== .*$', '', buf, flags=re.MULTILINE)
> +        buf = re.sub(r'^--[0-9]+-- .*$', '', buf, flags=re.MULTILINE)
> +
>          patterns = [ r'\b{}\b'.format(x) for x in
>                       ('exception', 'error', 'warning', 'fatal', 'traceback',
>                          'fault', 'crash(?:ed)?', 'abort(?:ed)',
>                          'uninitiali[zs]ed') ]
> -        patterns += ['^==[0-9]+== ']
>  
>          for pattern in patterns:
>              cp = re.compile(pattern, re.IGNORECASE | re.MULTILINE)
> 
> -- 
> 2.43.0
> 
> 
