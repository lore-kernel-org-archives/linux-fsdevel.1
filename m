Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA045D92B;
	Fri, 16 Oct 2026 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146330; cv=none; b=QmbPAKwt375sV302y6V2bw03A+FDK7aJPRPSysMT7kHN6AspePOI081teuTktnXxGq99eCszjJyGzFxVlgh97URCX9Otydw4+lnXYUOEWReMJQy2lxjXEAF+BDXd+o5v/x67hkPPPxMDZczirK5u7+7sGlKrqTkuSCmg0IGga7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146330; c=relaxed/simple;
	bh=6AtTqDiPcer0wygrYchWhtMqGPa107TlaBg/sAjEKnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsufzljmM5blDW6x1djqh9DROH2fR7YKqC9aprwdsN1vdOVzYggUuohYFMkllDqv3ijy44Cg5DXtGVcX2SOtAURZ33yJV/3GGYK04aytqmeEZiJlK328zfV7/AUL7XW1krKf95KPBgt4oHyJvQg8/Lsoxiz73SxEGA97GNN5TuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxTyAYfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxTyAYfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D311F000C5;
	Fri, 16 Oct 2026 10:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146328;
	bh=L7CixjZvJoslx09K5vWKcAMed+dFpyeUYrXgbZox0Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DxTyAYfoKsaQFxfYNNDxoSSLEHtAKtUv3s4QCjj6jokS57qZpMtw5XDL17Le34cu3
	 CPxQjDA3oF2dUPIfv27zhhoAjn69wcxlvymzYzONGB+Iy0EfeuuyOOpNthIUD6FwQa
	 zupM8nvZL2VHXTpwbc0BH1nmFF28LEBQ6UELTEdIYflZnFbcWq130lZ20x+yFHlMAn
	 NDaO3g6oIvLGqHbyWbiZ+23i8vYfttUQRkHnSbFton+zBqGC0tw0jSf2XQQXvroRvl
	 9P3TxAN0nBu4otczDEUdKlHQoKSc5Gkn9wvW4yfWBd1wlS8SJtih9fTlwnYsw6wHMV
	 LqCbK79DcODPQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 15/19 for v7.4] vfs mount
Date: Fri, 16 Oct 2026 12:24:28 +0200
Message-ID: <20261016-vfs-7.4-rc1.mount-2dea99e7bb3b@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=brauner@kernel.org; h=from:subject:message-id; bh=6AtTqDiPcer0wygrYchWhtMqGPa107TlaBg/sAjEKnU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/N3dE3T4sPv5nL5HRxWEC21ON81Lcbjl7VTmJit+X lLwgVZpRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETsLRj+By+/Nq/zy8oWy49B 5huvzW55PMfb6qj69H9MN2ZZSV5Un8/IsMYjbpbLOzGf5W/L4/jeM1gY3L6zjT3t8eFtXS+/hHz 2YQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This adds OPEN_TREE_DROP_MNTNS_MOUNTS.

crun started using OPEN_TREE_NAMESPACE to set up the container's mount
namespace and open_tree(OPEN_TREE_CLONE) for the sources of its bind
mounts. That fails on any host with a mount namespace pinned below such
a source. The recursive clone picks the pinned namespace up and
move_mount() refuses to attach the tree with ELOOP. Only a younger
mount namespace may ever be bound into an older one or mount namespace
references could form a loop. A namespace created with
OPEN_TREE_NAMESPACE is younger than everything else on the system so
from inside it every pinned namespace is older.
By the time this fails setns() has run and the host tree is out of
reach, so the runtime has to predict the situation beforehand and lose
the optimization. snapd pins mount namespaces under /run/snapd/ns so on
Ubuntu that is any container bind mounting the host root.

Every other path crossing a mount namespace boundary already leaves
these mounts behind, copy_mnt_ns() and create_new_namespace() both do.
Only get_detached_copy() asks for them. The new flag lets a caller get
a clone without them. It stays opt-in because open_tree(OPEN_TREE_CLONE)
plus move_mount() is mount --rbind through a file descriptor and
dropping them by default would silently lose /run/snapd/ns/*.mnt on a
live system. It requires AT_RECURSIVE, is a no-op with
OPEN_TREE_NAMESPACE and skips locked nsfs mounts the way copy_mnt_ns()
does, so nothing new is exposed. Selftests are included.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.mount

for you to fetch changes up to 062b32e4b55082f11b63dce22c78cd00fc6c7ed5:

  Merge patch series "mount: add OPEN_TREE_DROP_MNTNS_MOUNTS" (2026-10-12 11:33:23 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.mount

Please consider pulling these changes from the signed vfs-7.4-rc1.mount tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "mount: add OPEN_TREE_DROP_MNTNS_MOUNTS"

Kir Kolyshkin (2):
      mount: add OPEN_TREE_DROP_MNTNS_MOUNTS
      selftests/filesystems: test OPEN_TREE_DROP_MNTNS_MOUNTS

 fs/namespace.c                                     |  16 +-
 include/uapi/linux/mount.h                         |   1 +
 .../filesystems/open_tree_ns/open_tree_ns_test.c   | 193 +++++++++++++++++++++
 3 files changed, 208 insertions(+), 2 deletions(-)
