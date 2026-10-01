Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641B47ACC7;
	Thu,  1 Oct 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871915; cv=none; b=CeD0KoEW9nH6K5tBntDgjfaHvFzJPE6CTC66+TKsnAhtl12MELUk/GojODuqWWW5algSgjXo+z3A542EuflR84HZphKvMdGLZ2g7QYjWuHOqrvq1JhWGG0XFj1kvI4VgmNXcFg3JKsE0hT49zISuU6QnyuvpMFdkjPPs4rOOwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871915; c=relaxed/simple;
	bh=rlTJ46EROrZ4xietEu9Z8CmWYkfcDC9Jq+dW2xpIcX0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TY/Voorh9CvFtc7mIcYx73HVpjj56e6apx4j6XBTGNhR9nJjOnyURgL4P5LJlEvHOtSRV0oHL5EsL+b+x66qSOZIoYqBQoEezXk4Em9Bchx3aMxaZZ8wwm+8Vjiteo1LOw5wZmpRwkVuAsR2kabOjD3VwPCvHSpwp6HLH0T4wek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYI09KC6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYI09KC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817171F000FF;
	Thu,  1 Oct 2026 16:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871913;
	bh=CQLxvvuWx9rMkMpSoIifRp028zcT7mznbgcGPimVrE0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=aYI09KC66XbQ4DCcWEU6IMvmG9YogAqTYtTrFGcPM2LCzu1voLDKFWLE9qOI5n5Wa
	 ily2oIlKS0hTozWZnPi52AnR+GMQNlf4R0jpsU2eqewh1FeHcu2vEgQ37DVO1GhhnX
	 m8zsmiCLzdhg9tB/1fVeVTWUI44gKW+ohxMn/ttUBnFTIMujIYxK3oaF2IfyRss/xH
	 w6LYYS3NQ7uTVq/EgD1RXLPy1mbJJoZ8OeUbMaET8L1lPKB5gKQ9WWVvBBgewbV39X
	 X+71jbl+MPTlall/qm5hlVsgHWUZ9OUR2RKEF4cxvszQWXs7Ok1fUPrZh3l2FL2WKu
	 Dqxt+oc362yJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774F83811960;
	Thu,  1 Oct 2026 16:25:13 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl fixes for v7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <zcnee7kd4z7ncgccbh4cpmwoj4pbdvrscjl4chey7c4oczzgwg@fy3tb5yzdkii>
References: <zcnee7kd4z7ncgccbh4cpmwoj4pbdvrscjl4chey7c4oczzgwg@fy3tb5yzdkii>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <zcnee7kd4z7ncgccbh4cpmwoj4pbdvrscjl4chey7c4oczzgwg@fy3tb5yzdkii>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.03-fixes-rc6
X-PR-Tracked-Commit-Id: fdd6553e1e53b0421d89c7469c8a36d2eadb1115
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 703033e2350c8c9fcacd652f36675e1327221b10
Message-Id: <179087191191.2557118.9581052031359485915.pr-tracker-bot@kernel.org>
Date: Thu, 01 Oct 2026 16:25:11 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Bradley Morgan <brads@mainlining.org>, Kees Cook <kees@kernel.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 Oct 2026 13:38:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.03-fixes-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/703033e2350c8c9fcacd652f36675e1327221b10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
