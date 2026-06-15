Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD1A30DD2F;
	Mon, 15 Jun 2026 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495136; cv=none; b=C626sVyvzGFsT5z6HRz/j1/BISZ9gVsB9POv34ajO4hacGsMIbhA7ta2AtBO4eqm7zdvGxT2FE3DUFiKIMyC7CMJANc5hPseOqbZRmf0BvugPCn2m2nYMRIiIGuqSv9QKvOVI12DZz9vPd6xbE7hJuUdey4tsqZ0uJjivMOER44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495136; c=relaxed/simple;
	bh=qgqQ1ZgiskNuv0JXR/Ud4vcZcsh3ULSDRmsCwfddkfw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HRHxdnXlRM+75dOtrN1ZpSb7w+B+n/f/7IpPXKxD9ZQGQ6n0MCXvEfYB5aeKlBGCfDEP2ogS7F44Wt1w/brx3ul3Ep+tq+ODqA5ZFneEStbI/rElFUu8NitCxP4Cfis+/a9p0boQFWe+uzGgTUxLd4RFb1QjS1BseVZaOhZqEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlonVyiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlonVyiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAE71F000E9;
	Mon, 15 Jun 2026 03:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495135;
	bh=+KTjD8yPm+caHipIgP7l75tyhip70ofrfnn6HXz5duk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=WlonVyiDF8K73479oLRyYLBvYexlnOw0+UlxqtznvEtr/DY3ZR8RFJc12nt4lohX3
	 K9ncioLtclQWCAVkqB6dGpkpsrKXYedVKrgo65MijFRau9UL4uej4o8BuNqhkPwNVk
	 GhnmOWrvlZeKg9VFlFdjoXgon6CjsqLfN12jqd+tENYULbBpHTyk8yrkRFTU5aGFtK
	 bIb4/cIRoyVlDPZx+cAkBb2e48RbDuwdIJ9lOiY3riu1PLQoBd8F4P7kJPhggPTgOK
	 8D3RLQTPGmqPdg07gWUN64TBiwiov5hU3LWZBINwlJhQZAtPndIo//jJTZBA5iUC4e
	 QFOZ0T9K4ZFGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E43A566D6;
	Mon, 15 Jun 2026 03:45:32 +0000 (UTC)
Subject: Re: [GIT PULL 14/16 for v7.2] vfs xattr
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-xattr-v72-765acd2e67cc@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-xattr-v72-765acd2e67cc@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-xattr-v72-765acd2e67cc@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.xattr
X-PR-Tracked-Commit-Id: 9722955b54307e9070994f2382ec06af3d7405e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff8747aacaff8266dd751b8a8648fb728dcc3b21
Message-Id: <178149513074.2410512.11165308086674920642.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:30 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:15:43 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.xattr

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff8747aacaff8266dd751b8a8648fb728dcc3b21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
