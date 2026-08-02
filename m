Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF22306B08;
	Sun,  2 Aug 2026 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693161; cv=none; b=ZeQiPbpTUVxpiNrJXRT1EK+FKjzr2fwHHj8N6jxuAAvQk2M+ljcQO+1wHsv20a4a8McVqcTyN6qkq0kVea5rRFgYTaMORw5NQb6saruiLTlqip8dnWby8nZ4AO/A/ItelnENlAwLsZzcdeZqomahXclwfmu7TuJvpzBfaNXey7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693161; c=relaxed/simple;
	bh=o11vYijOb/0XZwxs4uRfVJ539cR7Iy0YV5aLFOn6WD4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kBk9dWkSXXuCFokIFCAbUJDfFQfhY+z4TwJe2xe3MjJjr8o2cZTA4Ec2/cpxSsX7D5Dy+uc/WrXErFE65NKJhq9xb6aoQAaj9k8XRde+SZXNZlFGbhLvc1T4sR72r63TtQG09amtHIHIBKWX7YOM12Qd3e1h4pqkGbSNhgbKWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEAvsaZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEAvsaZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770B31F000E9;
	Sun,  2 Aug 2026 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785693157;
	bh=pfNWVx4ND/pzF8koENKsF966dY6gC1YchUACAOhoVoE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kEAvsaZYGfk/SF3hpMoH9FtSUSs6n071BYn6VzVe0ya1HJRQGq6chFNk8dh+KpFK/
	 uIqFAnP+fqYxvDipk0DEu9k713NXXkgoLl3YnvIgVimY/e5gzCB3DXw57cjrXjjr1t
	 9rAkLnH5UkBtm/7h7tjd6HC3g+pmxn34HGuBJCuySQfzSyJeRhOYaglt8kKXEAN4wd
	 9U9JDUMF+dXOdR80yDnWmbhsGaRTfX1VKj/77Hkw6nfaaRQenoWqZnM64U543AbR4I
	 pfDWvbIXuykqoXafCgVvZOrdIEtHACjndtQkKjvoUbiRzDWVIKh3vhFJwjR6r+RjxF
	 EK1DRfNgwcsAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569F43809A33;
	Sun,  2 Aug 2026 17:52:00 +0000 (UTC)
Subject: Re: [GIT PULL for v7.2] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260802-vfs-7.2-rc6.fixes-d7f38ab4daa2@brauner>
References: <20260802-vfs-7.2-rc6.fixes-d7f38ab4daa2@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260802-vfs-7.2-rc6.fixes-d7f38ab4daa2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc6.fixes
X-PR-Tracked-Commit-Id: c679ce3be6cb63763d68ab9b5d9d73ddc0a40762
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd1dde877520385f6638af2d0f2bd4f212eb8f34
Message-Id: <178569311890.1445093.13492867591445188721.pr-tracker-bot@kernel.org>
Date: Sun, 02 Aug 2026 17:51:58 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  2 Aug 2026 11:31:26 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc6.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd1dde877520385f6638af2d0f2bd4f212eb8f34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
