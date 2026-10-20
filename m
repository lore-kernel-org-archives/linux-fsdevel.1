Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480341;
	b=n1S4HSJnvDtURavI6hB6085fyscSc148St5Mk0uzi3s1ItWu4fKm5CGsfpEDnFR18DuA
	 5pP4UzezrBz5wuKcw3m79+8WkMmL7RO6pfjyEveSoy59QX8KXBdV88fT9Fkhks2UBb2gS
	 2no+ptrQlzIGkgtYBVOGVpcjYuDSSbPdK+vvV6ssw1wHTvpWLGTJH/yksAzP5f6iKuTsZ
	 CnxJg0DnAYTX/xAEunsD/SO9cMuvtHa4iup60A8/0spSkZ44YxE/RwTr2TNVkCAjBGcwh
	 XZ2zkDhRNrOGC6dDmic9FzS2tfj9fSZXGYPzXs9KdZ3FckuVTZIgJckCkPwCXIMpJAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480341;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=z1oRTwVsKt7morTvhKzwOIWDkE3Qz9qgBKttA4hFtl0=;
	b=jAYTmUBKQockqC/Q33cIOTo+orrQG7ytYG+sJAoNVIRO0L778VTYNfyEDBZdcaDLznTs
	 CcPZOQL1vmOVbu3Nt3Iphz/LR+VQrn9wEIE0kzBnx+uC2yUoKSgIcoGjdhAx9NRgkxIXV
	 /Fwxau9S3iJHVO0wHfFDquLsgCcnsurYYgpyMO3V27tKYeqXqfN9Meq4i6L8awUSFG78j
	 MguX6KDEaddkf4VazeNQW/TRl46ZyUl53cs9mWLr1yDcDoEAmbYMM00sD+zfYcW3wsniN
	 7dLMNREwmam5HFS9SRalaSFpESZ79B+9TojxZh8qRt1LBcM6XgOwZ24315NgunUusYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Oh/q/u/5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BD960A2628;
	Tue, 20 Oct 2026 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oh/q/u/5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068D31F000D3;
	Tue, 20 Oct 2026 07:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480341;
	bh=z1oRTwVsKt7morTvhKzwOIWDkE3Qz9qgBKttA4hFtl0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Oh/q/u/5ToUKKYQB/2r1mIfp9utGP9+RVq9yoOeyS0jKpQ7vpDqumIGdmghnks9BQ
	 Tjx1Wlin/gd7h5oPQktWXLpyMwOf2/EXKRoTrA+boU5iRffISk4eq7g0X9uUvgesAt
	 iro6jFF65pFAzfncdr7OcbqzLe0rhV/qIxWe7ZOtX9wpmln5DVvMavg9GeJNTQd0hM
	 ZXieReHIRrAQmppOvI/PKKVso+pW6x1Jd4jCAcOBkYWDWfVa45DagIjvS+0DW4HS0j
	 mjAsCIoR5jFlEE8p06JSzAz/+sCiRsR2sNNyJsZR0JJxdJpLRMtrY47BuG/F3LdlQ/
	 2xTJXWixuSa1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F151E3924FD0;
	Tue, 20 Oct 2026 07:12:20 +0000 (UTC)
Subject: Re: [GIT PULL 12/19 for v7.4] vfs kernfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.kernfs-d34b0bc9b87b@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.kernfs-d34b0bc9b87b@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.kernfs-d34b0bc9b87b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.kernfs
X-PR-Tracked-Commit-Id: 1c45110a23bd7fb4a1a7d5f5a1014c5b688844ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ddc887102d8a13ce85041a41c45f2053b483119
Message-Id: <179248033949.3535438.9521713669479714148.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:19 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:21:59 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.kernfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ddc887102d8a13ce85041a41c45f2053b483119

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
