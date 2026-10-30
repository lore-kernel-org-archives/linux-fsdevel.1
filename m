Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401829;
	b=BKsSCeT21JErw0H/gX3mGwCJn9Hp7ahyBCg6trN11YtHXikHIiG/AuH/7+VTzdVfoBs/
	 rFoFvUMVFwaMqsPtj8nWX8u9M4loNoAjJT61CLPaLFKUWAVKL33a/jddMZ8RK2Ygu3Yk6
	 FHnx/4KCcKROmGhPG6ugH6NB+EIFSge1uUn0tRWOhDiuBmfOqvOwNQSCAPpbQ0RaHzJDy
	 mcybcWzdN+A0T2xj2yqLHaTMsc6oOHnXIxTN9nu3bShY/CESmDOWZhRB/CU8fwx4QRK/U
	 WtSFcL8udWLvAj1x/HCmaulkXvvdwcGzhefSgjF9l5O2kKlJVZ5BjJry9y0b9kjI0YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401829;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=FtW2nY1dSJiuoQtKdlTD5cKEtwwdD9hTMxTxsOcapvU=;
	b=Q0mz8J/xWs1Rz4/JtpfUhHaZ6LDzMley0dI+lTKS8YTfgvvjUejzGv1dw8Ssx/QmuuCz
	 8dJCqUthvryI3VGdGRti4ma+4kBDD2sj5xw5+T1UwlvIXaVk4zmWWsJQJHQcD7yiFCKv+
	 GMtjwhFzqDu9zP3Nx85jXk2wTobJFyDsUu59XbtodUFKF0pmXW7d3oZil3jCORSon/tk6
	 8f3Zm4DVQXrq4PRpJJRvEYay7H3+smheX3xRcgsFFb6TCB5zdtVBiltC1BZWHB+B6vSxO
	 yzj33C9i+PV8DZBNn50enKn22oZ3vgrFzPa/LwaHYTe6fNQ856MoOsy+UdV44DSBkaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv4+kWzP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945A606A322;
	Fri, 30 Oct 2026 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv4+kWzP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ECE1F00A16;
	Fri, 30 Oct 2026 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401828;
	bh=FtW2nY1dSJiuoQtKdlTD5cKEtwwdD9hTMxTxsOcapvU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Vv4+kWzP3qsFvteOHGryZMQ5z+hW3LPtn96y7H2Zdq8xzDRmMvP0zFAigKV66rCIW
	 VeQe0EeGLHCr0W5mL+WmUqkAN5hHfztKvauDX8OGFdmYo3DVZnaQ6f2tbPRqmUuY+5
	 /lcg8OMQ0IF4idQT6Z9ZQOZtOB8ChOiZeMUY2ankEfiwivf/K7dwdrwycEcpGzReKb
	 AJKqj8aUg3ENO55RhqEFX+NtjKE1xBDsltHXMVo3X4nKJ36Qp8u+SN8s+QP2er+omq
	 juP09ZfN7CxSHuR7JUvY+BmxABXION1rizIEzfhh8LTZUR8zQsW2kcP1fE8zDuKaR/
	 uzC4Wx+T8hkBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D3E73800478;
	Fri, 30 Oct 2026 23:10:28 +0000 (UTC)
Subject: Re: [GIT PULL for v7.4] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261030-vfs-7.4-rc1.fixes-92f660b23a8a@brauner>
References: <20261030-vfs-7.4-rc1.fixes-92f660b23a8a@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261030-vfs-7.4-rc1.fixes-92f660b23a8a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.fixes
X-PR-Tracked-Commit-Id: a522dd871024a0f065bfa7638afdb929607f58fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c8bf38058e5ac0e42246acb13f623b7962a3922
Message-Id: <179340182835.1820250.11344641883084834335.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 23:10:28 +0000
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

The pull request you sent on Fri, 30 Oct 2026 18:20:21 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c8bf38058e5ac0e42246acb13f623b7962a3922

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
