Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D521ABB9;
	Mon, 26 Jan 2026 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451974; cv=none; b=lGPETg3I/2N+TH5uMfv66bGFevlv+8HZh85ji5BWna4936qeuWHfk1p4UTJID9Kt6AM7Rc7rdHkexTSIvYMv4mhbEOvhRFO7b4KlyngbqXXUdo+/Oh/XsKbEl5WRDSl1DHZecQPxZfAvegDlpu8rJ0DOcPYfB8gYEt87NTdO4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451974; c=relaxed/simple;
	bh=vPtOd1zDpFpn6l3FyE7M61clUe1fluTpBdJCRPl48d8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LroYl/AGE/bI3wY87ll9HZdpEnYHXxn2u60As2Y7YeBmYvruss7zWdYWgZw3QKhu7yWPc4M3CO/zx6iYh2gjfKfCfgxeubp+jgbYuKTZSuBitW124GidzF2PATkQO6dVrgLQSRGNRR6ZfQ7ic9NxhsEkvAjt3QqOSmM3CzADmJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qM9n0igo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qM9n0igo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D0AC116C6;
	Mon, 26 Jan 2026 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769451973;
	bh=vPtOd1zDpFpn6l3FyE7M61clUe1fluTpBdJCRPl48d8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qM9n0igoHsbXH49OwWs4lJ/6QcrJW5Miij5FrHa7tH9VdbzQ2Z8A1p/DOmzyc25v2
	 DEIcJvDHQGqL1Jg9EOudLqRnZJ0oitLAzN6SpwtuSRlhfj55IBMpi2l0nlMfExf7pS
	 vJNxyPW+gOwrKPlMYFx3j2tBALwmftsx6PItJ5R1WrXisraVpCKhqHCMFpisFkOV0o
	 XfP0iJyOdMH8R08GFyglcjUHfsfV9MZlQrObuxE0oAFgjtOHb4ptQG9xtmdTEIKPTm
	 jWuFZwHV9nqp6witf5wiB2IfpLDRTJnOdonViYBGzWqMTtQ5rUNLRCtwPQilZXEUfU
	 NR+0T1jmmx2sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8C05E380A94B;
	Mon, 26 Jan 2026 18:26:09 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260126-vfs-fixes-v6.19-rc8-acd9fdd8d9b8@brauner>
References: <20260126-vfs-fixes-v6.19-rc8-acd9fdd8d9b8@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260126-vfs-fixes-v6.19-rc8-acd9fdd8d9b8@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc8.fixes
X-PR-Tracked-Commit-Id: 6358461178ca29a87c66495f1ce854388b0107c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcb70a56f4d81450114034b2c61f48ce7444a0e2
Message-Id: <176945196821.131791.15262585575236286513.pr-tracker-bot@kernel.org>
Date: Mon, 26 Jan 2026 18:26:08 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 26 Jan 2026 11:49:55 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc8.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcb70a56f4d81450114034b2c61f48ce7444a0e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
