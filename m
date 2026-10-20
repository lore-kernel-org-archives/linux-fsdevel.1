Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480329;
	b=seKexBeDOVX7ktvhPLlVlFlhCofj2eJ/s1QnTjpaGp/sWezigV6DZHuErZ8lcjPdrNiw
	 caJo5LIqH9G2nZhw0ylgJUGLeZ4wQAXFGqFsio0nfsSBjeTwMkje85R8kedcfdzS+UY3/
	 LHna2diEeomnAummyxt7M1+UmNPyLyZItWpTVRsnvc41FvtCjtQITAN+O0iePIbVVlsuc
	 JAuHyacxu9jBTaeseamwvddCd6T6ZiaL6KyP2dEfbayvFmvufToLnIIaO0LbJ9NP3Swom
	 d9WZFHOwxHOPtTymvYcc8fA6ROCCcNttbQYNjCfO976r3Tsbq2tuzc4bBHz/Bf/dxkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480329;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=/8uu0IyLMSvrL5ee1PcWGBaEVz6GLDWn4iNzOTbyK84=;
	b=TqFMSrGnRF992/JbiQat4y8tuqgJ+HSIBqi8k4XDj5u/hkJ2b6OJHqTwXdxH4EOlzzIy
	 WSl1kZmo7Rn01TKlK2nxVQDVZ5RIZwrj5qUtxQF0hk4Z33dC0qAynC8zlmR4JFvuavoWD
	 MzzQP0Qardhh4DQgIWP0/lw7qOZXgY3xAX+ipiRIdR9Ah3aRtNhODhRyS4wSiFRrbM2NY
	 avUYc7EiYbD1bHo5d6xgzxpYt5g1MXw9PWyF71TwcWcqWAVo7Gm0KJILxdNenAfBy6We6
	 7mbxAdm/B+xAKbhuD0+K0cF+Jwxqn9dU0yUEM6yJ3XNhur2zZyODeEQpGZnWTuP+eyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MB8XKIKJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110E606A334;
	Tue, 20 Oct 2026 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MB8XKIKJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFC41F000C6;
	Tue, 20 Oct 2026 07:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480329;
	bh=/8uu0IyLMSvrL5ee1PcWGBaEVz6GLDWn4iNzOTbyK84=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MB8XKIKJr6765L72yFcdh3hNoiMtP5yoMjR50d+EywoNQLM4Xe6R4wd/WYCYajNUR
	 qBuZqj3w0cZn2il/mRbvvnq9j5cvSHMllXnFB4z6ytJmRL4MffI9wobsNC+eTBzDXb
	 kBABFgpdTmSt3xSSkTcrNvgZxrpVY2OhnFlnJKd5J5nf0JgfDU+PmAnSO+8cSCu97q
	 nlR1aNY87egfKKDaCtuBm4TueiAf97auS+dbmArO+gH9FGSUTdmNBuUtIFUcgDlg94
	 KHSAEaRJURQLHXC2dgfjT91e686xLt3wBdMXWVbaLT166NGRahS6wItxCgWQdfAToB
	 ncHZBqGU1gllA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7744E3924FD0;
	Tue, 20 Oct 2026 07:12:09 +0000 (UTC)
Subject: Re: [GIT PULL 05/19 for v7.4] vfs bh
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.bh-97cf6f68db3d@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.bh-97cf6f68db3d@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.bh-97cf6f68db3d@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.bh
X-PR-Tracked-Commit-Id: 7c5bb35718a6ecc2001e2f8f6abc068ab926b583
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9a3eae9453b7547e4ab27df53a2ee8c7eb90c01
Message-Id: <179248032799.3535438.11012094458142386866.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:07 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:16:30 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.bh

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9a3eae9453b7547e4ab27df53a2ee8c7eb90c01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
