Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DA470E80
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765814; cv=none; b=BDLUYU/5Vesf1qZHcN3NKllTXYVxj7aH9MgVZlEpztMTKpZP4TpuXCkM3OwEUfLUFb9ihbogLZVeCi+0F6dFmTBCY28B9yxMCSoP6Qj2rO4SFQ2IQTn6i/usc0sEt7qvBs7Iie1jrcIqjwZ78sdXrQLV/pe1qioUU2+CHtnJjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765814; c=relaxed/simple;
	bh=HyY1mUV8rjwX8+ec5ToPMwu3EGZljNfcC5khCTDEryg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=W1dnlaS7FZ5ZspwIst5PW6iPfeNEpUsyYXkxiCkpKM6jr04zvfVbxmMcBFZbiLtSKC5PPGvDAiIt2c8K6QJ+5jVdDm0R4TWGHOrK2DGgnitLvkFje9I1AtzlFqh2dymw0HezQE2VjHr+1keH9+ihf4mmZ6ZB4MhgoHdYLfYNSt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkcGTII+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkcGTII+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8486ac3f347so20699b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 17:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784765812; x=1785370612; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HyY1mUV8rjwX8+ec5ToPMwu3EGZljNfcC5khCTDEryg=;
        b=GkcGTII+8pD9o2ocj83xkOMDM80lAYD0Kecoja8pDhfH4A8g6r2zFjoeX2vXFgiOrT
         F3V51irjzLoIW23nrqwVU6oAcUG+qu6Yvz8vsgnXKGBa+J3RQ/nAn33ImbWdPrXFR6H5
         0X/SQy+c9wEota155CPUTzx4ec0J0NQsrTcz4nFuYIQgejKYje/4YBGXSCkOOctucIaZ
         K3JdrFdtIWIzwodCMVxjPh9zCkHKMWbFb7Nj3ebj6EyJdGHt/o2xJrNrIKdvk0RKhuyw
         lXjCOTa+r38F8YDZy/PVPNmEgH+hT9SgfNKjFpcwzdg2SqDNt3jLpBKvYnePymeayg/5
         UbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784765812; x=1785370612;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HyY1mUV8rjwX8+ec5ToPMwu3EGZljNfcC5khCTDEryg=;
        b=iuLsh3tQ9UWsQ4k4yF0XhLcuNgdUdlsKJMrEhvtHPC9kMwdw6qJZppOGRrPncnp3T7
         zGrExUGRWVHpVYpi4uCtDkTy2BP803Tkeky9n/a0bWYE64bGyWN7xvGN2Qsr99R/pv4M
         Fad50r/vAwf3v9deALgm/iLuiMOlyYb2i+W+xSYY8MlDGSWcwuLQ/hT99IpZh0MJVLaz
         cVkZxWmoNn2SAMTYjNQaNyG8BMRvUH4sII8XAnRr4WXCN6wSxrx/grVLpkmJHU7uDUkf
         oHiHkn0zWkSjykM9f9RlkXQsH/scU5p6VT7q8VfpVt8PK+CfMO5jSERaa5pdijJYX8ig
         QJTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFgg9kXmQ55xpfx03fU8v8YhLtNMo1lv0dL9IiUSPUNxfB+WkG10GAG5Uzc8Q99Pdsq1yO34lGV0jxOkvR@vger.kernel.org
X-Gm-Message-State: AOJu0YzBdWz5JU3RHoU200O6y8EhEDPb6o79eOUDw4k7xoleseLAZLJg
	xFdIJ/nvnr9Ka5c7SXuV/cbzFMv9eSxAZaCUDi/ohsnY8gohRnaKfcTR
X-Gm-Gg: AR+sD12zS64q57gG2SbMrd5AgGWEMQTaDpxClBlM2I4zkXN09iaBciWmBNNsPDk+Lwz
	Wg1ZJjDO5KDkbDPnRMT9QSqgvT117YclozBhyGXkFVVwsdIH3oD09tJ6lRPR6Q2gs9rqnwFH5Mc
	mCR0YysR1j7VdXay3hwUdXZOX94ghyU93jr3GaiR3wMb06rZ6gs+H+PVpILp8S7GetHJpyxLEW5
	bibuQFzRHk6Irqd21zYBnUOeymzArJ9s/B8FqP9ZrZEZnvcbKlWX4EFcdp05cL3x1BpRIazCQbp
	6B7Ss9bkq1vU/6pNd7hOGcehUK/P6MHHaQV+QjXc+X6Q8oQXbF/C5EMagM+dOaONO4ymTenP+/p
	nBYjvdCMGa6PWmzmknVDatadBc7sF4xyFpctOg+h3pbRtc67qiqjqpTecBgWrzk81A5KLkAasF1
	pAo5o=
