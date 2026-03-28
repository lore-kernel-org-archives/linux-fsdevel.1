Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397871A683C
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774657300; cv=pass; b=ppPaJ+Zby2QxAW6D8VTL4KCbyDsVuxP7f1OyY5SqKL5Atz6S7LEJIRN/ZH1/TB9O6bPqxx77fdFCVNy8mkh4hGZCaAGqWcPWSJeG7MsrzjVL920goeySz6uGYXBd+1eXLGOGhjrXWaw+K0v9TSqm3H1zeLOPgPB6cy832j69LNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774657300; c=relaxed/simple;
	bh=vV5WV0HLSYcQy+A0cA2Js7gosI1iQQ3g9tIu/GBiDJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GViNcXns0vJEighjuiTNArkHnXck3MnNqtk6AAFAMwIv/c7FPneGyyUuZ/vCmBgq0+Ayn29mHpXg9zfFpskyhHHqKCIirwMfeIJ1iiBZ8RX+wpFj3QuWOYa2dplL3d758ek5pxBKKMRoqPZKiZ8OIl3y36Tyy+W5o+LuFWLVqkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWwyjB3U; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWwyjB3U"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50b6c45781aso239221cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 17:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774657298; cv=none;
        d=google.com; s=arc-20240605;
        b=HSLCD6pF8SyMs0jrX42uBv31Bd8BInhHzBuSrmNDLbneiLP6LsPvqqN+cdvQWjm8wP
         L2PSliTzOpwdRQ/AY4yAhrN0+vF6u1DoYMVqoUZU0J6Gth9fv+Lburm2XcIllaBpG0Tq
         KOeURyBvTWU4/ojJ+s+8g2iWb82mfYr4/I/D11rZPPjfjoRv4PuFuNsK3AKs3vKHjyy5
         TFTNDKiAfJd0rgjf/VpF3M/R2ss6z/BU74aULhfj3G6vm9TbXHVbjwNZ7Xw2tzRA2Kw/
         JbiomkAbBaIwaw4cSYzBalvcFijeYaLZbPaCgQldTMEFbjt4mZp/EVKdnfnN2VaEKhTm
         HL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K9bPtEBHXKpRO9CjXfaCqUQKt7R+Gz6rl79/OVT+YNo=;
        fh=bcRG1X0st0xFiC5H4sh04eKR8d2cJAE33RAOUSGIPLs=;
        b=B0bOIt1egHMthYxgi0bHOkGXSpUPgFhFCcN/igOX1AXxFXBlQcvrSgENDZhXj1bZd4
         j3ivYkt/+A2W7kuVEbIJR3oXT5qMLzMDxwbw9t33p8oym5plSV4+2fwoAhhMctEkr6JO
         cik97PXAxwUM3cMGVp80ea3Y37dLv+zQjZ3xWAxpAlHN8zwDPiTT6FwA5hRN8KzHk/OP
         1nNJF4OLwFResMa5VUwdKzfL5K6e6ocrOeqRZq0ZwuZuN7uAKO0NtDG49QHeU0Jl+FsE
         AqhVTe+ow24do/kyAnH+0xCGlLJTZ8kk30JRPjTqXsNBKHsi7DpQ2hYxlbF01E+StNBV
         bphQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774657298; x=1775262098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9bPtEBHXKpRO9CjXfaCqUQKt7R+Gz6rl79/OVT+YNo=;
        b=NWwyjB3UfYeV7edM9egaGo7HgyNb/papUg2FICs1v4K996gpTD631K0ks6qsaoXnip
         1XKQQJ7XugBoN95nibA/VOYFXsMd3m4sKD4h1xEZvIC0fu0Qs7EUEEK3acAHPb/YHZjQ
         /vezt11v8Yd4wBQbDge8sJnNth4jo6/11rp9oU4Y5O+NoSVeb+KK1toc+/l89T8MgVYA
         P5919sChlIVa+LVoCmJEZ5seas/+vMXbyI2hn19fS8hbdtjjRUkCVuP36pH4EeovELpp
         b+xCsFrvJifzzlU4o/BJ7o0pV1wQ0rUGZ4pR56ewhBNJVLD7RLEBIRJ+y4owp5dNDYXJ
         qNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774657298; x=1775262098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9bPtEBHXKpRO9CjXfaCqUQKt7R+Gz6rl79/OVT+YNo=;
        b=BHeAUfdSfuXWIpu+BtLxIjJexSMZEawGS0URSCzOI93oZqBKg5VLdbo/1R2PsouMb1
         gbhM91Ufmra2icMtRwZOQJsk+1cBmMZ59y3EvcbGv4c4XlvveA8rPFAfBOEl1LGPnWs7
         NQs2twDZBYq1vizpxb34JuPU7HeRuZB5LoyN80rGjqT45PHCafnAcTqfGb6ySMt91bK0
         9YbnjbUAfdTFocuv969DbrsE+HrJ366b9xkqQLnolP+2Mi6lhCEBp7JfH2WHMqy8XO6l
         zdGYl6XqE3zyg4p48DZmCOssHE4nfWduI9uOlaqw/gDgW9Tb+uCFs5Fq7usvSK76lM5S
         vwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeejNz6dJm+S15TATAruHiWxjpeUnw0jiwAplURJd4npSZySTk7UMl6KzvSnBgMK1FUqs1s1xfHEX3HpN/@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqxJzDk1XHIX73okebtX8knx51al4c/FkzRGX46lXyXylS2dt
	TrNFTiEnIzHZVhG3Zugo1tumJ4MyguElfaueT7tp5+z4j77wLef4Db9SIe1SZBR5foXoIgyIbDP
	SJuHKS66vEt9/AQaGFYGEgRqYhGHf1zgWlQUaiwiD
