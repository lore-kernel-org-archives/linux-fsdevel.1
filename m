Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADF351C36
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808649; cv=none; b=cM+d8LokkZ99iEzkqWsfa5NXd+O7i5m9xbvIurjY7QQRpckBZyelSa0Jz8wZ63uStwkIpuo9+5PMUcbJQRbWuJY/GvBICzMcoZ5rm4zmg6N0mKk8yn6+5vMi9BA7A32uRsPt0+yy7HRdAD5b7/nM/chESdHOlZia/kzM1pzgab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808649; c=relaxed/simple;
	bh=yorBw+h7bGf4uOHQEM1NX7UAbAm6990vYHcVuaxNQ6M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ri/fHa1vcX93+F4AkP2lyDKjKmcEelSqspyTAPQe05mCthmkP/NrPt6J1dM3cSIijE2jF91nux9Lw9YOhmvxRQUf9t+ynW+e41Tq4vq+szcTXTzGc3C6ro10ldeYBexbcozKfjQE4Gc9bv/eyRL8drzQUAoGA7gwTzG0FNPWyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdKdlsGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdKdlsGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840CDC2BCB0;
	Tue, 21 Apr 2026 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776808649;
	bh=yorBw+h7bGf4uOHQEM1NX7UAbAm6990vYHcVuaxNQ6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BdKdlsGySKwEU66WB80jgOuicH05xCMVCEfHqQ63XkB+s0Jx6hpKdkEeuzEQ1djXb
	 lFTqyUgzz0ptfm0VbIxXUefwb5IcO1qMvDhMFuvNT90T/PzgrZ6iCDZ3Y3gt48BMg2
	 s0TNw658UkCnwcgEvWfVO6rXyYBtqs2CpQm5og+kA6JxTZLkq2y39Wj1MBALJoaNcB
	 wBC/DFahxGkFuskBnhITROYeSQdT63HAuoRO28+KSIYCcrSto4o2nz/E8i46qjNG9e
	 wcKmQOBqaQv4qF0yMnlZuShc4XRambPAuMfuHOPSVad+Azh4p36aAeQr5BRPljmIM8
	 GE3RQ1GvyEfjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D73393020A;
	Tue, 21 Apr 2026 21:56:54 +0000 (UTC)
Subject: Re: [git pull] coda dcache-related cleanups and fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260421200636.GE3518998@ZenIV>
References: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>
 <20260407220427.326lgx22n4jgsy6b@cs.cmu.edu> <20260421200636.GE3518998@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260421200636.GE3518998@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-coda
X-PR-Tracked-Commit-Id: e252ed8988578f01da5a4f5aa4c2269f96f03951
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c94faa7cc414698d7c32cd43b7d02f34709a71f6
Message-Id: <177680861253.3017017.4454653112868723249.pr-tracker-bot@kernel.org>
Date: Tue, 21 Apr 2026 21:56:52 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jan Harkes <jaharkes@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Apr 2026 21:06:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-coda

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c94faa7cc414698d7c32cd43b7d02f34709a71f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
