Received: from rev.ng (rev.ng [94.130.142.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F363B19CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.130.142.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451794; cv=none; b=EvWEdvxTgV80JCF2pobWmuwhVgy6JNeusb8lUnxOIT68tmnIRBw97h9zrFjX0p3UoJsRlYvUEfQjLSgZxW1i7jkTi/Fv9CfdKqH6fQKeHvc4acCQ6S6AFaoTkt5p91vI7QYSiyHalgPtTCxKMYoBmUjorGip+/zWi3ZhG2Hrl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451794; c=relaxed/simple;
	bh=TfYW1H35mdWfUhfLN2YgBFGM+Zh70cNHVmyfnn9rTxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngNfu+bCC9DdMq2mOgH8GDPYJYrAcrGeZdUzAWt6SeuDbisPuoVc433R9uo10G3pNzhwCv35Ja4MwoZVmpIJAvIEXX3HeVUdYMhTdRKDbvfL2KOeHtJ3P9+4zq8Cta5LcVlvGVuvNn3Dsg9f9W8sxClVJxSEeE35LcJpVZm5Ab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rev.ng; spf=pass smtp.mailfrom=rev.ng; dkim=pass (1024-bit key) header.d=rev.ng header.i=@rev.ng header.b=g1Ibl3Nr; arc=none smtp.client-ip=94.130.142.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rev.ng
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rev.ng
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rev.ng header.i=@rev.ng header.b="g1Ibl3Nr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
	s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
	List-Help; bh=LOd9UrQsAdyElCk/EAoUmPp3WhTfkS5ZbjxAY1UmPmY=; b=g1Ibl3NrKz9tqwb
	dS1vqf6lMX9EXkKT5EcBGyoRwrBO9rUI3nmdgRE0fcKP0dGH5RgSBl6/Hiki0+vg5fX9Yr8EqirH+
	yXGEPppxgrnFtco4SdB+PFRlsZl5JjlVY3axaFTM6cJXX9wjRBbCMs5YNde3z86iDalmqpmb2vsCF
	8o=;
Date: Fri, 31 Jul 2026 00:48:00 +0200
From: Alessandro Di Federico <ale@rev.ng>
To: Christian Brauner <brauner@kernel.org>
Cc: Cole Faust <colefaust@google.com>, farid.m.zakaria@gmail.co,
 linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: Questions and concerns about BPF-selected interpreter
Message-ID: <20260731004800.6a570438@spawn>
In-Reply-To: <20260723-erfassen-datteln-gebot-f7ecb8c42f6e@brauner>
References: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>
 <20260722-bonus-annehmbar-umjubelt-e899440a34aa@brauner>
 <CA+9F0A3Z2MaiL2PoUnhkkjD0ZKppFJoEXqkoCgXvc4qwxd482A@mail.gmail.com>
 <20260723-erfassen-datteln-gebot-f7ecb8c42f6e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 15:15:37 +0200
Christian Brauner <brauner@kernel.org> wrote:

> And the deployment data doesn't have to come from android. nixos and
> rev.ng style deployments will generate it.

Unfortunately, we won't be able to adopt these feature if it requires
root.

> Tools you hand to arbitrary end users won't be covered by any
> kernel-side mechanism for years no matter which one wins because most
> user machines run old kernels.

Well, we're here to improve things in the long run and have a new modern
solution to a stack of suboptimal solutions (see below).

> Is the tree immutable? Who may write to it? Which prefixes are
> trusted? The kernel doesn't know any of that. So no amount of
> security consideration produces semantics that are safe to turn on
> for everyone.

Can you elaborate a scenario?
It seems to me that this is not so much different from RPATH+$ORIGIN
for dynamic linking in user space.

> But an old kernel doesn't cleanly refuse such a binary.
> load_elf_binary() simply ignores program header types it doesn't know. A
> binary with PT_INTERP_ORIGIN and no PT_INTERP loads as static and jumps
> to an entry point that was never relocated and so crashes instead of
> failing with a clean error.

To clarify, the scenario I have in mind is:

```
./enter-sdk-shell
./bin/myprogram
```

`myprogram` has both PT_INTERP_ORIGIN (relative) and PT_INTERP
(absolute /ld.so).

`enter-sdk-shell` detects the features available:

1. If `PT_INTERP_ORIGIN` is supported, just go.

2. If you have user namespaces available, create a new mount namespace
   and put /ld.so there, then go.

3. If everything else fails, ptrace all the things.

Ideally, with time, we'll be able to use just 1).

Note that 2) is not ideal, you basically need to:

```
mkdir ~/fake-root
for X in /*; do
  mount -o bind "$X" ~/fake-root/$(basename "$X")
done

mount -o bind ~/ld.so ~/fake-root/ld.so
userns-chroot ~/fake-root
```

If, for some reason, someone does `mkdir /new-dir` outside of the
chroot, `new-dir` won't be visible from the inside.

This is not a proper solution, it's an hack due to the lack of
something like `$ORIGIN`.

Also, the fact that AppArmor restricts user namespace to trusted
programs is a problem for me as someone distributing software but, from
a security perspective, I understand that. AFAIK many LPE exploits have
a critical path through user namespaces.

$ORIGIN in PT_INTERP would have an indirect side-effect of reducing the
use case for user namespaces.

> Where I remain firm is the split. The header names the intent and the
> handler implements the semantics. If deployments later show that one
> specific resolution policy is stable and safe, graduating that subset
> into the kernel is a discussion we can have.

Can you elaborate a scenario emerging from data that would persuade you
in one way and another scenario that would persuade you in the other
way?

AFAIU you would like to have systemd implement in eBPF
`PT_INTERP_ORIGIN`, see if they get exploited and then maybe implement
it with the acquired wisdom from their experience?

It makes sense, but tbh the most likely scenario is just that this
feature will never take off.
Maybe we can just look at what happened to other kernels, like Illumos:

    https://www.illumos.org/issues/6987
    https://engineering.backtrace.io/2016-06-29-exploiting-elf-expansion-variables/

Or even glibc:

    https://seclists.org/fulldisclosure/2010/Oct/257

On Wed, 22 Jul 2026 12:36:55 +0200
Christian Brauner <brauner@kernel.org> wrote:

> A PT_INTERP of $ORIGIN/ld.so isn't absolute and so Linux resolves it
> relative to the caller's working directory. Execute such a
> "relocatable" binary with an attacker-controlled working directory
> and ./$ORIGIN/ld.so is your loader.

For real? A relative path in PT_INTERP is interpreted relative to cwd?
This is the most cursed thing I've heard in a while.
I understand that Linux has strict policy of not breaking user space,
but I would ban this right away.

-- 
Alessandro Di Federico
rev.ng Labs
