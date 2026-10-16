Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E684657F2;
	Fri, 16 Oct 2026 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146358; cv=none; b=eUfCkM54t8vbPti/26iUzM6I+79Rv/a6JtNfqlyRAJrYBCWMon+HtBm5br1leubljMxwxmqj2/Z3pr99aObSnr6YaH5QGeCxle5KWu3GZvFvdEg7r1jz85b611mXwSb1KHSQdAGAkI40JhJel2jSVSiEwf3u4IiUxMTA+TrN+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146358; c=relaxed/simple;
	bh=4ri9Vi1vf0HFrjuQqJEH3mUXVtt0DeEwTPpjZcKTW5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHNCPmmmHiteorTvVHKoF6A/Ood4OasYasLl/3mO5gD6PDaoEWc0cgCDa9mh0whPpG+G4tKhLBQMb/Mtth1+hC+BHV8M5tLY+rMaukVgis5M/QQksYwb8zlp5bqswf1yl2c04xbn5/qlUBdjo++F4FqfhQpGqCsGfY2PU21VNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfYpYssP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfYpYssP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679801F000C4;
	Fri, 16 Oct 2026 10:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146356;
	bh=GI7pdd5vokOVrqgwDunEXuFThVQlPCFl+EbMFqxkB00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JfYpYssP1DO0BY4b1/Vtoy+HpySBZGh4RWSI5GNqGXZ/XT3Y6z3+dxVs5csxOmGZp
	 5AVwqqbnVQu/s0aFQ8B9BgYScSgGhRPqBQvxneJw/QamLZjyAU2ZmkpnVkg5if5Oh6
	 KSX1CpRXkMzkb03a43oYhkfyStYzdlGipDw5t7b+AHePoNbOD9X6eChnHdPiA+8GGq
	 6Cpa4+sY7ESP3vCrKKICUwEmnbFFea1B1IPhe+P3jChHRFPteHxU//g2h4yo4x+lyf
	 aLymdBL4l4EgXdKh5uHU4Eg9MCAgRX3EfLIXJDoO6cBYmGGHEbcGA2jIAd9sm8HfTf
	 2arw70M76nBYw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 16/19 for v7.4] vfs netfs
Date: Fri, 16 Oct 2026 12:25:40 +0200
Message-ID: <20261016-vfs-7.4-rc1.netfs-9979cb10f896@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7549; i=brauner@kernel.org; h=from:subject:message-id; bh=4ri9Vi1vf0HFrjuQqJEH3mUXVtt0DeEwTPpjZcKTW5Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/L3ikMrPrFmxaxZ9+8MXH+LjwejYkf3Y7U7tSS2bZ 7PYpv3P7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIXRwjQ3eDQ3nBxpL1v5P/ tjtrBe68fMXarPyBd8VfETuL402ZOgz/NGfpauusvr/O9qFTl/g259RDv+/Wf0veqrV2eeUh5uh 3fAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the netfs and cachefiles changes for this cycle from
David.

Cachefiles learns to cache the most common class of files properly,
files that are created or truncated, written once sequentially and
closed. So far it relied on the backing filesystem's idea of what is
stored and asked with SEEK_DATA and SEEK_HOLE before every read it
prepared, two seeks per read, and the backing filesystem is free to
insert or remove runs of zeros which produces false positives and false
negatives. The object type in the state xattr is now actually set to
CACHEFILES_CONTENT_{SINGLE,ALL,BACKFS_MAP} instead of zero. For files
written contiguously the type is ALL, the backing file's i_size tracks
how much is cached and the object size lives in the xattr, and reads
skip the seeks entirely. Netfslib queries the cache occupancy through a
new ->query_occupancy() method that returns up to two extents at once,
->prepare_read() only limits the size of a cache read anymore and a new
->collect_write() lets the cache update its metadata once a contiguous
run of writes completes. The state xattr is preset when the tmpfile is
created so ENOSPC from setxattr can't scrap a fully written cache file.
Two fixes for this followed, one for resize handling where the cache's
idea of the size can be stale and one for an unset error that hung a
request on a failed cache write.

Preparatory work converts file positions that can't be negative to
uoff_t, removes the writethrough code whose locking looked like it
could deadlock with ceph snapshots, makes the deprecated PG_private_2
support opt-in so mm can get its page bit back, adds helpers for the
NETFS_RREQ_ALL_QUEUED barriers and adds the cache object id to the read
and write tracepoints. Plus an unused header removal and two
documentation fixes.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a:

  Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.netfs

