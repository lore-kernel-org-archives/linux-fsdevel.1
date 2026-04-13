Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C436346AD7;
	Mon, 13 Apr 2026 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120547; cv=none; b=SLKu0UF+2Ph19fCp4NedWjCITzkoF0YKlk9vvVDxjPkddrrp2DE9crlKYfRFrtVCLnyjFULeeUageWrt6JL4NFOyHzUx+KD4L5YoX34bx8Yd7PbwSdEdPCuVQ8w9AoIq4O2sSEpjr7RovWOgrAd/9SF3orlI1TZSyp+o8U1oQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120547; c=relaxed/simple;
	bh=cnz/FGfpwFeBYwQXxbQO+ITzL76XQo2BW6mMbcesIyY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DQhLx5XkIHz3LeK/ThWASrr5O/KWSe7gXhAqK7BiQf4g4NWULwRlSlwvXZlARsdmXa94JvjewE880p95eTWrNcyTU1WnM0O5QBkhL7NvNZyuh/BjTJIOuIluE3cFT4krqDUcIcRrDKNl6OAuP/sQfrbNwuQIxroUQYuT7YZr4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snM5huzI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snM5huzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E04C2BCB5;
	Mon, 13 Apr 2026 22:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120547;
	bh=cnz/FGfpwFeBYwQXxbQO+ITzL76XQo2BW6mMbcesIyY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=snM5huzI1k72seDLzMI83F7Sk98/UcJ/XWhYSZXHWdMRE126w7HfQFhOfEZn8CiF8
	 QItHUSjLE16jVpGoxJMSc1sgk6dhIdVZhDL7rqbpS6SKBGfMKKbR8HLteM0E0VVg7N
	 J1ii6C549PfTvyex6Du43rBfakFcVBhieISXLQjzGqdSUzDkorF7yRwmJUkWwvOEeB
	 EAJHUX3rshHY1qbmJ5HGyOnenlYeQc4SSsUYFVDe/GG5ZdRHAHfVLSKruZSo3rK4zC
	 RoAm1aLA1lvcc3pcR3aTYkFD5Hc4RI1Xvve6BDJewHh284BNlrH7/RJisN0vaKdr6Q
	 Q/EWEVgtaEBeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE003809A0B;
	Mon, 13 Apr 2026 22:48:39 +0000 (UTC)
Subject: Re: [GIT PULL 08/12 for v7.1] vfs bh metadata
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-vfs-bh-metadata-v71-f0c1c7c747fc@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-bh-metadata-v71-f0c1c7c747fc@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-vfs-bh-metadata-v71-f0c1c7c747fc@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.bh.metadata
X-PR-Tracked-Commit-Id: 6e22726900ea54d72cbc6f053c0fa581de023de6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc825e513cd494cfcbeb47acf5738fe64f3a9051
Message-Id: <177612051818.584243.10721698181443029957.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 22:48:38 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:19:24 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.bh.metadata

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc825e513cd494cfcbeb47acf5738fe64f3a9051

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
