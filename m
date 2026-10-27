Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129386;
	b=v+nwMojKsL1jvm+nA2yYvm/bFluZLLMSHoEDvM5/Pyzomod85iH0JH8CpUcw9vEcFvs7
	 fJX54JzZPmYPJhaVY5Gd+VhoHdDet2CPakfXn+g+T4GLvH/Ogv3g1xKX8r8EaHjbYICFT
	 5hE7BBm3QFpqlogBQuqeXvN2ZwgTaK8QfxS2yZk54AVaz+8OP25ir38A6vcdlg1VvdhOT
	 d7w5pHBC8NcYpuJ77ip/6g/atNFWTAoHcNerbATrHwqXJa2+PElhmqxX9InY3J+ppw6MX
	 VCLRJVq7mLN4uYOW2Eh/a52gZDqdmVV1gs+xkfYWHHfPkkCdNkhVtk6XpI3MSA9rWwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129386;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=wwOhttfBcGqYletqRT3Losv9vUrjfvecrLZAFPgMjwc=;
	b=bGoN0M2YHs3D2jdkicc6G0fl8yjBf4FL3U5WaLwWL5McSZFwwMXuUIglb2EKEAjANQeC
	 9RbPfKoEEjmdJUtbR7j0vLFDc8mkpt5dUIEfFSVmMweGSvs9JAsYe++8+e71VFVnq5+Mn
	 ER6O0SazBiV5IWwMGmaVr4z49s/y5br+dsv8YREgXQHvcvLWQ0i4KQ48DxVCD3hTty2OY
	 EslAwz5nwWaUCplb63wSwcRrlvXp6qWOhJLSLMKMuikFFEoivrJo4v4ZMfRfDHhML4oZt
	 gExQ07JuAlC7mXFHt59EeWnHUxKl96xZ1gxkue1k3DpNGnHG/ueqkXNxCfNynR9vbHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c9NoXCf/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEB606A31A;
	Tue, 27 Oct 2026 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9NoXCf/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313A31F01825;
	Tue, 27 Oct 2026 19:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793129386;
	bh=wwOhttfBcGqYletqRT3Losv9vUrjfvecrLZAFPgMjwc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=c9NoXCf/joDyUhG2BkIxRZWhaZvKbJXTyClEyaG4jrp2cOrOZfbNWfXowgXZhnTb4
	 +Bibs6wa9YFWPa249NuqbXdODqrb/U+UyHPLzUhhmCwsR1Vg9oEtZsqwoolY4eKRLo
	 mjQk0myF9iEsQcaGS7EUb+3Q6knVNB2m/CHQGqcm/1MWVJPjqw4ufP00OH8+w7cytW
	 n6f0StXa3K6yvgb9U7hmT0AeCHKH4QDBSfHBdJB8F5LoxRQFFXE21RMzxqowapgJ6l
	 NgH3u8OTzXDlUOSpVziV9N/hWSMHBAVpX6deYr+oa2S8wOcldssxrkrRI6VZhRryYq
	 incVg6XZgcvHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2639F3AA9F47;
	Tue, 27 Oct 2026 19:29:46 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpeguS78Y_ZB=fNbYqFPcpo_mznJBR=5KTqifMzCm7c3O+8g@mail.gmail.com>
References: <CAJfpeguS78Y_ZB=fNbYqFPcpo_mznJBR=5KTqifMzCm7c3O+8g@mail.gmail.com>
X-PR-Tracked-List-Id: <fuse-devel.lists.linux.dev>
X-PR-Tracked-Message-Id: <CAJfpeguS78Y_ZB=fNbYqFPcpo_mznJBR=5KTqifMzCm7c3O+8g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-7.4
X-PR-Tracked-Commit-Id: bf56861216337c839dce3c8bb1c4be96d30ca716
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03973f7f3556b769a3dd5104f166614d446351c9
Message-Id: <179312938492.283091.12128641833973288245.pr-tracker-bot@kernel.org>
Date: Tue, 27 Oct 2026 19:29:44 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, fuse-devel <fuse-devel@lists.linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 26 Oct 2026 22:20:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03973f7f3556b769a3dd5104f166614d446351c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
