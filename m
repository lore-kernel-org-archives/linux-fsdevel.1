Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B03F8246;
	Mon, 17 Aug 2026 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005589; cv=none; b=Sa8Ty/yPY5PFvLuknOdGBhQpyg/cDRJ9eVe9WyMH7+w7ZN0bo6piG4fSAiJ9dpliD9zdXGXJYxTBBf+O2BvZUATsQW0bqOp657prFNLvVEMRsnKS9uSAowy4+YPg9HbzMU/Ip54uw6ZuO+fI/skfAh+xvdFf0zs5TzTp718zYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005589; c=relaxed/simple;
	bh=plijefQKJzs2hVrqIS9cwqipKRDjBKUQAUa2GsKR8Yg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pj59JgSkSBgrG6M+uWXn5WzsrVEAV4n/TtZqNb5G3MrGe8YfIRHJVJ6WM1Yg532HUjwqN1qPM0/1VidnOxEtRy+vHKEkIGE1gYILU2vQYKIR34hPv3qCeUt/mPF2UDJxpID3LSvvS093jhwxYBRrmcpfsWe0pn9VXbbAo5wwyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov6dmi1H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov6dmi1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30EA1F000E9;
	Mon, 17 Aug 2026 22:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005588;
	bh=foKh8fnc2FDgrZaGrxD9POmYfwvgzahmPUXt/U7Z+7E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Ov6dmi1Hw5D+ZeIyBis5OSeokAIT42Vjz5xzczLPAqqCf3wStJ/9zBZvTvdqZQIKK
	 LyK6DHLIjbkFHfhGpq0oWGrxc6P+ewOIBDBLeCBfbe8uOzSl4NG0CuRaHqi0kDtpb3
	 0JZSd5YBeF1/3ypbTqluN6goq25cl3coQ2jvMxqwTB4tiIs1oYiTjX18qofN7MW2DE
	 0qiMTsPwitzZO8YN+Irp7w3uO61mKVFc7jxadnLeLw1Ptbs/VmY4MqcScdo4Mt2Xsw
	 VaTBSjQ9uCpWdwEHoSmKnibKosMcYguPhbGTpdASxR1myQxBIJVaqhljhktWf7iEvr
	 MTECKp4v5CJpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197743926274;
	Mon, 17 Aug 2026 22:25:42 +0000 (UTC)
Subject: Re: [GIT PULL 07/18 for v7.3] vfs freevxfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.3-rc1.freevxfs-3ea96320f471@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner> <20260814-vfs-7.3-rc1.freevxfs-3ea96320f471@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.3-rc1.freevxfs-3ea96320f471@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.freevxfs
X-PR-Tracked-Commit-Id: a3ed4fcd04b95347ad04cf4409b394bb7fbd0c02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d31a688a49a82a48e0434aee9d851e094270a6ee
Message-Id: <178700554070.1769471.11257788979600483715.pr-tracker-bot@kernel.org>
Date: Mon, 17 Aug 2026 22:25:40 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:12:14 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.freevxfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d31a688a49a82a48e0434aee9d851e094270a6ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
