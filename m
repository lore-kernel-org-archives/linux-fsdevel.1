Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56134041C
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 22:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785711259; cv=none; b=hQGpzaZspHyhoFY5f6HaknTlzcz2y7UqDd02esfn0czazmgVqhXh/nAyCx3KS95vKID0IvNKpnFXxrFtaXjcarpIDREiSytPK29S0t1QXKl36NHC9kPsAiKYsDfSL2PlGLKu7uaUb609P8lSUE9+sTwgIQ32dtfvvN+LgY7U8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785711259; c=relaxed/simple;
	bh=hSFBKkmya71V99CcvaKtLUtW6MLEeCo92pqjKBtH7Xc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cCEanT29iW5iE1bA7VDPRgpZtN1ck/FMsCI5REtmknGAEcx11XF2L0jU7qGGT4mVFx2wEq/u61JpKDeLx6ASiQunoBEnZ0/LCbHsdwvyh2iPCEllsCPHYj5gnuFKshuiK4k5WmdGgSW30B+r99xJsvAh+FxCMUcWxKqosxiP5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bY3uP0kR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY3uP0kR"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3149823b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 15:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785711257; x=1786316057; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hSFBKkmya71V99CcvaKtLUtW6MLEeCo92pqjKBtH7Xc=;
        b=bY3uP0kRMsuULbpZlFeF5RWa9VlHnvoG/QRyfnPiTkaXJBsbSXy1pyPlzZrn61gtRW
         TCbbFJyca4jIEoSovch7cesNS0uXJ4pZIdOUtrp8mvJenMcJmT8JdhHM36g2kjDjgeV3
         vP/Qxdk0ILb3sPOFY4zGSC1IHf8VDlwojSsLBf82KLRf95vMHsccVLSIUPJgPVirRd7M
         oRS0j15F0TNIIN/nh8LW3kj5Jar8gkXX7RwNHfzZPiMQstOeT0pOoQQ2vCfsY8U/JRlO
         oDyW16EqZzal2HKTcIsszbC8cqlf1ibcDjqMGTUfpOxxOLWHMAh/lDL4CtJjjWetAI/h
         ydGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785711257; x=1786316057;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hSFBKkmya71V99CcvaKtLUtW6MLEeCo92pqjKBtH7Xc=;
        b=kxPOEJ8ogpiFcNqAZqKGFPMqWX5ODn1817Jq38M36flFT5QdTyXrFopSDHnGe0c0x/
         P3D/mFhDS5acCn+WlARcthDDyKv+wwyythfHkBy8I++gEU4JXOAouAy9/qZDUxt+8hk/
         jd/H3BzZpP0RjicskIKQuk7qTH0ak1EbI1vaYDH7y9o/gIRGpDF62r8yKZQdkG8oCWGN
         WZHQ2/j/eu0rt4S0ckaaV355nyVKUMzgn8tjHicevoXu/H9rvNpDMlbuNPMRM7Ck/T/a
         cl/yJdxalD2SD2QkGsKS+CXyDnEiGxFbG2IKmt1hBdHmcTUOMjpXwYbYXbGn0agYNex4
         74EQ==
X-Forwarded-Encrypted: i=1; AHgh+RpAi14AmmTzLF30kn/L09tSvBqrrIVO27yetaUgzAbcdbq2cUHncqBy8lGvlYty4GFjWIUsEzMIMWcllJeK@vger.kernel.org
X-Gm-Message-State: AOJu0YyZbTL7LsrvOlev/wxq4q3irHubnS3LPvfai/e7E0Xp3frbSG1k
	FGvcxxFQ1YJ4Haq2JNGRP0V5CXxdeRh8O/pVvLbZBVBkC7r6rF7CghNX
X-Gm-Gg: AR+sD118t234Gk0digmRDlcsXXSX+2VFwSNRkxYcps9BGed2sGQRi/rtvvm2MbYViBm
	P7ouhQs9Nx/YcO+WUukT/TPEYOz768cu8q88fbvj+5z/OgFyu3O8jsjxI6iaKP0ndxBMF5M/7X/
	wFmjHsYB9myhQnSgD8u1UME4l0GZgCBaFzykCcpV93RbmHHPwbtDp4wvXyUHBAXK/UEJ1k+4WvT
	dQGHG6E0/9he+BiPaCvqTDwYKudXIO0EW5gSbxtNiSf/lQPTFLgV376YkrcjUuqEiuad5phUn7U
	l9DJou1Ek3x6/ca626QfO3zyJ7GuadNPHczIhXU6/HYsz3NOrIWXDZ+etMa6xOkp/CqXCErvB0l
	PdJUjaL/Q96fP+3uEwxgPZ9sJgt6xB/L/2LaVz898x6JhLxX8NjfZt0vauylxEDp/Ac12cAVHub
	K8uvgxVIYPperc2PMbPUPg3/mG2hiWnePkkJOUZzPXu+GMXIdsLswBYmV+99ylogQ=
