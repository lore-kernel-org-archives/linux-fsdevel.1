Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480331;
	b=T6ru8+6eQYtpJukLLuGj34Y76o3AOw6YqZo3gESNXTUBSV3MK89Nk3SjHLMIPIwawIZh
	 VCqLpDWkFWeiqdI8VNG2UgkOVnwZArhd286SyBRsJmIPBU3IRAsQz0sLPtY20VtlHwWrg
	 WUZzwborRTxHH8M7MGKByQkeCk17hw5j3w7py1lN8e0zOY9gX5CkmmaYpbviFDLx16Kbd
	 xVzhEj36ZP5gGnDFucnyS16Xy+o4bk5outIrYyKgUcHCDUlROnVW/+2p9BzJZjpIis+8O
	 4Jixm8UI9L866x7jM3eCRmhuw+GZKVPfRq+WHBC7yK0gy0dEhZ7pZUMFa1DAbQ0/nJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480331;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=IwSYLuH82R0HHNdP+HczfBLBqUkggexa2UHDE4+68ZI=;
	b=S2u669pBIx7KGQSH4Kj+3HVOK7wWe1ZF45O4cCpbBCzhT0SEBVgDrT+AbEcOi/SkXBmg
	 bq3CDPbh2JqzAAzpflKUivJV64xEfUazlm0xJ9mpc4uxt8ycZICJzxFXXvW5bgkyMtcvV
	 GDG7xRcnaQ/gWIVfqKbCthiQkCCBLGSo9T0UYEcpr0yMtePxJAiBeiV69URZb2yEkl3FH
	 4MuZGA1fSPdzGayCCxQVaI8TMKj2CUKMwfKRLBlItBnIUmF8LBhcyS+TYWHBl3YFrQTby
	 uP8Xw6KQ0DhAXrBXAa9MTKKJHKl1VkGrlqSPoJA2kDLa4PA7kmwTIYVDLvjZW6DxI0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2hESHCA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C160A2605;
	Tue, 20 Oct 2026 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2hESHCA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF251F000CE;
	Tue, 20 Oct 2026 07:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480331;
	bh=IwSYLuH82R0HHNdP+HczfBLBqUkggexa2UHDE4+68ZI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=T2hESHCA7HgUth26SXU8w91Hs8WApFYAHXIk8api5K5ByfOCME4btoFooIUf8PzDb
	 S4TRbttDX7XEMpbpBBBaG4ASbnniZwaEWpuGZU5t8hQija3Nrkk2PVN9iYM7vFcVUX
	 53jZjGdhwMZbUkH7Kucin9U0bS81ndPzLWYDYp5zakFYtvM8FvMkDaIpgxdV8VdSt/
	 JTk2iXt2IqO7s67CX2LE+WWcPLBDbWMLvGWevSGmtmKrpbW9zLoYn/QaUa6gI8IxGQ
	 pSLOSnbxpY+a1SXRLG3ElFxc5m0LdA68aWWOXIK3j9HwQLYOKtZ9FGkdUylUztsrvq
	 BIhvIITHq3sGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20EF23924FD0;
	Tue, 20 Oct 2026 07:12:11 +0000 (UTC)
Subject: Re: [GIT PULL 06/19 for v7.4] vfs binfmt
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.binfmt-12f955685a99@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.binfmt-12f955685a99@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.binfmt-12f955685a99@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.binfmt
X-PR-Tracked-Commit-Id: 87b76786cc04c8137133a360088d94ab2ed592ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 550a7e28d801d35dd23aa2cdd30b7a59e193e080
Message-Id: <179248032975.3535438.2502460989856070922.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:09 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:16:58 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.binfmt

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/550a7e28d801d35dd23aa2cdd30b7a59e193e080

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
