Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27793E763E;
	Fri, 16 Oct 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146442; cv=none; b=QiNj+8L8PMag2PX0o22xujE7f1JZtxWStnbZTOoH568wj+s8qQ3S2GOq13PNjPXmnUg23sjTbZegnrJSTowcImK/FgEm6YolQUBaVvHxMMjaFp7ySZ9Gu1FfCPuYRkM1mRHdD1Ej8FVol0xRtByX133SzCIMeqxVbaP4tHIMunM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146442; c=relaxed/simple;
	bh=V9oIzwhs7rAkzkOfl1RW5xhbxm2LO8p1xl4+umu+U8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF8JF1ta9/JvLiulo6n4pTr6BtvCFf9uPUrnGRIPs2HtFTB0+znQBXTUy2prz1c+jtBNtjx+aQz0myvck+BKT8+0OjFe/cpXi6ZLhiFNtWRAtbMs5LKbHV5bKJWTTn96F3019N0GcVkGb4feTokq1uPnvAxlgAvrdRN5S6Z354w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deu1aISr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deu1aISr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCEE1F000C4;
	Fri, 16 Oct 2026 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146440;
	bh=ymEOIoIFadkgPAriyyjRP4F+L+5aMBp5wovkzviysgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=deu1aISrktEIy1HH5DoWJT+lejoBB6BfxFWISDb9DOiaK6KwcVkNhWUAFUhAFD9qm
	 x9CWC8cTTfxuuiLqWTDBd4f/Qn/kaqmMNw4hOuVRtMLqBReppN6dKL0d34jJcg8w6K
	 +RPikpAm+6MJd1HVfbfZE7Vg2NMfgG1FVx4g4W8Ze0SuPjaIo7iBEM6fErm0tgDf0P
	 b8KAcfzr+D4w/QgncVuyekoMnS/f5gSBUOrtULgNfhCYum4fYLemyR+B6PBiuHzAgm
	 Ju3QZNhgSbwNtiU2iJC5y4Pl6qQzR5isUqdi2dZzMUu2xI4W64PCdwdKdVer8jEGVC
	 UARMbK0q1inqQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 19/19 for v7.4] vfs sync_close
Date: Fri, 16 Oct 2026 12:27:04 +0200
Message-ID: <20261016-vfs-7.4-rc1.sync_close-2e203cb16139@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10923; i=brauner@kernel.org; h=from:subject:message-id; bh=V9oIzwhs7rAkzkOfl1RW5xhbxm2LO8p1xl4+umu+U8I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/P1nQvCXjAWmE5VnTJ59hW32Z1Hf/4/O1d46c3KSr lxXxsIyp45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJWLMx/BU3F8iZL2BjPVvQ i3sCB9uEntJdr9a59lucuL37tvYS2xJGhif7O961WKb+sFeWk3W+s+1f6f3o5sfsmndP976NmV9 TwA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This makes closing files synchronous for close_range(), exec and exit.
It is based on the vfs-7.4-rc1.close_range tag and contains it.

Since fput() was switched to task work every final __fput() of an
exiting task is queued on task work and run from exit_task_work(). exec
and close_range() do the same. For a task with a large descriptor table
that is a cmpxchg() and a TIF_NOTIFY_RESUME test-and-set per file plus
a list entry for any later task_work_cancel() to search under pi_lock,
and then a second pass over every struct file that isn't cache hot
anymore by then. Oleg and Neil have pointed this out over the years.

close_files(), close_range() and close-on-exec now flush and put each
file inline the way close(2) does. Kernel threads aren't affected. They
share init_files which init_task pins forever so their exit_files()
never drops the last reference, and their fput() keeps punting to a
workqueue. The one place that could put a table from a kthread context,
a failing copy_process(), can't hold the last reference while the
source table is alive.

On a 64 vCPU KVM guest tearing down 4096, 65536 and 1M descriptors
scattered at random positions in the table:

                         4096 fds        65536 fds        1M fds
  exit                   1045 -> 895 us  18.9 -> 14.9 ms  429 -> 306 ms
  execve, close-on-exec  1393 -> 1190 us 21.4 -> 16.9 ms  471 -> 325 ms
  close_range()          1179 -> 988 us  21.9 -> 17.4 ms  484 -> 337 ms