for you to fetch changes up to b6134f76740497004f72954ae67bd4ba45d2f044:

  fscache, cachefiles: Fix resize handling (2026-10-16 11:02:26 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.netfs

Please consider pulling these changes from the signed vfs-7.4-rc1.netfs tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "netfs: Miscellaneous preparatory changes"
      Merge patch series "netfs, cachefiles: Changes for next, primarily occupancy tracking-related"

David Howells (15):
      netfs: Use uoff_t instead of unsigned long long and loff_t
      netfs: Remove the writethrough code
      netfs: trace: Change the "clear" folio traces to "endwb"
      netfs: trace: Rejig a couple of the tracepoints
      netfs: Add the cache object ID to netfs_read/write tracepoints
      netfs: Make deprecated PG_private_2 support opt-in
      netfs: Add some functions to wrap the all-queued handling
      netfs: Set subrequest->source at alloc before trace emission
      cachefiles: Clean up cachefiles_do_prepare_read()
      netfs, cachefiles: Add a couple of traces for write failure
      cachefiles: Add a tracepoint to log insufficient space errors
      cachefiles: Don't rely on backing fs storage map for most use cases
      cachefiles: Preset the state xattr when creating a new file
      cachefiles: Fix unset error when calling netfs_prepare_write_failed()
      fscache, cachefiles: Fix resize handling

Ethan Nelson-Moore (1):
      netfs: remove unused fscache_internal.h header

Karl Mehltretter (1):
      netfs: Document the remote size member and its accessors

Zenghui Yu (1):
      cachefiles: Fix path of the "debug" module parameter in help paragraph

 Documentation/filesystems/caching/backend-api.rst |   2 +-
 Documentation/filesystems/caching/netfs-api.rst   |   2 +-
 Documentation/filesystems/netfs_library.rst       |   7 +-
 fs/9p/vfs_addr.c                                  |   1 -
 fs/9p/vfs_inode.c                                 |   6 +-
 fs/9p/vfs_inode_dotl.c                            |   5 +-
 fs/afs/file.c                                     |   8 +-
 fs/afs/inode.c                                    |   4 +-
 fs/afs/internal.h                                 |   2 +-
 fs/cachefiles/Kconfig                             |   2 +-
 fs/cachefiles/interface.c                         |  96 +----
 fs/cachefiles/internal.h                          |  18 +-
 fs/cachefiles/io.c                                | 474 ++++++++++++++--------
 fs/cachefiles/namei.c                             |  34 +-
 fs/cachefiles/xattr.c                             |  82 +++-
 fs/ceph/Kconfig                                   |   1 +
 fs/ceph/addr.c                                    |   4 +-
 fs/ceph/cache.h                                   |   6 +-
 fs/ceph/inode.c                                   |  16 +-
 fs/ceph/super.h                                   |   3 +-
 fs/netfs/Kconfig                                  |   3 +
 fs/netfs/Makefile                                 |   2 +-
 fs/netfs/buffered_read.c                          | 219 ++++++----
 fs/netfs/buffered_write.c                         |  69 +---
 fs/netfs/direct_read.c                            |  14 +-
 fs/netfs/direct_write.c                           |   8 +-
 fs/netfs/fscache_cookie.c                         |   8 +-
 fs/netfs/fscache_internal.h                       |  14 -
 fs/netfs/fscache_io.c                             |  12 +-
 fs/netfs/internal.h                               |  70 +++-
 fs/netfs/iterator.c                               |   2 +-
 fs/netfs/main.c                                   |   1 -
 fs/netfs/misc.c                                   |  10 +-
 fs/netfs/objects.c                                |   7 +-
 fs/netfs/read_collect.c                           |  14 +-
 fs/netfs/read_pgpriv2.c                           |  13 +-
 fs/netfs/read_retry.c                             |   7 +-
 fs/netfs/read_single.c                            |  50 +--
 fs/netfs/stats.c                                  |   4 +-
 fs/netfs/write_collect.c                          | 157 +++++--
 fs/netfs/write_issue.c                            | 142 ++-----
 fs/netfs/write_retry.c                            |   8 +-
 fs/nfs/Kconfig                                    |   1 +
 fs/smb/client/cifsfs.c                            |   6 +-
 fs/smb/client/inode.c                             |   2 +-
 fs/smb/client/smb2ops.c                           |   9 +-
 include/linux/fscache-cache.h                     |   2 +-
 include/linux/fscache.h                           |  60 ++-
 include/linux/netfs.h                             | 112 +++--
 include/trace/events/cachefiles.h                 |  81 +++-
 include/trace/events/fscache.h                    |  10 +-
 include/trace/events/netfs.h                      | 145 +++----
 52 files changed, 1149 insertions(+), 886 deletions(-)
 delete mode 100644 fs/netfs/fscache_internal.h
