Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06742FFF8D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519241; cv=none; b=AshXipNCnlF9r09+Lsx4wniWovHyCAUBd0w7USZkYLHFKifE9b73/FsRX3jULxrcYTSqoqs2l2MvcEcr5Hg45W4pyU6Tb8cvMqQwix/8ouZEnqK4IWVCckWePcnV5CFWiI+J3DyQzuQlUa+vpYvga7avLplBgMjqWJWnMCoD3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519241; c=relaxed/simple;
	bh=dyS7YdHDZ85llKjahsTwC0i7bbRFOHsXcgGUO6+wrxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C7Cmjz3NXkp4XEK/zf3D5oMIFtMvpvTx5GNEfnYQs2WtpWJe2Q0O/eWyil2BmFft7l4QRwTZMYySEXse2WVSdPX2uhWPMzE3vwRtmjz2rX/7lCSQuqheFI0ahSMrG6w0XgucraHnYByC52j0cZG3e3qpR/zMY2zyPOBd0An4Apg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtTYlXf0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtTYlXf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537B01F00A3A;
	Mon, 15 Jun 2026 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781519240;
	bh=WOBoP43eRXWa4Btq3nXRlG35tph7XBOKtZ4YQkoPk08=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MtTYlXf0S3S1rvk4GnkDlfQPTF5B/LqD7Mlr3D4mU3Ua9NQqz/jKXgONU5WGxtQlF
	 t6f/JKV26dSZJwxXa19VQcc4+gCaMmgi2FNgy3Mfk6DUYqs1FCciX5fMvr17bcgTcK
	 xbCHXvUzkY/VdpUfCcS2AW4hcYsZV7c9auUnonMlp5gbyqhfVB6Jijk4WbCp7EOUIt
	 i825Q6vEk0a47NJOzzBGMkP/NGOJ3VZ2eztOIyQm7IIl5Ij4l793q2rZ9PX5YFbSlt
	 qFjtOH4vbK0HvK7HZuj1J58PVPjLFlmjDVMQgIhY+VxTwK0JB3ED+820plD+850m3D
	 K/ioRBn+1rdAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CEA3A5676B;
	Mon, 15 Jun 2026 10:27:16 +0000 (UTC)
Subject: Re: [git pull] old udf fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260615023621.GA2142293@ZenIV>
References: <20260211201845.GN3183987@ZenIV>
 <n7blo2z6tk25p2pkjk53ifm2p2nejodngojrnmgdcr2bqpv3m4@up4qbcufnfii> <20260615023621.GA2142293@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260615023621.GA2142293@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 462bdd08fbdf41db223c6117d907c8fd68d666ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e0611827f3349d0a2ac121c023a6d3260dcecdb
Message-Id: <178151923552.2993796.1451822288554028899.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 10:27:15 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 03:36:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e0611827f3349d0a2ac121c023a6d3260dcecdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
