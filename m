Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140540F72C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716622; cv=none; b=qxrPZxKeG/6CWTW865rs/EnDNEPoRNaIIs6TIVu+QiQSJYcd8YN1rwkSoeaD5mxRngMbVmvadJBO0n1xNCO6LObXI2OIKadEOiTfAldWtgpzQ5j0NBDDhIgdHhvSgb9/pdEqnyh7lmxLGhj3wqN2WgyUKZYATH1Sq2HGyzbjH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716622; c=relaxed/simple;
	bh=e2fl2KM6DF4yqoyrhGRgcqCoS3D+h8q6jvBwb2045A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTP9kEGTbM+tjK19EIWkTYIOnb0WFWSj+2mTGCjuZwNSInd7ff65rsxtYtBc73MElpQM03hVOJg20aH5aS4a4clteSCgYN3RUn0QZda6JD67f6D5rcteOr1KNbxAzONcMv0i0NQbT7eAK+xPI49WY+tA10q1YOIFvUyv/6umFa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccSNNoHp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccSNNoHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1B41F000E9;
	Wed, 22 Jul 2026 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716620;
	bh=qU4+o7nKrzdbsiECc0tZj+TPwCEPLNpxpGrIX8iePxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ccSNNoHpCfOOYAruvOSJFWRjy85i2++Aw4z07KXVnmrTbyC2QA0I0AOnVSGhDt2ZT
	 LRZTgSlIg9sN9n8NIveSMAxglZg/FDJY0FAlcVJf9WGQeMAzoKRAcNwM6yZSr63u3R
	 PpRcfrwo5evHqag5wYyxou4wh9G0E4bJ6Jaz4F18vS1xQE+bsPUg9VeaNxRIT0rE7b
	 WGF4oGHeDGn+jnde4KbIUjSFNNk8nLd6eOW9RORlU2GXSxcrYlZhVJwblBQX2pPemZ
	 hGzc0YGFnc95Kb0/B7ujPdBvWWr5sMG03DqB8QqmkkV5Fngt34kCGjvxe3bR8VCtV1
	 w4HEEqXAFc0NA==
Date: Wed, 22 Jul 2026 12:36:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Cole Faust <colefaust@google.com>
Cc: farid.m.zakaria@gmail.co, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Subject: Re: Questions and concerns about BPF-selected interpreter
Message-ID: <20260722-bonus-annehmbar-umjubelt-e899440a34aa@brauner>
References: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>

On Tue, Jul 21, 2026 at 05:24:21PM -0700, Cole Faust wrote:
> Hi Christian, Farid,
> 
> My name is Cole, I work on the android build system. We have similar
> goals for creating hermetic and relocatable builds in our build system
> (a custom, android-specific one). I was very excited when I saw Farid
> working on $ORIGIN support, but then somewhat disappointed when I saw
> the new BPF-based solution.
> 
> Our usecase is mostly to decouple the glibc version used in the
> android build from the host machine. We've had several instances where
> our CI machines are running old glibc versions that cause problems,
> and they're not trivial to update. Ideally you should be able to
> download the android source and build it on a modern linux kernel,
> regardless of the userspace.
> 
> To register a binfmt_misc handler, you need either root + modifying
> global state on the host, or to make a user+mount namespace. But if we
> use a mount namespace, couldn't we just mount the interpreter we want
> to use at a fixed path? I thought one of the main goals of this
> features was to avoid the use of namespaces because they don't always
> nest well; Farid called this out as a problem with buck2's sandboxing.
> In android, we don't yet have any nested sandboxing but there have
> been conversations about increasing security of the build using
> something like gvisor to isolate the build from the kernel, in wake of
> the recent AI-discovered local privilege escalations, after which
> these complicated kernel features are likely to stop working. And
> requiring root is definitely out of the question.

If a single fixed path solves your problem then you indeed don't need
any of this. A bind-mount expresses one fixed path pointing to one
loader. The handler exists for programmable dispatch so that you match
binaries to whatever load you want, use multiple toolchains, allow
multiple generations coexisting, per-architecture emulators, etc.

A one-line binfmt_misc registration is considerably less invasive than
the glibc update you can't do. Plus, it's visible, revocable, and
scopable to precisely the formats it matches. You can have the most
restrictive policy ever that makes sure only one specific workload is
able to use $ORIGIN during build.

And gvisor doesn't forward execve() to the host kernel at all. The
Sentry reimplements the whole exec path in Go. There is no binfmt_misc
and even if we added $ORIGIN support to the kernel it would be invisible
to gvisor. Under gvisor you can just patch gvisor without any
involvement
from us at all.

