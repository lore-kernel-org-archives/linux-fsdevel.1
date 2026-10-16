Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49804377558;
	Fri, 16 Oct 2026 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146152; cv=none; b=BR/HHURrenW0qeyRchSZlFu8ho+v47Pfc3NDNfbXTVtPSnwr9aEQv/sCsO9hNLh2FhzYkHwBt7LLkrVUyKvpNLBowQcLpbSmBmXCc07aoYEm9Jyii7YjfHZ/kJbFywswgJ+6j6x/wP8a7QkbAwjXvNzbFpR0kxL8DMmqDi1pxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146152; c=relaxed/simple;
	bh=XLEWQiURi7aTHFjkuux9+QTBXfbA+Tn69PBNfHt4MlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=To8AzHRs8/sjdlZ4BSmCGjgj89ipXDep7mklP1RdaZ1JYL3wrEjMuLlrj0aNgvESxl3y6BDyAQ5brqydpHaToQLtrQ7/xB1k3hBD5kGeR01tixmNHSrxJdLX3A+XOyN+8ETg3tQ7QQHfbtdJ/yhYo3gHN+ij6uVZpwA2sEzVrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUuIJobk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUuIJobk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8380E1F000C4;
	Fri, 16 Oct 2026 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146150;
	bh=MmsD/+E77JzcPrYTTMXzSxDw0SRmaBW7nVo2SCiVios=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KUuIJobkfdIAK1xw1cr+2nUJ2Xgth+pSBxQ0EE8B68egwpz4HdQM1AB7BmgzLIVPl
	 z68hoF5XAlgzML8NTD48H5krOE5x5OsvtOnYkyr3XgXv8zOdfN26fe/X82pFRnwmvI
	 EXGi1sov1WSJ9K9k7lhvTqHENS/l0uUnybOa9iDIvR/yILRS3jjWnjUlvirDgYeQOS
	 Xfio8oxBdiIRfrzzRnTy/GvEyaGfG63WipDztNWdDb44GdH63MKMWJAWfX4iHbCPb9
	 wIIb/eQJxCCxKeDW8bUDWJ4iZZce1ciEPkS4g35AVk/Vo1g7CeXTZeWOqFUbOE0xl/
	 /V2cwsB3tn/jQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 12/19 for v7.4] vfs kernfs
Date: Fri, 16 Oct 2026 12:21:59 +0200
Message-ID: <20261016-vfs-7.4-rc1.kernfs-d34b0bc9b87b@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6438; i=brauner@kernel.org; h=from:subject:message-id; bh=XLEWQiURi7aTHFjkuux9+QTBXfbA+Tn69PBNfHt4MlY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/HVL9OytqpfPS3gO1m3ujpi6+M8VtYxb6XaMm7lyb 52PcD38s6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiQm4MfwWlL6nu4tuV9uz1 3/1HXK6vLPqTOf9j/oQlwUejr28OmsTE8N/H9veOqv5rurN2zz/d9UWR7d27Le48C1vvHVt4jXP W2mkcAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains kernfs scalability work from Shakeel driven by what Meta
sees in their fleet. kernfs_rwsem is per kernfs root, so sysfs and
cgroupfs each have one for the whole machine, and every create, remove
and rename takes it for writing. rwsems don't let readers steal the lock
once a writer is queued, so one cgroup being created or a device being
renamed parks the entire incoming reader stream in uninterruptible
sleep. Daemons that poll cgroup files in a loop turn that into a convoy
and the two that hurt most, oomd and below, are the ones that are
supposed to relieve memory pressure and record what happened.

kernfs_dop_revalidate() took kernfs_rwsem for read once per path
component of every walk into a kernfs mount. Nothing it reads needs the
semaphore. kn->active is an atomic_t, kn->__parent and kn->name are rcu
pointers, kn->ns can be compared instead of dereferenced and the
directory revision is a plain counter. The callback runs under rcu now.
Readers walking cgroupfs and sysfs while another thread churns cgroups,
renames netdevs and plugs devices went from 48,593,360 read
acquisitions and 1,744,517 contentions to 1,280,280 and 429,846 on an
8-CPU VM and path walk throughput improved 35-53%. LOOKUP_RCU still
returns ECHILD because kernfs_iop_permission() forces every walk out of
rcu-walk anyway. That is left for later.

