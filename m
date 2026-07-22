Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619A4457A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748581; cv=pass; b=mCBcT3ESAg5pU/QSo7juQFxTuECIT/vg+dP/zlZZLBy/Cvr3gMvRe5uVn6KNfCUXq933DF9Nh0V26JU28cJcY8vy+Rso/Ga27kfa6ScLXKdOxLoCAE5DjxaH/MuTdrCspOAk5VnPibfV0AW/kg42MUPnP6u+3RTkWP+Zsnv0pyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748581; c=relaxed/simple;
	bh=xC8DQShhZuKJo9FPWM3M+AGlDh6xz3AiRMbyuWOXL3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doRYFa6GjoJGob8n8pNoyi3Wc3Z+sBz9IEQJcfjM3d/80mmu1QjZt4AA8bsHJmD8oVEIBaBYO/GMhrnVOtZzLI5blRajQ5MqotihPJ1SXIiVyQ2/rVb1rZFBCjJJk70XC3riVD7ieWEKYJbBPT/0PUCXLx7ZfdFNMDEvybRnx78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDe213xD; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDe213xD"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c10e86e52so30571cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784748571; cv=none;
        d=google.com; s=arc-20260327;
        b=sCs3uyIztOx2EqygBRONdrct3eDU1qPV8d/EphPqur6B9Qy6WEgOZHSK8hA/ZYPqxY
         vjPlrOSRfcVA5imnvwCKAkX1krrCTwAykd5i6szRXzkWmVVSJCedVXp69FI43JED0JoW
         wZZrDU8EmgQ6k3x2zI5M5oekmN2vU8xNvHWJ9y7x80QlkuoO9OET1C6xOqYA7YyqQ2ms
         ocx7dA9WCZX9ENh6fJ65COdvsQ+4M8FYJ3r4YvRsJWUOOmHnbGCip5QWQpekdAZGaC2c
         zgwthQ8pa7Qwgf/JMwimaO257b2OeLIQ9mHiN8puQT+vFWzIKHUhoM3fZlWv+3BOjIXi
         JteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xC8DQShhZuKJo9FPWM3M+AGlDh6xz3AiRMbyuWOXL3Y=;
        fh=JDil2kD/fDEVW16rwOVAd65CRpqaAy/UuSLfAkUM1o4=;
        b=XzV/H97+DqNU14Oa9reDe598NBNDqgVtMMGFyjwT4SFqrSnFa9Aj3+h/rRv7Y+T+pU
         pLR0N4ohH3E4M77jRRjrU/Dq4hIl0tx5nC2ayJMEOcXzchqaO/V7+DAQJWj76erVAd0w
         72cn8oxWMAQ0o1tDLlUcl/wbMC6fNpZC2sRwIgM9japYohwqPj3wNMffwQIP+KM/wbRA
         AG8IqoRMf/nVAXx4MbRZlBtMMONTaFRszuHp+0QcGcXUVUS6vYY+o4YJtM3E+ZpFx0sG
         sR61arpmtccGr/6weQ1cmLhEe0XYTXq0j40TE1+O4xLVFbmFQ85QEQ2xIqzTThcLCs2i
         q1XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784748571; x=1785353371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xC8DQShhZuKJo9FPWM3M+AGlDh6xz3AiRMbyuWOXL3Y=;
        b=JDe213xDPosxhm9uoztiL9+L5a/G0is5vQ9xKYikkSVHuDk0v2M+Nu18p+YaDIfUbb
         T5VHWsxiPQm1Flzd+6YS1J14g9I0Ck8kFOEdSl2Q+ImsizQEG1ZHXN1CA7t8WRgXf1DJ
         ebLOudJ5ObrW//Dcot+EU3DWHdreHccSyMri5IKPeWSCfFztGMKBD0sYEdTp5f1qkqWa
         dfszkA/M4zKTmtD+RI2oPOMp/RH8vdeTDRD62BBGJiVt3mv8QuVnX4vdvXmB/38aj94H
         WJ7aGjj1a2Zcsk9mT/1LxCw1UiJ0e06queQ1w2/TSTSLs0IbR5KNm09VLRdk+esNeQXp
         Qa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784748571; x=1785353371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xC8DQShhZuKJo9FPWM3M+AGlDh6xz3AiRMbyuWOXL3Y=;
        b=RaWTmpGN9ykySHhTeRQwYNdvABEP38eptwXP6EYjeVKmUE5/nRnYw5QTzvU04WEytG
         lVVr0VoWrzVo4ErTu0X24ADtsRdWGX9/gpjq5iebTk5DpWjia1C9mxV9WVN9zQugkP4j
         u3da3dUXA6nxeIUSMy0rx/iMs3D+s7CPUHrQ1PqO2RCxVRsrLlx/ehgAzuNawXh0p8w5
         C+pYE3uGxIh+ix/XcCYjgPv5piq93jfGDXyW4BzgaZDuiwqyBWnHB1AMuI0RUp4DWk88
         6u8XAlmFmRgOP5Fymu2kERjm4GIjDJPtgBh8O/06MYNb8pZAFpIDxLDOBvCr6aFAkY1o
         HUjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqGbslgkI1Wxcgwfwmiay472sGt6ZIsnKx2TNWlCRH/25hOxDhKo3uNGdEElC+2KDJupzaUwPWaFttcaFH@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBhpwKdxiu4PWF5ej0kH72jzn600eeCmrQDZo/wPqDKi7zMc/
	Peq2l/6DthbXD/3Tmst6BGQtX1QFM1kV782oR56Y7TNkCZxmKIwBsl5hd+qpCHWI4lAbQ1Mxlf4
	uHPcOUoBKPgnB78U5usSjyCsUx1W7dF5SK1/KJ0B6
