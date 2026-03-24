Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60648361641
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390803; cv=pass; b=LwK/1saQBlzEoJ+y7RsDOlLsrsrEDiXqYqhje/76j9Uh8g5ajoW2tMZEcKcondxJV5dZziXAxScKElX+ClUY448AVlHJEKzuzfTat6cjyDIVxoXxhcOE7neTwY8jA/GpnTGwnS6Lc9jTDtPw7+8szY04MzeFQKNmdNLGCs+9Ny0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390803; c=relaxed/simple;
	bh=4JK7FkcdBWpQuygpIDHYRhmKkIpeBpxTxQL3XC3cxXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY+MABpprefbwkU8lTFfd587HRqeImYye4JNZueA7V9Ue9VEuCJY42Q4KSZgh4ffvTPX1//DVYuIL7YZ7B/wsPHNXlTdAv7gfM6CKb/ylXG5Bkgvy2tEiQYXpg1FA08cPRCWYpR3cnHwvZAwdMrJZFahRVtMCmng90wxrtD8kdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+1EXBak; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+1EXBak"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509069a7a7fso195191cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774390801; cv=none;
        d=google.com; s=arc-20240605;
        b=TGSoYN7PDmqX9WCsmELGdkm8U02LVX/n/h8iuouHftl0BUui44Q2RRpr/El9Vf0/QC
         ReyeD97vV4WIHuNkms5fmzjQ6vNpJolWyayeelK8j4eO+1IPErHfBxiYLs8IiTngk4Ei
         6ToHcBp1HUfUQ0iX7O3Gw7Ak4y/97r/S5/qYpDQHXdZSQywsXsh3KmoHbFDmmHpX7MJw
         C1pnOKwLZ6SU92/WcXlNqPDF93q/akLXNCxaEPqoa2xaggwUOURdwrQJR2Udn0WI7urR
         nX01iTiiCIekvYCkfq438mICFrTtN2nagANWrnabc85dezBFOSpJpSmZGs7G8AHxLwDb
         ypIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iA0qEOtZ8sY0A4PQMCyKkXrxyPKJc9xjSndOAsg0m2c=;
        fh=XXVXqJBZXy1tloUjUIKOAGs9DAnDVjIOq8TiVlxtPiM=;
        b=b7oYdz2lb3wLdN67JfRzJuUh15kK0uvlBpR+e5X5+fIpyWAp311P9Pndf4oUHoY8vJ
         e/yCKGrOtlcoI/fZqcmHkPdGoWrqTonNH0g36uTkwPeFC1M8AbiFWJK6GzCms+Utizjn
         FK6d+nTfHwpbMcNTkh/txldgBtwDu8TorNk6UtZWiBLAwuSzNgX00tvqzYhlPDfJJl9E
         xHVWpA2Tifh6UJbGeKNTDIo5LZnMsVELDSINcun3BR44srvX7HJXvIlJ7Bf11TmsdQMv
         UYhjED6vGIVoW0kyB2fvhNCp9vGhSgTvcHRFbXpuX+a3JT1FTECXiYkTv66+TC14aPEh
         E0Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774390801; x=1774995601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA0qEOtZ8sY0A4PQMCyKkXrxyPKJc9xjSndOAsg0m2c=;
        b=D+1EXBakG1kBGLA7rUczZI9EiPYPR4Z2LC9ybycSVsTNDZq59nUxXFF5tRA/JqSUI+
         Qq2AVMuqyv7rUhw0GwlPjTefDersOpyCmm67UQoIt3aVhqhSg+TIfa8XyrcXkpbq4qhl
         5GUZ4+HcLMnEsGVkUgK11P+6qMNQOMVzwoj3YwZ+L3NWtxrejq2oDVuj+iPUiZmeMZbc
         gtwRCgOc3H83k23DXj0sunKSlC92EZjz0GhX0wvqMrMmtUVK8R2ymwuBiXEFV1uxyLQm
         mGXAWHjaHWMekhtgCEV6YF8j+WPtHc/UYoZX8ykYqhwHsEfNYqxKcGytKMCzbLw2Ro4/
         DXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390801; x=1774995601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iA0qEOtZ8sY0A4PQMCyKkXrxyPKJc9xjSndOAsg0m2c=;
        b=ZDImPoRTNKb1aT1cV+V1MrcxZHclNUf6yJ7tI8zut6dDf7PNZV9iuQ26do//zzlGK3
         VaRqLR9gL1IPWKpAOkhd0pqzgyrEDJcRqR51WKxnykZ1cmd4acQL460y9N4kpzyLlvM9
         N8aKIJHIq8R2y++VSKgLzZageg7VJ0fUGT9YowzE8Vi9n34HF/bmnHzPhb7M58///5K+
         Tug1ZZguS+mOcl3BQlR9LoTSsIDho7rs/1NbS+TRYmrI+XJv74zBeQXfzyX193lpVb/2
         a5J6fKWEcH/KqXN1+AhEqm7O/PBpcnLc5d320TuA/SFUmHI00IvKDnAktRCA+eRuHUlp
         Afog==
