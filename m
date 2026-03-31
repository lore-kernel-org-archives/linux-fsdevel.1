Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B623FC41
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981897; cv=none; b=Gx8VdqRa4cfj/gvzh7/x+476/6hMmQg1lzb1ExyQDCFTZDZJJGfD17+V8p1JhXiFDGiB0V7KXjxy6DMSWk5Rrvpch1FT5Fxy08XKkDJ85AXnkxi2WaZcsJwZMSS1mwdP6VsKxlHS9m9PKwlNvdko42iuXH5GyuszzoFx9CBVGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981897; c=relaxed/simple;
	bh=BgoHp3fynExe+2b185+0sIyNhy3hoJfNpQ1eVqQcS5s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dou1Hi3scUHFuQcxMtKkqD63Xz8Rp1//de48lhNrtcmt+fXKwyGjpxtPJlg+OoBZduDZ23g7unw6CzLW6BljzBua+zUCJSiZ07bXptM1Jz6mkY3WWZqVR3tkW2boq4fZAydfc/Rt2cHBipqvBc84OwgRWXFefZUno0YkB9ce4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nrr+OZBb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nrr+OZBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6CBC19423;
	Tue, 31 Mar 2026 18:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774981896;
	bh=BgoHp3fynExe+2b185+0sIyNhy3hoJfNpQ1eVqQcS5s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Nrr+OZBb6rXdzIY7YxYMY+WCwMvdZtHGHYDiADwbOaDaZwIVd0H9MLIyC/vE8u4S+
	 +e4rE5TaCqY57KB3YPKn79Kfh6IOdmdo+gRSnohkiuVUHNAQldswipZSau5BXdw7nE
	 b/7ulj8g8Tzaj0o8ajzQAdSS+g0nzDpQ73PY3mtslWZSbpXlCUjEweBDdIp8Kp26tQ
	 gLnwAfb3clmaFgts/rJm9K8xwK/T4j0UBuwNAlKOMjOGLjEEcn+MKsd+PqsneAeMkK
	 RJmqwkwmJ5zqufrA4EHzI13KjAcJPz2wlN1cXkI0ZeCKSypYOgR0pIRXgmSNq8Eaue
	 heujC3Sb4/zHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFC03808203;
	Tue, 31 Mar 2026 18:31:21 +0000 (UTC)
Subject: Re: [GIT PULL] udf fix for 7.0-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <462tylahq3txzns6guwf6huabgovydarvwhjxiumhiswmccodm@xagpzm2gozdq>
References: <462tylahq3txzns6guwf6huabgovydarvwhjxiumhiswmccodm@xagpzm2gozdq>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <462tylahq3txzns6guwf6huabgovydarvwhjxiumhiswmccodm@xagpzm2gozdq>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.0-rc7
X-PR-Tracked-Commit-Id: 102e57d56f81fa5c5ed78f576101d1bf1b3e6fe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbf00d8d23b43a7a1d717e704c50651731d01d71
Message-Id: <177498188007.2857103.16938627228688543826.pr-tracker-bot@kernel.org>
Date: Tue, 31 Mar 2026 18:31:20 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 31 Mar 2026 13:49:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbf00d8d23b43a7a1d717e704c50651731d01d71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
