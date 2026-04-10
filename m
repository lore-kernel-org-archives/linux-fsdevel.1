Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13863DA5AC;
	Fri, 10 Apr 2026 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834310; cv=none; b=frHKHtp44E2OFYTW67lIbUn3NeTqrHQiH1dxVQ07AcfUt5YDaQHXAvAXSmgANfW92UVxHPIGpOEjgu6qSVlrrJ9uRWgUAVQZ9rS2JA/39tEaYv4ZJElTO+Mzqp5LVSQ+JKvUvSN+CqVySnDaf0LhFvZCFVbwhV4uv+qWMPBWT48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834310; c=relaxed/simple;
	bh=s4rwWqNth34RtxPk2+M7vTo4UKKDvqU4JTrmjhK7b8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu/N0XVPD26ts3E5Qgnc2givFwYBL3//ppVSDF89xWA6Lcj0N2q78cUy812hmLMvsbr0x1AlZGhpVHhJ4pk8KtvCnlDQW2M/ZwTa05Qk48GIyLNDs8s4v2faSlsLk0fk91X1RPM+csfdjCsQPC6bhOLglSsY+9OIFZfSBRj2aiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg5XWJ+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg5XWJ+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46281C2BC87;
	Fri, 10 Apr 2026 15:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834310;
	bh=s4rwWqNth34RtxPk2+M7vTo4UKKDvqU4JTrmjhK7b8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cg5XWJ+fAoPu5BWYEZJCws16Xs9HyEHY5yss1HqHKAnDqDPiQBTZ+nNaBFNWR2cuv
	 28suqjo/9k6o3gwjDNFRLTaC7yRAKI81//obXG5GJQdPHPuEePg9Ev9Yjiv14BTqCN
	 CwTfUB3FcIf3WTtw4F8lGVPYbJjyhpEKyAlDNsIJee5LvyNydoQhrdIoKudaEmJ5mv
	 sQqv0V10icGGzBWuZL1k8ElgtbrMwfWjtSGKxsoobPJr7doSgyKVqUgEgheO5km64d
	 pSmVCdfJUcT/rK/MKgDl1jLK2yuYizn4jK4bg+xAtqnx1I23cOh09ndyOgUx93qwEd
	 xAet4viR/3zbg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 05/12 for v7.1] vfs fs_struct
Date: Fri, 10 Apr 2026 17:18:19 +0200
Message-ID: <20260410-vfs-fs_struct-v71-cf1d44311509@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=brauner@kernel.org; h=from:subject:message-id; bh=s4rwWqNth34RtxPk2+M7vTo4UKKDvqU4JTrmjhK7b8A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFDko52Mi6pH3Z8kd/4afmkK2dzt2rHz+3+0Qu9zN7 8l2kmF7OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS/YqRYV68yc/rcjdO3SgO P6CWV8/yo4nF4+xuHqM0n9NXK6aIlzH8FWxb9YnrnoxedEKe8hkDa+lZLa9WXE45aLr7tkmVa2g VGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Avoid excessive dput/dget in audit_context setup and reset paths When
the audit subsystem is enabled, it can do a lot of get_fs_pwd() calls to
get references to fs->pwd and then releasing those references back with
path_put() later. That may cause a lot of spinlock contention on a
single pwd's dentry lock because of the constant changes to the
reference count when there are many processes on the same working
directory actively doing open/close system calls. This can cause
noticeable performance regresssion when compared with the case where the
audit subsystem is turned off especially on systems with a lot of CPUs
which is becoming more common these days.

Avoid this type of performance regression caused by audit by adding a
new set of fs_struct helpers to reduce unncessary path_get() and
path_put() calls and the audit code is modified to use these new
helpers.

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

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.fs_struct

for you to fetch changes up to 9eecc28ec595bfc0a8af3306b57f566027b3560c:

  fs: factor out get_fs_pwd_pool_locked() for lock-held callers (2026-03-12 13:41:45 +0100)

----------------------------------------------------------------
vfs-7.1-rc1.fs_struct

Please consider pulling these changes from the signed vfs-7.1-rc1.fs_struct tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (5):
      Merge patch series "fs, audit: Avoid excessive dput/dget in audit_context setup and reset paths"
      fs: use path_equal() in fs_struct helpers
      fs: document seqlock usage in pwd pool APIs
      fs: add drain_fs_pwd_pool() helper
      fs: factor out get_fs_pwd_pool_locked() for lock-held callers

Waiman Long (2):
      fs: Add a pool of extra fs->pwd references to fs_struct
      audit: Use the new {get,put}_fs_pwd_pool() APIs to get/put pwd references

 fs/fs_struct.c            | 34 ++++++++++++++++++++++++++++------
 fs/namespace.c            | 10 ++++++++++
 include/linux/fs_struct.h | 43 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/auditsc.c          |  7 +++++--
 4 files changed, 85 insertions(+), 9 deletions(-)
