Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358549;
	b=TacnNIuuHtHXjSy35dm03Zm2kdFgIVlEuoCuOrdZzL+z48HOwthRuuxiZmolPAmSzsYC
	 sxfKKtk5soRCcXGVOxfT9mgVVpqI9G+twB1BFOgH6y27Z4xmjwPX7mJQPSNQaDFV/BUqZ
	 M3kcAqlRE54CDp8UyFYTTRA8FtI7bO716nj3RlBX7CZwlESe5yJQXFzjBJ3oyZhGT3x8O
	 z1CR+q0nDrOiEbf6n86dv8C7CdnKJidhH8TCtqwUnr+0qpAtzu8sXnVs6VjNeukV+hDmJ
	 XVhXGH8/2PPRhVl6udPtjkBALokJss2Q/VIKDjWhF7B/hKxQNP3g5LRCBiltysKDKiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=A9Zv9/kAKHCUlo9CcVpDmVuBqMvgg3njmRLSGR1Brgo=;
	b=2+O6gkkm74bpBwZrMBUVQMNzNrepgfTOBH1r8pTswx9cnrq2c0YzIJ2ZVH5+oB7FgJZ9
	 sycmbemw2+sTwetmCv6iX/bfQHkZVcrv4wAcLdnYidNcMyVzg27gCNZDhP9MnLkZ2uUnj
	 XCohNyaR5hFDVQCqQ2fEpwIXR4ztHR4t7Ii/3ZlRtjbHp3/3a5zPnOVDmf+/ZcsWXycwx
	 nxquZXnWmHqh+SI5GAXvOYQIt9FMrPzJdtPbEzurFQgi1HHf3XbLyIxaXhuHB2c2ieKhp
	 NXCr+zYe9DrHQzyqFk6ZyVujM8SioKOpoZOh0j/A+tGXpYgUPsp+LhnmTyvc/on73dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YjX/aBFC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A4606A320;
	Sun, 22 Nov 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YjX/aBFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB7E1F000CF;
	Sun, 22 Nov 2026 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795358549;
	bh=A9Zv9/kAKHCUlo9CcVpDmVuBqMvgg3njmRLSGR1Brgo=;
	h=From:To:Cc:Subject:Date;
	b=YjX/aBFCLTcPVlxSkksvyJOHUAfodAEh331vWXoHlUEuRD3kINsUaPS2nOvn/wXFm
	 06wTxh7RFH8fDWSoruNrGw0TKsagL3T9aIyV37erAd5iIS8RH7vfSz3xC2DezvDRLa
	 qkvgIcXE8sop21EtRcW13KUBeBMgPFN0VKH6hKBLSg8SQXm2FzQrRw/n44ZIqbeGCE
	 gJgOs7KnAOwjj8FHWFQSF5xYrsKijeMOwvEydgzPuyQza1Y/NKu9QazdfOtsNgRFXY
	 ZvNe43wv1mw+N1pJS3o0MCd08F0vjWJb92SIouEazdiSQH2fZpsW0v+O8y2yLt6rDo
	 YFwXuubhX8xSQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.4] vfs fixes
Date: Sun, 22 Nov 2026 15:41:36 +0100
Message-ID: <20261122-vfs-7.4-rc4.fixes-0bcebc1aae75@brauner>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16153; i=brauner@kernel.org; h=from:subject:message-id; bh=Vh2t7QqbU+Kdwrj3MuWNopd+CuPBIrluq/btsqLmWIY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQz/Xc7Zspx6/8NpojZPxmt34fsTDIJ4FuRmp3/9dPZG IaIp1nXO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyn5Xhf3D/4zdedx7Gb/XN /8398XPGrvWeuyMUd2vdEa409j/zazkjw3+HnVzL+857PDyn8+unpPq7hDWXftmkq/z5P3fK5sR mHQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains fixes for the current development cycle.

