Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D933EDAC9;
	Mon, 17 Aug 2026 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005584; cv=none; b=tPg5lADvIKJzYuInhxxQ9Kr61QJVLaytE66wOF7VO84oDymdIhpssllWBEk5O2KdGqEwMN85KV7SGkBXY+RNXeTdfFVosopVH5bLyZAh2DoaxmxZzEj88eJRXS5IYtRaE/5r2SPb5cNO9FkU4/XdQ2uTqDN9WqVoVprKmf5LtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005584; c=relaxed/simple;
	bh=36YKYHwiPPQ8g/g9/2vqQy28iC1sJjn/cpng2DrhixE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sFZu2IkeyKzb4MJWCWnA+4qHK0aRHMLBGXZuMlEZgO+ueFmHxak/nARIVZ1BLoa9U1SUddXK5RY0CdwKhHwtALN3unZTDTfYyGIpi8ONFLF6M0fTJCp0QW/UX8v70+8F0rnxq1Tj8e+P8omzJtESj8ztOcXC5BodR0MmArQuBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC9giAPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC9giAPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27411F000E9;
	Mon, 17 Aug 2026 22:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005582;
	bh=/xHFibzw91+vXxBZwKyowx+jy/95TDPz9l1AiAHeidE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kC9giAPeesjbekXucwQh4izw9qgoB6UEdVpTWQFEZ2DT4f0QsoiNbN9+IP/+1ErYe
	 SBKffoN1M70W5EuJVGczL/w6XxrAFOVre/PImrQHUloeCkD+Im7yuds1PctVIA8HGH
	 Soq37/s/cN/O7Pz9JqzLYHfdQcdYRkitRyjCL096IT44CjELRbNBBqLlivxaKeqRDO
	 g4A5uvBcdSvUWUOQDRfN+ckqOu3lD1Pk7k4PsJ8M08fhoqQKmlK1CkhCc4zYp5NvnC
	 0hJIpXoy9UcuAEGdtqpDMaetIzqAzfxYRSuYfYpuoS07/de/iN3KdJ+Sm8+wD9NTbt
	 pNMr9F0HAz6Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E03926274;
	Mon, 17 Aug 2026 22:25:36 +0000 (UTC)
Subject: Re: [GIT PULL 03/18 for v7.3] vfs binfmt
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.binfmt-72f1306affcd@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.binfmt-72f1306affcd@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.binfmt-72f1306affcd@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.binfmt
X-PR-Tracked-Commit-Id: 68aabd01ddd26ced458a9e5716a640eaf8e4b7a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9cba7ebfe539f3e4bbdd03a1e0efa3b30b3f592
Message-Id: <178700553470.1769471.7922659106478508713.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:34 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:11:26 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.binfmt

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9cba7ebfe539f3e4bbdd03a1e0efa3b30b3f592

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
