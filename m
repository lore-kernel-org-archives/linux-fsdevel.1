Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480347;
	b=aOrX3Sa2uX5e66wWv6ozjGtCfL/ElemgxBK+C9hmSiT+vQ2UhjfmBOQQKOGVmhehI5ZD
	 tkzj8hMefTfTWAaB2URMoKVKvTibQUyyEdl80zxt19CepK3NU96REblmL2FAPvgZ9FHW2
	 8N9tbpGfLpJwbqC220IJfeM0Gaj5ppF/D1dQC51Cy9xmREZyFgKyNc/jcju8RMNPVUDZ0
	 LvYTCSKd6BFU0bCF/llODZLqPcXIQOwVdzVH0SJ1yVzVtyS8MuH6Ed8pawI4hY+VJzsHI
	 93hfdjHn97tN0USDRDysjuPBEHg7lD8LEY9dIHFyjSueIAUWj35DDOHEUlrPS4VJ+Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480347;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=ocbaBQDcqSI4MRyUZC60d3QAiRNjtSfy+HuYocEydCc=;
	b=xdhsJ0HYzsrpw9TjXB6h/B7CTiNRMqahcmaqFOHb6oB3qJA4x6WgIAJWF582Ih7mOS2w
	 cTR3vJDfC1lDaEVwtlV13toSCwxnpR70Hv15lWv5MaVmZvvxBt/SjJAXrNIszpf+nIBC7
	 cTji8Lr21rKKI+TszYFFnNPZuMrJFTh6ZRfvnVRtVtsrF5gHrbfWtT7DeNR5IXZt6XVbA
	 y8S6HD/DLBa+tKVB7fhmrsKoKavblK6xX8FzRBJ4Ufm8U3UySs/LaokMRQ3CyOuehiiKj
	 mfWcNIubnUsXK5jfP4rN8In50SmlG+kGcANyFY5Kfz1BJl8KX4P58F8wte/2k8K2DvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Istc7Vd7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F960A261D;
	Tue, 20 Oct 2026 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Istc7Vd7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4611F000D2;
	Tue, 20 Oct 2026 07:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480346;
	bh=ocbaBQDcqSI4MRyUZC60d3QAiRNjtSfy+HuYocEydCc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Istc7Vd7kewO2G8xrAXl+Vcd//803yUDUcoMiPJjAMUNnOs7fy36wVKMqZZ2xrbKL
	 1cWPJqJf2GoVvGjvexUpJPzV3CiZ8vlSgMwJGVPGTItem+0Cd4e37zS0n3igBBmcEg
	 /Ru9hR96tKZpLr7HZMh2ndziO77rRY/hMFJEJX5ab0ckjj1vzKtVlb3l1LJahHachb
	 Ff8Gk2NqVq9E5f9bIFREtVsZAlFiKoVE6y0+cOHeO7h4nEu6PIVzx+dtQ9CmoBWWei
	 mOdKuptFD/XtTmTUtI6H8nOtPdXfetf+jaJz/ilVRu+PnaGJbjqbIu0NeVNHrgwCdf
	 i2kRajBwJg1cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9B43924FD0;
	Tue, 20 Oct 2026 07:12:26 +0000 (UTC)
Subject: Re: [GIT PULL 15/19 for v7.4] vfs mount
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.mount-2dea99e7bb3b@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.mount-2dea99e7bb3b@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.mount-2dea99e7bb3b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.mount
X-PR-Tracked-Commit-Id: 062b32e4b55082f11b63dce22c78cd00fc6c7ed5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cbcaf75a1eb0dd9e800f66324fe4a295a251ccc
Message-Id: <179248034473.3535438.17290348346698715267.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:24 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:24:28 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cbcaf75a1eb0dd9e800f66324fe4a295a251ccc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
