Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E701C5486
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626388; cv=pass; b=Nt4QaVEZBxG49NoAUgImV2wgve1f4BJfJ2ioQnZTqGJKjl/Mmdc3wJmUeJLDD1b3MGNz17CCJplli2uE4tONRs1swoD0JruvBu4yYCbZ65W5Hk1HdktmAlqgaGp2POpGB1qiFyY/QbrS4HjzM2UZ7rGtZDyVuKh5ZDISIWIVBOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626388; c=relaxed/simple;
	bh=rfFc3eRjztFlLv2yNnqD4g/YPOS/C3C1upvZOqnlwfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTppAs7haRcM9Fg70p7wC6ia27UX+/coW5TbTxCHQVvt3yKUc35N083MrdTZHDC3P4r+yqsZEzR0DgCgWW7uaDHns1uKh4ZFYTAdSjeMxPoUQVUDBbJTwifuvqleePWTQT4sumcgQJOUiDLef3leNzhfvqsqi7BUXRhApd+QGvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2CaDgWn; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2CaDgWn"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b6c45781aso667161cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 08:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774626386; cv=none;
        d=google.com; s=arc-20240605;
        b=PDriQt/EV1XNrB5q3P7sjjjQN9uyrYwB12wjqqNNWlyJrSgohYmPoG4iTohaf7CJFx
         ObOHLQJUrjD9+UQMt+k4kbPDEhgXWBeljKR2ASGtJArvuL6Shua7w30WZLZbaNxTkV1N
         iuGWbtVaJBM4Rzy+AIrP0JK5vmlUtZ6/V7w4DXjGneNgHrx6dchQY/pZugaJp6SM7vG2
         UiauEpmbFTqO122YClL97HND5AiPUEXtlF6arMF7z1JlvDReAhLTzKnk6QiyOY1bC6bN
         VIwCS0ON2B2L+z+t6eDu3TdkNZKRn/u/NlE4xme8gDpsA0gd5aCvi3iRa3co+dQ2BO1G
         nezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=owpdxFF3v/KlPV1csbkJ90RTaf+LQvkCMaflebyBvGw=;
        fh=/QRE4mUrHJ+Mn0Zz+bNXlKTszJo5Z79ItCcaeQmsxzk=;
        b=AnsZBXEidPTI27ltL5D5NhU7a2BGvjRyrr0joIKsV56geWPK/WlEQXwN8yEq6Exzii
         k822/PUwdsw38A2aHDtwFQt5DVYyHEohPu8UZ9Ii7J430mD0H8C9ajrsrcXD0dnWIJcm
         RKDjj4sU7U9GUGsJI4R5DJUelqLxUvbYxR0W9bgF3nzjz4rXoDc4ljYbD1/TPUyJYeDP
         bq3GHOmg7ZlLbCngqjrNnmTKQ3MB+lUHTUI93m1OojrPZ6vSPmZerfoRWd3IsIURbhU7
         85tD0dCZrVxgnSa8xOtLdYDDU9huTCGE2EaM08yeAqq45qFI3cJJA/vJC5jfC2oBasko
         LWkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774626386; x=1775231186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owpdxFF3v/KlPV1csbkJ90RTaf+LQvkCMaflebyBvGw=;
        b=J2CaDgWn8eF75GrTNYrVFdHtBHOqAnJGnja9E/5HsGps3Z2TxTUkhY2sM/CKgds2gl
         aZ8XHTc4jzR9l673V8ZFLwjOhvRoq/ec8aiwK21b2PffpWLvo3ccZsI0ALkH7mQexlM3
         pu1wa1e8lNhRq35DlW1TVR/+YYNKwV3WMrwvypV836ylIPKT28Vh8JH+i/wXGKtD+1Al
         sF0BFqc/j1wH8zDt2O8I7ki+4/1C1JVLL6RsZgIGCrlaXT2fRS9ykaJ7W/ujc8n+JQI+
         T2dDngVdXs+7zcN0Vb3dUSGbTmdxxN7dcfKwRuDPMXc5cX8zq39CcUGnCiU0O04VnJx9
         gfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774626386; x=1775231186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=owpdxFF3v/KlPV1csbkJ90RTaf+LQvkCMaflebyBvGw=;
        b=WKFpHmohlvPfooB0/dWyuyFZwT94KgPtfQ6tqv+ylFnKsULlr4PjphByTlYVuFUQQh
         ys5oD86KGGsXfTjDSOw5Ee9RL02DsSiLE4jWVO+IRKuBDxsA40cLRm/BoBgtQw7yHYxK
         01F0l2OD/iMgoJ8N3QMaudpbycMd0EOwGDLSc0JMv9FBQ9TECssOZOWr1k5JfZ0DXF9W
         sm7ltiMlcSx6ceVBwG+Ku6RYmvT7DVZfLvnoKVB6vXFnTJKBGQapDsrhzHBP03tc4mvm
         Y/LsCoCQRhiwbsrpSFv3H6IST48pJmhuEAp4J+F/g3IED3UtBxHaiQXkVysnVI5Kp9xd
         JyWA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Y99dqxIA+fD18hect2jdrA5tvYBE2wFHHcDA4bQuzCj2Zf4ODnTVv0w9uUyHml3D5AYpAxgwchQ8IB1g@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKInsL2DDsKpvMzJqsIQ1y5YyKZZsNNUmdFMTpJwqpZGMKVIt
	RjXKH/25SiB0S8y/l4zhpaxJvscvNstab01j+x2SpRj8YK347gL9pLMEhpIXYWY7NmDQKeZYszG
	73DuBnZ8b3rUk9IqcBL4/W4KOHAUcwO90TpQWhXEh
