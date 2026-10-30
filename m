Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793318622;
	b=gZ9/Zxq09hwpijt+TEGIiYXICtiG+z16nNYPQO+yyMc/yW3u2X/vBzIh5M/kRD+rtUU0
	 4LvVGXEMkQ+uCp0L4bH3FCrkuki1r5vXzz7ZpiqYQBx0H8AqAG/H0RYQ4WdD0ThxswACA
	 9PVimOSIm1Qu+ITnxQ+sxxmyD4SS5TlG3PQMpSYsFNEI2t5oN/mdL9j6teaPGYzRWLXVD
	 ADFBcQEQJjGgiwAPt6PgI+qLFqEwAFhj7+8lZABYBYvo9rJB54cxYXRcFQOd+XiRw9sdK
	 lJxf3sS/trRqqbpFA0JTrdGgPfTXpHy+p0Jb6/Icy8vxspWIllMk9uO0Wo9SfAIeeWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318622;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=dMHxnxAuAY51WsK68Hbq8XLJIMVe6FZH8MOvZxQQ2Qg=;
	b=beHsHzg3aQmwZUun0uGqKwRKS3c67UIOLHCBtpj+JN93OvC57/ad/xM39L4xVlcw6HEc
	 OKgZ0VDTy+LETMIAfBY9x7SMMmMX41/akA/6xZ8WbLNr4N58EovlZgJeenDZWJMg+OikL
	 F1le5RU1p+0pd+CBeXXh0pChMa0uCHA8Rt7aFmDjo4asCVrMDT42B6KktsYhHRCubsiPN
	 YwE0rnqMNxvI89ZQmrURJsp5CCCiuepjeB1l43o9dZA2vu8zyaIw3w0aO5g80nkUOSz3a
	 rikFL6OdunkN3zGkUEMXidDvOwip51EkZdbtyn51sUH1gCIRufUeEhRCYlvW31uW2KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTC0PpSS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD180606A31C;
	Fri, 30 Oct 2026 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTC0PpSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8875C1F000C1;
	Fri, 30 Oct 2026 00:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793318621;
	bh=dMHxnxAuAY51WsK68Hbq8XLJIMVe6FZH8MOvZxQQ2Qg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=BTC0PpSSWF5Nall0NukdFuR1nPpc7VJuccTQnJhaWlIJRuZ34gttFY6DubQZpz1z0
	 zbJ/cXX2GxL7h8+WEbBen3Pmmptv1NwsbwmwMFYY/0c+DLZ5GwwmloeUr64SugEkae
	 m2EUMn4KJTs9eCUdiyWViK8maoucTwlFYcSTdzhebIldYQzOrf3n3H2cezXweaM+EZ
	 EVr3w9d1iLJFuetJIOEc3C/4Bq7FwrBsVdYd/BESgl760kso8sqa7vGyKHZC3aS+Hn
	 HKd/BHH7F8kShZNwYEQ8+UENRh+TCHJaPyEkTznRVJQdMgH8/u559Tjy2ubFMP2Ni0
	 F85vOe3fI1Ifg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D3FE38007D3;
	Fri, 30 Oct 2026 00:03:41 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: changes for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261028073622.8942-1-almaz.alexandrovich@paragon-software.com>
References: <20261028073622.8942-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261028073622.8942-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.4
X-PR-Tracked-Commit-Id: ee1cb3443cff5a800948b662756f75b17ca63fe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ff8f40110872ecd3a9918e56ddd0ff1b46fb10e
Message-Id: <179331862015.761441.4068740279355063428.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 00:03:40 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Alexandro Calo <alexandro.calo@nozominetworks.com>, Baolin Liu <liubaolin@kylinos.cn>, Dmitry Morgun <d.morgun@ispras.ru>, Hongling Zeng <zenghongling@kylinos.cn>, Hyeontae Lee <wonju345@naver.com>, Ibrahim Hashimov <security@auditcode.ai>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, liyouhong <liyouhong@kylinos.cn>, Matvey Kovalev <matvey.kovalev@ispras.ru>, Michael Bommarito <michael.bommarito@gmail.com>, Slawomir Stepien <sst@poczta.fm>, Vidhu Sarwal <vidhu.linux@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>, Yi Xie <xieyi@kylinos.cn>, Yousef Alhouseen <alhouseenyousef@gmail.com>, Yuejie Shi <syjcnss@gmail.com>, Yun Zhou <yun.zhou@windriver.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Wed, 28 Oct 2026 08:36:22 +0100:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ff8f40110872ecd3a9918e56ddd0ff1b46fb10e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