So that is 16-21% or 40-150 ns per closed file, largest at 1M
descriptors. With eight processes tearing down 65536 descriptors each
at once it stays at 16-21% because the second pass over 16 MB of struct
file is what gets expensive when CPUs compete for the cache. With 32 or
64 processes both kernels are bound by pushing millions of files
through slab and rcu and the difference shrinks to 4-8%. Files whose
own release dominates gain less, 13% for eventfds, 11% for pipes, 6%
for AF_UNIX sockets. close(2) is untouched and will-it-scale is within
2%.

The spufs coredump support is removed. It was the only reason
do_coredump() unshared the descriptor table. gdb dropped Cell debugging
in 9.1 and binutils in 2.34, the Cell blades are gone and nothing on
the PlayStation 3 produces or reads these notes. With that
unshare_files() goes away, exec installs its private table through the
new switch_files_struct() and the coredump startup completion becomes a
plain thread count waited on with the new wait_var_event_state().

Three fixes for the synchronous close are included. A failed fork
released its files under scx_fork_rwsem and deadlocked against the bpf
link's release. A session leader's exit released its tty before
disassociate_ctty() ran and the foreground job lost its SIGHUP, so the
tty is hung up before the files are closed now. And descriptor tables
are walked from the highest descriptor down which restores the order
the deferred puts had and keeps a few long-standing release ordering
bugs from deadlocking exit.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This conflicts with the vfs-7.4-rc1.coredump tag in fs/coredump.c
between commit 98a2606e32954 ("coredump: clean up coredump state
handling") from that tag and commits c2fe52e23c12a ("coredump: drop
core_state->dumper") and 3f0993fbe42be ("coredump: stop unsharing the
file descriptor table") from this tag. The coredump tag is merged
before this one.

It also conflicts in kernel/fork.c with commits 9cd0df397a119 ("fs:
pass flags to copy_fs()") and d2bdb9b61b427 ("fs: let idle threads
share init_fs") from the vfs-7.3-rc8.fixes pull request and commit
57088a37b2e4d ("fs: put the old fs_struct before the old namespaces in
unshare()") in mainline on one side and commits 296a98c1fa507 ("fork:
release the files of a failed fork after sched_cancel_fork()") and
31116e528f195 ("fs: add switch_files_struct()") from this tag on the
other:

diff --cc fs/coredump.c
index 8074f81c829c,6f4c6a900dc5..000000000000
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@@ -563,9 -557,9 +564,9 @@@ static void coredump_finish(enum coredu
  	struct task_struct *task;
  
  	spin_lock_irq(&current->sighand->siglock);
 -	if (core_dumped && !__fatal_signal_pending(current))
 +	if ((state & COREDUMP_STATE_STARTED) && !__fatal_signal_pending(current))
  		current->signal->group_exit_code |= 0x80;
- 	next = current->signal->core_state->dumper.next;
+ 	next = current->signal->core_state->tasks;
  	current->signal->core_state = NULL;
  	spin_unlock_irq(&current->sighand->siglock);
  
@@@ -1228,15 -1116,10 +1229,10 @@@ static void do_coredump(struct core_nam
  	}
  
  	/* Don't even generate the coredump. */
 -	if (cn->mask & COREDUMP_REJECT)
 +	if (cprm->mask & COREDUMP_REJECT)
  		return;
  
- 	/* get us an unshared descriptor table; almost always a no-op */
- 	/* The cell spufs coredump code reads the file descriptor tables */
- 	if (unshare_files())
- 		return;
- 
 -	if ((cn->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
 +	if ((cprm->mask & COREDUMP_KERNEL) && !coredump_write(cprm, binfmt))
  		return;
  
  	coredump_sock_shutdown(cprm->file);
diff --cc kernel/fork.c
index ebc39f620701,50f5b3e2ca87..000000000000
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@@ -2304,11 -2301,9 +2307,11 @@@ __latent_entropy struct task_struct *co
  	retval = copy_files(clone_flags, p, args->no_files);
  	if (retval)
  		goto bad_fork_cleanup_semundo;
 -	retval = copy_fs(clone_flags, p, args->umh);
 +	retval = copy_fs(clone_flags, p,
 +			 (args->umh ? COPY_FS_UMH : 0) |
 +			 (args->idle ? COPY_FS_IDLE : 0));
  	if (retval)
- 		goto bad_fork_cleanup_files;
+ 		goto bad_fork_cleanup_semundo;
  	retval = copy_sighand(clone_flags, p);
  	if (retval)
  		goto bad_fork_cleanup_fs;
@@@ -3339,10 -3305,11 +3324,8 @@@ int ksys_unshare(unsigned long unshare_
  			new_nsproxy = NULL;
  		}
  
- 		if (new_fd) {
- 			guard(task_lock)(current);
- 			swap(current->files, new_fd);
- 		}
 -		if (new_fs)
 -			new_fs = switch_fs_struct(new_fs);
 -
+ 		if (new_fd)
+ 			switch_files_struct(current, no_free_ptr(new_fd));
  
  		if (new_cred) {
  			/* Install the new user namespace */

Merge conflicts with other trees
================================

This conflicts with the kapi tree in fs/open.c between commit
856d40153ab75 ("kernel/api: add API specification for sys_close") from
the kapi tree and commit 2b256ebe82872 ("fs: add filp_close_sync()")
from this tree. Both add something right below filp_close(). The
resolution keeps filp_close_sync() first and the new kernel-doc block
for sys_close() after it. The kapi side is a 250 line comment so no
diff here.

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.sync_close

for you to fetch changes up to 02de8d0c3512108620cae8db0c71fe227f1da5bd:

  Merge patch series "files: fixes for synchronous close_range(), exec, exit" (2026-10-05 13:11:51 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.sync_close

Please consider pulling these changes from the signed vfs-7.4-rc1.sync_close tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (32):
      file: let dup_fd() leave the punched hole behind
      selftests/core: test the hole CLOSE_RANGE_UNSHARE leaves behind
      file: rename dup_fd()'s punch_hole to range
      file: let dup_fd() drop everything outside of the range
      close_range: turn the flags into an enum
      file: add CLOSE_RANGE_EXCEPT
      selftests/core: test CLOSE_RANGE_EXCEPT
      file: let dup_fd() drop only close-on-exec descriptors
      file: add CLOSE_RANGE_CLOEXEC_ONLY
      selftests/core: test CLOSE_RANGE_CLOEXEC_ONLY
      Merge patch series "files,close_range: add CLOSE_RANGE_{CLOEXEC_ONLY,EXCEPT}"
      powerpc: remove coredump support
      fs: don't open-code file_close_fd() in close_fd()
      coredump: stop unsharing the file descriptor table
      fs: add switch_files_struct()
      Merge patch series "powerpc: remove spufs coredump support"
      fs: move unshare_fd() to fs/file.c
      fs: remove unshare_files()
      fs: add filp_close_sync()
      fs: make close_files() synchronous
      fs: make close_range() synchronous
      fs: rename do_close_on_exec() to close_cloexec_files()
      fs: make close_cloexec_files() synchronous
      coredump: drop core_state->dumper
      sched: add wait_var_event_state()
      coredump: replace the startup completion with a thread count
      fork: release the files of a failed fork after sched_cancel_fork()
      exit: hang up the tty before closing the files
      coredump: factor out coredump_wait_inactive()
      fs: close files from the highest descriptor down
      Merge patch series "files: make closing files synchronous for close_range(), exec, exit"
      Merge patch series "files: fixes for synchronous close_range(), exec, exit"

 arch/powerpc/Kconfig                            |   1 -
 arch/powerpc/include/asm/elf.h                  |   6 -
 arch/powerpc/include/asm/spu.h                  |   3 -
 arch/powerpc/platforms/cell/Kconfig             |   1 -
 arch/powerpc/platforms/cell/spu_syscalls.c      |  20 -
 arch/powerpc/platforms/cell/spufs/Makefile      |   1 -
 arch/powerpc/platforms/cell/spufs/coredump.c    | 183 -----
 arch/powerpc/platforms/cell/spufs/file.c        | 114 ---
 arch/powerpc/platforms/cell/spufs/spufs.h       |  12 -
 arch/powerpc/platforms/cell/spufs/syscalls.c    |   4 -
 fs/binfmt_elf.c                                 |   6 +-
 fs/binfmt_elf_fdpic.c                           |   2 +-
 fs/coredump.c                                   |  48 +-
 fs/exec.c                                       |  13 +-
 fs/file.c                                       | 309 ++++++--
 fs/internal.h                                   |   1 +
 fs/open.c                                       |  17 +-
 include/linux/fdtable.h                         |  14 +-
 include/linux/sched/signal.h                    |   6 +-
 include/linux/wait_bit.h                        |  26 +
 include/uapi/linux/close_range.h                |  31 +-
 kernel/exit.c                                   |  15 +-
 kernel/fork.c                                   |  57 +-
 tools/testing/selftests/core/close_range_test.c | 951 ++++++++++++++++++++++++
 24 files changed, 1313 insertions(+), 528 deletions(-)
 delete mode 100644 arch/powerpc/platforms/cell/spufs/coredump.c
