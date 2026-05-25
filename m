Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8013E02A
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779739382; cv=none; b=fSd1eRvszWqbG8wuKTBlYQKakIYoZ7xr0Suqd7MPXHyOSIwYUOw7+p1BVde4cmDGdlYYPDrV+qgLK14bjK1PU5FIaU/ehcJdOGvD4nEtnoSLoEjlKzhNLp+KrCHqWzxRxrSL8HEyKDLBcMN2x5cALiPtyfR+kKTIHmkga3eI+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779739382; c=relaxed/simple;
	bh=VpqkGiW2It2wU4h7uqD87rC1takwoiB/pfrUAEZHQKQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s1JugV0TFdPnbx/VsfeqgYQTuMx5O+7QgjYzi1Ngh3l1Yjgcj8HnnMsaW1E1cVSjJdk8e32z81qhzXYvUAEhUlZiQbWDpovg+WVOggy952TrszG6zTnUxM/DZaw16m5hhkPwd2yJrGEv+PdXUDNTvFa33APVvc/gDdSh+Zc3A5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlmJi0O7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlmJi0O7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBD41F000E9;
	Mon, 25 May 2026 20:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779739381;
	bh=GvJrej6bR1cLAfjmc/I8AJZAJb2VAjHEFAtzyk7G52g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=IlmJi0O7DKV10VcbYLMt4TZiFgyrkkNVKXhIaMMBH6Zm+8n9ZKgiF35OANutULU8n
	 qtjmmM1WrXqq8FzIx60UUjJ4SFM7+S4Zb7fZchnkMnqWZocY+DDJk0NyPGB16/qu33
	 CMSCsqMr5kMjG/7p7yoGDBReDH/zgk71ucKl2ez3T4yxeozLIs/gqh+UcEEaTISE2p
	 BsHFzCLpxmz5IPEShkc18/sAVo/L6Dq/SlKHxYvaUfedSnkL5+DTV57aCjFLichOw4
	 z7xWKUeVUg7RdxKyp3XqjCz/oirMDjlIn83Omri4rs7AvWc/8xw1yWta8IV2S8giZ4
	 nVD5CXEgL2mHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56CD0380AA76;
	Mon, 25 May 2026 20:03:09 +0000 (UTC)
Subject: Re: [git pull] HPFS fixes for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <c28d3045-a040-d66d-7ceb-702a071d7621@redhat.com>
References: <c28d3045-a040-d66d-7ceb-702a071d7621@redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c28d3045-a040-d66d-7ceb-702a071d7621@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-7.1/hpfs-fixes
X-PR-Tracked-Commit-Id: 974820a59efde7c1a7e1260bcfe9bb81f833cc9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
Message-Id: <177973938782.3099881.7270298030506005136.pr-tracker-bot@kernel.org>
Date: Mon, 25 May 2026 20:03:07 +0000
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Farhad Alemi <farhad.alemi@berkeley.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 May 2026 15:03:49 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-7.1/hpfs-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
