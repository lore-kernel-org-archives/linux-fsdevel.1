Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A85285CAD;
	Tue,  7 Jul 2026 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453517; cv=none; b=LnSer0lr5R1kT9VD5V2Cw5DLBQZC69TBi+5PUmhNitDW41187CSPtpTFWK0D0dfEmxf0+52jotshgsVbYtcZt1ZTl9+42eYs5obZElSsKZATQUASCLySxmovMAri48g9fQhlKo2jHp2E+7b+1aSbICcUIWsCK9K07Un7LLea1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453517; c=relaxed/simple;
	bh=f2/r3OFjkGnjq1xSExRYwOyB6jTnXmNliLm2qYHSgNE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=kOYrbkzBVamKJ2vQqdlOykj+/2SbXA4C0CFaIg9B2Jk0JlRNJM0AOMDu0NiL3AnCPquNeoSEW8sa5c4seEWoUtS10t/wR9h1ayYbaG0jf+zSSgKT/duUbCNafQFKjYFDWSFM6+uM0cyZ/c/Nge6YfEqxWUB9OopsD+mjBN5VcVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9fGiKWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9fGiKWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D5F1F00ACF;
	Tue,  7 Jul 2026 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783453516;
	bh=kjD0Ay/RGuMmXAFryRcqf7UQBWFaDLVErpeUMjY74WA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=C9fGiKWO0UgmpcjlJ7ZsxUYSRNx5bcZRHSCU4OYpv2OHf04ceEkGc0L2y4DzuBzPl
	 cj21X37R8jDBsAcUeHld/lyxRSbm4VeG9TnW3Df8yEX6EvljdlCAKaBG0UY8CF7HHW
	 tO3sLo1G6ZGg7lvY3IUaORGpGEEUqXFpOJs1TYjWS4XE5udFpbLuhoWy4e27stM5sk
	 mcLAPWGpSqFh3Qs+epro5bMDU1dB4+dHDTxGK0WCI/slUh+rSUGah3kwLkVMGEyF7q
	 Sj5tR0NJGmyLFG5dEHl80vGnCOuAEkz6sEPvvME9+PCqCEhQZsrMldGGXDMjkbpw6b
	 ysl/I9nfh5HrA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, david.laight.linux@gmail.com, 
 jack@suse.cz, jannh@google.com, kees@kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mail@johnericson.me, 
 shuah@kernel.org, viro@zeniv.linux.org.uk, Gemini <assistant@google.com>
In-Reply-To: <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
Date: Tue, 07 Jul 2026 21:45:11 +0200
Message-Id: <20260707-wortreich-kanal-zensor-9386ef4f38f7@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f2/r3OFjkGnjq1xSExRYwOyB6jTnXmNliLm2qYHSgNE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5hnvoehTuXbSuetvytccYNN697Vv6qW3S0et32kxl1
 nvYeG5u7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiILiPDf1eJj1LiHUWydT77
 bfUe1se7vV3BZRdtUePYYh9b+XZrC8MffpNN6q4OHl5f9zrPDKlJOua4eXfTdlshPfWdgqaba12
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-07 13:34 +0200, Christian Brauner wrote:
> On 2026-07-06 09:47:53-07:00, Farid Zakaria wrote:
> > On Mon, Jul 6, 2026 at 9:01 AM Christian Brauner <brauner@kernel.org> wrote:
> > 
> > > Ignoring the blatant bpf abuse here I think this is quite workable. So
> > > this can be turned into an actual design and patch imho...
> > 
> > Glad to see you think this proposal is in the right direction.
> > Just for my edification, when you say "balatant bpf abuse", you mean
> > how it abuses the socket bpf type?
> > If so, do you have any guidance on a new type or should I just take a
> > stab at it.

I drafted a POC for you that should be closer to how this should look
like with the bpf people in Cc. I'll let you lead from now on. I just
wanted to help you out and illustrate a more viable direction. Might be
that the bpf people want it done differentely. Let's see.

