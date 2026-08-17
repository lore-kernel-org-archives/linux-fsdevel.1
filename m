Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4BE435A88;
	Mon, 17 Aug 2026 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005594; cv=none; b=gjRyNmtBQx/7mWZxbhVPu2NtqrVK3MGzMptS8sZva1pTLhGeoF8iMilGX2aKHKelLKnxek2tjLYITlsB0E9EDuYZW8LVDNM8huZewj8jjIcPL9SmrvGhP0gGNacA+09RajVq9dVq25LKN9Ls/oRRkoZdVATYfqswzTGKW2z+ZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005594; c=relaxed/simple;
	bh=EQHUwPwor24E0Wl3/L1j8mgWpdu6P9fFZpDOrwfihjQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V1ctgj+7xUuT/3rADPkOtWLSqs2jsVEsw1LL8geVEKfH4iNkKou60LpIkNMjyid+htwHlpDhtbmFTp32FQrlu0MB9Mvvq+/DxJGqkvybap5rtWYvDi2hby5Iqs+RIipjQsB417zNY7dh9Myyjr3/OR4T6K6axRepbcbABVBJp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrYFv6qC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrYFv6qC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ED31F000E9;
	Mon, 17 Aug 2026 22:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005593;
	bh=Cm0cPHU21wcYzT2jHwEXpWH7iCmXtUzMZ4Ogo7QORQM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=SrYFv6qCmG22p7g6Y8YsHf/vRBamjzGS+KNnrkC3kPBG+fn+uj6zWZ9CBs7I4SjgX
	 HZIW+kfN3PCa3nCH1B/G6VtPcFQrgm9u0o3mu2pGFXwh72LLp27CjgANhJpxwYL97h
	 YEXVDarW4cz/8HVRHezqeKejbhN6af28D/KVmcKxw/pWUnZVCHFJPcfMYzXcnyOSbw
	 /ciXCx9CfHF8k8lgBhPFhopPVGfvKZ62kRM0J8DOa2DnkUvSeXbJEAiygryp/G4dwP
	 63iYguDoG3f7fNqUHRRZCd1ugCf0zIfA1QCwF9iKdtSSr5wquORcCgf/H+QjdbOaCO
	 RqeTPig62spZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C663926274;
	Mon, 17 Aug 2026 22:25:46 +0000 (UTC)
Subject: Re: [GIT PULL 10/18 for v7.3] vfs kthread
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.kthread-f4580c1bc853@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.kthread-f4580c1bc853@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.kthread-f4580c1bc853@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.kthread
X-PR-Tracked-Commit-Id: b4343aebd3a4dd255b15b2e5b1363d6399da302f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fff0150b0299f834fe2c335ce0eb5c68bb414cbd
Message-Id: <178700554521.1769471.8647130899544218939.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:45 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:12:59 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.kthread

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fff0150b0299f834fe2c335ce0eb5c68bb414cbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