X-Received: by 2002:a05:6a20:b598:b0:3c0:e552:f2d with SMTP id adf61e73a8af0-3c92a761f35mr7446088637.34.1785711257265;
        Sun, 02 Aug 2026 15:54:17 -0700 (PDT)
Received: from localhost ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e70esm50339576eec.29.2026.08.02.15.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 15:54:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 15:54:15 -0700
Message-Id: <DKETT5RWDAG9.1AP6L1IJ3CL72@gmail.com>
Cc: "Farid Zakaria" <farid.m.zakaria@gmail.com>,
 <david.laight.linux@gmail.com>, <jack@suse.cz>, <jannh@google.com>,
 <kees@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-mm@kvack.org>, <mail@johnericson.me>, <shuah@kernel.org>,
 <viro@zeniv.linux.org.uk>, "Gemini" <assistant@google.com>
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Alessandro Di Federico"
 <ale@rev.ng>
X-Mailer: aerc 0.21.0
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
 <20260722011217.45e79a08@spawn>
 <20260722-raser-leselust-konsolidieren-05f8e36a0782@brauner>
 <20260731004604.53c66732@spawn>
 <20260731-batterie-galant-zumachen-d4b91acf8af0@brauner>
In-Reply-To: <20260731-batterie-galant-zumachen-d4b91acf8af0@brauner>

