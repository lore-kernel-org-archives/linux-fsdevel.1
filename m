Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08039284682;
	Tue, 10 Feb 2026 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684628; cv=none; b=VCSQbdPCs9LwAJuOVgPvTaTc3GyGNjAypdFIsZUee3V6RYgH2CxBB7PHoQ5bfYNSf8qTSGwRhJXOsogUsdKlesn2T2qrPVFXWrQHM/wdlSuoaY45J8Lnm93FcXgsuQI3ptg79MxvAPfkjtmdRLLoHxAZJk6FyUA0wwx88ynT4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684628; c=relaxed/simple;
	bh=8Z5Bilvi0uY0ppcvc9Zo4HNLSlyq3Eh9dHl1zDCbe10=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RHR8ZGQHqEruHjuUnPX6uzRm+3W6C4170BXxkl7EjhR9A0JLkaAexYVAPGWiGs6XRHl/b/NOZGnl/stRTO82Ec35u1DuMNWMfHC0OCYoOZmAakms+Z6qoA0HkwnXWXXaXRewrq1DaY/3bl8cBOahLxi33K3XLS64nGGFKIMPWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRIbixgA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRIbixgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4421C19422;
	Tue, 10 Feb 2026 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684627;
	bh=8Z5Bilvi0uY0ppcvc9Zo4HNLSlyq3Eh9dHl1zDCbe10=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DRIbixgAQ1sclvsVO189Uw3EbdkwD3cqWqWOWG7n3hiwq2TWRFhsJh8OmZWSlMHfP
	 2xUW/hwysakPKOBfNsh4m2xaOO4FV9eB/bbIqY4BCziYCUGcI2UHMw7LMa8laaaLgS
	 KyZjMj3RINxgTcna3Wguph0dZG3NgmOKkferS+dn0eWaSU/PbNORAfugMSwXNv6HaS
	 rSQu/feX3siuerM5iK0+0Gj8AqMOCwoyiYk/4cQhnlUfmWkN8Gz+Iizm7LXqsELulS
	 pjE+570uNkBFNWZodVPfAE/OvvJ0AukO6aFYP1A5vyLbLbyqvPbuRpTl9wlTiP+qcT
	 W8sAbzfzwgSZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DA59B380AA4B;
	Tue, 10 Feb 2026 00:50:24 +0000 (UTC)
Subject: Re: [GIT PULL 06/12 for v7.0] vfs btrfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-btrfs-v70-7e05d1142772@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-btrfs-v70-7e05d1142772@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-btrfs-v70-7e05d1142772@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.btrfs
X-PR-Tracked-Commit-Id: f97f020075e83d05695d3f86469d50e21eccffab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6124fa45e2d919eeb9fc2d6675f5824b44e344b0
Message-Id: <177068462381.3270491.15322550545011463442.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:23 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Feb 2026 17:50:02 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.btrfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6124fa45e2d919eeb9fc2d6675f5824b44e344b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
