Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C530CD81;
	Wed, 29 Apr 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472403; cv=none; b=cX6witbM/RJ0u6Lvn0X2RfIxV0b8VVVwmaKxiFaSJhBr13EPt1sjPxj8Iy2l8BTb/TtaQOLPFaQ6qPX0EnyLEIYUgdLeWzAPgcQDH8KgdTnUGTDlCDrqtrLWyzR5oFEBSvuSu50m/gw6M3j5wud2z0e5JEpFyWMmWH/QNaSLoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472403; c=relaxed/simple;
	bh=gxCpwqQ5z6e9sCNxXJF3lQB3qgoU8diorYjoFyBfxeU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKQ++U+7GaJ9LGCTcWj4lIUcfO7gAZ+maufuQYYXyGNXkq+QlCp/DaqAK+iNv+YfObNds4rePQqzYXDt6LG2hjvGhhOdvz5maN6v3VQmj2J+gvYrthNndPodgjTn8A76bIGH340rVZtwIe1bAy38MF1CxXDkcCdYNUpb6nhWrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdmtRwzX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdmtRwzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C87C19425;
	Wed, 29 Apr 2026 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472403;
	bh=gxCpwqQ5z6e9sCNxXJF3lQB3qgoU8diorYjoFyBfxeU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hdmtRwzXZ4pvCrf60btI8YAToflfIRvL+CDs/+wGo2rC/t1ryy3BPmBIIdCkCzeMO
	 DU6BTe9dH5SX62HzGntsf7J8HmB+MZGqT0ohsr4lzM07VdwWX8U6m025l2/tBHLDVo
	 e9T01CXo/zOQ+4xrBo5iHteSU4EVe8A72GHZlT5aItB4Iula9xF+3M+JVmVwrtDGNp
	 VNuj8JuqvQY98k78+yAZdeWdrE/6H5QTfq0cbOt+BLn1PbpDdYURDzFz9UX6WKAxmh
	 dqIOK9fWEPFlaGUzqMzYjJtSvaQAaSzpOGZenKyuWb/G/vsutlzoE36rVEFSC0VX9Z
	 zOGWv4k3Oy4uA==
Date: Wed, 29 Apr 2026 07:20:02 -0700
Subject: [PATCHSET v8 6/6] libfuse: cache iomap mappings for even better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
In-Reply-To: <20260429141253.GQ7739@frogsfrogsfrogs>
References: <20260429141253.GQ7739@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
---
Commits in this patchset:
 * libfuse: enable iomap cache management for lowlevel fuse
 * libfuse: add upper-level iomap cache management
 * libfuse: allow constraining of iomap mapping cache size
 * libfuse: add upper-level iomap mapping cache constraint code
 * libfuse: enable iomap
 * example/iomap_ll: cache mappings for later
 * example/iomap_inline_ll: cache iomappings in the kernel
 * example/iomap_ow_ll: cache iomappings in the kernel
 * example/iomap_service_ll: cache iomappings in the kernel
---
 example/single_file.h      |    7 +++-
 include/fuse.h             |   31 ++++++++++++++++
 include/fuse_common.h      |   19 +++++++++-
 include/fuse_kernel.h      |   33 ++++++++++++++++-
 include/fuse_lowlevel.h    |   52 ++++++++++++++++++++++++++
 example/iomap_inline_ll.c  |   16 ++++++++
 example/iomap_ll.c         |   16 ++++++++
 example/iomap_ow_ll.c      |   17 +++++++++
 example/iomap_service_ll.c |   16 ++++++++
 example/single_file.c      |    7 ++++
 lib/fuse.c                 |   35 +++++++++++++++++-
 lib/fuse_lowlevel.c        |   88 ++++++++++++++++++++++++++++++++++++++++++--
 lib/fuse_versionscript     |    4 ++
 13 files changed, 332 insertions(+), 9 deletions(-)

