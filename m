Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445A314D05;
	Wed, 15 Apr 2026 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224346; cv=none; b=SCtXdP4ryLJWsDBbfKwy0lXiS3Zdjgj5yv0i1tBpl9/9VqycWpWPZXMhgHU3TlodUw1HtD8qgW1AZN9y/GwCMzGE/y3kAAQA1TZRakibMXvIjC2Lk6Uki9OuEfOudm9H8AB8uxwUrV8pCd/I0pXMCUXK/brZHBt/inapQE6vv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224346; c=relaxed/simple;
	bh=OayR3VxiKe0Vk3WU2uax2IDbPwh8mpRtHw5LyPp5O7U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aYCSGERbndDZ2uR+ylqFDNsj7fpbvOOJokBkxlmGIYOhhCYuVoKrcMVBLMBISCx4cxQJ7j98fz7IC4MW0H6pAWUcmvMhiER+Qy/CC1a1pG7NgZ1qKzCgz0lQLDj4HLFpnLJcyy1bu2pY9a9y68JfG7X7ij/wInh0EGuXKzzI9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na5N8ERm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na5N8ERm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB641C19424;
	Wed, 15 Apr 2026 03:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776224345;
	bh=OayR3VxiKe0Vk3WU2uax2IDbPwh8mpRtHw5LyPp5O7U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=na5N8ERm0eZHUTfunrLty7ntjYq8ZQ3oHzHv56GujgXrlrpUdmJ+Vq8SUqqT5F5LH
	 NC+cnUDxMEIclbYiX/fbqNphyMd/vf2TQs+HnczUz+s2tlKb8s7MworDMOFFfinhOY
	 HxHhQVGEhAf8v8kzkTweY9WMCxpDLLZ7RF+veWJkkLpogydtNFiyPJ/op+E7T4bUyu
	 3+rXhwR33rCCET+19QXd2holhfEpRqdNo24hzhqlm0JthVYcWErCVjixqyaoFRHbsq
	 0UY/EbvSh5gHFpAib0XgI1VS/SGaCri+lPaQ1HXaSK3psIJmLExBSWwPd7FkQ4imBB
	 vNXCast97xcXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E153809A33;
	Wed, 15 Apr 2026 03:38:37 +0000 (UTC)
Subject: Re: [GIT PULL for v7.1] kernel misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260414-kernel-misc-v71-d07943689d03@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260414-kernel-misc-v71-d07943689d03@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260414-kernel-misc-v71-d07943689d03@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.1-rc1.misc
X-PR-Tracked-Commit-Id: 4c68d150246d7e1d826a807a82e6eb6b4669f42c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c0f43e8535d619ff32400e2e916075109fc7a56
Message-Id: <177622431546.1615558.16517639245292648239.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 03:38:35 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 Apr 2026 14:46:36 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.1-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c0f43e8535d619ff32400e2e916075109fc7a56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
