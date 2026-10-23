Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785480;
	b=SR8rpcWjcpkbSCjXhOU8bGg+mQrToGOcXmXkBol7aQshSoy2I+PjHl6oyUVchPaXHMYE
	 E3Kju7Hhn+B3QcpD+XQsDr4vp87nZR4bErQQZ0kuwkVel1W1Diw3cWbxtvN57Rll+xIBG
	 l7DM/qGy+W7f4ylhnW8m7L5Ei+g2HD/T9mOrwJjooXrDNoQVsQycbT5u+1FGszn6qMrLm
	 xwDK/Wl7UU74gD9bzLLjWF9xtCy6vPr2HyemKA4z7BibZMN4SZVWYAhy8SIrCqKtJ1v0+
	 TbqQgPiHdcgLaIDnhK6fFkjxP/Z7ynU/4brs53JEAMOU2hyG3l1I/B2M9BtCEGfyXpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785480;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=nPSXnmxSLkpUWhhq/6gJZ3Ep4i/8tECDFnswnMrQL6o=;
	b=UuC5Xiu7HcGlr4NpgvGb7in6I88EbpEEGwOuPUnYGbhSv01uR/z+ZTvgEnIdzHK5pkYa
	 Pfiy9lnzR80IP5TT3IV0Ny921KXmWYA5ikBwZS2DRdQ6hFKmbzfrAoa/LPZelUaL4apSj
	 +YQ2UUDs8NH6WgkujCaTHse8mExW4Hbbm9dR9/GVafRjNEd5mop1xBXgtTtiIgqq6O52+
	 cIKWIhTyf7VO31TeiGDV+W6f2tnOBvUiMchoSpOzki7b2z/ciF1sVeeKu6HSb5wT/v5nl
	 VNUHEP+1zNe6+Ev0Nk1NAw0lwjnwe7mTp9d2SabYioUUWYUbsn2CS/ImrKAKjJYXVVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aK6kgUtS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B69606A91C;
	Fri, 23 Oct 2026 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aK6kgUtS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDCE1F031E0;
	Fri, 23 Oct 2026 19:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785479;
	bh=nPSXnmxSLkpUWhhq/6gJZ3Ep4i/8tECDFnswnMrQL6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=aK6kgUtSXkNr0vL9U5fPBfyen3dL/XWE3X+zKsB8IkDQUgu01Ekm0DzgEYWl2cgtH
	 ZOcyMG8VVa/IERQL9kofANwc3Z2cvbf6YZEWaPz68jJ0MD5x3HTntohslyENUN0UTN
	 eZonADpMmfgu3Jrjz0CItVSDgbHSNprDpFdVVugi2Un3ID62msR47C5mpxBLN6+9Gr
	 SdyVHZK/JANCCmbbcg8r76wH2VDbx0Ogg5u0+CXFNlTGN9WcZfREIyibetGMXJdDJp
	 c4DbqmjgVCWe06D34toJ+tY2orrTiI8EGzd1eV00cyfelIWyrztsyJT4FrBMGvGCyM
	 6rXvWpQB3iwLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5F6391B153;
	Fri, 23 Oct 2026 19:57:59 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <atdn5xA9AZHAWNsM@hobbes>
References: <atdn5xA9AZHAWNsM@hobbes>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <atdn5xA9AZHAWNsM@hobbes>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-7.04-rc1
X-PR-Tracked-Commit-Id: 7b08e5851884e4ad207a6401b1dcffdb03d43c28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 845f394e462fb1bd67b9779c467be478631a4daf
Message-Id: <179278547847.1241373.5191456898931414162.pr-tracker-bot@kernel.org>
Date: Fri, 23 Oct 2026 19:57:58 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Bradley Morgan <brads@mainlining.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Yibo Tan <lhfff@tju.edu.cn>, Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Tue, 20 Oct 2026 15:08:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-7.04-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/845f394e462fb1bd67b9779c467be478631a4daf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
