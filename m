Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E322066DE;
	Wed,  3 Jun 2026 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445790; cv=none; b=My5OBHgZbQzozkYy7/btc0sYyQsQ5OaJpIPnj+rpYhXw8Rc3YtV19dY16xVSgpLJfOGonzURWiyfy+vVwWWYL6SXhC6mQYk4ZKiG4hE+WKDlR4Bmz9If6mCk2o8M3c3HAS325D5Z7DtHVhw0B6zHYm0ATkrWL/JBoMRBZo5FwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445790; c=relaxed/simple;
	bh=OEz1I3YVlrxq01G56GzSaeSYaFFzdaXgayTnYP4HqeY=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=lSZxCxX0tlB27R8N+SVuTiTlq/jmrdoz07Cv1xpC9a4onh8Yhg41B0PwLVnC4JMKpNWD5vsS3A3viz5dAvY2bvS9sDPQ0+vzVjD6fbb/hbu4BZqXNaoItpQPnzb5DiCyuw0asKxzgr6q9ejshFu7uSQw1HaOT7CPZ+xYzd84buY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FshNoR9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FshNoR9o"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6DCBC1F00893;
	Wed,  3 Jun 2026 00:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780445789;
	bh=oEZ4ARSIvM5zID4fnk3YWCdFM2aDrOGLB3HIUxBF2uA=;
	h=Date:Subject:From:To:Cc;
	b=FshNoR9ocFtgnJYOypD80A0TXUA/loFp6rvEi+P9bYq1OzXM5Q3BknZoYJHBjlR+N
	 iE8etMCNQ5YCE6YGZysdvde8QvA3drX7Y9ly6rH4ASzNMMLwifW/PaiQiqauKeCyRG
	 aQsf8bqldyk6KJMuxbI+BZS9d2qC0F9vrjexK+0n/fQTxen4vrxK0LdvgV7lv3A4fP
	 vBifDhfh13n2Dmn2/TBG7DoIb+gNk1FAq7Xywge0DvlKtIsKHpVR+uWvj/2vMJaH/s
	 YUUBTX0WEUuQDn7d7wcVHxV7hFocg6M3RUW4WkSuWqVRd4MmXtXYJcFMbvFH/U8tUC
	 ETDITmaLHN2uA==
Date: Tue, 02 Jun 2026 17:16:29 -0700
Subject: [GIT PULL] libfuse: more random fixes for fuse service containers
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178044568141.1436249.17252850386629267509.stg-ugh@frogsfrogsfrogs>
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

The following changes since commit b71dd2629ff24405ad95814ba24773a24436a49e:

Merge pull request #1444 from bsbernd/fuse-service-container (2026-05-26 19:56:02 +0200)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-random-fixes_2026-06-02

for you to fetch changes up to 43adcff7f923d7e34f9fe158a2e523481edbf3d5:

mountservice: advertise fuseblk support (2026-06-02 17:14:27 -0700)

----------------------------------------------------------------
libfuse: more random fixes for fuse service containers [v2 1/2]

Here are some miscellaneous fixes for libfuse.

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (6):
fsmount: don't truncate ms_flags in set_fsconfig_ms_flags
mount_service: don't pass the chopped buffer to apply_fsconfig_mount_opts
mount_service: call the new fsmount ms_flags helpers in the right order
mountservice: improve checking of protocol version
mountservice: don't print bdev preparation error when quiet mode is enabled
mountservice: advertise fuseblk support

include/fuse_service.h      |  8 ++++++++
include/fuse_service_priv.h |  4 +++-
lib/fuse_service.c          | 35 +++++++++++++++++++++++++++++------
lib/fuse_versionscript      |  1 +
lib/mount_fsmount.c         |  5 ++++-
util/mount_service.c        | 33 ++++++++++++++++++++-------------
6 files changed, 65 insertions(+), 21 deletions(-)

