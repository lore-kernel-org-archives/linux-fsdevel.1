Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550248;
	b=s9FQjAfDrq5eJqUCU9bNJsh8tyME0N9wRUaPY/7sFEvvrkeIyNsxhqgPdGINufFcl3H1
	 cDGvEBUF1Dyzu/yc+V6TJ67oo4fHXChL+IgL+o5CmV7vibKdxOIJIAkTBzhceZ+mgKCWM
	 +SZV9i2coyrgKnhEyY5AtWLEGnUeaizdp2FffT7Fqf6YobTAF9UnxdLiQSj4rUmVLDfXg
	 ukynPAlz/EVdbHvzfqfKf5S8vklGsSLBDD8aHaA3JoGPAT9P1yX70plMoe8jqYuotIOIC
	 /ruzh0AiQHhuoAJzJi/SMLwVhBnPXSxZahQdS04tpqEwSneCfWfr1DvboxOWI5yWzYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550248;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=tVHgUx5r7xqa4qLw7aaapOCpBEU1v2iTOd3MBdfjwao=;
	b=CIQTEwKo8Cq56y31ISHSxo8I0x/HDejAW5kM45GI+vTWjMzjRPJkhbZMLq8KUHffa1s2
	 Z7SJiQfpTD9AW67QjJbtSh+ZkgXUJaUyHS1R9M5f+no+ckRk6Vn0DAlKC/uYDr3xUORov
	 cg7aL1F9kGPZXuaAPFS1cE0i7eLxGGcP09mF9LevKxF+NkR/y4DR0z8/g1AGB7ilWC3/k
	 8ZtPOawTttmEQcrknBza9GrSLm0W2EH2cCXrqrhGpV7vpMaKGxBrixXaRv4K7AyxkR0VQ
	 lFHrCuFFS/dnLGOnVyHpIcPnmC+LQd9zukx7zd//azwlbW0HLSWY46OXgU9uBQS9aGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nd/p0vWD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF8606A319;
	Wed, 21 Oct 2026 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nd/p0vWD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818B41F000C9;
	Wed, 21 Oct 2026 02:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550247;
	bh=tVHgUx5r7xqa4qLw7aaapOCpBEU1v2iTOd3MBdfjwao=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Nd/p0vWDDMSZF5ga3Qq3Z3odSpPXCrEB5ZusVcz3qLFy08DJIpZQKpF79Fi/UERD2
	 jmcMyd6KlzpzXszjw5ZXOgwjvR7dt8cVbEqpESuM7DR7exlKI7ePX8RpeDehx9lple
	 xPJNqAgiPq8RA154A9+cnp4wEOgTUHsoSoIDg7QWkn7K2E5JgIDWfd96Od72k7/Ffi
	 a7nK669c2COhrnXu7kzEethGasRrs7sEj1JXkX2BAO+ikeLyRBx19XSnI5+erYjA0z
	 tstfn7+7FCWT2OcFTzXJSauRAq0Vf4RN1tzMLdMrBnCAXegcLDgGnZdRdH+Kb2MsSn
	 Uq1Iq0dhsvMIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773093809A18;
	Wed, 21 Oct 2026 02:37:27 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS fixes for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261015180607.1012034-1-dsterba@suse.com>
References: <20261015180607.1012034-1-dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261015180607.1012034-1-dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-7.4
X-PR-Tracked-Commit-Id: 78ea2058abf3ee053c0bd9c1b9a77304cb4ae58b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f31dddb243cf9f457af60f0124abea6a65d5e2c
Message-Id: <179255024614.339009.11312731048467160393.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 02:37:26 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 15 Oct 2026 20:06:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f31dddb243cf9f457af60f0124abea6a65d5e2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
