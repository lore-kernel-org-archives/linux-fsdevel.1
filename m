Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99632501F57;
	Fri,  9 Oct 2026 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583406; cv=none; b=fXZ8Q5BzQVt++DPuXLu4CMTByv1wCgH8sSHjKYOQ2Onz/Il2nGWmBXbRFN7TebB3qZKfr+s8vl1NVBahlzSbVI0gP4Krg32inBQEKq8oc8tBLd/FuFyKidyzcRA0CNNGORIXoKwRJA4J9GTNeJvq/hp98UffgJ8p/aBEako36ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583406; c=relaxed/simple;
	bh=kXufDxA3HXPWuJInknyLFFdYa+7l/UP6MPV8cZ6zclo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CsFbFC5IjFf1BDeaiQCI+0aooNOxztXm7ppxxFdcx7GjEb7rNR6TqDPvacbNwV6+Tv12GerBzkvtzK53LYv8BGWLrT3HTf4RB/oEJ/YsJh4g7bzDAdip3aL+Ac1QzIDcB8wPtLOizpBpGeyrmewPa6xukK8mlGHlZpAd36240q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHGLvhx8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHGLvhx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B411F000FF;
	Fri,  9 Oct 2026 22:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791583405;
	bh=YpFCihEmlN8bJzQxMyCIJJqU/0KsYb4SVarash7i2H8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DHGLvhx8MWrGFZLIIo4vvW7q6v0IcbviABf2nrZEOwacZX/PeKGNK5ic1JNIUi8d5
	 PNKHtTLOZuF5YR2jvDeibQM29xqNnZJLXCRjCUoykrhHfxjhjaaf6FWXbggUjzc27E
	 Za5E0tnU8/hh4+a1buCe58estBe9xsLs2GW9/aIUiL0hc8ixMArBTL/byMfbryYrnf
	 2UCb+WZi8h3G6jYZZ4aOO0oaOvFYJZ4Z6FmSbLV/Ev0QIV5mLKvHNg459ALFLkzzMN
	 JMbD5xeMt1j4/MFn9zIVc1bp66/urO6YkIjaSIVlBjCQGoj81YLez+i1gUMTs1cOCc
	 yFlcxH/6zaZVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775F23926392;
	Fri,  9 Oct 2026 22:03:25 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity fix for v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261009142040.GB321175@quark>
References: <20261009142040.GB321175@quark>
X-PR-Tracked-List-Id: <fsverity.lists.linux.dev>
X-PR-Tracked-Message-Id: <20261009142040.GB321175@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: e58c3805ed325fe2d4ae2dd467c0486cc860b733
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc1c25014ff8e416d75e8a5ba3b9c0ba5eb8e877
Message-Id: <179158340414.1020838.2508856120285420906.pr-tracker-bot@kernel.org>
Date: Fri, 09 Oct 2026 22:03:24 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Oct 2026 16:20:40 +0200:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc1c25014ff8e416d75e8a5ba3b9c0ba5eb8e877

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
