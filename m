Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9A91FFC48;
	Wed, 24 Jun 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322453; cv=none; b=KhH23f/2uuAM3U5lSbc0uW0NO0YPo1xg73nrLcPNR6Z/VORCfgS07PhfRA/KQWwHsV7nuD6k6VAKzJMj5NFYg8W4SynLl9hTwxgM+TriUeKc5zTScihqlndazy6frZPKNc5UdGbAPSA7tg3RAOQ5pXO2/z/EJjjqAF86YnDR6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322453; c=relaxed/simple;
	bh=Lx8sNzVy3en28MWQkj0wqo2PDuapP8NT8I2SiNbkdCM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Hhpu4WcDaf9zys2iDheZVOJjo4labKfEQ8lCIq34zadgfv+7jRWEm8uTaqvQdr7uVskx4ViI6zuGkSGaYJpA8nyTu3LqKmormBBib69h78UqSYXRGCjog/n2UWv2vKDbpC/4gXL+c46Cgh4/12waEbkz0SYVBs1UniWOkVqGAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFu71/2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFu71/2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C8B1F000E9;
	Wed, 24 Jun 2026 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322452;
	bh=mqqnvKoyRvjCm51EYYKzRh5KcOf70lqzMhet35d6tfQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=FFu71/2d+9bpzNQ9fXipuqUIA5H1P7gNcQQW6Khfvck78UmcFwVslsHwBqLFQjuOy
	 8ECU8wn9Ppm+9owyQQrpT0RgAFIam5o27ycjF+E2DXmKDlYzfKPstuq0oRK6KlJedh
	 tOP09DN7ytSJaE1NfYAmUH5QgzZZFPgvOrnG/OGRInE+RgPU87jSS0vSHK9zD7ZA8s
	 f4CdaItOuHUNHE+EIReOTt+/QhfL8f2KHz5/AZlcRifeDdARJU3xXL5uYdOtjmlxIh
	 5sN/LVzRqkU6UFhiUMt8Ik4qWwu8XVKR15K74qH3j2g59R4xPWx1Br37PXOetR6+EF
	 +8sPAVJCi+Jwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CA73AA6A47;
	Wed, 24 Jun 2026 17:34:01 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: changes for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260624063725.5151-1-almaz.alexandrovich@paragon-software.com>
References: <20260624063725.5151-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260624063725.5151-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.2
X-PR-Tracked-Commit-Id: 5b08dccecf825cbf905f348bc6ccb497507e28e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0e6f20cb52b14c2c441f04e21cef0c95d498cac
Message-Id: <178232244041.2912789.1112090141455320884.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jun 2026 17:34:00 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Alessandro Schino <7991aleschino@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Edward Adam Davis <eadavis@qq.com>, Helen Koike <koike@igalia.com>, Jamie Nguyen <jamien@nvidia.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Michael Bommarito <michael.bommarito@gmail.com>, Mihai Brodschi <m.brodschi@gmail.com>, Tristan Madani <tristan@talencesecurity.com>, Yunpeng Tian <shionthanatos@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, ZhengYuan Huang <gality369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jun 2026 09:37:25 +0300:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0e6f20cb52b14c2c441f04e21cef0c95d498cac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
