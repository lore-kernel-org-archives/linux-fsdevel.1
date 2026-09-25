Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38D14E80A6
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361796; cv=none; b=JuiW2cdJrdcp2y3WcyzT50NVXIcSG/uI+UhnMS4JhmkPgLXV1TXPsOA7cujN97J51ae+Kamw7XWdg5lXVm/xq73IU/z97ke8zDkFaIjkV7EPJlpUJc0tmj3cbibJ94SrRMXESILlq0XuGgxYFl1F7syDvqn/qrNkAba5WulccIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361796; c=relaxed/simple;
	bh=io2hXF7cWRGk0wihXMTwp6KZiYQkenXnoi5qfCPvw0I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J40w/P4OSzA2+r+7DKrvZdXFgI7siwNTm+4qL0CDWhyaQ8hz6gE2OzUg4mKY9uOtuOTPMnNdjEirakzsnIKUKJkkpNKE5tA+Kqh7TYKgnEr9rv2VOkV05OIk2PE/NCQJHI3sks6S8Y876l3acw+1NPMU82Grl23T6XcHi471VDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfjOP4rk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfjOP4rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737C61F000FF;
	Fri, 25 Sep 2026 18:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790361795;
	bh=/QmxxwOwHSl+RsyZnt3UherAwAy1nsBGihmbZmjAfgk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PfjOP4rk1t464AMsR0dT5uM4d0IWm4gX95Ll0aR8nr4zp6da5A7VnGi+MdF7nWRFO
	 6DucH5DLoBJguuLc7JIKCx/F3E18RWGNiQe7894oTkwHUxaRhLznRLZGVuP+vgzR94
	 O6TdryjF2lFzyGpPpPm7B+W3K9UtZONSeFCsd8aRp0+/fP6xKm/RKT0x3wjVqskCHM
	 IefkjET7zPfBxexN64o3aPYLt59uF311y2GdlqgCkQJ6VISJrwiBpKadfZcO3ZmTTu
	 7ptg/sjZZQpMFhVGdI/u64TGAplvjBFe/zPLYtV/KLhPhfMjl1OgU7SFNzKv7obgd1
	 MFs4ZVa5lFexA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7A898380820D;
	Fri, 25 Sep 2026 18:42:04 +0000 (UTC)
Subject: Re: [GIT PULL] isofs fix for 7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <kt5msp6vjbhfe74t5yj7cx6wfey2z3lnou2gdn64cltxhjqaq4@qp3h26tbvrqz>
References: <kt5msp6vjbhfe74t5yj7cx6wfey2z3lnou2gdn64cltxhjqaq4@qp3h26tbvrqz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <kt5msp6vjbhfe74t5yj7cx6wfey2z3lnou2gdn64cltxhjqaq4@qp3h26tbvrqz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.3-rc5
X-PR-Tracked-Commit-Id: 883b776abe48fed8ef615f4ff7e91113a6c4dffb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2ff1b626e1c9e65c9d384cfb3da3d292025cb4b
Message-Id: <179036172314.3089752.9696032127095737007.pr-tracker-bot@kernel.org>
Date: Fri, 25 Sep 2026 18:42:03 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Sep 2026 13:39:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2ff1b626e1c9e65c9d384cfb3da3d292025cb4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
