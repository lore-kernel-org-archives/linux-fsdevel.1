Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAA318EF0;
	Wed, 15 Apr 2026 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224343; cv=none; b=bShCg2XnOQTF3nak5DtwotcghAUHkz+CIgEzp4Y/aO3aCNQDkw9Yry21dNpaQRUapSXPXhAObx2TAo8Y6xhgFu72rCzzDTzzeWBwrZstFyLubsUrAHK/fvHtcxFO19TN68J49V6UOBbH8yJ6uDw2zOhutmFwgQ+N6T7fCA309kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224343; c=relaxed/simple;
	bh=Bdz690t3KwkZpjIauqueVsVjb4eCJgCorBQmY+Ysmv0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MkvHkI/8F5AKZyQX24lJTbbXJt3fVdif+9yNEjEPnUni/NCYCcPfz4bpchBwewvShFagyLWa85HsDVDqiJTPeOLEOtVg+IHxMRUfuwHQBZjBjTK2zGJKaIih2oZSLCYbV3x+6cRS1T4LyO+DGvJWE2uLm2ikz9WgrXaCg5t7i+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSX3LSd1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSX3LSd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF64C19424;
	Wed, 15 Apr 2026 03:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776224343;
	bh=Bdz690t3KwkZpjIauqueVsVjb4eCJgCorBQmY+Ysmv0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RSX3LSd1fSNGF4p0HzluGOM6cLygzgYvUHrAiplhD+OmW48TOXUQY5abVz08IxBnU
	 plRSeoBv94SC8A/LwBZfiPmlegNUaVxml0OQSz3Es29/oy+0qtNhp9N+elvSW5VwEY
	 1PyA5ojef2MlXxglumFT+r/Y8kAKgtGW2eAtVFHlJ5h0O1H8LgXoGWQIXRzy6v2w9X
	 Ant73tpYrMRjMzz9Wc/Q9nhHnupyYsfCqp/xhb8LQOcIwy5nsKeXidQc+2+Xrxg2Wu
	 9/1Ib8pOV+4HmtBhnMDgpuj9Dm8HeK2gcnq+ecYV0zmBJsJDYmPZH5A9Q0pwPLNnx0
	 T1RSorotSmWsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FFB63809A33;
	Wed, 15 Apr 2026 03:38:34 +0000 (UTC)
Subject: Re: Re: [GIT PULL 11/12 for v7.1] vfs mount
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260414-textur-anbahnen-004b3ac3ab8f@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
 <20260410-vfs-mount-v71-89e63a03df4d@brauner>
 <CAHk-=wiA_XzFe_YswO4hezv7MQH6D66k-MBWEZwFJ4urut1aJQ@mail.gmail.com> <20260414-textur-anbahnen-004b3ac3ab8f@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260414-textur-anbahnen-004b3ac3ab8f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.mount.v2
X-PR-Tracked-Commit-Id: cad3bf1c330274d11f25f1b7afae9b9dba13fbd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c8a4671dc3247a26a702e5f5996e9f453d7070d
Message-Id: <177622431272.1615558.15823100592083685783.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 03:38:32 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 Apr 2026 12:58:37 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.mount.v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c8a4671dc3247a26a702e5f5996e9f453d7070d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
