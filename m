Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63C1A316E;
	Sat,  9 May 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778352618; cv=none; b=ejkoTn39OZaLq2iXpBM00BhUwqlY2y+UFk16CxuKBLC0V5w5e3LVXZhR7Akh2xvbUDDbuPdkMcTduGtaViYwrjd7dkzUDk2/2TnO5yEMkX4DeSCLFSh6VuLKgiSKq3yIT7BktLVN3fJT/dZ1mCM/xKPQOGclBQzWlvDfhDOirQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778352618; c=relaxed/simple;
	bh=q4bT7v6dGaujMKEEI88wr38YDeJSR1XwYOk90KxkFpM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bKWp0onUN5j47frqsnyc9TJy2wd4QBp6W+YQPV4tUFih3InGJLr4H3vemz6Fk+0bzBEqluygHVRNaZGQGW2LGL2JyCXvk7h3F10hfx24w722iiXKtsdKZB9SWMYwuvFquTbnF86MMut0XN5BHjhUc1dnuxMxjEeYFnJi9dTJa1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFErmrN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFErmrN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28667C2BCB2;
	Sat,  9 May 2026 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778352618;
	bh=q4bT7v6dGaujMKEEI88wr38YDeJSR1XwYOk90KxkFpM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EFErmrN80tLSyyJe6gdWlItoXNyM4wMMvCeubemu0WifXjr5fCcrbcuskKu6c+7f5
	 TE6IXJl7jN51d87BhZRBgU5MvpvT9vumZXlvL/pMFQpyNukN3hNvlKt6QS9lOUyEQk
	 cnNdOwJtAgToa7+YyLTTDWc2tu9SRgZ5Lfgw/9Qs8wPvhmUazzO00FhpyCNZrfcSvr
	 yxMOEzSkUqib8N0C4FlbDeTJL7pfplDGAQwE85dRltfhhlMrmXGQwxeIA3tRlzp3b5
	 1MRiv5bfnYqnBIOGLBtbe4veEsGyRZLv31hBdBkjt3289/xWnIUgcY1EHIEGHXiBsa
	 nlLQkzEAMMDBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FECA3811A5F;
	Sat,  9 May 2026 18:49:27 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity fix for v7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260509183913.GA11883@quark>
References: <20260509183913.GA11883@quark>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260509183913.GA11883@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 0c8c88b8eb82a2a41bec5f17c076d6312dc40316
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bfaee9d3351b9b32a99766bbfb1f5baed60ddef
Message-Id: <177835256588.1153861.69730057292332831.pr-tracker-bot@kernel.org>
Date: Sat, 09 May 2026 18:49:25 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>, Colin Walters <walters@verbum.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 May 2026 11:39:13 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bfaee9d3351b9b32a99766bbfb1f5baed60ddef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
