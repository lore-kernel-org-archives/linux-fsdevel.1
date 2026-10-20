Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480345;
	b=Br0AsjoOH3I227PtQRMsjqXxea89avmuzBepVYr7aIdLa0pKjJzyAniAIRhsIl8AfdDr
	 JJWle1Khw8yg5m64BJTn1M5yxobsDv7HxgkoEqlI/CXBoKBtZujYq+UEjTL8Aq901Py+x
	 FDI55W/p3U1c2F6qipEuLDh3fsPGzt9+Q8UVzQeUsZ0RHaWEauCD/7VK/1RHXWszdI3o9
	 tdFfXtYAkWRYgYUb17Yz+3u/6PNxBe5Tn/SmlZmGZodhUHfAROOzn5ncZq24umE7NS+XD
	 EWH+ZUSzgGZlep6cfp33I2YN2ySiOFHh8aDR+mzopiYmQE6bOer5FmEIIP/iblE1gFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480345;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=Z/aucTtoVN+7MHA4KJEXSLxCHVys/vzuEgUxxoFP29Q=;
	b=c4R34Qp3IK9GUVviM42yA5kH823lrBnpymUU6LMo9/9Nurl+kh3q1WpeTglkQ6QD25WQ
	 VVock2daEd0we96Ttu0XO5dFSraB1F/XWPMcAQYH4MMSFzoJGbcyHTeRMmHmC3pM7/srm
	 lgTgvPdEzC7sb9aAsdaAMu+u/otH1YaHB5UFrxi/GLygmLqswbt2Vrnn4Sow8aI5QIATh
	 RKqS/hIXyLT3LYkl0aDGIW9rbsh4ua3TXt9QvJobZy/HyNxWerCFtkPdq1u/TBPtjsGtO
	 hqPQ4LCvXzDLGMMKneK0LhU3p4zKbJveb2+Yj8peizOGzzr32w7ahyGXhA4pzwTtu8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Or8yZU9Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD127606A336;
	Tue, 20 Oct 2026 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Or8yZU9Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8248E1F000C7;
	Tue, 20 Oct 2026 07:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480344;
	bh=Z/aucTtoVN+7MHA4KJEXSLxCHVys/vzuEgUxxoFP29Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Or8yZU9ZvN/01+ep+KRv/WlyAbTh6bzjjzAJyCS/6q7w2QFPyRt8MMsztkr7BEWyK
	 o+FdjjBbIOV0VBQP3UnX4GT2paRXX9NOpMo2sRGrGzLo297oLmc/hgXl+aPm2awBjl
	 SPPkicy9OBPcLeh3RSD8vqVzNLLKhvHiBpjQ212/P8G07xsturQryCuxPyO05SypOd
	 hNF56X370q26AH9+zNNJIaYndISfBevDd3XRnsuV8noQwtGQirwwCdnllzGuohywB4
	 7QSwUoBUkA+RPm787XEQmk45oPnnCpadTBveTkspkg16hp2eiCiFy+bLhBJkyvbRyB
	 YP6yHHgyynjPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7750C3924FD0;
	Tue, 20 Oct 2026 07:12:24 +0000 (UTC)
Subject: Re: [GIT PULL 14/19 for v7.4] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-vfs-7.4-rc1.misc-4e00f3bd0c83@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-vfs-7.4-rc1.misc-4e00f3bd0c83@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-vfs-7.4-rc1.misc-4e00f3bd0c83@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.misc
X-PR-Tracked-Commit-Id: 9ba6627ef6b12debd1c54443939718db63234274
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ed37e9d5c05bf3dc74146572d89e7391091e1a4
Message-Id: <179248034300.3535438.18139380303960232172.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:23 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:23:48 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ed37e9d5c05bf3dc74146572d89e7391091e1a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
