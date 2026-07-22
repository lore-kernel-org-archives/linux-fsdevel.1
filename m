Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB934C806;
	Wed, 22 Jul 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727228; cv=none; b=oP1kZoGh+PEekrYorEycPWOiHrUDS57BYXovBNbYrsBZD0j5f3tcFlC3xOl4/beRjvJjTEbWx7yx8638GO0sIYX1iT0FMpsLdRtG8Pd3RIJP7gzFbWeN98JkkXQ394PgZg8sHS3f2e1oD7TXuOjN0YyZ1OALzrrwVGXT/cLymHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727228; c=relaxed/simple;
	bh=OSnqiWFGrRlyva5O8ZuwHNaFEVyx2w2j82qJYYjirvU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=GTy3mdP/7wA9GaBJnroQeE1U2sCJbzJW+S78aFquX6CmMNNDbj9fvv8Qmj4LCTSDNLgsFocE3Q/az8z8KRIQMFaGm/IXd9Vy8aBmAX65j+kMU3zarjP/opwFwm/ptwpn5cKqP11bF+XM7U+DIkcKdH5NIv3UlVHCxHHDwvrGOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyFz6jKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyFz6jKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D941F00A3E;
	Wed, 22 Jul 2026 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784727226;
	bh=sTK1rlUFrmHBMlWiK/OncXT4tl+4gAfiT7OvDNlVqXw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JyFz6jKi/8sLexgerCnnlLz0zV0n78iaKObh9MK6Uez5siWAAn2pIsRabjenQjuGb
	 d7stkffV1HGriuKQgVAjmdUDDEhbwR3uVkMZps+evmzNs71uAyZA+09LNqi2Kw40lL
	 3BqME8yVYHZbg8sbIuWx0GDY/czPUFkgIKBHSiq42vB736jU89LBrrO8lrwqBt1ULP
	 x3SknDCyG8gEsPpxhCneyaEif2oC5wK3lJgYZOdwmCjzI4Xbu25gMVsjuB77J1fuqN
	 SfiB7gZPAxeQSiBlJ1XLNrC+Ny42d8scGr961A20CWkbfGpN+AFox/Vp9Unwk3U2Ed
	 N4LbdpLn+SzCQ==
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
In-Reply-To: <20260722011217.45e79a08@spawn>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
 <20260722011217.45e79a08@spawn>
Date: Wed, 22 Jul 2026 15:33:40 +0200
Message-Id: <20260722-raser-leselust-konsolidieren-05f8e36a0782@brauner>
X-Mailer: b4 0.16-dev-2f6f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OSnqiWFGrRlyva5O8ZuwHNaFEVyx2w2j82qJYYjirvU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlHNt2svu4BouLxTaj4woqR5YtP+x/Y9XsZte+1I793
 lfvaBrs6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI/qOMDL8fnliS92lTMp+5
 H1+LxmTXRVbWl47laBgleWVXPnXb7cfI8NfsicCsy2+cV7rJTjCY/P9NmXDCkTWzv8X+0Lsx+Up
 FBysA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> This patch could in theory solve our problems, except for the "no root"

We're not really enabling $ORIGIN in core elf unconditionally with weird
escape hatches to make it fit for a subset of binaries.

> > In any case, I think it wouldn't be crazy to allow registering
> > "default" handlers that appear in all binfmt_misc instances if needed
> > so containers with separate binfmt_misc always have the bpf program
> > available. [...]
> 
> Maybe we can have a "default eBPF program" loaded for
> `PT_INTERP_WITH_ORIGIN`?

I think this could even just be part of systemd. You ship the distro
with a file for that in /etc/binfmt.d/ and systemd loads that bpf
program for PT_INTERP_WITH_ORIGIN. Then you're good to go for all your
binaries with the 'L' option my other patch series adds.

This is policy that the admin should decide, not an arbitrary extension
into elf core.

