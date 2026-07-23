Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C5B413790
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812561; cv=none; b=Xmk1C4q748ZaMFlI9GahGOz1xWFWXifVb79e9xssa/d8b+uPJFC32ppl7ysnXrkTPX8MoShjW/DgS3Tpyp1z/AkFVgPw55/blET5zEDh3GEZEQrgDPkGSWvHky5lb+FefSXScWQGGzrCwU0et161rOftXy0XKeh6D7q3+vq8llI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812561; c=relaxed/simple;
	bh=hKQZkj8ZcN40k9cM7/EiAH7gyT65nMQ0VrfVO70Pb8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReVnqiRSTRQY5XiLXPLSr6MntBtFxroAmXAXBfdVf+cI63vkRb6DX4yBWDln/NtuFfV1N0aWkWn/NLIyENKTIWAEz6rm+1UMuBl3hbn0gQZAiusPyIiiZj+MUynlf9X+4bfpR0czTWYQwQ5FUfYIJKVBdfyRr5wWwzhjlqqzu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvMqGUw0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvMqGUw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6541F000E9;
	Thu, 23 Jul 2026 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784812552;
	bh=8u9T1H1lES+jmAaUdZ1bLtL1Ig7iizQtznNPLVwmn2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mvMqGUw0BLj/LQsobHiSAi64fgM3d1wB1jICXxvsKPVDXLZFQsEK/hwcUTPcmobgY
	 HrErH4PpXX3Eew8bdIMWJIhUKRc+6JdSvv7KZFFANtMLUCqdxVgOaC84YR6sKEcRzj
	 JwC82yUtvmaVkThB3QCzSnAm1bmk6S3bJBleEYTjep1gzxzJHC4+z/3wU+owSmDR7y
	 Ctj07KPqT5BXGQiYcS3gXLj5O0lCe2lzQaRGvgqi/Bh0KSeNWpOgv+1pJZqTqJMWPT
	 vGjcPuyYlmDia0RawmVIwQ5SnMDqyFhjeWBbE2PziM9rPOsTHp62Vf2nbqhb59OQH/
	 EECbmU8V5s3xQ==
Date: Thu, 23 Jul 2026 15:15:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Cole Faust <colefaust@google.com>
Cc: farid.m.zakaria@gmail.co, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Subject: Re: Questions and concerns about BPF-selected interpreter
Message-ID: <20260723-erfassen-datteln-gebot-f7ecb8c42f6e@brauner>
References: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>
 <20260722-bonus-annehmbar-umjubelt-e899440a34aa@brauner>
 <CA+9F0A3Z2MaiL2PoUnhkkjD0ZKppFJoEXqkoCgXvc4qwxd482A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+9F0A3Z2MaiL2PoUnhkkjD0ZKppFJoEXqkoCgXvc4qwxd482A@mail.gmail.com>

On Wed, Jul 22, 2026 at 12:29:14PM -0700, Cole Faust wrote:
> Hi Christian,

Hey, this is a really petty complaint but general protocol for lkml
threads is bottom- or inline posting. This makes it a bit harder to keep
everythin in order.

> 
> Thanks for the response. You mention a couple of times that we could

Thank you for your arguments.

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

That's a fair point. If you don't control the hosts you can't register a
handler on them. But the exact same is true for native $ORIGIN. You
can't put a new kernel on Samsung's build machines either. Native
$ORIGIN reaches those hosts the same way a handler does. The host gets a
distro refresh at some point and you gate on the version which afaiu you
already do in some form.

So reach and timeline seem similar. The difference is what is frozen
once it arrives. With native $ORIGIN the resolution semantics are kernel
ABI forever. With a marker header plus a distro-shipped handler the
semantics live in a small userspace program that the distro can fix,
tighten, or extend in a regular update. Same machines, same delay, very
different cost when something inevitably needs to change.

And the deployment data doesn't have to come from android. nixos and
rev.ng style deployments will generate it.

> Another point I'd like to call out is that we build a bunch of tools
> that users will use outside of the build, like adb. It would be nice
> if those tools also weren't dependant on the host system. With the
> binfmt_misc solution, you'd have to run a wrapper tool to set up the
> binfmt_misc handler in a mount namespace (or again, just remount the
> interpreter to a fixed path) before you could run adb, which is more
> friction for users.

