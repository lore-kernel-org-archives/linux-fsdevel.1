Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA1397E6E;
	Mon, 23 Mar 2026 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267047; cv=none; b=OAi1A9JfMgjHZfnqgFDFraAGiemzAkvsVxeTuIpOwLypoujDzbROPp+P+F2OUA4Vhr/IsjX5pgavawqakPXGIiJlDPXLmYMikcHxwggzfGLBv4kwCRkCFWCiqekdGRrWEMSKEky8a7azjYMf+Rur3nSBOrI8svsWEc7cw5moaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267047; c=relaxed/simple;
	bh=9xl0jblLcAk+Jw3wku0pgECHPHMBmUSBE8uuT/sRACY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2TGi/hKYJucpJ5fiiU5TzuAqJ0B7WLpAGISL9j0ezpqxkv40WedoOBR0m3EOxhVhfY76Ta2Dvj9vKGU75IhTjinXMbGagOMt+gcrjvw6pPa3c18i1FKX/7OU1LF6JkQIo8NoYukPsJN5Zn/tGgEDkPMXbbKfRVi/YD0Gv+nepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4kTjAd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4kTjAd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E814C4CEF7;
	Mon, 23 Mar 2026 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774267046;
	bh=9xl0jblLcAk+Jw3wku0pgECHPHMBmUSBE8uuT/sRACY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4kTjAd0ctcslBryKMpW0DhvuzoWmPs1KVSUUFBmNpd1eSjbHnhfWHuA+mUibLAO4
	 mp15uTlblz4lRwBy+azmJlbpw8OKe4Dzk3kBm7MTx1iq3CbFpmt2kWU4fA3GEmyw6X
	 AJKJ+ILoVq3t2dzNGlJKhMGM1nY+xFWf2xW8dNgQzvGqn/z5hepLfcETCktpHD03AX
	 5h1uPFuSSk8Dy9HBXrYQEi3YiK8YNRMxuEXL3MJIKDeujDjXaUJrDFD3phs8cyAWIn
	 1vNo4JNk0HvewEzPkC5wquY9Lsy50W5zpV0+Y5LrXWyVPXi1/2qdqJqTO7D6guMVPg
	 f5E7tHT8izwkw==
Date: Mon, 23 Mar 2026 12:57:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Emanuele Rocca <emanuele.rocca@arm.com>
Cc: linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3] pidfds: add coredump_code field to pidfd_info
Message-ID: <20260323-hochsehen-kurort-862912a1d7b5@brauner>
References: <acBRj-DSCpqlKt6t@NH27D9T0LF>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acBRj-DSCpqlKt6t@NH27D9T0LF>

On Sun, Mar 22, 2026 at 09:31:11PM +0100, Emanuele Rocca wrote:
> The struct pidfd_info currently exposes in a field called coredump_signal the
> signal number (si_signo) that triggered the dump (for example, 11 for SIGSEGV).
> However, it is also valuable to understand the reason why that signal was sent.
> This additional context is provided by the signal code (si_code), such as 2 for
> SEGV_ACCERR.
> 
> Add a new field to struct pidfd_info called coredump_code with the value of
> si_code for the benefit of sysadmins who pipe core dumps to user-space programs
> for later analysis. The following snippet illustrates a simplified C program
> that consumes coredump_signal and coredump_code, and then logs core dump
> signals and codes to a file:
> 
>     int pidfd = (int)atoi(argv[1]);
> 
>     struct pidfd_info info = {
>         .mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
>     };
> 
>     if (ioctl(pidfd, PIDFD_GET_INFO, &info) == 0)
>         if (info.mask & PIDFD_INFO_COREDUMP)
>             fprintf(f, "PID=%d, si_signo: %d si_code: %d\n",
>                 info.pid, info.coredump_signal, info.coredump_code);
> 
> Assuming the program is installed under /usr/local/bin/core-logger, core dump
> processing can be enabled by setting /proc/sys/kernel/core_pattern to
> '|/usr/local/bin/dumpstuff %F'.
> 
> systemd-coredump(8) already uses pidfds to process core dumps, and it could be
> extended to include the values of coredump_code too.
> 
> Signed-off-by: Emanuele Rocca <emanuele.rocca@arm.com>
> ---
> Resending as a new thread, apologies for sending v2 as a follow-up to
> the kernel test robot instead!
> 
> V1 -> V2: Add coredump_pad to struct pidfd_info to ensure the struct has
> the same size on both 64 bit and 32 bit systems. The issue was spotted
> by the kernel test robot.
> v1: https://lore.kernel.org/lkml/ab29J6KsQm8Xg3LR@NH27D9T0LF/
> Link: https://lore.kernel.org/lkml/202603211842.JCwUVYTI-lkp@intel.com/
> 
> V2 -> V3: Sending as a new thread, same as v2 otherwise.
> v2: https://lore.kernel.org/lkml/ab68fUmCK4An1UH-@NH27D9T0LF/
> 
>  fs/pidfs.c                                    | 12 ++++---
>  include/uapi/linux/pidfd.h                    |  4 +++
>  .../coredump/coredump_socket_protocol_test.c  | 26 +++++++++++++++
>  .../selftests/coredump/coredump_socket_test.c | 32 +++++++++++++++++++
>  .../coredump/coredump_test_helpers.c          |  4 +--
>  tools/testing/selftests/pidfd/pidfd.h         |  5 +++
>  .../testing/selftests/pidfd/pidfd_info_test.c |  1 +
>  7 files changed, 78 insertions(+), 6 deletions(-)

Please split the kernel code from the selftest code into separate
commits. Thanks!
