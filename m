Received: from rev.ng (rev.ng [94.130.142.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252D34DCE4;
	Tue, 21 Jul 2026 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.130.142.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677433; cv=none; b=SOVvE2skk29nv/bT7UZUn3Ub9iRPqBwEanT8lP8PGamnsLbFaITpUsuwn5wT6Xi6kuto13/0W8p0SCSxnmXlBvrq4rUL+Ip1fUkoMZehZrR+rN1C2X/H4ptxE9nCzhKgTb9CDi7lq+OEgUKSzLSIs8WeQpFlFTy35J573VoUiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677433; c=relaxed/simple;
	bh=g6YfZsj0eGJY09CfqZWfUBomH4c9euuvF++MXBsDTNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W86LHU+Mn87eL3fgIfJM2TanpPK9cIgBH5kUR8CvSeopqhj8/FDpfo4pSyyJwvB+VOCIuzUzWVfCZ2aavcj+4d+RtVxzsmihCoKrPfZRSWfcw8kGu2MDck+CjMqC2vAb6MvZ41aSz4KxanpTc+eHAr3voutUlfFaPgCiiSKWL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rev.ng; spf=pass smtp.mailfrom=rev.ng; dkim=pass (1024-bit key) header.d=rev.ng header.i=@rev.ng header.b=Cm+9ttcF; arc=none smtp.client-ip=94.130.142.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rev.ng
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rev.ng
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rev.ng header.i=@rev.ng header.b="Cm+9ttcF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
	s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
	List-Help; bh=6RrEHHSPxeM7rdWT0hfycPsvOnFeT0A9FFnWzE4N1zg=; b=Cm+9ttcF+8oHHzW
	Qpp2AmmbKSuZTuRKmWPaUVg5lPnF+zfqZ1cwGFXevVOVemoz2ujAcYxcuzffOFUlbeRnvJDpGRV43
	CBD+WgAOqtEYxZ1hLAX4i+xLdo/bMudOuCE8OpUM/veNlD58rYySHxczGn/AoFqfz9sF8GrulWRB7
	VA=;
Date: Wed, 22 Jul 2026 01:18:08 +0200
From: Alessandro Di Federico <ale@rev.ng>
To: Christian Brauner <brauner@kernel.org>, Farid Zakaria
 <farid.m.zakaria@gmail.com>
Cc: david.laight.linux@gmail.com, jack@suse.cz, jannh@google.com,
 kees@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, mail@johnericson.me, shuah@kernel.org,
 viro@zeniv.linux.org.uk, Gemini <assistant@google.com>
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
Message-ID: <20260722011217.45e79a08@spawn>
In-Reply-To: <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
	<20260704211409.1978485-1-farid.m.zakaria@gmail.com>
	<20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
	<CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
	<20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Jul 2026 13:34:46 +0200
Christian Brauner <brauner@kernel.org> wrote:

> > That makes sense -- but you will need CAP_BPF etc.. to load the new
> > programs though if inside a userns.  
> 
> Right, bpf tokens exist to delegate bpf access to containers. Not
> always ideal but it works for such cases. 

Hi everyone, first post here.

tl;dr I think an $ORIGIN+PT_INTERP-like feature should be available by
default (no root) since portable software is most important when you're
an unprivileged user.

I've recently read about this patch and I'm super excited. An
ORIGIN-like feature for loaders is something I wanted for years. Let me
share our use case + some additional nix use cases.

We have a package/build system that makes heavy use of RPATH+ORIGIN to
make portable installation directories of our software, as in: extract
a plain .tar in ~/mysoftware, `./myexecutable` and it works [1]. No
root, no run-time patching, no namespaces.

Now, this means we need to ship all of our dependencies properly
RPATH'd (using $ORIGIN). The only exception is the libc, which we can't
ship, since we can't put $ORIGIN in PT_INTERP. This means we
need to link against an ancient libc in order to be compatible with
a wide range of host libcs. Needless to say, is a *huge* pain.

This patch could in theory solve our problems, except for the "no root"
part, which I think it's the most important one. After all, if you
assume your user is root (at least at install time), you don't have big
problems, just drop your software in /opt/mysoftware and ship your
loader in there.

But I think being able to use $ORIGIN from non-root users would be
useful also for nix, not when you are on NixOS (where I'd assume they'd
enable PT_INTERP_NIX by default), but when you're on a non-NixOS system.

There are several projects that aim at running nix without root:

    https://github.com/davhau/nix-portable
    https://github.com/nixie-dev/nixie

Currently they either use user namespaces or ptrace. However, the former
is restricted under Ubuntu (`apparmor_restrict_unprivileged_unconfined`)
and the latter is not ideal.
AFAIU it'd be possible to avoid all of this if $ORIGIN was available by
default in PT_INTERP, or at least the biggest roadblocker would go away.

I understand that enabling $ORIGIN in PT_INTERP can be problematic (I
should dig into that actually).
However, in whatever way this gets supported, I think that in order to
be actually useful in the most important use cases where portability is
important (i.e., no root, no user namespaces), having this feature
available *by default* is important.

> In any case, I think it wouldn't be crazy to allow registering
> "default" handlers that appear in all binfmt_misc instances if needed
> so containers with separate binfmt_misc always have the bpf program
> available. [...]

Maybe we can have a "default eBPF program" loaded for
`PT_INTERP_WITH_ORIGIN`?

We toolchain people are happy to tamper with our binaries, but if these
features are not available by default, their use is going to be limited.

In any case, thanks for this work, I've been wanting this for a long
time.

--
Alessandro Di Federico
rev.ng Labs

[1] https://github.com/revng/orchestra

Note that this is soon going to be dismissed in favor of nix itself.

Example artifact:

wget 'https://rev.ng/downloads/revng-distributable/develop.tar.xz'
tar xaf develop.tar.xaf
$ ./revng-public-demo/root/lib64/llvm/llvm/bin/clang --version
clang version 16.0.1
