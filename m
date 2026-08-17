Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A33F3299;
	Mon, 17 Aug 2026 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005586; cv=none; b=isWfeqVfY543eF1bV34zNnftY+b94XWTLt8tYmHR8zbUDEOQLteuQ7oJ+Ef6PrF7gP+X6g1hZI0rsq08nqiN1Rf18s5XLhoSeTNGo0L1PY5JLPtUf/jT3ImDPGJWvxMSdVffrEZHOyfW0rk6o/3e5+uv78gF2BMny1rT4ZmBYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005586; c=relaxed/simple;
	bh=HxbU54ZuvAjAX9wrIn3/zpXjJCw6GYHhg4ad1HF41w0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BZJbcCWZg6hQ73ctvzpt0EAZJ7YGL88253xx79bhm8mv6DS3NQUhdCuc4YU9PKqmefEOwRe15XZxPBAruN9cpmcve3Hy7zAJ2lBLds5vxQ3SBUklhy+S1R99mGpv3g8HduzzI6rVKkvM6dzjtZjtlQPPFQ2NijagI35XKspFCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A34OfN/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A34OfN/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F4F1F00A3E;
	Mon, 17 Aug 2026 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005584;
	bh=Gs3UpYeCq0u6M4Bhdpxvi45CKc5RbaK8uNV+//F3Gpo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=A34OfN/VQS56G4iH2VDYFX3IqRrJ9xA9yTYmgJ+sAc5Vr5fy+yHyO6zeTVV/P9IHl
	 zgR1PK/STQ8hjE2zJEoh3Cb95RdIaVHM2W1msCLTgc5QfyCZeeDAFYOX06rQEY9TWL
	 Wrh0lCJgBofK8u6X/6rhQ/AKcEhhI5OKEpudOnYL9pvErEimV850zVrJPM4yemA4Gm
	 Q8Fo4iy6kbp3e2Zm1PNaflYzeahgTE2VjzJlE6gwm6ShbYuTVaiDYKE7JNqWjXDhGK
	 QTuyCLMPk/+bZuI9d8HPhPwJakIs/tuMj4gfxBARYlrO4u8n0HFXZz75CkNw1QBN8v
	 ojuuYLTrHosbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939253926274;
	Mon, 17 Aug 2026 22:25:37 +0000 (UTC)
Subject: Re: [GIT PULL 04/18 for v7.3] vfs efs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.efs-03f96f7082ab@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.efs-03f96f7082ab@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.efs-03f96f7082ab@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.efs
X-PR-Tracked-Commit-Id: bf2fbbca5d49d07917236604837145ee9e662c41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d31a688a49a82a48e0434aee9d851e094270a6ee
Message-Id: <178700553621.1769471.10366282889405352122.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:36 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:11:41 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.efs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d31a688a49a82a48e0434aee9d851e094270a6ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
