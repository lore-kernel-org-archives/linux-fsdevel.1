Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436610;
	b=5JEjH43Qsz9uujsTmXXcg/EvOqPF2n8ulpIc9RS1HiN68fIY46V2bG6X+zqww0Ydc7A6
	 fz2CV5wZKPZErk5pqLXOvJsfUxeI15hTI1gBtZR+ZxjW/5lBVjy2T55BjIC2mF2rX3nek
	 pwo0+rOMj1luZ0lgo9mKTydtFcJRuvdtYKZtOR7TYbB9lc6UO6aV3Fe/uWmJbheQVVwr8
	 Q0Cya66V3PcqsjTstbCzbR5+oiciyWtJsDIPEnGgpto9KdAdwXYzF+gdoMzNL9Rz0/ufF
	 caXlbHVHaXz0mzrT0tOzjB8Y9tlr1ist062ItI2Kcul092aafToNFsVR/qp3AiZK7kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=Kp6SWUPzNY3SnuEpqDyDKKx0eQvfF4FFcGru27vjJ+U=;
	b=G+zRNsJQp5mg83ZR557Meh+M5W5x8Dc5/JFpAhusW7quupZbry1CoQmzCwRP43PCX3xj
	 aN5608oEuMucHZmBNWG4k6HKpeUnCr14xUNeC52Hm2SEmtPwSl3LCZ8iTQHOQSLd8CCgQ
	 BFTkLluB+NgwXkOKuJi+xb54cyThpTAmolPoHWntNCMC6z/DGuzAXhcjAmadvGZkQvD5u
	 ZEFbFOaX0l8mJgwvh+giu4zKc0/uYr2SAtMKs/S/nYxYxdorkMItAOyi/i17Gf6Jahxyd
	 er/NA6v60cjirjvijVTMQb9ZIzglMd2KDtoWW0jIXKyOprEBFsa/omvJpCyNBvggqHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmy0Hz4C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE4606A339;
	Wed, 11 Nov 2026 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmy0Hz4C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B431F00A05;
	Wed, 11 Nov 2026 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436609;
	bh=Kp6SWUPzNY3SnuEpqDyDKKx0eQvfF4FFcGru27vjJ+U=;
	h=From:To:Cc:Subject:Date;
	b=bmy0Hz4CHiCfKltUIL+muGq5GLu8oWDVbPIrpqBKk7LXdSuR6U6OsK2FZ+L3hipNP
	 mnxU3iIzDcLeQHM7LJGYRGRuC7fARGa9Ly67gO5rVSTenCgyNsUSmluQ4rZo+668G3
	 jmkTl47mlI8FHQQsoeAjGRCATiUR+2uUrG4oSLlanq72fnPFFY62NC8hU97Qscmvs3
	 EWyjtCqrxhvqapVAtLTw8U/k94QDtJZKMSDVGcFZmMeKJI7pbXMUIRUf09isZNM0pb
	 lpTq1T3/dwupZasMlDUwmX9BHQrB7niHGx/qhoihlTh1PoyveOTE0bcF3PVvGFMtdk
	 SbsR34/G2W11A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.4] vfs fixes
Date: Wed, 11 Nov 2026 23:36:23 +0100
Message-ID: <20261111-vfs-7.4-rc3.fixes.2-6660a456a8e2@brauner>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8937; i=brauner@kernel.org; h=from:subject:message-id; bh=hk6E6JBWz0x/ihgNONcGmK/Rdj0nRJuwS5nbVG+H++M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9efvDsEN7xuzXh8VlRNqCNyXM4vH5r/nX0GNp1X+F+ RWFcYWvO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYydy4jw9xF049tvHnB2vGK zOuQd2xSUZZhLy81n1z5aFHC/oXHZYUY/ge7P+SS1ZihMMveReTi84T+81e0WHvYdQ5NuaphfjJ ChA0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains another round of fixes for the current development cycle:

