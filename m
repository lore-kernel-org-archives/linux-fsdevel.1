Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2263DC4A6;
	Fri, 10 Apr 2026 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834625; cv=none; b=U7tQKo149MeYhjbxmdMQp80Ftj0XNqXv60vG7SWq5MXy2YkkrxSyOMTHVD4foV/OX1xS5WShBYg5lFU7Z5rm9R0Kr7oAwamuhgxgqDsJuC5SJK/TkUYueQTkUsY/qeZy1WgwpaCwKymX3Vqfj/MAQ+JQ3RdapIgeFQct1mLVeeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834625; c=relaxed/simple;
	bh=ETpBAL/n0DjV4OTJ4K4SP05h/6QpW/RNFrMDlIXHzDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxMhcBSmJ4R1DpOsE5wHQ0BobCW33XyAMWTIg/zr2xNtx9UfTqpyj/K/imVjDLduwE4y1rq35UHb9Jf3rbROoSLr7cTf2kIeUKwTJLZtnJjcXRSmAi4/kIdLhrUAoJWNI0cCZKplABDirZgr/gS/Qa4qmwb8YuZ2jegvVFdz8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vlkq4U8F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vlkq4U8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85813C2BC87;
	Fri, 10 Apr 2026 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834624;
	bh=ETpBAL/n0DjV4OTJ4K4SP05h/6QpW/RNFrMDlIXHzDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vlkq4U8F+PCYEaoUjrvdV49W2VnDNLF4YuBPbJRrE9nciDLWF+Wz2xzFVYNr5zHsq
	 ujD8sPQfl7HA3DRfaeezJFh9fHPYNFRwHPAU7vpeVk25uN2hXXW/JpI8U65GKdyEW4
	 ALSAZ9gUtDQhVcpCAXhXRHTWWb4heeYb8fbMMNR0gX5pt4JroM87/RGxtgAEdvtqsu
	 EDELgXlkMSKOPPt9zMZOcd2t8c1dWLjbGRZ9fUBUt/pZP+ZlShSvLjIY2WA+UNtzgo
	 NC6NOV4cDlKaPbz8Pd4j/TzBfEgXO0xy+eaIovvF0VI0P8owCF9uDORz9xJW+kt2wE
	 rhJUzilv0MYpg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 12/12 for v7.1] vfs misc
Date: Fri, 10 Apr 2026 17:23:30 +0200
Message-ID: <20260410-vfs-misc-v71-40d5c75a1f66@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8312; i=brauner@kernel.org; h=from:subject:message-id; bh=ETpBAL/n0DjV4OTJ4K4SP05h/6QpW/RNFrMDlIXHzDQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFP0TIR+Zlti+51RDScaBc4mxAYF3Qk8ELzfl3rb9a zfz8tOZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZzs7I8C7w/XxJpysiD18F pVzx63sWN3mN/J6oKqlll9f5TdBars/IcGRj46lv33Y+Dsn4KXmf5yH/xosTu4uedG3aN43hFte Ms2wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Features

  - coredump: add tracepoint for coredump events
  - fs: hide file and bfile caches behind runtime const machinery

Fixes

  - fix architecture-specific compat_ftruncate64 implementations
  - dcache: Limit the minimal number of bucket to two
  - fs/omfs: reject s_sys_blocksize smaller than OMFS_DIR_START
  - fs/mbcache: cancel shrink work before destroying the cache
  - dcache: permit dynamic_dname()s up to NAME_MAX

Cleanups

  - remove or unexport unused fs_context infrastructure
  - trivial ->setattr cleanups
  - selftests/filesystems: Assume that TIOCGPTPEER is defined
  - writeback: fix kernel-doc function name mismatch for wb_put_many()
  - autofs: replace manual symlink buffer allocation in autofs_dir_symlink
  - init/initramfs.c: trivial fix: FSM -> Finite-state machine
  - fs: remove stale and duplicate forward declarations
  - readdir: Introduce dirent_size()
  - fs: Replace user_access_{begin/end} by scoped user access
  - kernel: acct: fix duplicate word in comment
  - fs: write a better comment in step_into() concerning .mnt assignment
  - fs: attr: fix comment formatting and spelling issues

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

[1]: https://lore.kernel.org/linux-next/adO9szS5_I7TmAjz@sirena.org.uk

This has a merge conflict with:
[1]: https://lore.kernel.org/20260410-vfs-kino-v71-672d31bc705c@brauner

