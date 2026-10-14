Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04165349D7;
	Wed, 14 Oct 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993010; cv=none; b=fpQblAJA5IuMpxO5R4Dik849knEC0nGKl96cRL10+ndWQeieDUOlIXHYUt+jfG6ougNbD/aq8oM2eysOOJJtx0FmWDMY+O6Sgwa0xIOcNDesiur39cmpXva+LqBcH0eXE/lUKh/J4UJ2ldjKR9xUVIuwi6RMIC+ookLU/XV6YIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993010; c=relaxed/simple;
	bh=gY5YKDbFoxSlUBEn28/dIgcqu2wNq55vHJROe+/J+Zg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pBgVx84agOpKO7569jPQlRAplnGUnUGDgebXtpS7BUdU/FMnL4dwtYO0TX9Kp8TKZA4F7/WT9qtYi7vSjdtfZl+zZVQQit/CV9cg1GV0E7orATvCGBhZ+02MqXf24Z3dPGYldzB83Dd71dWaJziJjgQyuHS9X2czX2ZLYa2cE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVNA3eRS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVNA3eRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463BB1F000C4;
	Wed, 14 Oct 2026 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791993009;
	bh=Vy5L0IADakmxovD3ddn8BsJkT2KcxP49soL/GVfIYzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HVNA3eRShJzaSe+0ElxIZZvTWzo3g00f88U8ASc0qND/3fNZpkg5bBSZfALGePbic
	 QK59Qn9KixarG1nCHLe+1EWMFSAbeMmHxr7rij2Klurf8t1qT1rJ23MR9sH2TCnTHq
	 1QShwn92fDzGBmtSN5Oh7VxAy1TKMwc210hMRVIivw89f7TJ9Dw8/ng4d4agAkK0rZ
	 eMUypgMU4nGW/KrPsR8lgUf7i/9EQte17Fto8UZU74kJCTFFLLF8WipRVUFcDxWr5T
	 eaaO9qSiwRkJJ1+6BOI/+Gy+wIYtKUDnQbAUPbBXAm474vfyRxNp0V+gcdpx9h9UxW
	 3QP1n6RQGxt3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2B539EDE30;
	Wed, 14 Oct 2026 15:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: opt in to multigrain timestamps
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <179199300776.2827562.15669777125122291916.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 15:50:07 +0000
References: <20261012-mgtime-f2fs-v1-1-a934ef646c44@kernel.org>
In-Reply-To: <20261012-mgtime-f2fs-v1-1-a934ef646c44@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 Oct 2026 11:46:10 -0400 you wrote:
> Set FS_MGTIME on f2fs_fs_type.
> 
> f2fs meets the multigrain requirements:
> - ctime updates use inode_set_ctime_current()
> - f2fs_getattr() calls generic_fillattr()
> - f2fs_setattr() calls setattr_copy()
> - s_time_gran is 1ns
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: opt in to multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/714c68e85ba3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


