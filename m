Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A86E2D97AA;
	Mon, 15 Jun 2026 03:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495118; cv=none; b=VRmxkW8cVmo3ztYR0Si4pkThnyKMeWIbSnezXe+EpBotATQk8jTs9o1H6BL+EPrXh7Enq0RJAsZV6QHQKH8Rn7dve6TjbvOzRMKOWBNBNbFeYt7TvDfsa9jg+VvL7Y2R0/jP++DHmLR/cmQwhkDAeEU4gLLaT1XdZ6hUHgVDRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495118; c=relaxed/simple;
	bh=8w6HjOr27dmAwO+Skcrmbr4/NnLpdw3es1EKt0BY5c4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Lr3U1F/aznAgRCaqhZ1FypNf3diDvQYN1rNL36jECggideeKnZpbQCUhVxV36xPVjOJ3WMDeQWME8udC+Z/q9PxoCWi/16Yo8rr9qqvioUYD3dV+iwzwGCcam7XZ50DEzPcmwsW0qNjrCZOZ0MVXvOWTYd7nM0D7tWlPh+CG0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjwLw0bv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjwLw0bv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DC11F000E9;
	Mon, 15 Jun 2026 03:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495115;
	bh=3TfrLIQYpOCMm5XhQJlVkS8d2wIh4BuOEeP1CTbRquk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bjwLw0bvRo2oD8D7Ac+Fx0F/5GEV9VWCbhMYdCk62cTRyBw/pmJd0jufePxEmGLGK
	 tbWiA70gJGjvGed3xbswJBl/z5Bxq8hXLo1Tuu8cgDbCtDg2RewtEimHuPiJYMROK+
	 xqUtrfIjGH1LtuZVQvpcXsVJTr14v5FYkSJkuAu2CMj/UMrtkUf6DyXrBN6MuHu0JO
	 1mNCgNEJ7d+XuoEUdiF04PeQzKMlLEiDoHt4w4BuHgPtfldZ/5RaqT6SlubF8QW5s1
	 f1UpDmRMDztlXmhWE149Da2oTSZPQvZF48CpnpYnTMemvRFC90G3jkoJ4NiD3b7IXU
	 iMEmXC/vEwbVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A603A566D6;
	Mon, 15 Jun 2026 03:45:12 +0000 (UTC)
Subject: Re: [GIT PULL 01/16 for v7.2] vfs kfunc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-kfunc-v72-64b151bcd92c@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-kfunc-v72-64b151bcd92c@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-kfunc-v72-64b151bcd92c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.kfunc
X-PR-Tracked-Commit-Id: 07410646f6ff1d23222f105ccab778957d401bbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2cb5e633c6e8f2fb9af57e72fb05899952b1e3c
Message-Id: <178149511101.2410512.9767610814067979327.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:11 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:11:28 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.kfunc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2cb5e633c6e8f2fb9af57e72fb05899952b1e3c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
