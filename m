Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F031274658
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308017; cv=none; b=Rm5/KexnnKoJK439F3KOddsfabfzRXN7EL/qXt22VaIxW/Is7Pm22YPu5sHyhi2iR9l6fwJLr590ZRGw+15vTha2U0BWW56pHN6r5aBoMtEPpL+G1zIq+zlMs+eW5SvR8MVRaUqCamEFgNUQnBv88Mr9L2T3vdRy5ySTv5du83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308017; c=relaxed/simple;
	bh=NXCA0hOA0/RS1+JitGVFZWBryqCusZgqyV4o83sEKXw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lObphcyaa9cMTfHyxFSEXHYM7jRsfAMHa88IyRWBRQIErZqPZByAh9Klev5g/4rQYtRbyq8ZQnoONNACriLtEDNN498wSPDiTpzbped+hZXdgHw7oPLgTcPYKNvDbabuFyHhffmnnyxGNBbFC0xFcgUAjmQqKrKBUQRy/7MdBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umdaD8gD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umdaD8gD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E54C19424;
	Thu, 16 Apr 2026 02:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776308017;
	bh=NXCA0hOA0/RS1+JitGVFZWBryqCusZgqyV4o83sEKXw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=umdaD8gDXNkA7VWwX6Bc7Y/8MB7VV2FYYYtqbwTfafCE2o+CAirJ99G1TXd+yEJ5m
	 wxDupMku0orVgDagX7Y7MKQXJcsVEy79vbB3fMtln5g1rCTo5wU1q1ytX+dmNZclNj
	 tEqgNwyW3qAzpNUkl/LbtBtWDXRK4UHcX6SJIa9mTNw8RMq8Mx79ni8SnvjaoqdwAP
	 Ke6mUVwffJdf8a9EemD2BQGyreJU+p2XacnnN8LLvTA4vAx2OF2tvdNsXo3jOzBhst
	 OKrkhIuGZR8U22B37iBbrf8wkkHcFQuUmCrPdq2j+FrTx3qbN2WNwBl/eUpHcgFuJ/
	 9Q9+COUxPEOtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDA0380A964;
	Thu, 16 Apr 2026 02:53:07 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <6mrxhg6cbhfmo6dff7b5jgxxckemswceme7xltwa3rpas4dbqp@5b576nbeagp5>
References: <6mrxhg6cbhfmo6dff7b5jgxxckemswceme7xltwa3rpas4dbqp@5b576nbeagp5>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6mrxhg6cbhfmo6dff7b5jgxxckemswceme7xltwa3rpas4dbqp@5b576nbeagp5>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.1-rc1
X-PR-Tracked-Commit-Id: 0fdbe845534f4e0b7243b7a44562c4486ce25fb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4ef28fe97556db32ffcbfb4cf8bd7c2b34c3b9a
Message-Id: <177630798600.2583492.6924449113779025835.pr-tracker-bot@kernel.org>
Date: Thu, 16 Apr 2026 02:53:06 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 Apr 2026 12:19:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4ef28fe97556db32ffcbfb4cf8bd7c2b34c3b9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
