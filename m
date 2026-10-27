Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124641;
	b=oG1ns84tly2V+sl1E4B4+PsrtgjtNJMQSoJHVCyNS1YXFcXqEsn4hYyLHUwlD6LsceY8
	 gkY8WnUuGNWW/gP5SM9r8Xgn655oy7nf3MgB6P1B+ngOplrBRpCX+rIzR/PgqHllBjCeY
	 yqOYmSvlN3tvtFh83tL7i2WaXVFFm9vwyRWoOx6Q/GaawgZu+G/39xJ/X0BjOQ/MZ9L+L
	 HsGpz/wSa9Ls40koCGKm0sqhNYHSPVT93ReKOc7m7u5TbS4HR0sazPbBZ8zKZBPdBcokT
	 60JrwsmzNFMFShgwA+EDmF+7/AMUue13pRT8kVkCjgrQpHpDBaSAw0uCrg4sVhQvmbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124641;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=WGzbyzwbAoTb/Q7ov2lpKsPTfscGU5vmCh240mybFoE=;
	b=sFnrVjhnkLeE2gdOJ0leWYzGJ2JSTLOGOaj0g5NQ5q8jGrRtmBgWS454+/tk03LyHe7f
	 ZvgHO2vAN0AZGQP7HeoSGoMMbux4yKezPubKynWJkecOj5SigJbGWIapFg+GI1mTd3dSB
	 CRWYL5nh79Krghr+7ZaU3uyqrlvTnebSi8r8ngI5CgrpezG5Psi5/FEIdcCjydP4zvrap
	 hyhUAKvSs/MheWUhF/j3XxGwdI5fnrTsyOrxgz7oA+JqmBFTLzK3BzABBxukfxQWK6NOv
	 tSVgZcwaOvqpQmP//P0qWX664UjNC0x7jI4NgoLapeeEp0DXE4nsAXvBeLXKSZpsRPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e3dhNVPv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACDF606A31A;
	Tue, 27 Oct 2026 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e3dhNVPv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C701F01825;
	Tue, 27 Oct 2026 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793124640;
	bh=WGzbyzwbAoTb/Q7ov2lpKsPTfscGU5vmCh240mybFoE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=e3dhNVPv4kBjabhrcamc420r41piJ8dL8OoY5aOB92r4mwdQIvrpjijE1EIanFDJ+
	 BQWfHQHna8JvtiVSm1dQ4KhYo7krAN7gxlEDO/F+wRsaNTnPVoVpjpWDZrYrXLs2lR
	 6d/p/yoYALous6p0RClCzDNJC1pVPRzQyPW1OsJjawpMVEFf9YnTajYni8e3TdHqOb
	 w0PXnXhm0qsDsFAPTDhxa6ZxDHK6CwZNdg/4WkEODpEDfvpHGgYSxqQMn5YxY08gOo
	 VXhFSoeu3b16jUfOguYBXZaBZpXYNy4U2Uhxfb2jXz9nJ6gt3hgBZIDy+rTWNpQAJ3
	 3SbOL8ucAvZfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CBBAD3AA9AA0;
	Tue, 27 Oct 2026 18:10:40 +0000 (UTC)
Subject: Re: [GIT PULL for v7.4] vfs keyring
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.keyring
X-PR-Tracked-Commit-Id: 503b65da9a7e5447d91222f62399522f2f62a0fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62c457528529cdcfa32bc52b331ceca10f3937b6
Message-Id: <179312463960.245349.7676428198715580925.pr-tracker-bot@kernel.org>
Date: Tue, 27 Oct 2026 18:10:39 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sat, 24 Oct 2026 12:44:48 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.keyring

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62c457528529cdcfa32bc52b331ceca10f3937b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
