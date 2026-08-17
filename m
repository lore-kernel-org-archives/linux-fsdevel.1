Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650733F12C6;
	Mon, 17 Aug 2026 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005588; cv=none; b=QxnGhvN7nY/HejFbuakgeKmhJKZCDMY6uPOvRbRj8Ntw5t8qowndGLzjPX4UPeipdMmj0wICsxIKXXiLFAMv9P8VKiuZevb0NGEWa5AgrHTWl5a1h0E3o3lY4b1wS40xCOHicFrsIxj+s8/AWKYF2kvCH7SD5SDvja0uIMOn494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005588; c=relaxed/simple;
	bh=I+6Xq2hdAO7Pa+Euc4P9sdFcRimJTSQjBhoWNEGq7oM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IIE2Qe9ypghkd1dKJNlr36PDNB/UYxUmSaL8SHemMPUgiv98aHa+vsw671yfyg8c87dTJ2b5d/YQ2sc9jAG6pVBeb56W1CFDZ5xe6zXP5GtCKTDqAJuW6C21K8lVrJxGq0+uwhWDJfmBvsyhd+x0qVZOpFjTh8PXk6R1hBr5yLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp51AMDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp51AMDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DF91F000E9;
	Mon, 17 Aug 2026 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005587;
	bh=Ww+h+hKCZGTEbH5Y/C3UANrTWFniaLYOkZRmCGdyEsE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Lp51AMDAFdWnw+cFITF8OliDzOqX/RokaMD/eU/pW7F3DWjDkGpxciOg8zsBogMMC
	 aL0XRC6gqoyLsrYXl91JraRTIKP//QKsKzWCyp80kAIFLbZfPL4ZJ1N3wuvg6MXdRZ
	 BFXp3GqxUWKVSKT588utz3Xi2I6bpT1DBR9H864IfjK5wNtiN4oPPZKcMwYC8ZxDYQ
	 4k7LF/yQoDyXyBHKieosEVF7h59kWR7OLJgQPxTTNKqf857cXJ6bN7d0rCIKFfluwn
	 za5zraJ3VqkRh5IGNCIbB53Lqxbrv9gfBOknVEnY40XNB2C4qrT5rY2t/qloYtS9Ut
	 EfH+7y0Ks8C6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398A3926274;
	Mon, 17 Aug 2026 22:25:40 +0000 (UTC)
Subject: Re: [GIT PULL 06/18 for v7.3] vfs fat
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.fat-26a476e80678@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.fat-26a476e80678@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.fat-26a476e80678@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.fat
X-PR-Tracked-Commit-Id: 9d7ed813ee5ff0d469bd99630828ed6fdef4e8da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d1f95267769caf5c3eb71a2c9586213ea0a3ef2
Message-Id: <178700553921.1769471.10399992289027859677.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:39 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:12:03 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.fat

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d1f95267769caf5c3eb71a2c9586213ea0a3ef2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
