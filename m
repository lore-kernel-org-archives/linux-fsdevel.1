Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4953ED10F;
	Mon, 17 Aug 2026 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005593; cv=none; b=t2WxAml+lFCjiprJKt7gQBeGjlLBTamMVnxrpZ280L2p1L9c1mTVN5E3LXhrwWyMYZoXvYCLrB4TM0kh0+3P7olueGYQ3RXtbnHxZE9HWvNAWl6Eldz6zV8akQP62YeRiIWSbFpDQO/+3LDCNB1CjemEV4/UDr/VbfmklaJIUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005593; c=relaxed/simple;
	bh=WJUhtbAuQBxT8B9bQnkc3DwvO0QYbvLVl48xBBM5n+U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CTyC6pA0DzX892gU0cq67ulQDpF2VxNOxxS7qyPxkwA464xwfCS95ZvPFtrt5sg+fGLET1qCrTAvPIzhiXxXWoJdhy1KUFT/3zl0DQB9yF/TqhByfx5IhnpcRXLAGmixm4aGdf3lKHxG5/1B07joc8dNr36O/bdTAp5mjzmJaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IluRDqVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IluRDqVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DF91F00A3A;
	Mon, 17 Aug 2026 22:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005591;
	bh=4r9GkC2w4biLCv7Zg+jDt/g/NpuFJlBdZLPb3lbTjZM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=IluRDqVUIvyYPZN1S06CcrLBJs2OXSirhKfUHSYqOjY5PpI1IlhIFpWELxTKBa7ik
	 /rLPDQgqqScjBWd6Apf0ZDLOr/wDfxbzka2LcxUcMZ+P1MsUhtPxmJ3p2gG4zB7Rs/
	 qCcAEVD+UHVy6ual/7IhAedbao2ueagzP/WFtLl0/FPJxNof6lV9nQPYmJ53s/mPDf
	 S6qgklE6kq2Icl/IWXXe3vcpodp6zth1ePJmZBoFa3jL7OCJ82nVLHYGvUXntyxXw/
	 y/3QS1p4/sgWDPyp9zNwmkYaPb3VIP6uJLFXOBdwbqZxciZFQbgqhLQJhAVOFnpNF0
	 /qG8bBYlkLmAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197453926274;
	Mon, 17 Aug 2026 22:25:45 +0000 (UTC)
Subject: Re: [GIT PULL 09/18 for v7.3] vfs kfunc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.kfunc-15aa56837afc@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.kfunc-15aa56837afc@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.kfunc-15aa56837afc@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.kfunc
X-PR-Tracked-Commit-Id: 8abc1c8badc11c859bb4ba43211611347e59c55c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de03b17ec046d81c4713bc54306579b9024fc513
Message-Id: <178700554371.1769471.6838255483759254342.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:43 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:12:38 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.kfunc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de03b17ec046d81c4713bc54306579b9024fc513

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
