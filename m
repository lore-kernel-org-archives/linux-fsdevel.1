Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC73D3CEE;
	Tue, 18 Aug 2026 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025493; cv=none; b=Y17Wr1mfMAEfvoEmvQYagzhg/FZMpLEi+B1ULTsU53ReRGGSNQaIb++fTAfKkEdJ5JsEJ2HjRUMHaXqBrChbXBUEoONm0crBI2yUPPjBJVYG4FNmRNxLHZ8TRBSkbPTxoYkDcQVoTcEwFr22h//IEHYjsBH3JO3/erQ3HRuiLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025493; c=relaxed/simple;
	bh=l+GNKwuUmNDdJ/68sQbtrLR6YZxVhUOd0AzsYJ3wCgg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d3hL1kgrh52f8GVqlmf7VZsDqIBtQ4cVuFTgI6ICsFgAyMFcpINizSY3r99piiKYFUwtSUey1zRJyS7yol9TEs7yzhaRTMYYeypV8wgvQZ3KTfL00dzxsKTRE48XL5vkQbmXbwIZ36XzX8G61mxBipwWQgM7Mo62uf3U3pEz7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0bvyL1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0bvyL1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAE41F00A3F;
	Tue, 18 Aug 2026 03:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787025492;
	bh=jmBhPug+ZvP6KtgqUmraBp57CW9UTZSsQs5ExCChAx8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=h0bvyL1nPYWfuv7Xs4r8Arlcl6+CbV5wccUwSoYCw4bCWrWrcqwRHvHxnV68kObbt
	 n0PsjoicKekKQXS/jcYKSE3N9l7aozprGJdN9oSRIJ9OFm4H/Gm2QhkL2xW0uW+h1d
	 H9K2Pdxk8BEzmAkFissOQql+6FG2eRGoNu7HZpp2TUw0KcQveo1XVbi35L5NC8OHX6
	 tDnWiA/C2bk6dno7agWG261jrnuT3WyRJpMfs4BkzJP2Qrk7Gnu3wJXzWvORDohT5n
	 Gj6kbqZQTWVL+Q6hkRz2isNSJmWavptr58aG+2aiP8/BEn7b9+/KB0Y7KF3lJKG2D6
	 sMyIaIrSspt5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1979A3926381;
	Tue, 18 Aug 2026 03:57:25 +0000 (UTC)
Subject: Re: [GIT PULL] hfs/hfsplus changes for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <f876403501994cf23efade9cb7dcf974c7a004ab.camel@dubeyko.com>
References: <f876403501994cf23efade9cb7dcf974c7a004ab.camel@dubeyko.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f876403501994cf23efade9cb7dcf974c7a004ab.camel@dubeyko.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v7.3-tag1
X-PR-Tracked-Commit-Id: 627b7865c062ff642c0000f3a4775f1a44b986a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0de672c7e1920acc5675d0dd22718c4f6e6b4447
Message-Id: <178702544376.1862718.8012143356717907049.pr-tracker-bot@kernel.org>
Date: Tue, 18 Aug 2026 03:57:23 +0000
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, vdubeyko@coreweave.com, aditya.ansh182@gmail.com, r772577952@gmail.com, kylebot@openai.com, davemadmaxxx@gmail.com, mdshahid03@gmail.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 12:27:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v7.3-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0de672c7e1920acc5675d0dd22718c4f6e6b4447

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
