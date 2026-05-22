Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F74372048
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478744; cv=none; b=QwTAFYv+RsgiGiFk02suvLkHxtd8UUG8/gF8QrQ21XTUv2VV+0jDMQUyxXkKcoPyKwYiySvx0AK7gvftCwz0+9bAEkByfMxv2YxdM8kUUfEmNO63mS+kzyZVih+jM9y8T4VLHVaxtKB4GbZ4YDL0vh0BBWmcrbr2JBbRN6ROOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478744; c=relaxed/simple;
	bh=urU8IyiE4aLG48pFKyyGxGzhtqW7FK6wjUTDQMpAMGI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iYobcUJs6mY3ErxaAV2p73BI+pWvxmhrETQ+pR/4Lu3z1moc+u4uDevOG/8pDHvvFDQqpxH/W79vyNcsIwt6/hHkVh2enNJY0qBPYJF5+AHd6A1DMeh3bUydLRYcDKUeL6nsbzs4n0N14FQdgyN5G0R664v8HE2htlNth9H8KNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dli+Sccj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dli+Sccj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B48A1F000E9;
	Fri, 22 May 2026 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478743;
	bh=OdrVU6oIGimo4VQPvwUveRBMgdAYKcrElunnf8giQvU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Dli+SccjHkFJmb1XthrmXD8h4bK/4D7TqAkaE1azDSvXHrHxtSUKQ8b/qhpT8Mbi/
	 0W45Ma0YvaENgBLLqjJrH2JQ1+8xI2xDDfi1UZT7326NOLFG5dFvbnayPEI9n3o3Gf
	 Q5YcgRPFwvGEmZ3V7d0jGyCUDIiKQCmFUCMDIbXgfBmW2jp6dxfw1wFcPb8nxFXOol
	 BQFvSZAGZ8PKWy6y1x29QXq6PP23j2djdNjrhxoNqm1TVsKFAiGIV0z5IDPrIT4lNc
	 ZnsdFRFcbnIh2tTwrKRjA6gax2sVUkTi0mUjp0L8YJK5OLVFK3uF9OGg1g20bQo2Nd
	 T81F/x6fgAwhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 847A13930FBA;
	Fri, 22 May 2026 19:39:13 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260522080726.529603-1-dlemoal@kernel.org>
References: <20260522080726.529603-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260522080726.529603-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-7.1-rc5
X-PR-Tracked-Commit-Id: 3a8389d42bdf4213730f4067f8bfa78bae6564ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 632360e8f5fce2eee720e952fd84e8cefb5749b6
Message-Id: <177947875228.1341212.11829898917960774131.pr-tracker-bot@kernel.org>
Date: Fri, 22 May 2026 19:39:12 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 May 2026 17:07:26 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-7.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/632360e8f5fce2eee720e952fd84e8cefb5749b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
