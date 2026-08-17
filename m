Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9B3EE1E5;
	Mon, 17 Aug 2026 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005581; cv=none; b=bBamEy8+ZUWnSJH2LeR/EuErn3vgwTFFlahfTLOgEiUTUr5rGWoHs8hMdinTzdCR8KtbAjtD1Z8K7w8/vsAbIKaYeBl2osVSU8yRVy0d/r+oCEusqUuqPJHB/srV5Tb1LLyjulvVmjpZ+s+xo21QSXu6bI6cWTeXt5FT7TS7tGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005581; c=relaxed/simple;
	bh=IMfCni2NmERgkJbBKQD6ZCeGPlW7caNd+nBkbxLO1Qs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i5/6dFr6llkH4xCkjOPosEHkWCketGBhUMTBUeunoyqw853xCCkWN/k2bz11EPJd7P4jrt02gJ8tUExSepMG9nNMBAifDXWpIlhetT6Ti1XPgBOs+8XptaH3IYLMcOg9D4vbAwd+4Os0iMiPK29GrzerqF09OJCzR2HfroNi3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+/db/cl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+/db/cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32611F000E9;
	Mon, 17 Aug 2026 22:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005579;
	bh=EQFCAX24j1i5HzED2+nL/dNvtGPRgH61MfegPF3VYIo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=n+/db/clhuq0P3C9mLgD85NrZqlqAKezzX8S5TGQzI4s/+lG068FOeuUbbZy3FSF7
	 VnzWlV+YCoqkvI6m1OotW4o4bDd6Dqvb4URdemOmEHn1uMFptc0ALFZxGyOHaWG3Eh
	 wNkmkYXtBPY9LrkyvdUSJf4SnoH52HOuF2IZVjCqudtjE5BY7QqorFng0Piomyuj4b
	 p04Ba6nzTyErbF/6KgRsMTy7buR+vUC7RobwQjfZ6Lp1WdoKh3fBaHBhPTwJJp0eXm
	 8OcIRIaPKqHNprOdsazX3rB0CZztS7ccBBilw6pgcWxwuu3zxOI3V8x1S99nTm3NE2
	 2nIQk55+00R/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A6A3926274;
	Mon, 17 Aug 2026 22:25:33 +0000 (UTC)
Subject: Re: [GIT PULL 01/18 for v7.3] ipc misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-illegal-miesmacher-trauben-c3da198a4112@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-illegal-miesmacher-trauben-c3da198a4112@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-illegal-miesmacher-trauben-c3da198a4112@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/ipc-7.3-rc1.misc
X-PR-Tracked-Commit-Id: 1184f5e8200902cae3e098ac68d8600ecdf6fe28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 043d7a2b4045df5eebc699c39bc3a571afb9f1ae
Message-Id: <178700553168.1769471.10590127007363749603.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:31 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:10:41 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/ipc-7.3-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/043d7a2b4045df5eebc699c39bc3a571afb9f1ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
