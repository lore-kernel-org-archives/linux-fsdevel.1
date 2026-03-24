Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B43E3176;
	Tue, 24 Mar 2026 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348096; cv=none; b=RlJaER4/NL2mNy28CPirleyXqa7k5vUHlqScMg3mexI0r6Vba2PQvZw1vA5DHHrN7sdfOYcfwaSp41t6pwCnJzczA71zrDC9aG4DsaokPo5N5zzZMTHWcZydI9HgIbCDSaKf4LPRRtAy3Qp5E5VlMPcueJ9yk/4qSdeYe1vL1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348096; c=relaxed/simple;
	bh=6sgVnhGfx/Gr8MffbxZCAPHDZSVU/xN0vvzwT8HpMXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhbvZsjK/Qw7DZfZ/hzoV9GtAufPTT5lp9qu35lzbIzd+epmZk1nXFnfpwKd8LuR+qdOvmzIbwnSMnZmYM+TmgKE1e7w5az7Taa2qxcDGW4NPH710KNB27sIGzq2Bf6LMGEsvoUv0ReQbc7Y3TpYlOu5MTi3VvGd3PPo5bHUDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwUPEMQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwUPEMQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8343FC19424;
	Tue, 24 Mar 2026 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348095;
	bh=6sgVnhGfx/Gr8MffbxZCAPHDZSVU/xN0vvzwT8HpMXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwUPEMQIHDD077VI3busfNuril0YmxjbGwYzsYejnKrfkZDSC31QZyKmCQLu9fJdE
	 S5DNkNHd03l3ny1WkrAQmiEwJkMI2pwGC/B0vLv7fVXyePrr3Hv8/hzfrjcXVx70nH
	 2dXBt0+xytHW7OEPwLd3iYvC/yWcp0dnxi/vvifQowEKAxMbcOwjbqMR9xKJPST+I0
	 OFbGwwBwY34Rx2+NPSefHt/Aszh4h0sx00Ivsq31FzrhDORR9msiKkKuA3Xs32MAW6
	 Yvz0D7YxPYQSeJ9ltUfuOmYgJs35b8EJ6irK5Npyzij9GsMYDq+WoJsHm0MXADDHnt
	 ablF4wBqmilcQ==
Date: Tue, 24 Mar 2026 10:28:08 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, criu@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Chen Ridong <chenridong@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Koutny <mkoutny@suse.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH 1/4] exec: inherit HWCAPs from the parent process
Message-ID: <acJnOB-rlyt-3jU4@willie-the-truck>
References: <20260323175340.3361311-1-avagin@google.com>
 <20260323175340.3361311-2-avagin@google.com>
 <acGEonF9I6sPA42B@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acGEonF9I6sPA42B@J2N7QTR9R3.cambridge.arm.com>

On Mon, Mar 23, 2026 at 06:21:22PM +0000, Mark Rutland wrote:
> On Mon, Mar 23, 2026 at 05:53:37PM +0000, Andrei Vagin wrote:
> > Introduces a mechanism to inherit hardware capabilities (AT_HWCAP,
> > AT_HWCAP2, etc.) from a parent process when they have been modified via
> > prctl.
> > 
> > To support C/R operations (snapshots, live migration) in heterogeneous
> > clusters, we must ensure that processes utilize CPU features available
> > on all potential target nodes. To solve this, we need to advertise a
> > common feature set across the cluster.
> > 
> > This patch adds a new mm flag MMF_USER_HWCAP, which is set when the
> > auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV).  When
> > execve() is called, if the current process has MMF_USER_HWCAP set, the
> > HWCAP values are extracted from the current auxiliary vector and stored
> > in the linux_binprm structure. These values are then used to populate
> > the auxiliary vector of the new process, effectively inheriting the
> > hardware capabilities.
> > 
> > The inherited HWCAPs are masked with the hardware capabilities supported
> > by the current kernel to ensure that we don't report more features than
> > actually supported. This is important to avoid unexpected behavior,
> > especially for processes with additional privileges.
> 
> At a high level, I don't think that's going to be sufficient:
> 
> * On an architecture with other userspace accessible feature
>   identification mechanism registers (e.g. ID registers), userspace
>   might read those. So you might need to hide stuff there too, and
>   that's going to require architecture-specific interfaces to manage.
> 
>   It's possible that some code checks HWCAPs and others check ID
>   registers, and mismatch between the two could be problematic.
> 
> * If the HWCAPs can be inherited by a more privileged task, then a
>   malicious user could use this to hide security features (e.g. shadow
>   stack or pointer authentication on arm64), and make it easier to
>   attack that task. While not a direct attack, it would undermine those
>   features.

Yeah, this looks like a non-starter to me on arm64. Even if it was
extended to apply the same treatment to the idregs, many of the hwcap
features can't actually be disabled by the kernel and so you still run
the risk of a task that probes for the presence of a feature using
something like a SIGILL handler or, perhaps more likely, assumes that
the presence of one hwcap implies the presence of another. And then
there are the applications that just base everything off the MIDR...

There's also kvm, which provides a roundabout way to query some features
of the underlying hardware.

You're probably better off using/extending the idreg overrides we have
in arch/arm64/kernel/pi/idreg-override.c so that you can make your
cluster of heterogeneous machines look alike.

On the other hand, if munging the hwcaps happens to be sufficient for
this particular use-case, can't it be handled entirely in userspace (e.g.
by hacking libc?)

Will
