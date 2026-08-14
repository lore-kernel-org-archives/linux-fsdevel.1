Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3732E739E;
	Fri, 14 Aug 2026 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713141; cv=none; b=ABuqKcugcdeApfwEn5Sbdv1EHH6dunowkc1D90hMQOx1u6ma4tCoIC/Pd+wfF04PSei+vzrkeVhIyHpLR+U3/UP71Kqq9xRGo1jJV+f9/dgxqctx9QwOLZ3SwZYClHevodJtei1cXpXxxPhCtlS1gBF9LIa3LtB+hLLJIKpdHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713141; c=relaxed/simple;
	bh=fy1EkTALxveBUwn3+mXMZ9zJqXWHWTFaHv0zqMrM7ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTJ8Cpl3V3zvR73qXp/oEAyT9QTyJbZzw2eTrPDkhyoak5aZ6A8yq32AqRpK4yTa3ucb4vvf3MyTSvF63B3cdL6iij8RTS35iTF3MiuszELfRELoM8L7mNlNLeCZZVtnDUvN/c6AAJ6S7HsSk2mK7AwEbxtdmWQDxx/2UGeF4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmaLKVy7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmaLKVy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2751F000E9;
	Fri, 14 Aug 2026 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713139;
	bh=s4UG7Hb01EsyaUvitRx4UQai9ODMbOfvlH1SLJSXbUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mmaLKVy70ln3S2GWvrBuBlLYF4+MvQzrb6gMD5EEGfB0YnL8Raq5h6BwcVD+WwlO/
	 cM0yC4c3zlloLHnmV2YtBRlTlZaIPOf5q4ZbxyGadDpAYDuoLvaFctS615tlYkGqCI
	 /5nm9V+3pRqjWoK86YOSaG8IMih/21McF1ue10sNymS7e5jvF+rX6bvEHtp5s2gA3f
	 RwKgYJ+37vcmGTwMnxF4G7oy4yqxgrLPUBreKQwV+LCW6Rcz7Wgk2dpRDWK88G9FvO
	 8HEXJt+R5pLq2EkOZQlOH4cwz/9bBuX5skRS3x34ZZ3Jlu1ayorsP1/zOEORBDvNfL
	 JKMjVB1sZUCYA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 07/18 for v7.3] vfs freevxfs
Date: Fri, 14 Aug 2026 15:12:14 +0200
Message-ID: <20260814-vfs-7.3-rc1.freevxfs-3ea96320f471@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029; i=brauner@kernel.org; h=from:subject:message-id; bh=fy1EkTALxveBUwn3+mXMZ9zJqXWHWTFaHv0zqMrM7ek=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi+i7Hyyx4npTftRohvTNRy/49O7Pb4589YZRdmqHh KvBVg3GjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkk9zIyfFLWux5expbUzBQl EFRhenSq2jXJqXwnNnptdar0dPLTY2Q4sskkOOabROPRiBy5g/UFFmcO8BRKX+d61/TQRdvl41M +AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This removes the freevxfs driver. Providing compatibility with
various old-school Unix systems from the 1990s was fun 25 years ago.
Today it mostly serves as fodder for automated bug checkers. There has
been only one known user and contributor in the last 15 years.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.freevxfs

for you to fetch changes up to a3ed4fcd04b95347ad04cf4409b394bb7fbd0c02:

  freevxfs: remove the driver (2026-07-31 15:23:44 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.freevxfs

Please consider pulling these changes from the signed vfs-7.3-rc1.freevxfs tag.

Thanks!
Christian

----------------------------------------------------------------
Christoph Hellwig (1):
      freevxfs: remove the driver

 MAINTAINERS               |   6 -
 fs/Kconfig                |   1 -
 fs/Makefile               |   1 -
 fs/freevxfs/Kconfig       |  27 ----
 fs/freevxfs/Makefile      |   9 --
 fs/freevxfs/vxfs.h        | 257 ----------------------------------
 fs/freevxfs/vxfs_bmap.c   | 272 ------------------------------------
 fs/freevxfs/vxfs_dir.h    |  68 ---------
 fs/freevxfs/vxfs_extern.h |  49 -------
 fs/freevxfs/vxfs_fshead.c | 166 ----------------------
 fs/freevxfs/vxfs_fshead.h |  43 ------
 fs/freevxfs/vxfs_immed.c  |  53 -------
 fs/freevxfs/vxfs_inode.c  | 314 -----------------------------------------
 fs/freevxfs/vxfs_inode.h  | 169 ----------------------
 fs/freevxfs/vxfs_lookup.c | 273 ------------------------------------
 fs/freevxfs/vxfs_olt.c    | 105 --------------
 fs/freevxfs/vxfs_olt.h    | 120 ----------------
 fs/freevxfs/vxfs_subr.c   | 152 --------------------
 fs/freevxfs/vxfs_super.c  | 347 ----------------------------------------------
 19 files changed, 2432 deletions(-)
 delete mode 100644 fs/freevxfs/Kconfig
 delete mode 100644 fs/freevxfs/Makefile
 delete mode 100644 fs/freevxfs/vxfs.h
 delete mode 100644 fs/freevxfs/vxfs_bmap.c
 delete mode 100644 fs/freevxfs/vxfs_dir.h
 delete mode 100644 fs/freevxfs/vxfs_extern.h
 delete mode 100644 fs/freevxfs/vxfs_fshead.c
 delete mode 100644 fs/freevxfs/vxfs_fshead.h
 delete mode 100644 fs/freevxfs/vxfs_immed.c
 delete mode 100644 fs/freevxfs/vxfs_inode.c
 delete mode 100644 fs/freevxfs/vxfs_inode.h
 delete mode 100644 fs/freevxfs/vxfs_lookup.c
 delete mode 100644 fs/freevxfs/vxfs_olt.c
 delete mode 100644 fs/freevxfs/vxfs_olt.h
 delete mode 100644 fs/freevxfs/vxfs_subr.c
 delete mode 100644 fs/freevxfs/vxfs_super.c
