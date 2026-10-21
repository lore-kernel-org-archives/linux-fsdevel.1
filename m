Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550268;
	b=xRk+umjwVj3oRbXzO+Kl+w9yg/FtbGdKjPlQfJs21+pN+242OzMWNCUnTI0JIT5nByWG
	 it+mcO7vzUexHQIqkWSERXrWdIdehZz8SpEK+lg9lS0ulfX0v0POLfAI2L8tuj2ZZ19GP
	 mOdQhRGitXS9rKvH795wb1RS2g5e4aH0w5vG0oa837yhODDq8KT1IGeDa37b+rdYKJeyo
	 DDQyXaulhc668l9OpIECSyxW8ZhzLpB1ruxKmpK6qsYhA5fzFqBG0g7VG6rQ2ieGN9BXJ
	 rCjCld57kXVtdjFWGSMeVGWarDcShRneWK4pw8L2WsqIX8oWwkcEPwyDW2pTPlZ2E6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550268;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=tmKwhz5nhSePOpHItD/dk/zdNqEuupgj6nHTXS50p4M=;
	b=4TE6pQsotUqmYe/5HuUTXBa/jvBFepBaQQOJOEkQDzr7YH0ygpGnbPlGPgbr0ZWe9syZ
	 ZHuzM4hclMJ+/MicbUwD/C36jP5s32K+H9zr7Yu4Jzf8vjl8+S0lEPaVn0h6Z7wEazF5U
	 ejayTZq4ItoG03eVH8UyqIeZi2nCyPyqYkYcjKeW0/IHkWvKGGQ78rbjDwsOjaoyv6Qkb
	 nL1lCXFZEeWpjtzPTBv+A6OiQ+mwB4+qIpCAScCRboSZmVukJ+pp6qxijxGARH+e9w7Xl
	 6sYginNYeSHH3k+q4BrhqcGfcnPjjp/rf7chPk8vO+xeUyybk3qwGyTuLeazcY5S65Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCwo26H5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D26606A319
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCwo26H5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0597C1F000CA;
	Wed, 21 Oct 2026 02:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550268;
	bh=tmKwhz5nhSePOpHItD/dk/zdNqEuupgj6nHTXS50p4M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kCwo26H5R907MMvOq/dVvckn3wwwrfQmqcu/+jyS7unpueTx0GoHGPXynsk71s2z0
	 dNXCsAzm4yJpsUUkh0Bq7BsrumGf6TZx+OTK/5wN5WW1C9KlUgsn2oSq53lXho6/kc
	 CkpIe93pqeKMLRX+/J7SecmugMiynoCCJ5MEduyUOzmh0KHg9Y8I4AaMcXfSckBCqZ
	 5lPNbfaaq3AKBVLAL25X/VewWzhpIzG6trBYjg93SJgcTI/oVQiafAdNaNqjl5/wzU
	 MwWI7s4+2F41IF0xmv/bPu55YwKwgfbS5wfVuRtypthvkswz+y5ayOPHMy02mN1V0/
	 c6QbTFXUUBS3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13133809A18;
	Wed, 21 Oct 2026 02:37:47 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <2zkvzrlxlbtreayny7ljhyy2jjny2mbpruz3j4dgjvxhq2ntkp@q6vb2gwvyf6z>
References: <2zkvzrlxlbtreayny7ljhyy2jjny2mbpruz3j4dgjvxhq2ntkp@q6vb2gwvyf6z>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2zkvzrlxlbtreayny7ljhyy2jjny2mbpruz3j4dgjvxhq2ntkp@q6vb2gwvyf6z>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.4-rc1
X-PR-Tracked-Commit-Id: ff05910cb1b77c2b229c5e6e260c6173a17b579b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fefd797c4135f183f87cde5ed4ad7974af087143
Message-Id: <179255026668.339009.3465595535442511268.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 02:37:46 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 14:15:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fefd797c4135f183f87cde5ed4ad7974af087143

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
