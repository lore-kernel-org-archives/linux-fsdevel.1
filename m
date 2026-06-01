Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D92D7814;
	Mon,  1 Jun 2026 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322219; cv=none; b=MrC1pUbcV3BNjp8xTZ3jyYj4sjtvnt3URG1MjKFZZEaaaLYywq5lu9yhRTAlBHdw+XiuztR+U9w8O7Mrf82FFT7gJPI7HldEtwFI7wCy1zOs8xR4xo7qckAwP5jlYP138uKK5pS9Fy/Cb410xwKLFsMKPXF/uX6bJNQWLh6gJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322219; c=relaxed/simple;
	bh=JtS6J8SxWmAh6kWD5QGWi8fkf/zgSMN2YoENzDzlA1Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dIeETyutJX8VASDmAeNp15ZGEyHU7q6J0h+kOM6NR3HXPE/AATHhTRu9CfiwyS76bfnYl+0C2ZzeWUHyguKDNdnkyqrqC3LEIqhaQ4NTKWSGbtkoxEuZhIHMQ68S8rAkFuzjnBiKH+TWi3n3IolADe5vqRAD9HMLXS8bGc3UnF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjqjKJSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjqjKJSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39761F00893;
	Mon,  1 Jun 2026 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322217;
	bh=3NBNXmITv16VsYJc3tQz0dH0tJj94jdEQmhYRU1ij3Q=;
	h=From:Subject:Date:To:Cc;
	b=SjqjKJSgeeG39TYlIyrldgJL/Jlp2qgegbjLOPBX5A45Je/bXGLVWdaxiWILcp5f8
	 JvPYRU92bOsmCOEO279fcTc7x0AiEumznHR9M49LywbWlr1ud4laXPIAW2wXngcQTV
	 9XJ/h/g/vnk8x6fhWNMOt9SIGiozE0dY0VpZobDXnBFlnBGQ0stqYK2ITI8gF5vGGu
	 pyaj8eTpxiBmhbZLwe2sQgGDkWOQr5Jx578/Q3iwFb/phYwWmenfU0lF4S9h/P4AJo
	 KfS2tfy2OcdIicku1RBcXuOdxVqtDrtaY5IWrmmR+PS5txWMzfvvDEBylJhYTBZSbX
	 zvPkTs68u+Atw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v4 00/25] fs,kthread: start all kthreads in nullfs
Date: Mon, 01 Jun 2026 15:56:33 +0200
Message-Id: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJGPHWoC/33Oy27CMBAF0F9BXteRHwlOWFWqxAd0W7HwY0JMg
 oPGwS1C+fc66YaqqMt7NXN07yQCeohkt7kThOSjH0MO5cuG2E6HI1DvciaCiS2TTNLPEXvaTx2
 CdjRch6GNtFaVrqVqS97UJH9eEFr/taof5H3/Rg4/ZbyaE9hp8ZYzoyNQgzrYbqnOOk6ARVIFp
 2j5ctH5OI14W9clvnL/DkmcsrwGqqoxTSlV9doDBhiKEY/riCQeke1zRGREO25KA045CX8Q+YB
 w/hyRGZHOCWugEdqxX8g8z98VIn6PegEAAA==
X-Change-ID: 20260303-work-kthread-nullfs-875a837f4198
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=9760; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JtS6J8SxWmAh6kWD5QGWi8fkf/zgSMN2YoENzDzlA1Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i+tsjC7mHT4U7C0U+/6femTum9cTne57XFXlz1E4
 pj89c5jHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5V8fwm21R3g1Z2TdT5dZf
 lw/ILTZw/7dU1uH5YpMAmVOiXhEGCowMG2sa9Mp/CxmXWIS4ruTYMLFScMmS56clbmv2vpvOXTK
 RFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I have not heard any big complaints. So I would like to move this into
-next. But I _do not_ intend to merge anything this cycle. Given that
this is a fundamental change I want this to be in -next for the rest of
this cycle and the whole 7.3 cycle.

Summary:

* all kthreads are isolated in a separate SB_KERNMOUNT of nullfs.
  -> no lookup of anything else, no mounting on top of it, completely
  isolated.
* init has a separate fs_struct from all kthreads
* scoped_with_init_fs() allows a kthread to temporarily assume init's
  fs_struct for filesystem operations.

So this is a bit of a crazy series. When the kernel is started it
roughly goes like this:

