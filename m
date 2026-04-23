Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD42417DE;
	Thu, 23 Apr 2026 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984428; cv=none; b=LSz0S2XeCslNmbK0IhQr+w9H+Tio9KkrgHQAjkMPVpwyMLaOj6F0g5xAvSHYxuJat7beCymcgIKeDFx3nHinugls5TZb60TpM9XoUeO4Yb2cwl8uO5uDjTtXs6EcGJZy3YqUSlNIS14Nd4/2g7vvSwT87eTGt1GYC00flLeS4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984428; c=relaxed/simple;
	bh=OebvDkomgwIVdHUKIuMSIUKMTueUer+tpphQqCmkZ3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pu7XYyxwHUTQxBwR/IIGfr+3jqrfrgrIXTtn0Nn+3eOMHO1h3YX5sjZixUOMtj94JsGsACusAHVSJr/4d9FhfoW2xVxDzguEzze77U96Gx44LHNZZKKdVR9/k4AljB0BRDjDUEtjrr5tH4Un+gYhdIsOPAnjfes0QI8DTsr0wpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBnPw+c4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBnPw+c4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64954C2BCAF;
	Thu, 23 Apr 2026 22:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776984427;
	bh=OebvDkomgwIVdHUKIuMSIUKMTueUer+tpphQqCmkZ3o=;
	h=From:To:Cc:Subject:Date:From;
	b=RBnPw+c4Dwj2YTOdOmbPuKtRwwNTIyRzopGLztZ5w0FKgp3YFJsDMZHXBeFHVe8Ej
	 nLrqAZxvTMVxiHE5uff0HCqz1/N7/MgcIHuMk7I6wAGELQYHNBBnG13IOEG/YVj0Gy
	 FlrIK2QXj21UJN3p5GqgHE6EWb+r+Me89CLS0cpPZwd89/sMbHPkvNnEtzmJETWJRH
	 b65re1li7AKFbWpIkiKtKcfMZbfOaxkjAt0M4jPWClpNkZGnZu1J0kCiP7wymhupac
	 kuQdukDmNJkZlCGX4YmPhOeMzl+OMrSbhHe+DFS3pf/eJOLWnDweihWCKyRnDa95nN
	 G9CF816fu/zYw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.1] vfs fixes
Date: Fri, 24 Apr 2026 00:46:49 +0200
Message-ID: <20260424-vfs-7-1-rc1-fixes-500b3d993ba0@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027; i=brauner@kernel.org; h=from:subject:message-id; bh=OebvDkomgwIVdHUKIuMSIUKMTueUer+tpphQqCmkZ3o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+WpiYk/Y0e/USmW0FtbstX9h2eYgpzp2leY89fuOH0 1s9N2pZdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwky5+RYVbH8lW5F82aK/w4 nH78XP5E6fX9FkG1J3X6mY5eVu9eOzMyfLqZJNvsPv1MzfKKR7YlXzcvqXatmXdn5uHDx49mMC8 8xgoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

- eventpoll: fix ep_remove() UAF and follow-up cleanup

- fs: aio: set VMA_DONTCOPY_BIT in mmap to fix NULL-pointer-dereference error

- writeback: Fix use after free in inode_switch_wbs_work_fn()

- fuse: reject oversized dirents in page cache

- fs: aio: reject partial mremap to avoid Null-pointer-dereference error

- nstree: fix func. parameter kernel-doc warnings

- fs: Handle multiply claimed blocks more gracefully with mmb

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit d60bc140158342716e13ff0f8aa65642f43ba053:

  Merge tag 'pwrseq-updates-for-v7.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux (2026-04-13 20:28:22 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.fixes

for you to fetch changes up to ac8777cc36224b4705d2c6efb10c56135d479b21:

  Merge patch series "eventpoll: fix ep_remove() UAF and follow-up cleanup" (2026-04-24 00:37:04 +0200)

----------------------------------------------------------------
vfs-7.1-rc1.fixes

Please consider pulling these changes from the signed vfs-7.1-rc1.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (12):
      eventpoll: use hlist_is_singular_node() in __ep_remove()
      eventpoll: split __ep_remove()
      eventpoll: kill __ep_remove()
      eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
      eventpoll: rename ep_remove_safe() back to ep_remove()
      eventpoll: move epi_fget() up
      eventpoll: fix ep_remove struct eventpoll / struct file UAF
      eventpoll: move f_lock acquisition into ep_remove_file()
      eventpoll: refresh eventpoll_release() fast-path comment
      eventpoll: drop dead bool return from ep_remove_epi()
      eventpoll: drop vestigial epi->dying flag
      Merge patch series "eventpoll: fix ep_remove() UAF and follow-up cleanup"

Jan Kara (2):
      writeback: Fix use after free in inode_switch_wbs_work_fn()
      fs: Handle multiply claimed blocks more gracefully with mmb

Randy Dunlap (1):
      nstree: fix func. parameter kernel-doc warnings

Samuel Page (1):
      fuse: reject oversized dirents in page cache

Zizhi Wo (2):
      fs: aio: set VMA_DONTCOPY_BIT in mmap to fix NULL-pointer-dereference error
      fs: aio: reject partial mremap to avoid Null-pointer-dereference error

 fs/aio.c                  |   5 +-
 fs/buffer.c               |   9 ++-
 fs/eventpoll.c            | 158 +++++++++++++++++++++++-----------------------
 fs/fs-writeback.c         |  36 ++++++-----
 fs/fuse/readdir.c         |   4 ++
 include/linux/eventpoll.h |  16 +++--
 include/linux/nstree.h    |   6 +-
 7 files changed, 125 insertions(+), 109 deletions(-)
