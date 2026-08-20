Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E53C1984;
	Thu, 20 Aug 2026 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255875; cv=none; b=kJ7HaQjXW46FlZjbFuJUXIe7QwICqB54oCc0xc9jJ4ej2PTwFjvxLdqg7m+k1DpGlHSvWrPgf40OW/4z1gMn+ORmEJWDHgD8y62FNWy+SukleszY/BhBdVod4JJ2VThCSDOABTV9ZTkPrELB19u63sVpzleeS/ZShGwQO0sfmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255875; c=relaxed/simple;
	bh=9o1HuSqcG8vJHII8JmuRRkrXAOHK/y7qWhmA6K2Ezt0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cuGDp2YzzHuBbEA1t/V8RtMlif2BABhz4TgE0cGTMiDz+xKKb++BE5kTZ4NcsPL2Pqu7nB2N0z0AWSplLUhuq+dgi+U+vz2yuZtau5a/lvttEwrhJwwJjue8i75dewqz4ybNppU3l8/y2ebBtdMFcc7efhDf7VJN1RJto5qWm+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQyiAyhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQyiAyhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678AA1F00A3A;
	Thu, 20 Aug 2026 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787255868;
	bh=nk9mKWcC1GQ/YLbq7h/db/TuO+5g+L54WLYISYzp9oc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=FQyiAyhdzsjGou8kg6jUbi28MnzM8Dye9w6VdKrNBYtEudczQMdou2wdc4voKIBEr
	 b9RHZ4R30uWX/fbOL6pFyUAWcPN4uj9wO1eF/3n+uz0DkzF3YkvVFLzo6emjSx5PPF
	 Be7oifM07bZabwhqeoE4sa7pAWTu/qKvxqnKqIw8XzYcNmqfAe8FagoUCLNb1CoKUx
	 DP8Uarch+X4sU9ObGkOUvDTKoK8biXQSCbG/YOQrMXY9wYWUVfNoLq8EbXzb8cJekr
	 02MFs7dEYkQBtHxUBiw5oidHdmqs6O3EMhB7FitTPvWcHoYGDaOKEzA2ZNhlPHzaTY
	 MmYjQAtS/56fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B46392445B;
	Thu, 20 Aug 2026 19:56:59 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: changes for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260818122105.24094-1-almaz.alexandrovich@paragon-software.com>
References: <20260818122105.24094-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260818122105.24094-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.3
X-PR-Tracked-Commit-Id: c22f91d82cb9a29d22bdffdce6c803467984ad0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc83d18cdd90482c70fa4320160bba70ec5c9ef8
Message-Id: <178725581850.459220.4053908989865636384.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 19:56:58 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?HE=20WEI=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89?= <skyexpoc@gmail.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Kyle Zeng <kylebot@openai.com>, Ruoyu Wang <ruoyuw560@gmail.com>, Samuel Page <sam@bynar.io>, Senjin <senjin@hatchling.org>, Weiming Shi <bestswngs@gmail.com>, Weiming Wu <weiming3@asu.edu>, Xiang Mei <xmei5@asu.edu>, Zhan Xusheng <zhanxusheng1024@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 18 Aug 2026 14:21:03 +0200:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc83d18cdd90482c70fa4320160bba70ec5c9ef8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
