Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480328;
	b=4K8DyPqZLfneKzn9OjFwvETX3/PvTWRwlnNxFvbbwnaaSzGfI1fB9k3zvwh1WnnTGklT
	 wkhlzUEUJhcQk+saI9sY3hH1SuwQ0je5QIrPr3Za9o2l0+E8lnYgipcBC4k+4BZH5QSd/
	 1HYVv78Ihyo8ErXC6fl1MlZ+hZryJOMw+1xP+Gp3zuxmfo9iOIkm0zomBR/bDEItVI2fl
	 qAd2qG6uOCKFp010ydj1Axs5ZO92Da/OGrtD7o4lxVh1KCoOYo1TdK0H3EaT8+PyjjO9D
	 9x+EVNEMOPjysY80wijV/Zot0fhLVzKZ/QRvvTroz60AE6693uEb83c0djbYOwKdZkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480328;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=Fh16V2Jc3UZ52IbWOe9uExx6edSsgfSjE517IgOMQus=;
	b=1qcdFqucnZ+hGUOp1P051SHbi5NsQ8DqMH8fuaInrffV88EA6fHGNzYfD4iS1xXntyiv
	 nrChcX+dw4dyDT62sun3Dhhhb4DTwS2x/mTn4EakEzmoG8lgaP7K9fgb1w2WFWNvxPxlz
	 jraQHyUVKBhJRHdIcHlQoBUpNQycwU7sPLspYeWlgPSzbu7bAB2qwqSZOKpHGpBTjQQJB
	 I+ru8hJRH7iUEclysksbtTmnTN7gHCWiru7DDqclWNUU0atKUHq51jK4RHpgk5eb/8AEt
	 vnal5aqZdh9fjwtl3fDVzNe+ExWmqIxVB8l1o9rhCqN2TGegt8aNAkuSt/KCZW2TCDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJBl4lxZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E0606A329;
	Tue, 20 Oct 2026 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJBl4lxZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7061F000C8;
	Tue, 20 Oct 2026 07:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480327;
	bh=Fh16V2Jc3UZ52IbWOe9uExx6edSsgfSjE517IgOMQus=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=jJBl4lxZsVAh9hkhfYlM7FeT3TA62nJwH3l8lCGfnfBYJPPGXQ+y84fY32bYYf2Qo
	 268xwvPSf7HD7GC/3y2owsisHMTH/1cEeMiWlr3Mc8Ez6zNhbUiTxvuJWfdiSH81Ym
	 lvoWmi2dNKTVlX2S9PWh6rb9WdO3JSP0PME2IdFizbmz5QEUB4Uf6TQ8vbu2qGcezb
	 Wn7EakUcFkZ8k//51iUTk0TIwST4eb/hU/qNUE3qmbBjKCkeKkqlpiCBTuSD1DtJbU
	 xIyiRgHLJeDnuiQNfBIkR757CzxlrHa2WzCE5KE2sTLHKeoo1hjodyjdoqzxJ5X2sK
	 nBJlbbZrO9pCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43543924FD0;
	Tue, 20 Oct 2026 07:12:07 +0000 (UTC)
Subject: Re: [GIT PULL 04/19 for v7.4] vfs bfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.bfs-c543fd325191@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.bfs-c543fd325191@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.bfs-c543fd325191@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.bfs
X-PR-Tracked-Commit-Id: e36781a626b2708d42a188f6274f1c7897251f1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 355da270c1700db892b8d1c9e0eb76a801e4549a
Message-Id: <179248032645.3535438.282144874222610280.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:06 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 16 Oct 2026 12:16:04 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.bfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/355da270c1700db892b8d1c9e0eb76a801e4549a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
