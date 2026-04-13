Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F539E6D4;
	Mon, 13 Apr 2026 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120551; cv=none; b=Bz2evBclVB+URDYBuu1i5Xp9//o7My1+XnHj9vWRdeb21YhrwnBMXYCF7JsfFuY8KjQG4VT5JfDe3OtM9VpyoUauXnrZHwNXLjNzrV1Y7+Wrpd/hOwRTM65L9k7da32q6ekrdc2oaSpWJYUIG0dcdcLoHyiACWNzk5lza0N0bnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120551; c=relaxed/simple;
	bh=rJUOkdEXLmQtMfqU34HVK9N5UI/nxu1J3LeJrDbTmVk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=spkfG+NkS1rlrZmF0czYOQFlL9OBqkbnSbXyXKT53LieWa3nKX2IuBy1ZHwH+rUyI5PGAZCAnx3jPTxR3OSI+GBHlIbDa7jw/mQEJUlU/+SB9ieCKYfPX9hzQ1HT6n8tRnVGfGQmVNAuGw/B7x5+R7rrYC75UsqfRiTiYkaeYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2bZJRnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2bZJRnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0A0C2BCAF;
	Mon, 13 Apr 2026 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120551;
	bh=rJUOkdEXLmQtMfqU34HVK9N5UI/nxu1J3LeJrDbTmVk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F2bZJRnVduY6AEMRVHRa9K0UYwIgR75YEukorlv4mOmS3fnWAfjGKeotC0RwzyRhw
	 UX7qo8ZtjcCG7KHvJIgYmwURAQOYInjNg+1Cb848E07iyhJzw7B1QETBUdFKvRWvzb
	 tabcG1t+RmhdGPyn9e44Pr+2vu7gkbJisDCQxDIVhWkBnIw2clpDXO/MAxOD/X9FI3
	 X17E+cPqNlGJ61o1bkKm4zUj5w4wHTAx6i8aad00osogMRYZYcGlmemH/A5dsObGnx
	 U34QZMLDPC+ulTNdHSv8RVLQDjVIEDpL1P6ZR7Ah0du+daAJcFSbigmXYC6Hd8Qlm3
	 8Ukn9vgZ3mLTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCD03809A0B;
	Mon, 13 Apr 2026 22:48:44 +0000 (UTC)
Subject: Re: [GIT PULL 12/12 for v7.1] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-vfs-misc-v71-40d5c75a1f66@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-misc-v71-40d5c75a1f66@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-vfs-misc-v71-40d5c75a1f66@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.misc
X-PR-Tracked-Commit-Id: 97b67e64affb0e709eeecc50f6a9222fc20bd14b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef3da345ccb1fd70e2288b821301698483c6c35a
Message-Id: <177612052276.584243.762302372508197313.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 22:48:42 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:23:30 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef3da345ccb1fd70e2288b821301698483c6c35a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
