Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDC43E275F
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334050; cv=none; b=Hl+Pu7PIfGhlnHkvt6XeAzWHeR4RLuVNmjCxUysUcS/yerb6KGb66W8DMlR1O3FjX4Gbie5CcpRxSjFBiqSccTwtkKEQI0m/EFFYjfna3bpcO8DIJIZXEXlKrxdn64/qELGQL+kaf4d45VE1m3HopXsx+AXdYevF0hb6gytyMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334050; c=relaxed/simple;
	bh=LN/N15NK0Jl4Kajwxml2YoAAFUAlsYkdOTqvHWp1Ljs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZDPPvA65bu9+2wE98qQiUj71ZUS7vEsULUWJ/x6IcIS/ozpNh9V2uu44CyPk55yPQWcSG0G+cH3LvYBlRaLhxXJSvMCktGh2mipUuE3N8Xob5u39mq39UUv/oYL9uJgAP1+HH3ODEY1tnPteQmma1LAwPfu49E4JRL9+egiTHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp4EmHkK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp4EmHkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26729C2BCB5;
	Mon, 27 Apr 2026 23:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334050;
	bh=LN/N15NK0Jl4Kajwxml2YoAAFUAlsYkdOTqvHWp1Ljs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gp4EmHkKL8mK8XleV99Zwjfn+7fQ5UFRH65qI0osITI7SXZ72HUlWh2SX4N+C5Y1o
	 +l4ZBAt1opK/kquxCP1fG40YxaX1TT403iZ/mXLtGMe/uy3/kheEUX2s7e/enD082d
	 yaEEdJPqB1T7gFOMZUO9HG5ZT3opQZiRWFAEAL++37clZr+mQ7ooCNj3Z9a+exK5fe
	 83TLb4JU17C7yaqEQ/ZT2LMlD/9tyWIpW6wLv3Bbsc+wx3yTx+UkjLZVjpeekVD93B
	 OYfC8NfdmK+P1mzWF3WF/twFM4IiPAP+8QJMGCb5DHON+G8QRDgUppu0zmg270/VNp
	 MlDqYOeVlmVkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D8B392FFCA;
	Mon, 27 Apr 2026 23:53:28 +0000 (UTC)
Subject: Re: [GIT PULL] isofs and udf fixes for 7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <wh5wtvlsfd62xo3dbar5wgp3wz25gzqq6hruqpotis6xt2bg6o@o7kjkqne5uco>
References: <wh5wtvlsfd62xo3dbar5wgp3wz25gzqq6hruqpotis6xt2bg6o@o7kjkqne5uco>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <wh5wtvlsfd62xo3dbar5wgp3wz25gzqq6hruqpotis6xt2bg6o@o7kjkqne5uco>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.1-rc2
X-PR-Tracked-Commit-Id: 13917f71a95a6ee6132ecb9a544cd5bc7197c68d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1a671092d29455a890af272f0702925adafdf59
Message-Id: <177733400723.159864.5190087185297424931.pr-tracker-bot@kernel.org>
Date: Mon, 27 Apr 2026 23:53:27 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 27 Apr 2026 17:56:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v7.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1a671092d29455a890af272f0702925adafdf59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