kernfs_fop_readdir() held the semaphore across dir_emit(). dir_emit()
copies to userspace and under memory pressure that fault goes to
reclaim with the lock every create, remove and rename needs held for
reading. Meta sees 120 second allocation stalls in filldir64() from
below and systemd-oomd stuck behind it. The lock is dropped around
dir_emit() now. Since the entry the listing stopped on can disappear in
that window and two entries can share a hash, readdir resumes on the
full (hash, ns, name) key and the fallback search lands after the
missing entry instead of repeating or skipping one. The repeat was a
pre-existing bug between two getdents(2) calls.

Three more lock holds are shortened. kernfs_notify_workfn() no longer
holds kernfs_rwsem across fsnotify() which allocates against the memcg
of the watching cgroup that is already under pressure. The open node is
allocated outside the hashed open file mutex, the most contended lock
in kernfs on their fleet with 2.19M waiters over 29 days and a 77ms
median hold. A new node is activated without dropping and retaking the
write lock, lock_stat says 1200 -> 830 write acquisitions for five
dummy netdevs, and kernfs_rename_ns() allocates the new name before and
frees the old one after the lock so a rename can't enter reclaim or
wait out a grace period with it held.

Three standalone fixes come with selftests. Same-parent renames take
kernfs_rename_lock too so kernfs_path_from_node() can't build a path
that never existed. Decoding a file handle takes the semaphore so a
decode racing rmdir() can't hash an inode after the removal's ilookup()
pass and lose IN_DELETE_SELF. And kernfs_create_link() reads the
target's uid and gid under kernfs_iattr_rwsem so a chown in between
can't give the link an owner the target never had. The kernfs selftests
grew from two xattr checks to coverage of dentry revalidation, rename,
namespace tagging, file handles and readdir under churn.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.kernfs

for you to fetch changes up to 1c45110a23bd7fb4a1a7d5f5a1014c5b688844ae:

  Merge patch series "kernfs: do less work under the kernfs_rwsem write lock" (2026-09-25 16:59:12 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.kernfs

Please consider pulling these changes from the signed vfs-7.4-rc1.kernfs tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (4):
      Merge patch series "kernfs: remove kernfs_rwsem from dentry revalidation"
      Merge patch series "kernfs: three standalone fixes"
      Merge patch series "kernfs: don't hold kernfs_rwsem across dir_emit()"
      Merge patch series "kernfs: do less work under the kernfs_rwsem write lock"

Shakeel Butt (18):
      kernfs: Use VFS lookup context in d_revalidate()
      kernfs: Prepare directory revisions for lockless reads
      kernfs: Avoid namespace dereference in d_revalidate()
      kernfs: Remove kernfs_rwsem from dentry revalidation
      selftests: cover kernfs dentry revalidation
      selftests: cover kernfs file handles and same-parent rename
      kernfs: take kernfs_rename_lock for same-parent renames too
      kernfs: don't lose IN_DELETE_SELF when decoding a file handle
      kernfs: fix up the unlocked attribute reads on the creation paths
      kernfs: allocate the open node outside the open file mutex
      kernfs: don't hold kernfs_rwsem across notification delivery
      kernfs: don't repeat or skip an entry when readdir resumes
      kernfs: resume readdir on the full entry key
      kernfs: don't hold kernfs_rwsem across dir_emit()
      selftests: cover readdir resuming at a removed entry
      kernfs: activate a new node without dropping kernfs_rwsem
      kernfs: allocate the new name outside kernfs_rwsem
      kernfs: free the old name outside kernfs_rwsem

 MAINTAINERS                                       |    1 +
 fs/kernfs/dir.c                                   |  225 ++--
 fs/kernfs/file.c                                  |   47 +-
 fs/kernfs/kernfs-internal.h                       |   18 +-
 fs/kernfs/mount.c                                 |   32 +-
 fs/kernfs/symlink.c                               |   17 +-
 tools/testing/selftests/filesystems/config        |    8 +
 tools/testing/selftests/filesystems/kernfs_test.c | 1187 ++++++++++++++++++++-
 8 files changed, 1414 insertions(+), 121 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/config
