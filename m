Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B012DA756;
	Mon, 15 Jun 2026 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495119; cv=none; b=UJ9kW2q/rsxQ8A6wuKizZBvXPDISzyWzLgjFwP4jdO7rkqVXNuFLqps9dF/G+8nK+GQBmE4PT5vX6+WQZ8LlT+zT21zcMBjS4yWQEFZv8EHvDhGkCyuWr3w6pGjFbYP0Bh+g2hbRU7yudt2BLC865waiXUATj5NcNZdPxfLNClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495119; c=relaxed/simple;
	bh=dx/9zhlASjHKW972+jLRodczmMpiBlDtdGkH/09dMpU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fz8Sm1jfRM3M2F4Op0/vvZQec8T3uOcPfhfJbJrWv+h9ngEt7QWD2v9KoBdixIk25KmPT1ZOZOKt65HFpU3BiIcOQRmP0gXiG92DXsdpBALSf5h7yd44DGmjxQNnzDz2AslaRPWieMNRIKi4cK05xEI2WfqeyMENaVgUDHEomPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxAl3HC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxAl3HC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1A31F00A3A;
	Mon, 15 Jun 2026 03:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495117;
	bh=lbjV45N0eoWr4fauJolKqtt2wRU/Bf72dTf5LNWvD+w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HxAl3HC8ylq+FKtTWyVbHRqXcfZu6qSA5/qP2SMDuJgEptZ8FosDIuzGhdou9X/9b
	 kFpcbkXMZI9eWjyUYMQ5j0VQZlsHGCIXAuxwuMVnwr2XLwvYlGPLRBvQl6PJqFxbAE
	 FWGbj1wcrGPWFnFQgQTYzr94vv8jterAKTPiPcTsAaNbJaQL78DyfT+62YPO0IZW/L
	 51aRvO8DFTztwUwPkozXOdWw4i6ZLwn3pSbNIEOpXW0gWGH4LfYL3EAg5JMEGYU68H
	 d9dmmSk9rKCk9igvG6LOh/C6OCAf2aEDTyCSGvmN1FVAxamCcIEOdPJN/jN8LO05dQ
	 Z8CFF8hB1GUaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1985F3A566D6;
	Mon, 15 Jun 2026 03:45:14 +0000 (UTC)
Subject: Re: [GIT PULL 02/16 for v7.2] vfs exportfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-exportfs-v72-75b4494c2b8a@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-exportfs-v72-75b4494c2b8a@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-exportfs-v72-75b4494c2b8a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.exportfs
X-PR-Tracked-Commit-Id: 79e33ddc62c03cce6c29f0792454e1d618228acf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d23bdc4988efc22904c78ca36ebeef5deb950db
Message-Id: <178149511273.2410512.15360696161524532947.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:12 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:11:49 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.exportfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d23bdc4988efc22904c78ca36ebeef5deb950db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