- inode: Let the shrinker reclaim inodes with I_METADATA_WRITEBACK like
  any other clean inode and have evict() write out what the bit tracks
  unless the inode is being deleted.

  Since v7.3 ext2, ext4 without a journal, fat, udf and minix set
  I_METADATA_WRITEBACK when they copy an inode into its buffer and only
  fsync() and friends clear it again. inode_lru_isolate() took such
  inodes off the LRU expecting something to put them back once the bit
  was gone but nothing ever did. So they couldn't be reclaimed until
  something fsynced them or the filesystem was unmounted. On ext4
  without a journal an atime update was enough to pin an inode, and
  creating 60000 small files in a memory cgroup limited to 96M got the
  task OOM killed after about 43000 of them. Now all 60000 get created.

- dcache:

  * Give d_set_mounted() a seqlock of its own that d_invalidate() waits
    on after unhashing the dentry. Since v6.17 d_set_mounted() doesn't
    bump the seqcount of rename_lock anymore, so a mount racing
    d_invalidate() could end up below the unhashed directory. Nobody
    can reach it there and it pins the subtree until the mount
    namespace goes away. With a FUSE directory 3000 levels deep 151 of
    200 bind mounts racing FUSE_NOTIFY_INVAL_ENTRY ended up there.

  * Only take busy secondary roots off ->s_roots in do_one_tree() so
    that umount waits for a racing eviction of an idle one. Since v7.3
    it didn't, which ended in busy inodes after unmount and an iput()
    on a dead superblock.

  * Make a disconnected dentry a secondary root when the mount on it
    goes away so that umount finds it and waits for its eviction. With
    CAP_DAC_READ_SEARCH such a dentry can be mounted on via
    open_by_handle_at() and move_mount() and umount racing its eviction
    ended the same way.

- splice:

  * Remove pipe buffer stealing as you and David suggested. fuse and
    virtio_console were the only users of ->try_steal() and now always
    copy, as they already did when a steal failed. Stealing took page
    cache folios out of their files and turned pages into page cache
    folios and back. SPLICE_F_GIFT and SPLICE_F_MOVE are still accepted
    and fuse still advertises FUSE_SPLICE_MOVE so servers that ask for
    it mount as before.

  * Clamp a ->write_iter() result that is larger than the iterator in
    iter_file_splice_write() instead of only warning about it.
    Otherwise the pipe releases buffers past its head.

- ns:

  * Allocate the namespace id before calling the namespace_init LSM hook
    that was added this merge window. Landlock now logs the allocated id
    instead of zero when it denies the creation of a namespace.

  * Don't mark the arguments of the namespace_init and namespace_free
    hooks as trusted for bpf LSM programs. Both see namespaces that are
    only partially set up or on their way out.

- proc: Don't let proc_sys_call_handler() report more bytes written than
  it was passed when a cgroup/sysctl bpf program replaced the value with
  a longer one. A splice() into the sysctl file then walked past the
  pipe head.

- coda: Pass the append state of each write on to the container file
  with RWF_APPEND or RWF_NOAPPEND. coda_open() sets O_APPEND on the
  container file after its iocb flags were cached, so an O_APPEND write
  overwrote existing data instead of appending.

