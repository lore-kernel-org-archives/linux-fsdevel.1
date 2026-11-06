Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987030;
	b=mPszmIdfCNURgM9dQEzIrqPC+emczQIGPp5yen3QNGrgpdGUdXRVheEsmofkQDzOO2gn
	 KVdk/0/YqqBJ53iWZcrVJkQKy1pnJueO0vO/CPxf78HeGN7/vlBdfQ2wR8E2l00PdCTS2
	 v4iTpkkmrNlxOlx2gMfF4ANlQuvVlyoBU5H5EV6RcZBjDzMQhNwQ6J/sRssWevQsH5g9S
	 gapgU2PZX+Swxvayz7ZHFA2iRUtVQZdB6X/+1vEGTtM8U5By6fc5r9vfQQ03vpmMsa7Tl
	 fgG1p4M+0GJqpx+MR7Akgw5pA6XLsHP6YEaA5NXCQgAswJp1xmGStc14p6LqKK/DWjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987030;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=AXAM2/e9bh9AaYTKxg7gkf9rzoz+ND0EOeYb5D3PtYE=;
	b=09/gG8XwzmnPpzsOFhYkPMO150hSLxWJ8x+OuKFY29vCcH3u0aOe0V8ai/ZlzDOO92Vw
	 taZiKGzNlVU8UAsjIHXa3MBHulV9RJae4pdnuIyTrpz22fhY/qoQP3ksmgbClXZ6dj8no
	 sw1N14gl/ePSRVbCXbZTE//aUTBy35RC4OJhBgcLrnP5U5fmKnfregcX1EcYvCrvo4HOg
	 wAlRFDd1wgb+6TRXQ8bmMhpAuOVjCsOntF0qEXfzCSqmiGKg+Yh0T7ppB9JZM2Hd/5a2z
	 DJN0vMdWbfefmcZK6Dz5ljRVjW+LaM22ct25N6g5qnRHntyhzhd+EdQ2pRlFX1dDWBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmxmm8Gr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C473606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmxmm8Gr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FE91F008BC;
	Fri,  6 Nov 2026 17:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987030;
	bh=AXAM2/e9bh9AaYTKxg7gkf9rzoz+ND0EOeYb5D3PtYE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=lmxmm8GrOHxP5+fJcQrWbE+IFQkrZBwWWWz5tXv/qeWP5Bm9Lp19xx2zGYXDi8QYQ
	 pSjLeKudpTVV/gt84+Tyndr6Cs9u3xCoB/nPfO8R/s+lf6O6vBaqfhem3Utod2tTzp
	 QipFMoAM1LpGjMauRwW+wklsPsNSyyfGz6/SKF0xYXY0JZ0KwTlNF5td8/aosKLq+5
	 0ADYm4tOVtNCWaYG3/xM1RJzUmtzzyHpXMv7+EjvjsSREz8FuFpW0qW32XuH7PkPPR
	 NgztAAHK+Z3DL2janFCKXMpzBKBksa7nHB1lM5M4aKRdsosGgSuW+YHwNM9MKkRan3
	 3e4kLjFRX1Ing==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20FED3A41005;
	Fri,  6 Nov 2026 17:43:50 +0000 (UTC)
Subject: Re: [GIT PULL] udf, ext2, isofs and quota fixes for 7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <mlorvbdtnqywaghslq472ylg7yckewhbu4fk5mhaq6gwyp43to@ppnfgyl6xezl>
References: <mlorvbdtnqywaghslq472ylg7yckewhbu4fk5mhaq6gwyp43to@ppnfgyl6xezl>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mlorvbdtnqywaghslq472ylg7yckewhbu4fk5mhaq6gwyp43to@ppnfgyl6xezl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.4-rc2
X-PR-Tracked-Commit-Id: e5801273f93eb7513850b1c38ea14d69f2de1592
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b556f1c4dc9fa538bb3b27c0b9710e62baca692f
Message-Id: <179398702861.773298.12402328290039041925.pr-tracker-bot@kernel.org>
Date: Fri, 06 Nov 2026 17:43:48 +0000
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

The pull request you sent on Fri, 6 Nov 2026 16:15:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b556f1c4dc9fa538bb3b27c0b9710e62baca692f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
