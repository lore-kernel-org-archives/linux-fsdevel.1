Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452253;
	b=kGTmYWs13AaiF97r0xTfYT+sVQtsuygSM7duhtKFmEIne/adFST2VT99N2kb51OLkpaq
	 zVdAXJmEvwJI3UNCATrZd60oaHCSgg1A6pPPMvvmBji8Pmq4/zI/fYpKDT7gxCAa0Xobc
	 GIhhQrk86TiX24uXGwLzPzH/xfuQjNfuyLDW22eZfgfU4/Y7Q7zdI5lanjbwT3p6aVMmk
	 yQHg97PUSyZGBHaxb6tmdmhV+9bI3gs53LzgNNGO2fSrKQibq19zWHiuc/Mktbkkpog15
	 A+xPj5rHVFBJUnzAJoAOHzjJa9ee3LUBeF7xcD+8pU0wJ9gGkCi/6U2TGagcTgW7m0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452253;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=Tjlztv0EC1bbXeH39wbu9VnhaEmZEWTL4nvg/QRTz6E=;
	b=t1W7hyYe1rj0YaAT5soSIL9u93axMYH5JlV7hpbrRzmZGkspEvBnl02viAxdniB1p01K
	 zDsndZr9xXhp5vwnL3C50rKOC3+iyMs83WBeXfjkLYWFAFruSK5IWQ9O/iqKFTG57zxla
	 cTLzDQYIniFZPD7xCUjhHvYlMNatF7/cOBscgAngt/Gc8OWfFL7h++RcBPtOvbb0Mpi11
	 TMAf7zu5w6uVosEwZLQXrD7ZP+g4xxqaZ2A9uGAU52IBuvz2HydamGwIuq/d/NIRlPHiB
	 shzyYHgE2DQxO3FLOyYdLhUVhMmJNkdu/lK/0uuHgjHKH3AxpN2Uu11AfN5RN763o1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaXKtnTR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186B606A31C;
	Thu, 12 Nov 2026 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaXKtnTR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C8B1F00A05;
	Thu, 12 Nov 2026 02:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452252;
	bh=Tjlztv0EC1bbXeH39wbu9VnhaEmZEWTL4nvg/QRTz6E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=QaXKtnTRcLnXpWpUJkJJQIUAXbb4edhcIBMzrHjZ6SL6ubC2k2Xwpp6DFcGDvOQKk
	 8SjU4BRkz5Kb2HQxFxY7kFhEWWB6tY0rcysS6kKG+naCzxwmvy0/MrAElmbHCuS5yI
	 b/G7e/G9ujGUFhospPS2geX0KfrV8TxrdWwvOr3WIi8I5UIxCjhxyVwz+6yihL8kaB
	 3rQDuOrujXFOzlcbvyW7Q7b7NemXpHNsUB0cyyJNBzEBzrX4hUeYVNauE9DeWqZJAA
	 xq7OcRveMQUKcMVe/tb+5YQJG0jqOUfJJX4nkBoezzMNJpjmM8WFGVwXihKkfbT9fU
	 8sFflhZZQ/2sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D831B38003B3;
	Thu, 12 Nov 2026 02:57:32 +0000 (UTC)
Subject: Re: [GIT PULL for v7.4] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261111-vfs-7.4-rc3.fixes.2-6660a456a8e2@brauner>
References: <20261111-vfs-7.4-rc3.fixes.2-6660a456a8e2@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261111-vfs-7.4-rc3.fixes.2-6660a456a8e2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc3.fixes.2
X-PR-Tracked-Commit-Id: 2cca8a6f6ae690755862f5b633125119dcf6bd0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d66f26fefacebfeed15de31c1123451a17ff119
Message-Id: <179445225150.1792269.2578072932219169434.pr-tracker-bot@kernel.org>
Date: Thu, 12 Nov 2026 02:57:31 +0000
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

The pull request you sent on Wed, 11 Nov 2026 23:36:23 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc3.fixes.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d66f26fefacebfeed15de31c1123451a17ff119

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
