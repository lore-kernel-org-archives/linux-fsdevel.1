Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7F4DF4DC;
	Wed,  9 Sep 2026 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961461; cv=none; b=baOmU6LMHfDzLRS4MqvfBXjKrgQUrxmWwFgeqVlquNfgregCBLrF4fNFhkifYtnIZ1tf4UI35roh4RvGI8gZCavC+d0BbsIdFRcs5KLBWmz6iDqHoS3u697JkRl5BP+skWRyUpROfiN9++XhK3Rbevz7G/E3y2Rw+afHUyQWgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961461; c=relaxed/simple;
	bh=FCImgy7ee6gvQg0naqOI0csI9p9fKKKV+CXAwuu0KI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EQ+hEfiCXIT/9L2AlFJMjwQsitlfaTJ+9RwmCP5UCdlooJb/OPgiRhFWCbi3rbfU15PPcMuzQn4C0/NlhCmCqr0CP4QwJBV0Y8156sHO+k7aS2b/2zT4c+YEwyK5ugvfcGmwq9YJbmBJEdJ3iKt/0xdbX+Wyu3RdZATgTUNs5Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBQy16UH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBQy16UH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2796F1F00A3A;
	Wed,  9 Sep 2026 13:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961459;
	bh=Ikoadsp17Cw/rC9gvm90l+8LIPtF7wszEeEmzmjbNSc=;
	h=From:To:Cc:Subject:Date;
	b=XBQy16UHsvMdocV9FaqvlhpNcXeve0jENfPCMjzuewZvrZPUFG0KxUFlTdXVj00QI
	 ogryxQ7WLCBWKJa4ztndUGYqlH6+pbom6C8d1M2SjoCfRd7mcHiG6dFHes/e+H4ahQ
	 heGafvkcEs9gaRjcdvBycGMSGWAcIxvcNri6L1cNX890KzAcB+KZp2osE8cAqKdynZ
	 gWZG0YOfCFZc+79Hgfn0GAh7y8oSrbAln/27evOxHkO8kpStsOu/htX+TGNpG7xQqd
	 4FrN+HSWhuymTBITv5+ECBT9RmO6shBdBlN0eVjjctaiEqy5vv5bccmWu3GCmCo/55
	 LCg9cckSYBSfQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.3] vfs fixes
Date: Wed,  9 Sep 2026 15:44:05 +0200
Message-ID: <20260909-vfs-7.3-rc3.fixes-fffe72bd00d6@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7740; i=brauner@kernel.org; h=from:subject:message-id; bh=FCImgy7ee6gvQg0naqOI0csI9p9fKKKV+CXAwuu0KI0=; b=kA0DAAoWkcYbwGV43KIByyZiAGqhYqqj8/rAnMMYasQWvJ7CJR9zq1LFWbFjJCU+9Fi4d74Xs oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmqhYqoACgkQkcYbwGV43KKbpAEAqEOM 5jYBSrHrfaEOydrriN38cLRRPFm+0zbwVk2/gk4BAKthmUate1GQIW2UD985ZxVZaCDfkE4LF8o GFVjQowYH
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains fixes for the current development cycle:

- netfs:

  * Fix an uninitialized return value in netfs_unbuffered_write() when
    preparing the first subrequest fails.

  * For partial unbuffered/DIO writes return the amount transferred
    rather than an error.

  * Update i_size with the amount actually written when a partial
    transfer ends in an error.

  * Fix a subrequest reference leak when the io_iter ends up empty.

  * Handle netfs_alloc_subrequest() failure during unbuffered writes.

  * Load all readahead folios into the rolling buffer upfront and drop
    the readahead references once the first subrequest is dispatched.

  * Mark folios for copy-to-cache while issuing subrequests.

  * Fix read progress reporting.

- afs:

  * Add the missing kunmap in the error path of afs_dir_search_bucket().

  * Fix a double kunmap in afs_edit_dir_remove().

  * Don't free an existing server's endpoint state when cleaning up a
    candidate server in afs_lookup_server().

  * Unbind peers removed from a server's address list.

- ufs:

  * Load the cylinder group metadata before creating the root dentry.

  * Validate the cylinder group index and rotor positions before
    caching them.

  * Treat an unreadable directory block as not empty.

- exec:

  * Close the close-on-exec files before taking exec_update_lock.
    Closing a file can block on the filesystem, so a hung filesystem
    blocked everything that takes exec_update_lock and a FUSE server
    inspecting the calling process could deadlock.

  * Drop the bprm loader before closing bprm->file in free_bprm().

- exit: Hold a reference to thread_pid across proc_flush_pid().

- reboot: Fix a use-after-free on cad_pid.

- nsfs: Keep the namespace tree fields out of the rcu_head used by
  kfree_rcu().

- nstree: Check listing permission before taking a namespace reference
  in listns().

- super: Return 0 when a nested thaw drops its hold while other
  freezers remain.

- ext4: Don't set I_METADATA_WRITEBACK during fastcommit replay.

- adfs: Free s_fs_info in ->kill_sb()..

- autofs: Free the inode info allocated in autofs_fill_super() when the
  root inode allocation fails.

- ovl: Return EINVAL instead of EIO on a user namespace mismatch now
  that it's a plain refusal and not an internal error.

