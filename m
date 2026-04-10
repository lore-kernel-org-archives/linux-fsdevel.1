Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE33DCDB7;
	Fri, 10 Apr 2026 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834331; cv=none; b=ttz6diLY2+m5tiimIPem6v9ZrC7Btgn0S1gNRHO6+STOzKMr0M0RNA8Ds6DpTzux79+pcwS7ZNA2ICEK6PmGkPaha28HRGlupUEvjFm9WbnZSRVAiYXlAQdxU1qgXDIO9uekLouPBDGAuiqL2BKEK3O83GpuLDXnF2SqH9HJLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834331; c=relaxed/simple;
	bh=wukpuw7ehJz9fFPNVmxGOZeGS+gwgKsmhOgiop0vvsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKa5D5Irhypj7BZqDyYDojqOBuzJXhfG8DOviKV5JLysrTGpiSgDwdN02Q3+AK7IQ/YS87lGt+OOXbcA6+1BmkgFc6ie2/iV6L+J3SiStVvc9tXdClK6bTsFeuDQZ3DeWqLADsd9/PpcSoFTwHGrGBkBEbgIVklTknBoFA4vz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2glwyN9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2glwyN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0709FC2BC9E;
	Fri, 10 Apr 2026 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834331;
	bh=wukpuw7ehJz9fFPNVmxGOZeGS+gwgKsmhOgiop0vvsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2glwyN9lCy+LyIZ1XOupRypH5TCbjnXtkpTrGHHe4U0AkOU2ztidom6vPv4dPpnK
	 YHM3sXukiCQT4WNFOjPnqg5hdG3seJeg99bC+UQRrDuvFD/JBGDsiOMXkDFLxnY5Bx
	 1VH5n2oeH4I1oYtlUYtlSbgqX64trPhR2hHaymg3RC8tgOiK1EJwc31EVDRS9Vp4IK
	 PxKagcHFaNH37za+9bNZ1XtwIOaM83nSOqrLUd+cSgzw70uhO0v6XqJMqS+tnQc7uZ
	 rQup11Js9wN8+Ar7jxQo15zgEkjJHqV1+oFafri0l/IRRfVmdSbXvPVykgX6nblG1f
	 zCmMdauAihnAg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 06/12 for v7.1] vfs kino
Date: Fri, 10 Apr 2026 17:18:42 +0200
Message-ID: <20260410-vfs-kino-v71-672d31bc705c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15513; i=brauner@kernel.org; h=from:subject:message-id; bh=wukpuw7ehJz9fFPNVmxGOZeGS+gwgKsmhOgiop0vvsI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFLm2N/xFfHTCk6keKyNbkvLdVjT9Oum0NuP+D3aZ8 C113/2edJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkYjfD/zwpTXUmvswlsUt0 Wre8Yt0071DX99Vn4yZcCGFqLxMX2cPwPzk1pvdDd9yeq9MXb2femOcgv3DP1mMr0p29+ddWWq1 hYQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

For historical reasons, the inode->i_ino field is an unsigned long,
which means that it's 32 bits on 32 bit architectures. This has caused a
number of filesystems to implement hacks to hash a 64-bit identifier
into a 32-bit field, and deprives us of a universal identifier field for
an inode.

The work in this pr changes the inode->i_ino field from an unsigned long
to a u64. This shouldn't make any material difference on 64-bit hosts,
but 32-bit hosts will see struct inode grow by at least 4 bytes. This
could have effects on slabcache sizes and field alignment.

The bulk of the changes are to format strings and tracepoints, since the
kernel itself doesn't care that much about the i_ino field. The first
patch changes some vfs function arguments, so check that one out
carefully.

With this change, we may be able to shrink some inode structures. For
instance, struct nfs_inode has a fileid field that holds the 64-bit
inode number. With this set of changes, that field could be eliminated.
I'd rather leave that sort of cleanups for later just to keep this
simple.

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

[1]: https://lore.kernel.org/linux-next/CAHC9VhRndi9kMUNQFA9J1exr2G0uQ-A-wKDqJLhUntMYdnUrsQ@mail.gmail.com

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.kino

for you to fetch changes up to 2e43ca1a4f949e4beb763f8196695da02b17bd77:

  Merge patch series "vfs: follow-on fixes for i_ino widening" (2026-03-17 15:38:54 +0100)

----------------------------------------------------------------
vfs-7.1-rc1.kino

