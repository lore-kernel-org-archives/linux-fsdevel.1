Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795311166;
	b=JlRYwHBQ8rnk9M1998hWr2eYyPDpRWwe9kZWwbBW2o5qN1d4HZdJGtcZQKpyVl9KMQx7
	 5fU+spa2dncd2yoWer5MJSZ0YyhG3IUnA1MOFddWhO7MK80lsIxYm66B0HBJKOYQb7jUa
	 vJhZSYLfE2L45+uwnKf6pCgQkkAAIzeoAB9RDYBvE3HP7FKooI5sgitM4+4QUjRUgFOHO
	 4cFGv70KNzjJ0MLMMUedGO0rCc/cnikRb/4jlYoh8EOVoG57l1aG8QBXzflrxfN1bou1n
	 6cD9XLuQLml8E9OyMHx2ArF7ZwHzrtvaZ/9k+VxSRewP8H+tC3TNC/PycqJwYUoA85A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795311166;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=Ju+19rSMyY1wyIZA0Wu8a/zFRoM/tsQK3p+Ff64WSNM=;
	b=H9/ubkxyaHsynqc7Tbl3ch/HN4Nya2Z+Dp7xPZCMM3jIdxht6LO2z7cXHE2lTocA4v3e
	 ZLznautHlzBY8k93uQ53hjnLSCD/U3qXi0zEb9pZoStp43731Ptr8sikGgtZWf8V8ujKS
	 t5OmG2Vxe+4AGArQFKYSq2Q55Tg3JXXF8Yd5f4j2rA5wy7+s0mqJ0bKLwrSKj4JeaRPi+
	 kjvrPSOhnVHeWxEF/PNqDIHtsW+z+vPAGy5MUA691IOsvgzA65Px5Rmmeo+j++4NTU1Lz
	 kFI7JFFTrPAmKUQ5Umyp74QMw3rg1zBPaWFKdxuvQSYajAUgFs04f65LEnMLuarqDxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHdcdHtG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E4606A32A;
	Sun, 22 Nov 2026 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHdcdHtG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FED11F000C4;
	Sun, 22 Nov 2026 01:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795311165;
	bh=Ju+19rSMyY1wyIZA0Wu8a/zFRoM/tsQK3p+Ff64WSNM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=QHdcdHtGosg7hdemppLt32ZPgERB1XVpXN2UxOKMmkWTSLIEe6oTXFuVv9dBxknkW
	 b4W++Z0eaEJLlaqyOV734c2/4sf7lP8Nyg/ZPpro0Dn6PTIQB+9WdR6g8Zd0HRcXeM
	 DYsnRSe0l6C2bwA9phuUcaQhfNJeTPuvypnFB78hZjv4Zsr5Zu/sMOOMrHBGn0meou
	 PfjrDYXpOmMRim2GUMyIR4WbU4lf5tGA8LbOeV8tpWolYDuPCi+tNBNBAuwzOpNbJO
	 bvVpP7WHtVRY3Jg9x6MB4YEy0E/iIDMbE4YuIYGTQIkocUCNWJYI3xjA2ZSLh5iJA5
	 emDy6Se4jUAhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774EB391B098;
	Sun, 22 Nov 2026 01:32:45 +0000 (UTC)
Subject: Re: Re: [GIT PULL] sysctl fixes for v7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <awH4Fh-XofdwwRqZ@hobbes>
References: <awH4Fh-XofdwwRqZ@hobbes>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <awH4Fh-XofdwwRqZ@hobbes>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-7.04-fixes-rc4
X-PR-Tracked-Commit-Id: 9fcdf40e0d7c58478d88d3e1ca69fec8badda0fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
Message-Id: <179531116414.1248683.10418563467755811748.pr-tracker-bot@kernel.org>
Date: Sun, 22 Nov 2026 01:32:44 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Avi Weiss <thnkslprpt@gmail.com>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sat, 21 Nov 2026 21:05:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-7.04-fixes-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4843f6873f7c4835e62f2c73ba0fd538e57a2f22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
