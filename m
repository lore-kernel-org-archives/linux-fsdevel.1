Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B5B2DCC05;
	Mon, 15 Jun 2026 03:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495119; cv=none; b=EIREyp9/ZT6VIbifKJoaCaHjERP+T3o3dBP4ye5PGHMyTHVXr4EMWZGFjh3O872SC8wJwZ23JKNZ/FOGsymR6uA4F1ES9IzON3rWuwGlCeHm1CTQNXqTPHNzDqkIUVZNBIqFIP+XxrKQzLARW6znhBKE1oAmcANi/0YEZqBQfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495119; c=relaxed/simple;
	bh=pJTBmcIZSlZAaph2p52SbbNQWgtob26PfkiKmoByv5A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aNXlV/1xZmaUdQxwc26v1GpV9rKQelbyarkT3BcI6pq3vtj1kQIQ0TxhOy0xJg1Hf7WwQE2yUcv0lhw5TgVnlSfLA2h1+1rWPZyyKAk3oBBZmFjmQHm5YmmHjHob/7LYDd4XM3FNReWcO1MNJ2LQ5vZUKXJZYaat2+k3rwSmGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYzlg9mv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYzlg9mv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F2B1F000E9;
	Mon, 15 Jun 2026 03:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495118;
	bh=zRdr1ec/X4o7e6OGOUr/iqUi1Mr6Vn3FErc2s2eLpoI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=eYzlg9mved5lJnNZ+5q2rVhPByE/LYrFQpDztOpBBaUz84jBnsSCfnnlVx8mlalQE
	 JGLTLcACaTqrtMMjtT79ZbJeb9sHoRtGRWjzuynNhxQJvPbjWv2r71niUudu5HL7IU
	 XQ5EAQPQt5VztMwZBwndpcFX9PD8JGMOmwYFV2fTM8CNqOqEsc4ss42oFIYN21SnfV
	 ZZt4JIyNixEzGq6ji2pIDodqyX2mAgqoWz6GNwyjKpvYMGcindpD6L/fpYi44hjZq0
	 kZZHVds7rbLQ3mFHONndZWfuF9aoP9v8RMy4pddovliRD2V1Rh+UHjw51VquxUS4Ir
	 DhLR/PlQkoBkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939B23A566D6;
	Mon, 15 Jun 2026 03:45:15 +0000 (UTC)
Subject: Re: [GIT PULL 03/16 for v7.2] vfs inode
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-inode-v72-dde1140216e4@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-inode-v72-dde1140216e4@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-inode-v72-dde1140216e4@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.inode
X-PR-Tracked-Commit-Id: 5b451b76c85c8309d2e02caa467b38f5999c986f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fac863c887a05d7c3091c5eccf30c89c2116ae11
Message-Id: <178149511423.2410512.15931730429412309316.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:14 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:12:09 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.inode

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fac863c887a05d7c3091c5eccf30c89c2116ae11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
