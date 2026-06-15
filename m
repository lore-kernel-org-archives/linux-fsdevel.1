Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3752F8EA7
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 03:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495141; cv=none; b=dF0Sx/DtMZOB2rW+q3od3InACr3MdHu0LojR2DSDAxmZm0Mki0s3iSUbi9Q5hlQDf0qvcDmanTeTUFDg+AYIrVCt0SEdc4zUWZb8YY8nFLzdUPEkLjbRaJouJBpjUzAxsOghlXQFzRliI0OK4Wu+eNPCNEnjowTxOy4s+tL+css=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495141; c=relaxed/simple;
	bh=NqbFPZASh3qVnRpQc97W5ZTu9dUhjsWicOyBct++MhU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sUg4WqIIzoLNxYGyc4p3IrTPUh2VFmNlDUTcbZ10X51Gac0RnlsvIhyJQ8LMW1knHVjn/HYhJ/j4vBVKv2LSn0OjduDJyefHxtq3LXjFjg23AaXHK269umlgw9rAB0srkCEBqONSUd3W/Wo+WPDtUPRoxOGs1k03uJJGncJSA+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYujEiR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYujEiR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F681F000E9;
	Mon, 15 Jun 2026 03:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781495139;
	bh=DTeLIXPX5pcmEpNDtVMUF6itBgamYigCchUe6Q2ij5U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=AYujEiR0yf7dc4qqNB+IjUhq8VClXxP1kBgOMVYxXyWSCTuNVKr9KNKtc9grugJM/
	 CE7x7zSg1hJFok+GiCxMixaXdkvO7rCpMmAgXMv40BE5w8T+TRSJYo3YMK2fNr4g62
	 qrG+TOeZdIFiTxhTNhM9UQFI6fIDkdwX0U6woNKxQbxykqAopUdONbCoCFMDdCPcHn
	 p8Lhc7GX4O8DL3RYjmxep8ZqRZaW65dOMPQ8rct8J2FMJKWl5j/H8dVhYW400jIbQD
	 r4e0KyJKCE1PM/EQk6x8OIJfNPyCF+HarD40MiFC6HH31TsORHCz2RIWWiUFPA5Ars
	 dMfbEP0/dz7bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ADC3A566D6;
	Mon, 15 Jun 2026 03:45:36 +0000 (UTC)
Subject: Re: [git pull] vfs: dcache work
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260614223103.GP2636677@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260605050910.1306432-1-viro@zeniv.linux.org.uk> <20260614223103.GP2636677@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260614223103.GP2636677@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache
X-PR-Tracked-Commit-Id: 3df5153c5f123d6018c82a24341ccd99c79d64a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8a56d6fc828bb569fa2dd33c3e6eb16a165b097
Message-Id: <178149513523.2410512.12670692748332995583.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jun 2026 03:45:35 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jun 2026 23:31:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8a56d6fc828bb569fa2dd33c3e6eb16a165b097

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