init_task
==> create pid 1 (systemd etc.)
==> pid 2 (kthreadd)

After this point all kthreads and PID 1 share the same filesystem state.
That obviously already came up when we discussed pivot_root() as this
allows pivot_root() to rewrite the fs_struct of all kthreads.

This rewriting is really weird and mostly done so kthread can use init's
filesystem state when they would like to. But this really should be
discouraged. The rewriting should also stop completely. I worked a bit
to get rid of it in a more fundamental way. Is it crazy? Yes. Is it
likely broken? Yes. Does it at least boot? Yes.

Instead of sharing fs_struct between kernel threads and pid 1, pid 1
get's a completely separate fs_struct. All kthreads continue sharing
init_fs as before and pid 1's fs_struct is isolated from kthread's
filesystem state. IOW, userspace init cannot affect kthreads filesystem
state anymore and kthreads cannot affect userspace's filesystem state
anymore - without explicit opt-in.

All kthreads are anchored in a kernel internal mount of nullfs that
cannot be mounted on and that cannot be used to follow other mounts.
It's a completely private mount that insulates kthreads.

This series makes performing mountains of filesystem work such as path
lookup and file opening and so on from kthreads hard - painfully so. I
think this is a benefit because it takes the idea of just offloading
_security sensitive_ operations in init's filesystem state and
running random binaries or opening and creating files to kthreads
difficult behind the shed... And imho it should.

The only remaining kernel tasks that actually share init's filesystem
state are usermodhelpers - as they execute random binaries in the root
filesystem. Another concept we should really show the back of the shed.

This gives a lot stronger guarantees than what we have now. This also
makes path lookup from kthreads fail by default. IOW, it won't be
possible anymore to just lookup random stuff in init's filesytem state
without explicitly opting in to that.

The places that need to perform lookup in init's filesystem state may
use scoped_with_init_fs() which will temporarily override the caller's
fs_struct with init's fs_struct.

We now also warn and notice when pid 1 simply stops sharing filesystem
state with us, i.e., abandons it's userspace_init_fs.

On older kernels if PID 1 unshared its filesystem state with us the
kernel simply used the stale fs_struct state implicitly pinning
anything that PID 1 had last used. Even if PID 1 might've moved on to
some completely different fs_struct state and might've even unmounted
the old root.

This has hilarious consequences: Think continuing to dump coredump
state into an implicitly pinned directory somewhere. Calling random
binaries in the old rootfs via usermodehelpers.

Be aggressive about this: We simply reject operating on stale
fs_struct state by reverting userspace_init_fs to nullfs. Every kworker
that does lookups after this point will fail. Every usermodehelper call
will fail. This is a lot stronger but I wouldn't know what it means for
pid 1 to simply stop sharing its fs state with the kernel. Clearly it
wanted to separate so cut all ties.

I've went through the kernel and looked at hopefully everything that
does path lookup from kthreads (workqueues, ...).

TL;DR:

==== PID 1 (systemd) ====

  root@localhost:~# stat --file-system /proc/1/root
    File: "/proc/1/root"
      ID: e3cb00dd533cd3d7 Namelen: 255     Type: ext2/ext3

  root@localhost:~# cat /proc/1/mountinfo | wc -l
  30

==== PID 2 (kthreadd) ====

  root@localhost:~# stat --file-system /proc/2/root
    File: "/proc/2/root"
      ID: 200000000 Namelen: 255     Type: nullfs

  root@localhost:~# cat /proc/2/mountinfo | wc -l
  0

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v4:
- scsi: target: only override current->fs in kthread context for the
  ALUA metadata write. core_alua_write_tpg_metadata() is also reached
  from the configfs alua_access_state and alua_tg_pt_offline store
  handlers in process context, which must resolve against the caller's
  root.
- devtmpfs: drop the kthread_mntns() helper and call
  ksys_unshare(UNSHARE_EMPTY_MNTNS) directly now that empty mount
  namespaces have landed; the unshare path already points the kthread's
  root and pwd at the new namespace.
- Reword the copy_fs() usermodehelper comment ("may copy" rather than
  "may use").
- Rebase onto v7.1-rc1.
- Link to v3: https://patch.msgid.link/20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org

Changes in v3:
- Fix __override_init_fs() to save and return the original fs instead of
  the override, so __revert_init_fs() actually restores the caller's fs.
