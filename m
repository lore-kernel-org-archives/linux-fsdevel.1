Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480325;
	b=HM1dyjL0X0/bMyYs+vfajsrcq9zuZb+DZdIBG8LqZI51gfus/FtDD2HRNkaOYwc7X21g
	 5TtultwSYi8zzJCBNLh2rbVXihB/PYob9J7mEw7MGmNb2AcBr6l/e55J4Le6BJ5O+Ke+2
	 CXPd4tTSkB//sUDPSjVRBX790+nzoi57lYtmF3qGN2i3plD8i3R8AE0V8ypoeCmM1kG/i
	 r2cz2rtWlan49dZSTWuEi+UHr22LWz+XNlwKfWL9YRYOPLr4J5emf/8re8D3cmj0JUKzq
	 1ixoQ9/wzazKfNhwhYsMauTj/nYWTObYCK/hGj7LFyztfuOIZ0e4nienxsB+CnLgYEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480325;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=GTjWG6veVgz7xI339WOtmWNDj9wsSt32KCA2KujHYgI=;
	b=mTKUhYswiXrLMaTeUDUIwlAh331XjTdM2dULF3TLjNVDVV7mLHuOFX0mjOtINUOId0wA
	 F+/1EMEystHYtJ0UgZhJ/BI59ZseMpXYX5ZGjVVXzrIyp0ZmXLkiW6duOeOyrkOKYfPgD
	 HtyDLwUh5/aS7XwCOj8XV0RrFecLInQF4BBMXHViF6Ghfm3rTS1R03GhFyq0rwN0AoSZV
	 77uol21vhM/N27Z9Xu2Kwj07WbPr8peTdX407ov7NZS9AIiIqzhGEH8nmQPkqJJjzA2fe
	 qEZQ/qoIOrwp9xptnqpEjQSyrRrWaQRWBmHg58HaG7Pjb8No4QoHaHw99fzrxrfeGxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1wlwdI2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2205606A31D;
	Tue, 20 Oct 2026 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1wlwdI2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874591F000C8;
	Tue, 20 Oct 2026 07:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480324;
	bh=GTjWG6veVgz7xI339WOtmWNDj9wsSt32KCA2KujHYgI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=e1wlwdI2FgdI3ul9ZfkmnEAVD4JsJKVbiYKUd4jJDMj+PocY3/SJ+HsZgixLZmlms
	 jgp5Ppk2FL2QRf9U/9K3nIojfRdnZq3ryDqxJ789VaSUCsq66bUGcOI9C5LEtahU9l
	 TkqpenXKGZDCn+wQ31xVGaat69L3mZ6jBLo1A9Nh6QBiT3pm0XTLupUgz83NFbCx93
	 AgmfEqYeXilWXrLHGuHsHAu6q9L/cSc3apdVDypbGPFujTMPFknbCSDP5fPl4XsXZF
	 wxyre8u2F21v/QYdu2Ukcf+O27zXzSCNln1QfZyRbxkZ3AmiJ23FCa+Jh+ZqiMy+/C
	 RT2p0OQCLSU7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774443924FD0;
	Tue, 20 Oct 2026 07:12:04 +0000 (UTC)
Subject: Re: [GIT PULL 02/19 for v7.4] kernel signal
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-kernel-7.4-rc1.signal-3dbe927d2fe3@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-kernel-7.4-rc1.signal-3dbe927d2fe3@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-kernel-7.4-rc1.signal-3dbe927d2fe3@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.4-rc1.signal
X-PR-Tracked-Commit-Id: 12e19bba68ba4ef222033ff9a3b63df07b7fad38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 018cf9bf786d501a27963dca6777f169f978e2a5
Message-Id: <179248032301.3535438.13404437277570902097.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:03 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:15:01 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.4-rc1.signal

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/018cf9bf786d501a27963dca6777f169f978e2a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
