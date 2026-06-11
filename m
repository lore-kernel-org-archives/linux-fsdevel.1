Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138301E7C2E;
	Thu, 11 Jun 2026 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140467; cv=none; b=f1e81nttNy69zd90kmFKLnIb1rT5JdCqOQ/a+xDcNxXXXcY4lFQjiwJcu2d+dNyD1/NnOUUgXxHGQ7STwu9T6uPbZ9pP54VQG8O+o7humU+5ZWe8wSJSyFHBrwCj82b/Zf5gmVNm2wWIpGq5G6BF9yd5lxh7qsG8qFC2Z0su1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140467; c=relaxed/simple;
	bh=urOiuaFgCu6/Er7X3kIMlyxTXAOpmbSpbdnK1j6ct08=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=oQkH2ln5rkJDkISNguSEhOzvVdS+8ARoFQptMnozIaS3jK44gbA6Ltm2NykZNvbXSC9UjmkkRtE+fl1gnmXLrgzAsE2wRG6UY1fXKWqUuiduIj4ziCB+GqAT3eYBU2Vf3hONSkXEY/JCGWIcwXh1Ib68ni020ixeJWGujUfC+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWOvo7ja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWOvo7ja"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B0DE51F00893;
	Thu, 11 Jun 2026 01:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781140465;
	bh=IssW9icXz9D3MCGS1aP8vpQrMlf3Dv5LwSatxRQxZeo=;
	h=Date:Subject:From:To:Cc;
	b=IWOvo7jaHhDvuX2+2LQBET0KAAx31+7jRREbPcAchXOxK/ncn2a3e2C+ni+bQfb7C
	 ptxjwuQF1LCYElJ/UZtAtmeiAgvSl4Vbhw4lMBV9G3JRkysmYAGLucDpqmYeH2Lhlt
	 E3mnhOjHYwk9ERe23fEbaWy3zp//48vjblsWs6qAlHvIQqi/Rtw2byTvRqLvBlEJMf
	 nH6GTbMivxuKOH98Td5RCciazA8oyMPivY/zNAM71rY4cw21ClOpyfFrCEJxvwDARG
	 Jzci6IKmX41cZjLgplYozx4c3In0wf1/oTgCvr8XGvNubQSfE0YHeIxCj0PwVh9vUF
	 mbi31vpfxDDQg==
Date: Wed, 10 Jun 2026 18:14:25 -0700
Subject: [GIT PULL] libfuse: more random fixes for fuse service containers
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178114032924.140224.9298472352650513008.stg-ugh@frogsfrogsfrogs>
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

The following changes since commit 5e3f016beff43cc0dfd3649f75cb6d0d19748f49:

fusermount: Reject invalid negative mount_max in fuse.conf (2026-06-10 11:02:18 +0200)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-random-fixes_2026-06-10

for you to fetch changes up to 9fbe88f167fbd039bd637d65ad7034c42e506347:

libfuse: remove unmount command from the service api (2026-06-10 18:11:54 -0700)

----------------------------------------------------------------
libfuse: more random fixes for fuse service containers [v3 1/2]

Here are some miscellaneous fixes for libfuse.

v3: correct complaints from maintainer, remove umount command
v2: add a few more patches

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (7):
fsmount: don't truncate ms_flags in set_fsconfig_ms_flags
mount_service: don't pass the chopped buffer to apply_fsconfig_mount_opts
mount_service: call the new fsmount ms_flags helpers in the right order
mountservice: improve checking of protocol version
mountservice: don't print bdev preparation error when quiet mode is enabled
mountservice: advertise fuseblk support
libfuse: remove unmount command from the service api

include/fuse_service.h      | 16 ++++----
include/fuse_service_priv.h |  9 ++---
lib/fuse_service.c          | 86 ++++++++++++++---------------------------
lib/fuse_service_stub.c     | 10 ++---
lib/fuse_versionscript      |  2 +-
lib/mount_fsmount.c         |  5 ++-
util/mount_service.c        | 93 ++++++++++-----------------------------------
7 files changed, 71 insertions(+), 150 deletions(-)

