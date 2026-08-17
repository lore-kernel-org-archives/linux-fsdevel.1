Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60416470420;
	Mon, 17 Aug 2026 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005600; cv=none; b=p/wO4cF9lk1CBW86VLfh9v71di0KegMtUGb92Q0aA7tMLuPkMYP84//+rp6IYQSJiOz6pqYpKMqGVIfR81MOpQcxiEOquVwZy2vwQgHb5BEiI3d23kkWIzopKBqKDYgUxd8ZDmfsOiYb4+nSNpisJI+qv47DbM1kF5Jt/X/WzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005600; c=relaxed/simple;
	bh=+IR8XVKJvMWFY0LHmFRKsTTYDLJRtEX0ITqn9CR+KOc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zn3zxgyUaWLvboAIqtyJRoSwAcheJFaAVH7OUlU5gDmTvEnv8sdOAZ+lYQlyH0aUdUcjB7kLtBtatiuOFO0jFpee6WnnMynt1k199ycX/dcpqRS5s8W6GIUbP9s6Z+S5t4coI3CqaWUybReiA7g/Gaz3VLOkLz/8+hAvY5xIYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQWqrViD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQWqrViD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BC51F000E9;
	Mon, 17 Aug 2026 22:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005599;
	bh=wJNO3r+KnL4QW6YmlcF2uuxEf9xEOE8B6Lya3M5OKwo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OQWqrViDAct/Ae4PZBe0I6zVgirU5Vp/0DG2wktvHWVvnoZgsIJsElTAUjH7otN09
	 w4PZ1iWuWCNH8Zstw0MQHoVWRu+T8/VfJ8o9sV1j2fv6qBM7M07NKS3rF/EzSjFNi8
	 fqWMdd9zM5GQCyDXqgflKvQr9DvFGsv7jrM+Ijt87y26DjraKfDzv3oKCcfoNsFJIm
	 AEba044LwH2J5CtkqhC0nOPn+8eOJwb08JIDPs4On3rNhYRmOZQz526/etSjkwfs8q
	 osD7Xubv/qbGQOK7lYca7G+nIhEnYePaSyQTZj5HT+LITS9K9CEp+WZkGm+ZxAdsCS
	 VfYD0pnSfHJ8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391C3926274;
	Mon, 17 Aug 2026 22:25:52 +0000 (UTC)
Subject: Re: [GIT PULL 14/18 for v7.3] vfs netfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.netfs-42f8f6e415b7@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.netfs-42f8f6e415b7@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.netfs-42f8f6e415b7@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.netfs
X-PR-Tracked-Commit-Id: 949eb95d5bcc530e6ce74cc95897c1849c53ea89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55668d04e3a821281f885e59ac951a22525b78e3
Message-Id: <178700555121.1769471.40985524834449943.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:51 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:14:05 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.netfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55668d04e3a821281f885e59ac951a22525b78e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
