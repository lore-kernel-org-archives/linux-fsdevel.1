Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FFB314B72;
	Sat,  6 Jun 2026 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780787348; cv=none; b=fSs/C38+Z4ysmCC5hGqDFFAYRrllSoCvofXXHzAC8/bMg/TF1u0BzfDL4X6S51r1mPTSzxIraJ1XskGKN4vhprV8giZQm3umOYpdnU18uc8vaeJvZ6ROnofhP78Cafwh3CJUTpS8s63nXEaKAgS4UItJXGWk6o8OW2mvHJIuPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780787348; c=relaxed/simple;
	bh=ztlzz5n1bOJ7aazOTcR64eeWDDO1BHUPe5OXkkCPlH8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t2g77jKus9RX0lwE3j854RXmaPMR4/X1eiG6tCHL4Pj4xrejvlIE4ZORj5f0aiKGgAg4l8BBOVNH5x0Gr4QLXq+TuLxYmTNMjoiv5yjWeQZBMQPlqk1qS1AuGHBHhCHZyIWs1ZJbjE6htM1kU/m43MqyhPY3meLLFPQ3OyUxou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGXmanrH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGXmanrH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE34F1F00893;
	Sat,  6 Jun 2026 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780787347;
	bh=a4SnVnR3cUq88+p68s5011VHa23wWjTeu/oEn3HH1z4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DGXmanrHMRxaCDTduIjPLjHe8VBxyj1dTOdxqeuQu3Em4CsxcQ02uiVZNIL1qc5Kb
	 HrvZs8UPW5xZxRO6RRIiHZRF6F8RoLa3XB3ShkeccFSzK1kOVFB4L5YTdPkE7CVqn8
	 so0UYwZEQZIOUDmgvPcUaWTKepeNRz7foO/2Nj5Y8jMiFBcpObuJ1W5zGs4vYU1NwI
	 DEzkPMcqhDHYfVEpAYgJ9Q5/fZNrYvj6PnCJc3H97pZtBjkoIgZ04FhXgfOy22zN4m
	 1L94HtWl1qRed1ZrMFaSOFz+LQzn89X+kS9a/LDoShkX8gzcnWkpA98qLPaEs5KLnw
	 YT+4l7YsYsRpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF13930C37;
	Sat,  6 Jun 2026 23:09:08 +0000 (UTC)
Subject: Re: [GIT PULL for v7.1] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260606-vfs-fixes-v7.1-rc7-29c54fc0070e@brauner>
References: <20260606-vfs-fixes-v7.1-rc7-29c54fc0070e@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260606-vfs-fixes-v7.1-rc7-29c54fc0070e@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc7.fixes
X-PR-Tracked-Commit-Id: 2eea7f44b9c8b42fd7d3a1a87c06a7cd1b99c327
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76351effa53d49114907dc9fd228110c2115292b
Message-Id: <178078734731.53577.18011458787419604847.pr-tracker-bot@kernel.org>
Date: Sat, 06 Jun 2026 23:09:07 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  6 Jun 2026 15:17:34 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76351effa53d49114907dc9fd228110c2115292b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
