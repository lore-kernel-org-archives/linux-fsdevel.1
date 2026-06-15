Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DA2F3C0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495144; cv=none; b=d8ubqN11gwOtn4aLY96L2CtA50uuiP1cOAoJDOocBdO4YBdrUl24UvoGFUSlam3iSNn8G+hfQeiEl7S40DqLUFY1lvVXyA34M7lyzW5rJw81B2d56zRfmy+36EBXPIpdEF8eYqsAAGU30gStcCkOYYsHAXHVhWFY0F/odEun75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495144; c=relaxed/simple;
	bh=F4/IH2MhMdEjUSge6Ea7srD2Z1f4iqpttsrwy3Wg1lA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Loc1mWWp3HxF28HpsQtulvbgSh952pZEDRBUWwKmwIRoM2cV3MLeO6AtEjYqtxZZtGqf/HgYgzwvXuirPTSJnTtcg1l/+T2r3Pzviv/aDZXlcwikQntjl2zLiA/Jb1yDGSHCgT/JtNK6ffzBdo6KGKZoN99SXQXxjYks6M+9flg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrDt3l04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrDt3l04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E445F1F00A3A;
	Mon, 15 Jun 2026 03:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495142;
	bh=w7UmYijoH69U9ZLwS6WO6IVCo1rA+HeOBpqTPzDy77M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=CrDt3l04kh8xu1nm1vvNZ+g7nTF8A4uR6bK5TOadAQZC9llSVWAp3jSWKu6Hh9pgy
	 qCBjPF5LtA4Ye36ir+Ac81BbLB0h0Kf758ulva1yugDxX9jXM8kThfYP6N6T9QtNqW
	 QihK30PhJKalJu3iSSX6ZIAAzbuU/Unei5zs4PcCJIjx+20t76j8UNOP4BhlSMdnX6
	 8bUZWhkxN6bK7ANiBqs7mSx0yCdx+kXfPrGTAu46TqvjElD3TTRDp6vOr3HS0n8c/5
	 k2H/VVfZW8/kFLmsNukBY+J+eiOC0yWmylEM0f94X5gOJB0uwceQgohz9VeEwWXHun
	 QXqjLvgNkHMxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B4B3A566D6;
	Mon, 15 Jun 2026 03:45:39 +0000 (UTC)
Subject: Re: [git pull] configfs cleanups and fixes (with tag on correct branch
 now)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260614224400.GT2636677@ZenIV>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260614223625.GR2636677@ZenIV>
 <20260614223951.GS2636677@ZenIV> <20260614224400.GT2636677@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260614224400.GT2636677@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-configfs-fixed
X-PR-Tracked-Commit-Id: d53ac61b6120fa596d758ff6e22b5dcb6db21ce8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de02909ae81aa4fda213d16915adb5e1b088a7db
Message-Id: <178149513829.2410512.294347582100935655.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:38 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jun 2026 23:44:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-configfs-fixed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de02909ae81aa4fda213d16915adb5e1b088a7db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
