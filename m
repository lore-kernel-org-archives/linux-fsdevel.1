Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC11A23A6;
	Tue, 14 Apr 2026 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126620; cv=none; b=j78XGnyGn7+PUVk/ulMvlDBkb+uTzd/XSQFLp4O6DgiOHcLrRHdMW8+Hrxfpx9oi2SZBCZ+xda0lBOX1+Keg6O8xDrnnm1O6wU1v0YIFw2GOf5aeZOP/sum5ug84j3rw5xksowP5zs453uFMDyWSjrFLaeUshv9xhdyjHj7ri+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126620; c=relaxed/simple;
	bh=IPYXoOc74Vz/PcpyaaUpklOujFv49UCow7ApNwulej8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BNbxEy65VNbM/FaHjhrq8iC/7Cv/b+RqAWDxxKqfckymrKDCJJTxVmQ222A6GDO3OleG4dU1gJEjv2b6lva7D7h/oFR4c/8c34mnX2HWYzz+BIjw14nCoTzwsij/gPvrRizfjcQrjTFpl2pY6N9BWXKPUF2jX4IcFNSQFZXPHH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmKRLG/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmKRLG/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D87C2BCB6;
	Tue, 14 Apr 2026 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126620;
	bh=IPYXoOc74Vz/PcpyaaUpklOujFv49UCow7ApNwulej8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AmKRLG/PJYgdCwWSaKfehz2Uk2B4IDWtypPCWRlloAk5K+DI4TMqNbnJ61UsTqvGy
	 tmTMwassQ6OrCof9/uURyIBnEpr6bstfTAybVOty2Sb46kYN9iPTfmyjpglU4luOTW
	 +EPOramaL4zOlQwmR6Fr+m0+KAmgVDIpLdO70rUZUBKc2F4MZfGe8pXy3vtFc584kL
	 Cjset7HqZ0qUaWeHiuHf8+rmAcZZIMB2Vbh3Nmnjsqus6UlWJQXRSp1ZywZ0MFvX7k
	 MAHorUqZc2qcq87Joz30s/TH/dQGQk545h37ELYbr+QlVQG5M5QDBmVf/imStH7xHg
	 BLTziXXcH4TaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DC43809A0B;
	Tue, 14 Apr 2026 00:29:52 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS fix for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1775783818.git.dsterba@suse.com>
References: <cover.1775783818.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1775783818.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-7.1-tag
X-PR-Tracked-Commit-Id: 6fa253b38b9b293a0de2a361de400557ca7666ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3756afb6f6cdcbbc246f1edd0580b8c7485124a
Message-Id: <177612659145.618768.11483441819996342393.pr-tracker-bot@kernel.org>
Date: Tue, 14 Apr 2026 00:29:51 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 03:38:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-7.1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3756afb6f6cdcbbc246f1edd0580b8c7485124a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
