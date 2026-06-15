Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9760E30276A;
	Mon, 15 Jun 2026 03:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495127; cv=none; b=q4iloO8XshDXxNyW6yWE1wjrqVthC0P4cUdc+jM3rkgf9G43T3x54YsBta4BjRrXLOWB9qauMvxk+But4UnHGRocyDhF/3kiASXyroe7s/AFwO+R1WX0EPi1yklsL1YFKrum9Uu6D49giQ7zmLvT4+p3erv2OxuKAEyaNhHaVjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495127; c=relaxed/simple;
	bh=4UbV0tWkzXzfFbbL6yXc/awSL4qMW/wczEqqj7HaHFY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kdjbSKNCNfMYhdQmCJLmRpDzpjGQtM/1hMw9glSKlWmmWiQjW0+/GHcqUa8b58bUCC5sKrHT47YeZW9OPKms4MvCHdUgw8z5jZ3zKYKhxsZnF0ReaRioTT+FlE05vSO3CoQFZe0Dkh4RbmErrJTaRo3haEWHSifUq1SzaZOAhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1zceAtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1zceAtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2591F000E9;
	Mon, 15 Jun 2026 03:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495126;
	bh=57meZBgxEsNUPd1Ah1o8g/Fz9LKk4OYQYKVKDMrJ+W8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=D1zceAtPRiCXQhq/IC2PJ7Epj2Nhneybl/q4Pl5mJMbfzfLx3ddTArM/45Awq7n+X
	 yyzJCcESjx6mYrWX9g9rp8d3Iublr0H+N6bCj+YjXIrMMuFJB1tDYgP7YJ6CrxB7Dg
	 +1WiUsbrmnpw9mbBU5EI70WaklYJleAc67c7dLv74KMDLSNU5nwpaJeYdPQ6HDkiau
	 8OibCUvMiEakDF6pBO6U4ZdlCva5CeeKSJMM5/2HUOW1dX/Ox8vP3CGrdu2EvAymvh
	 eVBuNLBl225N4e2Ctzt+E/+8ZAqp7L60CTnkToG6IRrah0W3W7aFgUfqXqS8ynD8wC
	 Gc+t5D8dsSBYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198F93A566D6;
	Mon, 15 Jun 2026 03:45:23 +0000 (UTC)
Subject: Re: [GIT PULL 08/16 for v7.2] vfs openat2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-openat2-v72-268139f61842@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-openat2-v72-268139f61842@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-openat2-v72-268139f61842@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.openat2
X-PR-Tracked-Commit-Id: 318643721de396012da102723f337f35ba7ec1e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50b900c564b0f0307c126de9f17c21d3a1ba039b
Message-Id: <178149512173.2410512.3524268831461105104.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:21 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:13:40 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.openat2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50b900c564b0f0307c126de9f17c21d3a1ba039b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
