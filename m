Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAF333FE00;
	Fri, 27 Mar 2026 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627598; cv=none; b=UDtUDXkeuxNhU5UsZNByURfppXIZuYgXDdfKLr/g9oAU5N9ToqsxG9vAosma4IWZc/ItKtHgibkGKI5qn98ff48R2QbcjvqZQ8AiErydCuE4rqjGkIuLApxIoxsm6wvl+mf4ee22nKLJTlFzl1zLvJJ2GGroxCFrsQ8En9koGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627598; c=relaxed/simple;
	bh=rP5Us1gXdwPg7GyTIgDBgSFYYiyK72XcZqUZNsRJd7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPT6DNNsl1ggyV2BviId4FcB1arEMcHY37npvk8aRxwMDw/4aigPvJ/sr2UDTxjsK7bSSfW1wSpzlt1BPtDravELk4n56O/3uh7MjJghUCXpSXT/rKta79dX6VTN2jguJaIFf4/l5umIIg73ytwNW6+kQWaF6xN7TjPmZ3PtMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=euB7uvj6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="euB7uvj6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0380635DA;
	Fri, 27 Mar 2026 09:06:29 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 501B53F905;
	Fri, 27 Mar 2026 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774627594; bh=rP5Us1gXdwPg7GyTIgDBgSFYYiyK72XcZqUZNsRJd7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euB7uvj6sPvllCzscsJiWjfu2yQKubt0UwiyzR70XCV7OQY28kY7MGRijQb7Rj/ww
	 g5Jnk+yKB7WIdQKX0sZMjkOG8Lh6yX18HV9LbxuG0Qx9gTebYXJ4nvfTqJnMBxiUjW
	 Tep1yK+UIiWrTDxl7aHcASnUCM2R72F1NxjKzw+g=
Date: Fri, 27 Mar 2026 16:06:27 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Andrei Vagin <avagin@google.com>
Cc: Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
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
Message-ID: <acarA3sGKY4Acozw@J2N7QTR9R3.cambridge.arm.com>
References: <20260323175340.3361311-1-avagin@google.com>
 <20260323175340.3361311-2-avagin@google.com>
 <acGEonF9I6sPA42B@J2N7QTR9R3.cambridge.arm.com>
 <acJnOB-rlyt-3jU4@willie-the-truck>
 <CAEWA0a7iR8YHooqXJfhersV6YhAXGMZDUhib3QQH5XGn=KNowA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWA0a7iR8YHooqXJfhersV6YhAXGMZDUhib3QQH5XGn=KNowA@mail.gmail.com>

On Tue, Mar 24, 2026 at 03:19:49PM -0700, Andrei Vagin wrote:
> Hi Mark and Will,
> 
> Thanks for the feedback. Please read the inline comments.
> 
> On Tue, Mar 24, 2026 at 3:28 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Mar 23, 2026 at 06:21:22PM +0000, Mark Rutland wrote:
> > > On Mon, Mar 23, 2026 at 05:53:37PM +0000, Andrei Vagin wrote:
> > > > Introduces a mechanism to inherit hardware capabilities (AT_HWCAP,
> > > > AT_HWCAP2, etc.) from a parent process when they have been modified via
> > > > prctl.
> > > >
> > > > To support C/R operations (snapshots, live migration) in heterogeneous
> > > > clusters, we must ensure that processes utilize CPU features available
> > > > on all potential target nodes. To solve this, we need to advertise a
> > > > common feature set across the cluster.
> > > >
> > > > This patch adds a new mm flag MMF_USER_HWCAP, which is set when the
> > > > auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV).  When
> > > > execve() is called, if the current process has MMF_USER_HWCAP set, the
> > > > HWCAP values are extracted from the current auxiliary vector and stored
> > > > in the linux_binprm structure. These values are then used to populate
> > > > the auxiliary vector of the new process, effectively inheriting the
> > > > hardware capabilities.
> > > >
> > > > The inherited HWCAPs are masked with the hardware capabilities supported
> > > > by the current kernel to ensure that we don't report more features than
> > > > actually supported. This is important to avoid unexpected behavior,
> > > > especially for processes with additional privileges.
> > >
> > > At a high level, I don't think that's going to be sufficient:
> > >
> > > * On an architecture with other userspace accessible feature
> > >   identification mechanism registers (e.g. ID registers), userspace
> > >   might read those. So you might need to hide stuff there too, and
> > >   that's going to require architecture-specific interfaces to manage.
> > >
> > >   It's possible that some code checks HWCAPs and others check ID
> > >   registers, and mismatch between the two could be problematic.
> > >
> > > * If the HWCAPs can be inherited by a more privileged task, then a
> > >   malicious user could use this to hide security features (e.g. shadow
> > >   stack or pointer authentication on arm64), and make it easier to
> > >   attack that task. While not a direct attack, it would undermine those
> > >   features.
> 
> I agree with Mark that only a privileged process have to be able to mask
> certain hardware features. Currently, PR_SET_MM_AUXV is guarded by
> CAP_SYS_RESOURCE, but PR_SET_MM_MAP allows changing the auxiliary vector
> without specific capabilities. This is definitely the issue. To address
> this, I think we can consider to introduce a new prctl command to enable
> HWCAP inheritance explicitly.
> 
> > Yeah, this looks like a non-starter to me on arm64. Even if it was
> > extended to apply the same treatment to the idregs, many of the hwcap
> > features can't actually be disabled by the kernel and so you still run
> > the risk of a task that probes for the presence of a feature using
> > something like a SIGILL handler or, perhaps more likely, assumes that
> > the presence of one hwcap implies the presence of another. And then
> > there are the applications that just base everything off the MIDR...
> 
> The goal of this mechanism is not to provide strict architectural
> enforcement or to trap the use of hardware features; rather, it is to
> provide a consistent discovery interface for applications. I chose the
> HWCAP vector because it mirrors the existing behavior of running an
> older kernel on newer hardware: while ID registers might report a
> feature as physically present, the HWCAPs will omit it if the kernel
> lacks support. 

