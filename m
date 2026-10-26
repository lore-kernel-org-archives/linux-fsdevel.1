Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792980398;
	b=Sp8Xi6GZ0IbfDaKDc+2z0wDADrmg9XoZo+FK7yMKJPYu7LSHw3RXBehJudXY/S54dHzy
	 QRsXfo8Urp9iIN+ktg0y/gw1QbQSZKcgXENbIjA2Kp6B2QBfWslNTey4i5h85opjDBpwi
	 1iKfWxwFUGMKorRRYV6nknIsS0lBWYjAzXauRG4ekN/BA/qtLDwH16p9zB45r67BgH+RT
	 p3wYCTCylsq/OzaAtyz7Pp/JWrh+btkRBNbaaswd7UAQfSYtKJI4XhlA80YSK7dNObhvd
	 ZDgT2DQcEN2wffXRnqgmLMhj55IInHJwaSJ0ppSS/Ye1RaIaXFUZEWrZYZPJlu5MLSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980398;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=QY/BTF9qrLlMVpYUwqhXDUxIoDX0pBezsBfawx7R2zQ=;
	b=HmZracnDMsa3Yoa3+UHn71J6v4lT5AcqEdx6k7KUm3/QzHBXQXHcFDRWzjuIioVXC+l6
	 v43VBsJ2LluIYfMV0MP3llEFDsu2AMG1ssvCyX9L/xhtuykLFpUvgNs9TQmVvF8cJ+nDs
	 5qClALk1MOanhvNmMmXJq7oXSp7s/QQtxJmTBCUmMlvORdxLDACXMgO3bbTArG8WiGloJ
	 0nAgdFoGyG22P+ZwafS1KfgMiyWPIJ/T3m2rpClvuMryYl21T4r6TbWAakVkbIz7nYfHo
	 Cr+7hXCa/vm/Fi5QcO77jwlc3Hkb6+ECbetGGELM3RFT423D0mIx0Nr/xKarup2FHEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1UN4Glk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B45606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1UN4Glk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D381F01828;
	Mon, 26 Oct 2026 02:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792980397;
	bh=QY/BTF9qrLlMVpYUwqhXDUxIoDX0pBezsBfawx7R2zQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=o1UN4GlkeCpIja8rwwLi2CaD3CCIzN6yBu8LSYIjIlT5KsCfTfhGXHprGH91HOB2r
	 CCPJNJ5guSHMURP4H4inEVH8zYawBccu4MDhNpNcdFC6OSEovYb8ht38GVsad946C8
	 YbXGobwXCq5Y53QZ3QV2MfDKIMsSfVESb/uMPqVB6oo8fezZXyYwNMVSGHaZNF4hOQ
	 3vVAjEtYewTzzzGfQoHzmDFTd93lOwRzjI/kj1osZDVdgjMiE2idznDEdCN2kUNHA5
	 3ZpHnzuIaZW/q0s2GXeWbv1as42eF4lkxGVKYvSfaB+xUmSON6Rxn6nrh+GKe6T9rO
	 oJRjZX0/0hrGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AB50F39EA760;
	Mon, 26 Oct 2026 02:06:37 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs changes for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSSxA7POTOHWrC-6Y5W-OAx=TaMLaCWuuA+e_0Y0+Mo7SA@mail.gmail.com>
References: <CAOg9mSSxA7POTOHWrC-6Y5W-OAx=TaMLaCWuuA+e_0Y0+Mo7SA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSSxA7POTOHWrC-6Y5W-OAx=TaMLaCWuuA+e_0Y0+Mo7SA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-7.4-ofs1
X-PR-Tracked-Commit-Id: 2bc09cb0e9e44c7e622b956332ebfb9b638fd5f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9206d6c40b52fab9bd59e8a8f7dd2d9a68d71a21
Message-Id: <179298039658.2358720.7042102506858445870.pr-tracker-bot@kernel.org>
Date: Mon, 26 Oct 2026 02:06:36 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, devel@lists.orangefs.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Wed, 21 Oct 2026 14:41:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-7.4-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9206d6c40b52fab9bd59e8a8f7dd2d9a68d71a21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