- adfs: Reject big directory entries in adfs_fplus_getnext() whose name
  doesn't fit into the name buffer. A crafted image overflowed it on the
  stack.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 1448959fe3d013ffdb8302d17e4a8fdad2d2da95:

  fs: fix the SEEK_CUR f_lock condition (2026-11-09 16:04:55 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc3.fixes.2

for you to fetch changes up to 2cca8a6f6ae690755862f5b633125119dcf6bd0c:

  Merge patch series "ns: fixes identifier fixes" (2026-11-11 12:41:49 +0100)

----------------------------------------------------------------
vfs-7.4-rc3.fixes.2

Please consider pulling these changes from the signed vfs-7.4-rc3.fixes.2 tag.

Thanks!
Christian

----------------------------------------------------------------
Cheng Yongkang (2):
      fs/proc: fix the write length returned by proc_sys_call_handler()
      fs/splice: clamp an over-reported write_iter result

Christian Brauner (22):
      ext2: add ext2_inode_block() helper
      ext2: don't read the inode block in ext2_sync_inode_metadata()
      ext4: use sb_find_get_block_nonatomic() in ext4_get_inode_loc_noio()
      ext4: don't read the inode block in ext4_sync_inode_metadata()
      minix: add minix_inode_block() helper
      minix: don't read the inode block in minix_sync_inode_metadata()
      udf: don't allocate the inode block in udf_sync_inode_metadata()
      fs: set I_METADATA_WRITEBACK in mmb_mark_buffer_dirty()
      fs: don't strand I_METADATA_WRITEBACK inodes outside the LRU
      ext2: drop mmb_sync() from ext2_evict_inode()
      ext4: drop mmb_sync() from ext4_evict_inode()
      minix: drop mmb_sync() from minix_evict_inode()
      udf: drop mmb_sync() from udf_evict_inode()
      fat: drop mmb_sync() from fat_evict_inode()
      Merge patch series "fs: reclaim inodes with I_METADATA_WRITEBACK"
      dcache: let d_invalidate() wait for a d_set_mounted() in flight
      Merge patch series "dcache: fixes for mountpoints racing d_invalidate() and umount"
      Merge patch series "splice: remove pipe buffer stealing"
      bpf: don't mark namespace_init and namespace_free arguments as trusted
      ns: allocate the namespace id before the namespace_init hook
      nstree: drop ns_tree_add_raw()
      Merge patch series "ns: fixes identifier fixes"

Hungyu Lin (1):
      coda: honor the append state of each write

HyeongJun An (1):
      fs/adfs: bound directory entry name length in adfs_fplus_getnext()

Josef Bacik (2):
      dcache: wait for a racing eviction of a secondary root
      dcache: let umount find a disconnected ex-mountpoint

Kiryl Shutsemau (Meta) (4):
      virtio_console: copy pipe buffers in splice_write()
      fuse: don't move pipe buffers into the page cache
      splice: remove pipe buffer stealing
      splice: replace nosteal_pipe_buf_ops with default_pipe_buf_ops

 Documentation/admin-guide/LSM/landlock.rst |   5 +-
 Documentation/trace/events-landlock.rst    |   5 +-
 drivers/char/virtio_console.c              |  39 +++-----
 fs/adfs/dir_fplus.c                        |   2 +
 fs/buffer.c                                |  16 +++-
 fs/coda/file.c                             |   3 +-
 fs/dcache.c                                |  44 +++++++--
 fs/ext2/inode.c                            |  63 ++++++++-----
 fs/ext4/inode.c                            |  22 ++---
 fs/fat/inode.c                             |   1 -
 fs/fuse/args.h                             |   1 -
 fs/fuse/dev.c                              | 146 +----------------------------
 fs/fuse/file.c                             |   1 -
 fs/fuse/fuse_dev_i.h                       |   1 -
 fs/inode.c                                 |  13 ++-
 fs/minix/bitmap.c                          |  37 +++++---
 fs/minix/inode.c                           |  18 ++--
 fs/minix/minix.h                           |   1 +
 fs/namespace.c                             |   6 +-
 fs/pipe.c                                  |  43 ---------
 fs/proc/proc_sysctl.c                      |   5 +-
 fs/splice.c                                | 113 +++-------------------
 fs/udf/inode.c                             |  33 +++----
 include/linux/fs/super_types.h             |   2 +-
 include/linux/ns_common.h                  |  16 ++--
 include/linux/nstree.h                     |  29 +-----
 include/linux/pipe_fs_i.h                  |  38 --------
 include/trace/events/landlock.h            |   3 +-
 ipc/namespace.c                            |   3 +-
 kernel/bpf/bpf_lsm.c                       |   2 +
 kernel/nscommon.c                          |   7 +-
 kernel/nstree.c                            |   2 +-
 kernel/watch_queue.c                       |   4 -
 mm/shmem.c                                 |   7 --
 net/core/net_namespace.c                   |   4 +-
 net/core/skbuff.c                          |   2 +-
 security/landlock/ns.c                     |   3 +-
 tools/testing/selftests/landlock/ns_test.c |   7 +-
 38 files changed, 239 insertions(+), 508 deletions(-)
