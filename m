Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D03D1AB5;
	Tue, 25 Aug 2026 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687473; cv=none; b=khhi9MjYmRwuytvy92UQhdPvBcC0s2+aGtDFkx1hVreq0VyQAATHJbWfYgGmWL/5bCYsAnpf44GaGBSI/yfO1s/sp0Bab5YU3pulQO+ySv9rv9DplOS7YePcc34cSPNEFVypTOsJwuwBqtyF8Ah6gERaTomi1pwwwOxKRBb0a/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687473; c=relaxed/simple;
	bh=1po/+kNei+i/8rW3nNDhJqQz47FxTgMbnYrsxWLSJfQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PmU5CrjtCU+hhKSgK7hqIcN8cADJksMIc73tWiKVjIkylrWgfmT20ed7fZ6WtLNPxuMschxfrEaedU4vgBINCnvAWALlDR8nkgwc1k8kgV6ClfBkxBJ97Y55HK3e3F7svIW7cAlkr9OdJrHW9J9YFO06UP/foe90p6W/76vGGm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKczK+6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKczK+6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B571F00ACF;
	Tue, 25 Aug 2026 19:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687464;
	bh=9wcoQ2o5iE9tULrEpCjrK0LQ8wDDSvEASDtgVeFGU8I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OKczK+6LH+Tv5KEQ3GdmW8egTHV0Xnr3RjsrUH/HGFT5g1izkefw6EzJPLSfUCF6V
	 NozRx6MmNH2I/7CWtoWz3vtos8ktvK5fJ5Sv9zkq4YgixaizHd3mjhBGMI3AUIr7JL
	 fvChR/JsIsLqIrT5HrGGLiVcu/pluA0n4L0AoxsYq5+3Ux5a/oSDnnZcsP8JprWp7J
	 KsC7quvEyKW8VLv/7DMDKrON6gqMRdwJkdEm/sNupx8C7M4wGbpUKUS6avlbPoERjT
	 VS8MP9QQ9WLsqqcMUJya4CNg1bXeSRjYu7tYWL9tfYfm0HaP2MZ9bZQzbwrLan0rAF
	 Eou55G8bDfojA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9394539253CD;
	Tue, 25 Aug 2026 19:50:12 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegu_5Sfbbi36ss3_4k_3Va+RSbnHxRbCUxWoTRcraQ07cw@mail.gmail.com>
References: <CAJfpegu_5Sfbbi36ss3_4k_3Va+RSbnHxRbCUxWoTRcraQ07cw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegu_5Sfbbi36ss3_4k_3Va+RSbnHxRbCUxWoTRcraQ07cw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-7.3
X-PR-Tracked-Commit-Id: 34b5c4a6e4fb9dbb3f9d87f3b0fb0372105c8302
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cebfe6504488198b012e746bc6b313f88b95439
Message-Id: <178768741134.4034242.688092249380170922.pr-tracker-bot@kernel.org>
Date: Tue, 25 Aug 2026 19:50:11 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, fuse-devel <fuse-devel@lists.linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Aug 2026 11:40:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cebfe6504488198b012e746bc6b313f88b95439

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