diff --cc fs/affs/inode.c
index e03e9f109ff9,f660e76584b3..000000000000
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@@ -219,7 -218,7 +218,7 @@@ affs_setattr(struct mnt_idmap *idmap, s
        struct inode *inode = d_inode(dentry);
        int error;

-       pr_debug("notify_change(%llu,0x%x)\n", inode->i_ino, attr->ia_valid);
 -      pr_debug("setattr(%lu,0x%x)\n", inode->i_ino, attr->ia_valid);
++      pr_debug("setattr(%llu,0x%x)\n", inode->i_ino, attr->ia_valid);

        error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
        if (error)

The following changes since commit 9702969978695d9a699a1f34771580cdbb153b33:

  Merge tag 'slab-for-7.0-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab (2026-02-16 13:41:38 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.misc

for you to fetch changes up to 97b67e64affb0e709eeecc50f6a9222fc20bd14b:

  dcache: permit dynamic_dname()s up to NAME_MAX (2026-04-07 12:32:22 +0200)

----------------------------------------------------------------
vfs-7.1-rc1.misc

Please consider pulling these changes from the signed vfs-7.1-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Aleksa Sarai (1):
      dcache: permit dynamic_dname()s up to NAME_MAX

Askar Safin (1):
      init/initramfs.c: trivial fix: FSM -> Finite-state machine

Breno Leitao (1):
      coredump: add tracepoint for coredump events

Chelsy Ratnawat (1):
      fs: attr: fix comment formatting and spelling issues

Christian Brauner (3):
      Merge patch series "remove or unexport unused fs_conext infrastructure"
      Merge patch series "fix architecture-specific compat_ftruncate64 implementations"
      Merge patch series "trivial ->setattr cleanups"

Christoph Hellwig (12):
      fs: mark bool_names static
      fs: remove fsparam_blob / fs_param_is_blob
      fs: remove fsparam_path / fs_param_is_path
      fs: unexport fs_context_for_reconfigure
      fs: fix archiecture-specific compat_ftruncate64
      fs: pass on FTRUNCATE_* flags to do_truncate
      fs: remove do_sys_truncate
      hfs: update comments on hfs_inode_setattr
      adfs: rename adfs_notify_change to adfs_setattr
      affs: rename affs_notify_change to affs_setattr
      proc: rename proc_setattr to proc_nochmod_setattr
      proc: rename proc_notify_change to proc_setattr

Christophe Leroy (CS GROUP) (2):
      readdir: Introduce dirent_size()
      fs: Replace user_access_{begin/end} by scoped user access

HyungJung Joo (2):
      fs/omfs: reject s_sys_blocksize smaller than OMFS_DIR_START
      fs/mbcache: cancel shrink work before destroying the cache

Kit Dallege (1):
      writeback: fix kernel-doc function name mismatch for wb_put_many()

Mark Brown (1):
      selftests/filesystems: Assume that TIOCGPTPEER is defined

Mateusz Guzik (2):
      fs: write a better comment in step_into() concerning .mnt assignment
      fs: hide file and bfile caches behind runtime const machinery

Thorsten Blum (1):
      autofs: replace manual symlink buffer allocation in autofs_dir_symlink

Yuto Ohnuki (1):
      fs: remove stale and duplicate forward declarations

Zhihao Cheng (1):
      dcache: Limit the minimal number of bucket to two

haoyu.lu (1):
      kernel: acct: fix duplicate word in comment

 Documentation/filesystems/mount_api.rst          |   4 -
 arch/arm64/kernel/sys32.c                        |   2 +-
 arch/mips/kernel/linux32.c                       |   2 +-
 arch/parisc/kernel/sys_parisc.c                  |   4 +-
 arch/powerpc/kernel/sys_ppc32.c                  |   2 +-
 arch/sparc/kernel/sys_sparc32.c                  |   2 +-
 arch/x86/kernel/sys_ia32.c                       |   3 +-
 fs/adfs/adfs.h                                   |   4 +-
 fs/adfs/dir.c                                    |   2 +-
 fs/adfs/file.c                                   |   2 +-
 fs/adfs/inode.c                                  |   6 +-
 fs/affs/affs.h                                   |   2 +-
 fs/affs/dir.c                                    |   2 +-
 fs/affs/file.c                                   |   2 +-
 fs/affs/inode.c                                  |   5 +-
 fs/affs/symlink.c                                |   2 +-
 fs/attr.c                                        |   6 +-
 fs/autofs/root.c                                 |   8 +-
 fs/coredump.c                                    |   5 ++
 fs/d_path.c                                      |  11 +--
 fs/dcache.c                                      |   4 +-
 fs/file.c                                        |   2 +-
 fs/file_table.c                                  |  31 ++++---
 fs/fs_context.c                                  |   1 -
 fs/fs_parser.c                                   |  19 +----
 fs/hfs/inode.c                                   |  21 +----
 fs/internal.h                                    |   3 +-
 fs/mbcache.c                                     |   1 +
 fs/namei.c                                       |   2 +-
 fs/omfs/inode.c                                  |   6 ++
 fs/open.c                                        |  40 +++++----
 fs/proc/base.c                                   |  22 ++---
 fs/proc/fd.c                                     |   6 +-
 fs/proc/generic.c                                |   8 +-
 fs/proc/internal.h                               |   4 +-
 fs/proc/namespaces.c                             |   4 +-
 fs/proc/proc_net.c                               |   2 +-
 fs/readdir.c                                     | 103 +++++++++--------------
 fs/select.c                                      |  35 +++-----
 include/asm-generic/vmlinux.lds.h                |   4 +-
 include/linux/backing-dev-defs.h                 |   2 +-
 include/linux/blkdev.h                           |   1 +
 include/linux/fs.h                               |   3 -
 include/linux/fs_parser.h                        |   8 +-
 include/linux/syscalls.h                         |  16 +---
 include/trace/events/coredump.h                  |  45 ++++++++++
 init/initramfs.c                                 |   2 +-
 io_uring/truncate.c                              |   2 +-
 kernel/acct.c                                    |   2 +-
 tools/testing/selftests/filesystems/devpts_pts.c |   2 -
 50 files changed, 225 insertions(+), 252 deletions(-)
 create mode 100644 include/trace/events/coredump.h