X-Gm-Gg: AR+sD11zomFNAA28F2AYIUXj5YoEGTiuft9ODfDmEBW/8UJy2s75/d0WVPq773qoeUZ
	ZeskY+4u4vGFxNFDYdWAzIowYVRdB5chf7u/EK9LofM5eiGgCx/60zZwy0xwJaQ6OFcJXRCVxsM
	kJUMbfU3mW3ao50grCnIEpNwtIcenplIxh3KG6Q6hTWpjqQ4YvUUsnbWEPvRQHrnysOPT5grh0s
	DCb55BvAZod/rIUiIM/netf+P+ZtxoX5hWXR/Y+NQ5cjdvQui76d7ux+h9piqZlo7vFIt0=
X-Received: by 2002:a05:622a:aa06:10b0:527:69ae:4796 with SMTP id
 d75a77b69052e-5283bbea81emr1569511cf.22.1784748570664; Wed, 22 Jul 2026
 12:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>
 <20260722-bonus-annehmbar-umjubelt-e899440a34aa@brauner>
In-Reply-To: <20260722-bonus-annehmbar-umjubelt-e899440a34aa@brauner>
From: Cole Faust <colefaust@google.com>
Date: Wed, 22 Jul 2026 12:29:14 -0700
X-Gm-Features: AUfX_myomyInN7QVaqT3eFpuOD74zQ_dnegBtbh5DTqsDzygqcGcu6X9hmnh6CI
Message-ID: <CA+9F0A3Z2MaiL2PoUnhkkjD0ZKppFJoEXqkoCgXvc4qwxd482A@mail.gmail.com>
Subject: Re: Questions and concerns about BPF-selected interpreter
To: Christian Brauner <brauner@kernel.org>
Cc: farid.m.zakaria@gmail.co, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

