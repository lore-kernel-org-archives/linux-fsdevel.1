Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF17337F01D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255876; cv=none; b=OW/GM5HSZRZTglLF3X4Mh0DFO9Pl+ZrfY87aV71Xkywj8V3MB3XQwhadU/rY+X8xMUayzHKnz5mGHw3SeEqlxTUAHJPG+LtKKn0HGnb4kilbmNI5HD14YEH/BTteqMLFsXduBqyLh0U7kCWyeHk+0fES3dMRg29pF0rQ2pO0PgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255876; c=relaxed/simple;
	bh=lOLpqzsLkb0NVYGCX0VHfJTz1HbtGS5qk6ajP2GELzc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NX8IIksMnk/UGo5eIpmV81ZZr32sAboiyJQOMKiwzPqIXZK3TjUrIvykjS4ZgnJE7rOvC+4XKM1E+YM9+MELN9DMPohX//N0f3HdZk74uR9Eg7CUlvZZG6UIUn4iJF1oAJWek1zDLTevflcjWN3ig+tnLjQj8SIGUUtTk2fu6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk8plXIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk8plXIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649851F00ACA;
	Thu, 20 Aug 2026 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787255875;
	bh=xheBom/HFtY2UXqqG67DQ814YElMFHZZ+quFOUPmHIk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Rk8plXIeRaqPTsy1vPLl9LFi5TYvfpX6fSNq4E05U1l1nxEhArfM0VjfdD18fWFW2
	 mx5EwCQyHUuHCNOTqOEDyU+DAZY8uEv5geTlB/HaQhlvd6nb+j/Xlngg2Hov0F8XtC
	 CB3H5YTsv1/a3eftb+HaClKA2D2wAbMhvW1xwbN+06YA2fju604WEkgqHTE9qIkrC2
	 7rQci//1LTZQcJZzoMrSmM6E7Ppdz/CMWI/de5uEqNa5UcgmmGHz66NFJAo596UGvW
	 WyuDHdrTzBH2Iren7bKUIdUumRwVo568XDKNo2SDXuySGi7k13jUBnkILpTtD6GnBq
	 z6i5J+XSyVeYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A30392445B;
	Thu, 20 Aug 2026 19:57:06 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify fixes for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <dwdmf4x7slx3pnpxddsnv3u6r72uduvvksk565ptmspjrigp75@h4ljktlfnt4f>
References: <dwdmf4x7slx3pnpxddsnv3u6r72uduvvksk565ptmspjrigp75@h4ljktlfnt4f>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <dwdmf4x7slx3pnpxddsnv3u6r72uduvvksk565ptmspjrigp75@h4ljktlfnt4f>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.3-rc1
X-PR-Tracked-Commit-Id: e422777fdd4746de1109575c51e65038d4c5c1be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81e51378b78a11b168ffec08d80ff4b47e5b0227
Message-Id: <178725582532.459220.14115711705464214104.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 19:57:05 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 19 Aug 2026 16:46:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81e51378b78a11b168ffec08d80ff4b47e5b0227

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