X-Gm-Gg: ATEYQzwp2dvuETft9NERsEgS1dLX3tSzUCErIG8gpkmeUbD5V77wBtH3MlQpmgSiL/l
	X6inKjAZF//E80+SewP0YFY3a2iILoI+bgxHHUTSLCXVRDMOTirnjCNjzN4s8hhP8UOg44j9Icf
	0uR1a+Lax9kIT3nHw2sJosLdWI1YX52Z/QIZfmO6iXed8kPWNcIt6CuuxHRma3vzxkKthFXk+Y4
	7q8z4lxn4vUabi/CczyrxWL38zVv1Ppwg/o+RKAjxiu7chPqwk00c2pgcCjaYF3UfusMFGSlDZl
	cMAexGo=
X-Received: by 2002:a05:622a:4c86:b0:509:72a:ae59 with SMTP id
 d75a77b69052e-50ba1cbeb9amr15605551cf.10.1774626384838; Fri, 27 Mar 2026
 08:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323175340.3361311-1-avagin@google.com> <20260323175340.3361311-2-avagin@google.com>
 <acGEonF9I6sPA42B@J2N7QTR9R3.cambridge.arm.com> <acJnOB-rlyt-3jU4@willie-the-truck>
 <CAEWA0a7iR8YHooqXJfhersV6YhAXGMZDUhib3QQH5XGn=KNowA@mail.gmail.com>
In-Reply-To: <CAEWA0a7iR8YHooqXJfhersV6YhAXGMZDUhib3QQH5XGn=KNowA@mail.gmail.com>
From: Andrei Vagin <avagin@google.com>
Date: Fri, 27 Mar 2026 08:46:13 -0700
X-Gm-Features: AQROBzCbFCKKF5EGKvRVWmaQmxOKGk-clLCYQmcai8kbKMF-pnr8L4F1E1mL0vY
Message-ID: <CAEWA0a629qGEHvHpczGrZ+UBnzO75KgLsU7RoeR0cekmvaxLQQ@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 3:19=E2=80=AFPM Andrei Vagin <avagin@google.com> wr=
ote:
>
> Hi Mark and Will,
>
> Thanks for the feedback. Please read the inline comments.

Mark, Will, just checking in to see if my explanation makes sense to you.
Let me know if you have any further feedback or questions.

Thanks,
Andrei

>
> On Tue, Mar 24, 2026 at 3:28=E2=80=AFAM Will Deacon <will@kernel.org> wro=
te:
> >
> > On Mon, Mar 23, 2026 at 06:21:22PM +0000, Mark Rutland wrote:
> > > On Mon, Mar 23, 2026 at 05:53:37PM +0000, Andrei Vagin wrote:
> > > > Introduces a mechanism to inherit hardware capabilities (AT_HWCAP,
> > > > AT_HWCAP2, etc.) from a parent process when they have been modified=
 via
> > > > prctl.
> > > >
> > > > To support C/R operations (snapshots, live migration) in heterogene=
ous
> > > > clusters, we must ensure that processes utilize CPU features availa=
ble
> > > > on all potential target nodes. To solve this, we need to advertise =
a
> > > > common feature set across the cluster.
> > > >
> > > > This patch adds a new mm flag MMF_USER_HWCAP, which is set when the
> > > > auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV). =
 When
> > > > execve() is called, if the current process has MMF_USER_HWCAP set, =
the
> > > > HWCAP values are extracted from the current auxiliary vector and st=
ored
> > > > in the linux_binprm structure. These values are then used to popula=
te
> > > > the auxiliary vector of the new process, effectively inheriting the
> > > > hardware capabilities.
> > > >
> > > > The inherited HWCAPs are masked with the hardware capabilities supp=
orted
> > > > by the current kernel to ensure that we don't report more features =
than
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
> > >   malicious user could use this to hide security features (e.g. shado=
w
> > >   stack or pointer authentication on arm64), and make it easier to
> > >   attack that task. While not a direct attack, it would undermine tho=
se
> > >   features.
>
> I agree with Mark that only a privileged process have to be able to mask
> certain hardware features. Currently, PR_SET_MM_AUXV is guarded by
> CAP_SYS_RESOURCE, but PR_SET_MM_MAP allows changing the auxiliary vector
> without specific capabilities. This is definitely the issue. To address
> this, I think we can consider to introduce a new prctl command to enable
> HWCAP inheritance explicitly.
>
> >
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
> lacks support. Applications are generally expected to treat HWCAPs as
> the source of truth for which features are safe to use, even if the
> underlying hardware is technically capable of more.
>
> Another significant advantage of using HWCAPs is that many
> applications already rely on them for feature detection. This interface
> allows these applications to work correctly "out-of-the-box" in a
> migrated environment without requiring any userspace modifications.  I
> understand that some apps may use other detection methods; however, there
> it no gurantee that these applications will work correctly after
> migration to another machine.
>
> >
> > There's also kvm, which provides a roundabout way to query some feature=
s
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
>
> >
> > On the other hand, if munging the hwcaps happens to be sufficient for
> > this particular use-case, can't it be handled entirely in userspace (e.=
g.
> > by hacking libc?)
>
> CRIU often handles workloads with a mix of runtimes: some linked against
> glibc, some against musl, and others like Go that bypass libc entirely.
> CRIU is mostly used to handle containers that can run multiple processes
> possible based on different runtimes. It means available cpu features
> should not be only specified for one runtime, they have to be passed
> across different runtimes. I think the pure userspace solution is near
> infeasible in this case.
>
> Thanks,
> Andrei