X-Gm-Gg: ATEYQzz60sKyWx/W/yBqq26k6j2Lf5FBhZzW4bBrE0bG/vh2ktWxvUFiQ27PNqR98Zv
	aRrgibXv8eJObTMrYlOuRJHIRR1bFecupqleC/IpHy0DgQ4KnbzCpqQxxN4O7NDO/2Ll4YalNYQ
	jA/rjqW2YrMlqUscDaDmLJMqvXhroC/+zROOFNxpopELtF4NtQ0taxt4uN/13wWwlCuajy9nfs7
	FeoaICQAg3JKLRa8hfZ/Cc30QupiYsHejJMQLqE8ePHnu9w0kjVXrirVRagypSLfsnxR3OVI8JK
	gTQsKHLB7SCBd+So/Q==
X-Received: by 2002:a05:622a:4c8e:b0:509:14f0:bff2 with SMTP id
 d75a77b69052e-50bb27f62edmr6416861cf.12.1774657297623; Fri, 27 Mar 2026
 17:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323175340.3361311-1-avagin@google.com> <20260323175340.3361311-2-avagin@google.com>
 <acGEonF9I6sPA42B@J2N7QTR9R3.cambridge.arm.com> <acJnOB-rlyt-3jU4@willie-the-truck>
 <CAEWA0a7iR8YHooqXJfhersV6YhAXGMZDUhib3QQH5XGn=KNowA@mail.gmail.com> <acarA3sGKY4Acozw@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <acarA3sGKY4Acozw@J2N7QTR9R3.cambridge.arm.com>
From: Andrei Vagin <avagin@google.com>
Date: Fri, 27 Mar 2026 17:21:26 -0700
X-Gm-Features: AQROBzAZx6vusK91xtphbHO0OyQ8WklBK8fprRQAhCkwYE-GzsBGKaet5s4vnp4
Message-ID: <CAEWA0a7AZiuy1F+0LDxtEtJpdu=zA-RKhPb1wcDMpy2tSMFO5g@mail.gmail.com>
Subject: Re: [PATCH 1/4] exec: inherit HWCAPs from the parent process
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>, 
	Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 9:06=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Tue, Mar 24, 2026 at 03:19:49PM -0700, Andrei Vagin wrote:
