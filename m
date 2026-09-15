Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE51372B41;
	Tue, 15 Sep 2026 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490911; cv=none; b=hyogFsSNdcCC8MYg6YjfM9Nu9MIS5YefdZZn2fW7BZU9Bl9y9ZULNCkRT+5oQNCCdrBFvAp7YYJpm1Ex3bLlML5pKwFuhgVVRe9jyNTqQTZFlQy4AHgU89XM0SRdVye3wzGiNSXbcV0N+gsDlpGNNJy/ML+0ZqhLiWMY+bOCSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490911; c=relaxed/simple;
	bh=Nr7PADNFjyFBrkNLZ8BwVw5BKU3DBIcUBtX6l2cwgto=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ryKYZ5A4qQ5r7jYaNLfN/c/W7NoZZbj09XcfAzB/c1f/0ExUi/ro/SL9SW605q+az7xzP2dFw2Lz14GH2b6C3OBDjRyc1gl9sGHQH2bSjB/ajPKBykYrNA0O3eWHi57nKb2rIuBEuJizd2jSx6nPD58a2DYCzNuc4c87zV+FZJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifgq6SE+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifgq6SE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD571F00893;
	Tue, 15 Sep 2026 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789490900;
	bh=lFWQXZWh/PStn+ihz2kTAj8RFEujghgT15VB+3BrAOg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Ifgq6SE+qsK6diOsO8fTR0wAHQunA2o0QgbWYhbDDXu23R8yff8yDxAj7oncYKCmm
	 sg+JV8y1GwKvfIW6W9ilXI4rUCpghVlMX5XiC+IfoC+3Svkfbqz9+6xcIubaKI8DvH
	 LOxg4y8zl7PRR30IA7H8xYHWSyFB3F46Liw+HmEOCWMS1TYOhXvMZfXXnXqu8sqT0t
	 7rk4xlyU7azP5uUSjj0v1nzrmTEgvGMaGuVa82aROqJGEAXjAmIdkmAXwISeR0Xuwl
	 yz0UvK+CmqIa9H6v88CnOz0ISkjfII+3mxAL7JJXvqyEw/X15rFpARrJzL4RQTwagn
	 W3fL06Gzxu2GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B163926669;
	Tue, 15 Sep 2026 16:47:16 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl fixes for v7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <5cdnt4kemxnc453x2ri3z76enwfsoijyeleu5uewkwpib26wde@l63ympmpioco>
References: <5cdnt4kemxnc453x2ri3z76enwfsoijyeleu5uewkwpib26wde@l63ympmpioco>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5cdnt4kemxnc453x2ri3z76enwfsoijyeleu5uewkwpib26wde@l63ympmpioco>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.03-fixes-rc4
X-PR-Tracked-Commit-Id: afdf35cfae0d039a4a6c907fa5d8391f1ef0a0aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6e7b42bf05b2427fb8a7a1d1c387a86638bb413
Message-Id: <178949083459.1725172.6798928523854226975.pr-tracker-bot@kernel.org>
Date: Tue, 15 Sep 2026 16:47:14 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 15 Sep 2026 09:39:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.03-fixes-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6e7b42bf05b2427fb8a7a1d1c387a86638bb413

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