X-Forwarded-Encrypted: i=1; AJvYcCUgQVAdhLvgP0eKnxVpTicyKLsIS2qBqMH7gUs3KmbPRi7mrvGtb4sOPpSozdEwrlRf4AWkGlkyJe31TuBf@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtkvYJn2EZGyeFV3uuzcUFqRpNnqgcSfs7XpdbNr/YBo/++0w
	ndjp0Q0Pz9nUkBiFrq1bPIr5WiqPxLzEdltz15SaP7AVJ73HSghhRcUWIc4ANg19gBUEkiOiSNN
	A8cgoWrC6CWmK7FBHiwn2f0VXbNVyLDcrnRjK9ym/
X-Gm-Gg: ATEYQzwrfPciWrpBvpacP0rctipRXgizNyZECnwsyCK2+CzCgCneSnC3KYSzjKY8Bnq
	QesWYFiPU6aXWdqI6S/lKTSJC/kQRgnPMjdAlHEwxOQGvA96hTb8156FxNFY2HMbnUIIZFdShnt
	SNd54yaLbMOyx7VKpK05QsjTtQkH3L+2/M4R8MrDgHvFsubs15LEoi5NXowLECby5wAy0ENmjt5
	uwLdDXUaIVufNKpA7soLxsmtFhS7WJuPyY96D1doLqvIUSZR7jYRnpqaTmuEIwhpvHK9X3tz0pz
	HmhCX5c=
X-Received: by 2002:a05:622a:a0b:b0:50b:4e90:44ae with SMTP id
 d75a77b69052e-50b83d9432fmr2305211cf.17.1774390800883; Tue, 24 Mar 2026
 15:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323175340.3361311-1-avagin@google.com> <20260323175340.3361311-2-avagin@google.com>
 <acGEonF9I6sPA42B@J2N7QTR9R3.cambridge.arm.com> <acJnOB-rlyt-3jU4@willie-the-truck>
In-Reply-To: <acJnOB-rlyt-3jU4@willie-the-truck>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 24 Mar 2026 15:19:49 -0700
X-Gm-Features: AaiRm52g4xzDr5_5nSdTi4eazdyhs8piBH0WKAbvFvJLqkZfV7WhTKZGEWCKiO0
Message-ID: <CAEWA0a7iR8YHooqXJfhersV6YhAXGMZDUhib3QQH5XGn=KNowA@mail.gmail.com>
Subject: Re: [PATCH 1/4] exec: inherit HWCAPs from the parent process
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Cyrill Gorcunov <gorcunov@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark and Will,

Thanks for the feedback. Please read the inline comments.

