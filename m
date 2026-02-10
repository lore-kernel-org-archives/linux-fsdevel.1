Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BD271A7C;
	Tue, 10 Feb 2026 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684630; cv=none; b=rvr7ZrdVVwxkus8wXWeJ7c5cquSfxFIGq6Tm3SHphwbDMVxwUwQnrnSZ+fj+0xBklDFnI7rnWh0nTRD/XNDTsW/HMA+ezztYXUEoGEoYNNRQij56rYUpQr1b0sTIpjG5ykQG5YAiTXAlZIQzCpanq2fHmGmzA4LRYr83lcxaJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684630; c=relaxed/simple;
	bh=VZXuxr6R8KGYzET38xqTkOMgxvgHRVTJ5XztEtlE9iU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=svWrkLGvoiYJC0BV3NAG/ZlhpXv2mjB1XwpyaXqsevIBFwGYtO9FoGrA1zM858mNh01JHS44pQGZv4FrmzPpzFJCoF8fgmrtHZ51nviN92IErC1sV5N9rJRioRMD1LY3HmNktM7c1dcJvHq+RFBlM/2TJGRcjB/F/Kohxt/9Sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsePl0td; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsePl0td"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359CAC19422;
	Tue, 10 Feb 2026 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684630;
	bh=VZXuxr6R8KGYzET38xqTkOMgxvgHRVTJ5XztEtlE9iU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LsePl0tdbNBuoOpxDKikhwquA73DCQMVJHJ3C15ATeJcshpKFvpEtazwiIWN60UxH
	 Dl02aa/UYlhwbZ9Kl5zgBea06NxiNIyoS+VwYSJxj6B5pelbjmVLq/m6SLxZnqQJD8
	 jwNACmjcr9wGdlNhbpAg11wN9IY+HVqcXvoREDTgDJAQQMD1OvaTlELDUBJZe3Bdjp
	 nbVmxg1i3sHAsn0PBnym13lAmjSF9D0pIJJzWCbZGSy9CBwA+aVT/F/o6F4v6ylAKm
	 v20Q6M1ZLVJVl0/47quX9FKLbsr4OSpFX1+CXGQ4yclktA2NhBtgerZ/wcJGCsGj1m
	 SiMhQFEwwrBJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2A0F9380AA4C;
	Tue, 10 Feb 2026 00:50:27 +0000 (UTC)
Subject: Re: [GIT PULL 08/12 for v7.0] vfs nullfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-nullfs-v70-20f5788c0c2f@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-nullfs-v70-20f5788c0c2f@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-nullfs-v70-20f5788c0c2f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.nullfs
X-PR-Tracked-Commit-Id: 313c47f4fe4d07eb2969f429a66ad331fe2b3b6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c84bb79f70c634a95929f21c14340ab2078d7977
Message-Id: <177068462609.3270491.10745558936509155431.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:26 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Feb 2026 17:50:04 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.nullfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c84bb79f70c634a95929f21c14340ab2078d7977

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
