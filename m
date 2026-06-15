Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3FB305662;
	Mon, 15 Jun 2026 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495129; cv=none; b=Flu3WDjgazVMwJRQ1X4P+Kte8zBKZji+B/OIEiA/uG/xK8JKRv4ydqvwR3AZdKrUaJdEaW3enYLUuvNr2OAp5XYMTzNOSyLiAgRdAfmi9APaUPTme1M34jJIBrmm+9/WKgdikHsDEHTlZsZ5hOl9P8lHsVP3GGupXuDJPKBUaN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495129; c=relaxed/simple;
	bh=wCKjdZh009SZuyLTLADpwsJAPnvLrjjvG5j6kPc1S0g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n1ITOYIbs3vd4tEL5lRkic6bv9/JRfX2FSVWtmM/ZdJtZQDjpZymUeRmtUzWyYC2RNPzdO6OCv7cqX++7TyMrpLHiOb3zcztTWfL8U9siFqByiMAIa8+9GlP4tSOsZfhE7CGX2EgXKJNF9BXn4UGV5FRYDNKD9mNzdW9F3/1YB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foaS9TGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foaS9TGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CE51F000E9;
	Mon, 15 Jun 2026 03:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495127;
	bh=LsiUXq+m6qpThUtZBzBc5ZugKz65O9lc5Ltomr9WGm8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=foaS9TGBPhWuIuoul3bkpe6ItmWiSpTjOsXH4oLJOlUj6/EMM4p08mL8WYqYzJQXb
	 gvSzqqq3Hcv6xqtVvxTT5l4t+2cpPXsOOsEk1KkC422tAU6kAkP+RbuMhHItQEgcLm
	 6A5Y+1iLhoZoEE0qwU6/Ro8rLcfcX9jjvqnO9bqLTyQFACJAER9G/pWke9VHrZqck0
	 UCSTky4XGJxl5n5zZO7DojRO5k2jdsWVu/pz+wAVnMfoTB7SujB7prROS00SmMTCII
	 Y8DAz70uIHhxkH2q4Bq6mg318VQ5m4K2/pogIpBmcRbQD9scv3/J53uiG7hcFyZsFf
	 DJMpIGlXDpwYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939113A566D6;
	Mon, 15 Jun 2026 03:45:24 +0000 (UTC)
Subject: Re: [GIT PULL 09/16 for v7.2] vfs super
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-super-v72-18c8e2c8b9b2@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-super-v72-18c8e2c8b9b2@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-super-v72-18c8e2c8b9b2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.super
X-PR-Tracked-Commit-Id: 2c6f0c248a6b49a6fc8c301c84d367860c56ccd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0793d39ec8bab2b2255e3a288894c39e88ce5a75
Message-Id: <178149512323.2410512.16876498247324565985.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:23 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:14:00 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.super

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0793d39ec8bab2b2255e3a288894c39e88ce5a75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
