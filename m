Received: from rev.ng (rev.ng [94.130.142.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC23E63B1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.130.142.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452331; cv=none; b=MHLM6aVsr0QZ2Ee/iU4jDtHFaz7CjtU87/j8Du0M0+UJySZIHvMwhrijqzX+kOAxCnB2PA03NgoN0c09LVc9yU3rds9vNg2nNgzDNFffOSPqTascrYRxC9W5Hzwjnro0e37oz4lmHuoej6v/sQVWRnPO9HxHKEA4w8SdaXowzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452331; c=relaxed/simple;
	bh=qpliqiKuvEv+vF0M/OFzrGJTZm6oBflZ5YmeE0dPaj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBKH7ECXfOjWEis+dhWSXLYn7o53kdwPg92h0Edcvg2tGJlso4BhTUgMwduvDtxRRloQSrP5NaEGu28uqcjc6ckziO4yiZWURbWWpSqmY333/7shI4YCVKx47H1FV3i1Lx1TbLeNy1aVPuXmXuI+KJc7oDAX6GR1ASano7n8tyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rev.ng; spf=pass smtp.mailfrom=rev.ng; dkim=pass (1024-bit key) header.d=rev.ng header.i=@rev.ng header.b=W59GTqzz; arc=none smtp.client-ip=94.130.142.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rev.ng
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rev.ng
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rev.ng header.i=@rev.ng header.b="W59GTqzz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
	s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
	List-Help; bh=L54GOWdjqRndf1N0Bl3JKPypFdhuh4dOD9kZrETKjt0=; b=W59GTqzz28XGIfy
	MgWx2m5J08iQh2gCyOqieNW/0EwHDytQKkSAAl/wKbD1Y3PD8KMO8aVJd04cLL531CRhIouIUz2cQ
	vf3sQspzC7+QNsYSFQ9VPoZVxfFd4tf4ltvruZ0zH8MQTZC/pMjcfRSvwLDW7ZrWkQHJnUhMeaDo0
	ks=;
Date: Fri, 31 Jul 2026 00:46:04 +0200
From: Alessandro Di Federico <ale@rev.ng>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, david.laight.linux@gmail.com,
 jack@suse.cz, jannh@google.com, kees@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mail@johnericson.me,
 shuah@kernel.org, viro@zeniv.linux.org.uk, Gemini <assistant@google.com>
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
Message-ID: <20260731004604.53c66732@spawn>
In-Reply-To: <20260722-raser-leselust-konsolidieren-05f8e36a0782@brauner>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
 <20260722011217.45e79a08@spawn>
 <20260722-raser-leselust-konsolidieren-05f8e36a0782@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 15:33:40 +0200
Christian Brauner <brauner@kernel.org> wrote:

> I think this could even just be part of systemd. You ship the distro
> with a file for that in /etc/binfmt.d/ and systemd loads that bpf
> program for PT_INTERP_WITH_ORIGIN.

One could delegate the feature to user space, but that makes it much
harder to get adopted in a uniform way.

Will systemd, Android [1] and OpenWrt implement this? In the same way?
If so, at that point it could have just been a feature of the Linux ELF
extension. 

Of course the Android people could disable the feature even if it's
in the kernel, but if the convention is established by the kernel,
there's really no reason to deviate from it in the way it's implemented.

The whole point of the portability thing is to reduce the assumptions
you make about the target system. Ideally, you just want to use
features widely available in kernels in the wild.

But from what I understand from another thread, your intention is to
use userspace as testbench, correct?

> This is policy that the admin should decide

Agreed, but the admin is probably satisfied with enabling/disabling,
not deciding whether the program header type is `PT_INTERP_WITH_ORIGIN`
or `PT_ORIGIN_ENABLED_INTERP`. Same for the distro maintainers.

> not an arbitrary extension into elf core.

I think that, in order for this to be useful, it needs to be a ELF
feature, not something the admin/distro maintainer puts together in
eBPF.

Then, from a security perspective, AFAIU, implementing this in
eBPF does not solve the problems that have been discussed.

For instance, `selftests/exec: add binfmt_misc bpf-backed handler test`
does string manipulation (no `openat`).

I understand that's just an example and it's not the same as committing
to a new ABI feature, but still.

Overall, I feel like the current proposal pushes back on having a new
ELF feature for security reasons, but then delegates to distro
maintainers who want to use the feature to take those risks. But also,
distro maintainers don't really need this feature because they can just
write /nix.

I love binfmt_misc enabling you to do ./foreign-architecture-binary or
./notepad.exe and spawn qemu/wine (usually with your friendly sysadmin
approval) and extra flexibility in that area with eBPF is super cool.
However if we are thinking about portability, this make sense only if
it's a default-enabled ELF feature (implemented in eBPF or not).

I'd be happy to try to work on the example eBPF program using openat,
address the various security concerns that have been mentioned until it
looks right and then it could be loaded by default, but with an option
to disable it. But I'm not sure whether there's such a thing as "default
loaded eBPF program".

Alternatively, I could extend the ELF core as a parallel feature of
the eBPF-based mechanism, reviving some patches from previous
iterations.

What do you think?

-- 
Alessandro Di Federico
rev.ng Labs

[1] There's a flavor of nix for Android (using proot) which would
benefit from this:

    https://github.com/nix-community/nix-on-droid-app
