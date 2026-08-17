Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A70471D0B;
	Mon, 17 Aug 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005602; cv=none; b=bilY4+tKHQ5EiA8SkeKbmQ7MWyqO6kYT88b5b1dGtniszq8SZEzJCohDODUG1WPoGlanqyPuNnIK2TthL7egjBBXgmwYjI1MyW4vEbOnA+i0yY+BCuvBYc5t2/5tfciXFJRpexHqIlmoBWU1TIn1MRWjP12PgnR4qQqBf7N8NeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005602; c=relaxed/simple;
	bh=ysmaq9vgTEy/peBqJa8KpSxNS4Xf+Hn6F3NM01rmB3k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qPI87E1d66d0pBZnQr268yzZ9Yoe6zaBZlDLzqCHVSxSaWPbMj9USvlRcUfctXXA5VpJj7G8HtgsJT62qpC0QbiavjXsehBIHPa2r29r7ianxn6MTgmCCV4khmt5ZbnwMnQdvC7UIk4oijZOqmIlVsOQbcdog25GE/dEWr9UsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2btexh/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2btexh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12CB1F000E9;
	Mon, 17 Aug 2026 22:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005600;
	bh=nBkR9BhVH1IDPW8upPmiBEVu53EaFAqKaO4qq/8e9+I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=R2btexh/usfU0j/eoYlOGI+M3bmlir84biEueNxz2y3wh+kWDcHwVTHyVqxhRqCmA
	 VtOVWIcRvYWiJ6uQZQRkWPmtbMaaHLX1CTs7ZzSsvqbTB7cFFubzoNNRxvt/bNymvG
	 h3F1l+X0suVPm42Aw2Yj5F4LgKPI0nWYrppoicPGwgkH1hjLoD1w38uMhkcxYsoezK
	 BGkbnqdZlBt3N3LrGsfTbYeWpQF/ko+4pSnApHrVfuJfcOY/LkQRSdRHoi3FoPem6u
	 ly1aN16iWGurecutfTTESDnVEJ1CvyhHGb0rm0OqARpVTQpQE0Ks4hMK6Jw30VROBP
	 8nUgDiXg+ug8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199ED3926274;
	Mon, 17 Aug 2026 22:25:54 +0000 (UTC)
Subject: Re: [GIT PULL 16/18 for v7.3] vfs ovl
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.ovl-5cd586fb6045@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.ovl-5cd586fb6045@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.ovl-5cd586fb6045@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.ovl
X-PR-Tracked-Commit-Id: 077ab8985ee278c3d8618182d335b0f0cd919e16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aaed66fadba2d2de8fe0daa0aa3eac827d2076b9
Message-Id: <178700555275.1769471.5880612422129836571.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:52 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:14:32 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.ovl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aaed66fadba2d2de8fe0daa0aa3eac827d2076b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
