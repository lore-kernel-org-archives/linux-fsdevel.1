Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F8B3EB7EC;
	Thu,  5 Mar 2026 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740531; cv=none; b=AtAbEMAHPZvgt/Ty6R43iHf6znkuGkZOrXZJ45acEcpsSQP0rAcsj7ID9sVwQoTxGdL+9fdZaQRQfVwiTpWEndEIGrloWo7ZrT8X14FbpZeOObpWqlmM0xM6Ojyi5W6E8ZQsvuoDhJ8Q7v57DCoOl4LAe/RJEoUjfoDf8tbQXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740531; c=relaxed/simple;
	bh=LcQ2kxwzgtWbhnhUMOXfV3qvvpnSV5lcvwwFoqdlAU0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ebOJPl1HMbhbU6pBVr0Or6FGgpqUCWKTKcKo0trfa28sgVLYr0uZCWVNyuBlbqUzJYvh6J1j8Mrgc3rXsum6ggEULdi0+LlqxSLiWv1Ow/ByRalu7Cs9nmga+Dj1B9MdPT3pfy0f+YL6/RLiBe/1UUQvziAt8U/NrGTxr2fYWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os9xwbgI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os9xwbgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71079C116C6;
	Thu,  5 Mar 2026 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772740531;
	bh=LcQ2kxwzgtWbhnhUMOXfV3qvvpnSV5lcvwwFoqdlAU0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=os9xwbgIMoQz5MQ6mWgHxFZ8W2U83BTBJyFSYjZOPsqHWpk8uHsN5OLg7sG9MGd3l
	 y35rm/XYFyzWLmgW10TJ9d5bAxRR6NaML6/jPchOmBx5gO/xOjkjiLrUES/FTjslOL
	 Q6S7C1PpeZzd52C0z1J+wnUbWZy/Aq5zt9hiFQ2jDRVV/5Kbse3paIJN0BQ8HXcej0
	 trhl8Cs0jq1L9dP1XofXto+kvmz4YpCSGyAblxrAprZfzBwE+WtnltN2+zqV5BHihF
	 1adBtRJrf1sECY+Q5BuuUJeAWOJvNBdPDGWvzNuAg/BBd5RwhTSR+2KfgkypVD/MK4
	 QrPGZQp6DsVTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 92FB63808200;
	Thu,  5 Mar 2026 19:55:32 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity fix for v7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260305184554.GB2796@quark>
References: <20260305184554.GB2796@quark>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260305184554.GB2796@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: a300000233a9ff842e2fb450fb9a79f7827a586d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
Message-Id: <177274053123.3268027.3718445977387287066.pr-tracker-bot@kernel.org>
Date: Thu, 05 Mar 2026 19:55:31 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 5 Mar 2026 10:45:54 -0800:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ee8dbf54602dc340d6235b1d6aa17c0f283f48c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
