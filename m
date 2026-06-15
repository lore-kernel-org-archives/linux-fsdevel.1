Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1CF30AACB;
	Mon, 15 Jun 2026 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495132; cv=none; b=JHEEluviz1MtZnd6yJi19zol+lNRuxdMRNkEFjuI/lxYgUgp/BsKYmD85dQaKoVbGpwY82McCllD1Pk/FDnJvizhJX1NwUmJ2yPmS7ELmB519OOLoC8sY5qjSbOEPlIS5FJKOTjUILdcyBbLrFUIRhMV0gq0oYY0e2t7GqLiUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495132; c=relaxed/simple;
	bh=Cze6xr/ekVVD2lj6rawn+2YlloRq8MUavHDtuHHs6MU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zg00aFVDKOC/roDYjfECZIYsxWCKQke5tOFdtb+nTwbkrcZFXvN/DEGU3FfFQG8BOzXBZLte/QYaLgWKFOhYgDnBdFg8D3l1hmJkzgbn3Vw+E2BuwdthzRV8mMKEjDNr/BrBaKu8lRzdekDDL4/MXdLmbkUmGgpRGFE8raDcW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESQvCNg1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESQvCNg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51611F000E9;
	Mon, 15 Jun 2026 03:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495130;
	bh=n2HsVIF5H3/eEtZXkFLrPADKjXHHihEi630Fs7/hKL4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ESQvCNg11MA9IwuxrsuzWdSz9+yECQJs/jaa2TdS1POOagZsrPjmfFkfOEkNpKhKi
	 nG0mGRhuMQY3urcBKPKldfuev1kP76LAs8SBykqO4KXmtzqUKB+Jlc5nbQttOAMd9l
	 ywUo36ig9qxv5W5CO6kvAWHf92RNtIVOyX2E03ZlK+teyka97MJnkRoTop+F7jiiiD
	 VSbIjSrvDnk+aB5HJyAqIBI2gWiS0ibwVuBSCku1R0+mJNRaOezWOHX3ic6h1NaHAn
	 Iqj91OVulYGFissuD2elm8E0dXqUacbsepD2pqEBTl6iTMfRreWywsgQQXoNUogY/6
	 TtCM71uDtPdQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391C3A566D6;
	Mon, 15 Jun 2026 03:45:27 +0000 (UTC)
Subject: Re: [GIT PULL 11/16 for v7.2] vfs bh
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612-vfs-bh-v72-d55cbf8fd827@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner> <20260612-vfs-bh-v72-d55cbf8fd827@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612-vfs-bh-v72-d55cbf8fd827@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.bh
X-PR-Tracked-Commit-Id: f0d857543e4d37464759c338f46ad6c85a618a2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8ed3a15a749246ddfedb84aab9cf0316c7b9b8a
Message-Id: <178149512623.2410512.3269946226319460945.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:26 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 17:14:35 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.bh

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8ed3a15a749246ddfedb84aab9cf0316c7b9b8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
