Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624E385535
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776281237; cv=pass; b=UDAxxMa3i1ah8GseknHcnBW+i7Ff9ObB810xB1rlnkODAw5x0X3vkmwm87P61ltksqUZ+a+vUwF706mWm2RSiJkKuJvr53ggqKBJOjpAt3QuIAyZCbTsYr5ZRXc1HfzdWV9OSNHdOMJufeIL+lZdi1Qad65kunS8dQcgOCQavaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776281237; c=relaxed/simple;
	bh=4v+Eko4xmqaU82b1NDdR0TLMvuLm6cFirxeTfWhHtMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i28CWLz67Vw+e5SqHBUPQUc5wDSrZDK2fEM3j8klAdxO1A2h8fxcaOvuUjdKLJwYSzj+8nw3tE3BiSMJUS6HK5ownAOq7QRm+eNkWuF47VK/yX4ez1sPDF+11lWB/NMHDs/bGPfgRgBcEhwsQxRLB433Xq2CqdiQoxHbR60SMvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/amLioS; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/amLioS"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so3563741a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 12:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776281235; cv=none;
        d=google.com; s=arc-20240605;
        b=HhFeELuZqRNb5iTe1lsSmm1oLUPUG6ksVSWtd7PNH4srH7/3gBEO/mIsNQx3U2aT8Q
         Utzr8ovZ+L0UaoGva/HXmJ6Fa5Ej10IsatqjluplsS+607d8EfgmDEMktPM/7paqEV2x
         evEJRKJsm2pw+wINv9NoyHO/RW7ZIvgMI0buMvvFaXTJvqNZ2ObN1QaNWi5Bxi2jOSQA
         K73LmPhy08IViNG/nKQ42DaWa2h+ftyhVHszoi85Piru537mzh8m7aFeN3c88xoPCIfK
         fyaIiBBGJbprb8VLOkwawBCkk0G4JQLMB7ocTbeqy6W7nshLz/pI2rCOaAJwxa1B1fvd
         FTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WQ7kho8nNPiCZN6dDdK/LtHsVWQC24olPeq9GPw1YEU=;
        fh=o6g63Dh0TPPBpwX9ZGP2ZWriNEYOPFhd9qGfE7lWLus=;
        b=iKMpObUhTHf+PD6chJYvYIwoY1T6a+WYj6TPb0e+sXWS2ZRUHkb4/Ma865eN7oAodO
         0VCEgEA6dBaMwZufv4dX9PEFP3PZLTvJamPgzB2M632RkWp4aL5mlz+ip/J8oLDsqtK2
         neKpW3rcIB3c/+8Ow58uqgoHsw8yavbPRzl1086s4IrS58N6Z6PQILck3fzKS6bW2cdb
         5ZfJkzkx7WmZH8waVlR4mUn/m+REAwz1buhO3cXtwSCN1I/OD3pVV1O+Gq1s1sNRSa81
         h6eiPIjySw0YwYEGPN3Gvzkar0gV910j2h8MVcflJag9KHYAJ4/2AdMQeTEDgqjmDVi9
         wigw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776281235; x=1776886035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ7kho8nNPiCZN6dDdK/LtHsVWQC24olPeq9GPw1YEU=;
        b=s/amLioSoVGpC7OWVVQQZ8PyUrIMSk2hpeib9QuB06ogOU56MRGKDBOCy2SQE5FdZQ
         18wTQ5zfSIP8STV/b6vvKsKCwaYxv1fd04eILFYITlwEv05vFzl2tPN86hTi8W53D39P
         oeXw445TC97MMew19fP4cCxTYse3Ytiqr0YxW96+gAxPSssqTNW9JWRd/wHoX1q5qdi+
         8/FCkbm5M/QORwfK2Z8dk6dzO+DnRPJi4mhhdeCpkSjm32vyzugiZwPHyQjhKIee3o/L
         vD9FoADpejObFdkLSmt3r4Gm3vBm4BguaDoLSq1/cIWi6pQ/LP/4rZR9O8ZEbOBRbACf
         C+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776281235; x=1776886035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQ7kho8nNPiCZN6dDdK/LtHsVWQC24olPeq9GPw1YEU=;
        b=BsalVxyxqhdKZdds59KnGTDQACjmzo6Dy7SUFpVGh/6ZsdNYV6ANwh+6aLhrK03Zf+
         fXoIuPoe3ik7xNVa0yhe/0PoYJ4y3M73JeGKkAe9nZJ47yxOj+5GH9mnb8cH5vaXeJDk
         pmeAs7J/e94mIC0jJM7XhLGx8QeKT6htODB5JpXlchssTR+3Ey0+ZvFVgwmFHx0ppiLN
         QBi36UPem9SuYqY0ReONL1Is+0vXGjXyrODY9asn4hfbju44acLgMTvMO5QQBRDtb6YF
         Mkoqi50W36NmlW1kuj9TtNREqRqjGO0KVJ54y8816bnE5zHzFRD0Ltj1TdeBKpZhVLIh
         sZHA==
