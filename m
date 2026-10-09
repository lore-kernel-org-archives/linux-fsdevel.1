Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06E3E7BA8;
	Fri,  9 Oct 2026 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583436; cv=none; b=Co2KwTxFqv4QymKOhEtidZRSgAknQQpKtcBP80iOCh1Ynpa/K54hHAYVFAdo7/o42vwpgepYOS7JaSy62CSORX98QG+dyJ4fgKe8Fmbt8Uo8bYU7RHIllc6cWWIXUfoR95nfN9C3hsuUxHrokxA/74dDy5TJq76h9+o0jEGkKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583436; c=relaxed/simple;
	bh=3p2CjFQg/k38GULa/dAS3YL9bB9Td4ndLa47+nNtNS8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KRMH6AFO5hG7XrlWS50u8z6aJ+KyounQfp4xXXwsFjHYnqEkTMDuKUqT1Ztp+AjU+VonhfMyjmLY6B5qrus8C6cY8lEsVkIRBwyX4gEgue/OFKdmnQirkaseNBOlpa42wRHas1TsttP7h3RJlweQbhNvM9kTGWukhe1CtCha5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI8BLqZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI8BLqZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C161F000FF;
	Fri,  9 Oct 2026 22:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791583435;
	bh=D5cPBxG3QKLd4HsAm614pyHUY1h3PdtbJUC88KM/v3U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=gI8BLqZSeZxU9DsbDpkZc092Q0S2HRuTTSKPs07x8RSlZx0DT9vJFLX5N6O/ien2a
	 z0tQ+zC69pPUfT0Fuspw3mw4UAXOlyP+JynViA4zS1xPKKsl6ixGjWBMgNIcFF2FYG
	 OhMsQll78H0qNRK0u+rRDMC3zWUwCQq2b5o+WNOef6nI9Imv1HMw520xbXvhWQY61K
	 KHbIcjyeuvMbyDRQ/lrj3L7CXlVzRN8azMndD3MuM0DB1GgclSw6OTOyVIWSBhp+B9
	 5jMLl07R8lp7TIGs1NJqu8mruXnab/xDSyEdU3bP3JniFlBd0zTCUNns7rIcsO88ou
	 czpJKQoy1sc/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F17613926392;
	Fri,  9 Oct 2026 22:03:54 +0000 (UTC)
Subject: Re: [GIT PULL for v7.3] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261009-vfs-7.3-rc7.fixes-cbe1a4036c84@brauner>
References: <20261009-vfs-7.3-rc7.fixes-cbe1a4036c84@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261009-vfs-7.3-rc7.fixes-cbe1a4036c84@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc7.fixes
X-PR-Tracked-Commit-Id: 3d399224425573875b6f6f1181bd8cf9a28cc7d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f99005fbed4e8071110faa350cc5fa453afa1455
Message-Id: <179158343343.1020838.9563885859981864426.pr-tracker-bot@kernel.org>
Date: Fri, 09 Oct 2026 22:03:53 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Oct 2026 11:05:13 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f99005fbed4e8071110faa350cc5fa453afa1455

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
