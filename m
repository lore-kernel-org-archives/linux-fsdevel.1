Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A030D3EE;
	Mon, 15 Jun 2026 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495135; cv=none; b=qwcUArsKJiCRcCOwxMhCfQZU8iKoH7YR+Nh8VizH5jEqXwBa1ETAYUAtxdW8QZJwDkKgdKRVwv7KkPRwrm6sW1zwpbIvbZd3SmTojtiBx7+sNdUvU6XEtCVrdwMhmUQoNIu206ao5crtvW+t9Gbkxa4VhI2PxVqEQnYfY1ucgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495135; c=relaxed/simple;
	bh=o8+6Su3arol5JnD8s6elDlMx393ryYVmkSO82AF5RII=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aSUrLv6pg9ITK7j5ag+wlIjjA4jXmxNCjHSdPR72E90wcA8QeVyEAYJAwD9NcjtDCmycd9swmiKZz6qM8PUwEhirDxZE0PnA1tCbPKER+xOyK9zrw8StMXSUGJypHbxC9MY4Fd09UPctGbx9KbDDfJ0RdSrZeyt8YoI113/CFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KovBUx6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KovBUx6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C8E1F000E9;
	Mon, 15 Jun 2026 03:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495133;
	bh=ZefJ1UZwFDOB7K92rgiFoC9xVO9obJ40BhVd6B3k99w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=KovBUx6+RmjowJycifflEBQ3SoBojL7MNtSD6FEFk/FI+qQ3yoMuERynkLn9TgTHs
	 5F4rvTh/XGNeT0IrPOCwunCZpmi8o73ByPWpWU8n+nUcRQBa18gg1S15ieWvQ/h8iK
	 fMDVEUeEDH/AHALNnInxCJnqTTJokJcnNdPmsSaFQDZcdmx952vLzU7nZk7i8skisu
	 Bg4ocJZJoocaaWnrGmeUC5KPJ05JcuLCM9hzVIxNUqugcaGqAVKoh9VpQRxZyc978P
	 ahgdvXHzevyYVwkU7BWdYjFOBc7HdMZoEpqkTk5R1BXM5XOvpxCWbeN2tLiQsrl5Kk
	 RIJhL35B9WNFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939753A566D6;
	Mon, 15 Jun 2026 03:45:30 +0000 (UTC)
Subject: Re: [GIT PULL 13/16 for v7.2] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-iomap-v72-3c93b1aa4390@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-iomap-v72-3c93b1aa4390@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-iomap-v72-3c93b1aa4390@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.iomap
X-PR-Tracked-Commit-Id: b7bae6880e8de2a5f693c18d87ad5cc26f157eb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec5d1ae94e99d8831427d00973da5620c7fb4368
Message-Id: <178149512924.2410512.5629580347936714234.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:29 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:15:26 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec5d1ae94e99d8831427d00973da5620c7fb4368

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
