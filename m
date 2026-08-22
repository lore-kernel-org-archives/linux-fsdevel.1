Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEBB38F92D
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787443175; cv=none; b=ntLyFba8ABhcES0cUXrfma1OXYazyqdMbXW7+9UFYG8kIFor4dDti4fUXaEYNC0gNToJlq0TF5k8Ut9fE8BXrZNb1acOL5TPRVXUOx9DGqW634I5oPgjCZ+PP9XDNMVuuEiSVI+o0ytYCQbj2Jz/Rl/eaVyHflv2Zoqcc8fIboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787443175; c=relaxed/simple;
	bh=Ic8zp1JNKCbwwSrRRyCxzyKQydnFPi0WYoeLUCG1ST0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iM/o6FJiNM6zp5dD+xYIC1ngeBspsIhxUL1ny3+VMO3l2jhDnQ5SMY0nvBLlnCbflRbxH3WAc1X8jYywryUrJxKDVKlswwmHMiqcyw2Z95Ki+Yn2U/T6HDtK6zOtQyJzRx5hlz5CEN1mi6/2tPZA/+VNk0NxGUte7UvuKX88fg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr/dq5bt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr/dq5bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0061F00A3A;
	Sat, 22 Aug 2026 23:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787443174;
	bh=FPN0DXN3OKA6vXSsC2gGo7S3St9d2vlh+BS86f4sfu0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Gr/dq5btwqQ/0p9rV6Xb3rJCWTR4mR/ba3gP42zGqIedjPFVcHk5W1gV8gq4tqy5a
	 y+ZJTudjDQeBuB/GfMIU5KaLmgWpudU0T6zB9DJbxJNB4vCoiLrMdqyBj/BR3dVCJ9
	 Y3/p/3Q4f75LKHlc49yXX8gblWYMTrxTQ2C3jXurgvLiWCxiuXODSEpUvW5K/V37zJ
	 iMRIvH28bRKuqSBCFM35rnxNUdQ9fIV1QjMWjp71UDWfJQeU2tS1uMAnENq/lrBFPS
	 IMSwYkrA8qAAZfQvQQ3IpSyRfBxWbIwsAxSOeCXLGyhWKQGD8dXXJ7bGDu1vVJaHC3
	 kArBOtIFYZBZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09A4380CEF9;
	Sat, 22 Aug 2026 23:58:43 +0000 (UTC)
Subject: Re: [PULL] unicode changes for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zeydsui9.fsf@mailhost.krisman.be>
References: <87zeydsui9.fsf@mailhost.krisman.be>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zeydsui9.fsf@mailhost.krisman.be>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-for-next-7.3
X-PR-Tracked-Commit-Id: a511442085c140da9cdbe60e3f0fab1c71480801
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e13629f4df7e7159d82b11e43149308978103ec9
Message-Id: <178744312241.1864468.12246910403111094353.pr-tracker-bot@kernel.org>
Date: Sat, 22 Aug 2026 23:58:42 +0000
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Aug 2026 17:41:34 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-for-next-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e13629f4df7e7159d82b11e43149308978103ec9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
