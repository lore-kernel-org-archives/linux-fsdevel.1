Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA982877F7
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923665; cv=none; b=eIOjfGTt/0BtLB6JH94F+DBdFhz60jPesaN/MFjcCkImL65uGFe7pb9qUQmY5uHPAYkOzF8YoIgGELVlFUI/4EayEkHX+in0cpryXxbPUkGbLbOn0++/jbSJjMyelAxcHEp4mE6C083kDHeYRrB8VgA4nIYIVpSe++QPDhlTI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923665; c=relaxed/simple;
	bh=yKDi4meh4Vyiomgk7rSBLR/a3bnnHuQ/zbDI93ww/bw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qfyTDI7DQOQhYDRa5UABZ60gEIHRrgQrWS/8JexcUOO7g9mrVI+Run6GtdBr34TKyKJVON+HhKm8cEHaGw0GKbxeY5ZGXhnjfeYrvs8TLloLhiTgmqVNgpG/fCboxE/zV5ZQTZ9G8rVlqfflrpW+a2Zwe8Kd27z9WDt02gKel5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMmxmxWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMmxmxWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79875C4CEF7;
	Thu, 12 Feb 2026 19:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770923665;
	bh=yKDi4meh4Vyiomgk7rSBLR/a3bnnHuQ/zbDI93ww/bw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bMmxmxWi/ri+wR2l2s7qxkb/VUTyVlt7Vtli62zg7TpAt4RoKkTB3ANunmMMLBWf1
	 qEagEh1Xso97EAZ7O4M4i4GUFzAMZmnh/OLdV0VteRUtyDWoXJom+AbRdx56bJcM0S
	 X86fdQkz3y3WQADjotZzvyZBts0a/BsVwZkDBjd3f2jDxQFayuI5dAz9kLKCu8uaSc
	 xaNGORoqXwU+I/hMcPGrhw7HfJCmgwbQ4IZImDOcez8jbfNH/l6M4AE9ggrarELPBh
	 ceAo8oW/VpNqwJDu3hRNHi5puB/KA+PpU1wfzgJBoQFmINEnMDRF6OIqNRdpdWyABe
	 84J6JjGkPlhuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AF3F3800346;
	Thu, 12 Feb 2026 19:14:21 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 6.20-rc1 (or 7.0-rc1?)
From: pr-tracker-bot@kernel.org
In-Reply-To: <ydxny54jcyo6e2gfnanvdyp3k56orif4gfedumhbf6s2ocges5@m6nvf4awu7vv>
References: <ydxny54jcyo6e2gfnanvdyp3k56orif4gfedumhbf6s2ocges5@m6nvf4awu7vv>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ydxny54jcyo6e2gfnanvdyp3k56orif4gfedumhbf6s2ocges5@m6nvf4awu7vv>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.20-rc1
X-PR-Tracked-Commit-Id: 74bd284537b3447c651588101c32a203e4fe1a32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8ed22870f5304a6ac64f694572cafc12801a9cf
Message-Id: <177092365963.1663336.928582449263803794.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 19:14:19 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Feb 2026 12:50:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8ed22870f5304a6ac64f694572cafc12801a9cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