Thanks for the response. You mention a couple of times that we could
install the binfmt_misc handler and go from there, ("A one-line
binfmt_misc registration is considerably less invasive than
the glibc update you can't do", "So you can deploy the policy you want
today on hosts you administer"), but we don't control the hosts that
build android. We work with many partner companies (Samsung, Qualcomm,
etc) and have basically no visibility into how their hosts are setup,
and we certainly don't get root access. So I think it's literally
impossible for us to install a global binfmt_misc handler. We could
use user/mount namespaces to install a scoped one, but in practice we
only have 1 version of glibc used in the build, so we might as well
just bind mount it to /lib64/ld-linux-x86-64.so.2 if we were going to
use mount namespaces. So while this new binfmt_misc feature is cool,
and allows for a lot of flexibility, I don't think we would ever use
it. This means that we also wouldn't have an opportunity to "collect
data" on how it works.

Another point I'd like to call out is that we build a bunch of tools
that users will use outside of the build, like adb. It would be nice
if those tools also weren't dependant on the host system. With the
binfmt_misc solution, you'd have to run a wrapper tool to set up the
binfmt_misc handler in a mount namespace (or again, just remount the
interpreter to a fixed path) before you could run adb, which is more
friction for users.

Re: the gvisor / additional sandbox concerns, I'd like to not get into
the weeds too much on this. There are many possibilities to consider
(another being the default docker config doesn't allow mounts), so I'd
rather that we consider it a requirement to be able to use a local
interpreter without any namespaces.

Regarding security, it seems your stance is that it's safer for system
admins to opt-in to this new functionality, so that if it has security
flaws, it's their problem. I think that's a dangerous stance to take.
I could see distros like nixos opting into this because they need it
and opening themselves up to problems that they are left on their own
to defend against. If we're going to allow this, making sure we've
considered security thoroughly enough that it can be made opt-out
instead of opt-in seems safer for those users. If $ORIGIN support is
too dangerous to be opt-out, it's probably too dangerous to be opt-in.

I see your concerns about old systems running $ORIGIN binaries and
treating them as `./$ORIGIN`. Could we potentially fix that by making
a new PT_INTERP_ORIGIN section? Binaries would only be allowed to have
one of PT_INTERP or PT_INTERP_ORIGIN, so a PT_INTERP_ORIGIN binary
would fail to run on an old system, as it doesn't have a PT_INTERP
section.

> In other words, I think implementing a very custom policy into the core e=
lf loader is a dead-end even if the AT_SECURE and memfd cases simply error =
out. Every such carve-out becomes frozen uapi. The same binary then runs or=
 fails depending on whether it was reached by path, by fd, as a memfd, or t=
hrough an overlay. Each of those answers is someone's future regression rep=
ort and none of them can be changed afterwards.

Are we considering cases where the kernel errors out as API? Wouldn't
that mean adding the B and L binfmt_misc handlers are also breaking
api changes, as trying to register a handler with those types before
would've errored? IMO, erroring out explicitly reserves the API space
for the future. But I'm not a kernel dev.

> An in-kernel $ORIGIN can always be added later as one more policy. Once s=
hipped it can never be unshipped.

This is understandable. I'm not saying we should rush into adding
$ORIGIN support right now, I just wanted to keep the conversation of
it alive, and not declare victory just yet with the binfmt_misc
solution, as it doesn't cover the usecases most interesting to us. As
is, we won't be able to use the binfmt_misc solution, which is fine,
it's no worse of a state than we were in without it, but I would like
to see something more useful later on.



On Wed, Jul 22, 2026 at 3:37=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jul 21, 2026 at 05:24:21PM -0700, Cole Faust wrote:
> > Hi Christian, Farid,
> >
> > My name is Cole, I work on the android build system. We have similar
> > goals for creating hermetic and relocatable builds in our build system
> > (a custom, android-specific one). I was very excited when I saw Farid
> > working on $ORIGIN support, but then somewhat disappointed when I saw
> > the new BPF-based solution.
> >
> > Our usecase is mostly to decouple the glibc version used in the
> > android build from the host machine. We've had several instances where
> > our CI machines are running old glibc versions that cause problems,
> > and they're not trivial to update. Ideally you should be able to
> > download the android source and build it on a modern linux kernel,
> > regardless of the userspace.
> >
> > To register a binfmt_misc handler, you need either root + modifying
> > global state on the host, or to make a user+mount namespace. But if we
> > use a mount namespace, couldn't we just mount the interpreter we want
> > to use at a fixed path? I thought one of the main goals of this
> > features was to avoid the use of namespaces because they don't always
> > nest well; Farid called this out as a problem with buck2's sandboxing.
> > In android, we don't yet have any nested sandboxing but there have
> > been conversations about increasing security of the build using
> > something like gvisor to isolate the build from the kernel, in wake of
> > the recent AI-discovered local privilege escalations, after which
> > these complicated kernel features are likely to stop working. And
> > requiring root is definitely out of the question.
>
> If a single fixed path solves your problem then you indeed don't need
> any of this. A bind-mount expresses one fixed path pointing to one
> loader. The handler exists for programmable dispatch so that you match
> binaries to whatever load you want, use multiple toolchains, allow
> multiple generations coexisting, per-architecture emulators, etc.
>
> A one-line binfmt_misc registration is considerably less invasive than
> the glibc update you can't do. Plus, it's visible, revocable, and
> scopable to precisely the formats it matches. You can have the most
> restrictive policy ever that makes sure only one specific workload is
> able to use $ORIGIN during build.
>
> And gvisor doesn't forward execve() to the host kernel at all. The
> Sentry reimplements the whole exec path in Go. There is no binfmt_misc
> and even if we added $ORIGIN support to the kernel it would be invisible
> to gvisor. Under gvisor you can just patch gvisor without any
> involvement
> from us at all.
>
> gvisor doesn't forward execve() to the host kernel at all. The Sentry
> reimplements the whole exec path in Go. There is no binfmt_misc and even
> if we added $ORIGIN support to the kernel it would be invisible to
> gvisor. Under gvisor you can just patch gvisor without any involvement
> from us at all.
>
> Fwiw, with $ORIGIN support it's worse. On any kernel or sandbox that
> doesn't implement $ORIGIN this doesn't fail cleanly. A PT_INTERP of
> $ORIGIN/ld.so isn't absolute and so Linux resolves it relative to the
> caller's working directory. Execute such a "relocatable" binary with an
> attacker-controlled working directory and ./$ORIGIN/ld.so is your
> loader.
>
> So $ORIGIN-tagged binaries are actively dangerous precisely on the old
> unupdatable machines and future sandboxes you're describing. A
> binfmt_misc handler that isn't registered simply does nothing.
>
> > I also wanted to ask about the security of this bpf solution. I
> > understand there are some security concerns about $ORIGIN. Why is this
> > new binfmt_misc + bpf solution better? An attacker will still have
> > more opportunity to place a malicious loader relative to the
> > executable. With the binfmt_misc solution, you will be able to only
> > have it active for certain things, like a build, but that's only if
> > you use the user+mount namespace to scope it. From what I understand,
> > Farid plans on registering the handler globally and persistently on
> > NixOS systems that want relocatable builds, does that not make those
> > systems susceptible to these concerns? (correct me if that's not your
> > plan, Farid)
> >
> > I can't really think of a better solution than the originally-proposed
> > $ORIGIN support for build systems to use. I don't care about setuid or
> > complicated filesystems like memfd, so I would hope it would be
> > straightforward to just error out if AT_SECURE is set or if any issue
> > arises like not being able to determine the directory of the
> > executable. IMO it's fine if it only works in simple, known-safe
> > cases.
>
> This is very focussed on the $ORIGIN case and it's understandable. This
> is a very specific policy. I understand how it can be useful for a
> distribution like nixos that wants to make the loader relative to the
> binary everywhere or to some build system.
>
> But this sort of decision is policy and policy doesn't belong into the
> kernel, it belongs into userspace. The kernel's job in this scenario is
> to give userspace the tools to implement such policy in a way that it is
> flexible and doesn't just serve a single use-case.
>
> binfmt_misc exists to move custom binary policy out of the kernel and
> let userspace handle it however it sees fit. As such it is the perfect
> fit for implementing what loader to use for what binary.
>
> The power of this proposal is that $ORIGIN is just one single policy
> that can be implemented. But it also allows for other custom policies.
> You could even label binaries with xattrs and use those to decide what
> loader to use. You could scope it to cgroup or whatever. That's useful
> and I have use-cases for such policies in other projects.
>
> In other words, I think implementing a very custom policy into the core
> elf loader is a dead-end even if the AT_SECURE and memfd cases simply
> error out. Every such carve-out becomes frozen uapi. The same binary
> then runs or fails depending on whether it was reached by path, by fd,
> as a memfd, or through an overlay. Each of those answers is someone's
> future regression report and none of them can be changed afterwards.
>
> Note that the implicit argument made further up is that the security
> posture of having native $ORIGIN support is stronger than having a way
> to implement whatever policy - including $ORIGIN - via binfmt_misc.
> That's very obviously false.
>
> Implementing $ORIGIN natively means we start shipping a static, custom
> policy _to everyone_ out there next release. Whereas binfmt_misc does
> _nothing_ and only affects users that actually do need this custom
> policy and do set it up. And once they have set it up the existence of a
> policy is even visible via binfmt_misc.
>
> So the security story of enabling $ORIGIN in core elf code is a lot
> weaker: it's inflexible, it's unclear what holes it opens up, and users
> will be surprised by it.
>
> If users don't care about the bpf policy support for binfmt_misc and are
> worried about someone registering a bpf handler: CONFIG_BINFMT_MISC_BPF=
=3Dn
>
> Btw, the exact semantics you're asking for ($ORIGIN-prefixed PT_INTERP
> resolved against the binary's directory and hard failure for everything
> unusual) are about a hundred lines of bpf on top of what is already
> in the tree. The $ORIGIN demo handler written for the series does
> exactly that, including failing closed instead of falling back to the
> cwd-relative lookup mentioned above. So you can deploy the policy you
> want today on hosts you administer, collect data on how it behaves in
> practice, and if a blessed subset ever emerges that conversation can be
> had with evidence. An in-kernel $ORIGIN can always be added later as one
> more policy. Once shipped it can never be unshipped.
