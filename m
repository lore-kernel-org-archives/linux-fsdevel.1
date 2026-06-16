Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B2130E0E4;
	Tue, 16 Jun 2026 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593691; cv=none; b=AK9IauKYKaU24MsZNwDQj5RJTUssaM0iSRlwi1xPNey5CtvhWPj/50VmwFzDflywBxl0OYilJTmYzf3IrLzxHvfg6Cq/ozgP9/Y60/dTND0mR35bySrOAhKexxOdtJYAh0IbydNNcWRqPMk7lROKTqsO2VQP/s41IinqCCC/s8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593691; c=relaxed/simple;
	bh=VBMS5RrmtX5080A/6IMzY2aU3s1PaBHHPJzv6CAGpHs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sPOmMVWvt9H59oMhl2D+I90YcSAFmfxxr2wNQzi9PBJQTXZiuvcKWBXzWsRa0VtslQVdzoJlKO6USrk4Ea+Ma/5oRmQznPdI36+7HZLHGW0g7mwbiDoUAO5Zf+CDiC7vHxvFU2M+StoWTtq3+ZyAf5eE2/b520Ttqrx/I1bcbNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crRpc5Fu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crRpc5Fu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77091F000E9;
	Tue, 16 Jun 2026 07:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781593690;
	bh=IVnrclE/OuzvPo8ookNc+up42syF9LEwu2o7GNyJUVo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=crRpc5FuhmANevNDrsHX9+QoJq25iMSoaGNQBoS/vWVypBkfU99LrkTDiRgzFlPvm
	 5JZhikMxwbxMUrXWT93QiQDMNl3SxLQfX04ZOWA+20c+hikGOqkMwzdyy8GLbbNlmN
	 eECfH3OffD2ALsNWQ5hCGVehgjkoiQhN0EeckpV9vTpvt8C6imn2QQQg25geYTZfBi
	 NoMLo3r7UzeKqVuwKr2Jtt60WLswcILOW0uS19rUAWsEtKHqOnIjAtyTokXWUe8Vyx
	 BdCuf9fqQ2YVS++w5UE7FAAPDjoyIDzJocwSw4IduXGv/O6Ej+kQItUt6sTZ8ZWv1X
	 t4eqEO6BqqjhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A4C383BF5B;
	Tue, 16 Jun 2026 07:08:06 +0000 (UTC)
Subject: Re: [GIT PULL] hfs/hfsplus changes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <fa1082e07e6396634c97d28d4489ab1902cad099.camel@dubeyko.com>
References: <fa1082e07e6396634c97d28d4489ab1902cad099.camel@dubeyko.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fa1082e07e6396634c97d28d4489ab1902cad099.camel@dubeyko.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v7.2-tag1
X-PR-Tracked-Commit-Id: 7fde7e806657fbe0d33f489521b488eed94f9b39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d29fd593e6836c96c6fd6df2b0cc6a47dda21b74
Message-Id: <178159368535.494683.16401182291250212373.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 07:08:05 +0000
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, eadavis@qq.com, rosenp@gmail.com, tristan@talencesecurity.com, Slava.Dubeyko@ibm.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 22:48:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v7.2-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d29fd593e6836c96c6fd6df2b0cc6a47dda21b74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
