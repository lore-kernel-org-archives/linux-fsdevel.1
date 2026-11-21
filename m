Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795228650;
	b=HUS3zGHKE52P5/NjO18oIfvwjO5nJAvq2PVjU6rDBnBSWvKAZDlawkwn2v7KFmeqkQR8
	 J5fnTjeBr40mbtj6MFD8405/Zf6SpB3slN4jwysapmKqeSPn9bhWrcfs5Zy6QN99VhGDj
	 Kr7LezrbAXtIa7+pZOncIyFBK8gJpKOYJUVeqjrw0ujOIkPB7X0HRflIs38kE53mBH9IC
	 HjmpMXJZXQyN5Kuyv03wc6/8ELbRTscbj0BxRJlZmwNHghkVnPKnTpAsrcdLzP4h8sGhh
	 jQjeHEJ0dtVwVp9IwMxids4/H4jIlbAOSyXiPf2VHTcOXnW2gnfRAuugHxNook+B0ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795228650;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=AoaUaprWdoak7d8mXSrvCYcPq83J6skZ+zUYG4iH3RA=;
	b=L0i2MZfx1pEP62bVpax+bUeO0N8gxW8XUAKGVO6IweGrIWnCDP8H7r4SCNih1XVY9tk9
	 VtlxQnO3VWHdHIEHvm5WAv5tyM+4LriDSv+gXdWkgSPpRwjXSHWaDO0FXd/UEu5v2M7Lj
	 9nrp0iW3j84ytUa0U4lVjfcf36HgUznav74R4THcBcu3iPU9SAiPrbP5ueOPIFwiEzit+
	 VbOuzop9J0T5DgzulJ3Zzgu/BloFBlxZt6XqR+nKo2u5OjLCG4EoKg8mmFYXyjla8Ziwz
	 UY/xUWlD2hdDOHz4gMdJthpnyJ3u6sDNycmGs/25cT4Znipy+25b4O6abx1JpTynsYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BN5uRoii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC9606A337
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BN5uRoii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7CF1F000CA;
	Sat, 21 Nov 2026 02:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795228649;
	bh=AoaUaprWdoak7d8mXSrvCYcPq83J6skZ+zUYG4iH3RA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=BN5uRoiivKWk+/K4Rcw1kTwI79dFVI4t4TnRktJjmCcEQvPNMBxvjj3ZYQifszwu+
	 oFYJggxzQtHUkNfG7RrSk2mZWRY3AZNhNXox/ByXFl1DjERqMk/viDJc8IFeTTD6oN
	 o419YwNCZkFlcDAM6N6kzy6U8iTd5wQfqSptEibihnO8xI4TXlOIXT2KVccy2P0qV0
	 nhJn5VloXDAXingTbDBJ6UoLH7Y5zCiVxlV/XYY6NPl075zttNmHeAGqeqrAsndItZ
	 9IAC+pfX/VOnExU6Y9eIEgCF+U5SkR9lUychrB99PqsVIgOk6sFR4k80KqUiR70Qi+
	 hsxXVvzaIc5lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B46D1380AAFE;
	Sat, 21 Nov 2026 02:37:29 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261120213503.580799-1-dlemoal@kernel.org>
References: <20261120213503.580799-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261120213503.580799-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-7.4-rc4
X-PR-Tracked-Commit-Id: fb5289b697c965581104bafdd875b969a1db3e79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05718d5c2907cb46fb27bb6580edb89769ea430a
Message-Id: <179522864827.895295.1765951385191390446.pr-tracker-bot@kernel.org>
Date: Sat, 21 Nov 2026 02:37:28 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sat, 21 Nov 2026 06:35:03 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-7.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05718d5c2907cb46fb27bb6580edb89769ea430a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
