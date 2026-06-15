Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240E2EEE98;
	Mon, 15 Jun 2026 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495121; cv=none; b=o+yKbhLK5D0+fJV8KWCP1J3YQcHymgURqd223UkOBIDsmas6hX0Bn0zofzUYl1TNMWALGh/N2Nv/Eh8JEnjn6G9WsUvQcpZw1+bHYYv6tMeolb8gTihkuMOs2/iv3QzoBKo+b/zLlzHnpz5uRRyqeCp73Qw+WJs+p3zj3wSQIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495121; c=relaxed/simple;
	bh=yantU25lXPR5efwEL1YguNqz5Gdkal1qAxlz5RlsrKU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T9FLjdMbQ1CaHSl4lprs9vRPf/d4XrmCkNfATgp2kZe9a7fZk2s3VLQNF43uxAW0reCEPDf0ivQWzjjwhHvtQeH3nvwSkDa66zWf8ko0qfYvTgXIVsAnkemjvfXRFvvBKSQMfR63X7fMv9ayAfbNkjxlEfS8mKsZzvXsSck51Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gyzu+kHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gyzu+kHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7C01F000E9;
	Mon, 15 Jun 2026 03:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495120;
	bh=LFWEEYXN/ZEhOYKqW0+4q0FiLgqwlx24UTLIIn63QIo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Gyzu+kHlgug5jyu/N/qq+eJjBQiK1646o+wQ34z1c8/EVF5Av6IMvkb3AAOFOMXad
	 ignUfFYfOMMJeXvFpnKHf5fRy7ZJYl45YzkYuXYZ6F5KMgbMwiERGbEChZYc+h8gFU
	 xRepEDpFqum91i2RU6IkGG8EJ5V9sCGgLZPqEc1iy0kAgRzACKt+5Juvo9bT+JO7Ys
	 xv0zGEx0nY3LLD8G61k/Ypk4utjRySONfUafu5UdnOL0D+KVb+FZs2K+xYyQ9K9/6x
	 Q0dZYPr2lyH8rLx14XGUTt8dMHp8EIU0f0DdFOVskyUj6MNbkW/jZeNBKJcgUvkOn2
	 hfGfzjge9ymbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1981B3A566D6;
	Mon, 15 Jun 2026 03:45:17 +0000 (UTC)
Subject: Re: [GIT PULL 04/16 for v7.2] vfs directory delegations
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-directory-delegations-v72-6a98c8961ec4@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-directory-delegations-v72-6a98c8961ec4@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-directory-delegations-v72-6a98c8961ec4@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.directory.delegations
X-PR-Tracked-Commit-Id: 246bc86d0fd891273a8502314f158eab23af823c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b5b72ac2c6383e423144beb257f98359b966a3b
Message-Id: <178149511573.2410512.654030479796095861.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:15 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:12:28 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.directory.delegations

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b5b72ac2c6383e423144beb257f98359b966a3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
