Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC622FF65B;
	Mon, 15 Jun 2026 03:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495126; cv=none; b=XD7E8HFnRaW++OV9Dc8HQvofUnDXF2gxOyMC7ub6xEnP7oecVmqViCs+LlpzAkv1Db5pDOOnOrDy1Pyz3FFz6LvmmTFH5FpQhJ93q3KsTGrcjtPzx/UTiiRC+SkHKQp6ub3WJIAIrO1rAN+yKVxhl9sWD3SwMq8iO5g+x5wtXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495126; c=relaxed/simple;
	bh=B/LP6O/r8IVUxHSwoP21JrrggTup43E31TW0Huy9IPo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PbH+dgjoVoM5EGjcp0VSzo9LJlvYlT8T1rnnDXS1jRH+2yx/bIwy4IY4lk0krLwp15Wg5DZ206Qx9p/CbQGowzwkpyQ/LQ8JEI3vnyZOVSLT7puqqACqBkxpBDpF8Ud3j8KL5XQ4anzmYqYtQA0NFXFx0JkheVebDVERBrN3AKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1p8Fea7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1p8Fea7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F361F000E9;
	Mon, 15 Jun 2026 03:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495124;
	bh=xf176OukFNqB8GRG0dKB/c2eBkTHhvVoHzGBjsRrEy8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=n1p8Fea79qFjKljnoQ/o7pBau1Y1yi3MwYgQzz0tSXplccJ0rHPJFM162+fJDg68Q
	 9QiwYrnlX4B5iU7Gfa02+2GHkm5/iRO/5leYe6UvmSqwvkj8GO1KJD/PB/J1PdZlNh
	 nSL12tA09WIe4KmPYtAcWJydsOdkM4DMg7hd2MooiQ8PALPCkcK8Ji+FNA+Em4Cn4I
	 9MqsawZO+7MELfQKhRjFP1lqys74vctAaNB5uOACTanC1CyGKv7InqzYwa4npumAxj
	 oQlJK5ynBF/vZ2Qoy6Ur1f79O8IpmfqAJdkRSH3l/WHWt/J24Lxd1ArfAkg0R7nzYb
	 76LEX6ELdOInA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939B53A566D6;
	Mon, 15 Jun 2026 03:45:21 +0000 (UTC)
Subject: Re: [GIT PULL 07/16 for v7.2] kernel misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-kernel-misc-v72-71c9604df6a6@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-kernel-misc-v72-71c9604df6a6@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-kernel-misc-v72-71c9604df6a6@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.2-rc1.misc
X-PR-Tracked-Commit-Id: ee8ab98f831226d69d43ccd93f53c50e6f19b389
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37c405aeaa5c2cbe04c3c727e3989a16a2e9f30f
Message-Id: <178149512023.2410512.13684603767338573713.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:20 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:13:19 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.2-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37c405aeaa5c2cbe04c3c727e3989a16a2e9f30f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
