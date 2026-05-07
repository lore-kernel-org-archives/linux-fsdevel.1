Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8334F275;
	Thu,  7 May 2026 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192138; cv=none; b=kR2QjE1fVgUBSzAvZJN9jsZekOI0UR0MPJgNdnDycKv6RBbUEHx0Hn1kMbivbpxUWzXBAxhrI0UgiGYvPX621IU2+wXJB2W/hWVl9nYMAK2BReWnrEOHx+7yVpo8gw1suI7nM8fLsriSRlfXbBIATzVPWXey4bkMewMr9zxhBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192138; c=relaxed/simple;
	bh=prfIspbcNGkk8uRbdEyV4zYoStxvNR4/N23FNTVFrEA=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=pmU0y9eyT0xcMLlP/GrJuM+IiU3/vkARB1BodCJExOIbV97lupbLnffCC4gWXRlnO0yLRTym/GIrgMry5UQeLMenQnq9WhY9paKoEa+EwZRX6hok3hC3Hugq2b/WdluZcys0VUyeGdQNTi0umzGk7UyBEdn1vvqql8R17vixLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkR5X/H/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkR5X/H/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2792C2BCB2;
	Thu,  7 May 2026 22:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778192138;
	bh=prfIspbcNGkk8uRbdEyV4zYoStxvNR4/N23FNTVFrEA=;
	h=Date:Subject:From:To:Cc:From;
	b=bkR5X/H/CG0IGJkfbMjzAOSX5KkWTmVkd4B17gK/Lp102EHhmBftVZF5SI+qHcvhT
	 A05xjx49yjQ8vhCJf3SLNGSbt5ZkXvonGM/R0eD8TRPjTNujuxZVw9i+xfry7pIgHV
	 PLnyWtHUlidvdsyxKWULKMdBhYGwYh2Q05pNC3CF6CHndR1rCxE0sLMNhQj65GF2jS
	 hPFWzqUF0jKIqbpBUjXYRUXySTRAiB5Ld2h2IGFc8TIebIoEQBoICVePzHdAvZ65y6
	 fMOVXFZg7dlDqXKnFVczT+ICq5CipepKH25/JU3AFKC9ygO1wlBc5flIsl3RP3uvEG
	 UiH4iRQV7ctfw==
Date: Thu, 07 May 2026 15:15:37 -0700
Subject: [GIT PULL 2/2] libfuse: new mount service container fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <177819210392.3493306.2682111795524189776.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Bernd,

Please pull this branch with changes for libfuse.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 1760a7221342ada367b5102641e3ecc9f03f7805:

mount_util: fix mount_flags entries for MS_RDONLY (2026-05-07 15:12:21 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container-fixes_2026-05-07

for you to fetch changes up to 40dc96cf32cfd72bee7b2e23d2ccadd98795c9f0:

mount_service: use the mount_flags table instead of declaring our own (2026-05-07 15:12:21 -0700)

----------------------------------------------------------------
libfuse: new mount service container fixes [02/11]

This is a collection of bug fixes and cppcheck cleanups for the new fuse
service container code.

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (1):
mount_service: use the mount_flags table instead of declaring our own

util/mount_service.c | 51 +++++++++++++--------------------------------------
1 file changed, 13 insertions(+), 38 deletions(-)

