Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B50635E93C;
	Fri, 12 Jun 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277119; cv=none; b=GZUX3esnu3+O4rzeF3kxJOAbXJ6lqQOt1WIT4wsWDIArw1HNSp/zqjUTZ37txQAry2+8Wuq60tMY03fnFiYOJEVFXyepv+CpBKA5MzpkQAvXXb44pvR2SiPXKfXDh3ir5ICgGZmg/kcHhsU+A6LodQAGJVSe29iUiWBTIjoCRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277119; c=relaxed/simple;
	bh=Ki3CJQiipXo8nU85yh5hTa/rmsRaVHA1d2qt6Ne4/bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kfv5R+zvrY4ux7XgpkYwzdxSwMczPtte+mVjfTkeXLj2JjnOpaVzF+QdNpoFkWGTFp6I8hsNFml2KOGuINzvzbt8hcRc0qWu/SivEvKEdBoun/X1IeOL270mSU49uibFIKvO/Le32Nvn3cczbeq35J+lslTSNkJnHDxOSCyv+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h32q2jgI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h32q2jgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA2A1F000E9;
	Fri, 12 Jun 2026 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277118;
	bh=kqJoOOuKz7p1UAsfKwRHUgib9fSQ4s//TGZm/lCjg/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h32q2jgIGaU1ZliShWw0p20FnDGZz9/uq8m05a4uCYD+SASHpAUdeMQzEdSXn0XJP
	 4coLFn3Tv9zTa8V64K8flwfRPlc+tezT1INGA6Ztp3rxhFxj8tSZUVYIDw1EciEtO0
	 BDYT6gExMOnPyzaSl7Npwbv7l1HCZkfk+7KKSc57lkmR9rTMaaXuXCFn45bCBhH0DS
	 Su6qVzkk8eSxIn/ddcj4dIvyb5qZxX0GuBrRLy94JSdCBUy+R92mibXhLr+F1v4hxI
	 Q39wRFP+W3dmN8FdMNcQQWt1rRsizAArO8yPv3uuq9H7tkSaFwteePq7B/4bsstFxM
	 j7elpmvg75Bag==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 02/16 for v7.2] vfs exportfs
Date: Fri, 12 Jun 2026 17:11:49 +0200
Message-ID: <20260612-vfs-exportfs-v72-75b4494c2b8a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639; i=brauner@kernel.org; h=from:subject:message-id; bh=Ki3CJQiipXo8nU85yh5hTa/rmsRaVHA1d2qt6Ne4/bI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKO5QcX05Y/snp/uP7t6VrUri7WJgMFxzP//eEgFNi Y1XlvwI7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjImUJGhv3TxeruPw4tvlry q+6XmHjBgbgFanc7ls9ozNo5YdamenWG/17Jfg0i5d+s9nyNqr4Y+1n6vOKsIAa12NWvY3/bpfg fYgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This cleans up the exportfs support for block-style layouts that
provide direct block device access: the operations for layout-based
block device access are split out of struct export_operations into a
separate header, ->commit_blocks() no longer takes a struct iattr
argument, and the way support for layout-based block device access is
detected is reworked. nfsd's blocklayout code also stops honoring
loca_time_modify. This is preparation for supporting export of more
than a single device per file system.

Note that the nfsd tree is based on a merge of this branch so these
changes may also reach you through the nfsd pull request.

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

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.exportfs

for you to fetch changes up to 79e33ddc62c03cce6c29f0792454e1d618228acf:

  Merge patch series "cleanup block-style layouts exports" (2026-05-11 11:11:55 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.exportfs

Please consider pulling these changes from the signed vfs-7.2-rc1.exportfs tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "cleanup block-style layouts exports"

Christoph Hellwig (4):
      nfsd/blocklayout: always ignore loca_time_modify
      exportfs: split out the ops for layout-based block device access
      exportfs: don't pass struct iattr to ->commit_blocks
      exportfs,nfsd: rework checking for layout-based block device access support

 MAINTAINERS                    |  2 +-
 fs/nfsd/blocklayout.c          | 37 ++++++++----------
 fs/nfsd/export.c               |  3 +-
 fs/nfsd/nfs4layouts.c          | 29 ++++----------
 fs/xfs/xfs_export.c            |  4 +-
 fs/xfs/xfs_pnfs.c              | 44 +++++++++++++++------
 fs/xfs/xfs_pnfs.h              | 11 +++---
 include/linux/exportfs.h       | 25 ++++--------
 include/linux/exportfs_block.h | 88 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 162 insertions(+), 81 deletions(-)
 create mode 100644 include/linux/exportfs_block.h
