Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F033E2779;
	Fri, 20 Mar 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030767; cv=none; b=TZNC8VPvDeNzVhojXdT2tyMHoi9//wGbwMBMxZJI+Scd8mzNeH9prl0LvK4TMTl4WPaexDNOf2Gmnso9vsa7o7wcHn0SGUKjiFD4+Teqh/vczqbsdTla3lnkX3Qmeg+1Prpsx7dVdL5qo6prWXJWIpqx/6dPr0cuRSKT9EFnL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030767; c=relaxed/simple;
	bh=fhynckOY3YNY5Z7Vmj+3M9LO934fJkg+0qdwtO++Nsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSe1ZeUGIYt/j1m51sn/fL5WYFI+NRBlrnhMHUGgXhr3HktH7bBlevzsN6m0V7qDpUHzrbm8C4Wd8VFE4HP0h3Mb5c78GVZ78YSSvidytlb7ETvv0GqUjGWbKwirk/OSKzfDU/LGTCmIuw77JEQotEaG85DMp6CF92OXFOCPAU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cet4N38q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cet4N38q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC792C4CEF7;
	Fri, 20 Mar 2026 18:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774030766;
	bh=fhynckOY3YNY5Z7Vmj+3M9LO934fJkg+0qdwtO++Nsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cet4N38qjcfMf1hg2fBVK/3J0TcvK5Mk9XFV6riNA9guHnYQ3YgtOKsHP+rmkWYr6
	 rYXRmsM2aZqSY1A/mFeiQVZ07NhSrrijL6gq9mf3rgmQDl9FZZSzK/4Yr/Y6A8fPm5
	 OEyBvZnOwUeTv9YxnI7x5f9WeYlMWV7UBnIkfT1gVY+PIvDElJUBkTOflo85rfxBVs
	 nAKTPslk4lGymjYpEAxIBj9hHs21k2R8ATq9mp8G1ZbRZTFA4K1rT10A9RaFvBJry8
	 zSNh2xS7oOi3lGYzxWkSLd/Fb9gPDybtiMzuM7yOYte0zRAgXpqEc/8vCk8YLItg5C
	 rxtx+Rh4ZwmpA==
Date: Fri, 20 Mar 2026 11:19:26 -0700
From: Kees Cook <kees@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrei Vagin <avagin@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, criu@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Koutny <mkoutny@suse.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH 2/4] exec: inherit HWCAPs from the parent process
Message-ID: <202603201118.2F75F8D@keescook>
References: <20260217180108.1420024-1-avagin@google.com>
 <20260217180108.1420024-3-avagin@google.com>
 <CGME20260320091528eucas1p14a64767f916b556d30cfa00bfd320ace@eucas1p1.samsung.com>
 <aec9c36d-d67a-4b61-9950-57b95afedf75@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aec9c36d-d67a-4b61-9950-57b95afedf75@samsung.com>

On Fri, Mar 20, 2026 at 10:15:26AM +0100, Marek Szyprowski wrote:
> Hi,
> 
> On 17.02.2026 19:01, Andrei Vagin wrote:
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
> >
> > Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
> > Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > Signed-off-by: Andrei Vagin <avagin@google.com>
> 
> This patch landed in yesterday's linux-next as commit ac8c259ce0d5 
> ("exec: inherit HWCAPs from the parent process"). In my tests I found 
> that it causes regression on my Khadas VIM3L board, which is based 
> on Amlogic Meson SM1 (S905D3) SoC 
> (arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts). Running init 
> process fails after this patch:
> 
> Freeing unused kernel memory: 13696K
> Run /sbin/init as init process
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
> CPU: 1 UID: 0 PID: 1 Comm: init Not tainted 7.0.0-rc4-next-20260319 
> #12369 PREEMPT
> Hardware name: Khadas VIM3L (DT)
> 
> What is probably important here, this board (for some internal, 
> historical reasons) uses armv7l rootfs, but other boards used in my 
> tests, based on different SoCs, also use such rootfs and boot fine with 
> yesterday's linux-next. Reverting ac8c259ce0d5 commit (together with 
> 0ea77bbf3b98 due to dependencies) on top of next-20260319 fixes this issue.

Thanks for the report! I've dropped these patches from -next for now.
Andrei can you investigate what is needed to fix this?

Thanks!

-Kees

-- 
Kees Cook
