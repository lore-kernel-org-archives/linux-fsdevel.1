Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A6233704;
	Mon, 13 Apr 2026 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120544; cv=none; b=Wzy1XrdPRRnmsxW7qMKpH7Qc0nwRoUEXndWHFFKpyzW64dI9fz0WhBEfYI4I1xkxVV5SVFiYeH8rqlz9avr+UNqqJqHpRkELcB53qUK/p8Juj91In9JaFu+hJd1Yh25ujC6ZTaxRxEWYxXWTS4l8OLr/gRY/oMcuwYI3scwnRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120544; c=relaxed/simple;
	bh=XfKBwvCjpoyMWJW2plycZA63DahUthunfFbjKLbI/xk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q1rxRyVA6RDrEbDj9XCbevCpzM4hHFFRS9CYHedHSCV5wp+mTc3dlerXId7E9FsTTX/aFidOcr7WUJtejAVCBQhHbbhc9g28A5q7cFGdux9z1CTapdGH513vH6PIHt8qTRi89WrUJEMk4jhP5YR0nx/y09Y9LZobdawNFbyNs6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSu/iHaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSu/iHaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E85DC2BCAF;
	Mon, 13 Apr 2026 22:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120544;
	bh=XfKBwvCjpoyMWJW2plycZA63DahUthunfFbjKLbI/xk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LSu/iHaFM+2ckJaOxZRgCxBIAdxZW5jC+heTT10lfcE97cM72pgZ4epgnCvuGv9GZ
	 PwnNzq4k74ejxtq56rxZxfZ1HtNt8OaMLY0kmv1sjGCDrvrKfGwleyfvfN73Kghwym
	 U9Z/5bAxXig8KygLcoLBYuTVgAbXJd+Gyd0tqUCjwxoIp7mx1OFD+9bI8i0VZ1A885
	 tN8lFhkvPEYeHHr+TfELRMkKW3xe9TPGfAWcwRKN12BlYKyhNRg6G4sGEHBS7Hxfg8
	 B511ozhyc4E5F4VxMIrAiVXS/gVNrEe8Tf9DV5zM4j2diN2vELIo0AmhL1auEivepu
	 zPvJmkma+fHnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE2A3809A0B;
	Mon, 13 Apr 2026 22:48:36 +0000 (UTC)
Subject: Re: [GIT PULL 06/12 for v7.1] vfs kino
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-vfs-kino-v71-672d31bc705c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-kino-v71-672d31bc705c@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-vfs-kino-v71-672d31bc705c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.kino
X-PR-Tracked-Commit-Id: 2e43ca1a4f949e4beb763f8196695da02b17bd77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7d74ea0fdaa8d641fe6f18507c5f0d21b652d53
Message-Id: <177612051502.584243.7438951464613471550.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 22:48:35 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:18:42 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.kino

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7d74ea0fdaa8d641fe6f18507c5f0d21b652d53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
