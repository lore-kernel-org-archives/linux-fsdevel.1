Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550253;
	b=DP6NsnZDR39SlbXpnJL2toO4E7TvABTmjbBGaPzxzAfcxiCVDM800W3K8PrX7tzEReMr
	 /4AsoOBVnE0XrO7UTccA02JoMuvlvXWxQeqmCFu6hpc6k1bS7NcON6pZDb1W27tI7IXLo
	 IcGgcA8v+p9cdRDCLys7v1w4HfACofUkio286Ymc8r4KZJb1/5tRVhH3pGbJsJiKbPQl2
	 NHBlPjvesFO/i5Xeohioai9QSilSsRNSjKIizW9riYby4JbFX2eXKDTgG75i26jrIPsEh
	 Ztd4WGQU8Us+MTu7iDRoC7FrU3t+8dEFPXLMYKR/4oEaaOC2UwI4pPd9Ly4uOfzvozw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550253;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=hzjPWGXMJHFTt0P2fpnRJcMLCKYVGA2SUAfE4b4LKj4=;
	b=4onfVOqeasEJfD+SAB3wwmHLMQZDgHFGfLJ4u3KzrvTZhVJ1IS4VtnyNlBLLHH9+YK0O
	 wjpHPUR7er2T1dtPdS+zEN7f+4cZTX/macrLT/JbhPY5RG7NMYDe8Sd74NADoO5XRGN+P
	 l0sIz6MsQdVHPtmp2+7+k2/rncljLLVs2t/DSVA2ndDHwFz0y2YcsKMR58lNCISGlSfgN
	 DTtlX/udFxZxAiAq/FGv6MFupKurjT8RU8a8YtnVUm23wyUm1HHq51Rf4T+KQFjF+8mh3
	 EFDAMA78WALRpJNKs97so8zedrSoHuK2+VXwfFHFQwC8SB/RwFmQGZDTw+IbBA6W60w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJWSuK9A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F42606A32C;
	Wed, 21 Oct 2026 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJWSuK9A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8030F1F000CB;
	Wed, 21 Oct 2026 02:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550252;
	bh=hzjPWGXMJHFTt0P2fpnRJcMLCKYVGA2SUAfE4b4LKj4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=gJWSuK9As7LyzzT1IvuosRgFPFXdJRm8j6LvRK7p1eQ15PRHmmBu4OTu4iul81h/E
	 vgj1EkM8KbJwW/f+p9ilFip0aAXXJ3mxEYnJPcQZ+Fyiu2ugyupxTVkvgLLV03+Faj
	 dIWWbQwp+EMgeq8/yboKQiZx9vGG+/fbW+mF5rry5MyQVLZNlsbmnZjTKu2w89MCb0
	 m7doezZ7w6EURHs/uClIAyaK7ZZyr+AZ2PA4PtX+gaEI8kJdTM5jjh90qjsDWi3p0w
	 2uiNBiC3iy+0a07Pokvm6yIchzruWvu4JxmlkQiBBNm84VyeoP7VlY6ebx4JZ72E/U
	 0grEoxOMU4peQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773223809A18;
	Wed, 21 Oct 2026 02:37:32 +0000 (UTC)
Subject: Re: [GIT PULL] hfs/hfsplus changes for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <db285527bb969bdd9388a84523979ddff36e86cd.camel@dubeyko.com>
References: <db285527bb969bdd9388a84523979ddff36e86cd.camel@dubeyko.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <db285527bb969bdd9388a84523979ddff36e86cd.camel@dubeyko.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v7.4-tag1
X-PR-Tracked-Commit-Id: f278d04be3acfd3a9eccf045b9eb180007cceccc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd7b15aeac80425faa7f0af55776be117db61548
Message-Id: <179255025104.339009.271357602412156760.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 02:37:31 +0000
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, vdubeyko@coreweave.com, bruno.produit@trailofbits.com, davyfelipe34@gmail.com
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 16 Oct 2026 16:24:11 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v7.4-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd7b15aeac80425faa7f0af55776be117db61548

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
