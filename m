Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB62BE7D1;
	Fri, 12 Jun 2026 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277386; cv=none; b=L+gFsJ12Pu1gbvz0odx+lek8AysliO0HgAMF7uyl2xcL/rYjCq4FWx142ArOFDMjp7Y5qQiA2+pyxQbauQeRyYyb8SEtGc887GyiHwLtI+JD3SmpkUU7bBHIKlQAxVuf6iLi/nM8Ev3vaSg1+jBJBkZ29k23gXwnFTtEwp84JQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277386; c=relaxed/simple;
	bh=tR4S3b81VhvBB+qE98w1sPtZ8/A31xO4kWhdqFNIB04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAQTHGKJhWza8TYbIyNdzO45SJWeAKnszNd1a4bp7GjpPvJyB6HxD6X3oP9H7xRIwnXVQmDQ4r4J9BE8/iJKqG2eLRPEr4/Bjmocedq7JPglap1ZE063Uh8DOg7Wyg36SM90uybAnckaJYK4Jj/daViTD4W3AhAXr/Nuq1QAZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd+pIFKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd+pIFKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012931F000E9;
	Fri, 12 Jun 2026 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277385;
	bh=HzWkyb1SUyYvUTdRzFwZ8Oth+NFuVC3NJ/kkv0BvRo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rd+pIFKUID8jmjVCAq536n7hiQJpmqHyx8Pj0cdlSJzdy8rfEQfQJuWLq3f/1xjMY
	 JphMFBzRfVJhLgoVVbOQROQxO1ff3yqmRI7cPm4ZRCRVOfw5XyL4DyvdEQL2XbXYOy
	 CvBbLYBh5FMkyBLb7RFjz606FoVWhTWYpAzWUT6Jxj34d0lbObOxzYjn+JLTlQl/UX
	 wVnyQ1FQPnkzf5xk6t6KYWWg2O7+uX9sKj/KvA3gwTMLbvvXgzB+IfXt6KX9lijUiI
	 /QmJUQ47qEVrOITphB10wiSkEClCQ1rG06bvcD+wAsHYW2o77tts+sHL8E4XzcF+SK
	 fHdxJaopCpIaw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 16/16 for v7.2] vfs procfs
Date: Fri, 12 Jun 2026 17:16:18 +0200
Message-ID: <20260612-vfs-procfs-v72-15e0a3b7e3d2@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6326; i=brauner@kernel.org; h=from:subject:message-id; bh=tR4S3b81VhvBB+qE98w1sPtZ8/A31xO4kWhdqFNIB04=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKB059SBuR/PnJ04C2mbmwk84Re5s2KjcOTmtjk37/ xbFw+zuHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ7sLIcONH3SOPonqBaTan snbxPD3y8EBFiIjtkvifz1wfL3U/zMfwT8U4z/Hon37uHQuvlLD/8OVTvPLS98Z7p9a5B37e3uO 9kxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the procfs changes for this cycle:

* Revamp fs/filesystems.c

  The file was a mess with a hand-rolled linked list in desperate need
  of a cleanup. The filesystems list is now RCU-ified, /proc files can
  be marked permanent from outside fs/proc/, and the string emitted
  when reading /proc/filesystems is pre-generated and cached instead
  of pointer-chasing and printfing entry by entry on every read. The
  file is read frequently because libselinux reads it and is linked
  into numerous frequently used programs (even ones you would not
  suspect, like sed!). Scalability also improves since reference
  maintenance on open/close is bypassed.

  open+read+close cycle single-threaded (ops/s):
  before: 442732
  after:  1063462 (+140%)

  open+read+close cycle with 20 processes (ops/s):
  before: 606177
  after:  3300576 (+444%)

  A follow-up patch adds missing unlocks in some corner cases and
  tidies things up.

* Relax the mount visibility check for subset=pid mounts

  When procfs is mounted with subset=pid, all static files become
  unavailable and only the dynamic pid information is accessible. In
  that case there is no point in imposing the full mount visibility
  restrictions on the mounter - everything that can be hidden in
  procfs is already inaccessible. These restrictions prevented procfs
  from being mounted inside rootless containers since almost all
  container implementations overmount parts of procfs to hide certain
  directories.

  As part of this /proc/self/net is only shown in subset=pid mounts
  for CAP_NET_ADMIN, reconfiguring subset=pid is rejected, the
  SB_I_USERNS_VISIBLE superblock flag is replaced with an
  FS_USERNS_MOUNT_RESTRICTED filesystem flag, fully visible mounts are
  recorded in a list, and the mount restrictions are finally
  documented.

