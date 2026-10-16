Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6427144B;
	Fri, 16 Oct 2026 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145780; cv=none; b=VBWLSlWXLY81aToqpLQYmHCV6Gd/ARXasNCpT8/510g3SGyihv6q6IXxQ0XOa8bCZWE1CwsF+yfv1G+kdXR3SYJZVj/lpKi0ehsC05KixJ+gKCdtfHjwFE/CkuAWH288KEPMmYSiACo01BFE/sRZbtlvM94rT8WO4t1VOZgV3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145780; c=relaxed/simple;
	bh=t29Z3cm4CE7VYXiwvVuhzjFZdSMn0RKjNhJI5lWETBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOxCBV9jWG3U3uKWBBAa1WANOPAfm074OC7w2b1Z3qNjaL4Mn2sZBTPxsnCoP1jWh0OQYvLmQvXvHwNizWhKhEBWPhBZhF3TcORAVuON8VzlUT6EYMAuD6XPna+6272MiS50AF4/HTzlLY4D7T9lw96KNyUd3vQqxtcdFKrtEZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glkp9Qhl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glkp9Qhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250C41F000C4;
	Fri, 16 Oct 2026 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145779;
	bh=pzyhVOVUnINL+9JvPO4azhX2+slP+CF67hs+dpaZ1Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=glkp9Qhlt9cK3pfQEx1kagPr+jMOJfb/TNnbOL5c73PROlBO144OWeh+vlIV2Gz1W
	 MiMIgsl2y19ni0xGWUjOMZN1WhqddMge9m7LrPC9/TQkmgR7TBZPnHX3YuOMZrO+zY
	 sb9ddrxpZBBxTDCH98/aYgKPbgFopGjnZUAKsTvRKbJt8zD8i8B0oVZtQtpm30GLBB
	 J2Hj8piKDJWTxgCjZK2mwDx68+xsYdon8NbcJBxf5LEpBJpUsSYmXHJ6nOeZ6QbYzw
	 old2ZGiuO2pDqIYjMT5n2PnmrOrFTHIbyaPeZ4OveINEGaMl/jzASADnJLI4jKYZ23
	 1mTyP4uFYDXCw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 04/19 for v7.4] vfs bfs
Date: Fri, 16 Oct 2026 12:16:04 +0200
Message-ID: <20261016-vfs-7.4-rc1.bfs-c543fd325191@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2871; i=brauner@kernel.org; h=from:subject:message-id; bh=t29Z3cm4CE7VYXiwvVuhzjFZdSMn0RKjNhJI5lWETBE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/JleHeu8++6frrIzfu/US/wZi5Q838rMffHH3/Pd0 mMqITvSOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayIoDhf7DP34O64kd5Jlv0 X+HO3ZZhn7Onfd+Ru1J/lDyOfrLLO8XIMLtpunjsP6ObK65I+NjzuEjaWPy0qCvc+qoirFX+IZs fKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This removes bfs, the filesystem UnixWare uses for its boot partition.
It only supports contiguous files and has no subdirectories. The only
data on such a partition are kernels and bootloader settings so there
is no reason to access it from Linux anymore. The uapi header stays.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.bfs

for you to fetch changes up to e36781a626b2708d42a188f6274f1c7897251f1f:

  bfs: remove the filesystem (2026-09-04 12:43:07 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.bfs

Please consider pulling these changes from the signed vfs-7.4-rc1.bfs tag.

Thanks!
Christian

----------------------------------------------------------------
Ethan Nelson-Moore (1):
      bfs: remove the filesystem

 CREDITS                                            |   2 +-
 Documentation/filesystems/befs.rst                 |   4 +-
 Documentation/filesystems/bfs.rst                  |  60 ---
 Documentation/filesystems/index.rst                |   1 -
 MAINTAINERS                                        |   7 -
 arch/mips/configs/malta_defconfig                  |   1 -
 arch/mips/configs/malta_kvm_defconfig              |   1 -
 arch/mips/configs/maltaup_xpa_defconfig            |   1 -
 arch/mips/configs/rm200_defconfig                  |   1 -
 arch/powerpc/configs/fsl-emb-nonhw.config          |   1 -
 arch/powerpc/configs/ppc6xx_defconfig              |   1 -
 fs/Kconfig                                         |   1 -
 fs/Makefile                                        |   1 -
 fs/bfs/Kconfig                                     |  21 -
 fs/bfs/Makefile                                    |   8 -
 fs/bfs/bfs.h                                       |  69 ---
 fs/bfs/dir.c                                       | 356 --------------
 fs/bfs/file.c                                      | 203 --------
 fs/bfs/inode.c                                     | 538 ---------------------
 .../filesystems/statmount/statmount_test.c         |   2 +-
 20 files changed, 4 insertions(+), 1275 deletions(-)
 delete mode 100644 Documentation/filesystems/bfs.rst
 delete mode 100644 fs/bfs/Kconfig
 delete mode 100644 fs/bfs/Makefile
 delete mode 100644 fs/bfs/bfs.h
 delete mode 100644 fs/bfs/dir.c
 delete mode 100644 fs/bfs/file.c
 delete mode 100644 fs/bfs/inode.c
