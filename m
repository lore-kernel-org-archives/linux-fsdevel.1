Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24F3A6F05;
	Wed,  9 Sep 2026 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979152; cv=none; b=ufK/cuKwh1mlfXMXRlSd4JkVPuuNuGSqYY+2ha9vQmu0wk4LQMHJ9eJpkChVf7hvPRviMcN6GJDgdx8UAkF6aqEgPnCepVpow0+NX77URzaEb1QtgJM6mteamNp8Gzq/+DHKPpWIDOPUYg1oaUPDZdblO2YfwO0FxSNabEvP1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979152; c=relaxed/simple;
	bh=eq5//BjmfJCGpSn5kkzLDzo4Pa6zmLR4IkLLsGdl9CY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uHnIVFThAXgU3orAYvQhnUOKZNilppvE5I2zKtR7IO+a3T+VI/othQaBJbDhH2tZlh8UZehv5PGRdGYeKAMjQ1j2EYYj0ztOic3MDU6h1SNSwQEApQrjZSVafPOfHA6GNQkkulglSxiiBbYYwO7E9eHyNoQi3VWiZNMqKRZCY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRIce6QX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRIce6QX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5F01F00898;
	Wed,  9 Sep 2026 18:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979147;
	bh=H2d+9+MpQB4GeMTYaUKvpSMUJSrrgp9lIhJocNHvxAM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VRIce6QXfrrvkqeE20mBvHc15omVxUOU7x1luor6/lHreIeKQxlRJpViMrx27hzXL
	 gysNjfznMCNmURRlNp4ZHQTA94sLu4SIKfvtoXTfLM7UrHnExyrPXjbkVf+UwcAgAw
	 iQLqjn9NjNxMzaATwvj5Dmh3Q2ER+tqpegxHMmJ6wCRjCgnMpoUzsB/jPKqDYlgeVO
	 12k8quwMszNProYlO6szzdauK8Fk4wKafSRQt60gIu8/+Xf7OCmFS/7ECl5/5C8gCv
	 7mBWP0SQXcDUlGnB1SC+c1hRPtEtjOTDaaKvDe5rxKhFHSUrsI346rKKAQsSLTYoHx
	 hcnaXyPZEXPjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990A380AA52;
	Wed,  9 Sep 2026 18:38:07 +0000 (UTC)
Subject: Re: [GIT PULL for v7.3] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260909-vfs-7.3-rc3.fixes-fffe72bd00d6@brauner>
References: <20260909-vfs-7.3-rc3.fixes-fffe72bd00d6@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260909-vfs-7.3-rc3.fixes-fffe72bd00d6@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc3.fixes
X-PR-Tracked-Commit-Id: 56ea4e86832d8abe8930394473566c194d189f85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e1287972b649aab54a894addeaf1fdd6bc23e6b
Message-Id: <178897908570.999556.10939477702023701907.pr-tracker-bot@kernel.org>
Date: Wed, 09 Sep 2026 18:38:05 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  9 Sep 2026 15:44:05 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e1287972b649aab54a894addeaf1fdd6bc23e6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
