Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C53A1A5C;
	Mon, 13 Apr 2026 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120550; cv=none; b=f2LPKbLogrUSfPuV5m1sUf1YYo1Jt+s5iMnfVj1DBzmVGRx/i7qfMQUwKy7Q0WKrxljZ0ccfhxvbUPahnxPqe1XNiEbNYeBbepNSfSnYwGVEBQrC2wG1hHzLL32yQ92sfstlCaakcJUu88GZFT24aeCh88fTHKbZTDxPZGMpbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120550; c=relaxed/simple;
	bh=GcfQpjanD3pcLlf2PmCIkjDLDWcVyYKpJSouXK+4CTo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lCILhd4wg+apqIOGBjPbirCNdBlkeZdDV+fM3kQ7wILZi4thrO0t5FGRxg+i+T+rQy2VhmsGkbMfWQsfypJVU0vQLeVwIIqH5X5Qb9Fu1RZQFZNhK6jLD1wBw5gw+6OpZVdqqmZ1KbbXtBgUfV+189YxuCWBaWlYeeJw9Pyjp2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euMV7fGi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euMV7fGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C6DC2BCAF;
	Mon, 13 Apr 2026 22:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120550;
	bh=GcfQpjanD3pcLlf2PmCIkjDLDWcVyYKpJSouXK+4CTo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=euMV7fGiAPlTLP68C4xjCPA66zVABebAeoucs2rdkBb1+6+83MKouhIB8CC+7LoCt
	 ux4vhX2W5EQW0R+0xUPXG+XW64f5wo4pVHhaeGChWrAA7VWTdGuRrB/vwtvXZjdTbd
	 yzjE6diYdzsLVxU+9txkwGS60kVzQaCSv1g2hFFFGYzQEPO5eNnVpGSU5EPhLv0Rsu
	 mE5QILz48LpIf1Sn5xfsF2alFNZ/KGCTTRfQbFBqKnADWo+k0UD5kNq2HhRqjMhQ88
	 e//yXjhXR6Lqn4Th0g6b0Ocmvc4YiTtJoqshMd1A6S0ggUUQobICOcfuI6LarxeL4A
	 yMV7HUNBNGCbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD7C3809A0B;
	Mon, 13 Apr 2026 22:48:42 +0000 (UTC)
Subject: Re: [GIT PULL 10/12 for v7.1] vfs pidfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-vfs-pidfs-v71-b736f79a20b9@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-pidfs-v71-b736f79a20b9@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-vfs-pidfs-v71-b736f79a20b9@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.pidfs
X-PR-Tracked-Commit-Id: d29eb5f0ce674cfe71b93f8ff67dc0f66e6a9371
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07c3ef58223e2c75ea209d8c416b976ec30d9413
Message-Id: <177612052118.584243.9253017298368329932.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 22:48:41 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:21:05 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.pidfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07c3ef58223e2c75ea209d8c416b976ec30d9413

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