On Tue, Mar 24, 2026 at 3:28=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Mar 23, 2026 at 06:21:22PM +0000, Mark Rutland wrote:
> > On Mon, Mar 23, 2026 at 05:53:37PM +0000, Andrei Vagin wrote:
> > > Introduces a mechanism to inherit hardware capabilities (AT_HWCAP,
> > > AT_HWCAP2, etc.) from a parent process when they have been modified v=
ia
> > > prctl.
> > >
> > > To support C/R operations (snapshots, live migration) in heterogeneou=
s
> > > clusters, we must ensure that processes utilize CPU features availabl=
e
> > > on all potential target nodes. To solve this, we need to advertise a
> > > common feature set across the cluster.
> > >
> > > This patch adds a new mm flag MMF_USER_HWCAP, which is set when the
> > > auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV).  W=
hen
> > > execve() is called, if the current process has MMF_USER_HWCAP set, th=
e
> > > HWCAP values are extracted from the current auxiliary vector and stor=
ed
> > > in the linux_binprm structure. These values are then used to populate
> > > the auxiliary vector of the new process, effectively inheriting the
> > > hardware capabilities.
> > >
> > > The inherited HWCAPs are masked with the hardware capabilities suppor=
ted
> > > by the current kernel to ensure that we don't report more features th=
an
> > > actually supported. This is important to avoid unexpected behavior,
> > > especially for processes with additional privileges.
> >
> > At a high level, I don't think that's going to be sufficient:
> >
> > * On an architecture with other userspace accessible feature
> >   identification mechanism registers (e.g. ID registers), userspace
> >   might read those. So you might need to hide stuff there too, and
> >   that's going to require architecture-specific interfaces to manage.
> >
> >   It's possible that some code checks HWCAPs and others check ID
> >   registers, and mismatch between the two could be problematic.
> >
> > * If the HWCAPs can be inherited by a more privileged task, then a
> >   malicious user could use this to hide security features (e.g. shadow
> >   stack or pointer authentication on arm64), and make it easier to
> >   attack that task. While not a direct attack, it would undermine those
> >   features.

I agree with Mark that only a privileged process have to be able to mask
certain hardware features. Currently, PR_SET_MM_AUXV is guarded by
CAP_SYS_RESOURCE, but PR_SET_MM_MAP allows changing the auxiliary vector
without specific capabilities. This is definitely the issue. To address
this, I think we can consider to introduce a new prctl command to enable
HWCAP inheritance explicitly.

>
> Yeah, this looks like a non-starter to me on arm64. Even if it was
> extended to apply the same treatment to the idregs, many of the hwcap
> features can't actually be disabled by the kernel and so you still run
> the risk of a task that probes for the presence of a feature using
> something like a SIGILL handler or, perhaps more likely, assumes that
> the presence of one hwcap implies the presence of another. And then
> there are the applications that just base everything off the MIDR...

The goal of this mechanism is not to provide strict architectural
enforcement or to trap the use of hardware features; rather, it is to
provide a consistent discovery interface for applications. I chose the
HWCAP vector because it mirrors the existing behavior of running an
older kernel on newer hardware: while ID registers might report a
feature as physically present, the HWCAPs will omit it if the kernel
lacks support. Applications are generally expected to treat HWCAPs as
the source of truth for which features are safe to use, even if the
underlying hardware is technically capable of more.

Another significant advantage of using HWCAPs is that many
applications already rely on them for feature detection. This interface
allows these applications to work correctly "out-of-the-box" in a
migrated environment without requiring any userspace modifications.  I
understand that some apps may use other detection methods; however, there
it no gurantee that these applications will work correctly after
migration to another machine.

>
> There's also kvm, which provides a roundabout way to query some features
> of the underlying hardware.
>
> You're probably better off using/extending the idreg overrides we have
> in arch/arm64/kernel/pi/idreg-override.c so that you can make your
> cluster of heterogeneous machines look alike.

IIRC, idreg-override/cpuid-masking usually works for an entire machine.
We actually need to have a mechanism that will work on a per-container
basis. Workloads inside one cluster can have different
migration/snapshot requirements. Some are pinned to a specific node,
others are never migrated, while others need to be migratable across a
cluster or even between clusters. We need a mechanism that can be
tunable on a per-container/per-process basis.

>
> On the other hand, if munging the hwcaps happens to be sufficient for
> this particular use-case, can't it be handled entirely in userspace (e.g.
> by hacking libc?)

CRIU often handles workloads with a mix of runtimes: some linked against
glibc, some against musl, and others like Go that bypass libc entirely.
CRIU is mostly used to handle containers that can run multiple processes
possible based on different runtimes. It means available cpu features
should not be only specified for one runtime, they have to be passed
across different runtimes. I think the pure userspace solution is near
infeasible in this case.

Thanks,
Andrei