* Protect ptrace_may_access() with exec_update_lock in procfs

  Most uses of ptrace_may_access() in procfs should hold
  exec_update_lock to avoid TOCTOU issues with concurrent privileged
  execve() (like setuid binary execution). This fixes the easy cases -
  the owner and visibility checks and the FD link permission checks -
  with the gnarlier ones to follow later.

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

This will have a merge conflict with:
[1]: https://lore.kernel.org/20260612-vfs-misc-v72-13d57389d260@brauner

Both add a new fs_flags define at the same location in
include/linux/fs.h. The bit values don't overlap. It can be resolved
as follows:

diff --cc include/linux/fs.h
index 10d35a68f597,e7ff9f8b1485..dcd0575a3830
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -2281,7 -2281,7 +2281,8 @@@ struct file_system_type
  #define FS_MGTIME		64	/* FS uses multigrain timestamps */
  #define FS_LBS			128	/* FS supports LBS */
  #define FS_POWER_FREEZE		256	/* Always freeze on suspend/hibernate */
+ #define FS_USERNS_MOUNT_RESTRICTED 512	/* Restrict mount in userns if not already visible */
 +#define FS_USERNS_DELEGATABLE	1024	/* Can be mounted inside userns from outside */
  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
  	int (*init_fs_context)(struct fs_context *);
  	const struct fs_parameter_spec *parameters;

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.procfs

for you to fetch changes up to cf30ceccfaec3d2549ff60f7c915625f12dd3a93:

  fs: fix ups and tidy ups to /proc/filesystems caching (2026-06-12 14:26:27 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.procfs

Please consider pulling these changes from the signed vfs-7.2-rc1.procfs tag.

Thanks!
Christian

----------------------------------------------------------------
Alexey Dobriyan (1):
      proc: allow to mark /proc files permanent outside of fs/proc/

Alexey Gladkov (4):
      proc: subset=pid: Show /proc/self/net only for CAP_NET_ADMIN
      proc: prevent reconfiguring subset=pid
      proc: handle subset=pid separately in userns visibility checks
      docs: proc: add documentation about mount restrictions

Christian Brauner (7):
      namespace: record fully visible mounts in list
      fs: move SB_I_USERNS_VISIBLE to FS_USERNS_MOUNT_RESTRICTED
      fs: RCU-ify filesystems list
      sysfs: remove trivial sysfs_get_tree() wrapper
      Merge patch series "revamp fs/filesystems.c"
      Merge patch series "proc: subset=pid: Relax check of mount visibility"
      Merge patch series "proc: protect ptrace_may_access() with exec_update_lock"

Jann Horn (2):
      proc: protect ptrace_may_access() with exec_update_lock (part 1)
      proc: protect ptrace_may_access() with exec_update_lock (FD links)

Mateusz Guzik (2):
      fs: cache the string generated by reading /proc/filesystems
      fs: fix ups and tidy ups to /proc/filesystems caching

 Documentation/filesystems/proc.rst |  19 ++-
 fs/filesystems.c                   | 330 +++++++++++++++++++++++++------------
 fs/mount.h                         |   4 +
 fs/namespace.c                     |  34 +++-
 fs/ocfs2/super.c                   |   1 -
 fs/proc/array.c                    |   6 +
 fs/proc/base.c                     | 160 ++++++++----------
 fs/proc/fd.c                       |  27 ++-
 fs/proc/generic.c                  |  10 ++
 fs/proc/internal.h                 |   5 +-
 fs/proc/namespaces.c               |  12 ++
 fs/proc/proc_net.c                 |   8 +
 fs/proc/root.c                     |  24 ++-
 fs/sysfs/mount.c                   |  18 +-
 include/linux/fs.h                 |   3 +-
 include/linux/fs/super_types.h     |   2 +-
 include/linux/proc_fs.h            |  13 ++
 kernel/acct.c                      |   2 +-
 18 files changed, 429 insertions(+), 249 deletions(-)
