Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB75A3BD22E
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255874; cv=none; b=rXq4gls8+eZRtOVfgVP4fZZKuJN0FqEism+HJeREG5u+q74NVRX3de/FYzrBCAzaQVwqdsZofGLErdB5ol1QEuoNg0pY4j7KAIhBYJNTmqMi1v+COdPU7L/AzQxpCTnfomWtqy3//10bjJ3yYY0GKdpSlXNIovShvGGAWNBdbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255874; c=relaxed/simple;
	bh=EmGkoIyRL7msNssjJ+1qCJZUzR1edPKWfJahwhGMkjw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SsdLPaPV6rwkh/07gGw2bS+KENi15eUaeCbWIKrsk2ceIrBKEECxQpWibSL3VLUEb+0RNuVnGV21XBi4YQL0EnTKF9lPOdtmSNv0CNlByS9llLPEAiuQXVReRMQya2RZQzArNRJhuQOyqPhLPuF/ZjE/yEG5VNLfjaDkEjweygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2iswqXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2iswqXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F4B1F000E9;
	Thu, 20 Aug 2026 19:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787255873;
	bh=mGvy3eBOlnyoIwuCL+1rClSmpWiw+CXS3kORZt4INNc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=R2iswqXWn+4ZH92EwmfKGgtdGa6O4Ryo/EoQsxnGBuDOWFuMwgtFiwMEmS9Mx9u0M
	 1PuU7tU5lkvwBkobDXMiuhQr7J652vZkNtzqnGf7587SvwPbFwLKtRvIqVycjNAEjB
	 aJz6lMFpJVLJOLpqyNFe6kjw8hECU//jrvjxJoEFD0yC2S2Kx42Z5P4WGdHDlw4Inj
	 gSDdn3Y2XCNYy4wcelXCkyUcBRzOgYudxYvpwVz9mwlSa3BXbj44Yrd6AeRUUd6ke1
	 EmhDRVcV9VcVunZujxJrQOcYZDTosqLFXwdWG9C2neyJ83HDfpCBVYt1sHHA/TQOaY
	 rLjORL0MeOeLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A58392445B;
	Thu, 20 Aug 2026 19:57:04 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs changes for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mST+o6j9A2txJFLtGB+a8eq8W1sZqFiJDM7b48_9jV5_LA@mail.gmail.com>
References: <CAOg9mST+o6j9A2txJFLtGB+a8eq8W1sZqFiJDM7b48_9jV5_LA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mST+o6j9A2txJFLtGB+a8eq8W1sZqFiJDM7b48_9jV5_LA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-7.3-ofs1
X-PR-Tracked-Commit-Id: d410cd5303ec59c7cf23dd61423752ce8e9ecb59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ada9ccfb81eca6943c3cd42d23b9ddd446e75342
Message-Id: <178725582336.459220.17705745825947818552.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 19:57:03 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, devel@lists.orangefs.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 18 Aug 2026 12:09:06 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-7.3-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ada9ccfb81eca6943c3cd42d23b9ddd446e75342

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
