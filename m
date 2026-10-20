Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480343;
	b=HZnBiei8mJ6i9NviZeMsDjCEu0chcvwC82osOaVJzos8ZYK6LCyDIyeV3dJjysORlsaJ
	 YrvIFAZLm9G4fQzP1tam7Fg+TBaJmRQANh4RoeMNtBcx0St5lZ2s/p8shbii7CkKwooIL
	 03IOwovCQYZ2Q1MwxPzdmtO3rGpW7WZNJEQVhZ1ZTAWFMkjr6eUKbarmKqhtbZAymJD1u
	 /hPKfyd1h9+FWMqJP7/LkHVrT2Dak+1xhcnLHcze7VxWWFqPLgstgf1cB8xvRC3miOVuz
	 2NWeWOQBMuZWKcFeEH/INK5ATHIl1LMIzYoZzr9V69pTi11GeL6ukRbKJ47X9kqqVzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480343;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=UcFZgw+5y9b65VyO8MQ0pWgTsVuOL9k4C/DcUG8fuV0=;
	b=NLKBwGinuaddq53648SAgi/1hCltTmuzkjR0Ta6GCYlTklHZWciEmpbwK+S4FTESqNTG
	 vec8cvBtJtx2UF++MvU2cd3aXZgBe9QIvLEpB/56pEt8Gi3hozVk9bnq15tv0+srnlysO
	 liSUoVYV7b1F1a6qMQGV4bo1O2bORUty0VPWZuaOkD8P7IYFqbMhu9HF87vlfmodCYpM3
	 EGjEOMy/L8Tucom83qOq32etuIP0UPGObJ56RhfRIrFeiBdgkvgV/RGB1vRGO4PnPEFaH
	 qsOFxxb/6gacgnGcfltXZmrwYKQK+sY1CD5DN9AlbLSgxSua2w30eVtXlQE3lZs8ELA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePjI7bFu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD1606A338;
	Tue, 20 Oct 2026 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePjI7bFu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFF21F000C8;
	Tue, 20 Oct 2026 07:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480342;
	bh=UcFZgw+5y9b65VyO8MQ0pWgTsVuOL9k4C/DcUG8fuV0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ePjI7bFuAa9EO343mPiXhJu//8ATuTVuj+7nHLgJ8Urh+amldWCbwKUGCoxrLZEJJ
	 PCsAUtpHa6Gwe13RuaVxiYvSQeVWIfCpq11dvCgqXpo+XigVvU3LMgNsjo4PJIFIYE
	 20toLAo9vSfYr4k0B9P3hx5bG0769vqNDMJfJdkst5JtDMTao25Jh0jNvu6SRxQufY
	 XL6Pqrik3/TakB0xSAQ1s/jNemdAswvYVmPhix/lbMzaTqUQYfnrtm+M/Q28EIHjBc
	 hjOU4Jg0KRdxxjxQhTRsh9lE7Zo0OCA866k+saV25qlQziau0bSYjWZz3UBz4TNAEg
	 7uu8URk8rAULw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44AB3924FD0;
	Tue, 20 Oct 2026 07:12:22 +0000 (UTC)
Subject: Re: [GIT PULL 13/19 for v7.4] vfs lookup
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.lookup-89a07517ed9e@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.lookup-89a07517ed9e@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.lookup-89a07517ed9e@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.lookup
X-PR-Tracked-Commit-Id: 31fbbc8bb1ca256f3d27d1172ad3493d46d29c73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96a377ba007a6a1ee9fa9f0ba48812fe9284f0ce
Message-Id: <179248034124.3535438.11978742180487952194.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:21 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:22:42 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.lookup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96a377ba007a6a1ee9fa9f0ba48812fe9284f0ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
