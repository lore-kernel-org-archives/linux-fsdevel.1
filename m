Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480323;
	b=vsC+FuK7EkvZ0MPXgskU+CaWSJA5yEVqwPBc2Ii4HRaiPQC21ryIl9/rv384nxhU81y1
	 GqE0QOq4A25vFBvknO7StxWVpY5FEoHj5kkladS63L0AxueKQjMLhBi/AKdVADUTRb/Mf
	 n0F/Z+nYXPlTy/nwLx8VdSiTJqQlOUHdiemc0PDFYV/aoDiMyjxVaOcmE40d9QtyLrXGo
	 IMVQUVyIgP2u89xkdMCmmcRN/qZG7i1qaQtA1xan/C5ypTfSbTbMIjfOYoZhjQO60P0n+
	 m+bchrPijDPP9+AF1j2H4pQOARVY2hBHRSCsgGRb1xii0iBfQgWp81v9xiKY/jSG/BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480323;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=xY4K4OPdS+G1liekhnRfVimU/2Xv+yXYhZ7fGllUQEA=;
	b=tdLnjRzAwnVlgyOdZMn+Lt0kCt9xCucRNNxok+fE2ubztDnXSZOHwmWYn71jb2zne0XJ
	 XxmSx512FoTuJN1TB7Rc49LUbTccbgSJyAqbWjmrxqZVaOh+Y+QKNm5EBk/ozdiS8npTV
	 0Za1pp5MGPDWyocSX7pZklNWN0gtURXLxJV39L620RM3pgVpSXvIhQ6K4t5vo2K6df8Qb
	 Somy6pd28Phck9gvtiazKw4B1+jQZLu3Fadq+ZQliVMeoBylZP2uwMPqrVgO37Ciwz6YG
	 Yl3Yhq93zK19OOEf9tX+bPxjygLq6J1yo7sIeuqN8pxUQiej6XJeQZeyYd6tzDGLIKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+7wRpeO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31CE606A319;
	Tue, 20 Oct 2026 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+7wRpeO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C045A1F000C4;
	Tue, 20 Oct 2026 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480322;
	bh=xY4K4OPdS+G1liekhnRfVimU/2Xv+yXYhZ7fGllUQEA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=B+7wRpeOezgPW2xjsr8IIu6n1k7J6MKV5yGNgfH8/eUkR9Eqebo3DUIbClKRtTG1N
	 403ofyFsj4zbhzbsOeJ30YpvrFrd6xVm6xF59b/U+UVsFUVLL7iUqJ5hYUzD8sM1ZB
	 vWmZI9tUSO9Vv+FNKjiHdaWVgE7yGYGnJ0Z+ccS8OMtRQFK6kdUcPfESjt/HEkSYS3
	 E1ZVWesKlLGSvJRkitglfezBdKWXjuC+YkQzRi6AWrOqbqJ/MGdRQM6jS+BfBys0jd
	 YhCa+Pvmskew+Wsp6FaIC7xuhleHFIWJxM6dDQQNsOQx1+hYJgWbaxTR7Ay7CF9MEN
	 qsFuQrVXmoNyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B48063924FD0;
	Tue, 20 Oct 2026 07:12:02 +0000 (UTC)
Subject: Re: [GIT PULL 01/19 for v7.4] ipc misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261016-ipc-7.4-rc1.misc-e31c975da358@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner> <20261016-ipc-7.4-rc1.misc-e31c975da358@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261016-ipc-7.4-rc1.misc-e31c975da358@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/ipc-7.4-rc1.misc
X-PR-Tracked-Commit-Id: eb85469f0dd69ca145d63117450e14c31f67f698
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: def41b7bd4f1c9fc8eedba70ceb05d999ea7bb1a
Message-Id: <179248032151.3535438.3234182027679922021.pr-tracker-bot@kernel.org>
Date: Tue, 20 Oct 2026 07:12:01 +0000
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

The pull request you sent on Fri, 16 Oct 2026 12:14:16 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/ipc-7.4-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/def41b7bd4f1c9fc8eedba70ceb05d999ea7bb1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
