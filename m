Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480340;
	b=yqhA81dow23vYU2bB4x6BwYzFTT+QYTf/2uy/z5qLX/1EFyLLyf5PCfx88qHdbAoFSU1
	 HucUry3FikwW6G2pHzDpMAa0k5Pp81JjlFzHxdZ2gG9EvoHm6JZfq2usK1m6vSXFH36DQ
	 EPR/ZtP0QlvXgj6WsR5Vdgz5VgLbNumLjW4Oyb2ep8tOwLoUUbE9sF2TSli6sGJAmw2EQ
	 9KQT371MZ/JSZERM7nkF2HoWrkoRckXBbm76A0g9s7V3SHxO79QxVX/+v0YFTxPaF3JZv
	 IhX4TTbZ3SF+0OgHO+ehdrRsZIo7qHsvQXbsVd2ylnXw/yIJFSprcV91AoMOECiOa8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480340;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=Iy3jl/Dt6HbO+wTmjy1+RQ1vBbfdcGMdumhWxmkAcXE=;
	b=SiEIF/JBGAyAu53arsSIOlK4OYC2Q2PWZcPdrcU+DjAqu7XdvK3K+/zXWmyRe5TsLCFK
	 LDi7FJ3l7wfI8FxxL2vFLiqX3tK0f3f7CexVTbUcc3JkIqaE4iSb6jRtIC+zfD0zDfz4C
	 A8YhnoxgdoeOPiZbWTof85Z/hyOxKZuxC5MZj2UivQvGUxI5PBNBtoojaCuAVyRb7pcxq
	 ckr5ERDUzkRqAkwqwj5zAdCBZXbOfGizxVqXdCiZb4Ue+O3anyhiXUiAlz/WfUxJ1ZHQV
	 5EzAfMFOPWEi6zTZalRbJOhQHfJ0vXhPrp9evroHc42096sG2Vu8mVtjb6R7M1uI6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCCogmAO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987260A261F;
	Tue, 20 Oct 2026 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCCogmAO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440B91F000D3;
	Tue, 20 Oct 2026 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480339;
	bh=Iy3jl/Dt6HbO+wTmjy1+RQ1vBbfdcGMdumhWxmkAcXE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=CCCogmAOD6U5O9eCqqGCIQ9T29QNKI/OD45MTygxKlm4YZN0JUqDrxxBmM6nQNevM
	 oHq9dapWPx4MpfBFleBx15lmOcSgyJjQ/NmN5DtabSNI2japb4JatRBrkv14XUCYAc
	 quf9Fdl0A1e9vHoCRtuAnAnMQhm16ET3LWCZPPZqIDffm45VOM8ukfJwirDi77nEiD
	 WlB1RrVMA9CHe/cyX08Y5grk3T05xvuZKsIjnSTCACarvcZwV74Mqf21ehhNXwSxTA
	 ZOzM85+x6VYlKqoP4j13aRkAPIncdxmN/sWI4ko+Zgxh6efZsDJhH+uMCqeEMVACsa
	 CqS/bybpo/jWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2A73924FD0;
	Tue, 20 Oct 2026 07:12:19 +0000 (UTC)
Subject: Re: [GIT PULL 11/19 for v7.4] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.iomap-a7ba039d4f24@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.iomap-a7ba039d4f24@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.iomap-a7ba039d4f24@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.iomap
X-PR-Tracked-Commit-Id: a0f61a936b36a340998825cb945e5fdf03468988
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27dd2772e6c62cf0627d97fe03950710df334cf4
Message-Id: <179248033774.3535438.11607263821099717459.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:17 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 16 Oct 2026 12:21:33 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27dd2772e6c62cf0627d97fe03950710df334cf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
