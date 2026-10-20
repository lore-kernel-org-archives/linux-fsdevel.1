Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480354;
	b=u8lM/iiqkPK1rMYpPOxCDpoIsTnaHACYXdHuLPBUC/oXU2DO5o4Z2m94dTgsjwkjmnAa
	 pG/s2WRxYsv56QDx4EiFVrAwFw63LWgODHZsghwrIepBp8cqagVfS+k9WAjL97o/06SGs
	 b4S9cx2i4AAd2L/PSU+BaK5/455SaCugozK67W6Er/SFpqTF2U3HXUTNZQjb3uLcH/nCE
	 VOCpnoMhGQErUpRTiBiF8MV/HryOSlaUkKTy/954XczeiNL86ijHa7YIr5lqcumCuunT3
	 lWXIindDdjOtCucNBMdr1qN8vWmQS7+SRn+uH1GQANWPHGMy4pW9EupRcuIOmQnynqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480354;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=5ffd7mI0Tk28Pk+HchgKnzkBNdKRDttlOluMvCzgkGs=;
	b=SZTU/O77AjB79N7MZPq2kkXlwAS7inKC5ObFOsvSYgtnJwnfw/l5vlsMYAq7lQaBjzIm
	 wg5ajJMv0MU/oYoADM/ecFjGhlCcnbpgPF+eqPha1qhtnahIYiNm2J5LMn4gKYwRPxUoL
	 6zEyovu6pjp4BQTVFGs0jIAhfDFu8MhtV2lcZ4BMujthWksaWDZE+F7Sm1RadBKZKs0nm
	 NptzOBbw4ko/9nNeBowApmjf+1LKM6e+c4ai36yw+R9FDc/Yf5U74XPVJ7+ZSTR9KcFSj
	 HchxCcs7gj2ie/32waIO6khU7BpceCzuiFm3lMpu2EVw9S4yujV65ceZJsEtCoUUllQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYLXQmXO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F5606A32F;
	Tue, 20 Oct 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYLXQmXO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DDC1F000D1;
	Tue, 20 Oct 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480353;
	bh=5ffd7mI0Tk28Pk+HchgKnzkBNdKRDttlOluMvCzgkGs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bYLXQmXO7wVFC0MyDeJHzHC6rfRQ12CxoZkaJeEXkrV2xknaOsduIFnGA7XbfcFDB
	 O3an3JpZ+GIVuBEPK31pG+h4IopSWNvraTNYBTa5sZ8JP7sc4dEw3yCE4nobELjiCl
	 +U+nuc8hyPWCqWiwNOQw1D2Qw7rrMFmHk+1LmRSkCwnsdhHiBH/My3DsXyzXn9ZFdB
	 xXzzQQzAh0KjOzAp0NrOV/1Tp8hyYO4i6HQQA4KziB3hRMcK8nnhO3nsXtKlktFNOy
	 afVFLtvA3n8P2Okz6iJhcKYwww/ElqsxtTMHVxAecnuQUpQurYJGvoT1K8VB3657xl
	 GJjtu7fUEOCxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A1F23924FD0;
	Tue, 20 Oct 2026 07:12:33 +0000 (UTC)
Subject: Re: [GIT PULL 19/19 for v7.4] vfs sync_close
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.sync_close-2e203cb16139@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.sync_close-2e203cb16139@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.sync_close-2e203cb16139@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.sync_close
X-PR-Tracked-Commit-Id: 02de8d0c3512108620cae8db0c71fe227f1da5bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f47d223627f80cb7a1eb14c585fe6cb35de5e984
Message-Id: <179248035174.3535438.17070300146487247056.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:31 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 16 Oct 2026 12:27:04 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.sync_close

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f47d223627f80cb7a1eb14c585fe6cb35de5e984

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
