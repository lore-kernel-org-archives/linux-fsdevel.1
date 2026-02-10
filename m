Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C332B99B;
	Tue, 10 Feb 2026 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684634; cv=none; b=l3vOfPI755EQJbX5iLdzBspVYnDKChk1DdREcq/zr9ZXBr+f5B5wpTnANRtuZ0tGPBgWUn4CREodeGXHeRjgFGYEmWAX91Z0guFWV1QHpnklJM1wic1eVKC2clK0kGjiXyZ9i8M3F2FtQAfuML1dNXLPowXDpbG/7SGYnacH42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684634; c=relaxed/simple;
	bh=r8zjJlrTxej6A0JdmgMZ3TKmKO0ueBSRYdsbbRDqMAg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i5X+w5YPsTJ9xdL+XA74PB6VAuVz3e6+CU6J45F+haTk2rXAXN+TCHVP9Y97lI5NMuB4yAsZcjbVH2+xY0R0zE6CihK6nUIczWOHHkcBQsYagOxOubL/S1Kwuv1QS5UKDIoIWf0LFAIJaip3PxPZkbb5SBkCv+eK0EXeYvtbbzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA5jskJA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA5jskJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6835C2BC9E;
	Tue, 10 Feb 2026 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684634;
	bh=r8zjJlrTxej6A0JdmgMZ3TKmKO0ueBSRYdsbbRDqMAg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OA5jskJAS8KlcGnnhuYpzVrXA+mIPfa8OxR8Ek45TGU2ZIEJlKQa3ezaSu6n7Qq8a
	 lc4bs2h/4DhEf9NtQjRe1jKDcC9EoOt6cgb5rWX7H4JdzWCMtMfzvzQYWee+cXSHtQ
	 MQqwdjNrPgPkQW+ShI1RIcFxxOqaKnl0iamyjme2wCsdc9GqUJQ8lp+neeCDoPsAX0
	 YeGJg4ew2voF8g1ot9H9FNdHj0vD4DwNDVqQNtEjc9KHjZkRzmRbBYE5h+DGG1cyKj
	 yUHWBsURqQFb3iRAcCMekAwXqpFYeQzCJUHAayAobAe1SQPd0nj9sNcHOjnKTLLwsi
	 Bk8t/ZrBKkgYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC5F3380AA4C;
	Tue, 10 Feb 2026 00:50:31 +0000 (UTC)
Subject: Re: [GIT PULL 12/12 for v7.0] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-misc-v70-be6f713f9fa9@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-misc-v70-be6f713f9fa9@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-misc-v70-be6f713f9fa9@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.misc
X-PR-Tracked-Commit-Id: 6cbfdf89470ef3c2110f376a507d135e7a7a7378
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e355113f02be17db573d579515dee63621b7c8b
Message-Id: <177068463065.3270491.5326904409085188493.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:30 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Feb 2026 17:50:08 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e355113f02be17db573d579515dee63621b7c8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
