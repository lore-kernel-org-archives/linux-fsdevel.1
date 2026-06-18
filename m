Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0672773DE;
	Thu, 18 Jun 2026 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799337; cv=none; b=fDv+fTzVh6hYIUclzjUHXbI8TiIQWB4wJtwIPM0HY2NVq8ejzWsRSD07ZKr5thyQAP9EttJfQvQpGGNDjt/LMc1iiW76YIcg5i2j7A2clg39XjGLs+mQGWmc1Bl7e3jm5fUh0TA5bDQLxM0r6Srj34pR7tcD+XpJz2J709Qbc4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799337; c=relaxed/simple;
	bh=WUun8voudBOyQk6nSZcv/uJROxDcWBN4W4sp4ebqy90=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Si0Wzh5cxMoJyQVSxFn0tLb4XQSgUvteVwexF4PK0NC0HGl/11vS83JSIXyxJZ0uPc1yLpFU5YkVmh0vGH0CA9loZmUc1XxWcEIWKKVcuIZpw/AeyPZ/Pc1Az3z/E7hpYlEWwSn6BWUzfBNMq8+OeDFqx9mYzzix+cBf+/mT1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMWp8x+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMWp8x+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1691F000E9;
	Thu, 18 Jun 2026 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781799336;
	bh=9j33WgUIVj/BMTm0ggt7s6Sb37luHltq8YVoDC5W6zE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=hMWp8x+75xlSe9iThwg9uarlsKQNPGTmhj2z2caQnVsVMysOupDs5lCsH39co21n2
	 zGqaCSxRjdFKCV1KifiwULhvW1Dx7PXg5prmL43wy0t/5g0IZT0AdiaWTZSDrgCuXO
	 s699EATZrmvitOw4+bRh008kixgQIazuw5/h9hAZIkM1frTlmMMOHBJ6k4yNtjzFqB
	 pxdm80dkll4FWDEQjonHXPjOU+Dv+lCR5D/UFTfqocwJvFH7fl6PTxpXvnN5EkjG3n
	 GiwBJb3uPvgUlLZfje/Nb0nNbhFOLMYpghVG2z59zs7CMbUc8VwbKns7EKxxOlDk2c
	 37w8MjoouVGpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BF83A566DF;
	Thu, 18 Jun 2026 16:15:30 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegtvWRiFQWzr9eXN5gr6cAwwR_wqqRy4K-nyvg3B7u-vrw@mail.gmail.com>
References: <CAJfpegtvWRiFQWzr9eXN5gr6cAwwR_wqqRy4K-nyvg3B7u-vrw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegtvWRiFQWzr9eXN5gr6cAwwR_wqqRy4K-nyvg3B7u-vrw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-7.2
X-PR-Tracked-Commit-Id: 7d87a5a284bb34edb3f4e7e312ef403b3385a7b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6edc20078ad0b05ab2dc2693965d373628d65f80
Message-Id: <178179932940.2966375.6927709133467172073.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jun 2026 16:15:29 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, fuse-devel <fuse-devel@lists.linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jun 2026 16:23:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6edc20078ad0b05ab2dc2693965d373628d65f80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