> > Hi Mark and Will,
> >
> > Thanks for the feedback. Please read the inline comments.
> >
> > On Tue, Mar 24, 2026 at 3:28=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Mon, Mar 23, 2026 at 06:21:22PM +0000, Mark Rutland wrote:
> > > > On Mon, Mar 23, 2026 at 05:53:37PM +0000, Andrei Vagin wrote:
> > > > > Introduces a mechanism to inherit hardware capabilities (AT_HWCAP=
,
> > > > > AT_HWCAP2, etc.) from a parent process when they have been modifi=
ed via
> > > > > prctl.
> > > > >
> > > > > To support C/R operations (snapshots, live migration) in heteroge=
neous
> > > > > clusters, we must ensure that processes utilize CPU features avai=
lable
> > > > > on all potential target nodes. To solve this, we need to advertis=
e a
> > > > > common feature set across the cluster.
> > > > >
> > > > > This patch adds a new mm flag MMF_USER_HWCAP, which is set when t=
he
> > > > > auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV)=
.  When
> > > > > execve() is called, if the current process has MMF_USER_HWCAP set=
, the
> > > > > HWCAP values are extracted from the current auxiliary vector and =
stored
> > > > > in the linux_binprm structure. These values are then used to popu=
late
> > > > > the auxiliary vector of the new process, effectively inheriting t=
he
> > > > > hardware capabilities.
> > > > >
> > > > > The inherited HWCAPs are masked with the hardware capabilities su=
pported
> > > > > by the current kernel to ensure that we don't report more feature=
s than
> > > > > actually supported. This is important to avoid unexpected behavio=
r,
> > > > > especially for processes with additional privileges.
> > > >
> > > > At a high level, I don't think that's going to be sufficient:
> > > >
> > > > * On an architecture with other userspace accessible feature
> > > >   identification mechanism registers (e.g. ID registers), userspace
> > > >   might read those. So you might need to hide stuff there too, and
> > > >   that's going to require architecture-specific interfaces to manag=
e.
> > > >
> > > >   It's possible that some code checks HWCAPs and others check ID
> > > >   registers, and mismatch between the two could be problematic.
> > > >
> > > > * If the HWCAPs can be inherited by a more privileged task, then a
> > > >   malicious user could use this to hide security features (e.g. sha=
dow
> > > >   stack or pointer authentication on arm64), and make it easier to
> > > >   attack that task. While not a direct attack, it would undermine t=
hose
> > > >   features.
> >
> > I agree with Mark that only a privileged process have to be able to mas=
k
> > certain hardware features. Currently, PR_SET_MM_AUXV is guarded by
> > CAP_SYS_RESOURCE, but PR_SET_MM_MAP allows changing the auxiliary vecto=
r
> > without specific capabilities. This is definitely the issue. To address
> > this, I think we can consider to introduce a new prctl command to enabl=
e
> > HWCAP inheritance explicitly.
> >
> > > Yeah, this looks like a non-starter to me on arm64. Even if it was
> > > extended to apply the same treatment to the idregs, many of the hwcap
> > > features can't actually be disabled by the kernel and so you still ru=
n
> > > the risk of a task that probes for the presence of a feature using
> > > something like a SIGILL handler or, perhaps more likely, assumes that
> > > the presence of one hwcap implies the presence of another. And then
> > > there are the applications that just base everything off the MIDR...
> >
> > The goal of this mechanism is not to provide strict architectural
> > enforcement or to trap the use of hardware features; rather, it is to
> > provide a consistent discovery interface for applications. I chose the
> > HWCAP vector because it mirrors the existing behavior of running an
> > older kernel on newer hardware: while ID registers might report a
> > feature as physically present, the HWCAPs will omit it if the kernel
> > lacks support.
>
> On arm64, the view of the ID registers that userspace gets *only*
> exposes features that the kernel knows about, as userspace reads of
> those registers are trapped+emulated by the kernel. On arm64 it's
> not true to say that something appears in those but not the HWCAPs.
>
> I understand that might be different on other architectures, and so
> maybe this approach is sufficient on other architectures, but it is not
> sufficient on arm64.
>
> > Applications are generally expected to treat HWCAPs as
> > the source of truth for which features are safe to use, even if the
> > underlying hardware is technically capable of more.
>
> I'm fairly certain that there are arm64 applications (and libraries)
> which check only the ID register values, and not the HWCAPs.
>
> Architecturally, there are features which are detected via other
> mechanisms (e.g. CHKFEAT), for which HWCAPs are also irrelevant. Even if
> that happens to be ok today, there are almost certainly future uses that
> will not be compatible with the scheme you propose.
>
> I don't think we can say "applications must check the HWCAPs", when we
> know that applications and libraries legitimately don't always do that.
>
> > Another significant advantage of using HWCAPs is that many
> > applications already rely on them for feature detection. This interface
> > allows these applications to work correctly "out-of-the-box" in a
> > migrated environment without requiring any userspace modifications.  I
> > understand that some apps may use other detection methods; however, the=
re
> > it no gurantee that these applications will work correctly after
> > migration to another machine.
>
> I think the existince of applications that detect features by other
> (legitimate!) means implies that there's no guarantee that this feature
> is useful and will remain useful going forwards.
>
> For example, what do you plan to do if an application or library starts
> doing something legitimate that causes it to become incompatible with
> this scheme?
>
> I don't want to be in a position where userspace is asked to steer clear
> of legitimate mechanisms, or where architecture code suddently has to
> pick up a lot of complexity to make this work.
>
> > > There's also kvm, which provides a roundabout way to query some featu=
res
> > > of the underlying hardware.
> > >
> > > You're probably better off using/extending the idreg overrides we hav=
e
> > > in arch/arm64/kernel/pi/idreg-override.c so that you can make your
> > > cluster of heterogeneous machines look alike.
> >
> > IIRC, idreg-override/cpuid-masking usually works for an entire machine.
> > We actually need to have a mechanism that will work on a per-container
> > basis. Workloads inside one cluster can have different
> > migration/snapshot requirements. Some are pinned to a specific node,
> > others are never migrated, while others need to be migratable across a
> > cluster or even between clusters. We need a mechanism that can be
> > tunable on a per-container/per-process basis.
>
> I think that's theoretically possible, BUT it will require substantially
> more complexity, to address the issues that Will and I have mentioned. I
> don't think people are very happy to pick up that complexity.
>
> There are many other aspects that are going to be problematic for
> heterogeneous migration. Even if you hide the HWCAP for a stateful
> feature (e.g. SME), it might appear in one machine's signal frames (and
> be mandatory there), but might not appear in anothers, and so migration
> might not work either way. Likewise, that state can appear via ptrace.

