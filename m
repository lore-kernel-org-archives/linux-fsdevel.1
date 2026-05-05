Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510213B38BD;
	Tue,  5 May 2026 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958803; cv=none; b=fxm+Lfb/aspY0P+t15R1aJwH9xFAr6IEnPRXOFRhOBeLrDftgTkB89sF+Q3bwedv/73dRpPR+AfuSwMskuIfKN5+ZUgjzKXjiAlsEu9AWHWkx6SXxMKwQBQDJ6RQ3czvNjoqzp2He75snaJxAn516LVuhdIiViYZlMjJLC946pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958803; c=relaxed/simple;
	bh=yVldk1cuJeUgvA0ntlXvq17KI6eF4LEXJ8WVo0B0S80=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:In-Reply-To:
	 References:Content-Type; b=GHJBrZvwtnCGozhSK9z97F0VEyPOQPL6xjLYvHOyRlkt9OExPb7vSPQwFF1Z5T+KJvPtvjsRxRT+capS1GoW6udfiHAZAsYXMexJJB2ClCebnbXL/qfFoMKDPOngywJ2t3fL6s3QLyOB4G9yFVbJpHLy1L4ZDrI+u8NrrG0546w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJQCnE4g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJQCnE4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB2CC2BCB4;
	Tue,  5 May 2026 05:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958803;
	bh=yVldk1cuJeUgvA0ntlXvq17KI6eF4LEXJ8WVo0B0S80=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QJQCnE4gaLo+gglcB2xcohJZAlMJ2QuLBOG5reGJ8el7g42b2cklwneML1XZ1t7tT
	 rQR0ALj5TjVsfSF9KtmLqTXhe5sePmvJRCeoQE7LsiVUXn00KEgbw5t3AU7FawJfrh
	 ZWus5nph3Bs/i7iYFthFy/dVDJ8lpAmPmrdAPGIqAL5CwoUJwlYpxUG2X+Bcq/U1Vo
	 oItq2fcLYDrh+8vj+bEcuuub4lGCnMIFd7jxy6cM2t4W78dSm6ZtWeXzZrS8br1oiD
	 FeBazwhdwKcl4NItt7kiG02+FDWPZ0De1aByuA7lM9TGtrbekhA7uqntRg5uFM3HKv
	 KasSD/KQJlo+Q==
Date: Mon, 04 May 2026 22:26:42 -0700
Subject: [GIT PULL 1/2] libfuse: new mount API and SYNC_INIT fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <177795854294.1134010.18375895979263011642.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260505052133.GR7765@frogsfrogsfrogs>
References: <20260505052133.GR7765@frogsfrogsfrogs>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Bernd,

Please pull this branch with changes for libfuse.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit d454f681fdd0e31217261d1656071a3d5c87d61e:

Show a feature config summary the end of meson setup --reconfigure (2026-05-04 17:29:41 +0200)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-mount-api-fixes_2026-05-04

for you to fetch changes up to ce2feba31ef7ab81807dcba3ae8f64d314ffd14a:

libfuse: always send the subtype to the kernel when using fsconfig() (2026-05-04 16:22:43 -0700)

----------------------------------------------------------------
libfuse: new mount API and SYNC_INIT fixes [01/10]

Here's a collection of bug fixes and cppcheck cleanups for the new mount
API code and the new SYNC_INIT code that landed in main recently.

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (2):
libfuse: don't use SYNC_INIT unless asked for
libfuse: always send the subtype to the kernel when using fsconfig()

lib/fuse_lowlevel.c  |  6 +++---
lib/mount_fsmount.c  | 13 +++++++++++++
util/mount_service.c |  3 ++-
3 files changed, 18 insertions(+), 4 deletions(-)