- Replace smp_store_release() with WRITE_ONCE() in fs override/revert.
- Move userspace_init_fs wiring commit before conversion patches to fix
  bisectability for user-process-context callers.
- Switch all remote procfs accesses (mounts_open_common, get_task_root,
  proc_cwd_link, task_state umask, kcmp) to use task_struct::real_fs
  instead of task_struct::fs.
- Move VFS_WARN_ON_ONCE in copy_fs() into else block so it doesn't fire
  for UMH threads.
- Fix sleeping under task_lock: validate_fs_switch() now runs outside
  task_lock() with might_sleep() annotation.
- Add pnfs/blocklayout scoped_with_init_fs() conversion.
- Wrap security_initramfs_populated() inside scoped_with_init_fs() in
  initramfs unpacking since IPE accesses current->fs->root.
- Fix stale comments: "two mounts" -> "three mounts", UMH comment,
  kthread_mntns() nullfs ambiguity.
- Fix commit message mismatches.
- Link to v2: https://patch.msgid.link/20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org

Changes in v2:
- Remove LOOKUP_IN_INIT in favor of scoped_with_init_fs().
- Link to v1: https://patch.msgid.link/20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org

---
Christian Brauner (25):
      fs: add switch_fs_struct()
      fs: notice when init abandons fs sharing
      fs: add scoped_with_init_fs()
      fs: add real_fs to track task's actual fs_struct
      fs: make userspace_init_fs a dynamically-initialized pointer
      rnbd: use scoped_with_init_fs() for block device open
      crypto: ccp: use scoped_with_init_fs() for SEV file access
      scsi: target: use scoped_with_init_fs() for ALUA metadata
      scsi: target: use scoped_with_init_fs() for APTPL metadata
      btrfs: use scoped_with_init_fs() for update_dev_time()
      coredump: use scoped_with_init_fs() for coredump path resolution
      fs: use scoped_with_init_fs() for kernel_read_file_from_path_initns()
      ksmbd: use scoped_with_init_fs() for share path resolution
      ksmbd: use scoped_with_init_fs() for filesystem info path lookup
      ksmbd: use scoped_with_init_fs() for VFS path operations
      pnfs/blocklayout: use scoped_with_init_fs() for SCSI device lookup
      initramfs: use scoped_with_init_fs() for rootfs unpacking
      af_unix: use scoped_with_init_fs() for coredump socket lookup
      fs: stop sharing fs_struct between init_task and pid 1
      fs: add umh argument to struct kernel_clone_args
      devtmpfs: create private mount namespace
      nullfs: make nullfs multi-instance
      fs: start all kthreads in nullfs
      fs: stop rewriting kthread fs structs
      fs: stop rewriting paths for PF_EXITING | PF_DUMPCORE

 drivers/base/devtmpfs.c           |   2 +-
 drivers/block/rnbd/rnbd-srv.c     |   4 +-
 drivers/crypto/ccp/sev-dev.c      |  12 ++---
 drivers/target/target_core_alua.c |  11 +++-
 drivers/target/target_core_pr.c   |   4 +-
 fs/btrfs/volumes.c                |  11 +++-
 fs/coredump.c                     |  11 ++--
 fs/fs_struct.c                    | 103 ++++++++++++++++++++++++++++++++++++--
 fs/kernel_read_file.c             |   9 +---
 fs/namespace.c                    |  16 +++---
 fs/nfs/blocklayout/dev.c          |  15 ++++--
 fs/nullfs.c                       |  12 ++---
 fs/proc/array.c                   |   4 +-
 fs/proc/base.c                    |   8 +--
 fs/proc_namespace.c               |   4 +-
 fs/smb/server/mgmt/share_config.c |   4 +-
 fs/smb/server/smb2pdu.c           |   4 +-
 fs/smb/server/vfs.c               |  14 ++++--
 include/linux/fs_struct.h         |  34 +++++++++++++
 include/linux/init_task.h         |   1 +
 include/linux/sched.h             |   1 +
 include/linux/sched/task.h        |   1 +
 init/init_task.c                  |   1 +
 init/initramfs.c                  |  14 ++++--
 init/main.c                       |  10 +++-
 kernel/fork.c                     |  53 ++++++++++++--------
 kernel/kcmp.c                     |   2 +-
 kernel/umh.c                      |   6 +--
 net/unix/af_unix.c                |  17 +++----
 29 files changed, 282 insertions(+), 106 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260303-work-kthread-nullfs-875a837f4198

