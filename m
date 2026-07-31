Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0527A476;
	Fri, 31 Jul 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490887; cv=none; b=BRNcWKbPnc9oKXi8d9vhd3OH6ggC1227RS4CEuPnmdGYG69VdWx13zCGizDivrzlFskBEuMudItiHNDcRgssuHwoUF5NDlF+B3OolumJd2LJ3MZ6EGTOgFCQfev51JACV9GZxbpJ8jeELaNv9JnIVeZuK3Gcu2G4eLQRoHQmj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490887; c=relaxed/simple;
	bh=5swYhhwmDsY2I9Ui+t/EYKiUCwSQ//1AdDb9h151IAQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=caL37fyEVl2pX6NE4akTd32623Bfy8SThdDS+oSMgRHPAu/TH2UKXQ0n7oW4i6vdlLQuWjKtEdtbJmQ2kV0OQ6TUvPKxG35OwmyOl0wDbFh/3sJ2YgxqEwX/JrQF31BcLFGKAHEUDMYAWj2bMQ6sMXhn4hZe4XXh0AaYsac95xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHyBtkKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHyBtkKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DE71F000E9;
	Fri, 31 Jul 2026 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490885;
	bh=5swYhhwmDsY2I9Ui+t/EYKiUCwSQ//1AdDb9h151IAQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MHyBtkKNKk3PEr5OOfeeq8QoOqdVgZebFzrICCA4sG84mDkQi7+EaB6HoTGaQyshu
	 0znkSDBjxiq9NNhR9e/hSLDQ3SvrjizbYbnZ4UuT4lWFuFUXYiJZPPcl2JxBufqJ+y
	 +GWnAAk1f27gj71hMC+fop9oXfWuUzUI4EjN2EjjyPHF0oga/Pv9zs0FdpcQ3QGonX
	 lp6W8b9RLCCbWvOR1fHg+M6dzgwYEjmaeqCqEYDc3CtEDnRMbbKng9wYbp13Jakh8K
	 1TK5gR4ZpdCqF9o2U5nEPtet1EUK+sdVdoXp7uEVMRSX/KvOSNieu8qbN99DB/R++t
	 S70FvHl+p+XQw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
From: Christian Brauner <brauner@kernel.org>
To: Alessandro Di Federico <ale@rev.ng>
Cc: Christian Brauner <brauner@kernel.org>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, david.laight.linux@gmail.com, 
 jack@suse.cz, jannh@google.com, kees@kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mail@johnericson.me, 
 shuah@kernel.org, viro@zeniv.linux.org.uk, Gemini <assistant@google.com>
In-Reply-To: <20260731004604.53c66732@spawn>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
 <20260722011217.45e79a08@spawn>
 <20260722-raser-leselust-konsolidieren-05f8e36a0782@brauner>
 <20260731004604.53c66732@spawn>
Date: Fri, 31 Jul 2026 11:41:20 +0200
Message-Id: <20260731-batterie-galant-zumachen-d4b91acf8af0@brauner>
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=7481; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5swYhhwmDsY2I9Ui+t/EYKiUCwSQ//1AdDb9h151IAQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTl5B5KWTjLcrO8T5fsZTvlOXIRH1qbIkvP+GafUQs8U
 WzxWnxeRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESqVjMybGf+PC3smJ7QM7cv
 dSV95xlSZ7jfEmVdcvjNwYkzow0YPRj+ae3obLgz9/5Gwbmn9Qz/NGyfnxh+7IDyVN7geYnZBpo
 WXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, Jul 31, 2026 at 12:46:04AM +0200, Alessandro Di Federico wrote:
> One could delegate the feature to user space, but that makes it much
> harder to get adopted in a uniform way.
>
> Will systemd, Android [1] and OpenWrt implement this? In the same way?
> If so, at that point it could have just been a feature of the Linux ELF
> extension.

Whether systemd, Android or OpenWrt adopt something isn't a decision the
kernel gets to make and it isn't one it has to make. Merging code doesn't
create adoption. It creates an obligation to keep the behavior working
forever. That includes the machines whose owners never asked for it.

It's also not how ELF conventions get established. PT_GNU_STACK and
PT_GNU_PROPERTY are the two OS-range headers our loader acts on. And
they came out of the toolchain and we implemented them afterwards.

The one time we picked a program header type ourselves ahead of the ABI
PT_ARM_MEMTAG_MTE in 761b9b366cec we collided with PT_AARCH64_UNWIND
and had to change the name and the value three months later. We got away
with it because it's a coredump segment that gdb reads, not the exec
behavior of every binary on the system.

If you want systemd, Android and OpenWrt to agree on one marker, the
thing that produces that agreement is generic-abi with binutils and
glibc/musl on board, and then we can implement it.

So we don't actually disagree about there being an ELF feature. We
disagree about what the header means. My position is that the header
names the intent and userspace implements the resolution. Yours is that
the kernel does both.

