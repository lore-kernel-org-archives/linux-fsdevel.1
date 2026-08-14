Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DE46F4BA;
	Fri, 14 Aug 2026 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713114; cv=none; b=lLZGSslAOgntN/Mbc9XDZOhxs7tedkbASvyHoz3c0Yv3f/kKCKkqHQddvhM+R46dILssIOx/YWTvNcYpzgmqZcelwDnYiw+gOl+p6y1Ow4KL5RNGST97+Hj8M6BjKiy75IrduAasW1Uk/zQO4XPjuYpSpG/OxY4/5apNAdWDE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713114; c=relaxed/simple;
	bh=bMhYp5APkiRa4Tuarj+/lTXw474UWateFr+B9obdt58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJBvNcusQ4JQ+LSh7CelT4hRAsSWfMaS2hcXr5ldEewPNWQYEgXXJRlLTb6AONqU+MAAQ3OxAtJbC7LDWXOEBDbpYDgreKuIgCDnDwjklivmig7dCm6EBxgHIZD4Q8smhilpMsRZkEr5mKOPccarrJVb6Ww2Onr2IeUqOnLvYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbPIcneF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbPIcneF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ADE1F000E9;
	Fri, 14 Aug 2026 13:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713107;
	bh=+LnBbt/EQaOp50dQNhS0U2324eBkwG6d141mYAtyM7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbPIcneF8CaPE8vUBKTb+iDWoDHbxxFcX0GegP3o2VpFH3lW+A+O0xYilnzUgPKD5
	 RMrSLjU+UNrtLcyJ34F2s0BZDbCbXPT8GRfJjAGJO2/7BBHeJVr9lcOtjeZVMj6XiY
	 JZ2RTIKZW8J2x0shphwPuzaKkge+X+PWqaQvgMT8oFvfCDoHlU0upIvTH5tjG0SpDD
	 GaBPFTfXuBbhsdj/L5xbCM9m1orVaHr5ZvQbWhLew+p9cztJVzxScXQfOhJCdBJx2O
	 Xw2UCcMl1Tz23pTcTzTYLsvircXVx8Xir3SeldJqSG1+0FXA8FxbTzjdRXA7P2b90d
	 e4xwpgbfKpeyg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 04/18 for v7.3] vfs efs
Date: Fri, 14 Aug 2026 15:11:41 +0200
Message-ID: <20260814-vfs-7.3-rc1.efs-03f96f7082ab@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729; i=brauner@kernel.org; h=from:subject:message-id; bh=bMhYp5APkiRa4Tuarj+/lTXw474UWateFr+B9obdt58=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi/AZzU85ZX6mkMs7rTZNN+pH2OHeT4XLk/mENKYYR +1Q3SbSUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHKRYwMM6cuXC2mmbRiY8z9 Zu29bImbp4nxb5B41LM4dVpv51MlV0aGWW5HnHTt6nYXftNiK7v/S+nGURmTYAXGja0Jvg6eDiX MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This removes the EFS filesystem, the read-only on-disk format SGI used
on IRIX before XFS.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

[1]: https://lore.kernel.org/linux-next/akaE4dbtwZthgqJc@sirena.org.uk

     This conflicts with the net-next tree in MAINTAINERS between commit
     eb56577ae9a5a ("ehea: remove the ehea driver") from the net-next tree and
     commit 969076f31bf63 ("efs: Remove EFS") from this tree. Both commits
     delete adjacent MAINTAINERS entries, so the conflict resolves by removing
     both the EHEA and the EFS FILESYSTEM blocks.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.efs

for you to fetch changes up to bf2fbbca5d49d07917236604837145ee9e662c41:

  Merge patch "efs: Remove EFS" (2026-06-29 10:28:52 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.efs

Please consider pulling these changes from the signed vfs-7.3-rc1.efs tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch "efs: Remove EFS"

Matthew Wilcox (Oracle) (1):
      efs: Remove EFS

 MAINTAINERS                    |   5 -
 fs/Kconfig                     |   1 -
 fs/Makefile                    |   1 -
 fs/efs/Kconfig                 |  16 --
 fs/efs/Makefile                |   8 -
 fs/efs/dir.c                   | 105 ------------
 fs/efs/efs.h                   | 144 ----------------
 fs/efs/file.c                  |  42 -----
 fs/efs/inode.c                 | 315 -----------------------------------
 fs/efs/namei.c                 | 120 --------------
 fs/efs/super.c                 | 368 -----------------------------------------
 fs/efs/symlink.c               |  50 ------
 include/linux/efs_vh.h         |  54 ------
 include/uapi/linux/efs_fs_sb.h |  63 -------
 14 files changed, 1292 deletions(-)
 delete mode 100644 fs/efs/Kconfig
 delete mode 100644 fs/efs/Makefile
 delete mode 100644 fs/efs/dir.c
 delete mode 100644 fs/efs/efs.h
 delete mode 100644 fs/efs/file.c
 delete mode 100644 fs/efs/inode.c
 delete mode 100644 fs/efs/namei.c
 delete mode 100644 fs/efs/super.c
 delete mode 100644 fs/efs/symlink.c
 delete mode 100644 include/linux/efs_vh.h
 delete mode 100644 include/uapi/linux/efs_fs_sb.h
