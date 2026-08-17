Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9C45516A;
	Mon, 17 Aug 2026 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005597; cv=none; b=b+ke4M3ybgrUITOago33vEOlU7ph1JDILW7XjWpkVSSiOICqTpK/+Ayp5LjXL+ofF+b8dk/HjcEnKiMWyDm/o6DDD8PKv4Mtw4U/bvqX3Ko8Zn1ywLL9C3mmzg3FtenPks0NGrbhvqAv7BXfbN5N8ENx+r26g4066EsfCccTCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005597; c=relaxed/simple;
	bh=OvQvAnzajCg9eXhAsoV92hzhsVEKAykcMgIWPxyuA9k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pUfOcdslXrmHDtLEksut8u0xGK+LBxTWb7N3RKqlwpndk3v5D46H+JEZW6qTWAmJ5GaYGxEHNdNmsX1ez5j8ER9c8DP/xvmsoGUwhL0Sw0tjwaWbDBasWAaqDvZcozXPf8R9XKWkmv7WjzBm3gBGtpHK7xscRZtYdzWc3aZ1HwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWFlrRwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWFlrRwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C821F000E9;
	Mon, 17 Aug 2026 22:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005596;
	bh=HcdalHW2OGn+NJQ6FuBqaW7ocAeoII56Ev+7Pz0L5MA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EWFlrRwDzsS/ynIvK9onlcwbt4TcPLQCVrd3PcMsjE1d5KnvZ5LD1uSjHq36YTuMi
	 nnZ/JUXG25O1B0hky/JtUWd5sTN5zNXZnbhBMrv+KZ4WE8/gRro9BcIMBAhKRH6ihl
	 x5CgvQZmBiVChY/17eFglxDH6NkA3Oi+1P0GlP2OODxpj5yRL0/PxQljYrQN68a/cC
	 OLYGlviUg3Jxq9ypsQ080h14Am6cLrLAGB4EXN8osjWOlz5L2kw+iPJSxjagQzBXT7
	 UGxwtmTUUtcjFvEOfmjUWIdkKMtBmYWrMZHkETrpK+k2qA+51nE8caq2mnMEX0FFgQ
	 2MrQdEiMOXJyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397B3926274;
	Mon, 17 Aug 2026 22:25:49 +0000 (UTC)
Subject: Re: [GIT PULL 12/18 for v7.3] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.misc-abaa1db7ff94@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.misc-abaa1db7ff94@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.misc-abaa1db7ff94@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.misc
X-PR-Tracked-Commit-Id: dcacab904fe78d60840ba947a104993ee9ded887
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c3e8cef79ea5f1415cff0d3c507e2e07b71ade8
Message-Id: <178700554821.1769471.13245342474597718264.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:13:26 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c3e8cef79ea5f1415cff0d3c507e2e07b71ade8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
