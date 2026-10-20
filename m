Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480326;
	b=IQd/MzQUiBX9rjjmYXz4NyDmh4d3Ak2/o5K6h+3G0W4+QZQEnEEVmHWhTx0z0OWsCHFw
	 HxwrDn8Wa8TtOhpQ2e3wePVIz/YpH0RaSAy/NIRN+hTTWfuK8pE6muBux7mnkyNDmIrrI
	 5xn6at4fdvrxVV55wFclbJhg+FKbd+2koZzjbFmZZoSaOu7J/mg+faU9d1qbgHwqfPWTI
	 ZSwQrDjdJKFLUUnuYJxTSD95itE0ojIfMWvatNfAghAWZP8xB7MD4jnFJSF9fnP7gDdf5
	 nqRTwjMm+v94f1wUUCNknB5tug3GzkFCXvKopfoVjDPVAYz0jt6qDdlqd6nwYiuIlyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480326;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=HU/P10cQpd/0vYkK61iCJZEosudH40tLUJLUUWq/r/Y=;
	b=WMA5EHbPDCzdLN9u2s/9AhYJCTP0K2rIO/ptR8Fn1n1VcISNHzNeMmtHi6vXXng0quCj
	 +bKsC9l4IAPhdyvK2QcF883K+pSPDBBs/tzLt07K8c8RXgTmzW5ESY3FrbRr7j8jxfef4
	 hF5Mpg80/mvwqtErrcPK6m2mhh82VDBrwmPzE/xJfL3UWE+B/wJf0UkzcR9r/1jB+ypX5
	 XOMUNQdZFJcIQfCrINsSskdAtHVo14HlSe8cre6OJvA81jKLA/jQJBpk/rAc9791+jrV2
	 qFG0+u5gLrdvJEQC6HI2F2/ezjBlnvHgI+Ce9e4y56PgubXAcqkLyGN6m4BQufOfvng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfstvTDH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96397606A328;
	Tue, 20 Oct 2026 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfstvTDH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1D01F000C8;
	Tue, 20 Oct 2026 07:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480326;
	bh=HU/P10cQpd/0vYkK61iCJZEosudH40tLUJLUUWq/r/Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=gfstvTDHNUgUjLhrm1khIDj+hZWjEt/HTAAE7/LuSGHsh5fXDslhKwWsDEFkLWCEs
	 hEA1yFMdGWlsj5TJUTNi/qn6mqvw6qlc/RDgniBB0eoLJmMw478Qfgiovk3qV6P5Dz
	 Qx8BapKVzSJEijz61Ap9rD/KB5A0qW29PpaIjZ35PqASpK2X3gCkq3YyQdBAPep7Fy
	 X6udM1bb6nZ8M6mgYk6/p2bl0Ast0I+P4NlrlsHLrFGRunCiJ7kQwpPTsf2mrX/W5v
	 96Fq4egAXUeswBNXtVH3YEL/LFf77BtMh+2By/4C3f/kdXFzwefI3PeydYPRbR1+qL
	 p6n3QUlzKkmkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2EFFE3924FD0;
	Tue, 20 Oct 2026 07:12:06 +0000 (UTC)
Subject: Re: [GIT PULL 03/19 for v7.4] namespace misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-namespace-7.4-rc1.misc-3a56b9fd31a9@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-namespace-7.4-rc1.misc-3a56b9fd31a9@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-namespace-7.4-rc1.misc-3a56b9fd31a9@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespace-7.4-rc1.misc
X-PR-Tracked-Commit-Id: fbc59bc7f05c62b0c1607b92eaf8175e75ef755d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e86d265826b8dc54178e16c4027d3bd5d0299f12
Message-Id: <179248032477.3535438.14395426097560699032.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:04 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:15:36 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespace-7.4-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e86d265826b8dc54178e16c4027d3bd5d0299f12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