X-Forwarded-Encrypted: i=1; AFNElJ8QNKxn4MlqnlQldbRr6ExPuVrmYBDTDOMrjeKiRESWTACe00C1XIMRrBPmAz+W+TZwPKTgSdioLDMqmIVB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw7EQlkMPksyQjb8+HCA5Y/ozWqf+PVKcKXaEhr2c+hEoJUmK4
	aMFKMHdIArFc+TszRIXAeujQwDz0v/0pk2SbhPPlqhvptW1UYXFv7KqM0GQ/ZZuyYXc+5SHwO73
	l8hHY4GNVxBk1pm8MJlsJ2orGZNei8s4=
X-Gm-Gg: AeBDievv5+eflOyGEhr+1EzKcv+SvZwsI/BL9lod4qFcabsWqlHsfNPhZH5X3IwG48r
	SnGbJAu33tYSH+PtxUQROaDqOEAbMLZqlsgmQ5SNlsD9aUp7hRzb4QuSldGQ2zr10irLrlvEp+k
	1XpLfXdc8TiLsk475vtv5rOj7U0zMD3TRhFPH4X77Y+7DfshhoP5LlQ9qWqVB6vEBsJ02rzbeZc
	g0QXkuMekQ119HyLZ8Az46thWbu+cD35PCzyKzrkTeVPiUpcsYp1uaoq271pVnFYbNL2/as1VSd
	N272/i6Bg22oyvmSDg==
X-Received: by 2002:a05:6830:25c5:b0:7d9:f50f:968a with SMTP id
 46e09a7af769-7dc27c66377mr13072583a34.5.1776281234901; Wed, 15 Apr 2026
 12:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323175340.3361311-1-avagin@google.com> <20260323175340.3361311-2-avagin@google.com>
 <acGEonF9I6sPA42B@J2N7QTR9R3.cambridge.arm.com> <acJnOB-rlyt-3jU4@willie-the-truck>
 <CAEWA0a7iR8YHooqXJfhersV6YhAXGMZDUhib3QQH5XGn=KNowA@mail.gmail.com>
 <acarA3sGKY4Acozw@J2N7QTR9R3.cambridge.arm.com> <CAEWA0a7AZiuy1F+0LDxtEtJpdu=zA-RKhPb1wcDMpy2tSMFO5g@mail.gmail.com>
 <adUhbk0sKT0ucWhJ@J2N7QTR9R3>
In-Reply-To: <adUhbk0sKT0ucWhJ@J2N7QTR9R3>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 15 Apr 2026 12:27:03 -0700
X-Gm-Features: AQROBzBNtO31xd0yW9r81lEqB1GfFyuOQPPb5LE8m1aTt5Q8NnQOvyvucUSdcQk
Message-ID: <CANaxB-xitpwsU9SmQ1D7q0Jn0Ng1b4WYxzAWF3L-pE+EYzbObg@mail.gmail.com>
Subject: Re: [PATCH 1/4] exec: inherit HWCAPs from the parent process
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andrei Vagin <avagin@google.com>, Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
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

Hi Mark,

Thanks for the feedback and sorry for the delay, was on vacation.
Please see my comments inline.

On Tue, Apr 7, 2026 at 8:29=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Fri, Mar 27, 2026 at 05:21:26PM -0700, Andrei Vagin wrote:
> > Hi Mark,
> >
> > I understand all these points and they are valid. However, as I
> > mentioned, we are not trying to introduce a mechanism that will strictl=
y
> > enforce feature sets for every container. While we would like to have
> > that functionality, as you and will mentioned, it would require
> > substantially more complexity to address, and maintainers would unlikel=
y
> > to pick up that complexity.
>
> The crux of my complaint here is that unless you do that (to some
> degree), this is not going to work reliably, even with the constraints
> you outline.
>
> Further, I disagree with your proposed solution of pushing more
> constraints onto userspace (to also consider HWCAPs as overriding other
> mechainsms, etc).
>
> I think that as-is, the approach is flawed.

I would really appreciate it if we could move this conversation toward
how we can make it work.