- cachefiles: Don't cast the variable-length coherency data to a __be64
  in the coherency tracepoint.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 818bebeb63dd6bf5f4e07e145f6cdbace520a34c:

  drm/xe: Don't hand out the flat CCS storage as usable VRAM (2026-08-20 20:12:39 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc3.fixes

for you to fetch changes up to 56ea4e86832d8abe8930394473566c194d189f85:

  nstree: check listing permission before taking a namespace reference (2026-09-09 10:03:15 +0200)

----------------------------------------------------------------
vfs-7.3-rc3.fixes

Please consider pulling these changes from the signed vfs-7.3-rc3.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Ahmet Eray Karadag (1):
      adfs: fix memory leak in sb->s_fs_info

Ali Ahmet Memis (3):
      ufs: create the root dentry after loading cylinder metadata
      ufs: validate cylinder group metadata before caching it
      ufs: do not treat unreadable directory blocks as empty

Cen Zhang (Microsoft) (1):
      reboot: fix cad_pid use-after-free race

Chengfeng Ye (1):
      afs: Clear stale peer app data after address list changes

Christian Brauner (3):
      Merge patch series "ufs: harden the mount path against malformed images"
      Merge patch series "netfs, cachefiles: Miscellaneous fixes"
      Merge patch series "afs: Miscellaneous fixes"

Daehyeon Ko (1):
      exit: hold a reference to thread_pid across proc_flush_pid

David Howells (11):
      netfs: Fix unbuffered/DIO write partial transfer error return
      netfs: Fix error vs transferred passed to ->ki_complete()
      netfs: Fix i_size update for partial transfer
      netfs: Fix subreq ref leak
      netfs: Fix readahead synchronisation issues by loading all folios upfront
      netfs: Mark folios with COPY_TO_CACHE whilst issuing subreqs
      netfs: Fix read progress reporting
      cachefiles: Fix potential UAF/KASAN warning
      afs: Fix missing kunmap in afs_dir_search_bucket()
      afs: Fix double-unmap of directory block
      afs: Fix incorrect free in candidate cleanup in afs_lookup_server()

Edward Adam Davis (1):
      netfs: break unbuffered write when netfs_alloc_subrequest() fails

Jan Kara (1):
      ext4: Avoid entering writeback paths during fastcommit replay

Jann Horn (1):
      exec: do_close_on_exec() before taking exec_update_lock

Jeffin Philip (1):
      fs: autofs: fix memory leak in autofs_fill_super()

Jérémy Jean (1):
      nsfs: keep namespace tree fields stable until after RCU grace period

Karl Mehltretter (1):
      netfs: Fix uninitialized return value in netfs_unbuffered_write()

Miklos Szeredi (1):
      ovl: return EINVAL instead of EIO in case of mismatched user_ns

Moritz Tanner (1):
      fs: don't return -EINVAL for successful nested thaw

Norbert Szetei (1):
      nstree: check listing permission before taking a namespace reference

Sun Jian (1):
      exec: Drop bprm loader before closing bprm->file

 fs/adfs/super.c                    |  24 +++---
 fs/afs/addr_list.c                 |   5 +-
 fs/afs/dir_edit.c                  |   9 +-
 fs/afs/dir_search.c                |  11 +--
 fs/afs/fs_probe.c                  |   1 +
 fs/afs/internal.h                  |   8 ++
 fs/afs/server.c                    |   1 -
 fs/autofs/inode.c                  |   4 +-
 fs/cachefiles/xattr.c              |  16 ++--
 fs/exec.c                          |  24 ++++--
 fs/ext4/inode.c                    |  11 ++-
 fs/netfs/buffered_read.c           | 164 +++++++++++++++++++++++++++----------
 fs/netfs/direct_write.c            |  31 ++++---
 fs/netfs/internal.h                |   3 +
 fs/netfs/misc.c                    |  19 +++++
 fs/netfs/objects.c                 |  32 +++++---
 fs/netfs/read_collect.c            | 128 ++++++++++++++++++++---------
 fs/netfs/read_pgpriv2.c            |  15 ++--
 fs/netfs/read_retry.c              |  13 ++-
 fs/netfs/read_single.c             |   2 +
 fs/netfs/rolling_buffer.c          |  79 +++++++++++-------
 fs/netfs/write_issue.c             |   2 +
 fs/overlayfs/super.c               |   2 +-
 fs/super.c                         |   9 +-
 fs/ufs/cylinder.c                  |  10 +++
 fs/ufs/dir.c                       |   2 +-
 fs/ufs/super.c                     |  17 ++--
 include/linux/netfs.h              |   5 +-
 include/linux/ns/ns_common_types.h |   6 +-
 include/linux/rolling_buffer.h     |   6 +-
 include/linux/sched.h              |   2 +-
 include/linux/sched/signal.h       |   5 +-
 include/trace/events/cachefiles.h  |  19 ++++-
 include/trace/events/netfs.h       |  30 ++++++-
 init/main.c                        |   2 +-
 kernel/exit.c                      |   9 +-
 kernel/nstree.c                    |  10 +--
 kernel/reboot.c                    |  19 ++++-
 kernel/signal.c                    |  12 +++
 39 files changed, 532 insertions(+), 235 deletions(-)
