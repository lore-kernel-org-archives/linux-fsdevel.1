Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659EB28469B;
	Fri,  3 Jul 2026 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094128; cv=none; b=o+9H+VWU3dTwyQP1XFWDav01r9ErExRfqXtt/eeva0+y9rzRtjxRPX4cSzjwnp7J4YpvE93OScEUGgROGrLdClzuNOqWngzLWVzz5xorKmjvo2t0k+wid/AcTC9i15kvlh4PZGvSd26CUPIOvL5PJhX5vj6tdqncXYVe3ozJqmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094128; c=relaxed/simple;
	bh=WvEGoZfrrpIounL74xEPpFTz04cSO+xGSo8fLpNFwvM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mQhAomYfkezg+b+iWmiPWSzxEw/RuHkmdxvy5WwCm/sgdGjzyUcGAo8fOtsg1dMKPqzm/sCZ7iBzAl6AvqJcrChX1WzR+LXRTfXlMEbC6w5ch6HHhP9QaLVi3lEAR+nWoNoe5nH8+h0q6zs/2nShHiXs6hcsVe0mFs/VtJs+mtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJTfVQ7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJTfVQ7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1B91F000E9;
	Fri,  3 Jul 2026 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783094127;
	bh=7D2AGfC+s/cr0yZIN39J0ne0MYD3KLWN+TLUxw+9q9Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=IJTfVQ7iKZIDXzrZk+v4LBPx0P6YFE/KZcguy4Va0AfAMS3ld8qUrVXlFFWqeFUh5
	 uW/Sg5E1g4Tz1yzC848+Lmdq4xI0PCIzXzwwK6fiEUp1cPvMqq5mdMCKAveEHtzz8P
	 GQWSrffU410xLqNDbu5gQvGknMAEq64PSaxno7hh9GVxzy76c11A5aLaub9iIeopL1
	 LtyxAedWvgAwvMHbPdF8nYKM5yyx1hrBumWXIQhKg4EElrfvDRNDLnG2lUcMJcknh9
	 YzugHCWLU2IW/EABnGrY0bZFwIdtnHzbCOdk0OMsq5U0BPZjqw2cIgXnIB49x3Opy/
	 Y53UX/Shdm3yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D099A3939347;
	Fri,  3 Jul 2026 15:55:10 +0000 (UTC)
Subject: Re: [GIT PULL for v7.2] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260703-vfs-7.2-rc2.fixes-115a53229423@brauner>
References: <20260703-vfs-7.2-rc2.fixes-115a53229423@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260703-vfs-7.2-rc2.fixes-115a53229423@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc2.fixes
X-PR-Tracked-Commit-Id: 5c6ce05e406520290c1d89da97fb3cd70c09137d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71dfdfb0209b43dfd6f494f84f5548e4cfd18cb5
Message-Id: <178309410937.2776291.3289179489768587307.pr-tracker-bot@kernel.org>
Date: Fri, 03 Jul 2026 15:55:09 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  3 Jul 2026 13:32:02 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc2.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71dfdfb0209b43dfd6f494f84f5548e4cfd18cb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
