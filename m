Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5E49CF5C;
	Mon, 14 Sep 2026 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409317; cv=none; b=cJar2Fj9S+Awq9mBPHDetmLEpqfmUA9wzCDaRf9JkqZpKH9bYtVvyHN/p6YduTrF+l22EhDT+sU0yqjoS5cILkQKl+/BAe6tKdcJsNP42v5svQp5MnTK8tDdueBqbNowxHyTE8iBBf4ZK3dhCridvfOh/sYFqhjOJ3zTOUTiLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409317; c=relaxed/simple;
	bh=BqwgUCk+TeQUOmg4iNRmUuYbbU3Cvxu4gaM5z3vc36w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RNi6Uopjj1uuyyWkZ3ugov8yR9LVDRmzLuMevnP3kWT3WIShklTGXl3k3jQ7+uUEA0gfYILoNQyGSS9f3ZYDiJYS6vnDMU3L2r+VdDC/L2k33McVA0NX87E33LOM5P2P6Gt/+/jmKXTdNpXGyvgSSBQDDxRovjp+qPpkzWx0rDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgYrhlOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgYrhlOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE14A1F00893;
	Mon, 14 Sep 2026 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409302;
	bh=D7QxJbEd4NS0a1jbwSzHb2FlLrmd8sQhM1tiq4t06cE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OgYrhlOaIJC6v+7sJ2tsF0OXPJ2fN3tfRXwPHEmIydriNhAbY9jsujggGqBLdkIIL
	 kUan1bkotQ9ajMFmI7Fmti+rEZUceACylG/tb55/OT9Xg2eOpBaCpcm5NE3QALfhy2
	 MeA1eIECVizsyl9ZgtnDpjHpw4VgVKjOrCYBCG4Dfeq8ZZGxxSnIy0vHaQ3ATsju0f
	 QUVP1kEuu8TjAt/ZXaBsoG1O10/zTLLYl9VzU6aoPoaNnzoyXoBKllXituZy4Dk8lu
	 D78Uk8n3ivwmLI63Vgu4BXWwN1IqNSzSrdaIdT1r6fjOcES8s7pCIuDg863K64QhUF
	 zenVbFKWxcYPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199783924FD1;
	Mon, 14 Sep 2026 18:07:19 +0000 (UTC)
Subject: Re: [GIT PULL] 9p regression fix for 7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aqe_sF0kM6mGn_KY@codewreck.org>
References: <aqe_sF0kM6mGn_KY@codewreck.org>
X-PR-Tracked-List-Id: <v9fs.lists.linux.dev>
X-PR-Tracked-Message-Id: <aqe_sF0kM6mGn_KY@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-7.3-rc4
X-PR-Tracked-Commit-Id: c60ae98c5aa64021751b38ab1313b19d620bf640
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59826bc5a42a5e85dc21d4cdf3892f22dcda65f8
Message-Id: <178940923760.1155813.17521856555663175364.pr-tracker-bot@kernel.org>
Date: Mon, 14 Sep 2026 18:07:17 +0000
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Mulqueen <mike@method-b.uk>, ericvh@kernel.org, lucho@ionkov.net, dhowells@redhat.com, pc@manguebit.org, linux_oss@crudebyte.com, v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 14 Sep 2026 18:34:40 +0900:

> https://github.com/martinetd/linux tags/9p-for-7.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59826bc5a42a5e85dc21d4cdf3892f22dcda65f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
