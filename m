Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8FC30EF94;
	Mon, 15 Jun 2026 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495138; cv=none; b=FzrAPoqK1EXpZ0VA3x5uXpYsWrbdjG/1EyrwlFyq1QkqH/QBJUs5v4E6KJBro2Nv33L6pUehwXmwenyxtdgt69TBbKV5d3rl72LXK4PCcoKzPCjCmK6AOxSacB9lyDUMtvvOyHKQIOlnPQPYlKhxVgenQGLlezPIxRQN6FZ73cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495138; c=relaxed/simple;
	bh=sppJ+xdEHEpfJNXR+K0toD/R1I9ucGvA1cNFj9ZV/tg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nMhA4B4Nt2ElLvtXvRhjJ2Pm33hsQ+h+ZMAFwNa3RwRQi5guCRASCdmoosXgYh7VY63n114NruBhi11yTCTkSyVxzxLlOhQ4tP5EXoSkZIsXL7qgNU6aCE09P73eMcnGDKvAgudG3x980HAec6q4vhOWXstCfV4UAkKco8S9p4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKwRe/nS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKwRe/nS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A391F000E9;
	Mon, 15 Jun 2026 03:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495136;
	bh=J+8YCqOwxPO6oHspIYnA1riMTUEc1PCQ05/IBBlRdLk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PKwRe/nSirEB5xlK2/U7mQt1+pO1KPxr+/t4AkHA+1tq0bBJJCXN+hPwYbytDQNMS
	 xFF1hF9JaV7aU2FEOuCmMrpABf6zVa4+kILVucgH0QPzI8sRHN3veJWXK82WYAN97q
	 65D75qaO5XhWv5p2MGPu+9bdN4suAvJmCF4i+2njtclrNZzy+m8ZsEp9tj2uAtuteH
	 3Y8oCXpjSvVEWUJHfyufmnVDi/cDwY+V2+aW46+0FYceJChJ61Rf1rAjEQvgEOruP3
	 b+zyVvoP6ruqolLESF4RjreMVS2iZZt5Pbzpki3RNOIRSYKmFocSn7hkC/TMs2a8yv
	 xjLREbD0l5Ocw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938FC3A566D6;
	Mon, 15 Jun 2026 03:45:33 +0000 (UTC)
Subject: Re: [GIT PULL 15/16 for v7.2] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-misc-v72-13d57389d260@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-misc-v72-13d57389d260@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-misc-v72-13d57389d260@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.misc
X-PR-Tracked-Commit-Id: aa5c4fe3ba0cb2af90bbcfa7a8ef4fefcd5c2370
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e0e7bd60d4a812b694c477716597fcb038b00cb
Message-Id: <178149513224.2410512.15315948842057732315.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:32 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:16:01 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e0e7bd60d4a812b694c477716597fcb038b00cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
