Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47C44212B;
	Mon, 17 Aug 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005596; cv=none; b=hUEzUfgVBdwjEA2diSuP8aJn1alORVqQ5lFZLhQ83fMypWfgGXotRQvdNK+U8bbTV7qY2/1iap1jOeRh6rZjF0uGYJClm906bYmIgobIYVxQ6M0gXWvVHLEd4v6g46kto6OR81STiXKgmGFvEjPd4hvzKm5S7cFV1+A4ae1KGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005596; c=relaxed/simple;
	bh=XX6umEBg5HL3zxS9TumS8c3XT5FEfMiA2hgnXwRqJok=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ar/UZm8kzG1p4QMG8VO/JX/caQmFrCz/ez7jJ3IdWPwzIh1wI0U6sj8c9i7zgNg69EkObiuycgZQgA4S1prp8VRb8SzzBYybPIeZUt1pKPNdUc+61uPpBn9iadxJt5RzmVHFqmU7/ajOsFHanox9jVvMmL/SgJQSudt18SVk7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQplNiGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQplNiGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E9D1F000E9;
	Mon, 17 Aug 2026 22:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005594;
	bh=beamc105H7X0SnPGJsgDxEU4t6rMQ5uPIAH9+eY7x6Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=YQplNiGSwtMFIkl01Gw+8iz3Utm01B33nIQs/t2lsfcuENIBy7xS39wy6+TucjAJG
	 W8Anr6ncRHiOh46TLNMKdwfXQ5NFWXdndptgCtIVv8vIF2AOSMLmV05kGUFwFGemkR
	 wCp/pah42rNTbC0nYqEfAC5cIxWU4FQ7ZojlU449dd0KtRSwuLrxt9BHnTUFMTIGIP
	 MHZVHh0k3cDDVvyMymPoGZpUqW9mQmkHmxT5DU4CM/aO1x7OG6Lu3KPm7uHd4sk5Be
	 X41dxTw+lvuGLvx9mbqSo1cumgmHne6KcbCAiES0n52Pxg4cov4CUnkWlRhss4eU73
	 RxZkQVIm9QOwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197DB3926274;
	Mon, 17 Aug 2026 22:25:48 +0000 (UTC)
Subject: Re: [GIT PULL 11/18 for v7.3] vfs lookup
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.lookup-945fe3fb6a45@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.lookup-945fe3fb6a45@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.lookup-945fe3fb6a45@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.lookup
X-PR-Tracked-Commit-Id: 895741772f6ca989da565bcbe4673f12d3d0ac31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab5ed08f2d8396fb8e3942569bbbd5cd569a753e
Message-Id: <178700554671.1769471.6766606937486400026.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:46 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:13:13 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.lookup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab5ed08f2d8396fb8e3942569bbbd5cd569a753e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
