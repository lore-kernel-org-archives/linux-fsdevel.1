Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ABD30E0E4
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593723; cv=none; b=hsDAXuIo0uQ5rdqarZjShghKkbwQVmsHEuMRxEedpX/uUbG/e8qAXyWF2FO1bBbojlHdQl05xedBKDDMMvsVAJUpw9zsonCqX87F0acOMNBct1/l1GT4puJqmJs4Eu0voPZMbTA5pav/cHBwF+/E0pvvPpyqfAMlNpPRF8CAvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593723; c=relaxed/simple;
	bh=nrakTFQIpJjeRZ8Vte2wYc7dZIUYZfxvdHDvw2MEm2M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hC/1hf572jXtox1F4WR6spmaNNmcp3D5TMwkdX9PGNxmRfwtxTm5UKIGOMMh5+nraB1IwMFMnNZrGBS12T6LSpGlQzRPH6pNiGCRgFzhf3kYrsXvrqQJw/IHULc/l6ZC6iVSJpGIa8/Nv60DXy9Wp4icO9uE2j4I5DDWYgnZFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4LwOkJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4LwOkJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8431F000E9;
	Tue, 16 Jun 2026 07:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781593722;
	bh=H3bsakwx2SFrPN/weWzRr7wtoFcPgFgvUTaZ2flv/Og=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=T4LwOkJuwEd5KE4+kakZCXa9/kgTdeMKAvBLjT8J68lrfEnPL1ZE9sOp+q2jRNWWZ
	 XMMdK2urwGMob6p15skX6ikbVWgCNsGBXLDVn44ml/az137mCNkfiuZFC2E7MKv4s5
	 5adVMb5PTzgFyw1jOSJIsmo7Vnf7bYomb8C4r+KrKwfGC1mz+wC72lJALjFAzLPHR/
	 /TYbfPmrAK+OEj+wZzWmnyu89dNhKWIXyqfcHdW5CmxD7DHlrLBchiOlSAHIjMBwaU
	 1fQ5hQNtzuw2QSb2W9oLGNNBJWkKt9wrvBTer802OtEfPyiwoODZyqPXHYjgL0tZtK
	 gDa7R6ZM7Lh1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398F383BF5B;
	Tue, 16 Jun 2026 07:08:38 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ljorgdnz6rwsg73eozwdg4uzg5gqdaazqdv4lyyt4nuc7b3ouy@vdbnsxmez4t2>
References: <ljorgdnz6rwsg73eozwdg4uzg5gqdaazqdv4lyyt4nuc7b3ouy@vdbnsxmez4t2>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ljorgdnz6rwsg73eozwdg4uzg5gqdaazqdv4lyyt4nuc7b3ouy@vdbnsxmez4t2>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.2-rc1
X-PR-Tracked-Commit-Id: 82c6dd20479bb6a9625e1d63a650c3be8865e2db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59b1c2aa064fdc4b91a26dce83697fea47cd0a61
Message-Id: <178159371714.494683.13119185833923621622.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 07:08:37 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 16:46:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59b1c2aa064fdc4b91a26dce83697fea47cd0a61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
