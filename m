Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BD3DEAF0;
	Fri, 10 Apr 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839577; cv=none; b=l1X4JwC/BKGYqYTKihtSxBW0h0Neew6jqwi5sOdHgC26oKsM9WipRciTt85WqinzdaJdp0a4e38D5V9nzRxajZazTiyHV8bV40nq6YeU4C4Ob6AN3MciQkde6KLa9DGYz0UeESJuYfVJmaSg5311evcNISwzjO/4qr80t8KzBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839577; c=relaxed/simple;
	bh=FmcCBAkcKGPkeYBE76zoGNSCTK5qqYlV+z6b4C2sisQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oG74wSEoBp21M2xXSLPKm/KomhQly6/jwJV0e5qcEhMmUnnS7OL6ma4rJ2k4Yyc9qdGakqG0P0eVLQzyyiACijQX5QON0cWOosYmbcEqAAcRTeB/W4Hoe+z61rjclxrJNcXIIbckc7YX+OuYnOCFmmJ5eKHKEZesCdx/1ZS2rW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxiIAp0F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxiIAp0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A98C2BCAF;
	Fri, 10 Apr 2026 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775839577;
	bh=FmcCBAkcKGPkeYBE76zoGNSCTK5qqYlV+z6b4C2sisQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sxiIAp0FLQODiGGvhNTUgArm8IpH+DMnT3MZ0GSEX64nTTQBq0a81o79ucFYBjW3n
	 86kmEgXz04uEPQ+fV++fqneKeNni6wJifUgruPl0u7QbxRniWLlmtRYACAFNrv1zzr
	 BFucjrVZ/lxv3ZWDJyq7wMWgWx3Q7u3eKP/DbddhW8eRPBOAMKC3HAYD1SwRUSXqWU
	 bRLOAHDuTyvqpWORwqpRHrU4sardSth7bhZchtVDTGuHDI+z1GU9JEJ5P3gMfbyPQz
	 WZ5kF/yJSI6VZlhcZNUq+WGRMrFo/as+5E0hPw0vWx6Ud9zNggqR18/CRfQL8DrP2b
	 y5INsUmto8P5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCE93809A87;
	Fri, 10 Apr 2026 16:45:53 +0000 (UTC)
Subject: Re: [GIT PULL for v7.0] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-vfs-fixes-52296d845868@brauner>
References: <20260410-vfs-fixes-52296d845868@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-vfs-fixes-52296d845868@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc8.fixes
X-PR-Tracked-Commit-Id: cb76a81c7cec37bdf525164561b02665cd763421
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c6c4ed80b874f721bc7c2c937e098c56e37d2f0
Message-Id: <177583955190.2559624.4403397662197557375.pr-tracker-bot@kernel.org>
Date: Fri, 10 Apr 2026 16:45:51 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:14:49 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc8.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c6c4ed80b874f721bc7c2c937e098c56e37d2f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