On Fri Jul 31, 2026 at 2:41 AM PDT, Christian Brauner wrote:
> On Fri, Jul 31, 2026 at 12:46:04AM +0200, Alessandro Di Federico wrote:
>> One could delegate the feature to user space, but that makes it much
>> harder to get adopted in a uniform way.
>>
>> Will systemd, Android [1] and OpenWrt implement this? In the same way?
>> If so, at that point it could have just been a feature of the Linux ELF
>> extension.
>
> Whether systemd, Android or OpenWrt adopt something isn't a decision the
> kernel gets to make and it isn't one it has to make. Merging code doesn't
> create adoption. It creates an obligation to keep the behavior working
> forever. That includes the machines whose owners never asked for it.
>
> It's also not how ELF conventions get established. PT_GNU_STACK and
> PT_GNU_PROPERTY are the two OS-range headers our loader acts on. And
> they came out of the toolchain and we implemented them afterwards.
>
> The one time we picked a program header type ourselves ahead of the ABI
> PT_ARM_MEMTAG_MTE in 761b9b366cec we collided with PT_AARCH64_UNWIND
> and had to change the name and the value three months later. We got away
> with it because it's a coredump segment that gdb reads, not the exec
> behavior of every binary on the system.
>
> If you want systemd, Android and OpenWrt to agree on one marker, the
> thing that produces that agreement is generic-abi with binutils and
> glibc/musl on board, and then we can implement it.
>
> So we don't actually disagree about there being an ELF feature. We
> disagree about what the header means. My position is that the header
> names the intent and userspace implements the resolution. Yours is that
> the kernel does both.
>
>> Of course the Android people could disable the feature even if it's
>> in the kernel, but if the convention is established by the kernel,
>> there's really no reason to deviate from it in the way it's implemented.
>
> The kernel can't establish this convention. It can only implement one.
> If binutils won't emit the header and no loader cooperates, we've shipped
> uapi that nothing uses and that we still can't remove.
>
>> The whole point of the portability thing is to reduce the assumptions
>> you make about the target system. Ideally, you just want to use
>> features widely available in kernels in the wild.
>
> Sure, but nothing merged today is widely available tomorrow. Both need a
> new kernel. Uniform-by-default doesn't arrive sooner because it went
> into core elf.
>
> And a new phdr doesn't degrade nicely. On any kernel that doesn't know
> it the binary has no PT_INTERP it loads as static. Dies horribly at an
> unrelocated _start.
>
> And keeping a literal $ORIGIN fallback in PT_INTERP instead and old
> kernels or gVisor open it cwd-relative, so an attacker who controls cwd
> plants ./$ORIGIN/ld.so.
>
>> But from what I understand from another thread, your intention is to
>> use userspace as testbench, correct?
>
> Not testbench as in "go away and come back later". The difference is
> where the semantics live once they turn out to be wrong. Get a corner
> case wrong in a bpf handler and the distro ships a fix in the next
> update. Get it wrong in load_elf_binary() and it's the exec behavior of
> arbitrary binaries... which we can't change afterwards.
>
>> > This is policy that the admin should decide
>>
>> Agreed, but the admin is probably satisfied with enabling/disabling,
>> not deciding whether the program header type is `PT_INTERP_WITH_ORIGIN`
>> or `PT_ORIGIN_ENABLED_INTERP`. Same for the distro maintainers.
>
> Nobody is asking an admin to name a program header type. The distro ships
> the handler and a file in /etc/binfmt.d and the admin never sees either.
>
> But note what you argued here... If it needs an enable/disable switch
> then it is policy. And the only question left is what the switch looks
> like. A global boot-time on/off is the worst available version of it.
> It's one bit, machine-wide and can't be scoped to a subtree, can't be
> delegated.
>
>> Then, from a security perspective, AFAIU, implementing this in
>> eBPF does not solve the problems that have been discussed.
>>
>> For instance, `selftests/exec: add binfmt_misc bpf-backed handler test`
>> does string manipulation (no `openat`).
>
> The handler doing nothing but string manipulation isn't a simplification
> in the example. It's the design. The program never opens anything. It
> computes a path and hands it back, and the kernel opens it with
> open_exec() under the credentials of whoever called execve(). There is
> no openat() to add. And fwiw, it also supports pre-opened binaries for
> really crazy use-cases where you want to pin a set of loaders once.
>
> The module RFC resolved $ORIGIN in kernel code opened the interpreter
> itself with file_open_root(..., O_RDONLY, 0).
> That skips everything open_exec() does and it achors path resolution at
> the binary's directory. .. clamps there and absolute symlinks resolve
> inside it. $ORIGIN/../lib/ld.so, which is the RPATH idiom everyone
> actually writes, silently means <bindir>/lib/ld.so.
>
> I'm not holding an RFC to final-code standards. The point is that this
> is fiddly.
>
>> Overall, I feel like the current proposal pushes back on having a new
>> ELF feature for security reasons, but then delegates to distro
>> maintainers who want to use the feature to take those risks.
>
> It doesn't delegate the risk. It binds it to whoever wants the feature.
>
> Whether resolving the loader relative to the binary is safe depends on
> invariants of the deployment. Is the tree immutable, who may write to it,
> which prefixes are trusted. The kernel doesn't know any of that.
> /nix/store is root-owned and immutable, so the policy is safe there. The
> same semantics pointed at a directory the user can write to is a hole.
> Only the deployment can tell those two apart.
>
> Userspace arrived at the same answer, incidentally. glibc expands $ORIGIN
> under __libc_enable_secure only when it is the first path component and
> the result is rooted in a trusted directory. That trusted-directory
> notion is exactly what an in-kernel implementation would have to invent.
> And it is deployment-specific.
>
>> But also, distro maintainers don't really need this feature because
>> they can just write /nix.
>
> Right, and that's the honest core of it. The people who need this are
> users on machines that someone else administers.
>
> But "default-enabled ELF feature" is a strange shape of fix for it.
> Because the machines you'd be enabling it on belong to the people who
> never asked. This proposals is to change what exec does for everyone
> else in order to serve some use-cases.
>
>> I'd be happy to try to work on the example eBPF program using openat,
>> address the various security concerns that have been mentioned until it
>> looks right and then it could be loaded by default, but with an option
>> to disable it. But I'm not sure whether there's such a thing as "default
>> loaded eBPF program".
>
> And there is such a thing. The distro ships the object plus a file in
> /etc/binfmt.d and systemd loads it at boot. That is a default-loaded
> program with an option to disable, it just lives in the distro image
> rather than in vmlinux. If one handler ends up being what everybody
> ships, that's the uniformity you're after, and nobody had to freeze
> resolution semantics to get it. Could even be upstream in systemd.
>
>> Alternatively, I could extend the ELF core as a parallel feature of
>> the eBPF-based mechanism, reviving some patches from previous
>> iterations.
>
> I'd rather not, for the reasons above.

Christian,

Could you help me please understand how the next branch makes
its way to the kernel?

I see NixOS Offers the latest as of 7.1.

The topic for binfmt is named on 7.3.binfmt in vfs so my assumption is
that it's slated for 7.3.

So that means when Linux pulls for 7.3.rc1 I could start to test it on
NixOS? Maybe 3 more weeks?




