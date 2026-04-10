Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B03D9DB3;
	Fri, 10 Apr 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834179; cv=none; b=JcqLr74xW/355xl0Td+ZKXuXpKhON1geqW7TMMGhOoGsdtlZevSbYL0hDvH57vgJ2BsIekswDbeMAFEOW0dBCMS+NAXbMuW8AvQ07qdoUUU56Bknu1Jq54C09nRe7Nv1MwUWUytCrPZ560TEZlL8VcnKAU1korEXNmfYwXkivOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834179; c=relaxed/simple;
	bh=dofeNp7/MI81AYNTr/qCW+1idtxim6t6jECcKFJ+rcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uITlJH6+UDJt3wlq34GQKVsBTMvf15NhXwIIyVv7CM5jzpZrK0DgcYPLjGDpdyXOzGQ/8QnTOjLul+YhelQFtvVTrlWswCeWb3zQDfdHmOnSUWBq/CKnKl372VLZtdQHPf9QN2ABVRI64/0FR77/6VvyTJxamtw+3WEWy2XKk50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daCmXXbB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daCmXXbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A95CC19421;
	Fri, 10 Apr 2026 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834178;
	bh=dofeNp7/MI81AYNTr/qCW+1idtxim6t6jECcKFJ+rcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daCmXXbBuZTUEonzbFi7ZNrKaOIy1KnpfDbhipEZ8Hf2MX53UB4tSfD7gHTIkWrPq
	 RH5ex8wGFZVGeHckqcLNC1SmakjUGcy5eSRkfeQweqYy0P+qsjwHV8d+RYjDDhtW6s
	 jahqwtzxMlS3WIB7f+b/tql0kSAN2Vk0Gs8iBpuPilIwMYmzhn8zHzHcCJJHc6zB6A
	 NcJr0H2lHuwp0TsTk0XMSKL17dnLUVUn34UA5WqleGfDQ+hagQAVyoT96tEZ70hGoa
	 OSFl8vYXPuUf1vjQ2B9XLA7mObqjBpj+RRfZ16EP1JIKtpyROBUoWOqeRikZrIBAjm
	 BIys76Pu2crEQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 01/12 for v7.1] vfs writeback
Date: Fri, 10 Apr 2026 17:16:11 +0200
Message-ID: <20260410-vfs-writeback-v71-7f2e4fd28a68@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=brauner@kernel.org; h=from:subject:message-id; bh=dofeNp7/MI81AYNTr/qCW+1idtxim6t6jECcKFJ+rcA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFLHd9XPKrpBSmdsT7otmlvCzKKzWWppndWjmmmf13 46v2LYxuKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAifh4M/71Tu0OOvquQV1BI b75z7dAdR9Eyse//pjEv33Xw2LQek/sM/4vDeHM1t8793cE1M5thLR/r/TktF66uKavpSO2ZU7r QhRMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

The series introduces writeback helper APIs and converts f2fs, gfs2
and nfs to stop accessing writeback internals directly.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 9702969978695d9a699a1f34771580cdbb153b33:

  Merge tag 'slab-for-7.0-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab (2026-02-16 13:41:38 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.writeback

for you to fetch changes up to 86566865986c4fa1963aace4ef5181501b2974c7:

  Merge patch series "Avoid filesystem references to writeback internals" (2026-02-17 13:25:19 +0100)

----------------------------------------------------------------
vfs-7.1-rc1.writeback

Please consider pulling these changes from the signed vfs-7.1-rc1.writeback tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Avoid filesystem references to writeback internals"

Kundan Kumar (4):
      writeback: prep helpers for dirty-limit and writeback accounting
      f2fs: stop using writeback internals for dirty_exceeded checks
      gfs2: stop using writeback internals for dirty_exceeded check
      nfs: stop using writeback internals for WB_WRITEBACK accounting

 fs/f2fs/node.c              |  4 ++--
 fs/f2fs/segment.h           |  2 +-
 fs/gfs2/super.c             |  2 +-
 fs/nfs/internal.h           |  2 +-
 fs/nfs/write.c              |  3 +--
 include/linux/backing-dev.h | 13 +++++++++++++
 6 files changed, 19 insertions(+), 7 deletions(-)
