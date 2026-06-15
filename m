Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824823128B6;
	Mon, 15 Jun 2026 03:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495139; cv=none; b=B3qPRebP/BPlSdFFTI/kcCt5yRK7PWxLeS/ZH8Sq49ZSVjlBkjcqKf3ieg+P9NsMJnew5LSGO0SXZBiDghl2H6XLJcCZX8S30ixRc8dFExLCGDgHISAHTYw6PZFkhdGTnXaQS/Jy8QJNnH0PTUbM5c8FG2MEn9u1WNaOPoTAkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495139; c=relaxed/simple;
	bh=l/u5+q5uXjiRzp5qd7lVdemc70jZDJqorvmJ+QXfyWI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kki7vqqxd7HblurzSv2V47lxN2E5Yg6nx6qvbhW2/yrX6tD3Jg1A6C8SKSWnUk1xkqCLX068LoMqaI5ezKaxKCVNWGd/dqFG11S9oF+9zmnBI8Q0/LyE56fP9C1f+Vp5F9nseBH/+I5PPzrbp0OzVEes2F+NaHqFKvh3Zg5M60E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djbXEJVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djbXEJVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FC21F000E9;
	Mon, 15 Jun 2026 03:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495138;
	bh=ZJ1yRH+2YzTqAxGb1MadmmxWQq1eD+5SRmmSYWLT8+M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=djbXEJVFlPCn3muCSXZcYVxlkqF3WfnGC1+TrY13pKGwxvXBALnvzXXFI6UcH+UVA
	 mdlYyn4DsdvPBt9aecMcdbBp6pQoze71UOB6XDZv06bAsmHVucMqC3nZ8pnmAYrAG6
	 Zsk3N7XKDJLjjp2hB3T5TWjOTfjz6jKayYoy8+ecxTHnlwQBTwu4b7OlMZ8DWus/Ho
	 pk2w/R59yJ2IU4hJZf60Symdfd/vkJVOi2zvkhaDgIyGCBoOBiqXIum4pCZ82NmeCb
	 /AQmrsA4Hxnlp0os4qhJCvtKdkyvwedejV0b5XMEGiZYpEl+WzBh7ljJ0kAgivy0bx
	 l3zM8aFaj1qeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197B03A566D6;
	Mon, 15 Jun 2026 03:45:35 +0000 (UTC)
Subject: Re: [GIT PULL 16/16 for v7.2] vfs procfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-procfs-v72-15e0a3b7e3d2@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-procfs-v72-15e0a3b7e3d2@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-procfs-v72-15e0a3b7e3d2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.procfs
X-PR-Tracked-Commit-Id: cf30ceccfaec3d2549ff60f7c915625f12dd3a93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79169a1624253363fed3e9a447b77e50bb226206
Message-Id: <178149513374.2410512.15376774306336034786.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:33 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:16:18 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.procfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79169a1624253363fed3e9a447b77e50bb226206

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
