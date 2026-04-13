Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6639D6DA;
	Mon, 13 Apr 2026 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120548; cv=none; b=k+AnCVPlM7P/tJbq4X0QaL5yytuyYhUFBQL9nHgVJee0yG7NBfQqPIPvxTnTeL22Uqgn1OuydnVUrh8JJHmz1KrC8XTEpNmrGXd29oSHXYVaxzcH9oOQh31CYEBIzehI6vahsLGw9No2znZ3mqmSXOqV+cKqoYUs97mwweaj0eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120548; c=relaxed/simple;
	bh=bj+Cxn6US8aB/z/YuNO42rv81TvxmfBVgFSzCzc2xik=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tHLGzf8yYhFjWNvjZ0nfCMdMHBWXusDg4o9/9v+Z8wEHci1rCemoqltXYW7ab2d6MYRgUq5G5B5ljq5fwCmrmCMIyvxB6uWr3pUfwpSniDfcRgbdO8TFa3knL8adDvRxYm4GXEhohD8oxqrk7sJcWH/kHbL1DX2Vdc4RpaqloQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmGWvdPc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmGWvdPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811B0C2BCB4;
	Mon, 13 Apr 2026 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120548;
	bh=bj+Cxn6US8aB/z/YuNO42rv81TvxmfBVgFSzCzc2xik=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MmGWvdPcDTutSExv/YOSQbjc6DJSzw/sKwzYEOvnaWPf7NCr7/Nvvh48c8ApokdvU
	 xu5GYH1aUB0NYCmWlA90KF0gqePrCmN14dGxoHn19LwSHAVG9g6QRoFmk2F/K+DPCz
	 ZdvQeCyfDNm1k1b582o1qNX8/YEsv63Y0Yoe0mFqlER+MhQ8YkEATnwFtXZ4WJrUiM
	 STR9+VELIilVxBZEkWWtqlFSGgassqgHGIlegAde+Z3LWscaGubd6X0JtoIO4CGlMg
	 fuSXhpSzeKHhWYqLqfdNwXflqRd8voBeQK93fjnpEtXoJOJSffU9tE8g6mtWSSBABe
	 +aCPORZONs/CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C8B3809A0B;
	Mon, 13 Apr 2026 22:48:41 +0000 (UTC)
Subject: Re: [GIT PULL 09/12 for v7.1] namespaces misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-sardinen-lageplan-0caf0cb83f99@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-sardinen-lageplan-0caf0cb83f99@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-sardinen-lageplan-0caf0cb83f99@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespaces-7.1-rc1.misc
X-PR-Tracked-Commit-Id: 935a04923ad293cd89bf6ec23fc4efc9cf1a0142
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc0dfa73381bc8b2ebd298face5dbe7e240cd80c
Message-Id: <177612051969.584243.814542501789418635.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 22:48:39 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:19:43 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespaces-7.1-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc0dfa73381bc8b2ebd298face5dbe7e240cd80c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