X-Received: by 2002:a05:6a21:46c4:b0:3c3:80bc:1540 with SMTP id adf61e73a8af0-3c44c96010dmr485552637.3.1784765811990;
        Wed, 22 Jul 2026 17:16:51 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df09ac0sm11941218eec.16.2026.07.22.17.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 17:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 17:16:50 -0700
Message-Id: <DK5IOE7CB3LL.1NWYU3NYZHO2Z@gmail.com>
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Cole Faust" <colefaust@google.com>, "Christian Brauner"
 <brauner@kernel.org>
Cc: <farid.m.zakaria@gmail.co>, <linux-fsdevel@vger.kernel.org>, "Jann Horn"
 <jannh@google.com>
Subject: Re: Questions and concerns about BPF-selected interpreter
X-Mailer: aerc 0.21.0
References: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com> <20260722-bonus-annehmbar-umjubelt-e899440a34aa@brauner> <CA+9F0A3Z2MaiL2PoUnhkkjD0ZKppFJoEXqkoCgXvc4qwxd482A@mail.gmail.com>
In-Reply-To: <CA+9F0A3Z2MaiL2PoUnhkkjD0ZKppFJoEXqkoCgXvc4qwxd482A@mail.gmail.com>

On Wed Jul 22, 2026 at 12:29 PM PDT, Cole Faust wrote:
> Hi Christian,
>
> Thanks for the response. You mention a couple of times that we could
> install the binfmt_misc handler and go from there, ("A one-line
> binfmt_misc registration is considerably less invasive than
> the glibc update you can't do", "So you can deploy the policy you want
> today on hosts you administer"), but we don't control the hosts that
> build android. We work with many partner companies (Samsung, Qualcomm,
> etc) and have basically no visibility into how their hosts are setup,
> and we certainly don't get root access. So I think it's literally
> impossible for us to install a global binfmt_misc handler. We could
> use user/mount namespaces to install a scoped one, but in practice we
> only have 1 version of glibc used in the build, so we might as well
> just bind mount it to /lib64/ld-linux-x86-64.so.2 if we were going to
> use mount namespaces. So while this new binfmt_misc feature is cool,
> and allows for a lot of flexibility, I don't think we would ever use
> it. This means that we also wouldn't have an opportunity to "collect
> data" on how it works.
>
> Another point I'd like to call out is that we build a bunch of tools
> that users will use outside of the build, like adb. It would be nice
> if those tools also weren't dependant on the host system. With the
> binfmt_misc solution, you'd have to run a wrapper tool to set up the
> binfmt_misc handler in a mount namespace (or again, just remount the
> interpreter to a fixed path) before you could run adb, which is more
> friction for users.
>
> Re: the gvisor / additional sandbox concerns, I'd like to not get into
> the weeds too much on this. There are many possibilities to consider
> (another being the default docker config doesn't allow mounts), so I'd
> rather that we consider it a requirement to be able to use a local
> interpreter without any namespaces.
>
> Regarding security, it seems your stance is that it's safer for system
> admins to opt-in to this new functionality, so that if it has security
> flaws, it's their problem. I think that's a dangerous stance to take.
> I could see distros like nixos opting into this because they need it
> and opening themselves up to problems that they are left on their own
> to defend against. If we're going to allow this, making sure we've
> considered security thoroughly enough that it can be made opt-out
> instead of opt-in seems safer for those users. If $ORIGIN support is
> too dangerous to be opt-out, it's probably too dangerous to be opt-in.
>
> I see your concerns about old systems running $ORIGIN binaries and
> treating them as `./$ORIGIN`. Could we potentially fix that by making
> a new PT_INTERP_ORIGIN section? Binaries would only be allowed to have
> one of PT_INTERP or PT_INTERP_ORIGIN, so a PT_INTERP_ORIGIN binary
> would fail to run on an old system, as it doesn't have a PT_INTERP
> section.
>

It's funny you mention PT_INTERP_ORIGIN as that's what was also proposed
on the mailing list here by Alessandro [1]

I also proposed PT_INTERP_NIX in the BPF example. We probably should
collaborate on a single proposal; we should (can) propose it to the ABI
at generic-abi@googlegroups.com or wherever it is discussed.

Once this lands, I liked the systemd solution Christian also offered
here [2].

We can propose this upstream to Debian & Fedora. That way at least you
have a gating function for clients by suggesting that they need Fedora
or Debian version >=3D X (which you presumably already set).

Happy to discuss this privately as well. I will continue to follow the
thread (hopefully I am now tagged with my correct email) and will
propose it upstream to NixOS as well -- although large changes like this
are always more political to get merged in.

Cool to see all the interest in the topic though.

>> In other words, I think implementing a very custom policy into the core =
elf loader is a dead-end even if the AT_SECURE and memfd cases simply error=
 out. Every such carve-out becomes frozen uapi. The same binary then runs o=
r fails depending on whether it was reached by path, by fd, as a memfd, or =
through an overlay. Each of those answers is someone's future regression re=
port and none of them can be changed afterwards.
>
> Are we considering cases where the kernel errors out as API? Wouldn't
> that mean adding the B and L binfmt_misc handlers are also breaking
> api changes, as trying to register a handler with those types before
> would've errored? IMO, erroring out explicitly reserves the API space
> for the future. But I'm not a kernel dev.
>
>> An in-kernel $ORIGIN can always be added later as one more policy. Once =
shipped it can never be unshipped.
>
> This is understandable. I'm not saying we should rush into adding
> $ORIGIN support right now, I just wanted to keep the conversation of
> it alive, and not declare victory just yet with the binfmt_misc
> solution, as it doesn't cover the usecases most interesting to us. As
> is, we won't be able to use the binfmt_misc solution, which is fine,
> it's no worse of a state than we were in without it, but I would like
> to see something more useful later on.
>
>
>
> On Wed, Jul 22, 2026 at 3:37=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
>>
>> On Tue, Jul 21, 2026 at 05:24:21PM -0700, Cole Faust wrote:
>> > Hi Christian, Farid,
>> >
>> > My name is Cole, I work on the android build system. We have similar
>> > goals for creating hermetic and relocatable builds in our build system
>> > (a custom, android-specific one). I was very excited when I saw Farid
>> > working on $ORIGIN support, but then somewhat disappointed when I saw
>> > the new BPF-based solution.
>> >
>> > Our usecase is mostly to decouple the glibc version used in the
>> > android build from the host machine. We've had several instances where
>> > our CI machines are running old glibc versions that cause problems,
>> > and they're not trivial to update. Ideally you should be able to
>> > download the android source and build it on a modern linux kernel,
>> > regardless of the userspace.
>> >
>> > To register a binfmt_misc handler, you need either root + modifying
>> > global state on the host, or to make a user+mount namespace. But if we
>> > use a mount namespace, couldn't we just mount the interpreter we want
>> > to use at a fixed path? I thought one of the main goals of this
>> > features was to avoid the use of namespaces because they don't always
>> > nest well; Farid called this out as a problem with buck2's sandboxing.
>> > In android, we don't yet have any nested sandboxing but there have
>> > been conversations about increasing security of the build using
>> > something like gvisor to isolate the build from the kernel, in wake of
>> > the recent AI-discovered local privilege escalations, after which
>> > these complicated kernel features are likely to stop working. And
>> > requiring root is definitely out of the question.
>>
>> If a single fixed path solves your problem then you indeed don't need
>> any of this. A bind-mount expresses one fixed path pointing to one
>> loader. The handler exists for programmable dispatch so that you match
>> binaries to whatever load you want, use multiple toolchains, allow
>> multiple generations coexisting, per-architecture emulators, etc.
>>
>> A one-line binfmt_misc registration is considerably less invasive than
>> the glibc update you can't do. Plus, it's visible, revocable, and
>> scopable to precisely the formats it matches. You can have the most
>> restrictive policy ever that makes sure only one specific workload is
>> able to use $ORIGIN during build.
>>
>> And gvisor doesn't forward execve() to the host kernel at all. The
>> Sentry reimplements the whole exec path in Go. There is no binfmt_misc
>> and even if we added $ORIGIN support to the kernel it would be invisible
>> to gvisor. Under gvisor you can just patch gvisor without any
>> involvement
>> from us at all.
>>
>> gvisor doesn't forward execve() to the host kernel at all. The Sentry
>> reimplements the whole exec path in Go. There is no binfmt_misc and even
>> if we added $ORIGIN support to the kernel it would be invisible to
>> gvisor. Under gvisor you can just patch gvisor without any involvement
>> from us at all.
>>
>> Fwiw, with $ORIGIN support it's worse. On any kernel or sandbox that
>> doesn't implement $ORIGIN this doesn't fail cleanly. A PT_INTERP of
>> $ORIGIN/ld.so isn't absolute and so Linux resolves it relative to the
>> caller's working directory. Execute such a "relocatable" binary with an
>> attacker-controlled working directory and ./$ORIGIN/ld.so is your
>> loader.
>>
>> So $ORIGIN-tagged binaries are actively dangerous precisely on the old
>> unupdatable machines and future sandboxes you're describing. A
>> binfmt_misc handler that isn't registered simply does nothing.
>>
>> > I also wanted to ask about the security of this bpf solution. I
>> > understand there are some security concerns about $ORIGIN. Why is this
>> > new binfmt_misc + bpf solution better? An attacker will still have
>> > more opportunity to place a malicious loader relative to the
>> > executable. With the binfmt_misc solution, you will be able to only
>> > have it active for certain things, like a build, but that's only if
>> > you use the user+mount namespace to scope it. From what I understand,
>> > Farid plans on registering the handler globally and persistently on
>> > NixOS systems that want relocatable builds, does that not make those
>> > systems susceptible to these concerns? (correct me if that's not your
>> > plan, Farid)
>> >
>> > I can't really think of a better solution than the originally-proposed
>> > $ORIGIN support for build systems to use. I don't care about setuid or
>> > complicated filesystems like memfd, so I would hope it would be
>> > straightforward to just error out if AT_SECURE is set or if any issue
>> > arises like not being able to determine the directory of the
>> > executable. IMO it's fine if it only works in simple, known-safe
>> > cases.
>>
>> This is very focussed on the $ORIGIN case and it's understandable. This
>> is a very specific policy. I understand how it can be useful for a
>> distribution like nixos that wants to make the loader relative to the
>> binary everywhere or to some build system.
>>
>> But this sort of decision is policy and policy doesn't belong into the
>> kernel, it belongs into userspace. The kernel's job in this scenario is
>> to give userspace the tools to implement such policy in a way that it is
>> flexible and doesn't just serve a single use-case.
>>
>> binfmt_misc exists to move custom binary policy out of the kernel and
>> let userspace handle it however it sees fit. As such it is the perfect
>> fit for implementing what loader to use for what binary.
>>
>> The power of this proposal is that $ORIGIN is just one single policy
>> that can be implemented. But it also allows for other custom policies.
>> You could even label binaries with xattrs and use those to decide what
>> loader to use. You could scope it to cgroup or whatever. That's useful
>> and I have use-cases for such policies in other projects.
>>
>> In other words, I think implementing a very custom policy into the core
>> elf loader is a dead-end even if the AT_SECURE and memfd cases simply
>> error out. Every such carve-out becomes frozen uapi. The same binary
>> then runs or fails depending on whether it was reached by path, by fd,
>> as a memfd, or through an overlay. Each of those answers is someone's
>> future regression report and none of them can be changed afterwards.
>>
>> Note that the implicit argument made further up is that the security
>> posture of having native $ORIGIN support is stronger than having a way
>> to implement whatever policy - including $ORIGIN - via binfmt_misc.
>> That's very obviously false.
>>
>> Implementing $ORIGIN natively means we start shipping a static, custom
>> policy _to everyone_ out there next release. Whereas binfmt_misc does
>> _nothing_ and only affects users that actually do need this custom
>> policy and do set it up. And once they have set it up the existence of a
>> policy is even visible via binfmt_misc.
>>
>> So the security story of enabling $ORIGIN in core elf code is a lot
>> weaker: it's inflexible, it's unclear what holes it opens up, and users
>> will be surprised by it.
>>
>> If users don't care about the bpf policy support for binfmt_misc and are
>> worried about someone registering a bpf handler: CONFIG_BINFMT_MISC_BPF=
=3Dn
>>
>> Btw, the exact semantics you're asking for ($ORIGIN-prefixed PT_INTERP
>> resolved against the binary's directory and hard failure for everything
>> unusual) are about a hundred lines of bpf on top of what is already
>> in the tree. The $ORIGIN demo handler written for the series does
>> exactly that, including failing closed instead of falling back to the
>> cwd-relative lookup mentioned above. So you can deploy the policy you
>> want today on hosts you administer, collect data on how it behaves in
>> practice, and if a blessed subset ever emerges that conversation can be
>> had with evidence. An in-kernel $ORIGIN can always be added later as one
>> more policy. Once shipped it can never be unshipped.

[1] https://lore.kernel.org/linux-fsdevel/20260722011217.45e79a08@spawn/#t
[2] https://lore.kernel.org/linux-fsdevel/20260722-raser-leselust-konsolidi=
eren-05f8e36a0782@brauner/
