Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5F27AC48;
	Mon, 15 Jun 2026 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495123; cv=none; b=dTPE7DQPGcnvv4Zi2NhuSnS5a6nqqRJqRCrvrMSCI9D6aTNqpQNv+Tz2YHfuRmRvfzRq42y49noeIWJiuUU3tIzHzpaK2F7F6RqhUzuJg0bkMabQJGb+oyBdpc+xqspQkN3eJ7pNVWirPDFrXqdEs9plpmCIRl+cdMPypS8c3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495123; c=relaxed/simple;
	bh=HMcupiq5uHeteaWYV5gxjnyRaWBjviHNg3BfOwowrYA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kuqJaAFYL6TeS1YqOEbCMiC0xk28iweYP5oq/9BYS3FKhjhpUOcsghtNH/8rgpt3R27gw3rbLlKz5r4tFrpMmdV8Ntx505aG5g7ZKXiU5k9zKOkrChqrMQfYSYcdinkfULyymH6jCdQZAuQGveeNlAVTReqk7nmCUjOphQJ49Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgBS+ycL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgBS+ycL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62B11F00A3A;
	Mon, 15 Jun 2026 03:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495121;
	bh=c/MH/W2raEq9e6s9rxqJsVia15hEu1Oyp6uK6o7Wjtc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=dgBS+ycLQczsO3Bv5cBxg1prZswDDrM+zUsBoPm7Rth2RdSecooNKFW6QLwxgD1Dh
	 C21Dr/5LMK8hMf0kn6AdTVaEl9c73+e/RvY9LqAS+jrfyCQBJFkfEW9KH3VzsgrNKM
	 FO1yKZnb51S/CLLyYONvajsNvCVG+JYzhLXr4vUzGA27abWoKnkis3e8fTX74HEORU
	 2HvM6/VcwIb0MiTyiddEVtDDAqmNT2rjzCOp+9lnXnH5kvncDSdBOjnvX+21zHLcr9
	 Kopj30vjUgmjXfCul9Wx3VRdB2GD8TWgAMWZBpDBI+hXKtSXrzgyKqhlTP25QGebo7
	 H5mJMDnoAGirA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4F3A566D6;
	Mon, 15 Jun 2026 03:45:18 +0000 (UTC)
Subject: Re: [GIT PULL 05/16 for v7.2] vfs casefold
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-casefold-v72-e9b33c432ef3@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-casefold-v72-e9b33c432ef3@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-casefold-v72-e9b33c432ef3@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.casefold
X-PR-Tracked-Commit-Id: ea3120fd5153c967efb20e6e3330caecbf9d8b0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d15ab717d503ff10b585a144870648b9a88c616
Message-Id: <178149511723.2410512.218203256392941041.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:17 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:12:45 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.casefold

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d15ab717d503ff10b585a144870648b9a88c616

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
