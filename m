Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA74E50AD;
	Fri, 25 Sep 2026 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361793; cv=none; b=T2pE/bFEFvd0k4yXoi/WxbI9a6Rhn95LvW5Ib4vn5t5Jd1jmK7sU34ik4caQGEd47/HD0Hhs63ey8PRGzbsMtKLE5aIbDY8gNlvWDvWQqgMnmtI1HioVFJKs4B70dXTnGm5xidvqZxSVhUy34c8oQGH0+LdMMe4geUIopWFlynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361793; c=relaxed/simple;
	bh=yzOO6BQUysdx7xv8wZshjeAdQH3b3fDW6iwWKHO+XQ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KtyZUbjGddIKWp6IopZGkOrr5vLR5Du7CkV9H8Widqmz7fChernOLkpyFeJ7hxrsHuYCOMljXT2+Bs6LbBguZRfDGF6FT/nR0QQVqTErkk3UXvOgvrg5OpNyJmIU64pO0fgcy1KNn5NVyUTaWo1Z9twLDyapbNWy/1YVFZwvvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUbVHcvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUbVHcvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AE81F000FF;
	Fri, 25 Sep 2026 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790361791;
	bh=5hmkBCarUCpTeTxfe3FQ96NS5ntUoxVyb+0DfPx86eQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=LUbVHcvXj6G9+Pyw0Y5+i2Ujf3Ce02OZA9npPr2/Ca6PKOhYhN5P1XCDlOUEzsB11
	 nzsA/r0vqkNLRYnByqM0WkzMreIdC2JLlVCOmP0YD8uDSxwFkFqejyR6qy549mZGzo
	 8BZ4X0K4FkZSKdPE7LllxiKTm/h9r3yA+5tE0vLp5ibe3wIXf80kB0BD+Ing5tMmYr
	 Tv6X9q9nuJJYevgG6dHufO6l4YimVoaFDfT1HFyCnuRQpG4QJftOBuGQVfsgQozklv
	 Kjbe0G+2d+WP/FpnKisvTjyHYHgT7HLbAw9jh4Rxubvu/oNJKYVrTcjUpmTVsHodlT
	 Nbe9XvUPQ+Cxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED327380820D;
	Fri, 25 Sep 2026 18:42:00 +0000 (UTC)
Subject: Re: [GIT PULL for v7.3] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260925-vfs-7.3-rc5.fixes-924ff07b1ab1@brauner>
References: <20260925-vfs-7.3-rc5.fixes-924ff07b1ab1@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260925-vfs-7.3-rc5.fixes-924ff07b1ab1@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc5.fixes
X-PR-Tracked-Commit-Id: b78b728e21c32ec4c330b299f657fb1eb02dffc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa98230e410f0ed212b6788c46b1e4d49e0ff7ca
Message-Id: <179036171975.3089752.62649188230061000.pr-tracker-bot@kernel.org>
Date: Fri, 25 Sep 2026 18:41:59 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Sep 2026 18:19:27 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc5.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa98230e410f0ed212b6788c46b1e4d49e0ff7ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