This contains the procfs fixes from the procfs rework I've been doing.
I've mentioned this on the list. If you'd rather take the fixes during
the merge window, let me know:

  Fix a lot of old bugs in procfs and in /proc handlers all over the
  tree. They turned up while reviewing just about every ->proc_read(),
  ->proc_write() and ->proc_ioctl() for moving procfs to what kernfs
  does.

  * Resume readdir after the last name it returned instead of at a
    counted position for both /proc and /proc/sys.

    An entry that was added or removed between two getdents64() calls
    made caused one entry to be repated or skipped. /proc/sys readdir
    now also skips an entry that is being unregistered instead of
    reporting end of the directory.

  * Don't hold the sysctl table while read(), write() and getdents64()
    of /proc/sys copy to or from userspace, and don't pin a /proc
    symlink's entry while readlink() copies it out. A copy that faults
    for as long as userspace wants held up unregister_sysctl_table() or
    remove_proc_entry(), whose callers hold locks such as RTNL in
    addrconf and snd_card_mutex in ALSA.

  * Treat a non-directory like a missing directory when resolving a
    name.

  * make pktgen refuse device names with a '/' or that are taken

  * make pktgen let go of a renamed device when it is unregistered
    instead of leaving unregister_netdevice() waiting forever

  * Queue the pollers of the sunrpc channel files on a single static
    wait queue again to fix a uaf.

  * Refuse to map procfs files on NOMMU.

  * Bound the lengths of the esas2r HBA, SMP and firmware ioctls by the
    struct they were copied into and stop copying kernel pointers out.

  * Keep the position of the PCI and isapnp config space files in a
    loff_t.

  * Remove /proc/driver/rtc before taking ops_lock.

  * Let proc_remove() remove the entry it was given instead of whatever
    has its name now.

  * Fix the /proc handlers of ALSA, powerpc, xtensa, scsi, PNP, s390,
    sparc, um, zorro, toshiba_acpi, libipw, lockd, ntfs3, psi and
    profiling. Several of them read past or in front of their buffers,
    handed out uninitialized or freed memory, dropped the last byte of a
    write, consumed only part of one or returned 0 from it.

- fs: Stop resetting userspace_init_fs to nullfs when PID 1 stops
  sharing it to fix an Android regression.

- ns: mark internal mount namespaces from mount_subtree() so they're not
  denied.

- nfs: Reintroduce SB_I_MULTIROOT and raise it again on the superblocks
  nfs may share between mounts of disjoint subtrees. The flag was lost
  in the conversion to the new mount api in v5.6 and removed as unused
  in v5.10. So ".." could walk out of an NFSv2/NFSv3 mount and out of a
  chroot again once a directory was moved into the other mount's
  subtree.

- fhandle: Only warn in vfs_dentry_acceptable() when the walk up from a
  decoded directory ends at a disconnected dentry.

- cachefiles: Size the buffer in cachefiles_preset_object_xattr() with
  max() instead of min().

- ext4: Remember the file before submitting a direct read instead of
  taking it from the kiocb afterwards.

- signal: Walk the threads in complete_signal() with
  list_next_entry_circular() instead of next_thread().

- iomap: Cast the page index to loff_t before shifting it in
  iomap_fill_dirty_folios().

- xattr: Require the inode owner or CAP_FOWNER to write user.* xattrs on
  sockets.

- devpts: Create pty nodes with simple_start_creating() under the inode
  lock of the devpts root, like mknod_ptmx() does.

- kernfs: Clear i_nlink of a removed node's inodes before deactivating
  the node. A lookup that killed the dentry in between still saw i_nlink
  at 1, so inotify never sent IN_DELETE_SELF.

- fork: Call copy_exec_state() right before copy_creds() again so it
  can't fail before rt_mutex_init_task() reset the PI state copied from
  the parent.

- iov_iter: Check the alignment of what iov_iter_extract_bvecs()
  actually extracts.

- shmem: Let the remaining reservation instead of the current inode
  limit decide whether shmem_initxattrs() consumes the space reserved
  for an xattr.

- bdev: Report the block size as st_blksize when it is larger than the
  minimum I/O size.

- fuse: Add IOP_SET_ACL_OWNER_CHECK so fuse_set_acl() can do the ACL
  owner check itself and skip it without default_permissions.

- stat: Reject unsupported flags such as AT_RECURSIVE in the
  AT_EMPTY_PATH fast paths of fstatat() and statx().

- exit: Read mm->owner with READ_ONCE() in mm_update_next_owner() to
  match the WRITE_ONCE() on the other side.

- pipe: Annotate the lockless checks of pipe->files in pipe_lock() and
  pipe_unlock() for KCSAN.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 7e1392a42ea288d70a266f6553fe06f57f8647ea:

  Merge tag 'net-7.4-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-11-12 12:26:14 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc4.fixes

for you to fetch changes up to d5b84d3d7e902c44b05b106718c579f3d3834812:

  ext4: don't use the kiocb after a direct read was queued (2026-11-22 11:24:12 +0100)

----------------------------------------------------------------
vfs-7.4-rc4.fixes

Please consider pulling these changes from the signed vfs-7.4-rc4.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Andrew Morton (1):
      shmem: consume the reserved xattr space despite remount

Avi Weiss (1):
      fs/stat: reject invalid flags for empty paths

Christian Aurich Zanettini Martins (1):
      fork: Don't let copy_exec_state() fail before rt_mutex_init_task()

