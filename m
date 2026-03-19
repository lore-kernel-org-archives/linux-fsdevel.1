Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D837DEAB;
	Thu, 19 Mar 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773916305; cv=none; b=pxlsbl75x4X8rmrEJkjJynRBlkxQduONEF3DW+h8VhvdN2UWP1oDLq3vfohewrgWXY6gUBA7wXp5YpF2jFdDvCr6VmcubeOdAq9Ua0giR1ayeByV+OMP6vQjKM+Goc3wHNM9KQs/YUxBXDelYSa8fc9Atu8u7oj3Xn4WXr7ey8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773916305; c=relaxed/simple;
	bh=AhYWom1zgeom/WoBc23+E1WeT+xUHpYrdzSzn/pX54g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8wXSCug89Bp6ncyySCaCwrS8U+N2N0/HRnqLPJddVpP95bk6jHAnYqQpEh2yHS++5eu6nH2b/onr1UOr7IRE3awzJNnnsbhzvOS5cV/NVRlpSwjN964sgIcaOKb8bUJ0ec3xEShxZ/zhKMHydaLkzGwGmVcpRF9HNl7HSEz7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBfpTewJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBfpTewJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4897C2BCB1;
	Thu, 19 Mar 2026 10:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773916305;
	bh=AhYWom1zgeom/WoBc23+E1WeT+xUHpYrdzSzn/pX54g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBfpTewJVAwpPuZAK++FKIr4oBz0RWCIHSd9R7QzQcCTQH0hjvP660Affw7BZeNsn
	 gGsvfqAZjmtLPxG86ticMfW5UCFcSEWqcadeS5qDIEr5lA664pHTmSLFfE28AUIlo/
	 qX+tWawiWLtJVy4wXJ0x6gHBX3ulTnydwkbeA/4qfHxMqMBCB2jNfC8U8VrvCWkBhY
	 jxtdJdRq4qIIHSdzNoiJvwDsDile55RPXHGZqkeaH9B3a1jZhOupPB57kOZ6SL+S7c
	 whXnJw+qjAtVY0Ryl/zq7M7O5qlL9XGb44TOcB5h09j0gjZ1rMDGHVP2d6H75FPigY
	 RgoVrSOenpPGg==
Date: Thu, 19 Mar 2026 11:31:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: Emanuele Rocca <emanuele.rocca@arm.com>, Jann Horn <jannh@google.com>, 
	Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] coredump: add core_pattern specifier for si_code
Message-ID: <20260319-detektiv-antrag-52ba733ccd8f@brauner>
References: <ablsdmLsMKm0z5wt@NH27D9T0LF>
 <20260318-lanze-dachwohnung-d04d1ff63e12@brauner>
 <abql6_yzm1E_-PKR@NH27D9T0LF>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abql6_yzm1E_-PKR@NH27D9T0LF>

On Wed, Mar 18, 2026 at 02:17:31PM +0100, Emanuele Rocca wrote:
> Hi Christian,
> 
> On 2026-03-18 10:45, Christian Brauner wrote:
> > Request %F which installs pidfd for the coredumping process into the
> > coredump helper then use the pidfd info ioctl in you binary with
> > PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP and you can retrieve the exit
> > status including the signal that was sent to the process.
> 
> Correct me if I'm wrong, but PIDFD_INFO_COREDUMP seems to be setting
> coredump_signal, which is siginfo->si_signo? That information is already
> available by using the %s core_pattern specifier anyways.
> 
> What I am looking for is si_code instead. Perhaps a field could be added
> to struct pidfs_attr and set in fs/pidfs.c similarly to what is currently
> done for si_signo?

I see. I don't have a problem with doing that. Let's rope in @Jann and
@Oleg to see whether they have any info-leak/security concerns around
this.
