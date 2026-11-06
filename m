Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987028;
	b=gyi/mgRSNnRxBWu+SJGIHoTOi43T/K9XAvCBXR9NxqTfZemvbhvvzwmVy+yQsBwDmN/5
	 AYoprhKtHYM2MOTIds/1zEsJeMpiYxIuGXewD+ZvGrPs5A+gpLAAnBmTAc9nFwi2U8vM7
	 EC3+PVOxNL8TgQmT7oXoQNDQXyh9jnvgxtcD1+3UcoYPFYrQ+H1nfeQjUTzcJMKZS94WU
	 V/1LXECOMH1c0voFE2/PnXgqDCd4jMaGBQxuLlYrXG8nfqKJ6/RMzxS35JSUrBvaBQbUG
	 zvq4jRTOLPt9tRyzd2OlzRFj9XIgfrRsWoor8/D36uahtOOQ582x7YFrf74U38SsjWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987028;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=29TJnSJ2Q6JU67Und6SVF3UcsZhqWeCb4kkzWH0WjPg=;
	b=PmhDQRH24CLu0inibLhkbpCNRPSP7UzHpWrOIceMdDDRN0CRed/p8L5BLY9emYLPKQ92
	 nlIip06y9n1khscfjgTyehYqXcX2x6XmyB27aAJO+jO7xXL53FoG23U8a2bUL9kRHz+td
	 oXBT4HNkDHP+0WpM6Elv2ftELSnofbDYxUUZaeVEEWqxZ3DfpHBP5polvOZ5cXOmut+MF
	 gaVNq8kKKKUnFvGA13KifGkuEcP9j40TndrRkQXVLutn3DntrsD5n+F7p54gSdOC2zDa5
	 Lo8JhbzSvdES7u2AdyQQXqllUKRMPwpjfybjdF3U62izSmqJs6VlnrfogzuYZx5BgjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5ADoDz7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA1606A329
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5ADoDz7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17EA1F008A5;
	Fri,  6 Nov 2026 17:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987027;
	bh=29TJnSJ2Q6JU67Und6SVF3UcsZhqWeCb4kkzWH0WjPg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=I5ADoDz7bLNDybY+Iu8fneCT/DXnjaGUN+KPacH8j3/RxF8vUUp8VpogXEoUj0vdk
	 JXAy6wc7CZcCfUGuggYFyOXwym4kJmm5u0TZeiZ5HPjG9Goaa0C8DaY55bgPOLim6w
	 z1gn0qbhz04SileOtayxEeQqjP1mk0omnDmWDMr4FNO3+pBR3bE06xRoT/jGwu8WC3
	 chnw3HmmKRhJ9fD6fy5IZPg45gz43jKA5AYfpDobvE+8S0IUaP7Ev1RgxtgtfPiKR9
	 3RBks4ZUZ4PwInc/9aMIBzFxg+IbX5KNoPWnUgTlgvF5Gg41BUO6MqFTdncOXaQ4c7
	 b2CMUQhBaKiug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D82CC3A41005;
	Fri,  6 Nov 2026 17:43:47 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify fixes for 7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <q7drckhsrlj6opkqs2b7kco3ttp46yi6rwhcrrawrnmckqpm4m@4qheazgvbo45>
References: <q7drckhsrlj6opkqs2b7kco3ttp46yi6rwhcrrawrnmckqpm4m@4qheazgvbo45>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <q7drckhsrlj6opkqs2b7kco3ttp46yi6rwhcrrawrnmckqpm4m@4qheazgvbo45>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.4-rc2
X-PR-Tracked-Commit-Id: 581230d2ec3c0380917d1255792508851e7c4627
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb382e8efdd4b89b0dcd0169abd31d90b7ddd570
Message-Id: <179398702631.773298.12466475523022851314.pr-tracker-bot@kernel.org>
Date: Fri, 06 Nov 2026 17:43:46 +0000
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

The pull request you sent on Fri, 6 Nov 2026 16:08:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb382e8efdd4b89b0dcd0169abd31d90b7ddd570

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
