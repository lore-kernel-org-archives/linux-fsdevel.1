Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E24305692;
	Mon, 15 Jun 2026 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495130; cv=none; b=dMrTwKtQSCTA7lDHynYmWG4HBnSKTGZzgMXq2JwMkGRrzIOT8RYWh1rLvpWT+6J3nE7aGekpj5oOJcYxpBJL6pS/70JH7hf/mFW8ACLjiccPdvlHf117V3lj+gyn5s3gzgJXbhEXVgOPpD6Vk8UC7Nd9iUxZwfvKdtAU+nCtcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495130; c=relaxed/simple;
	bh=YG1IlgJp60n5UjEr/UE2oIo/8kU/rx2va6IafDfzK5I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TYYDQAnfxiXbXqr1FEulJJ6GnU1CPmPdbzlqxYVCpZCHiBQNtm604KYttFE5B7sI1CoKRs20AUEquWhG8kDggB4qsWdvWaSWUIKiMeKEgwAPzC8FDaN//iLFxy7a1IQnYMO9wFZraSjsPYUGnhw9/+H+QMlRUmiTUphfzJjfpUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfEhepm+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfEhepm+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9981F000E9;
	Mon, 15 Jun 2026 03:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495129;
	bh=/1d3YtFN64ila478y1iSfe5Z/KMUsTEAK7KixA0Mr44=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VfEhepm+/gTP6foayxst2cUiqzx4tdUVMeiHR7q637Bzvgfy6FzmIuL6jHlyHMPrA
	 9sTFqzIiXSxjYskww2zJZfNQICDEhwJc6zpeVlZIRgNfwXIldhf8XwiIVFkNC4Z3a6
	 28ItaF5pIHhpxCcTo+xLCWfZao+0oLqtNqSDjP+hC2ldAGTJiLXOxFdDlsGolTgL+Z
	 c12t/jqNZoQ7ks3WXZAFrCYHNATb2WN3exr1SqM1sgwF0b0qhLXk7BDp2oEgm68X0y
	 5xyZXYzbm6iyBVTkD+eNM8JraCqaG0t8H6DH8j+5F3WoMmzJXGCsW0TPch+0Yozzub
	 VyqHncqR0s2HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197713A566D6;
	Mon, 15 Jun 2026 03:45:26 +0000 (UTC)
Subject: Re: [GIT PULL 10/16 for v7.2] vfs writeback
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-writeback-v72-d7ca37da4512@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-writeback-v72-d7ca37da4512@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-writeback-v72-d7ca37da4512@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.writeback
X-PR-Tracked-Commit-Id: 0275dc184aa007b260374af6d46fb15741c062a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c17fdf62aeecbbaf2c2fd5c494e2089c02b0e75b
Message-Id: <178149512473.2410512.7985346384881657597.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:24 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:14:17 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.writeback

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c17fdf62aeecbbaf2c2fd5c494e2089c02b0e75b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
