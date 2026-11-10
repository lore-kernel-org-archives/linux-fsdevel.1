Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333017;
	b=THLgorQWuESrS5cZPxkiAUYSQg4PFLG617WlJalIHQLQmsn+lqcnO7szU4P2HyQW+LIP
	 dHeZa59YBkX1ek1a72gWUb7ULi1D23D2GOr3hIxUfHm09qlrdcBNOS46SvBtFGwpYN1tx
	 bH9ah8mMgkFok3RQSCFpLw7b9TodJkFAS+ZyIZ0Tj9dtWDieR/DGi50becYYFIGTFtBC8
	 H3K5VDzhWFZdOQcv6xB/c08IaKfJ6ELUxTO+g5hsTEqfe5Z0RSfEXOkn7ilz+wn7fMcUW
	 ukdH2lbxRMdneD8XBEW7RKKlwzH4xhSEkS55QKL4pMI+VbTnwSpxUw/AcUvqSC3g44A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333017;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=9mS7h9xd2CLSAl61DAjbcfMHEgDitR9tzpHN1AfzrQE=;
	b=m/Z9yDh2UZml85rPdXqIL5brcB2XK/L7wwEZBWrQG0omkIlLziA/GsTnPFEDgDpD2iX4
	 VcLKB8W6LPu5isUCrPAye4LjfZUNC43gsQ01HiYKHVpYpnRhLFrQTkCtChJ1Dx1BhRUbi
	 RycY5dcsgQPOwse3sVd9rkIuwvxsdp/oYYvefrbA8vEhMbRkg25iXa1SJPAnXiNPmmpiD
	 DIXz5RnCgdQoTV4RL9bOddnLxLOPEenuaw7HbTPkGo8BHk02oVf5czIeyQmTg+j4tkRmZ
	 QjNqF92mJYtxbQoGuE2zgz5g5d3aTBYvTbXanczsB54IWotzUb9f8BplY9i77gn6x9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xek3eErB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F98E606A31C;
	Tue, 10 Nov 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xek3eErB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5251F008A1;
	Tue, 10 Nov 2026 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333017;
	bh=9mS7h9xd2CLSAl61DAjbcfMHEgDitR9tzpHN1AfzrQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Xek3eErBxh0xAt+HCvh73VUk9nFNb9k0hvtbVDObt/PVQwoeAqAdEi5VjSQM7H4UX
	 b3L9hcI8+3oUASJR1YoddytA6gcskFvZ5bAcge5Fzkdiw1LkJbHkf6lL8pUJTvmdML
	 PIIk9ggtSJ2gb4pcC2kRKEVH4pXwVMyKqBh7u901kh7zqI5zTKawsH9igaQ0v2UpTs
	 UIt0NLN0dSF88o+5Ix5P62IuzTCiizKFNELlW00UCGN8kO16cXTYFUMFjQ/7rsdj4X
	 KOos8rzkh3Ohi+EtHrwYMj5VRW1zaOCskEgIFtfrD0LICV/Ftj81c2nGtrHNa8nqF3
	 OyQAXidAd6yRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 211B039D608B;
	Tue, 10 Nov 2026 17:50:17 +0000 (UTC)
Subject: Re: [GIT PULL for v7.4] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261110-vfs-7.4-rc3.fixes-a971ed79be85@brauner>
References: <20261110-vfs-7.4-rc3.fixes-a971ed79be85@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261110-vfs-7.4-rc3.fixes-a971ed79be85@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc3.fixes
X-PR-Tracked-Commit-Id: 1448959fe3d013ffdb8302d17e4a8fdad2d2da95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f5be6584cf5af0d70ee2fd40aa6264da18617ec
Message-Id: <179433301579.4118775.11506351938281610014.pr-tracker-bot@kernel.org>
Date: Tue, 10 Nov 2026 17:50:15 +0000
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

The pull request you sent on Tue, 10 Nov 2026 11:47:42 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f5be6584cf5af0d70ee2fd40aa6264da18617ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
