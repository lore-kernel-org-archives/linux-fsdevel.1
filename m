Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480336;
	b=tIvtTPSENEEFkyXy5Df5eGru3vcN8nqnNTig/O099PKF1P4ER8dH8B0AQ31tvtKjqkFQ
	 V8MR3O2WcGokbmEXk6JqajD7IneyV9rybnmsv+ktTGF4PBQjWIKq/Oq+iCc2PAcUSE4+C
	 UmxHxNI6ZQOn4kfzAf5GjmLNUnliPiZrsHdgbGHxekT5zTRYrD3bblqTCOncu89mIUiso
	 jVdnYy3m25FR/TquoVJhRYDINcxlSzppSMp2SYLBcDqhlRu3rkloLT/dhk43jpwyrSoVB
	 DczmA1WNNe4L7VP39w8Wf+UO0BNwt141R6LH+1AbhKqJtYUA/8dBSx8uU5oQ28XlOcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480336;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=mRTxAn//jD9NuwmUGHx7T6/aSz9vc2M63kQsVsw7IHs=;
	b=1fpTIrN96RNGmf6jkuhFHsKKE9fwezYNSESCfFsqjpRHC/bNu9j+7PY9SuqjGKRxp18e
	 ueoOAnIZqL8NOG14BjnFqtQuXAXY7TSJgmyBeSo2lsknyoUSUVUCtuT+Fk+5IhPjPWaPe
	 SO7Jq6fL1oBa7NzJ56/KdPJJusGtb/Q0TE+BSIk5tWgKvUBCmy2xLZ95pItKNqcmqCbXS
	 1VS4a6kqoACfduoo5rJeuOy4o0Mf3dSi5z2p9hlE2lG5REkOL3n+pNxqL7b2jM3rqvxKI
	 Usq/tu6piike6DzNSo6PraoHumWp/dvMGqAVD2XZEgNMjUGrHTjAXTN3GnV7nfeTu5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5U3z598;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142CD606A31E;
	Tue, 20 Oct 2026 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5U3z598
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA7A1F000C5;
	Tue, 20 Oct 2026 07:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480335;
	bh=mRTxAn//jD9NuwmUGHx7T6/aSz9vc2M63kQsVsw7IHs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=a5U3z598/GJwnoUDM430sv+xxTMNRMeQXg6oTzQtfR2Ppu9A3T+lPemG7VrPDmTfE
	 L/u3+RaKAu2zbYQET5VTjkXk5094UcG4NTyC/haJ+ur+2hTMY8jRo9+I5FCrmQbVJs
	 eWFqSmQGENEbsTbx0Yj7UDXd5IeRAiDZtGbRM0LGHeDOaAJ6mVCgiOel/+X8uV0/ao
	 6kgCxyYileQAnlk7wuoeiSQtCThfuujRWve8ZtozxSApd2zGG1+10nLyaQN0odEYih
	 oVpeCrk5BM7I815em+PvleNN9QPY9+8Bhfk6XvqAVYQdWg+VW/gwVSeVcrxHHeLI+J
	 BfY0XRA0jj6NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44323924FD0;
	Tue, 20 Oct 2026 07:12:15 +0000 (UTC)
Subject: Re: [GIT PULL 09/19 for v7.4] vfs file
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.file-c45175e298c8@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.file-c45175e298c8@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.file-c45175e298c8@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.file
X-PR-Tracked-Commit-Id: fae37d5e3c4e94aef334825ab89f66efcfe489b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1d4585be12feb09b3e66d312ceb200234164660
Message-Id: <179248033425.3535438.6070211968597684857.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:14 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:18:45 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1d4585be12feb09b3e66d312ceb200234164660

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
