Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315730BF67;
	Mon, 15 Jun 2026 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495133; cv=none; b=MytuH0b+QjUXyXbINcl+fznaMcbWsiJoW9wplFJYq4UN1+2vsnsr8OMilkfaoKF6anuZxdNMaWs76ShoMJQauEQMSHLYcRRiPg0hILYg9bzsoYE8GaULvGfxFdFJQ5OmpqfKW3J5enhooR09vL7bB4PEPm+L7M4C/XmsKobSi98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495133; c=relaxed/simple;
	bh=kgvmkA4jFt+un1lA6N6sek1jqJ8bzYIdFk6CXAWwCJc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Jo/L5ipyMXgiiUNNCv5XhYG2PF7o6fkr0fA0x7G+F6uAkkj4eoUPhE6n+e5fmYFYT2aP/YAV1czqA6Gtn3mOrLPsCf+wiHY9eif9TiMtguppWaTHfVRDBpUdP/Zg+5MrLbPDiUCizVw8r+WWwBWE/xuSc9O/7VCPbqUzkNiwPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGMwow7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGMwow7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA321F000E9;
	Mon, 15 Jun 2026 03:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495132;
	bh=9qCaHwQCztcJ9yB6DYw0TJc56zoHHacIV1pR+Ac/g0I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=gGMwow7PUuO+jBYRa0hCzKqJPl05hOIMMW1zgrVm0tOCmvzjZq4e0VpwgHzQqZXU2
	 zW1zpQprZ9W87915uUNbRAoMQdYzIDDq7nXwcb6IMVd6ynGWAC1YadbljYh1Yfvq+R
	 GBDfIxCawxPsq4YwhrFPBX7fUXe22OqqpkinzaS7QIdcI6ZQrowEXxdRsILikodoqO
	 iS/48H0BpSaNg72BadjFM/mnjcuDLBJuvzAogUBcH9Q4cMcOOnpQVy/FURFXh1smgV
	 fxremsjoLpRIfnnhb39JTJRCaUdjeG1Mz4rM7vF1TP7Ti0v3QFx5m8qs72J2Sn8CKI
	 qfQ+jRvlEOs8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198F83A566D6;
	Mon, 15 Jun 2026 03:45:29 +0000 (UTC)
Subject: Re: [GIT PULL 12/16 for v7.2] vfs eventpoll
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-eventpoll-v72-07f66407ee78@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-eventpoll-v72-07f66407ee78@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-eventpoll-v72-07f66407ee78@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.eventpoll
X-PR-Tracked-Commit-Id: a1e9718b406bc4e6d0c63c7b999d06febbdc4091
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b7c3f0fe36d8e867288f8e452ede82d178c757a
Message-Id: <178149512774.2410512.7362434165458706805.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:27 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:15:09 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.eventpoll

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b7c3f0fe36d8e867288f8e452ede82d178c757a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
