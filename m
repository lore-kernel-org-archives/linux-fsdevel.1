Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150F1C862F;
	Tue, 18 Aug 2026 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787016670; cv=none; b=qpyJmPocDLh9nLpJYYHZO+vYoLkeSo+cFHT2amjO7C5fLRq0BkYk3hcqElLodIOw+eItAilXa/b5wZi17zEbN5/aQQF5ZJ6MqcVsZNfj8g1NpHE6CeGOIEWIdOEUR9RzTzLunngeq1KbePX5MDjwu5aXfItQUTTgYQ4pIb7bDac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787016670; c=relaxed/simple;
	bh=vRwrK0/TYwyd1kvP3Fa9DDEdeY+P+TrgJgg5JATeOQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GUoiqqvbNIGq2ieFiimo19WZqp5rO3TdaZ2EjRQJT3ORxGxOvwNqpYr+TdGJiR7vMwW0OJ3v1RE/cFpdw+CB9qWcMSxEs1iBzeuur+t8+cp33KhN0Kqsp0AMdVVJFVqMWyTYcdn3KNGLeCr4mornQo0wFM767XLmqAvkxQlAtAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McobZKxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McobZKxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8351F000E9;
	Tue, 18 Aug 2026 01:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787016668;
	bh=ph17w4cWkIWGWD3g8OwG4uTR49r5JT8RTbG2SlTj63c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=McobZKxY7gcvwBM/0t7SsFMo4uTEtGv48bfnnVJqTGSBpaj9xgZQr4f5kbYEss9NR
	 g7iCmvrpPGVmQnn0NcdJX92TxcYwUmgYRBlVGOEZcN58fXm48d7eFzjgUNbwFpIBU3
	 i+jWtY7mj1j6/eEFWFZTxPJZVQ/qdUecLr3Xg+IxpLNLORPf6hrl7k9+2Lnmtb6aFH
	 0k6M+pkgCNrfF8MB/TS7tmtPIHd/Axgl7Jzu6QYsqS/SRBxRj0hQ6zdk2owC4enUx0
	 XmyiFy9r9PPYas+oaJ/3BopMxeu9eqAgqFGWHp1M4H8f31ibmWJLaDjPoHXO1evDwv
	 Zsfb/G+0a+zPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198043926279;
	Tue, 18 Aug 2026 01:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/4] net: af_unix: useful handling of LSM
 denials
 on SCM_RIGHTS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178701662063.1820167.14677074297106840300.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 01:30:20 +0000
References: <20260813162818.149248-1-jkoolstra@xs4all.nl>
In-Reply-To: <20260813162818.149248-1-jkoolstra@xs4all.nl>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, kuniyu@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Aug 2026 12:28:14 -0400 you wrote:
> Right now if some LSM denies an AF_UNIX socket peer to receive a
> SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> that point, and MSG_CTRUNC is set on return of recvmsg(2). This is
> highly problematic behaviour, because it leaves the receiver
> wondering what happened. As per man page MSG_CTRUNC is supposed to
> indicate that the control buffer was sized too short, but suddenly
> a permission error might result in the exact same flag being set.
> Moreover, the receiver has no chance to determine how many fds got
> originally sent and how many were suppressed.[1]
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/4] net: af_unix: enable custom setsockopt for all socket types
    https://git.kernel.org/netdev/net-next/c/de1c489b57c1
  - [net-next,v7,2/4] net: scm: move scm_detach_fds() from common path to scm_recv_unix()
    https://git.kernel.org/netdev/net-next/c/48b84acc5e18
  - [net-next,v7,3/4] net: af_unix: useful handling of LSM denials on SCM_RIGHTS
    https://git.kernel.org/netdev/net-next/c/fd8756fa1487
  - [net-next,v7,4/4] selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS
    https://git.kernel.org/netdev/net-next/c/5d513ce19de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


