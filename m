Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921330C62D;
	Wed, 18 Feb 2026 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441517; cv=none; b=UUAVdn675fdp6pJBUpckbZtkWlmFTrq8BkFHb9Va2Q+ed1KtlIMMdMNQQOm3T+IksDzmFM1ToT0R4ur0DQ42FzQAIFpBpXoP0i/mWYKCVcr34bSwO1eba3L6kF8JQUhgrfiLWJgvJeABaOLeGmT7aXmkkP9xmAx1vIi+TMQqEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441517; c=relaxed/simple;
	bh=KRWEI0MywRI17OOIliZFe5u+ZcAE6w1v0P6ZsRWuPDM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rQeJaIqMPNbrWrc6dCgyo0THtQQPcH4n4g4HSvo4L36x0tDS9SciFdJaUTULf7Kn5QtsjshJgDTYWeaUGpEKfMepFbTVTGprOFQEDDvmpoiiIMFZgfBE/wnuZlFzHIs0oGDCjR65RMSLV4E46/r4Cc0/eK6drF3WfmS5V2Zoyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxsaxf1P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxsaxf1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA39BC116D0;
	Wed, 18 Feb 2026 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771441517;
	bh=KRWEI0MywRI17OOIliZFe5u+ZcAE6w1v0P6ZsRWuPDM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Kxsaxf1P3RI+38QBh7dpp6Yyh+ViPFroR4Yz3yc9Ni5Kf+Y2DFfxgZ22PjPr2W0+A
	 hD4RwwL7IKGHDu4gPMM9DbSKH560eC2FEPeSGRP2Wf7UmjgzR4sQrWSojODydpVqqK
	 K3ddb8/CUbFuNd3XiSD3D0AbRuBHGhzRfaHnAXd1VeT2vPKMrqsH4KF8I2UyzEaT7g
	 Ik2tHb5MH075uTuSExm/mC2GnvGGFEBoHvd5VW+Z650sRZcphhP4po2dh8c/BfdhDt
	 TEt4NFb+QuDTq63tVSHo5WOGv4cOAsKa1yimQc+aqWWwZGbf3boOgMeVn5xCSnXxL7
	 tt54lPGzahAUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85412380CED1;
	Wed, 18 Feb 2026 19:05:09 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v7.00-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <glab5jvehmpi6poog4lmsnai2ikkysnx2xrjqfizruuf63wvwn@7bsrznabpzka>
References: <glab5jvehmpi6poog4lmsnai2ikkysnx2xrjqfizruuf63wvwn@7bsrznabpzka>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <glab5jvehmpi6poog4lmsnai2ikkysnx2xrjqfizruuf63wvwn@7bsrznabpzka>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.00-rc1
X-PR-Tracked-Commit-Id: d174174c6776a340f5c25aab1ac47a2dd950f380
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23b0f90ba871f096474e1c27c3d14f455189d2d9
Message-Id: <177144150823.1508448.9893779765637440099.pr-tracker-bot@kernel.org>
Date: Wed, 18 Feb 2026 19:05:08 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>, Jan Kara <jack@suse.cz>, Muchun Song <muchun.song@linux.dev>, Paolo Abeni <pabeni@redhat.com>, Suren Baghdasaryan <surenb@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Feb 2026 10:59:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.00-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23b0f90ba871f096474e1c27c3d14f455189d2d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
