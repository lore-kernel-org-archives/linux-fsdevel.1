Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A07456E1E;
	Fri, 16 Oct 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146416; cv=none; b=LsR/je0STQdFSYXyTdpKZ+YlNuARPQ2tZVhg2kaYbIAO+ECEzgr7gE7kAhVISZL9XfJnftsyvhfJnr4ozOMkEFDZ6cKgLuc5YBKhnOmTtjaprhJ3cOBXnVRR4WE8Pqk4b++MZIqMQqZK6J1OEWag/lnn+uuZ5Np+YvmNktck6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146416; c=relaxed/simple;
	bh=5X+Hz3FsqH+OUdSaW+rWeomMkUj7YWo0rcMJi/PXyO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwAV189AXkOr8SFbWrtuGLBZGQQSdnqUXcsUdJu5wiKEj3LP9o0ntcCx7l7eFfcKJh5q0JIUi6tgMj7k+jCyOiUdsJtzmPMXAHTBGMQv2Ic9IKG+ss2AdYYVcVjONQdOW6zA7UfLnLICGOuCDWd2ZYoNUDqEknDpgtmtCAKjNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIZ/6HSM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIZ/6HSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFC51F000C4;
	Fri, 16 Oct 2026 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146412;
	bh=aAcZd/1a5QH6emZD012JISlg5YWpQgM0L/in0xAa8AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mIZ/6HSMZf/3wDF506F1zyjAyaHTW6TYPx7t4ud5QwAryvqB9TBuTNWiIhH2Kgeyf
	 h9/Mx1fq0j/6b+3Fi+74+5v524T34W00blt7kaLWG2XLN/FhM7V27FYpJ+9ZNgr27y
	 4zXQKQfkNU4etAn+TlyKjcFv6tXxbUoXmle6qheTSWA9Tye0d+iXS//IP/nbFHsqhR
	 QbM67ffRTNg5ZhszCzwKC01RGe9DBPJeTNvBZkcFDv0h+2Zgamovy3oCBR043soVFG
	 M2jtA82j91jZv+19rwbvkzkQmng0nYBHzUSs584uVxc4E0zDrdpuZKwcAD3wadQAkS
	 X+ZZFMEJJQcxw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 18/19 for v7.4] vfs shared super
Date: Fri, 16 Oct 2026 12:26:37 +0200
Message-ID: <20261016-vfs-7.4-rc1.shared.super-9c2de4415e8b@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=brauner@kernel.org; h=from:subject:message-id; bh=5X+Hz3FsqH+OUdSaW+rWeomMkUj7YWo0rcMJi/PXyO4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/P3QtOigTwTL39U7zB/O9C837Z777otNi/ORopzvl 7YlRzpu6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIpjMjQ3v7+QfeObMWX/vN l3d3peaF75b1VZNucsRxp/ac/dgiw8rwVzD2itqXH54MCzXWzcn4vzrvPXfaLduaDybFmWfYfZf psgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This renames vfs_get_super() to get_tree_super() and exports it so a
filesystem that needs its own superblock matching policy can reuse it
instead of open-coding sget_fc() plus fill_super(). erofs uses it to
share a superblock between file-backed mounts. This is a branch shared
with the erofs tree so the change may also reach you through the erofs
pull request.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.shared.super

for you to fetch changes up to ab3c5140acb36ecc02d5408b99aaaa5648f2ba1f:

  Merge patch "erofs: share the superblock for file-backed mounts" (2026-10-12 12:47:33 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.shared.super

Please consider pulling these changes from the signed vfs-7.4-rc1.shared.super tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch "erofs: share the superblock for file-backed mounts"

Giuseppe Scrivano (1):
      fs: rename vfs_get_super() to get_tree_super() and export it

 fs/super.c                 | 19 +++++++++++++++----
 include/linux/fs_context.h |  4 ++++
 2 files changed, 19 insertions(+), 4 deletions(-)
