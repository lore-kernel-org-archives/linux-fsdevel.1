Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168F2D8DCA
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495143; cv=none; b=Z9kY98P+ll7Bt9LY+49oPJEQUDijoA8bSgW4kPUJrZyyQnjwaHSNJQfeXOSoNBq1eZlaceZxfiBv2Y/dAaBYJ5TdvQgl4ZEjePJVLy7gnfbJ5CSVTPsLDz6QrE2Xt76X2UbeLlyASoDSTfqIGj/8R7B3Ow0rdvtB7o+MdH+nwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495143; c=relaxed/simple;
	bh=4OGSz0ALtN/EnoXCwvXvtrFxaqyUy3y61Ncu7MkYric=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U/pEJz5hT6L/6w6LvarQDYL86EOv8yElD83SWAirJ/NtI4chUQoiApvz7GD6RuT5Yz6Lt84SNxTDfSqsg4ZZPb0gwLdhLZ2VNcrtxKjUwOH8c2IS9ovcx00mbAdkzGDHY5nL0IQRrtUPGEDJhI3j9zoeqC9v9iBhEc9CcxZbRBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcEpkBEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcEpkBEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0C61F000E9;
	Mon, 15 Jun 2026 03:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495141;
	bh=eKtioJ69KEYD/n6oO8ClTfPFu2c1W6chFQ95VnPRQHg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=dcEpkBEUkwHRr+3ikI7uYoN4MdTqzpox8xhXi3D8Lk+LjHaHglCMLYu5CqbJE/NxX
	 vY8M8KQn66ilyxet8kZyAZnlMNk8Zh0E+ItQ/gS0vCyteVSYZLMG1W6Gi+0STB8E9c
	 w2BsnvkllMBvS0gaMZADTiMSuq4nlZ1CYgcN8vQmpNmqwsGQ9KXFv/sBZM7AXPj2RW
	 unrGXATW+EJf9t4aRtytmb5Dq+JAwNTgaykCOcD3GEdM2HrNTZijN3HWyT1wwFSs+u
	 c1T0XV/RObFNltt0PSRoDAD+8QIs54obdF+TJYJJlC3pamjfwvT/Cp0lh8+oS3fgQy
	 kQPy4fdR2IJBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198383A566D6;
	Mon, 15 Jun 2026 03:45:38 +0000 (UTC)
Subject: Re: [git pull] vfs: d_add() misuses in ->lookup()
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260614223218.GQ2636677@ZenIV>
References: <20260606064956.2722874-1-viro@zeniv.linux.org.uk> <20260614223218.GQ2636677@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260614223218.GQ2636677@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-d_add
X-PR-Tracked-Commit-Id: 2555ac7a450bf11f8e461ce6cd0f62613734a796
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ab34af09f292ca9620dad8df253fec766729b29
Message-Id: <178149513674.2410512.1129753833255488626.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:36 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Andreas Hindborg <a.hindborg@kernel.org>, Tyler Hicks <code@tyhicks.com>, Namjae Jeon <linkinjeon@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jun 2026 23:32:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-d_add

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ab34af09f292ca9620dad8df253fec766729b29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