Hi Mark,

I understand all these points and they are valid. However, as I
mentioned, we are not trying to introduce a mechanism that will strictly
enforce feature sets for every container. While we would like to have
that functionality, as you and will mentioned, it would require
substantially more complexity to address, and maintainers would unlikely
to pick up that complexity. Even masking ID registers on a per-container
basis would introduce extra complexity that could make architecture
maintainers unhappy. There were a few attempts to introduce container
CPUID masking on x86_64 in the past.

In CRIU, we are not aiming to handle every possible workload. Our goal
is to target workloads where developers are ready to cooperate and
willing to make adjustments to be C/R compatible. The goal here is to
provide developers with clear instructions on what they can do to ensure
their applications are C/R compatible. When I say "workloads", I mean
this in a broad sense. A container might pack a set of tools with
different runtimes (Go, Java, libc-based). All these runtimes should
detect only allowed features.

Returning to the subject of this patchset: this series extends the role
of hwcaps. With this change, we would establish that hwcaps is the
"source of truth" for which features an application can safely use. Any
other features available on the current CPU would not be guaranteed to
remain available after migration to another machine.

After this discussion, I found that the current version missed one major
thing: there should be a signal indicating that hwcaps must be used for
feature detection. Since we will need to integrate this interface into
libc, Go, and other runtimes, they definitely should not rely just on
hwcaps by default, especially in the early stages. This can be solved
via the prctl command.  Libraries like libc would call
prctl(PR_USER_HWCAP_ENABLED). If this returns true, the runtime knows
that only the features explicitly listed in hwcaps should be used.

You are right, the controlled feature set will be limited to features
the kernel knows about. And yes, we would need to report CPU features in
hwcaps even if the kernel isn't directly involved in handling them.
Honestly, I am not certain if this is the "right" interface for that,
and I would be happy to consider other ideas. I understand that these
hwcaps will not work right out of the box, but we need a way to solve
this problem. Having a centralized API for CPU/kernel feature detection
seems like the right direction.

As for signal frame size and extended states like SVE/SME, we aware
about this problem.  However, it is partly mitigated by the fact that if
an application does not use some features, those states are not placed
in the signal frame. In the future, when we construct/reload a signal
frame, we could look at a process feature set for a process and generate
a frame according to those features...

Thanks,
Andrei
