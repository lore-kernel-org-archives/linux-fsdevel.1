Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526362F83AE;
	Wed, 18 Mar 2026 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827147; cv=none; b=ttJVruEZzrKgzedtTFWC0D5+9iGWFJ5uvniOEYXXQi26X1RC7C6C5UbvG+y3sJF8YAw53rOUHfHrwPzvPhH3UInT5HtNqed9fmXetLGgFyuB337MpJYAuhv55lLCGic2hsCuZhB6ojzSqTqZyAMYG1FC9O4Y6EBCxHia3lTFLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827147; c=relaxed/simple;
	bh=DNXWx/PS5cdxupTj8qBRmq2jPFUNMHVlFyQdRPDtk2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk1/eIJRoNYFIzgYxqQxUXEIfJeivmKIfsXpaKmvd96oneNzBIK5W1EdtTqrSQKGHsEu6OK4sGzJ4Fi4B8Ul81R5+71AGSyWyMuaEjd5fkiaWhIeAU3A4Pticf3VCyoUkvsI2X26mvHT4CCiDq9eRk3Mc/0rPuQOm5bUyVojCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEmyINfd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEmyINfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4B9C19424;
	Wed, 18 Mar 2026 09:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773827146;
	bh=DNXWx/PS5cdxupTj8qBRmq2jPFUNMHVlFyQdRPDtk2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEmyINfd4fD2spNcONW68E7Syk6gG4p7b1h6A1PzHqD1s78VsqBgLwqyrvjP2ravc
	 40alchVqjS8r9T3DUhFlMeFyIBTIz88LhVMUExsRTHDqMlhcz2rNrPLx24ip3Uup+I
	 cyaxbF9pFBuhSi729UznakrqZvEqMKjCNMQCb77AjthNDlgLnyodR0YvlWLhVjob6u
	 903GiNgiA8wrvSYgwAM8boc15uTKzDQgzEQ5sxqIi6XJn2EaAMa64vJOatPDX6YNFU
	 mPPYwG7uJGKAOYVpcAQaVLicazvd0De4R/DpeFg1skqbtiGp/nPd2NTqVtxw6MXCFA
	 EzqsgisFWcwKA==
Date: Wed, 18 Mar 2026 10:45:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Emanuele Rocca <emanuele.rocca@arm.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] coredump: add core_pattern specifier for si_code
Message-ID: <20260318-lanze-dachwohnung-d04d1ff63e12@brauner>
References: <ablsdmLsMKm0z5wt@NH27D9T0LF>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ablsdmLsMKm0z5wt@NH27D9T0LF>

On Tue, Mar 17, 2026 at 04:00:06PM +0100, Emanuele Rocca wrote:
> The specifiers supported by core_pattern include the option to indicate the
> signal number si_signo by using %s. Other than identifying which signal
> generated a core dump (eg: 11 for SIGSEGV), it is useful to know the reason why
> a certain signal was sent. The signal code si_code (eg: 2 for SEGV_ACCERR)
> provides this information.
> 
> Adding the signal code to core_pattern can benefit in particular sysadmins who
> pipe core dumps to user-space programs for later analysis. systemd-coredump(8)
> is a notable example of such programs.
> 
> Signed-off-by: Emanuele Rocca <emanuele.rocca@arm.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 1 +
>  fs/coredump.c                               | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 9aed74e65cf4..20177bd94514 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -170,6 +170,7 @@ core_pattern
>  	%d		dump mode, matches ``PR_SET_DUMPABLE`` and
>  			``/proc/sys/fs/suid_dumpable``
>  	%s		signal number
> +	%n		signal code

Request %F which installs pidfd for the coredumping process into the
coredump helper then use the pidfd info ioctl in you binary with
PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP and you can retrieve the exit
status including the signal that was sent to the process.
