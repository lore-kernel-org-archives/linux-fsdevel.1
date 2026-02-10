Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5930AACA;
	Tue, 10 Feb 2026 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684629; cv=none; b=mlhCWOX+XKqp++3IqkP/I5oFRGbDLDB3Lpd+3tI8MWm2KoFUiEiT8YCBCznxBHAkR/JrQoKMyFVD76b3itBdVzdWIkzfscQ9cM2thyQz1XG+nIIQNu3h6XjF7RKqDeD1I0Er9lhOG4Jhivvs86LRxjRO5CQu68YuENujY/1qRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684629; c=relaxed/simple;
	bh=mcpK02ij4mgg+64tYNDULW54hK99ld5ja0Fz9oevLCk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QwaotMfu9gmfmmJiDKrZJ0EqHYeFkYzANZS1mH7XpwfU4KqeNHM+cmXWfx9uJyKBiVASkJ859SwgM1vJ3f5ztUNj2r8vFPYl+0bfqaXF4DYDFAbIrZ8VgXNYynt+JT2WEvliMzPfeEhPTteYVSxnxOpsgSSymaPovr3x8QMzgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKLkx3Km; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKLkx3Km"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16284C19425;
	Tue, 10 Feb 2026 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684629;
	bh=mcpK02ij4mgg+64tYNDULW54hK99ld5ja0Fz9oevLCk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UKLkx3KmyRJr1KwHD9cUMmiFy64Z6chEDBPr0ZvHGgJyCbZq51Dv5WImMuWJiNCVG
	 iS2rlxR3am4UR+YWmwMgmXZizziwhyKyUqmRfmpgD6LEHBwUpB0oaVzD4pCcZXDIsV
	 GtALmE4fCvYQXEBSxMbcEnG9pnSlDqH69or/2R4Ad6/RXXHCFDKbcBwsvB54LEG44T
	 PWW7uNq1Fq42y/GIXYlJ2j3AOXhEgTdEHsUgv8uJ75n/BeZRj/rQDMa9l5M1y8ISdQ
	 p8FwIbqQKJkrKVFv0tmcC/snliTCVImQY/6iZ3AlX2+uNWEl35LmHxeWgBzCmrzGiu
	 ehHTWSBR4JeBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0ADC9380AA4A;
	Tue, 10 Feb 2026 00:50:26 +0000 (UTC)
Subject: Re: [GIT PULL 07/12 for v7.0] vfs minix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-minix-v70-94555c213288@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-minix-v70-94555c213288@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-minix-v70-94555c213288@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.minix
X-PR-Tracked-Commit-Id: 8c97a6ddc95690a938ded44b4e3202f03f15078c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e01a69f5c4f2a6af2d4cd1cc46d48efdeb98230
Message-Id: <177068462494.3270491.16847033616714525122.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:24 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Feb 2026 17:50:03 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.minix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e01a69f5c4f2a6af2d4cd1cc46d48efdeb98230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
