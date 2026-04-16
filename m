Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30221CA02;
	Thu, 16 Apr 2026 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308015; cv=none; b=HZFIhP51atwPyTu5WWIgPPHvyHwWIuzogDqa5Cb9qCrqA+F+tXjFRFY1lr7vG0FYZEGvf0/bbRXRSMtjJUpR9K4llyK1oxir2pWIs1bkjNzqJEOOQY4EkhM5BwHsd05LPUQ82dcs/jNVcbNkwd6ZXMc+zywrl/GWj5Fmlmk/1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308015; c=relaxed/simple;
	bh=o9YayQ4hcMLvFMxl2V39KKmPUbsuHiymstdwgdhKssI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K2CGfY5lAuKEHQLM/U6OXJcJIcmHqXYnYEJ3Sk4awtryIZzCjQ1fmKkmPuviJE4DZq18NVZHvv17Xoattr2aHSpCqRhQrInawrDDYERtNMiL5GSZM1MGTKuU9VYoNphzTenUBzyasdj5mCPMyd0pRH6Y5aBXsvUyDsTV1iyfOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpHwZPor; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpHwZPor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6D7C19424;
	Thu, 16 Apr 2026 02:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776308015;
	bh=o9YayQ4hcMLvFMxl2V39KKmPUbsuHiymstdwgdhKssI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WpHwZPor766LpZ9PyrTE2OrMQuHAAx5/ycxTImsVxW/QogDRvAiJXUYdllyG5NLih
	 HwCRfXucJd7ClTwRiumVZNXFnw/tIjhOd5zJD1Ug0cuhTh/I79OwQ15LqWuWetKbNI
	 DVZSsq97aQ6ZWZ1WMoCU3FNt7MPlVau2T775/35LQw4+LhZRfCjL1Dzpx5UaQIM5Xz
	 QR17O3KDnXXAbK2wffP28XXxwXT5Ykm/Pn+QeiQjXPM4vjppwoajX7Ya1s1nx00G4W
	 5uU9xDSvcABlOd5K+OgDncxXbHf3Sa3hQ9/asG+hjgmR1+MXW2cDhNkgXBr2EDNN5G
	 9xP0LWoPhojYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7E29A380A964;
	Thu, 16 Apr 2026 02:53:05 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegt4sD_u1Qv+NQcQdJa=b+Je7Z973J=Ztcad8YgmEQU8Gw@mail.gmail.com>
References: <CAJfpegt4sD_u1Qv+NQcQdJa=b+Je7Z973J=Ztcad8YgmEQU8Gw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegt4sD_u1Qv+NQcQdJa=b+Je7Z973J=Ztcad8YgmEQU8Gw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-7.1
X-PR-Tracked-Commit-Id: 2339f9cc9f080eff40432c0343d358ead39a4988
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acf6c670e476304c89b5e9320ca8f9d20c9e0aa8
Message-Id: <177630798397.2583492.9504061938400140052.pr-tracker-bot@kernel.org>
Date: Thu, 16 Apr 2026 02:53:03 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 Apr 2026 09:50:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acf6c670e476304c89b5e9320ca8f9d20c9e0aa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
