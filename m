Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD14D90B7;
	Fri, 16 Oct 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164262; cv=none; b=G7BNesh5x2OSOZoL1vgvuMWT0WtaRKWHl9XY2JWwnvzQzmzKX8t6fHq6DH3tIE7J0IexxNCQXSB4h4UQZ24Qscc522Yd9rVyu3BpzCvURo1iFjuz7bLq2dsCiMWClFTzt2DoPqtKR21SNtKPEzNnNkgCxmuYlNBYJgOooo4r55E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164262; c=relaxed/simple;
	bh=GsrK4qUFmG7vKZOKmRQvfszJMz/gImOKNqnXLO5Ncj0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dajCfY8SHM5YAayyKSrf9zXzQp0Sw41VucQ+ae5lyGeHaKtApa8a06v4obVNWDEe/+NYnfMXWWL2zUHbh92O+c41PQP3/xbPcfbqFzYyCcQyWv3aTpEEsQLZSPr+Droeb6p/bT4BFEbXsnWedtWQ0kZFpUG9cyAdd2S+T6gdK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR36ixTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR36ixTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0785C1F000C5;
	Fri, 16 Oct 2026 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164255;
	bh=u55hnYy8LFvehjTN/l/rU1LpS+76PpxEpydpSQ425UE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bR36ixTg3qHW/rYnFeI7Qkrg9vVOD9lP07KrWMng4+Q8IxjULj9zASn3P3A1M5pAb
	 Jlc5WSpJj69m54QsbOStcC3KDhKwayaVPpQGoqPCNIS04xNaWCY7XA5LS4+inc6ib8
	 ULofTckZ8ae/mPoaTycm2Enb4ikowkujsuQMLcV+doGcsrMf7EMAEpFAIoCASA1wzX
	 gS3wEGCdVj7B8keyXzjkeGu2u/y4hwUMEP+eOmeDqZlTnDGWhaFyUS2gmUOpp47B+k
	 DNNrGwy7isKK/y3N9sr64gr3dA3WA1h8A+cjRZv+N5vhna4Gh3f/bomyj7bJJqIMzM
	 5VZl/d9ELaTGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1741380A96A;
	Fri, 16 Oct 2026 15:24:14 +0000 (UTC)
Subject: Re: [GIT PULL for v7.3] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.3-rc8.fixes-c224354747ab@brauner>
References: <20261016-vfs-7.3-rc8.fixes-c224354747ab@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.3-rc8.fixes-c224354747ab@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc8.fixes
X-PR-Tracked-Commit-Id: 214897acc8c2e5d6b63189d23ccaed6fa2af45a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dbb7422053fa0f4fb5f9acc3931617fc0091939
Message-Id: <179216425359.816915.13750806939487191277.pr-tracker-bot@kernel.org>
Date: Fri, 16 Oct 2026 15:24:13 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Oct 2026 12:27:37 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc8.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dbb7422053fa0f4fb5f9acc3931617fc0091939

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
