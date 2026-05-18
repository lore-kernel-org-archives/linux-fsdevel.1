Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8E1C84A2;
	Mon, 18 May 2026 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125531; cv=none; b=UidwZBxPuBmNkAqhEQoRW/HA/kwokZn7H+bp7ll2J8BZbcj1+cx1HIBFAYWNemjrXXE7+VzV3+wJx+GoVnRnJGvfVWUKzoXmSUjy+O7cbk3cdhX0n0vVtxu4eY1DXyws4AjlepBWLK1+hQNS81KY7q4BD510tE9/6sUJ5DB8Gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125531; c=relaxed/simple;
	bh=OZJ8vZpF8aARZ/AelekVzsKZ0GEJk7do3mwYi/7zGjs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U4fJCpNJBLkn2wzvBWpD3quQ64MGVzRuEzzY+ja51U52VOjPIeQLK77NphstX4mSkK5rvE2qpm5pW8wLAcBR7cVYzWfTSPpLQz6elKhUPl/ox1nddYlIPXPDy18gYQd42tmLJEyhygBlBkhFZtCn4yj4TiJNuGh0Shmx734lsuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnOsYzfp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnOsYzfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E20C2BCB7;
	Mon, 18 May 2026 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779125531;
	bh=OZJ8vZpF8aARZ/AelekVzsKZ0GEJk7do3mwYi/7zGjs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cnOsYzfp+vlUXxzKCbw6AlU9K/13A9ArWUKlIz3RK6KunmlB71N2l1KpkRS8OQU+p
	 Kn628ZNOVXmuIXcx4+tElzUM5pgDJbyaNhKZhAVimdu8j4PrN8GWWQQFaAvE3AQzs6
	 6DIlQ3GeR1xeCcRkYY6LZn6+RVgMtEpdJkt4BSVIzFqIhvvcjuoNsVATEJt+vB+YH2
	 4EiJYRnaGkoSWpDFy/eoReqplgk8TvptVnBpnmKBE19HEgh5AgIVr5TJrIIooyNPz8
	 4andg7Xq0aK89TpsG42LMkBNZFYcn5NX02NXGAQfZHyQeDTwZQvaYAvtYpMmVNKM48
	 r6xVi/HTAUxZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CFA3930C9F;
	Mon, 18 May 2026 17:32:23 +0000 (UTC)
Subject: Re: [GIT PULL for v7.1] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260518-vfs-7.1-rc5.fixes-3eded3a501f4@brauner>
References: <20260518-vfs-7.1-rc5.fixes-3eded3a501f4@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260518-vfs-7.1-rc5.fixes-3eded3a501f4@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc5.fixes
X-PR-Tracked-Commit-Id: 8a220d1c312c66194f4a33dd52d1fba42bc2b341
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dfa01ef37a8b944773aef8dee747cd76dec4234
Message-Id: <177912554250.1907084.14526813052208782069.pr-tracker-bot@kernel.org>
Date: Mon, 18 May 2026 17:32:22 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 May 2026 09:35:59 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc5.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dfa01ef37a8b944773aef8dee747cd76dec4234

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
