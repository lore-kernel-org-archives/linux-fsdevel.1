Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23593ACA5A;
	Thu, 10 Sep 2026 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077223; cv=none; b=eOFXQff1nnnprKr0Xh83SxFM4JaZMdJCfhqJ+yhHCuPTcM6oWqmIaeENOSWzoZShT6tZuSUYtkpZwY/xKSWyQB83MCQXEY1tU6wVkF7XYDeHm0NnXCzOYhhyHZ2j4OPIgdd9efCQiUG583zgNj075zmjLT3BQuKGCQ2TcXpBea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077223; c=relaxed/simple;
	bh=a+ixi+VqDx28QGjV2YjZQ6gxzz+Y8gQCPZmOph45j5c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Slic81WAbq62S7wHO6UVo3c6QNtR0ZCTRI+dz5YcJ4vEzQzxqdUwU/w9JA9IGFt1v6BypYfQdMv2dznqTiWJHoEm2sm8zXX1fmFgzN5umrdvXwcmg2P7n7s3BfZ8Cf4EokhWpqfj9BDkBojHJ+o62clszNU0rChcWmX1Rq/3udo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBdic9Do; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBdic9Do"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5209D1F0089F;
	Thu, 10 Sep 2026 21:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077219;
	bh=TeoOqIB+SUhzTp1q3X43GMWOt+NEKTJz+9LBlzh4fI8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=jBdic9DoVYCUzBQdh4LYAGEcYn5ZvXZ1YH+6CDmyhqfHbkmTWN/gToLNwbgtpbeYo
	 861lDAIeF7giO99MmLfmSpjwrFwg55+tKpYeCPBkm3jjMlAfM4zPr7P/AtkPac82kJ
	 1TkqgKvJWOwG8Hd1dNyq+WbqBAh2nYruWulPFcQabHNLN5e2r7J/gf7JR4TavF67g4
	 5pHZzzKHi2I7G/o6t+EacpsVkAojCJ7ivR7u+POs4XLzkmARCFI0l56HUlV/hMfVA5
	 B+NQeiC2AaGrFtt9H6H5n7mUVEF0pEtQpLXZ1xSC8x7pUmEEDQhsukcjkW8fEUx8kC
	 QOK/MZ7DkTOXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C0B380DBDD;
	Thu, 10 Sep 2026 21:52:37 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl fixes for v7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ioe66sxd6x7ku7sghm4tdq5i2fhh2jfanhsb7wvsqjc5gjq6vq@3r5v7mcphc6s>
References: <ioe66sxd6x7ku7sghm4tdq5i2fhh2jfanhsb7wvsqjc5gjq6vq@3r5v7mcphc6s>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ioe66sxd6x7ku7sghm4tdq5i2fhh2jfanhsb7wvsqjc5gjq6vq@3r5v7mcphc6s>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.03-fixes-rc3
X-PR-Tracked-Commit-Id: 353a95f1cd8da8a5436a3f070be07d2f484486cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad724d319c81475488794eccc11eb5e27242e1eb
Message-Id: <178907715642.2100681.3141491075017291589.pr-tracker-bot@kernel.org>
Date: Thu, 10 Sep 2026 21:52:36 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, Bradley Morgan <include@grrlz.net>, Karl Mehltretter <kmehltretter@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Sep 2026 10:38:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.03-fixes-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad724d319c81475488794eccc11eb5e27242e1eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