On arm64, the view of the ID registers that userspace gets *only*
exposes features that the kernel knows about, as userspace reads of
those registers are trapped+emulated by the kernel. On arm64 it's 
not true to say that something appears in those but not the HWCAPs.

I understand that might be different on other architectures, and so
maybe this approach is sufficient on other architectures, but it is not
sufficient on arm64.

> Applications are generally expected to treat HWCAPs as
> the source of truth for which features are safe to use, even if the
> underlying hardware is technically capable of more.

I'm fairly certain that there are arm64 applications (and libraries)
which check only the ID register values, and not the HWCAPs.

Architecturally, there are features which are detected via other
mechanisms (e.g. CHKFEAT), for which HWCAPs are also irrelevant. Even if
that happens to be ok today, there are almost certainly future uses that
will not be compatible with the scheme you propose.

I don't think we can say "applications must check the HWCAPs", when we
know that applications and libraries legitimately don't always do that.

> Another significant advantage of using HWCAPs is that many
> applications already rely on them for feature detection. This interface
> allows these applications to work correctly "out-of-the-box" in a
> migrated environment without requiring any userspace modifications.  I
> understand that some apps may use other detection methods; however, there
> it no gurantee that these applications will work correctly after
> migration to another machine.

I think the existince of applications that detect features by other
(legitimate!) means implies that there's no guarantee that this feature
is useful and will remain useful going forwards.

For example, what do you plan to do if an application or library starts
doing something legitimate that causes it to become incompatible with
this scheme?

I don't want to be in a position where userspace is asked to steer clear
of legitimate mechanisms, or where architecture code suddently has to
pick up a lot of complexity to make this work.

> > There's also kvm, which provides a roundabout way to query some features
> > of the underlying hardware.
> >
> > You're probably better off using/extending the idreg overrides we have
> > in arch/arm64/kernel/pi/idreg-override.c so that you can make your
> > cluster of heterogeneous machines look alike.
> 
> IIRC, idreg-override/cpuid-masking usually works for an entire machine.
> We actually need to have a mechanism that will work on a per-container
> basis. Workloads inside one cluster can have different
> migration/snapshot requirements. Some are pinned to a specific node,
> others are never migrated, while others need to be migratable across a
> cluster or even between clusters. We need a mechanism that can be
> tunable on a per-container/per-process basis.

I think that's theoretically possible, BUT it will require substantially
more complexity, to address the issues that Will and I have mentioned. I
don't think people are very happy to pick up that complexity.

There are many other aspects that are going to be problematic for
heterogeneous migration. Even if you hide the HWCAP for a stateful
feature (e.g. SME), it might appear in one machine's signal frames (and
be mandatory there), but might not appear in anothers, and so migration
might not work either way. Likewise, that state can appear via ptrace.

Thanks,
Mark.
