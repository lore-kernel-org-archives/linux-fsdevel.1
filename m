Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7CB39020C;
	Mon, 13 Apr 2026 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120545; cv=none; b=OwQttnyRaY06lCbtoyPjdNgel/riFmdO1W9D1tkG6lGwl8rthZlHaV3eByRgSCd8pMX6M3qlH9p5LQMTg2y6/ciK2FCtHBfJdh3U0WSOyYeE4Bnzhu35xiu2tAxLsYW0TVvZRgttQOWCkqGaW/bnYnPCskZhdS6f4zqd+iN59SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120545; c=relaxed/simple;
	bh=PwwTXcEG+DKHFU9WJKs/N1ETsYYR9wydmfXmDA71Zjs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WfSnNcoHD7/9EPXAI+Pbhq7i4HEsRWERcvHoWpGZB2so8m6hERKEkZsc4aHM4yzLZr8LwTB+kxD84e71CDjPTRtegIVxh4cE30dLpWRTQYcNtXf1Gk0wvhW7M1IiOBHDUmGnAeq5oD6VpJU+rnu5hMMUUXMUuAFHVtHOTzxH4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNqMCqOq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNqMCqOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F6BC2BCAF;
	Mon, 13 Apr 2026 22:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120545;
	bh=PwwTXcEG+DKHFU9WJKs/N1ETsYYR9wydmfXmDA71Zjs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KNqMCqOq0HarJx1yN2wkS5cr5LOmdAoyF4RkjLw/GTwRv5G7KGmK6Zifs+WcBaUzo
	 4hu+R75KJNha3ztbMWJ5KOX3/mkmK7Jh7/Y/SXTDSS5p/HUkDnUwxmDDNo8oQRn36w
	 AByKXTAMwiebDau5mYXpZ6z09EkUml75yJgT/R3y1dvrNzLQ5ClguI5rrAR+/ZysWG
	 naoEnNAMuLH/hDuYCyOgZ7IDnlCj/X/ehP+g5ekISbKCrrivHS424Ck8/fwHwnbY6z
	 Fk1SzBMkKSVxYFSolW/SvR6iSTaS22TU9RTrWQYUKziR3zQtkWOLFKI7ueUWgp/Dkq
	 p7HnmiMP3kAIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BF63809A0B;
	Mon, 13 Apr 2026 22:48:38 +0000 (UTC)
Subject: Re: [GIT PULL 07/12 for v7.1] vfs fat
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-vfs-fat-v71-5d175366d729@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-fat-v71-5d175366d729@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-vfs-fat-v71-5d175366d729@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.fat
X-PR-Tracked-Commit-Id: 94505767bd32f8a240cf3590776b16a12d75d98e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2802f9407299c8e17bb8e1311e2ea7816f550649
Message-Id: <177612051668.584243.9947221185313791655.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 22:48:36 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:19:02 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.fat

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2802f9407299c8e17bb8e1311e2ea7816f550649

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
