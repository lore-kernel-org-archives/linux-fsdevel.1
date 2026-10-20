Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480351;
	b=Blvd1/BNctBfcsD/Yjiiox+QrLoX16dxgkFq/9IJsn0jRua4J8pOVfh6iCYy/2Magbty
	 rS+hz/gdON8MPgzdUbyOInp2yhOIpC/xiMMFA0hJhdrOb+v3NzMtXNr0d5PYt16+n3F6Q
	 CVI5FQbCNdzUbZ7jW5z3LTqkIYzB42yUeIYG/P/ucD7VeNkX7lAM2wVRhFdcpiS2/KyfI
	 OKZH7O25/U/8Ni1k7u1K1KZ3SI7Id1XVQUK/iAxrugDdUy5OKGlFRDvAMbLegLwC2FHzy
	 90P4h7suu83K7UBxFf1udLOWKXQNT6TxnzaNj8R06kuy9zzH+f2yO3L/YTt8Gsk+4Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480351;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=rsxVQuYQz1bB9tMEGtVHUE+NuK6QjxG5BrjYpI/hU74=;
	b=DPeZUx0sWOP8nPLWUUI6y63SUIPtNE0+W+RuAWng9S2hM4j55LWanAUMTySTdnmXEdJd
	 H0M73TJx0hOwmno7x29dF+dH7+DscgLgk/jWiomPB74Jc8q/Wp1XA9gLQKTqaxGwOEo7S
	 ANnX5Yj3GfaTVQKw99IRSOYYh6wnLrwOR7LCk2Ni/nTeAj+QimYVXSvcEYim1H2ZPoQAu
	 ZwHmZOp2PBNnH4PIuzsAKZkex1cuTvvxw/VjcKG7qT+JaIK+D0gfRhgtNa4B9Hp7ux6Eu
	 PdpPVB3H8Q0k7ygmml3ltDJ8Tpbno2oO0t1ZlU37QKCFmeYfxgE7YttU3F0lJhEC0OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+CQ2iAX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E7606A322;
	Tue, 20 Oct 2026 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+CQ2iAX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818471F000CE;
	Tue, 20 Oct 2026 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480351;
	bh=rsxVQuYQz1bB9tMEGtVHUE+NuK6QjxG5BrjYpI/hU74=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=A+CQ2iAXFw6lbwGS2kxNM+y8kaW5mjIYt7JrubQV4dAngklt+j/iYBbw3QfbdvM0b
	 ZF5Xv2CrJBm8vQc4FjFY7yv3nP/MHaVRJTGYYZEBwHdeO5uKXsWFIV4Qrkw3KCc5LU
	 FsLvJs6i5O3YchMXzTUKEZx98LevleX6lMDiivjVNVDTYFG/XLzfrdOojLLQQDlX3m
	 xHfFa/iGkdi7BI+5Fes6ZoLeGo08Gm3S/teT7VDhEDR4RnH1WsUSLyTBMHm8hOAIkT
	 GrbkYm8SIjMqynVV9XBD3HEkuO5CKNlylJiR+C60YlPqVG6Kvn4v3BCvba81F9UMRE
	 0k81N7cyhN6ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774B83924FD0;
	Tue, 20 Oct 2026 07:12:31 +0000 (UTC)
Subject: Re: [GIT PULL 18/19 for v7.4] vfs shared super
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.shared.super-9c2de4415e8b@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.shared.super-9c2de4415e8b@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.shared.super-9c2de4415e8b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.shared.super
X-PR-Tracked-Commit-Id: ab3c5140acb36ecc02d5408b99aaaa5648f2ba1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58aeff92eebcad28da1f01e6d16b04794f7ea4f2
Message-Id: <179248034999.3535438.12815346576185949767.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:29 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:26:37 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.shared.super

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58aeff92eebcad28da1f01e6d16b04794f7ea4f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