Tools you hand to arbitrary end users won't be covered by any
kernel-side mechanism for years no matter which one wins because most
user machines run old kernels. If adb must work on any host today the
answer is toolchain-side. Either static linking or a small bootstrap
that locates the bundled loader relative to /proc/self/exe. That's
independent of this whole discussion imho.

> Re: the gvisor / additional sandbox concerns, I'd like to not get into
> the weeds too much on this. There are many possibilities to consider
> (another being the default docker config doesn't allow mounts), so I'd
> rather that we consider it a requirement to be able to use a local
> interpreter without any namespaces.

Sure. Note that with a distro-shipped default policy that requirement is
met. The user just execs the binary. No namespaces, no root, no wrapper.
The privileged part happened once, when the distro was assembled.

> Regarding security, it seems your stance is that it's safer for system
> admins to opt-in to this new functionality, so that if it has security
> flaws, it's their problem. I think that's a dangerous stance to take.
> I could see distros like nixos opting into this because they need it
> and opening themselves up to problems that they are left on their own
> to defend against. If we're going to allow this, making sure we've
> considered security thoroughly enough that it can be made opt-out
> instead of opt-in seems safer for those users. If $ORIGIN support is
> too dangerous to be opt-out, it's probably too dangerous to be opt-in.

That's not my stance. The point isn't to shift liability to admins.
The point is that whether resolving a loader relative to the binary is
safe depends on invariants of the concrete deployment. Is the tree
immutable? Who may write to it? Which prefixes are trusted? The kernel
doesn't know any of that. So no amount of security consideration
produces semantics that are safe to turn on for everyone.

A nixos handler that only fires for /nix/store is safe because the store
is root-owned and immutable. The same semantics pointed at a
world-writable directory are a hole. Only the deployment knows which of
the two it is.

"if it's too dangerous to be opt-out it's too dangerous to be opt-in" is
a bit of a trick imho. By that logic no LSM policy, no sysctl, no
sudoers, and no PAM configuration could exist. Security policy that
depends on context is configured. That's not a defect.

Distros can configure this however they see fit.

> I see your concerns about old systems running $ORIGIN binaries and
> treating them as `./$ORIGIN`. Could we potentially fix that by making
> a new PT_INTERP_ORIGIN section? Binaries would only be allowed to have
> one of PT_INTERP or PT_INTERP_ORIGIN, so a PT_INTERP_ORIGIN binary
> would fail to run on an old system, as it doesn't have a PT_INTERP
> section.

A new program header type as a pure marker is completely fine by me
and a lot better than hiding magic strings in PT_INTERP.

The handler matches on it, the distro ships the default policy for it,
and the 'L' series does the substitution. Alessandro floated the same
idea as PT_INTERP_WITH_ORIGIN and Farid as PT_INTERP_NIX.

But an old kernel doesn't cleanly refuse such a binary.
load_elf_binary() simply ignores program header types it doesn't know. A
binary with PT_INTERP_ORIGIN and no PT_INTERP loads as static and jumps
to an entry point that was never relocated and so crashes instead of
failing with a clean error.

Where I remain firm is the split. The header names the intent and the
handler implements the semantics. If deployments later show that one
specific resolution policy is stable and safe, graduating that subset
into the kernel is a discussion we can have.

> > In other words, I think implementing a very custom policy into the core elf loader is a dead-end even if the AT_SECURE and memfd cases simply error out. Every such carve-out becomes frozen uapi. The same binary then runs or fails depending on whether it was reached by path, by fd, as a memfd, or through an overlay. Each of those answers is someone's future regression report and none of them can be changed afterwards.
> 
> Are we considering cases where the kernel errors out as API? Wouldn't
> that mean adding the B and L binfmt_misc handlers are also breaking
> api changes, as trying to register a handler with those types before
> would've errored? IMO, erroring out explicitly reserves the API space
> for the future. But I'm not a kernel dev.

No. Registering a handler is a root-only configuration interface.
Accepting a new flag there is ordinary interface evolution. Same as a
new mount option or a new prctl. It's deterministic. The same string
fails on an old kernel and works on a new one and whoever registers
checks for that.

What I called frozen uapi is the exec behavior of arbitrary binaries.
With native $ORIGIN the same binary succeeds or fails depending on how
it was reached and those context-dependent outcomes are exactly what
userspace silently grows dependencies on and what we can never change
afterwards. Erroring out reserves design space when the error is
deterministic and context-free. These aren't.

> 
> > An in-kernel $ORIGIN can always be added later as one more policy. Once shipped it can never be unshipped.
> 
> This is understandable. I'm not saying we should rush into adding
> $ORIGIN support right now, I just wanted to keep the conversation of
> it alive, and not declare victory just yet with the binfmt_misc
> solution, as it doesn't cover the usecases most interesting to us. As
> is, we won't be able to use the binfmt_misc solution, which is fine,
> it's no worse of a state than we were in without it, but I would like
> to see something more useful later on.

Keeping it alive is welcome and nothing here is declared victory. My
pushback is about which layer owns which piece. The marker header via
generic-abi or whatever plus distro-shipped default policy gets you and
Alessandro by-default behavior on the systems that matter without
freezing resolution semantics into core elf on day one.

> On Wed, Jul 22, 2026 at 3:37 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Jul 21, 2026 at 05:24:21PM -0700, Cole Faust wrote:
> > > Hi Christian, Farid,
> > >
> > > My name is Cole, I work on the android build system. We have similar
> > > goals for creating hermetic and relocatable builds in our build system
> > > (a custom, android-specific one). I was very excited when I saw Farid
> > > working on $ORIGIN support, but then somewhat disappointed when I saw
> > > the new BPF-based solution.
> > >
> > > Our usecase is mostly to decouple the glibc version used in the
> > > android build from the host machine. We've had several instances where
> > > our CI machines are running old glibc versions that cause problems,
> > > and they're not trivial to update. Ideally you should be able to
> > > download the android source and build it on a modern linux kernel,
> > > regardless of the userspace.
> > >
> > > To register a binfmt_misc handler, you need either root + modifying
> > > global state on the host, or to make a user+mount namespace. But if we
> > > use a mount namespace, couldn't we just mount the interpreter we want
> > > to use at a fixed path? I thought one of the main goals of this
> > > features was to avoid the use of namespaces because they don't always
> > > nest well; Farid called this out as a problem with buck2's sandboxing.
> > > In android, we don't yet have any nested sandboxing but there have
> > > been conversations about increasing security of the build using
> > > something like gvisor to isolate the build from the kernel, in wake of
> > > the recent AI-discovered local privilege escalations, after which
> > > these complicated kernel features are likely to stop working. And
> > > requiring root is definitely out of the question.
> >
> > If a single fixed path solves your problem then you indeed don't need
> > any of this. A bind-mount expresses one fixed path pointing to one
> > loader. The handler exists for programmable dispatch so that you match
> > binaries to whatever load you want, use multiple toolchains, allow
> > multiple generations coexisting, per-architecture emulators, etc.
> >
> > A one-line binfmt_misc registration is considerably less invasive than
> > the glibc update you can't do. Plus, it's visible, revocable, and
> > scopable to precisely the formats it matches. You can have the most
> > restrictive policy ever that makes sure only one specific workload is
> > able to use $ORIGIN during build.
> >
> > And gvisor doesn't forward execve() to the host kernel at all. The
> > Sentry reimplements the whole exec path in Go. There is no binfmt_misc
> > and even if we added $ORIGIN support to the kernel it would be invisible
> > to gvisor. Under gvisor you can just patch gvisor without any
> > involvement
> > from us at all.
> >
> > gvisor doesn't forward execve() to the host kernel at all. The Sentry
> > reimplements the whole exec path in Go. There is no binfmt_misc and even
> > if we added $ORIGIN support to the kernel it would be invisible to
> > gvisor. Under gvisor you can just patch gvisor without any involvement
> > from us at all.
> >
> > Fwiw, with $ORIGIN support it's worse. On any kernel or sandbox that
> > doesn't implement $ORIGIN this doesn't fail cleanly. A PT_INTERP of
> > $ORIGIN/ld.so isn't absolute and so Linux resolves it relative to the
> > caller's working directory. Execute such a "relocatable" binary with an
> > attacker-controlled working directory and ./$ORIGIN/ld.so is your
> > loader.
> >
> > So $ORIGIN-tagged binaries are actively dangerous precisely on the old
> > unupdatable machines and future sandboxes you're describing. A
> > binfmt_misc handler that isn't registered simply does nothing.
> >
> > > I also wanted to ask about the security of this bpf solution. I
> > > understand there are some security concerns about $ORIGIN. Why is this
> > > new binfmt_misc + bpf solution better? An attacker will still have
> > > more opportunity to place a malicious loader relative to the
> > > executable. With the binfmt_misc solution, you will be able to only
> > > have it active for certain things, like a build, but that's only if
> > > you use the user+mount namespace to scope it. From what I understand,
> > > Farid plans on registering the handler globally and persistently on
> > > NixOS systems that want relocatable builds, does that not make those
> > > systems susceptible to these concerns? (correct me if that's not your
> > > plan, Farid)
> > >
> > > I can't really think of a better solution than the originally-proposed
> > > $ORIGIN support for build systems to use. I don't care about setuid or
> > > complicated filesystems like memfd, so I would hope it would be
> > > straightforward to just error out if AT_SECURE is set or if any issue
> > > arises like not being able to determine the directory of the
> > > executable. IMO it's fine if it only works in simple, known-safe
> > > cases.
> >
> > This is very focussed on the $ORIGIN case and it's understandable. This
> > is a very specific policy. I understand how it can be useful for a
> > distribution like nixos that wants to make the loader relative to the
> > binary everywhere or to some build system.
> >
> > But this sort of decision is policy and policy doesn't belong into the
> > kernel, it belongs into userspace. The kernel's job in this scenario is
> > to give userspace the tools to implement such policy in a way that it is
> > flexible and doesn't just serve a single use-case.
> >
> > binfmt_misc exists to move custom binary policy out of the kernel and
> > let userspace handle it however it sees fit. As such it is the perfect
> > fit for implementing what loader to use for what binary.
> >
> > The power of this proposal is that $ORIGIN is just one single policy
> > that can be implemented. But it also allows for other custom policies.
> > You could even label binaries with xattrs and use those to decide what
> > loader to use. You could scope it to cgroup or whatever. That's useful
> > and I have use-cases for such policies in other projects.
> >
> > In other words, I think implementing a very custom policy into the core
> > elf loader is a dead-end even if the AT_SECURE and memfd cases simply
> > error out. Every such carve-out becomes frozen uapi. The same binary
> > then runs or fails depending on whether it was reached by path, by fd,
> > as a memfd, or through an overlay. Each of those answers is someone's
> > future regression report and none of them can be changed afterwards.
> >
> > Note that the implicit argument made further up is that the security
> > posture of having native $ORIGIN support is stronger than having a way
> > to implement whatever policy - including $ORIGIN - via binfmt_misc.
> > That's very obviously false.
> >
> > Implementing $ORIGIN natively means we start shipping a static, custom
> > policy _to everyone_ out there next release. Whereas binfmt_misc does
> > _nothing_ and only affects users that actually do need this custom
> > policy and do set it up. And once they have set it up the existence of a
> > policy is even visible via binfmt_misc.
> >
> > So the security story of enabling $ORIGIN in core elf code is a lot
> > weaker: it's inflexible, it's unclear what holes it opens up, and users
> > will be surprised by it.
> >
> > If users don't care about the bpf policy support for binfmt_misc and are
> > worried about someone registering a bpf handler: CONFIG_BINFMT_MISC_BPF=n
> >
> > Btw, the exact semantics you're asking for ($ORIGIN-prefixed PT_INTERP
> > resolved against the binary's directory and hard failure for everything
> > unusual) are about a hundred lines of bpf on top of what is already
> > in the tree. The $ORIGIN demo handler written for the series does
> > exactly that, including failing closed instead of falling back to the
> > cwd-relative lookup mentioned above. So you can deploy the policy you
> > want today on hosts you administer, collect data on how it behaves in
> > practice, and if a blessed subset ever emerges that conversation can be
> > had with evidence. An in-kernel $ORIGIN can always be added later as one
> > more policy. Once shipped it can never be unshipped.

-- 
