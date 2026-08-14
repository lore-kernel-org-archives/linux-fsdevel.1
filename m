Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9B342C80;
	Fri, 14 Aug 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723234; cv=none; b=PuZTraSxwPiRg+K/4CVcC72bwWvo0sZNs18/NJNj7zDvKpgWPvQ0Ys1opzQJs0pyl+55PCVcY2lzzQfpCEy02B9NVB3CoEwrrDTx8LajM1z7Fmo9f1DeTx6uzrzkJHUicX9SKRSeK+bc3aFHfSMtX0i3JoJn2+MqqiYe00Lx5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723234; c=relaxed/simple;
	bh=ThR/wLVpWaaEBu+R9RVfrClPCjbhmV8EkOpNTnMt7S0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i1UOY7G17j6SPxx+zVatrG2sRxvdocn36IULrD7Av8n6L/i1lLlqZs1QtHCvCVtnKmPviY9+WqHDNwx3KaXeazd8l7fuD7+vBpllDCjzMxU2lW0XcYOq5beoXyc1PZ7hEpSmieIKbHBogbUrKMbYYlmYYGpRAhEEin37bitUzNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfIqPobr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfIqPobr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEABF1F000E9;
	Fri, 14 Aug 2026 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786723233;
	bh=x5A6BO9ULyjox5izlEX9s0q+oJEYTubQrgqkoGajsGk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=IfIqPobrzRn1C4sLUw6s0pMeadEp3BZSwaCF67s+8pk4WN3ALorws9lY9hxtXgf1P
	 l758RCo2PuKP9csCRj4L05NYUjb09exf3nn4B75skE0jSG2mtcvzsNxY24zemylE8z
	 Eq8VAD8RUztN5AA/hLvIe0jfdF4Jav0NEOoXDi3aVayfgmKIsQhcI2P0HregPs1/Yg
	 JCsOVEKjGOUINeuRbRWzmbKiKkaSA8d6LXEDs1Lh7J4i9xz/4uR6d+cY/blehe4K8/
	 GE9uBYW9wB8IkgFo+bZzBmS+c0hdfvuvoDdQm09w5IEkauv+FbewYurTww3ezr3Iqb
	 GGY7dPHCIYBWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199273924450;
	Fri, 14 Aug 2026 15:59:49 +0000 (UTC)
Subject: Re: [GIT PULL for v7.2] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814-vfs-7.2-rc8.fixes-6d7ba75b0b43@brauner>
References: <20260814-vfs-7.2-rc8.fixes-6d7ba75b0b43@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814-vfs-7.2-rc8.fixes-6d7ba75b0b43@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc8.fixes
X-PR-Tracked-Commit-Id: b64a9f67e082e04835ddd69d422a25168d69375b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad8d485e665829ecbf3c97b22ce251f8ff5f8037
Message-Id: <178672318767.3416600.16673912678305667173.pr-tracker-bot@kernel.org>
Date: Fri, 14 Aug 2026 15:59:47 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 15:05:58 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc8.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad8d485e665829ecbf3c97b22ce251f8ff5f8037

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