Christian Brauner (65):
      scsi: esas2r: don't copy kernel pointers out in EXPRESS_IOCTL_GET_MOD_INFO
      ALSA: cs46xx: hand the region to the region proc files
      PNP: isapnp: don't go on when isapnp_cfg_begin() fails
      xtensa: simdisk: remove the proc entry before the disk
      powerpc/pseries: put the node that the ofdt property commands look up
      lockd: don't hand out the terminator of nlm_end_grace
      powerpc/pseries/lparcfg: don't drop the last byte of a write
      profiling: report it when /proc/profile can't be created
      zorro: size the proc files like what they serve
      sparc: led: consume the whole write
      powerpc/rtas: consume the whole write to /proc/powerpc/rtas/progress
      sched/psi: don't drop the last byte of a trigger write
      ALSA: info: keep what was written when a text entry's buffer grows
      rtc: don't remove /proc/driver/rtc with ops_lock held
      proc: sysctl: don't stop readdir at an entry that is being unregistered
      PCI/proc: don't truncate the position of config space accesses
      PNP: isapnp: don't read past the end of the buffer on a large pread()
      s390/dasd: don't look in front of the buffer on an empty write
      platform/x86: toshiba_acpi: reject malformed brightness and fan writes
      xtensa: simdisk: don't read the file name without the lock
      powerpc/rtas_flash: don't read past the validate message
      powerpc/rtasd: zero the error log buffer
      ALSA: info: don't write past the end of a data entry
      scsi: BusLogic: don't return 0 from writes to the proc file
      scsi: ips: don't return 0 from writes to the proc file
      wifi: libipw: don't return 0 from writes to debug_level
      scsi: core: NUL-terminate what is written to the host proc files
      um: NUL-terminate what is written to /proc/exitcode
      ntfs3: don't warn when a huge label is written
      proc: don't walk through a non-directory when resolving a name
      net: pktgen: reject device names with a '/'
      net: pktgen: don't register a device file under a name that is taken
      net: pktgen: let go of a renamed device when it is unregistered
      proc: resume readdir after the last name it returned
      selftests/proc: check a /proc listing while entries come and go
      proc: let proc_remove() remove the entry it was given
      proc: warn about entries left in /proc/net of a dying namespace
      proc: don't let NOMMU map procfs files
      proc/vmcore: don't let vmcore_cleanup() run twice at once
      sunrpc: make queue_wait a global wait queue again
      scsi: esas2r: bound the lengths of the HBA, SMP and firmware ioctls
      powerpc/pseries: bound the lengths in the ofdt property parser
      powerpc/pseries/lparcfg: return h_get_ppp()'s status as a long
      proc: sysctl: resume readdir after the last name it returned
      selftests/proc: check a sysctl listing while entries come and go
      proc: sysctl: copy to and from userspace without holding the table
      proc: sysctl: look at the table under sysctl_lock when creating an inode
      proc: sysctl: don't hold the tables while readdir copies to userspace
      selftests/proc: check that faulting sysctl accesses don't hold up removal
      proc: don't pin a symlink's entry while readlink() copies it out
      selftests/proc: check that a faulting readlink() doesn't hold up removal
      Merge patch series "proc: fix a few old bugs in /proc handlers (Part 1/7)"
      devpts: create pty nodes under the parent lock
      cachefiles: fix buffer size in cachefiles_preset_object_xattr()
      fs: reintroduce SB_I_MULTIROOT
      fhandle: only warn about disconnected directories
      Merge patch series "fs: reintroduce SB_I_MULTIROOT"
      fs: let pivot_root() move userspace_init_fs when nobody shares it
      fs: don't reset userspace_init_fs when PID 1 stops sharing it
      Merge patch series "fs: don't reset userspace_init_fs when PID 1 stops sharing it"
      mount: pass flags to alloc_mnt_ns()
      ns: don't call the namespace LSM hooks for kernel-internal namespaces
      Merge patch series "ns: don't call the namespace LSM hooks for kernel-internal namespaces"
      kernfs: clear i_nlink before deactivating removed nodes
      ext4: don't use the kiocb after a direct read was queued

Daehyeon Ko (1):
      iov_iter: validate extracted segment for bvec alignment

Dominik Maier (1):
      xattr: require inode owner or CAP_FOWNER to write user.* xattrs on sockets

Hengyu Liang (1):
      bdev: do not report a statx block size below the block size

Hristos Nenkov (1):
      fuse: preserve daemon-owned ACL permission decisions

Mani Tofigh (1):
      exit: use READ_ONCE() to read mm->owner

Oleg Nesterov (1):
      signal: fix lockup in complete_signal() racing with mt exec

Shashank Mohan Jain (1):
      iomap: fix offset truncation in iomap_fill_dirty_folios() on 32-bit

