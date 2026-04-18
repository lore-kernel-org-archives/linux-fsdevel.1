Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5B2E413
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776471180; cv=none; b=MpJXsG+8EKsvioesA2VqB62p3tOu5ixWdbB4//wRr9p/CLuKdbSVxUshZ+HCKSjQE47S7DzypydLl06SQlc26xIbQM2F+13YSx6eGh0u+EatfVZoFVtNf7ivYfmIpa3GHzFCdRwHzFB1dyUDnrZuIG5maS/DBOTpYDAU3rkYeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776471180; c=relaxed/simple;
	bh=z8zbKaWpc7lHUHiGiJ53QzTzL/jjRpwpK9Udtm7mlKs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GpqORgvgeUHTatmewaKxPmiFaMY27DGhi97C6jp6HQGkISNkZjn9prxgIxMqU5OH+kAWycZG/fNbn6Hpx1oXTGC6iQzaeyUztYjTRMaIjD3nbgP220wb9OEPP0RuS37IwhHhea/rofNYr86tAxPWjpU1SUlgJWpOqEC+5FEGQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+6qGRS+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+6qGRS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F96EC19425;
	Sat, 18 Apr 2026 00:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776471180;
	bh=z8zbKaWpc7lHUHiGiJ53QzTzL/jjRpwpK9Udtm7mlKs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L+6qGRS+0hHb6YXQ6GPqWsGrLXqqA7roDg4DuLzE5KC8dxT9AaFOhp7CQQMFecBw2
	 np13X1mAYwNOSInjJCR0KkYQoF6NOR36mj5ccOqO2yPyincBGmsn0fEohQycScwRLu
	 EgFqjdntWCX8TTN0MRRP35pmQOI+rvLUSGstl5mgJqpduo3bKLYkopFydfzRobSvkp
	 tyT2SFfg0UeDfl+B1fYS5LOX6SFq1QTm1iTljduohrrEFosIIJ6CRXMwKZIAlaHWq7
	 wN3e2VyyyBLKKp6A6DN2AZUP9nzn+N3eVUIAuwwScQTgZqtuiFqNsVEuR/1qexUHX6
	 gat89+aYEsvIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D09B380CEEE;
	Sat, 18 Apr 2026 00:12:28 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs changes for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSTTi0E5wgs8ZupXNa97Xb3UsG-botm0JwPE64--moMsgw@mail.gmail.com>
References: <CAOg9mSTTi0E5wgs8ZupXNa97Xb3UsG-botm0JwPE64--moMsgw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSTTi0E5wgs8ZupXNa97Xb3UsG-botm0JwPE64--moMsgw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-7.1-ofs1
X-PR-Tracked-Commit-Id: e61bc5e4d87433c8759e7dc92bb640ef71a8970c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30999ad049158057d55e613c90a8302970540f7a
Message-Id: <177647114712.212906.15435466066572418975.pr-tracker-bot@kernel.org>
Date: Sat, 18 Apr 2026 00:12:27 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Apr 2026 10:14:50 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-7.1-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30999ad049158057d55e613c90a8302970540f7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
