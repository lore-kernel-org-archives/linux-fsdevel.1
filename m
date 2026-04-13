Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8AC3BADAA;
	Mon, 13 Apr 2026 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102854; cv=none; b=MXiOvVj8Afshu3iTs6O4UxceH2MyJEdHQWgpJdlnBlvvlTlhVDjKHJnv/ySy1LUDRVtNgl0ZklVqcQV4I4Qytbb0TNQhWxEsRq4gQPXCs5Pn+rcPmeCtLAS+FjraVTGPtHvl38NVaNaNxRABZG7i69tG+OXz95ZdYBcIROyiKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102854; c=relaxed/simple;
	bh=pYznf0udXl55SpukRIFYPS4Vh3rHl8nSeD/F9VLZ5Gs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LpBYrR4ZIss/oB+2m9aOGrBPg7pvXrzgE1wK3i8/PKVUxhrcarJ3wSwZocstnXDhcLnO3lNixsaAZs3pytTwPbyR+se+U814WvrOXqFOAHkL6EOqCpItrM1WYb0or6jd2LLT1VjkttBXi/T/M8gZkl/FdB7yHId0HNRPGKwS4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBFeQFAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBFeQFAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CDAC2BCAF;
	Mon, 13 Apr 2026 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776102854;
	bh=pYznf0udXl55SpukRIFYPS4Vh3rHl8nSeD/F9VLZ5Gs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BBFeQFAJ6BcUedJqxy0wEMBtMSWhGH2vDC550LPOBddjEl9MGws7sg+PLYuMzkjLE
	 +YtJ6lidWqsTf6PP9iQhfjYsAGnlrbxi1kU7Wvm464KSrcO42cC92T9VAIUWZckskj
	 jV0Pmf3RZcDmi8nqhvp/LllHHwcBoMxwUWYHHhz/D1s9hVEZCFZkBJkKHFzyppTWLE
	 st9jIedHxJ8P599PzT2TWg4ZvB2pxg4DIY7EQWExKhmEJK1L3LB2k3Y85Dnaah21XD
	 emxlY3Olmb+ZDcU7zz12NX0PSyqmmeVUXxlu8T0jrgMqGdvtqFqn+QFmdVpjulK1fA
	 4CpWcWq1Nk+Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD8A3809A8A;
	Mon, 13 Apr 2026 17:53:47 +0000 (UTC)
Subject: Re: [GIT PULL 03/12 for v7.1] vfs directory
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-vfs-directory-v71-76a569f63c00@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-directory-v71-76a569f63c00@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-vfs-directory-v71-76a569f63c00@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.directory
X-PR-Tracked-Commit-Id: 9c62536a958ffef246b6f7c01125ebac962158f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3383589700ea1c196f05b164d2b6c15269b6e9e4
Message-Id: <177610282618.473774.13223739463343223170.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 17:53:46 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:16:51 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.directory

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3383589700ea1c196f05b164d2b6c15269b6e9e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
