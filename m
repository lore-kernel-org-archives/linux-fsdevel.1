Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085703B6C1C
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334049; cv=none; b=GsRGU09LegFg8z0h84tBGHGWN2oXv00OF1E+SwhnIvYcLcpeRmtcBWngD/dFDw08+ANGGhc7J3Ob1OHwKTeBh82BvagtCJKO0PphCTN7v2+FWlw9oBdVjwy7GDPafRZv9mgs4HqcyuU5MTt9v2PsLijKhj3LY4USsVYzAwUEbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334049; c=relaxed/simple;
	bh=kaAEZuLvK1uTPTuwTum4uQeqkYGa3otIMnKTSDe8OL4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S1nKHhy51+JbFDWEWXWrTw/0NEhhCDEAzzN0QfAkw9UPkVMhHUE4EPZzxZPlH5qKJ2cBpHz4cqPHtWwWJNHFe+EqEvK11KSwEdd7nxeq93T59Yqbp7j4Wfix9nnxJwOM6uj6SGw38K7UE5kPuFJZ+L6kEw3/wLwJbqO4kZ/UT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0sjj6YE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0sjj6YE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F2FC2BCB5;
	Mon, 27 Apr 2026 23:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334048;
	bh=kaAEZuLvK1uTPTuwTum4uQeqkYGa3otIMnKTSDe8OL4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P0sjj6YEGty0wPn2WJH2HK9+GBcr7plFOJUyZcZnlkj4A7myH/1q07TdKx7LlNRu7
	 lGMkSJOWf4iC2CtTBmQYXqESr0JqAOEf1Yp/n/tvT0Uts8+QwTXy+MWDa171lszRwn
	 AzuoG8/272CesEKDzD55DiPr+6KO614T3VEGPpYDRGQ29Uy8s++XGYNpren2YqeOJJ
	 MW5w2ad6ALDFMWYhoLuJ/GZC6idlbF3iDUA6Aa+lTmxltKYFvIsoUmlYDneEUHR23s
	 yKOjOJeSKZAMJLA5LW8S7EO/jMidg3LWbJVUBCVdWEW29Fu7bu1/bzZJa2WtYtuCge
	 34AFKuBZcDOhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D13392FFCA;
	Mon, 27 Apr 2026 23:53:27 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify fixes for 7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <fpk463rrvt2yisauvvxmwnsboigqh6rj4wokkee4xkezzdlqvr@nixbnm5cx2ia>
References: <fpk463rrvt2yisauvvxmwnsboigqh6rj4wokkee4xkezzdlqvr@nixbnm5cx2ia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fpk463rrvt2yisauvvxmwnsboigqh6rj4wokkee4xkezzdlqvr@nixbnm5cx2ia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.1-rc2
X-PR-Tracked-Commit-Id: 4aca914ac152f5d055ddcb36704d1e539ac08977
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53b6156308e5ec9f4440e7cd3e84c6d1775167b1
Message-Id: <177733400550.159864.7454415909984014628.pr-tracker-bot@kernel.org>
Date: Mon, 27 Apr 2026 23:53:25 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 27 Apr 2026 17:52:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53b6156308e5ec9f4440e7cd3e84c6d1775167b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
