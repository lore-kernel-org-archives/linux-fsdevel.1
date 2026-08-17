Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CB47279B;
	Mon, 17 Aug 2026 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005605; cv=none; b=LyVvI8pH9xTqm20scNjoKJsalGhWCZROzAKuMlaiws3IlzK8DXOqUvtqxBgLgq1lywSIHQ9nz1AdmH7KQRwRrO9obY4ZxEbyIZzQ8m4xjHc/Lf3Y5Mo0zAgQ1fIkYuthVSldA2YnRkClmQBFfJF6+KFkjyhTjawz/IGpiohF6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005605; c=relaxed/simple;
	bh=QFdP63FwmTrt4TmV19Oz34J87oz5Qlueh4CcIGxNv9g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WXvbrXUMKiy46Fy8kn1so7wvM2tRjoADCbZxm7cZvjaYdDqI8bbx5/euD193LNVoXltdllRjiKk/S85ZsIie7DhVpA2spj0MuShRZomLEfU/BWDSUWS/40UaLPbwptAiKanetpynIIv3SIB36zTmm9UIGhYLWdgmM1wepydnYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDCQ+bu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDCQ+bu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31F01F000E9;
	Mon, 17 Aug 2026 22:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005603;
	bh=MES+8CGuqBPp4RAiYKF77o7MRGpCOYzth5/TsERbD00=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NDCQ+bu949Wvzrgr/rjSqP6JbvwcP9R9RQfJ5xEpUAL1LQPEgf8MuvaDMilj2VpAu
	 ZV4d8uynSANs5JVApMe3NTkR1DwC2l9VbyTcUK7dzVFf+yuedFPBcjgRUsm7jTuqMN
	 ES0/D8l+Kjdd9NqIzPgGoGKqgV4bMq/31X6iAdVUFeF6RJP51e8uMNsYimX1DFsfO8
	 IVLJy+wuPCmVt0pJBu1/LzKQ4lPPJ4ijeWRIpIP67nqnw3fasClDyucmv2OCJtvlGX
	 JG+RRn5HQoyTqlLQNTRqmMvQ3spPw0n5fip75+piNd0LEjyhZIekBiq0BOg+Ix1+aI
	 u4/b9sSCLXAyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E33926274;
	Mon, 17 Aug 2026 22:25:57 +0000 (UTC)
Subject: Re: [GIT PULL 18/18 for v7.3] vfs sync
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.sync-55166eaa0000@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.sync-55166eaa0000@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.sync-55166eaa0000@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.sync
X-PR-Tracked-Commit-Id: 974d0be0cb8e48d63b9d413a2e1a8fba16cd2583
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff68e5f557f69a08fdcfa4ce8b1b809d63bd4f45
Message-Id: <178700555571.1769471.11372446319355226306.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:55 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:15:02 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.sync

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff68e5f557f69a08fdcfa4ce8b1b809d63bd4f45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
