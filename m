Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480333;
	b=TcVIcBEnWPQi9UsbQDXhxPu1cY2DOehnFyv9Wd100/HZvP58iCnxUhrUHFXyidhbXiP7
	 kX2rJXF2U4CBgnjwm08pvpUY5j0cPwoEeXAO+MAVznkiDQ9kOyfJejwANmS9OKhDWBylC
	 nFZmXr+D4gdM8SkQawkYv3iSd/qihnOLQHCe14DCb7HnsNbYh8505oJ6Fk2OzQI8/RSLD
	 ugMbv7u1sId2QNOfgAMrtSm9d2e2cNudxmfUoQt8gJPxl2zMxqRhPIssyAyCzPADn1qT/
	 XmyF0EX6pRYynE0lnBQ6LgzxvksCdQhZGdbs6HMHYVqSIdeYTy0tpkb768uFM1RUcuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480333;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=cMHugrmOEeHYGDRHb3GmOIP3ayJWNe1wrUuCVrKpLbQ=;
	b=US7Hsg/zGn2TDH/fcFs3Ld+grq3l984cifVv4FGqMzMB/uDg3s7ly8+9RQMTI8llsU8S
	 LFMzwaEf2qZC1n6s+0WajaluxRf2k77Zy26qjc3YYbZ7mn9T8n4nWX6CQLL38HfSWLaEf
	 smE+TUAcE9tO73BYPPyYXX6fdGUu3q+quT33s7e9qdCAVPf0qXf1Fu5TQVWeMmHCaJ9hC
	 ZKKXJk4ObRBbk5+GPmEGunSNBfnWduoAm51ItOQgjopdNfQxfF6DpTbRMwsrWInkFS4A9
	 MOm8SxOMexgIJ576rEFyNo55yAVDaHGJi6FCZFOC1OVbxCfNBA1w4gSPM75tQEVD6uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpE8qV69;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650A606A333;
	Tue, 20 Oct 2026 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpE8qV69
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D731F00AE3;
	Tue, 20 Oct 2026 07:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480332;
	bh=cMHugrmOEeHYGDRHb3GmOIP3ayJWNe1wrUuCVrKpLbQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=BpE8qV69gCRqqpEBi8Y+EGbRPvw+TKYwUCIsHaFQMz1z9W2QwAR3/bkHzTF+LmEuy
	 rITLBkSjNON5OhHzZi0JZxhkyHrpVKQbfDtbhlOu/rtOcG/TC5sqBQiTUZq4gmAOeL
	 yYGcMVnyXiwf1flPCmoRVN+9vyIAn0JLDkQYlnf+0/KTYwcS7BBVdHrc3zAvDJgb0r
	 kPU/iAMAYLQoJaeNPiEGMWv1h6dL2XemPfwDBxI6eJc0y86QbblKhnimHiqO6xG3UI
	 OmI4ddjDRNrp33s5xySmhLzN98jyfWn+XhjLRMTnMZRrM5VYOIO5/sEOH0veyjFTfV
	 QGfO2gc39w9Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7DDF13924FD0;
	Tue, 20 Oct 2026 07:12:12 +0000 (UTC)
Subject: Re: [GIT PULL 07/19 for v7.4] vfs close_range
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.close_range-bfb6cb8d0f6a@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.close_range-bfb6cb8d0f6a@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.close_range-bfb6cb8d0f6a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.close_range
X-PR-Tracked-Commit-Id: c73c0e243836d5dfd1c617f73b6003b1ad40b2d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c2b4ab7f437c5ef9c0f825a461b67ba16ab4066
Message-Id: <179248033138.3535438.2044027226966618017.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:11 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:17:24 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.close_range

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c2b4ab7f437c5ef9c0f825a461b67ba16ab4066

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
