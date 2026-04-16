Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12B272803
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308019; cv=none; b=Xl0GFbNHmP00U6U8Qtk5U8APykGIHTunM9mRrVEc5NKEOwQcKT9+JEzPmYzj20xW8hb9FRwrZOj2TJp1dKkA/LzvPRPYQz0iS3N/YUXLzqtsR/LC++1NTbmB39Urdf22C/+CN0qLh5H2wsBciRt9H/xVodiX5oCdl3Bljtuf3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308019; c=relaxed/simple;
	bh=PdrranCr68xjJ+Xp1fPSsV15WsIKA+vOUjX7UMH+J2Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TbRP77uHCzNNCGeG6F5urVyhVp/5p9jRIXDc8rwJobQmTVC+bDMFWI0bWzunZDG4BE2FYIvsC1+2P33snRX5h2e/5VIVC5tDkW1215Z6lPyrptNkERviElFwbAh+dbMcabkaj5p9tRjMCYBnRHD/CJDXnojuPvAHjyHQHV3GJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdyhTv4S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdyhTv4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3035FC19424;
	Thu, 16 Apr 2026 02:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776308019;
	bh=PdrranCr68xjJ+Xp1fPSsV15WsIKA+vOUjX7UMH+J2Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qdyhTv4SN7TyufjnYuNvBf7HusL6LTtJtwWuQVQdsQq9pbThpdYyOtvzfn9f2TVC9
	 YEYIudp+N/ACT+g+dUcN0mUhN0pgg+DhEXisjaNv099tmrYHg1a3EMALmI1oiuCJZo
	 P3XilV9aOhQxcHPkC2W3uGYz9Dgkw5POcXuzo4j3YzYp5ngN6pkM1+kxkSGS1ne/V1
	 bAQq0lVjkTrvBhIWQ3lFtjRsEKTGt4tX++MvhHvNpUUL5m4cYAIXXtztDlXda8UiEd
	 fM87rncLcg9fF3deC7EMWzd4Lis1JLg23dPH9F1lMe0mkNdhqsNZoPHRERY5EnPBkP
	 dPychGZMlP/HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCF8380A964;
	Thu, 16 Apr 2026 02:53:09 +0000 (UTC)
Subject: Re: [GIT PULL] ext2, udf, quota cleanups and fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <mymqle4yeuajzhwek6wmu5cwc7pezn26essmzhra3qxzcbdbnr@z265eiwpzcui>
References: <mymqle4yeuajzhwek6wmu5cwc7pezn26essmzhra3qxzcbdbnr@z265eiwpzcui>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mymqle4yeuajzhwek6wmu5cwc7pezn26essmzhra3qxzcbdbnr@z265eiwpzcui>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.1-rc1
X-PR-Tracked-Commit-Id: 25947cc5b2374cd5bf627fe3141496444260d04f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5414f3fd54b3a3f7f63f3edd276fb55281ecbe3b
Message-Id: <177630798798.2583492.13051459737267551916.pr-tracker-bot@kernel.org>
Date: Thu, 16 Apr 2026 02:53:07 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 Apr 2026 12:26:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5414f3fd54b3a3f7f63f3edd276fb55281ecbe3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
