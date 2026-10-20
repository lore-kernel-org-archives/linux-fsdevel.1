Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480348;
	b=I2ZtnhQYeR1uKXHajj48edfc8k+eFg6tEnsvzZeDvtmnpeYRc6TvqrkpUDskFn5zTLcg
	 3Cnsma5IPvRz7IqPSkIJbBcdznS8PpXLWdnr83WRqBbgJooiaRSVTCjUVDaKicRiDhsCM
	 EhVoGwtplvhdD2iIe1nSwZnFKAvxFcw25t1/lpUuGLgI6G68b/dhaQ4qEtWyqHLiKziRu
	 okSCNMHrHBPMK9oHdo0R58J2DAkZCVUCwVvml1sFlzMSEcWCfJDOwrFkyE+X9htUzP7a6
	 D5x4mnlpqU4TVKiw/0EjXb/3LNVy+9q1Fjy4snIghSlPhqCp3TGosATw8kRD8GyoabQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480348;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=3XfaOnoCIioQsWL5JSG9YCXOK4fbtOe7mVeE8EztZBw=;
	b=HImh8ffUKSymO1suUjSR9oHXPNccEXNjwiEKys6wc1odb7ooRf2ou6WmXFsBDck1pb1C
	 +/NFAWv9pSQBPbc2iY86dstp4Wrn9m2GUr1Ce6xaOzS5JA53ri5XnvocVldi7kZ+m6qCM
	 LLYLV3fPw2dTtWbx8/nUo8ujyoKDHkPbeCRaNIsDhod2NKdF1Q5xUtC5wSlfiPgfOuRcr
	 jD2I+gAXVF0kVAJfskmpdc7oHi/++DUlU/7upvW6oHAHwZYb5sVVTdiozO9Zoji7fstOT
	 vS0oyK3TkhAZPGKt3aqhuO5421uxi4uHkXZ4eUWH2zrA/Ad9djzljv71Z5mMOZjzuWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlQZda+t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF4606A31D;
	Tue, 20 Oct 2026 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlQZda+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0884E1F000CB;
	Tue, 20 Oct 2026 07:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480348;
	bh=3XfaOnoCIioQsWL5JSG9YCXOK4fbtOe7mVeE8EztZBw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=BlQZda+tCKSPGOTu1LPJh2+eft0eQMfMOnKSmJZiKNrJr1CkTouC6HP+JMmBv9Hu+
	 KVTF3hq0sP7Bl7Ieev9DmOYGGMVWw+0lEZepOO33sAt5u2RE7Y86UgUo82xJbDYVZ8
	 pb5jRxPG/ouwoI84B0nZyBu/kBi5uxMKnS66JmVUkoKovXMI8iLyBFBMZ8iKvGBWT9
	 0410YB2X6fpNfjzx+7cvF2rysj0GPDw2pQNuZx5yLxwQ5pWkfO4bQ9btjHTGQK4Q6s
	 WMdsxvpzhIvtr9hqzKihQBnlM0vBh4AoX+d1OnTnxDg6+Ee8YDwUdh2enhD7bwtElU
	 X8GAa1LguYRyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13E43924FD0;
	Tue, 20 Oct 2026 07:12:27 +0000 (UTC)
Subject: Re: [GIT PULL 16/19 for v7.4] vfs netfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.netfs-9979cb10f896@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.netfs-9979cb10f896@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.netfs-9979cb10f896@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.netfs
X-PR-Tracked-Commit-Id: b6134f76740497004f72954ae67bd4ba45d2f044
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a49d49159b76f6dd587131b3765d3458cc3aa01
Message-Id: <179248034649.3535438.2879468762726355082.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:26 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:25:40 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.netfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a49d49159b76f6dd587131b3765d3458cc3aa01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
