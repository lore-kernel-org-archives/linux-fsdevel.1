Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1323921E4;
	Fri, 27 Mar 2026 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644001; cv=none; b=MSuRmcc0i+Na4w34P+rKrfvmv79U7wXwRZAFp0DOM+8UmJyTXsQrIk1whV2u1fJpuZdG+qdDZDjLcFdAD0gLK+8eqXB+n8ALiVq0RxRNeMazdoWLdg0d/RUoDalX7K5+HOc3Ci2a2DRsXKRa1/uEIFF58qodscxO8FwwRenohaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644001; c=relaxed/simple;
	bh=oLHIsDYelyY4WjoAvXObvXycrXMqt0YKiAORfZHdYGc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ip8tLFDBASD2Q0x2PTcHNt8fbkDG3P/rs/p0/qrhZwU+VDO1NM3BrsCYDM/7gz8IlR+1cNh0/LAESnYVVtimBFi8YyUfbcPNlLPpFXH+Migh9Bd1Z8CfTT4HpeRA52vHwKNbriM/rErbvMmwKEsrHAVawWQjx7p3S+JhbiYi+RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foJJLM7z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foJJLM7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5E7C19423;
	Fri, 27 Mar 2026 20:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774644001;
	bh=oLHIsDYelyY4WjoAvXObvXycrXMqt0YKiAORfZHdYGc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=foJJLM7zQghx3wUVJbd+pOAG1j6tR7hvjcvA25rW4qRJQeJHTnI32OymCAfRj/Lqf
	 h3FQw8+j2hYpuaEVabnAF5HUJzNnyK5Y8UITfcARRSuq+jMoHwO+GYQ2Mb6z9hg0C4
	 fCFeTC2viWu36TyVchjc1+SPkvswjKweFBbjw5LdF4jHWKKbbiykHQZ3DZeXqzS4Ge
	 h47YHnuuqTnWlfcPAGsTqas5Ub+mv2kmZrrzhfP9kEgS6ZzF3iE+zga8idGFFXNwMo
	 YVGlAdh5PZOGOwci6y+Ji24tqnF/HFG/8WHoeLBy6ZwH2BkVjDCdRhxCyXGksWycVM
	 IA1g9BxNV5C5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DCC3806928;
	Fri, 27 Mar 2026 20:39:48 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl fixes for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <vrx6mlibyi56mx5ibb6mzmey26ngcgrufkhg2j5yfw6d7azc7u@wvmp6rtddd34>
References: <vrx6mlibyi56mx5ibb6mzmey26ngcgrufkhg2j5yfw6d7azc7u@wvmp6rtddd34>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <vrx6mlibyi56mx5ibb6mzmey26ngcgrufkhg2j5yfw6d7azc7u@wvmp6rtddd34>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.00-fixes-rc6
X-PR-Tracked-Commit-Id: f63a9df7e3f9f842945d292a19d9938924f066f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b8bf3b64eee8470d27a62a7923af3058125c7ca
Message-Id: <177464398661.3654421.18032493453309217966.pr-tracker-bot@kernel.org>
Date: Fri, 27 Mar 2026 20:39:46 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, Marc Buerg <buermarc@googlemail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Mar 2026 10:18:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.00-fixes-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b8bf3b64eee8470d27a62a7923af3058125c7ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
