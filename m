Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDD1DDC37;
	Mon, 13 Apr 2026 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102852; cv=none; b=lTRvB+ZgxCbIYAnF462+T43r2T6wH9qr5R62vPylrdXVqXmm/MwjNfjkmU8PqwkCH7tPOK+1wTpoYAQ2XPX1cL4yrxqx4HTFkwYaHD9p5Duy72snQxnkQIyzZ7CtiXU1tZb7Tra0LUHop1z2D/yj/oebb7B1ArzhJtQsmXBpBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102852; c=relaxed/simple;
	bh=oePrxe36oCX9aYI/JfIGiNZi1tgTxnjgKk9yQqUa5k4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MvroWMmnbf2dgUHaf2ZodvDU1SLmn6z9T9zHEwoiIwTEbmUlWbOSP3Q/OOptOhYh2gKhyCH+kmMsYaLeV3bjgkaYG+Irl/Czjztl3KNS4phiV+uKBdeyYxv5dvfx45IrYoKAJ3ATp+SBgJS9Ltn9HwZhm809099ODO/g1UWRUoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0eMpxao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0eMpxao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AC0C2BCAF;
	Mon, 13 Apr 2026 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776102851;
	bh=oePrxe36oCX9aYI/JfIGiNZi1tgTxnjgKk9yQqUa5k4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Z0eMpxaokCmxnrLE2DvBBuPcVRqgKjm86n4vChKps4c7BcXCs9fTbYfXMASDSjlMl
	 1koWBoy2m5uHe3MZV8r+vQUx3rR4+YNfQv3ujwMqHfpYre7rY5hGuuAT90cTgnkNdh
	 5BXhL9FhGrTCc9Gzbs5h4dxTzMiGV+tC0pOsAHgsz8Jx3uiLY8VrCtZ0WISGnVJAuZ
	 0hldw+6PH5La3+PQIDF8XVqmf9El96xLvRHQgfSQNdfLB3jfGWhNjA7UYmWlTsAofJ
	 ybPzQqiNdKTYDKs2pX2Ytno73OzlhiZ8K9EimC7GinTkkzdDIdSQreQ7PZbWI7bpBw
	 9ZYz8z//bp70g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0A13809A8A;
	Mon, 13 Apr 2026 17:53:44 +0000 (UTC)
Subject: Re: [GIT PULL 01/12 for v7.1] vfs writeback
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260410-vfs-writeback-v71-7f2e4fd28a68@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-writeback-v71-7f2e4fd28a68@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260410-vfs-writeback-v71-7f2e4fd28a68@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.writeback
X-PR-Tracked-Commit-Id: 86566865986c4fa1963aace4ef5181501b2974c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e58e3f1c57850f62afd40a642a7fe3417d80b21
Message-Id: <177610282317.473774.4731925589656543172.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 17:53:43 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 17:16:11 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.writeback

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e58e3f1c57850f62afd40a642a7fe3417d80b21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