Zhu Jun (1):
      pipe: annotate lockless checks of the file count

 arch/powerpc/kernel/rtas-proc.c                    |   3 +-
 arch/powerpc/kernel/rtas_flash.c                   |   2 +-
 arch/powerpc/kernel/rtasd.c                        |   2 +-
 arch/powerpc/platforms/pseries/lparcfg.c           |   7 +-
 arch/powerpc/platforms/pseries/reconfig.c          |  24 +-
 arch/sparc/kernel/led.c                            |   3 +-
 arch/um/kernel/exitcode.c                          |   3 +-
 arch/xtensa/platforms/iss/simdisk.c                |  28 +-
 block/bdev.c                                       |   6 +-
 drivers/net/wireless/intel/ipw2x00/libipw_module.c |   2 +-
 drivers/pci/proc.c                                 |  22 +-
 drivers/platform/x86/toshiba_acpi.c                |   8 +-
 drivers/pnp/isapnp/core.c                          |  16 +-
 drivers/pnp/isapnp/proc.c                          |  11 +-
 drivers/rtc/class.c                                |   3 +-
 drivers/s390/block/dasd.c                          |   2 +-
 drivers/scsi/BusLogic.c                            |   2 +-
 drivers/scsi/esas2r/esas2r.h                       |   2 +-
 drivers/scsi/esas2r/esas2r_ioctl.c                 |  48 ++-
 drivers/scsi/esas2r/esas2r_main.c                  |   3 +-
 drivers/scsi/ips.c                                 |   2 +-
 drivers/scsi/scsi_proc.c                           |  16 +-
 drivers/zorro/proc.c                               |   2 +-
 fs/cachefiles/xattr.c                              |   2 +-
 fs/devpts/inode.c                                  |   8 +-
 fs/ext4/file.c                                     |   6 +-
 fs/fhandle.c                                       |   5 +-
 fs/fs_struct.c                                     |  72 ++--
 fs/fuse/acl.c                                      |   9 +
 fs/fuse/inode.c                                    |   6 +
 fs/iomap/buffered-io.c                             |   2 +-
 fs/kernfs/dir.c                                    |  12 +-
 fs/lockd/procfs.c                                  |   2 +-
 fs/namei.c                                         |   4 +-
 fs/namespace.c                                     |  31 +-
 fs/nfs/super.c                                     |   2 +
 fs/ntfs3/super.c                                   |  11 +-
 fs/pipe.c                                          |   4 +-
 fs/posix_acl.c                                     |   3 +-
 fs/proc/generic.c                                  | 164 +++++++--
 fs/proc/inode.c                                    |  38 +-
 fs/proc/internal.h                                 |   1 +
 fs/proc/proc_net.c                                 |  10 +
 fs/proc/proc_sysctl.c                              | 394 ++++++++++++++-------
 fs/proc/root.c                                     |   1 +
 fs/proc/vmcore.c                                   |   5 +
 fs/stat.c                                          |  11 +-
 fs/xattr.c                                         |  10 +-
 include/linux/fs.h                                 |   2 +
 include/linux/fs/super_types.h                     |   1 +
 include/linux/ns/ns_common_types.h                 |   2 +
 include/linux/ns_common.h                          |  20 +-
 include/linux/sunrpc/cache.h                       |   1 -
 kernel/exit.c                                      |   2 +-
 kernel/fork.c                                      |  10 +-
 kernel/nscommon.c                                  |   9 +-
 kernel/profile.c                                   |   8 +-
 kernel/sched/psi.c                                 |   4 +-
 kernel/signal.c                                    |   3 +-
 lib/iov_iter.c                                     |   9 +-
 mm/shmem.c                                         |   2 +-
 net/core/pktgen.c                                  | 115 ++++--
 net/sunrpc/cache.c                                 |  12 +-
 sound/core/info.c                                  |   5 +
 sound/isa/es18xx.c                                 |   6 +-
 sound/pci/cs46xx/cs46xx_lib.c                      |   2 +-
 tools/testing/selftests/proc/.gitignore            |   4 +
 tools/testing/selftests/proc/Makefile              |   4 +
 tools/testing/selftests/proc/config                |   9 +
 tools/testing/selftests/proc/proc-readdir-churn.c  | 333 +++++++++++++++++
 .../selftests/proc/proc-remove-slow-readlink.c     | 191 ++++++++++
 .../selftests/proc/proc-remove-slow-sysctl.c       | 215 +++++++++++
 .../selftests/proc/proc-sysctl-readdir-churn.c     | 152 ++++++++
 73 files changed, 1740 insertions(+), 411 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-readdir-churn.c
 create mode 100644 tools/testing/selftests/proc/proc-remove-slow-readlink.c
 create mode 100644 tools/testing/selftests/proc/proc-remove-slow-sysctl.c
 create mode 100644 tools/testing/selftests/proc/proc-sysctl-readdir-churn.c
