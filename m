Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1593EC829;
	Mon, 17 Aug 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005583; cv=none; b=LO8J4rf229e0FRt2X5w7aN0h/lzuXjoGZS8aS91cls9IK+CYYxy8WPcPuPdUdGXlm0Zj7EMnDhjJMFrdg+uNANhsqJOgGxur0NSFIscnw909OT34eK0/0Jlvcc1gKan0anvWOn7YT7xGGr+CsTkXCfKeayuWnvD1rCsWEsBzNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005583; c=relaxed/simple;
	bh=cd5jAANHjoYIW2Fn2ayhjtXxqA2II7FnsVs+tygT3/4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lrq6ak5hJ3sZQvxSdUK9feeZdAPjjQK4AlhR9JHZa0sGYq1FMa79BHi/lsAg2yt297kY2Rj5HKWkXI5Wqq0FiKuhD1KxmV+TAM6WCbTjh6kPJue/PHZqjEl+o3Es8OUsXqHaM5Xb3o4XFXrjqUDt6oc1tEUb2uAAuFXCGQ257UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzH9CfFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzH9CfFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477D01F00A3A;
	Mon, 17 Aug 2026 22:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005581;
	bh=6MuwteoA7Nf3qLImvPmJSn2XEGety4DdvCiqWkCdJYE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ZzH9CfFXirFD4k36ujmUyBZODrkpVPARMmDgAO/5SUtr71PgP0OFrkUqTKXZUo/U+
	 wIfpYAtINrPqWQclF6l+JUFA7t81pGyTDc70r/ircOQ/bLjSbWhJtzqM11F3AVZchC
	 puSANUZ9/EdTSmHFd87pngI4RGxQLHJVWRWZWkZk8gr0ikWQPrwxUiobEDazWisvy1
	 93xQ/b7bZvUAbaWIjBZWO9T8+iLTWsGI3WY6OlyrPmRVwEwz7oRK4l7GVw5qHq3ne0
	 8BT5ZclTu3eyhkZ/GyfGzXKE6nyq5/jxbUF9smiQcbRNKrlMomUkguQJPpxn/ldpqm
	 KuXpTjRdD0qgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939123926274;
	Mon, 17 Aug 2026 22:25:34 +0000 (UTC)
Subject: Re: [GIT PULL 02/18 for v7.3] kernel misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-kernel-7.3-rc1.misc-ac735b47a231@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-kernel-7.3-rc1.misc-ac735b47a231@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-kernel-7.3-rc1.misc-ac735b47a231@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.3-rc1.misc
X-PR-Tracked-Commit-Id: d7337cad4dbe6caf9535d3539daed353dd425dc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 043d7a2b4045df5eebc699c39bc3a571afb9f1ae
Message-Id: <178700553321.1769471.4676345139931022730.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:33 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:11:13 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.3-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/043d7a2b4045df5eebc699c39bc3a571afb9f1ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