> Of course the Android people could disable the feature even if it's
> in the kernel, but if the convention is established by the kernel,
> there's really no reason to deviate from it in the way it's implemented.

The kernel can't establish this convention. It can only implement one.
If binutils won't emit the header and no loader cooperates, we've shipped
uapi that nothing uses and that we still can't remove.

> The whole point of the portability thing is to reduce the assumptions
> you make about the target system. Ideally, you just want to use
> features widely available in kernels in the wild.

Sure, but nothing merged today is widely available tomorrow. Both need a
new kernel. Uniform-by-default doesn't arrive sooner because it went
into core elf.

And a new phdr doesn't degrade nicely. On any kernel that doesn't know
it the binary has no PT_INTERP it loads as static. Dies horribly at an
unrelocated _start.

And keeping a literal $ORIGIN fallback in PT_INTERP instead and old
kernels or gVisor open it cwd-relative, so an attacker who controls cwd
plants ./$ORIGIN/ld.so.

> But from what I understand from another thread, your intention is to
> use userspace as testbench, correct?

Not testbench as in "go away and come back later". The difference is
where the semantics live once they turn out to be wrong. Get a corner
case wrong in a bpf handler and the distro ships a fix in the next
update. Get it wrong in load_elf_binary() and it's the exec behavior of
arbitrary binaries... which we can't change afterwards.

> > This is policy that the admin should decide
>
> Agreed, but the admin is probably satisfied with enabling/disabling,
> not deciding whether the program header type is `PT_INTERP_WITH_ORIGIN`
> or `PT_ORIGIN_ENABLED_INTERP`. Same for the distro maintainers.

Nobody is asking an admin to name a program header type. The distro ships
the handler and a file in /etc/binfmt.d and the admin never sees either.

But note what you argued here... If it needs an enable/disable switch
then it is policy. And the only question left is what the switch looks
like. A global boot-time on/off is the worst available version of it.
It's one bit, machine-wide and can't be scoped to a subtree, can't be
delegated.

> Then, from a security perspective, AFAIU, implementing this in
> eBPF does not solve the problems that have been discussed.
>
> For instance, `selftests/exec: add binfmt_misc bpf-backed handler test`
> does string manipulation (no `openat`).

The handler doing nothing but string manipulation isn't a simplification
in the example. It's the design. The program never opens anything. It
computes a path and hands it back, and the kernel opens it with
open_exec() under the credentials of whoever called execve(). There is
no openat() to add. And fwiw, it also supports pre-opened binaries for
really crazy use-cases where you want to pin a set of loaders once.

The module RFC resolved $ORIGIN in kernel code opened the interpreter
itself with file_open_root(..., O_RDONLY, 0).
That skips everything open_exec() does and it achors path resolution at
the binary's directory. .. clamps there and absolute symlinks resolve
inside it. $ORIGIN/../lib/ld.so, which is the RPATH idiom everyone
actually writes, silently means <bindir>/lib/ld.so.

I'm not holding an RFC to final-code standards. The point is that this
is fiddly.

> Overall, I feel like the current proposal pushes back on having a new
> ELF feature for security reasons, but then delegates to distro
> maintainers who want to use the feature to take those risks.

It doesn't delegate the risk. It binds it to whoever wants the feature.

Whether resolving the loader relative to the binary is safe depends on
invariants of the deployment. Is the tree immutable, who may write to it,
which prefixes are trusted. The kernel doesn't know any of that.
/nix/store is root-owned and immutable, so the policy is safe there. The
same semantics pointed at a directory the user can write to is a hole.
Only the deployment can tell those two apart.

Userspace arrived at the same answer, incidentally. glibc expands $ORIGIN
under __libc_enable_secure only when it is the first path component and
the result is rooted in a trusted directory. That trusted-directory
notion is exactly what an in-kernel implementation would have to invent.
And it is deployment-specific.

> But also, distro maintainers don't really need this feature because
> they can just write /nix.

Right, and that's the honest core of it. The people who need this are
users on machines that someone else administers.

But "default-enabled ELF feature" is a strange shape of fix for it.
Because the machines you'd be enabling it on belong to the people who
never asked. This proposals is to change what exec does for everyone
else in order to serve some use-cases.

> I'd be happy to try to work on the example eBPF program using openat,
> address the various security concerns that have been mentioned until it
> looks right and then it could be loaded by default, but with an option
> to disable it. But I'm not sure whether there's such a thing as "default
> loaded eBPF program".

And there is such a thing. The distro ships the object plus a file in
/etc/binfmt.d and systemd loads it at boot. That is a default-loaded
program with an option to disable, it just lives in the distro image
rather than in vmlinux. If one handler ends up being what everybody
ships, that's the uniformity you're after, and nobody had to freeze
resolution semantics to get it. Could even be upstream in systemd.

> Alternatively, I could extend the ELF core as a parallel feature of
> the eBPF-based mechanism, reviving some patches from previous
> iterations.

I'd rather not, for the reasons above.

