Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480338;
	b=gp4BhZNkhDAhDlj7ODlu17SQByWLG2YPic+eMV40qqYVoSDfU7g/jTTSUGg4cMW/SDfB
	 cnAMkrRZt1G9t4izs1uQ52kUxEKcb/LS5tijTggll1rrtjFh1510+5Mf9j86IzAWGTVT1
	 FNtj+w/wayFN8Ik6QHguDUSRiCXmVN73KIKGBR1THeqLC8Mwab0b2bA3KVQd4GiTkC2yZ
	 UuK543gi0pBARrJB09ni4xptfP3R1/mi31vRYRDbCH62nY7ceyxd4yyVDBg6vsf0P6nU1
	 si3h8cQ1qKpPkBetg8ZJCiCvwTMyvStYmfsMPxzvKwTK00e5nDVU3UC+572tunvyvZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480338;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=ZeNXADTTNZbBJde21VAc8dViq3TLID8wGJhmyXI2Oq4=;
	b=FVLPS2Ni14yaTOjIphd81I3/pVJhhU3qcLtwb0QoG1dn12Iwjq8lyNJlGBHrb1mAf4Sx
	 3uxxKPJ7rD3xbkrjSaJgXB1OQ+biV9EH+Ngwj0gB/vcSnWJYptUuVEiNvDfftXIQlyKSm
	 kOmDe1jLPILEpa+IemdwQ32ldVjjcbLrv52vSVIwvuA8WsaBGw12PcDvmuFSY86BclCni
	 LUeZdLalfOFKcOnZ5p5ZL8Fohvp7OG6ee+3y0hWaxhZWOmT/LQuLspuhHijr9RPKjU5G9
	 XY+5Z9Rrb3brS7ad0FOq9MLltNDKSuVZk86yLI5dVPcNXkHYsKizMGs4hjeAcpW89HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2uJhk6C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCABB60A2616;
	Tue, 20 Oct 2026 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2uJhk6C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7761F000C5;
	Tue, 20 Oct 2026 07:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480337;
	bh=ZeNXADTTNZbBJde21VAc8dViq3TLID8wGJhmyXI2Oq4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=i2uJhk6Clg0r3WrKJqaKMJHvPg42Bw0/7UJFwBd3Bq4TddpjaaoSxHAbe02CcrG4g
	 EwxDobV/wabytIdq2Qu9xgDAYCcrZ/4NgpDBda9fHPuSGYUfn5vKuxT+Lvi8CxrBVE
	 PIu2/gxrM/eSTUwAMtGBnOg8pJs7GIIWyxZpjxL9BZQ2/aTdE47dB4rV+X+IZAaTAP
	 0grby/Xt50c0am5HVDDbGco+g1yNYype9LZH2l3xAzY29ZebCIbDcz9GgNozIccA8r
	 FaPKw98EbD3Z/2Ke8JPX+r0Z4JGUSEYG9MEnFUVWIrDOj966ISiO3b89PH4hsjjOpi
	 so6eD4huDMu5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773E63924FD0;
	Tue, 20 Oct 2026 07:12:17 +0000 (UTC)
Subject: Re: [GIT PULL 10/19 for v7.4] vfs idmap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.idmap-dcc7a63fb863@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.idmap-dcc7a63fb863@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.idmap-dcc7a63fb863@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.idmap
X-PR-Tracked-Commit-Id: 0f30047dc83fe18fe0b0766134e9c1a67a09a431
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00b04f4495c354cad82f96d41947aa70f71e2cc4
Message-Id: <179248033599.3535438.8455599716677222834.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:15 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:19:18 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.idmap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00b04f4495c354cad82f96d41947aa70f71e2cc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
