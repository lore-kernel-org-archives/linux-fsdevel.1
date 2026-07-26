Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041A6377EDF;
	Sun, 26 Jul 2026 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096034; cv=none; b=V4l/9StP43XH+RvRvYpCwu+XkY73ktF2GYZ/1jiq+JGCFxH+/7Nhh7yCsUMiPRy7czhHGws4D4hGtGqG5QTdI7BG/K7kJwlvuNssBhh67xcNG/ahUa4TGX+O5CYKxtSrJGrmKjE6ujmjxGeO70Kb/jbUIxl8HiQD0eg/iOPXT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096034; c=relaxed/simple;
	bh=G3icZVPZSVyIYCaEDaFEllM080QVRQmJGhAfYtHytIY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EEr+KukqeHTecLQ7SZ6QOOrOM7IybyqBhdPkqPptmjQMt+91E5xupv6NzcjBFLcVnpdbiw4rxwBrJ6vXAcqI4KTodwvItQ4KEPmKtS41jzKA38QBXzM5cmCQ7NJAn5hP0UiXfurK5FRRZAkoYkAYsLDiJFyhLp6yTUt0j4uqD74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVmKpiY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVmKpiY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14051F000E9;
	Sun, 26 Jul 2026 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785096032;
	bh=6WYFI1gRvLWllIH53QnjOrGJ/nwADA058kyavVag2/Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=XVmKpiY1t2Pwf71YpFiQgEAY6Ro1OWW9CWoPxAKRcVA5bjaFMC4BS0sTcDFL2A2D6
	 xas/SsyI91Ivtu7FTNhihSraj2VNSD6T572HBt3FPvEUqUdYKEu+kegoCe28jEMw0Q
	 Xww5qPIyuN/9v6bCzxx+oYlMeGH+u4b9UW1pDCUVZjmmkNrVi4/8RAMhlZCdd3Gtgy
	 LvMbtDeqlvwbGRjCrh30ux6HsuLZSweHv+eCv4r0EAU0sscPajXDFK5BYCoZgxsGAJ
	 nRY2+eUH6vBL2O4vUCI3fUKP210IXH2vUnJrjI6tquvSr2FZL6zo3fn8yc+qGflFU5
	 Jwo/sTMNImAQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198EC38119F4;
	Sun, 26 Jul 2026 20:00:00 +0000 (UTC)
Subject: Re: [GIT PULL for v7.2] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260726-vfs-7.2-rc5.fixes-40ccd95afb90@brauner>
References: <20260726-vfs-7.2-rc5.fixes-40ccd95afb90@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260726-vfs-7.2-rc5.fixes-40ccd95afb90@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc5.fixes
X-PR-Tracked-Commit-Id: 749d7aa0377aae32af8c0a4ad43371e7bf830ab5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4235cb24ec1e8e96843f3671ba4da2a6ccca2c7b
Message-Id: <178509599876.3839324.12552810533951218491.pr-tracker-bot@kernel.org>
Date: Sun, 26 Jul 2026 19:59:58 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Jul 2026 17:37:10 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc5.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4235cb24ec1e8e96843f3671ba4da2a6ccca2c7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
