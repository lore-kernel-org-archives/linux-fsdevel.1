Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DC3F3269;
	Mon, 17 Aug 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005603; cv=none; b=raT7oxsDvNcYUgHSyCJ8k442va9PE6PGjN4vEpmKOHSNzHiqHWZ4f57xEClNErbS0EN0/hMfwRzZWOwIIbBWMTM04FOTCvaV9DmoBm/JA9He+0V6+IwVlA6KZvNWXRYaFldRUoMqysR6xfEynutdHI59yPgHd1yz4X9MwTSKiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005603; c=relaxed/simple;
	bh=KrgFjt1db/eQx2+LTgwYXekljwskKgzvuNwTpPdoKGw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BJ+FqgGUgyoPdexRH1Lnv5cRbUEWup4Lf8uWWICQvsL/q6+mkUhb3HtI/GdwtvFeQnrnTObsEaReGvXggYPQTu0EtgafblJGKUZH9bfPlN0PP+852zYgrL45d/9ejRpgZfistM/yGekpPWWJXT6mFVNbnrhb3zRbMaOY2Pth1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq1RE0ig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq1RE0ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB711F00A3A;
	Mon, 17 Aug 2026 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005602;
	bh=S82e61Tuayt+5N+WhNbiYL7xIjxIbg05wf19x4jtNOE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Nq1RE0igxWxIVUV2yBKpIdm28yqaqMOihBaGcJFd2z/MBIcaVzpbfPDSKZ/IHdct0
	 rN/GlBgqSqnWer2J+zQ/zvseaFkgQxPNogGrzniNJQR7nB59yMpaa/EKQl2wwYhYyp
	 xhDapgD5P25unVi+MioA2V/69fl0pAz3sz7LGZgcqskExLJajQNmFDyE8I8jJnVeAA
	 WESp/iSl1f4NThm6IXmNxevDW8FDMgSNSngNK9ce+OZNCIFQdX2b3+BkmXg9Bh3fuk
	 JIjeSXq08maxFa6H2XpLJ21oza+ymVhY8m6Ym/g31R0KXdYE+egmQCLK2q2kjqqrd9
	 UqeeJbxa8C9uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939CB3926274;
	Mon, 17 Aug 2026 22:25:55 +0000 (UTC)
Subject: Re: [GIT PULL 17/18 for v7.3] vfs super
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.super-03a7095ebb84@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.super-03a7095ebb84@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.super-03a7095ebb84@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.super
X-PR-Tracked-Commit-Id: 9ac8fd831252e52aa78399eaccc11a72f6c2af1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1781f0b3d75caa22376cf7fa0224f9aca696580d
Message-Id: <178700555421.1769471.2659293399695298395.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:54 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:14:46 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.super

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1781f0b3d75caa22376cf7fa0224f9aca696580d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
