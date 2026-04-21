Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8B37AA6D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788760; cv=none; b=a42CMX4eH07M+zQTN5v9TzSFcVsZ3WxaqFVI//oVZNeUvYht9LXy4Hn7/LSEJ1alNKOWusJ1WECQN8c6vn8hwloCYyOpNH+J9k1MHBRswyyivDI0NjsgJhk+11hOWxPt/mP9qSwpFrYLdIVS7gouVJlhoYahZHrZKDmZdibfmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788760; c=relaxed/simple;
	bh=6j/x3BDBL49PfTzbHj0d7DyAzxRtmFW6wkpt8nEyvQw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YxxvEEqfF1WBfSDBWff6oFcowhBQBg5d5bVIlvfK8l+PAzzSS63TkOucSh6KBFHqgpltqwpWa+RCTyubhWKsmOjcWjERPYq+ZAWAyup0Ed3UrfArjYlSc7y0vPz/qIF+yLF2ou83v/xbvvryK/orB6LuCMuM8CpqT1CeGEZC78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCIyvrwQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCIyvrwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F17BC2BCB0;
	Tue, 21 Apr 2026 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776788760;
	bh=6j/x3BDBL49PfTzbHj0d7DyAzxRtmFW6wkpt8nEyvQw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OCIyvrwQQDjSjTPYyNZzuZAeBKv7ziMfAnUP9fYlAO6sqj8s5jJ0d3hzg27A+fGLW
	 mrwLZfeQDCDdH8rWvdAGlthXORBsNhrmTC81lkA1aRXoPaW7l1h7pwP3hVN3UGUoZ2
	 u9Ehgb2vcG/UcIlZl0fIO64bdkiK6y8kZOh15KHN+UCe6XBj9xYRrW5D/JjLQXfHok
	 U9m66pirCzgZGMVbRH1K/UmsnvK6HmyKs3o6V/XwfdQeG2xM5HrD01BMMbcCo2MlOc
	 vPFoo8YJeCoGuluZqzpQFMFCD91cjFSPU2/n8wxJvZOwIb1592I/smEDNvqc8P4IvV
	 Si8669G7ZG0tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E2039301AE;
	Tue, 21 Apr 2026 16:25:25 +0000 (UTC)
Subject: Re: [git pull] dcache busy-wait fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260421092842.GD3518998@ZenIV>
References: <20260411213348.GB3836593@ZenIV>
 <20260411213454.2418381-1-viro@zeniv.linux.org.uk> <20260421092842.GD3518998@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260421092842.GD3518998@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache-busy-wait
X-PR-Tracked-Commit-Id: 14a51045e10d3087b8374deef02a9d3a694132d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 292a2bcd172662c7f281a7d79b095c91101c2e32
Message-Id: <177678872346.2896080.14482383430357583991.pr-tracker-bot@kernel.org>
Date: Tue, 21 Apr 2026 16:25:23 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, Max Kellermann <max.kellermann@ionos.com>, Eric Sandeen <sandeen@redhat.com>, Paulo Alcantara <pc@manguebit.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Apr 2026 10:28:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache-busy-wait

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/292a2bcd172662c7f281a7d79b095c91101c2e32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