gvisor doesn't forward execve() to the host kernel at all. The Sentry
reimplements the whole exec path in Go. There is no binfmt_misc and even
if we added $ORIGIN support to the kernel it would be invisible to
gvisor. Under gvisor you can just patch gvisor without any involvement
from us at all.

Fwiw, with $ORIGIN support it's worse. On any kernel or sandbox that
doesn't implement $ORIGIN this doesn't fail cleanly. A PT_INTERP of
$ORIGIN/ld.so isn't absolute and so Linux resolves it relative to the
caller's working directory. Execute such a "relocatable" binary with an
attacker-controlled working directory and ./$ORIGIN/ld.so is your
loader.

So $ORIGIN-tagged binaries are actively dangerous precisely on the old
unupdatable machines and future sandboxes you're describing. A
binfmt_misc handler that isn't registered simply does nothing.

> I also wanted to ask about the security of this bpf solution. I
> understand there are some security concerns about $ORIGIN. Why is this
> new binfmt_misc + bpf solution better? An attacker will still have
> more opportunity to place a malicious loader relative to the
> executable. With the binfmt_misc solution, you will be able to only
> have it active for certain things, like a build, but that's only if
> you use the user+mount namespace to scope it. From what I understand,
> Farid plans on registering the handler globally and persistently on
> NixOS systems that want relocatable builds, does that not make those
> systems susceptible to these concerns? (correct me if that's not your
> plan, Farid)
> 
> I can't really think of a better solution than the originally-proposed
> $ORIGIN support for build systems to use. I don't care about setuid or
> complicated filesystems like memfd, so I would hope it would be
> straightforward to just error out if AT_SECURE is set or if any issue
> arises like not being able to determine the directory of the
> executable. IMO it's fine if it only works in simple, known-safe
> cases.

This is very focussed on the $ORIGIN case and it's understandable. This
is a very specific policy. I understand how it can be useful for a
distribution like nixos that wants to make the loader relative to the
binary everywhere or to some build system.

But this sort of decision is policy and policy doesn't belong into the
kernel, it belongs into userspace. The kernel's job in this scenario is
to give userspace the tools to implement such policy in a way that it is
flexible and doesn't just serve a single use-case.

binfmt_misc exists to move custom binary policy out of the kernel and
let userspace handle it however it sees fit. As such it is the perfect
fit for implementing what loader to use for what binary.

The power of this proposal is that $ORIGIN is just one single policy
that can be implemented. But it also allows for other custom policies.
You could even label binaries with xattrs and use those to decide what
loader to use. You could scope it to cgroup or whatever. That's useful
and I have use-cases for such policies in other projects.

In other words, I think implementing a very custom policy into the core
elf loader is a dead-end even if the AT_SECURE and memfd cases simply
error out. Every such carve-out becomes frozen uapi. The same binary
then runs or fails depending on whether it was reached by path, by fd,
as a memfd, or through an overlay. Each of those answers is someone's
future regression report and none of them can be changed afterwards.

Note that the implicit argument made further up is that the security
posture of having native $ORIGIN support is stronger than having a way
to implement whatever policy - including $ORIGIN - via binfmt_misc.
That's very obviously false.

Implementing $ORIGIN natively means we start shipping a static, custom
policy _to everyone_ out there next release. Whereas binfmt_misc does
_nothing_ and only affects users that actually do need this custom
policy and do set it up. And once they have set it up the existence of a
policy is even visible via binfmt_misc.

So the security story of enabling $ORIGIN in core elf code is a lot
weaker: it's inflexible, it's unclear what holes it opens up, and users
will be surprised by it.

If users don't care about the bpf policy support for binfmt_misc and are
worried about someone registering a bpf handler: CONFIG_BINFMT_MISC_BPF=n

Btw, the exact semantics you're asking for ($ORIGIN-prefixed PT_INTERP
resolved against the binary's directory and hard failure for everything
unusual) are about a hundred lines of bpf on top of what is already
in the tree. The $ORIGIN demo handler written for the series does
exactly that, including failing closed instead of falling back to the
cwd-relative lookup mentioned above. So you can deploy the policy you
want today on hosts you administer, collect data on how it behaves in
practice, and if a blessed subset ever emerges that conversation can be
had with evidence. An in-kernel $ORIGIN can always be added later as one
more policy. Once shipped it can never be unshipped.