Please consider pulling these changes from the signed vfs-7.1-rc1.kino tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (4):
      Merge patch series "vfs: change inode->i_ino from unsigned long to u64"
      ext4: fix signed format specifier in ext4_load_inode trace event
      treewide: fix missed i_ino format specifier conversions
      Merge patch series "vfs: follow-on fixes for i_ino widening"

Jeff Layton (15):
      vfs: widen inode hash/lookup functions to u64
      audit: widen ino fields to u64
      net: change sock.sk_ino and sock_i_ino() to u64
      vfs: widen trace event i_ino fields to u64
      cachefiles: widen trace event i_ino fields to u64
      ext2: widen trace event i_ino fields to u64
      hugetlbfs: widen trace event i_ino fields to u64
      zonefs: widen trace event i_ino fields to u64
      ext4: widen trace event i_ino fields to u64
      f2fs: widen trace event i_ino fields to u64
      nilfs2: widen trace event i_ino fields to u64
      treewide: change inode->i_ino from unsigned long to u64
      vfs: remove externs from fs.h on functions modified by i_ino widening
      EVM: add comment describing why ino field is still unsigned long
      nilfs2: fix 64-bit division operations in nilfs_bmap_find_target_in_group()

 drivers/dma-buf/dma-buf.c                  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 +-
 fs/9p/vfs_addr.c                           |   4 +-
 fs/9p/vfs_inode.c                          |   6 +-
 fs/9p/vfs_inode_dotl.c                     |   6 +-
 fs/affs/amigaffs.c                         |  10 +-
 fs/affs/bitmap.c                           |   2 +-
 fs/affs/dir.c                              |   2 +-
 fs/affs/file.c                             |  20 +-
 fs/affs/inode.c                            |  12 +-
 fs/affs/namei.c                            |  14 +-
 fs/affs/symlink.c                          |   2 +-
 fs/afs/dir.c                               |  10 +-
 fs/afs/dir_search.c                        |   2 +-
 fs/afs/dynroot.c                           |   2 +-
 fs/afs/inode.c                             |   2 +-
 fs/autofs/inode.c                          |   2 +-
 fs/befs/linuxvfs.c                         |  28 +-
 fs/bfs/dir.c                               |   4 +-
 fs/binfmt_elf_fdpic.c                      |   2 +-
 fs/cachefiles/io.c                         |   6 +-
 fs/cachefiles/namei.c                      |  12 +-
 fs/cachefiles/xattr.c                      |   2 +-
 fs/ceph/crypto.c                           |   4 +-
 fs/coda/dir.c                              |   2 +-
 fs/coda/inode.c                            |   2 +-
 fs/cramfs/inode.c                          |   2 +-
 fs/crypto/crypto.c                         |   2 +-
 fs/crypto/hooks.c                          |   2 +-
 fs/crypto/keyring.c                        |   4 +-
 fs/crypto/keysetup.c                       |   2 +-
 fs/dcache.c                                |   4 +-
 fs/ecryptfs/crypto.c                       |   6 +-
 fs/ecryptfs/file.c                         |   2 +-
 fs/efs/inode.c                             |   6 +-
 fs/eventpoll.c                             |   2 +-
 fs/exportfs/expfs.c                        |   4 +-
 fs/ext2/dir.c                              |  10 +-
 fs/ext2/ialloc.c                           |   9 +-
 fs/ext2/inode.c                            |   2 +-
 fs/ext2/trace.h                            |   8 +-
 fs/ext2/xattr.c                            |  16 +-
 fs/ext4/dir.c                              |   2 +-
 fs/ext4/ext4.h                             |   4 +-
 fs/ext4/extents.c                          |   8 +-
 fs/ext4/extents_status.c                   |  28 +-
 fs/ext4/fast_commit.c                      |   8 +-
 fs/ext4/ialloc.c                           |  10 +-
 fs/ext4/indirect.c                         |   2 +-
 fs/ext4/inline.c                           |  14 +-
 fs/ext4/inode.c                            |  22 +-
 fs/ext4/ioctl.c                            |   4 +-
 fs/ext4/mballoc.c                          |   6 +-
 fs/ext4/migrate.c                          |   2 +-
 fs/ext4/move_extent.c                      |  20 +-
 fs/ext4/namei.c                            |  10 +-
 fs/ext4/orphan.c                           |  16 +-
 fs/ext4/page-io.c                          |  10 +-
 fs/ext4/super.c                            |  22 +-
 fs/ext4/xattr.c                            |  10 +-
 fs/f2fs/compress.c                         |   4 +-
 fs/f2fs/dir.c                              |   2 +-
 fs/f2fs/extent_cache.c                     |   8 +-
 fs/f2fs/f2fs.h                             |   6 +-
 fs/f2fs/file.c                             |  12 +-
 fs/f2fs/gc.c                               |   2 +-
 fs/f2fs/inline.c                           |   4 +-
 fs/f2fs/inode.c                            |  48 +--
 fs/f2fs/namei.c                            |   8 +-
 fs/f2fs/node.c                             |  12 +-
 fs/f2fs/recovery.c                         |  10 +-
 fs/f2fs/xattr.c                            |  10 +-
 fs/freevxfs/vxfs_bmap.c                    |   4 +-
 fs/fserror.c                               |   2 +-
 fs/hfs/catalog.c                           |   2 +-
 fs/hfs/extent.c                            |   4 +-
 fs/hfs/inode.c                             |   4 +-
 fs/hfsplus/attributes.c                    |  10 +-
 fs/hfsplus/catalog.c                       |   2 +-
 fs/hfsplus/dir.c                           |   6 +-
 fs/hfsplus/extents.c                       |   6 +-
 fs/hfsplus/inode.c                         |   8 +-
 fs/hfsplus/super.c                         |   6 +-
 fs/hfsplus/xattr.c                         |  10 +-
 fs/hpfs/dir.c                              |   4 +-
 fs/hpfs/dnode.c                            |   4 +-
 fs/hpfs/ea.c                               |   4 +-
 fs/hpfs/inode.c                            |   4 +-
 fs/inode.c                                 |  49 ++-
 fs/iomap/ioend.c                           |   2 +-
 fs/iomap/trace.h                           |   8 +-
 fs/isofs/compress.c                        |   2 +-
 fs/isofs/dir.c                             |   2 +-
 fs/isofs/inode.c                           |   8 +-
 fs/isofs/namei.c                           |   2 +-
 fs/jbd2/journal.c                          |   4 +-
 fs/jbd2/transaction.c                      |   2 +-
 fs/jffs2/dir.c                             |   4 +-
 fs/jffs2/file.c                            |   4 +-
 fs/jffs2/fs.c                              |  18 +-
 fs/jfs/inode.c                             |   2 +-
 fs/jfs/jfs_imap.c                          |   2 +-
 fs/jfs/jfs_metapage.c                      |   2 +-
 fs/lockd/svclock.c                         |   8 +-
 fs/lockd/svcsubs.c                         |   2 +-
 fs/locks.c                                 |   6 +-
 fs/minix/inode.c                           |  10 +-
 fs/nfs/dir.c                               |  20 +-
 fs/nfs/file.c                              |   8 +-
 fs/nfs/filelayout/filelayout.c             |   8 +-
 fs/nfs/flexfilelayout/flexfilelayout.c     |   8 +-
 fs/nfs/inode.c                             |   6 +-
 fs/nfs/nfs4proc.c                          |   4 +-
 fs/nfs/pnfs.c                              |  12 +-
 fs/nfsd/export.c                           |   2 +-
 fs/nfsd/nfs4state.c                        |   4 +-
 fs/nfsd/nfsfh.c                            |   4 +-
 fs/nfsd/vfs.c                              |   2 +-
 fs/nilfs2/alloc.c                          |  10 +-
 fs/nilfs2/bmap.c                           |  17 +-
 fs/nilfs2/btnode.c                         |   2 +-
 fs/nilfs2/btree.c                          |  12 +-
 fs/nilfs2/dir.c                            |  12 +-
 fs/nilfs2/direct.c                         |   4 +-
 fs/nilfs2/gcinode.c                        |   2 +-
 fs/nilfs2/inode.c                          |   8 +-
 fs/nilfs2/mdt.c                            |   2 +-
 fs/nilfs2/namei.c                          |   2 +-
 fs/nilfs2/segment.c                        |   2 +-
 fs/notify/fdinfo.c                         |   4 +-
 fs/nsfs.c                                  |   4 +-
 fs/ntfs3/super.c                           |   2 +-
 fs/ocfs2/alloc.c                           |   2 +-
 fs/ocfs2/aops.c                            |   4 +-
 fs/ocfs2/dir.c                             |   8 +-
 fs/ocfs2/dlmfs/dlmfs.c                     |  10 +-
 fs/ocfs2/extent_map.c                      |  12 +-
 fs/ocfs2/inode.c                           |   2 +-
 fs/ocfs2/quota_local.c                     |   2 +-
 fs/ocfs2/refcounttree.c                    |  10 +-
 fs/ocfs2/xattr.c                           |   4 +-
 fs/orangefs/inode.c                        |   2 +-
 fs/overlayfs/export.c                      |   2 +-
 fs/overlayfs/namei.c                       |   4 +-
 fs/overlayfs/util.c                        |   2 +-
 fs/pipe.c                                  |   2 +-
 fs/proc/fd.c                               |   2 +-
 fs/proc/task_mmu.c                         |   4 +-
 fs/qnx4/inode.c                            |   4 +-
 fs/qnx6/inode.c                            |   2 +-
 fs/ubifs/debug.c                           |   8 +-
 fs/ubifs/dir.c                             |  28 +-
 fs/ubifs/file.c                            |  28 +-
 fs/ubifs/journal.c                         |   6 +-
 fs/ubifs/super.c                           |  16 +-
 fs/ubifs/tnc.c                             |   4 +-
 fs/ubifs/xattr.c                           |  14 +-
 fs/udf/directory.c                         |  18 +-
 fs/udf/file.c                              |   2 +-
 fs/udf/inode.c                             |  12 +-
 fs/udf/namei.c                             |   8 +-
 fs/udf/super.c                             |   2 +-
 fs/ufs/balloc.c                            |   6 +-
 fs/ufs/dir.c                               |  10 +-
 fs/ufs/ialloc.c                            |   6 +-
 fs/ufs/inode.c                             |  18 +-
 fs/ufs/ufs_fs.h                            |   6 +-
 fs/ufs/util.c                              |   2 +-
 fs/verity/init.c                           |   2 +-
 fs/zonefs/super.c                          |   8 +-
 fs/zonefs/trace.h                          |  18 +-
 include/linux/audit.h                      |   2 +-
 include/linux/fs.h                         |  88 +++--
 include/net/sock.h                         |   4 +-
 include/trace/events/cachefiles.h          |  18 +-
 include/trace/events/ext4.h                | 544 ++++++++++++++---------------
 include/trace/events/f2fs.h                | 242 ++++++-------
 include/trace/events/filelock.h            |  34 +-
 include/trace/events/filemap.h             |  20 +-
 include/trace/events/fs_dax.h              |  20 +-
 include/trace/events/fsverity.h            |  30 +-
 include/trace/events/hugetlbfs.h           |  42 +--
 include/trace/events/netfs.h               |   8 +-
 include/trace/events/nilfs2.h              |  12 +-
 include/trace/events/readahead.h           |  18 +-
 include/trace/events/timestamp.h           |  16 +-
 include/trace/events/writeback.h           | 162 ++++-----
 kernel/audit.h                             |  13 +-
 kernel/audit_fsnotify.c                    |   4 +-
 kernel/audit_watch.c                       |  12 +-
 kernel/auditsc.c                           |   4 +-
 kernel/events/uprobes.c                    |   4 +-
 net/ax25/af_ax25.c                         |   2 +-
 net/bluetooth/af_bluetooth.c               |   4 +-
 net/can/bcm.c                              |   2 +-
 net/ipv4/ping.c                            |   2 +-
 net/ipv4/raw.c                             |   2 +-
 net/ipv4/tcp_ipv4.c                        |   2 +-
 net/ipv4/udp.c                             |   2 +-
 net/ipv6/datagram.c                        |   2 +-
 net/ipv6/tcp_ipv6.c                        |   2 +-
 net/key/af_key.c                           |   2 +-
 net/netlink/af_netlink.c                   |   2 +-
 net/netlink/diag.c                         |   2 +-
 net/netrom/af_netrom.c                     |   4 +-
 net/packet/af_packet.c                     |   2 +-
 net/packet/diag.c                          |   2 +-
 net/phonet/socket.c                        |   4 +-
 net/rose/af_rose.c                         |   4 +-
 net/sctp/proc.c                            |   4 +-
 net/socket.c                               |   2 +-
 net/unix/af_unix.c                         |   2 +-
 net/unix/diag.c                            |   6 +-
 net/x25/x25_proc.c                         |   4 +-
 net/xdp/xsk_diag.c                         |   2 +-
 security/apparmor/apparmorfs.c             |   4 +-
 security/integrity/evm/evm_crypto.c        |   6 +
 security/integrity/integrity_audit.c       |   2 +-
 security/ipe/audit.c                       |   2 +-
 security/lsm_audit.c                       |  10 +-
 security/selinux/hooks.c                   |  10 +-
 security/smack/smack_lsm.c                 |  12 +-
 222 files changed, 1331 insertions(+), 1321 deletions(-)
