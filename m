Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480350;
	b=myR9Ro0WTjdxslCrhZuPNCh7vB2HAIvptzDcy0dIgp6drFtGV2693H12LKrtIq/xKVBg
	 l+Eqr7FbVtvStKzw8q27RS128l/eaoK/RkMvOJJQOe+FDPIMOpADp6OhCPtK9S631cefn
	 D2dJOqNLX5++nFMVzANGWld12V2yyqYjqQL9c97NMGi+N6VR+Swbm6y9VRhwapqCECzD9
	 7ObFRxZD8RrVjPJJ29+7Dtvg+boc0/qJmD8cpsqY9vEMkMKpiAhHjcHQpRoRHau0ZVszR
	 AZR5SGTemKaOkZdd0OgxnEOwMPgNh449usGhdsMMshJnfXNXKhur0Sf1QVgoBK2xbOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480350;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=dA5CstJnKJEaDH+6stsAsfVsuEFZsLNnL3cLj9svN5A=;
	b=z1v2fjWXjvNT8gjUpvhgFCO6SllrFDlTesSkbq255L3tBGgcytB6N5+jwbrer3ilgX6F
	 wTayRllnILHXJ3bBPt1+OJRKz8doqIGmQUQ8AjleRCUtaBHQjomJNHpyMcNaMcutJK69m
	 KQWxwpNXl9QvvQB5rFsJKP2viFYkY2zCbfyntD6AMBBMTTAY2vQScfKgh/4jx5JUjtXpc
	 i8PFSjP1ro8ZCuubZnNlshHdkwfWU6lg+58WG9avVDLdU5g6QCJXUvjRiNtbKahWHhjTt
	 Cl+7xKLlykoWCToyhT2ITMcSSWu1R7TyKkU4jdh7aqmhaLuXzHyUyqEyNsQXZaSDrXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dE5HS9Yd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F1606A33D;
	Tue, 20 Oct 2026 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dE5HS9Yd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF20E1F000D1;
	Tue, 20 Oct 2026 07:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480349;
	bh=dA5CstJnKJEaDH+6stsAsfVsuEFZsLNnL3cLj9svN5A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=dE5HS9Ydb/Lch6DsH/x1cAUPUJEIppZQks24ubp6VtjojXZuaJEpuR+lprfVRncJ0
	 +Djr/Zo9bytyrb4Q/GtBh+ATyMkEWaXCaur1+qqGhvdqX5TatjeDWCsnT+qCkfRVw7
	 mtGB3UGLW1U8ox1ob2TYj1PGkThXUy9JVJOJKPaqgdTVZuFiRJKmhKxIVngylP29mw
	 VBCjgzmxNE3OQaI9IXCfx6yLBoloNjAw2LMYUtnfuYYh0QjnxhSFypCQ52ENfjfYEz
	 gI8kCsPIuzRzwVQbpXY2hb3HDlVVXXlZpfC0kRkiwN5Q9P8dMhgh3gEaFuYTygGFe3
	 FtI4Zt5QR+sQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44223924FD0;
	Tue, 20 Oct 2026 07:12:29 +0000 (UTC)
Subject: Re: [GIT PULL 17/19 for v7.4] vfs shared net-next pidfd
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.shared.net-next.pidfd-c9630b566d79@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.shared.net-next.pidfd-c9630b566d79@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.shared.net-next.pidfd-c9630b566d79@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.shared.net-next.pidfd
X-PR-Tracked-Commit-Id: 96bd708bdab49bea550070d935198ad4f2028a73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6656aefd328d544420ecec121fc898b7f067827
Message-Id: <179248034823.3535438.10149213982862606161.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:28 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:26:08 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.shared.net-next.pidfd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6656aefd328d544420ecec121fc898b7f067827

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
