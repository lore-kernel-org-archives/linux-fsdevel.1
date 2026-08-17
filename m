Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28073EB80E;
	Mon, 17 Aug 2026 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005591; cv=none; b=Ty6GlU0qaAUtLF3JDH2UcJ6mAe/urzk9kbeoImiQGq12UBDCpc7FEMoVqqhjLaFPAoMUocs0EuCpldS8ZmGgc5YijxL8AdOPYgCnkEapFrKppseamKc7xOxAasXoEmeYtfI2dQXZddrkecAkpNm6I+0bqcFTD/4ztMWELeNCJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005591; c=relaxed/simple;
	bh=fjBvrigGgcfr2bPXYJNmYqW/3Xt307cdPmZ/giFwc28=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RmdejskWFYAiIwfgcb2OeZXJw4zFRjXxNwPnr5ss5YQmW/ECfW1n3nJLY9BP+GTk9DIlCbU115UJpQok+eIRBWeJWtfPMZEejbvvo6QxD4HsncKxCWTt2oopDhVNfkJCCt7wJ/M+/g4oP1krhGRlEPJ/cDee/C8N+DgCj61KhSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1eN9cWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1eN9cWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D021F000E9;
	Mon, 17 Aug 2026 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005590;
	bh=gugiUKmX/XvjJ8DgUB2aWJbkSputwz9eAdHFzYwTOOc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=e1eN9cWGkHpKDm66p9iOw2jWn5G8O+65XiuYVWn/SOMfXokhnAsXilkuAD+2Vyt95
	 iFTlzFom+pkLGVq9Kx0m7L2JRqNaZTBg+1laLbg4MAtgZNcxDVSVXFYmbd9QEIpq5Y
	 7tdcToGnc39xfOUtNxI9VtR+hjtruBORh32l1yTMnx92M3CAJe7gGxxRoji8SCkDqz
	 u/0qttPXzplV3ErR1VSUmDLZMH26BLgtIGJNod9OGIhlyqXJMVmvs3NvXV553Wt+0m
	 DYCwE3F6EwzY+DKzZQki4lklfwyjYtiOH5dtl2P5awS2IiqAmUGpqynU+AlVBsfdsS
	 4bUD0DI5dH7mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938FC3926274;
	Mon, 17 Aug 2026 22:25:43 +0000 (UTC)
Subject: Re: [GIT PULL 08/18 for v7.3] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.iomap-78c92ce13812@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.iomap-78c92ce13812@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.iomap-78c92ce13812@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.iomap
X-PR-Tracked-Commit-Id: 9948bc9aa1c2e5e77ab989a8e5d5eec829e967d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ea8d6197d9f43a15ccb9c0dce601ec535d5da7e
Message-Id: <178700554221.1769471.14684821692170060816.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:42 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:12:24 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ea8d6197d9f43a15ccb9c0dce601ec535d5da7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
