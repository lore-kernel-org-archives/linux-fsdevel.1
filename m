Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0672618;
	Fri, 24 Apr 2026 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989662; cv=none; b=uzXmUiHAyBXJLblT3sy6ch79PpLEIokLh3F8tCpcAvOfOexkRkUQxqkph1th9Dvc8+P0EnccRifxiOyR8fHn2PQlxvxahVKVVC+Df0i6tyvaMfuPXeLHNwxZJuiim2DLfErgOWQ56elEm6ZdbfF6ri1xFKJhiuWA/o/A9Ly7enU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989662; c=relaxed/simple;
	bh=aOaHRnN9XBV/j0vE3oYjBK33x9IcjWorS8LLGl5KzUw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P8Wrp2W6guNQSwTrUdl1zaj2jud/CQKbuCTS6GhMW5NfjCsKmoTBjjR47uU9Ogc+VFt66x0ExuHpENspZGr5Il6dvRnwKoOASFJCmduFNyHqya/5ZHCqyiRkxU4Cx1MAtIxQ2yF9XLJwGeLgF4pph1V+K6pOCftktmnZTcZQX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npaXMDvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npaXMDvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A45C2BCAF;
	Fri, 24 Apr 2026 00:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776989661;
	bh=aOaHRnN9XBV/j0vE3oYjBK33x9IcjWorS8LLGl5KzUw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=npaXMDvoocWayUUXgvxAjzLwhBsssw2LrbNfK4Z55TQf19T9ZHmYFFqxRUKgq0D3e
	 nF33U1z0a8ZLS/qq66zLkTvkxCH40edAkZMq7/yMRu3duUGDDIEdPny7HFQ1PC4iLe
	 3mM8HJ6LCiFnSEGgXjRatcmRZR6DyKdYGQV6T6l3ARuSgBjfHCiUoIJqKzwBwE4kq9
	 kRzsHNBDLNJ7V2beVRwwGpvYiw1vw6mnqI6njZERB0q80okS7IsM3oH7O6kYTOX+AM
	 wWMlr5gr1fGUJK/BwqnPcVaaw6q4hEQOU2251iriNLzs+plPhC8OibQBk5JT+/t6Pq
	 3jJFw8iUE8MNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400C4380A951;
	Fri, 24 Apr 2026 00:13:44 +0000 (UTC)
Subject: Re: [GIT PULL for v7.1] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260424-vfs-7-1-rc1-fixes-500b3d993ba0@brauner>
References: <20260424-vfs-7-1-rc1-fixes-500b3d993ba0@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260424-vfs-7-1-rc1-fixes-500b3d993ba0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.fixes
X-PR-Tracked-Commit-Id: ac8777cc36224b4705d2c6efb10c56135d479b21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
Message-Id: <177698962276.818077.9126423796971931869.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 00:13:42 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Apr 2026 00:46:49 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
