Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24926A1A7;
	Sun, 29 Mar 2026 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774824007; cv=none; b=pkA/5J9IdK2qjZ636Wv9S/TpBKzMDxvi6Iy0ZOJwfrooJHdu+xsbONIjm9xoKFmRgbp64Cl2wGooyC//0vhdQy97XAqHRD/cOPdgSeqGSVGnQQY4G215/bEvUn95OGwqlDDb6KsUBkAUo/tH6/kFJTRVYCYEXpTPRU4Xe1s+H+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774824007; c=relaxed/simple;
	bh=ltdPLDPq1lm3rLn1rw2Xm+o4NWrFkwu892wUN0heBc4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hiAWMz5+cIIxSVDejoYf2fm1ABtpk+Lqq1pG6MBA2QgofXuJX20ETBIU3thUC3eAr0hWvHpVYs4ENeyqzdBSElupCa6og9P1i3+7WQT7kTKQTAOt9Lce27rbt0dyXpP2t8JApXhXnMTvoPXmbEqYVduP+m60Z2mnvsXSMNMdg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0+nJBAH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0+nJBAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74381C116C6;
	Sun, 29 Mar 2026 22:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774824007;
	bh=ltdPLDPq1lm3rLn1rw2Xm+o4NWrFkwu892wUN0heBc4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u0+nJBAHGb4/vz/nklmDYkEdOZoof0UEgGF097as9abG9nymLJ8t450v2dZcr0fbb
	 YqHONFrguS9OyauwCUA0Y7ifd/7ru+84Lj7p1DhsP2QzkNiEz2WPG4ghvgCQzOYWiN
	 JZ2zlEbeY9YDasQz7ynlsShLJMYtVHt6wSsd6uCtpSWw4OBdhbO1mLUAfxEWfFV3en
	 T3l/tj+qtg5kBHnaS3JUcuLf2wZaDQB6rRImg/i8Q89YyBmcTUfumWGYGIHjFdZuuX
	 j4J+eYYs0CIdPe/59g4c6NImSOmZ2JVfuMy+wVyQpUhBIonHkZ+qXSiQZ1rIbwzwwj
	 ZSys3EFpjeRDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401BC3930012;
	Sun, 29 Mar 2026 22:39:53 +0000 (UTC)
Subject: Re: [GIT PULL for v7.0] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260329-vfs-fixes-846b973993eb@brauner>
References: <20260329-vfs-fixes-846b973993eb@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260329-vfs-fixes-846b973993eb@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc6.fixes
X-PR-Tracked-Commit-Id: 0e764b9d46071668969410ec5429be0e2f38c6d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1384f70b2e3162786bc73b8f86c27417803bd57
Message-Id: <177482399170.482910.11692555110697277358.pr-tracker-bot@kernel.org>
Date: Sun, 29 Mar 2026 22:39:51 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 29 Mar 2026 23:06:07 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc6.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1384f70b2e3162786bc73b8f86c27417803bd57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
