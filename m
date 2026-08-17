Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287993EC829;
	Mon, 17 Aug 2026 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005587; cv=none; b=iWwxCWoTeiMho22c8ir42bqm6LJYwqeFgGaRlWK73Byf0sX41unzKVG1U8XjxpW4kh4DISsOOkxuDcfCDTnubzlzaDZTVroTFNnMDUY8PGTppojvl9uJ3U93xvLkloQPceOl+AQ/WfTkLuooTrSshZdvrDGiDcmLPLNewCTPRrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005587; c=relaxed/simple;
	bh=n+3PLGqONja0Tj7VgW2FtHegFIiysMR5BVT6QhKnvWA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XzQV/RKcLH9X7jMuB/yJoYM1jGNz5stKqW2G1g7inxbDKhchpPmvH7tHS62ZAxUJN6qTxRw5ZbmYuBXoVMEuDac+kZHScyuAS6IBybUqmG5odJJuuud1A3iRYnUxWV6gJli3o70ZYYIFvgJHeUyJ9Gdfi7n6VVnqUxoj2xq/2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAg8QlWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAg8QlWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C253F1F00A3A;
	Mon, 17 Aug 2026 22:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005585;
	bh=85XXdu3tUwQulhfX9rrvlVHdvjkkFmFu7bBiOhEXNM8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=oAg8QlWeHZfPlAH0LzG+nYk+J6Xp17YjFuSr7AtInNi5oCMxZB+FzqzlcWLfzNOOm
	 Xf49qJWUnbonvyTy6unG2CXgU1V1HGFY6Ig03Qcm2lMdCcYBchm2Z7Y/hVrt+ZqV+g
	 bCuempe377pj9z86TsiNtLXrqHVjJVz9SSoBrShp6Ub8OQcvesodhCyyoVBeCdCmMI
	 LmdnLD+GYdRIyKtaledQdLzX7dqJwo7ePmTKroO3VMnqy+92KwI9Q65UozPlFjcfCT
	 E1l8cC5wlTBzTlRSwKacWH0iIrsuLeKlqhj5/fcz7rhMEFWvNnkn+HeAPlZb6hlH3T
	 f+0X9fkA7+ytQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983D3926274;
	Mon, 17 Aug 2026 22:25:39 +0000 (UTC)
Subject: Re: [GIT PULL 05/18 for v7.3] vfs failfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.failfs-903759d156dd@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.failfs-903759d156dd@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.failfs-903759d156dd@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.failfs
X-PR-Tracked-Commit-Id: 1d38e750a389e919c1608dbc61cd5c93cd4915dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd051cfe1e35a471fc2cdf6d32fae6ee23305ecb
Message-Id: <178700553771.1769471.14566472380174475973.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:37 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:11:51 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.failfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd051cfe1e35a471fc2cdf6d32fae6ee23305ecb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