>
> > Even masking ID registers on a per-container basis would introduce
> > extra complexity that could make architecture maintainers unhappy.
> > There were a few attempts to introduce container CPUID masking on
> > x86_64 in the past.
>
> > In CRIU, we are not aiming to handle every possible workload. Our goal
> > is to target workloads where developers are ready to cooperate and
> > willing to make adjustments to be C/R compatible. The goal here is to
> > provide developers with clear instructions on what they can do to ensur=
e
> > their applications are C/R compatible. When I say "workloads", I mean
> > this in a broad sense. A container might pack a set of tools with
> > different runtimes (Go, Java, libc-based). All these runtimes should
> > detect only allowed features.
>
> I do not think that arbitrary applications (and libraries!) should have
> to pick up additional constraints that are unnecessary without CRIU,
> especially where that goes against deliberate design decisions (e.g.
> features in arm64's HINT instruction space, which are designed to be
> usable in fast paths WITHOUT needing explicit checks of things like
> HWCAPs). Note that those typically *do* have kernel controls.
>
> I think there's a much larger problem space than you anticipate, and
> adding an incomplete solution now is just going to introduce a
> maintenance burden.

I am not adding arbitrary constraints for standard non-CRIU use cases.
Previously, I suggested that standard libraries would need to call prctl
to determine if hwcaps should be used for feature detection.  However,
we can avoid this extra syscall by adding the new HWCAP2_CR bit. Then
libraries will simply check this bit in auxv[AT_HWCAP2], meaning the
overhead for "non-criu" cases is just a single bit check.

As for HINT instructions, there are two class of instructions.

The first one doesn't change a process state and they are not required
any special handling in term of checkpoint/restore. If a process is
checkpointed on a newer cpu, and restore it on an older cpu, the older
hardware will simply skip over that instructions.  The architectural
state (registers, memory) should remain consistent.

The second class such as PAC are instructions that actually change a
process state. These instructions require kernel/userspace coordination.
For example, usage of PAC keys can be controlled from userspace via prctl.
I mean when support for new instructions is implemented in the kernel,
we will need to consider that userspace should be able to control them.

>
> > Returning to the subject of this patchset: this series extends the role
> > of hwcaps. With this change, we would establish that hwcaps is the
> > "source of truth" for which features an application can safely use. Any
> > other features available on the current CPU would not be guaranteed to
> > remain available after migration to another machine.
> >
> > After this discussion, I found that the current version missed one majo=
r
> > thing: there should be a signal indicating that hwcaps must be used for
> > feature detection. Since we will need to integrate this interface into
> > libc, Go, and other runtimes, they definitely should not rely just on
> > hwcaps by default, especially in the early stages. This can be solved
> > via the prctl command.  Libraries like libc would call
> > prctl(PR_USER_HWCAP_ENABLED). If this returns true, the runtime knows
> > that only the features explicitly listed in hwcaps should be used.
>
> I do not think we should be pushing that shape of constraint onto
> userspace.

Look at the previous command.

>
> > You are right, the controlled feature set will be limited to features
> > the kernel knows about. And yes, we would need to report CPU features i=
n
> > hwcaps even if the kernel isn't directly involved in handling them.
>
> To be clear, that is not what I am arguing.
>
> As I mentioned before, the way this works on arm64 is that the kernel
> only exposes what it is aware of, even in the ID regs accessible to
> userspace. We usually *can* hide features, and do that for cases of
> mismatched big.LITTLE, virtual machines, etc.

I understand that. My point was that the kernel would need to report
features in hwcaps even if they don't require specific kernel-side
handling.

>
> > Honestly, I am not certain if this is the "right" interface for that,
> > and I would be happy to consider other ideas. I understand that these
> > hwcaps will not work right out of the box, but we need a way to solve
> > this problem. Having a centralized API for CPU/kernel feature detection
> > seems like the right direction.
>
> I think that for better or worse the approach you are tkaing here simply
> does not solve enough of the problem to actually be worthwhile.

This approach mimics solutions that some CRIU users are already
implementing in userspace, but those only work when the user controls/
recompiles all their libraries. I am open to other ideas, but we need a
path forward.

>
> > As for signal frame size and extended states like SVE/SME, we aware
> > about this problem.  However, it is partly mitigated by the fact that i=
f
> > an application does not use some features, those states are not placed
> > in the signal frame.
>
> That is not true. The kernel can and will create signal frames for
> architectural state that a task might never have touched.
>
> Generally arm64 creates signal frames for features when the feature
> *exists*, regardless of whether the task has actively manipulated the
> relevant state. For example, on systems with SVE a trivial SVE signal
> frame gets created even if a task only uses the FPSIMD registers, and on
> systms with SME a TPIDR2 signal frame gets created even if the task has
> never read/written TPIDR2.
>
> When restoring, an unrecognised signal frame is treated as invalid, and
> we can require that certain signal frames are present.

You are right; that was my mistake. My only explanation for why we don't
see this failure often is that C/R is rarely triggered while a process
is actually
inside a signal handler. This is definitely a problem that still needs
to be solved.

>
> > In the future, when we construct/reload a signal frame, we could look
> > at a process feature set for a process and generate a frame according
> > to those features...
>
> When you say 'we' here, are you talking about within the kernel, or
> within the userspace C/R mechanism?

... within the kernel.

Thanks,
Andrei
