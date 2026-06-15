Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F342E7361;
	Mon, 15 Jun 2026 03:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495124; cv=none; b=bUgUUagPVgvsPzbH8k1TQ7O7gu46Mm54tdSWhtAKXWgeCk8SDwdiPyKrenClo0cjK3NCawk/yuavkwMx0Xu5Vv1kEWTU1yLbJB++gmzM2DDvgo4DkNlWtsRJBPVvPf05C2CFppTUJLf6//13KK3f3msbFdzyx2OLhBPJQq+IbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495124; c=relaxed/simple;
	bh=czLqOJF3Fg3zHPv9eoAAOcIsRgkFYcItuqD/9KFrOmU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D/D1eVujh6ZKLrgrUwyz/kobCWLcg+Kl8ZjGjAfnbjmKkf2eubrXxkCFiVpFcwberLW2RdEJ3Ezme6nVaOsVX+oTfxLBaLNVhfADxGQJYC0VYik1KCIZkyoBffdMjvpXevwjg51JBTpYnC+05tvLW7OAmZH3EaGmKSAvN/CBNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKaY7SjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKaY7SjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8B51F000E9;
	Mon, 15 Jun 2026 03:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495123;
	bh=y3ZJ3JVUNkQv4iyxT3eRF3cxc6zntwItMsw/r+Oqt9M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=fKaY7SjUvcBoaNjSy+CTaU/aqgtf9gPFxya18a9ToYeHVM/aBbgSMNe7WVvk2G37e
	 HDxtgtrPtI+QMXGdaaXvlDNgx0keYNd5aT6HqWSDOZGnP8d8byyJAlHBm0XtWJSeXF
	 9TfF84y9D52ckYpF8FTeT7CHP217uHXQsp1k1gEfKvPU62XdZW161tlzASyaNCior5
	 ryZg3xoP9xqZeDCsHYWp1lpXmNytlNU+2pDlafj/PrgQLPrAXT1wkbD+qM9Ftmo53e
	 LcvpvWL0DVjeaD5eBjhUyNYny6tc7LV7/Xb9ikRp+ZWYzzzNZXY6z30jDYYWYFyZJJ
	 R6kulLN6jxLpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1981B3A566D6;
	Mon, 15 Jun 2026 03:45:20 +0000 (UTC)
Subject: Re: [GIT PULL 06/16 for v7.2] kernel task_exec_state
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-kernel-task_exec_state-v72-c39ca82510c0@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-kernel-task_exec_state-v72-c39ca82510c0@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-kernel-task_exec_state-v72-c39ca82510c0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.2-rc1.task_exec_state
X-PR-Tracked-Commit-Id: 38205ecbe6b6dc47968ad4e9c978e2117720969e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c9e6bd4cca02f2d183eb260451fb6018f9ee67e
Message-Id: <178149511873.2410512.6848485661273618443.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:18 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:13:03 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.2-rc1.task_exec_state

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c9e6bd4cca02f2d183eb260451fb6018f9ee67e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
