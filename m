Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480334;
	b=SEM6vD4Ifmk6t7u4kO/BGayMEYp0+QTitKC2UsyAqw7XvAfxIovfyFEKR6NfiNuT1N4T
	 GpoM5WuX2FFSCJjsawkhZofxMxqBwEUWbC1SAmQRhwPzbzBLAy+67f0CC/bbTsMIUiMgM
	 OTtwHSb+aLwciXxrh/nuG8IitS7JDyQk8UOOHSoW+hElKGagxbbXfVDgLlXCoJIy9Xj3/
	 CC0SuVf5EwjrTho62qaqal4nWwkHn3jIQkf6cm4AMRMkZJXx5h1W1lDZhrUJrFyYcKUax
	 /9E7sU+4exP/AZUp5lzTMg75rJPh2aKk8bXUIDMna1EEWJTUSf/kSTpScQf5tuIqulA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480334;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=oNA5vT2WGgi4imuvOXWUD5aFhS3wPkPDJpVgkZorC8A=;
	b=tq6XiG3l3CsZWraqi5J0EzxrXmCBMz2NndVVqKh+90kgyhLgwH4AN7XP4xZQO6cO8fGK
	 6vroQb7aZ7LNlrjmCfUZJxfwZ7oetC3FC2hZwQRMjax9RSVmELuH0WOp2xPl4pFds7ZHP
	 KTtjiugfPLvIlE31PX10cNHNND4C3TSwCWH3cPVyCfu5byP2n7xZ2YamVFjABjxQimVRk
	 c/y3UwUuGmEYMqodpyCcaSLPrYPVFs1flNjMIWbkmS2aGbR7AaWnHq69E/fmNrJMpVUnQ
	 EuFualIYybHEV/9fYqkOAGK8j4pWMS9yg4+jkP9mwm6dbcHyG/zK74ARoLEy1ZdYXSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RP+5h//P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BFA60A2627;
	Tue, 20 Oct 2026 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RP+5h//P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0676E1F01574;
	Tue, 20 Oct 2026 07:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480334;
	bh=oNA5vT2WGgi4imuvOXWUD5aFhS3wPkPDJpVgkZorC8A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RP+5h//PhxSRi7Z5xUcIkloifoAsNJ84yy2HfMEfnWWBbirCnmjS38GrXBJBAfbhc
	 6tR7y4RGecioLbdjQ0E8pYX8r58dp4ZM0sT99SzHsJEvfQlyW8r/X+PHKy+s7G+rrh
	 Ggcmf2xASEcB2wOZteJsz7b4rJBL1lt2sEz2dgEBaS9/sRtQua07eO81813qJcAfDK
	 QcjJqRzNayY8yeOsWlE/PNN3cfTSGzEaMZW2zKoBiUwJDhCRe5kUCjRQCTW5QZon0G
	 Nvc3370QhR1sgTmoj+CsMi7N/Mo3bnCLETfp1kjQJHiQPVrfxdbVZ7sJgjbrcEpy6K
	 LtrGCgl1rW4gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13F63924FD0;
	Tue, 20 Oct 2026 07:12:13 +0000 (UTC)
Subject: Re: [GIT PULL 08/19 for v7.4] vfs coredump
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.coredump-5fe9155f7d73@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.coredump-5fe9155f7d73@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.coredump-5fe9155f7d73@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.coredump
X-PR-Tracked-Commit-Id: fd00a46e36a12c5279d3d163f0d0c8f83d12dc09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ada21d495ccedc37e165d3c7da12a9ae4160ad81
Message-Id: <179248033276.3535438.7760307517666012723.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:12 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:18:00 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.coredump

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ada21d495ccedc37e165d3c7da12a9ae4160ad81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
