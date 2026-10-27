Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124642;
	b=3Ij/f530U/myBRClqHjuV1c9mR3dS8Pp05IvDDmHe18c3L2+eOOYCLlWUD48y8b2Bqsy
	 lwxJPD1DjIUZadxroUD0sMoO0e/ER0Rct7KgzASO8I4B53Y5GnSWhY+EJgEGiZvDlx73j
	 wsuwFRrX6j4zSnEpOhiYxI43FE8AidULQulh2NwcUQL9hb6rcZMkQBbPHD0jCEI6JybDk
	 agpZGGSfQ/7+OixZWoOseKsE4F1XzpjPVMiPP/5lcm7fyCuJpJ5KIepYAmoU30w4toeTS
	 xHrQSgnjLwqdcDcxcQd+s5C0jwb8PQzURC8N4yc1OAiOZCyyHi/ghUOkckUWgfgDpVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124642;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=WGzbyzwbAoTb/Q7ov2lpKsPTfscGU5vmCh240mybFoE=;
	b=LaZ1pRYI4Lh/UZQNw7uyODjmUfwy1C6grNERVognENkhWCYe+i1D4WVf33ZS2S2n3/NV
	 5DkUmnsu+vIpTmpkhX3lwdH+g1OhXdWEh1UETuOI9mEtGdl59lqMwSCcB9OgsQyXnG90X
	 UCcfGweabyoFeYaAAUUO8zZGgq64pW9PEvlUuuXZ3Ss4c2At5zok6khZSFzGrpgiJ52gW
	 oI/nIKWXEex0c81qZ7QzhvKArasliuSVB0AxB+BTOWxGHCyzIf9F7Cj3UMDbA0u2UCCfA
	 XketCRS+dlBQ39aB16rJ95MIfOZ6yEmjsAH4sZEKrslwnaLeWxWoApILbmSUCIFg5tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5McfJya;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586B606A31F;
	Tue, 27 Oct 2026 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5McfJya
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100181F01825;
	Tue, 27 Oct 2026 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793124642;
	bh=WGzbyzwbAoTb/Q7ov2lpKsPTfscGU5vmCh240mybFoE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=E5McfJyaQt/7AwfG0/+TSRM3PbzUJlX+tVEMMb/tV1sXHLCrKxtVFEMhpESOtsJyH
	 7LLQdUmRyiMACR9ETLHAM/RvkyrFSD9HebsH1Zm0WVNpAzqB2W+W/aVqbHAILU8CbQ
	 uR4w1RvViI9yI+/lwRux0Xf8BULNf7FmWd7320zqgj/yFjalX67dCFKkUixS71NDLM
	 KhzGwVnv75X3PbV7t00bMJC+q6ghyWbEEVg0dxZ626lO4J/To8V7lXp7sDASd+zXmU
	 qII0Ku4xs6mtKZkM2JRxU5bSb1a90NiRoViBEIeMXxpV9IjclTj5oXEOHkBCW7wrc1
	 Yo+/l+vo93MKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0752A3AA9AA0;
	Tue, 27 Oct 2026 18:10:42 +0000 (UTC)
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
Message-Id: <179312464081.244297.11105394692340872905.pr-tracker-bot@kernel.org>
Date: Tue, 27 Oct 2026 18:10:40 +0000
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
