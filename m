Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01853B9D8B;
	Fri, 16 Oct 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146217; cv=none; b=ALTIylRu/bvuTf2GyvSbCTVIMPL1H81/2r/DM44EI1RTAS+lvcgLAZ/gla7o+7c0TJewGOCrWtkj8I8AXNOGdp40e45KcdQr8Q546Rv7zVhAI/oOWOqCAQagKKk+TQZfaUsggqgxmx4tYAEVCho/Fhp7QfvRqIMZJa4YfYfGZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146217; c=relaxed/simple;
	bh=vUNY9rPt+nrilGeNstizbyc8m9RcsK3/spGwEHkD8xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahKCX0oRxeXVAaHy6mn2wzxOlQIeLry28XeyxlbEEu4ciOMkPmGLx+1g/aiJ65a0pfE5+w+OmTwaT93NO9wSkU4cH4qxCtOxstbnx8sgbiBTH79znAU+kMV2aV2ySgG0OxG7RFyqLo5Yfk2sjknpWAF53zhNNrnofQ9u7xvES/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImWTq0tV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImWTq0tV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2FF1F000C4;
	Fri, 16 Oct 2026 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146216;
	bh=DYYXr+iyYcEMmoFCZizmOeOBia2hri+7LdwScKOEP1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ImWTq0tVLqAfua0k1m+IiZEade/ivBFdo9ZHOkGvUpJ2AHlq4sFdqZUukmKP1Up+a
	 UFQ47ZEjKAWiDk/EgRA03aYBdR8JV2ifZq1hdT7yH8NRkW2Mepn0gHE+ug3l9RhS6g
	 TDcoSuKps19ya9hWELCPKKvd9S60W5zQhn8F2l+3epDprJQwfL/TowJe1s9BoKmfpg
	 so9xXWokfYXDwJaqpAgy8pErLQPNHT1KZ75KFIzHl4kGgsghIrcBm7kiLRKlJumnEX
	 wbi4pvbdS265dq/RkK9qATkfxqG6awPygYU5PW1A6en6NCal+kauQjaAbQ6vqBavs5
	 HOGc1DSK8kiUA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 13/19 for v7.4] vfs lookup
Date: Fri, 16 Oct 2026 12:22:42 +0200
Message-ID: <20261016-vfs-7.4-rc1.lookup-89a07517ed9e@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5155; i=brauner@kernel.org; h=from:subject:message-id; bh=vUNY9rPt+nrilGeNstizbyc8m9RcsK3/spGwEHkD8xs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/C0t8jv86Za2koBt9ze8WqGYUPVfqUdgwu2MSXJSP yasSfcO6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5fUMf6XY9ymrPuReLB// blX7+sWb7IJEb+zb5Ps432Fj36rUns8Mf4VOvJxvfP9fcqxB085Tj6cuKD/MMfX3pLSPUZXH1i5 pf8MNAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This prepares for Neil's changes to directory locking. The goal is for
the VFS to lock the dentry and not the parent directory and to push the
i_rwsem parent locking down into the filesystems where it can be kept,
removed or adjusted as each filesystem sees fit.

The next step in that is to swap the lock order of d_alloc_parallel()
and i_rwsem so code can wait on i_rwsem while holding an in-lookup
dentry. Two things have to change before that can happen. Nobody may
call d_alloc_parallel() while holding i_rwsem, and nobody may d_drop()
a dentry while it is being worked on since that effectively unlocks an
in-lookup dentry and lets another one be allocated too early.

So d_splice_alias() learns to handle hashed dentries in addition to
unhashed and in-lookup ones, which is what ->atomic_open() needs and
removes the reason filesystems d_drop() first. d_alloc_trylock() is a
non-blocking d_alloc_parallel() for the filesystems that prime the
dcache from readdir, smb, nfs, fuse and ceph, where waiting for a
concurrent lookup is pointless. d_duplicate() creates an in-lookup
dentry with the name of an existing one for silly-rename and whiteouts.
LOOKUP_SHARED tells ->lookup() how the parent is locked so it can drop
and retake it. DCACHE_PAR_LOOKUP is tracked by lockdep now with a per
filesystem type key, and overlayfs gets its own class since it stacks
over itself. And a d_flags bit is reserved for filesystem private use.

Also included is Mateusz's fix for the spurious dentry reference cycle
on open. __legitimize_path() grabs a reference, do_dentry_open() grabs
another and terminate_walk() drops the first. do_dentry_open() consumes
the held reference now. Opening the same file read-only on a 20-core VM
goes from 4043375 to 5629378 ops/s in will-it-scale.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This conflicts with the vfs-7.4-rc1.idmap tag in fs/namei.c between
commit 025756ee7b476 ("fs: port mnt_idmap() and file_mnt_idmap() to
const mnt_idmap") from that tag and commit 161ce1e692d01 ("fs: avoid
spurious dentry ref/unref cycle on open") from this tag. The idmap tag
is merged before this one:

diff --cc fs/namei.c
index 3fc7572e917a,d4b2e5883cba..000000000000
--- a/fs/namei.c
+++ b/fs/namei.c
@@@ -4788,7 -4791,8 +4790,8 @@@ finish_lookup
  static int do_open(struct nameidata *nd,
  		   struct file *file, const struct open_flags *op)
  {
+ 	struct vfsmount *mnt;
 -	struct mnt_idmap *idmap;
 +	const struct mnt_idmap *idmap;
  	int open_flag = op->open_flag;
  	bool do_truncate;
  	int acc_mode;

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.lookup

for you to fetch changes up to 31fbbc8bb1ca256f3d27d1172ad3493d46d29c73:

  VFS: d_duplicate: repair comments to avoid kernel-doc warnings (2026-10-16 11:14:51 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.lookup

Please consider pulling these changes from the signed vfs-7.4-rc1.lookup tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "VFS: prepare for changes to directory locking"
      Merge patch series "Fixes for dentry lockdep tracking on stacking filesystems"

Mateusz Guzik (1):
      fs: avoid spurious dentry ref/unref cycle on open

NeilBrown (10):
      VFS: fix various typos in documentation for start_creating start_removing etc
      VFS: enhance d_splice_alias() to handle hashed dentries
      VFS: introduce d_alloc_trylock()
      VFS: add d_duplicate()
      VFS: Add LOOKUP_SHARED flag.
      VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lock.
      VFS: reserve a d_flags bit for fs-specific usage
      VFS: per-fs-type lockdep key for dentry in-lookup locking
      VFS: rename lookup_map to dep_map
      ovl: provide private lockdep class for dentry->dep_map

Randy Dunlap (1):
      VFS: d_duplicate: repair comments to avoid kernel-doc warnings

 Documentation/filesystems/porting.rst |  10 +-
 Documentation/filesystems/vfs.rst     |   4 +-
 fs/dcache.c                           | 177 ++++++++++++++++++++++++++++++----
 fs/internal.h                         |   1 +
 fs/namei.c                            |  69 +++++++------
 fs/nfs/unlink.c                       |   3 +
 fs/open.c                             |  27 +++++-
 fs/overlayfs/inode.c                  |   1 -
 fs/overlayfs/overlayfs.h              |   2 +
 fs/overlayfs/super.c                  |  19 ++++
 include/linux/dcache.h                |  38 +++++++-
 include/linux/fs.h                    |   2 +
 include/linux/namei.h                 |   3 +-
 13 files changed, 296 insertions(+), 60 deletions(-)
